# First 30 Minutes: Shared Settlement Without Grind

The first 30 minutes should make the player feel useful, recognized, and ready
to found their own settlement. This phase is a light social onboarding space,
not forced co-op and not the start of the long grind.

The player completes short personal goals beside other players. The shared
settlement reacts to everyone's activity, but each player keeps guaranteed
individual progress even on an empty server.

## Design Goals

- give the first visible reward within 60 seconds,
- create a reward moment every 1-3 minutes,
- make the world visibly change as the player contributes,
- introduce future specializations without locking the player in,
- give the player planks before they found their own settlement,
- unlock the player's own settlement through a milestone ritual around 20-30
  minutes,
- avoid high material counts and repeated identical actions longer than 2-3
  minutes.

## Shared Settlement Contents

The starter settlement should contain:

| Object | Role |
| --- | --- |
| Mentor NPC | Gives the first tool, short tasks, recognition, and the founding rite |
| Starter forest | Provides the first satisfying gathering actions |
| Shared sawmill | Converts shared activity into individual plank rewards |
| Job board | Shows short local tasks and community contribution progress |
| Settlement worksite | Gives visible construction and repair milestones |
| Craft NPCs | Preview Logging, Mining, Carpentry, Farming, and Trading paths |

The settlement is social because players see other players working, shared
project bars moving, and the sawmill cycling. It is not mandatory co-op: solo
players can complete every step through personal milestone thresholds.

## First 30-Minute Flow

| Time | Step | Player objective | Reward |
| --- | --- | --- | --- |
| 0-3 min | Arrival | Meet the mentor, receive the starter tool, complete one immediate task | Logging 1, a small settler title, starter wood |
| 3-7 min | Satisfying Gathering | Cut starter trees with clear feedback and contribution tracking | Wooden log craft unlock, bonus bundles |
| 7-11 min | First Visible Contribution | Deliver materials to repair the sawmill, bridge, or workbench | Material crate, short production buff, NPC recognition |
| 11-15 min | Skill Sampler | Try Logging, Mining, and Carpentry in any order | Micro-unlocks and clear hints about future roles |
| 15-20 min | Shared Sawmill Moment | Help trigger a sawmill cycle through personal or shared contribution | Individual plank bundle for each participant |
| 20-25 min | Personal Intent Choice | Choose a starter settlement style | Starter kit and first building blueprint |
| 25-30 min | Founding Rite | Prepare a settlement sign, starter chest, or foundation | Own settlement, first placeable building, saved NPC comment |

## Dopamine Mechanics

Early dopamine should come from frequent small wins rather than inflated
resource totals.

- Bonus bundles can drop every few gathering actions. Examples: extra wood,
  resin, wild fruit, settlement tokens.
- Shared project bars should often be close to completion, but personal rewards
  must not depend on another player finishing the last input.
- NPC recognition should be short and frequent. The player should hear that the
  sawmill works better, the workbench is fixed, or the settlement is ready
  because of their contribution.
- The first processed product should arrive quickly. Planks should be awarded
  before the player starts their own settlement.
- Starter path choice should feel expressive, not permanent. It should decide a
  starter kit and first blueprint, not a hard specialization.

## Starter Paths

The mentor offers the player a soft intent choice before the founding rite.
This should guide the first private settlement without closing off other paths.

| Starter path | Starter kit | First blueprint | Promise |
| --- | --- | --- | --- |
| Woodworker | Planks and extra wood | Lumberjack hut | Faster access to wood processing |
| Stoneworker | Stone and simple blocks | Stone yard or stone furnace path | Faster access to construction and mining |
| Farmer / Forager | Wild grain, fruit, and fiber | Garden patch or food prep station | Early stamina and comfort loop |
| Trader-helper | Crates and settlement tokens | Small trade stall or storage crate | Early logistics and selling hint |

## Gameplay-Facing Concepts

These concepts should stay data-driven when implemented in Rojo-owned code.

| Concept | Meaning |
| --- | --- |
| `OnboardingMilestone` | A personal onboarding step with objective, reward, and optional world reaction |
| `SharedSettlementContribution` | A contribution to a shared settlement project with personal credit |
| `StarterPath` | A reversible early intent choice that grants a starter kit and blueprint |
| `FoundingRite` | The final milestone that unlocks the player's own settlement |
| `StarterRewardBundle` | A small reward package used to keep the first 30 minutes moving |

No public runtime API is required yet. These names define the vocabulary for the
future implementation.

## Acceptance Criteria

- A new player reaches the first reward within 60 seconds.
- The first 10 minutes contain at least 4 reward moments.
- The player can unlock their own settlement between 20 and 30 minutes in normal
  play.
- A solo player on an empty server can complete the full flow.
- Multiple players can contribute near each other without stealing progress or
  blocking individual rewards.
- No first-30-minute objective requires large material totals or long repeated
  actions.

## Out Of Scope

- monetization,
- long-term grind pacing,
- hard specialization decisions,
- player market balancing,
- offline workers and automation.
