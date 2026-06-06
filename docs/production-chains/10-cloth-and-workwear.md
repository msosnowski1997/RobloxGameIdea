# Chain 10: Cloth And Workwear

The player gathers plant fiber, spins rough thread, weaves cloth, and makes
basic workwear at a tailor bench.

Workwear is an early equipment chain that supports stamina, inventory, or worker
efficiency without becoming mandatory for core progression.

## Summary

| Field | Value |
| --- | --- |
| Main specialization | Tailoring |
| Side specialization | Farming |
| Player stage | Early game |
| Starting resource | Plant fiber |
| Required buildings | Spinning frame and tailor bench |
| Final product | Basic workwear |
| First unlock time | Around 110-170 min |
| Skill requirement | Farming 1, Tailoring 1-2 |
| First trade moment | Selling workwear to gatherers and miners |

## Production Graph

```mermaid
flowchart LR
    A["Fiber plants"] --> B["Plant fiber"]
    B --> C["Spinning frame"]
    C --> D["Rough thread"]
    D --> E["Tailor bench"]
    E --> F["Rough cloth"]
    F --> G["Basic workwear"]
    G --> H["Stamina / carry / worker readiness"]
```

## Progression Timing

| Time reached | Requirement | Expected player state |
| --- | --- | --- |
| 0-90 min | Fiber can be gathered | Player sees optional material |
| 110-140 min | Spinning frame and thread | Player can start a light equipment chain |
| 140-170 min | Tailor bench and workwear | Player gets first non-tool equipment |

## Chain Stages

| Stage | Player action | Input | Output | Building | Design goal |
| --- | --- | --- | --- | --- | --- |
| 1 | Gathers fiber | Fiber plants | Plant fiber | None | Optional starter material |
| 2 | Spins thread | Plant fiber | Rough thread | Spinning frame | First textile processor |
| 3 | Weaves cloth | Rough thread | Rough cloth | Tailor bench | Intermediate material |
| 4 | Makes workwear | Cloth + thread | Basic workwear | Tailor bench | First soft equipment |

## Recipes

| Recipe | Input | Output | Time | Building | Notes |
| --- | --- | --- | --- | --- | --- |
| Rough thread | 4 plant fiber | 2 rough thread | 30 s | Spinning frame | Starter textile |
| Rough cloth | 3 rough thread | 1 rough cloth | 40 s | Tailor bench | Textile material |
| Basic workwear | 2 rough cloth + 2 rough thread | 1 workwear | 60 s | Tailor bench | Optional early equipment |

## Buildings And Upgrades

| Object | Type | Cost | Unlocks | Role |
| --- | --- | --- | --- | --- |
| Spinning frame | Building | 5 planks + 2 simple components | Thread | First textile processor |
| Tailor bench | Building | 8 planks + 4 nails | Cloth and workwear | First Tailoring station |
| Peg rail | Upgrade | 3 planks + 2 nails | Faster workwear crafting | Small tailor upgrade |

## Skill And Building Requirements

| Unlock | Skill | Building | Notes |
| --- | --- | --- | --- |
| Plant fiber | Farming 1 | None | Gatherable from map |
| Rough thread | Tailoring 1 | Spinning frame | First textile skill |
| Basic workwear | Tailoring 2 | Tailor bench | Optional equipment path |

## Balance Notes

- Workwear should be an individual item, not a mass-consumed resource.
- It can give minor stamina, carry, or worker-readiness bonuses.
- It should not be needed to reach the forge or pickaxe.
- Tailoring can be a soft specialization branch after the player is self-sufficient.

## Design Risks

- If Tailoring is required for core progression, the early skill budget gets too tight.
- If workwear gives a huge bonus, every player feels forced into Tailoring.
- If textiles take too long, the chain feels slow before it has market value.
