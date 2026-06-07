# Quest System

This document describes the planned quest architecture for NPC-driven tasks,
delivery chains, gathering objectives, combat objectives, exploration
objectives, and tutorial progression.

## Decision

The game should use a server-authoritative, data-driven quest system.

NPCs should not contain quest business logic. An NPC can offer dialogue, show
available quests, and act as a turn-in target, but quest state, validation,
rewards, and progression should live in server-side services and shared quest
definitions.

This keeps quests flexible for:

- taking a quest from one NPC and finishing it at another NPC,
- giving or removing quest items,
- chaining several NPC interactions,
- mixing delivery, gathering, combat, crafting, and exploration objectives,
- reusing the same objective types across many quests,
- saving player progress,
- adding onboarding quests without creating a separate tutorial system.

## Core Principle

Quests are state machines built from reusable objective types.

A quest definition describes the steps. The player's quest log stores only
their progress through those steps.

Example definition shape:

```lua
return {
	QuestId = "StarterSupplyRun",
	DisplayName = "Supply Run",
	StartNpcId = "Mentor",
	Repeatable = false,
	Requirements = {
		MinPlayerLevel = 1,
		CompletedQuests = { "StarterWelcome" },
	},
	Steps = {
		{
			StepId = "ReceiveParcel",
			Type = "TalkToNpc",
			NpcId = "Mentor",
			Rewards = {
				{ Type = "Item", ItemId = "SealedParcel", Amount = 1 },
			},
			NextStepId = "DeliverParcel",
		},
		{
			StepId = "DeliverParcel",
			Type = "DeliverItem",
			NpcId = "Carpenter",
			ItemId = "SealedParcel",
			Amount = 1,
			Rewards = {
				{ Type = "Item", ItemId = "CarpenterToken", Amount = 1 },
			},
			NextStepId = "CutWood",
		},
		{
			StepId = "CutWood",
			Type = "Gather",
			ResourceId = "Tree",
			Amount = 3,
			NextStepId = "ReturnToCarpenter",
		},
		{
			StepId = "ReturnToCarpenter",
			Type = "TalkToNpc",
			NpcId = "Carpenter",
			Rewards = {
				{ Type = "Item", ItemId = "StarterPlanks", Amount = 4 },
				{ Type = "SkillXp", SkillId = "Logging", Amount = 20 },
			},
			CompletesQuest = true,
		},
	},
}
```

The exact Lua structure can change during implementation. The important design
decision is that each quest is data first, while the server owns all mutations.

## Quest State

Each player should have a quest log stored on the server.

Example runtime state:

```lua
{
	Active = {
		StarterSupplyRun = {
			QuestId = "StarterSupplyRun",
			CurrentStepId = "CutWood",
			StepProgress = {
				CutWood = {
					Amount = 2,
				},
			},
		},
	},
	Completed = {
		StarterWelcome = true,
	},
	Repeatable = {
		DailyWoodOrder = {
			LastCompletedAt = 1780843200,
			NextAvailableAt = 1780886400,
			Completions = 3,
		},
	},
}
```

Only the server can start quests, advance steps, grant rewards, remove delivery
items, or mark quests complete.

Clients can ask to interact with an NPC or open quest UI, but the server decides
what is available and valid.

## Suggested Objective Types

MVP objective types:

| Type | Meaning |
| --- | --- |
| `TalkToNpc` | Player must talk to a specific NPC |
| `DeliverItem` | Player must give one or more items to a specific NPC or object |
| `Gather` | Player must gather from a resource type, such as trees or stone |
| `CraftItem` | Player must craft a specific item |
| `VisitLocation` | Player must enter a marked area |
| `KillEnemy` | Player must defeat enemies of a specific type |

Later objective types:

| Type | Meaning |
| --- | --- |
| `ContributeToProject` | Player contributes materials or actions to a shared settlement project |
| `TradeWithPlayer` | Player buys or sells through another player's marketplace |
| `PlaceBuilding` | Player places or upgrades a specific building |
| `UseMachine` | Player uses a workbench, sawmill, forge, or similar station |
| `ReachSkillLevel` | Player reaches a skill threshold |

Objective types should be small and reusable. A complex quest is just a sequence
of simple objectives.

## NPC Role

Each NPC should have a stable `NpcId`.

NPCs can provide:

- dialogue lines,
- quest offers,
- quest turn-ins,
- recognition comments,
- hints about skills or production chains.

NPCs should not directly grant rewards or mutate inventory. They should call a
server API such as:

```lua
QuestService:GetAvailableNpcQuests(player, "Mentor")
QuestService:StartQuest(player, "StarterSupplyRun")
QuestService:TryAdvanceFromNpc(player, "Carpenter")
```

This allows one NPC to participate in many quests and one quest to involve many
NPCs.

## Inventory Integration

Quest items should use the same custom inventory system described in
[Inventory System](inventory.md).

Rules:

- quest rewards use `InventoryService:AddItem`,
- delivery objectives use `InventoryService:HasItem` and
  `InventoryService:RemoveItem`,
- quest-only items can be marked in item config as non-tradable if needed,
- unique quest items should use `UniqueId` only when the exact item instance
  matters,
- the Roblox `Backpack` should not be used as quest storage.

Example quest item config:

```lua
return {
	ItemId = "SealedParcel",
	DisplayName = "Sealed Parcel",
	Stackable = false,
	MaxStack = 1,
	Rarity = "Common",
	QuestItem = true,
	Tradable = false,
}
```

## Event Integration

Quest progress should be advanced by gameplay events emitted by other systems.

Examples:

```lua
QuestService:OnResourceGathered(player, {
	ResourceId = "Tree",
	Amount = 1,
})

QuestService:OnEnemyKilled(player, {
	EnemyId = "ForestWolf",
	Amount = 1,
})

QuestService:OnLocationVisited(player, {
	LocationId = "OldSawmill",
})

QuestService:OnItemCrafted(player, {
	ItemId = "BasicPickaxe",
	Amount = 1,
})
```

Other systems should not know quest internals. They only emit facts about what
the player did.

## Suggested Roblox Structure

```text
ReplicatedStorage
  Modules
    QuestRegistry

  Config
    Quests
      StarterWelcome
      StarterSupplyRun
      RepairTheSawmill

  Remotes
    QuestLogUpdated
    StartQuestRequest
    NpcInteractRequest

ServerScriptService
  Services
    QuestService
    DialogueService

  QuestRules
    DailyWoodOrderRules
    SpecialistFavorRules

  QuestServer
```

`QuestRegistry` can expose public quest data needed for UI, such as display
names, descriptions, and visible objective text.

Server-only reward values, hidden prerequisites, or anti-exploit validation can
live under `ServerScriptService` or `ServerStorage` if they should not be
visible to clients.

## Quest Availability

Quest availability should be validated on the server.

Common requirements:

- player has a required account, character, or profession level,
- player has completed another quest,
- player has not completed a mutually exclusive quest,
- player has not already completed this quest,
- player is on a specific onboarding milestone,
- player has a required skill level,
- player owns or does not own a specific item,
- player is near the required NPC,
- player has unlocked a settlement or building.

Example:

```lua
Requirements = {
	MinPlayerLevel = 13,
	CompletedQuests = { "StarterWelcome" },
	MinSkills = {
		Logging = 1,
	},
	UnlockedBuildings = { "LumberjackHut" },
}
```

The client can display available quests, but it should not decide that a quest
can start.

## Repeatable Quests

Some quests should be repeatable with a cooldown.

Examples:

- a lumber order that can be completed every 12 hours,
- a town board contract that resets every 24 hours,
- a rare specialist request that returns every 3 days,
- a weekly reputation quest with a larger reward.

Repeatable quests should use the same objective system as normal quests. The
difference is availability and saved completion history.

Example:

```lua
Repeatable = true,
CooldownSeconds = 12 * 60 * 60,
MaxActiveCompletions = 1,
```

Saved quest state should store at least:

- last completion time,
- next available time,
- total completion count,
- current active progress if the quest is accepted but unfinished.

The server should check cooldowns before showing the quest as available and
again before accepting it. Client-side timers are only presentation.

For long cooldowns, such as 3 days, save absolute timestamps rather than trying
to count playtime.

## Conditional Rewards

Quest rewards should support both base rewards and extra conditional rewards.

This lets one quest feel different for different players without duplicating the
whole quest definition.

Examples:

- players with Logging level 10 receive extra rare wood,
- players completing a quest for the first time receive a unique title,
- players who helped repair the shared sawmill receive bonus settlement tokens,
- players from a specific starter path receive a different tool skin,
- players who finish a repeatable quest for the 10th time receive a reputation
  bonus.

Example:

```lua
Rewards = {
	{ Type = "Item", ItemId = "Wood", Amount = 20 },
	{ Type = "SkillXp", SkillId = "Logging", Amount = 40 },
},

BonusRewards = {
	{
		Requirements = {
			MinSkills = {
				Logging = 10,
			},
		},
		Rewards = {
			{ Type = "Item", ItemId = "FineResin", Amount = 1 },
		},
	},
	{
		Requirements = {
			FirstCompletion = true,
		},
		Rewards = {
			{ Type = "Title", TitleId = "HelpfulSettler" },
		},
	},
}
```

The server should evaluate bonus rewards at completion time. The client can
preview visible bonus rewards, but hidden or surprise rewards should stay
server-only.

## Custom Quest Logic

Most quests should be pure data. Custom scripts should exist for unusual logic,
not for routine objectives.

Good uses for custom quest logic:

- a quest whose requirements depend on several systems at once,
- dynamic reward selection based on player history,
- a branching quest that chooses the next step from player behavior,
- special validation that cannot be expressed with standard requirements,
- one-off story events in the world.

Bad uses for custom quest logic:

- checking a normal level requirement,
- checking whether another quest is complete,
- granting common item or XP rewards,
- counting ordinary gathered resources,
- creating a separate implementation for every NPC request.

Recommended shape:

```text
ServerScriptService
  QuestRules
    StarterSupplyRunRules
    DailyWoodOrderRules
    SpecialistFavorRules
```

Quest definitions can reference a rule module by id:

```lua
RuleModule = "SpecialistFavorRules",
```

Suggested optional rule API:

```lua
return {
	CanStart = function(player, questDefinition, questState)
		return true
	end,

	SelectNextStep = function(player, questDefinition, questState)
		return nil
	end,

	GetBonusRewards = function(player, questDefinition, questState)
		return {}
	end,

	OnCompleted = function(player, questDefinition, questState)
	end,
}
```

Each function should be optional. If a quest has no custom rule module, the
standard quest engine handles it completely.

Custom rule modules should be server-only unless their data is safe for clients
to inspect.

## Dialogue And Quest Flow

Dialogue should be separate from quest logic.

A dialogue node can ask the quest system what options are available and then
show buttons such as:

- accept quest,
- continue quest,
- turn in item,
- ask for hint,
- close dialogue.

This avoids hardcoding quest branches inside NPC scripts. It also lets a single
NPC say different short lines based on quest state.

## Example Chain

Starter NPC chain:

1. Mentor gives the player a sealed parcel.
2. Player delivers the parcel to Carpenter.
3. Carpenter removes the parcel and gives a wood token.
4. Carpenter asks the player to cut 3 starter trees.
5. QuestService listens to tree gathering events and updates progress.
6. Player returns to Carpenter.
7. Carpenter gives planks and Logging XP.
8. Carpenter sends the player to Mason.
9. Mason asks the player to visit the stone yard.
10. Visiting the area advances the quest and unlocks the next onboarding step.

This creates the feeling of NPC relationships without requiring a bespoke script
for each branch.

## MVP Scope

The first implementation should include:

- `QuestRegistry` for loading quest definitions,
- server-side `QuestService`,
- in-memory quest log per player,
- quest start requirements for player level and completed quests,
- repeatable quest cooldown tracking,
- `TalkToNpc`, `DeliverItem`, `Gather`, and `VisitLocation` objective types,
- simple NPC interaction remote,
- quest log update remote,
- inventory integration for quest rewards and turn-ins,
- one starter quest chain in the shared settlement.

DataStore saving can be added after the basic quest loop is reliable.

## Acceptance Criteria

- A player can accept a quest from an NPC.
- The quest appears in the player's quest log.
- The server can give a quest item as a reward.
- The player can deliver that item to a different NPC.
- The server removes the delivered item only after validation.
- Gathering progress can advance a quest without NPC-specific scripts.
- Visiting a marked area can advance a quest.
- Completing a quest grants rewards once and only once.
- A non-repeatable quest cannot be accepted again after completion.
- A repeatable quest cannot be accepted again before its cooldown expires.
- Quest requirements are checked by the server before a quest starts.
- Bonus rewards are granted only when their requirements are met.
- A client cannot grant itself quest progress or rewards through remote calls.

## Design Notes

- Quest chains should be short in the first 30 minutes.
- NPC recognition should be frequent but brief.
- Quest rewards should teach production chains, not replace them.
- Quest items should rarely block inventory space for long periods.
- Job board tasks can reuse the same objective system with shorter definitions.
- Onboarding milestones and quests may eventually merge into one progression
  service, but they should start simple.
- Custom rule modules should be rare, small, and server-only by default.

## Open Questions

- Should the player be allowed to abandon quests?
- Should abandoned quests return consumed quest items?
- Can multiple quests track the same action at the same time?
- Are quest items visible in the normal inventory, or in a separate quest tab?
- Should quest chains be strictly linear, or can the player hold several active
  branches from different NPCs?
- Should party or shared settlement quests exist before the player owns a
  settlement?
- Should repeatable quest cooldowns count real time or only online playtime?
- Should players see all bonus reward requirements, or should some stay hidden?
- Should custom quest rules be allowed to change dialogue, or only validation
  and rewards?
