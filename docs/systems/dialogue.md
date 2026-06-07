# Dialogue System

This document describes the planned architecture for NPC dialogue, quest
conversation flow, NPC services, short recognition comments, and dialogue-driven
world interactions.

## Decision

The game should use a server-authoritative, data-driven dialogue system.

Dialogues should feel RPG-like: NPCs can have branching conversations,
conditional responses, and meaningful player choices. At the same time, NPC
scripts should not contain business logic. Dialogue definitions describe what
the conversation wants to show or request, while server services decide whether
an option is valid and whether an action is allowed.

The first implementation should focus on:

- one dynamic conversation hub per NPC,
- topic options generated from quests, generic dialogue, trade, and services,
- node-based dialogue after the player selects a topic,
- conditional options based on current player state,
- safe server-side actions for the small number of cases where dialogue changes
  the world,
- camera and movement control during important conversations.

## Core Principle

Dialogue is presentation and intent. Gameplay authority stays in services.

An NPC can say different lines, show different topics, and offer different
choices based on the player. It should not directly grant rewards, remove
items, open gates, complete quests, or mutate world state. Those mutations must
go through server-owned services such as `QuestService`, `InventoryService`,
or a future world interaction service.

Good dialogue data says:

```lua
Actions = {
	{ Type = "OpenWorldObject", ObjectId = "OldSawmillGate" },
}
```

Bad dialogue data runs arbitrary world logic:

```lua
Action = function(player)
	workspace.OldSawmillGate:Destroy()
end
```

Dialogue actions should be whitelisted, validated, and executed by the server.

## NPC Conversation Hub

Each NPC should have one dynamic conversation hub.

When the player interacts with an NPC, the first dialogue screen is built from
available topics. A topic is an entry point into a conversation, not the whole
conversation.

Examples:

- a quest offer,
- a quest turn-in,
- a generic greeting,
- a trade option,
- a crafting or training service,
- a short hint.

If an NPC has one available quest, the hub shows one quest topic. If the NPC has
two available quests, the hub shows two quest topics. Generic topics can appear
alongside quest topics.

Example hub:

```text
Mentor

? I have a first job for you.
? The blacksmith asked you to speak with him.
speech Hello. What's going on?
back See you later.
```

The visible UI should use icon assets, not text tags like `[Quest]` or `[Trade]`.
The topic text should remain diegetic.

## Topic Model

A topic describes a start option shown in the conversation hub.

Example topic shape:

```lua
{
	TopicId = "StarterSupplyRunOffer",
	Type = "QuestOffer",
	IconType = "QuestAvailable",
	Label = "I have a first job for you.",
	Priority = 100,
	StartNodeId = "OfferStarterSupplyRun",
	QuestId = "StarterSupplyRun",
}
```

`Type` describes the gameplay category. `IconType` describes the UI icon.

Expected icon types:

| IconType | Meaning |
| --- | --- |
| `QuestAvailable` | A quest can be accepted |
| `QuestInProgress` | A quest conversation can continue |
| `QuestTurnIn` | A quest objective can be turned in |
| `Trade` | The NPC can trade |
| `Service` | The NPC offers a service |
| `Training` | The NPC can teach or explain a skill |
| `Crafting` | The NPC opens or explains crafting |
| `Generic` | Small talk, hint, or flavor dialogue |
| `Close` | Leave the conversation |

The exact icons can change during UI work. The important decision is that topic
type is communicated visually, while the text remains in-world.

## Topic Sources

The dialogue hub should be assembled from multiple systems.

Example server flow:

```lua
QuestService:GetAvailableDialogueTopics(player, npcId)
DialogueService:GetGenericTopics(player, npcId)
NpcService:GetAvailableServiceTopics(player, npcId)
TradeService:GetAvailableTradeTopics(player, npcId)
```

The dialogue system sorts all topics by priority and returns only the topics the
player can currently use.

Unavailable topics should usually be hidden in the MVP. If the player needs a
hint, use a generic topic or dialogue node that explains what is missing.
Disabled but visible options can be considered later for important NPCs.

## Dialogue Nodes

After a player selects a topic, the conversation enters a node-based dialogue.

Example definition shape:

```lua
return {
	DialogueId = "MentorDialogue",
	NpcId = "Mentor",

	Topics = {
		{
			TopicId = "SmallTalk",
			Type = "Generic",
			IconType = "Generic",
			Label = "Hello. What's going on?",
			Priority = 10,
			StartNodeId = "SmallTalkBusy",
		},
	},

	Nodes = {
		SmallTalkBusy = {
			Text = "I don't feel like talking right now. Come back later.",
			Options = {
				{
					Text = "Sure.",
					Actions = {
						{ Type = "Close" },
					},
				},
			},
		},
	},
}
```

Nodes should be short. Most NPC lines should be one to three sentences. The
first 30 minutes of the game should avoid long exposition.

## Player Options

Player response text can vary by context.

Important RPG scenes can use fuller spoken responses:

```text
"I will do it, but first tell me why the sawmill is locked."
```

Repeatable or functional interactions can use shorter intent labels:

```text
"Trade"
"Turn in the parcel"
"Ask about work"
"Leave"
```

The system should support both styles. Dialogue authors should choose the style
that best fits the moment.

## Conditions

Dialogue topics and options can have conditions.

Conditions should check current player state or simple saved flags. They should
not perform mutations.

Expected condition types:

| Condition | Meaning |
| --- | --- |
| `HasItem` | Player has an item in the custom inventory |
| `MissingItem` | Player does not have an item |
| `QuestAvailable` | Player can start a quest |
| `QuestActive` | Player has a quest active |
| `QuestStepActive` | Player is on a specific quest step |
| `QuestCompleted` | Player completed a quest |
| `SkillAtLeast` | Player has a skill level |
| `DialogueFlagSet` | Player or NPC dialogue flag is set |
| `WorldFlagSet` | A world or settlement flag is set |
| `NpcServiceUnlocked` | A service is available from this NPC |

Example:

```lua
{
	Text = "I have a hammer with me.",
	Conditions = {
		{ Type = "HasItem", ItemId = "BasicHammer", Amount = 1 },
	},
	NextNodeId = "HammerResponse",
}
```

Condition checks should be server-side. The client can display the resulting
options but should not decide which options are valid.

## Actions

Some dialogue choices can change the world, but only through a safe server-side
action catalog.

Expected action types:

| Action | Meaning |
| --- | --- |
| `Close` | End the conversation |
| `GoToNode` | Move to another dialogue node |
| `StartQuest` | Ask `QuestService` to start a quest |
| `AdvanceQuestFromNpc` | Ask `QuestService` to advance an NPC objective |
| `GiveItem` | Ask `InventoryService` to add an item |
| `RemoveItem` | Ask `InventoryService` to remove an item after validation |
| `SetDialogueFlag` | Save a small dialogue flag |
| `SetWorldFlag` | Set an approved world or settlement flag |
| `OpenWorldObject` | Open or activate a whitelisted world object |
| `RevealMapMarker` | Reveal a location marker |
| `UnlockNpcService` | Unlock a service for this NPC |
| `OpenTrade` | Open trade UI |
| `OpenCrafting` | Open crafting UI |
| `OpenTraining` | Open training or skill explanation UI |

Actions should run on the server. The server should re-check conditions before
executing any action, because the client request cannot be trusted.

## Dialogue Memory

The MVP should support simple saved dialogue flags, but not full NPC
relationship simulation.

Good early flags:

- player talked to this NPC for the first time,
- player chose an important path,
- a tutorial hint was already shown,
- a service was unlocked,
- a one-time dialogue reward was claimed.

The system should be designed so more personal NPC memory can be added later,
but it should not be implemented first.

Later possible memory:

- the player was rude,
- the player often helps this NPC,
- the NPC trusts or dislikes the player,
- the NPC changes tone based on a relationship score.

For now, dialogue should mostly react to current state: inventory, quest state,
skills, settlement state, and unlocked services.

## Quest Integration

Dialogue should be separate from quest logic.

The quest system decides whether a quest can be offered, continued, or turned
in. The dialogue system decides how that appears as topics and node text.

Examples:

- `QuestService` reports that `StarterSupplyRun` is available from `Mentor`.
- `DialogueService` adds a `QuestAvailable` topic with a question mark icon.
- The player selects the topic.
- The node shows the mentor's offer text.
- The player chooses an accept option.
- The server calls `QuestService:StartQuest(player, "StarterSupplyRun")`.

Quest definitions should not need bespoke NPC scripts for each branch.

## Interaction Flow

Expected flow:

1. Player interacts with an NPC through click, proximity prompt, or another
   interaction input.
2. Client sends `NpcInteractRequest(npcId)`.
3. Server validates that the NPC exists and the player is close enough.
4. Server builds the conversation hub topics.
5. Client enters dialogue mode and displays the hub.
6. Player selects a topic.
7. Client sends the selected `TopicId`.
8. Server validates the topic and returns the first node.
9. Player selects node options.
10. Server validates conditions, executes allowed actions, and returns the next
    node or closes the conversation.

The client owns presentation. The server owns truth.

## Camera And Controls

Dialogue should normally lock player movement and camera control.

When a conversation starts, the client should enter dialogue mode:

- disable normal movement input,
- disable normal camera control,
- hide or reduce unrelated HUD elements,
- focus UI on the NPC conversation,
- close the dialogue automatically if the server ends the session or the player
  becomes invalid.

The system should support NPC-specific camera framing. Different NPCs may stand
in different environments, so a single global camera angle will not always work.

NPC config can define dialogue camera hints:

```lua
DialogueCamera = {
	Mode = "TwoShot",
	Offset = Vector3.new(0, 3, 8),
	LookAtOffset = Vector3.new(0, 2, 0),
	FieldOfView = 45,
}
```

Later, important story scenes can use more authored camera data:

```lua
DialogueCamera = {
	Mode = "Custom",
	CameraPartName = "MentorDialogueCamera",
	LookAtPartName = "MentorDialogueLookAt",
	FieldOfView = 40,
}
```

The MVP should support a simple default camera plus optional NPC overrides.
Fully cinematic camera sequencing can wait.

## UI Notes

The dialogue UI should be readable, fast, and diegetic enough to feel like a
conversation rather than an admin menu.

Guidelines:

- show NPC name,
- show NPC line,
- show player options as selectable rows or buttons,
- use icons for topic types,
- avoid text tags such as `[Quest]`,
- keep options short enough to scan,
- allow fuller RPG responses when the scene deserves it,
- provide an obvious close option,
- avoid long walls of text,
- make quest/service icons readable at small sizes.

Dialogue options should be controllable with all supported Roblox input methods:

- mouse,
- keyboard,
- gamepad,
- touch screen.

The same dialogue should not require separate content or different option
layouts per input method. The client UI should adapt selection, focus,
highlight, and activation behavior to the current device.

## Networking

Potential remotes:

```text
ReplicatedStorage.Remotes.Dialogue
    NpcInteractRequest
    DialogueSelectTopicRequest
    DialogueSelectOptionRequest
    DialogueClosed
    DialogueStateUpdated
```

The exact remote names can change during implementation. The important rule is
that clients request dialogue actions and the server returns validated dialogue
state.

## Data Location

Dialogue definitions should live in ModuleScripts and stay close to shared game
data.

Possible layout:

```text
ReplicatedStorage.Shared.Dialogue.Definitions
    MentorDialogue
    CarpenterDialogue
    MasonDialogue

ReplicatedStorage.Shared.Npcs
    MentorConfig
    CarpenterConfig
```

Server-only custom handlers, if ever needed, should live under server scripts
and should be rare.

## MVP Scope

The first implementation should include:

- `DialogueRegistry` for loading dialogue definitions,
- server-side `DialogueService`,
- one dynamic conversation hub per NPC,
- static generic topics from dialogue definitions,
- quest topics generated from `QuestService`,
- node text and player options,
- condition checks for inventory and quest state,
- actions for close, go to node, start quest, and advance quest from NPC,
- simple dialogue flags,
- one default dialogue camera mode,
- optional NPC camera override,
- movement and camera lock while dialogue is open,
- one mentor dialogue and one carpenter dialogue for the starter chain.

The first version does not need:

- voice acting,
- relationship scores,
- remembered rude choices,
- cinematic multi-camera sequences,
- localization tooling,
- branching consequences beyond approved server actions,
- disabled but visible unavailable options.

## Acceptance Criteria

- A player can interact with an NPC and see a conversation hub.
- The hub shows one quest topic when one quest is available.
- The hub shows two quest topics when two quests are available.
- The hub can show generic non-quest topics at the same time.
- Topic types are shown with icons, not text tags.
- Selecting a topic opens the correct dialogue node.
- Dialogue options can move to another node.
- Dialogue options can be hidden based on inventory state.
- Dialogue options can be hidden based on quest state.
- Starting a quest from dialogue goes through `QuestService`.
- Advancing or turning in a quest goes through `QuestService`.
- Item rewards or removals go through `InventoryService`.
- Dialogue actions are whitelisted and validated on the server.
- The client cannot execute arbitrary dialogue actions.
- Movement and normal camera control are locked while dialogue is open.
- An NPC can define a custom dialogue camera framing.
- Closing dialogue restores normal controls and camera.
- Dialogue options can be selected with mouse, keyboard, gamepad, and touch
  input.

## Design Notes

- Dialogue should create the feeling of NPC relationships without requiring a
  bespoke script for every branch.
- Most NPC interactions should be short.
- Important story or specialization moments can use fuller RPG responses.
- Functional options such as trade, crafting, training, and turn-ins can use
  short intent labels.
- Dialogue should react to the current player state before it tries to remember
  personality details.
- Personal NPC memory should be added only when the game has enough content for
  it to matter.

## Open Questions

- Should dialogue sessions time out if the player is idle?
- Should another player be able to interrupt an NPC while one player is talking
  to them?
- Should party or settlement dialogue exist, where one player's choice affects
  a shared settlement state?
- Should important dialogue choices be confirmed before executing world-changing
  actions?
- Should unavailable important topics ever be shown as disabled hint options?
- How should dialogue camera behave for very large NPCs or NPCs behind counters?
