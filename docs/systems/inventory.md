# Inventory System

This document describes the planned inventory architecture for player items,
resources, tools, UI icons, and held 3D models.

## Decision

The game should use a custom server-authoritative inventory as the source of
truth.

Roblox `Backpack` should be used only for active `Tool` instances that the
player can equip or hold. It should not be the main inventory database.

This keeps the system flexible for:

- stackable resources like wood and stone,
- non-stackable tools like axes and pickaxes,
- different item rarities,
- different stack sizes per item,
- durability, upgrades, and item-specific state,
- expandable inventory and hotbar capacity,
- inventory UI with 2D icons,
- real 3D models when an item is held,
- future storage crates, trading, crafting, and saving.

## Core Principle

Inventory items are data first.

The player's inventory should store item records, not Roblox instances.
Instances such as `Tool`, `Model`, `MeshPart`, and UI objects are created from
that data when needed.

Example:

```lua
{
	Slots = {
		{
			ItemId = "Wood",
			Amount = 40,
		},
		{
			ItemId = "Stone",
			Amount = 12,
		},
		{
			ItemId = "BasicAxe",
			Amount = 1,
			UniqueId = "item_102938",
			Durability = 87,
		},
	}
}
```

## Item Configs And Registry

Each item should keep its public configuration next to its assets.

The config should be a `ModuleScript` named `Config` inside the item folder:

```text
ReplicatedStorage.Assets.Items.<ItemId>.Config
```

This keeps the item's data, icon, world model, and held tool together.

Example:

```lua
return {
	ItemId = "Wood",
	DisplayName = "Wood",
	Stackable = true,
	MaxStack = 64,
	Rarity = "Common",
}
```

A shared `ItemRegistry` module should load all item configs and expose one
simple API for the rest of the game.

Example API:

```lua
ItemRegistry:GetDefinition("Wood")
ItemRegistry:GetAssets("Wood")
ItemRegistry:GetIcon("Wood")
ItemRegistry:GetTool("BasicAxe")
```

This gives the project one clean place to ask about items without forcing every
item definition into one large file.

Public config in `ReplicatedStorage` should only contain data that the client is
allowed to know. Server-only values, such as hidden drop chances or economy
tuning, should live in server-only modules under `ServerStorage` or
`ServerScriptService`.

## Suggested Roblox Structure

```text
ReplicatedStorage
  Modules
    ItemRegistry

  Assets
    Items
      Wood
        Config
        Icon
        WorldModel
        Tool

      Stone
        Config
        Icon
        WorldModel
        Tool

      BasicAxe
        Config
        Icon
        WorldModel
        Tool

ServerScriptService
  Services
    InventoryService

  InventoryServer

ReplicatedStorage
  Remotes
    InventoryUpdated
    EquipItemRequest
    UnequipItemRequest
```

Item assets should be grouped by item rather than by asset type.

This keeps all presentation assets for one item next to each other:

```text
ReplicatedStorage.Assets.Items.<ItemId>.Config
ReplicatedStorage.Assets.Items.<ItemId>.Icon
ReplicatedStorage.Assets.Items.<ItemId>.WorldModel
ReplicatedStorage.Assets.Items.<ItemId>.Tool
```

`Config` is used for public item data. `Icon` is used by inventory UI.
`WorldModel` is used for item previews, drops, or non-tool world visuals.
`Tool` is used when the player can hold or equip the item.

Not every item needs every visual child. For example, a purely passive material
may only need `Icon` and `WorldModel`, while a held tool should have `Tool`.

## Server Inventory Data

During a session, inventories should be stored on the server in a Lua table
keyed by `Player.UserId`.

Example:

```lua
local Inventories = {
	[123456789] = {
		Slots = {},
	}
}
```

Only the server can mutate this data.

Clients can request actions, but the server validates and applies them.

Example server API:

```lua
InventoryService:GetInventory(player)
InventoryService:AddItem(player, "Wood", 20)
InventoryService:RemoveItem(player, "Stone", 5)
InventoryService:HasItem(player, "BasicAxe")
InventoryService:EquipSlot(player, slotIndex)
```

## Stackable Items

Stackable items use `ItemId` and `Amount`.

Example:

```lua
{
	ItemId = "Wood",
	Amount = 40,
}
```

Stacking rules:

- `ItemRegistry:GetDefinition(itemId).Stackable` must be `true`,
- no stack can exceed `ItemRegistry:GetDefinition(itemId).MaxStack`,
- adding items should fill existing partial stacks first,
- leftover amount should create new stacks if space exists.

Example:

```text
Wood MaxStack = 64

Current:
Slot 1: Wood x40

Add:
Wood x30

Result:
Slot 1: Wood x64
Slot 2: Wood x6
```

## Non-Stackable Items

Non-stackable items use `Amount = 1`.

They should usually get a `UniqueId`, especially if they can have durability,
upgrades, randomized stats, ownership history, or trade state.

Example:

```lua
{
	ItemId = "BasicAxe",
	Amount = 1,
	UniqueId = "item_a1",
	Durability = 73,
}
```

`UniqueId` is useful because slot numbers can change when the inventory is
sorted, moved, traded, or saved. A stable id lets the game refer to one exact
item instance.

Stackable resources generally do not need `UniqueId`.

## Rarity

Rarity belongs in the item definition by default.

Example:

```lua
Rarity = "Common"
```

If a specific item instance can roll a different rarity or quality, store that
rarity on the inventory record too.

Example:

```lua
{
	ItemId = "BasicAxe",
	Amount = 1,
	UniqueId = "item_b7",
	Rarity = "Rare",
	Durability = 92,
}
```

The UI can use rarity for borders, colors, sorting, and filtering.

## Icons And UI

Inventory UI should render from a read-only copy of server inventory data.

The client should combine each slot record with `ItemRegistry`:

```lua
local definition = ItemRegistry:GetDefinition(slot.ItemId)
local icon = ItemRegistry:GetIcon(slot.ItemId)

slotButton.Icon.Image = icon and icon.Image or ""
slotButton.AmountLabel.Text = tostring(slot.Amount)
```

The server should send inventory updates through a remote event such as
`InventoryUpdated`.

The client should not decide whether an item exists or whether an action is
valid.

## Inventory And Hotbar Capacity

Inventory capacity should be upgradeable.

The player should start with a small number of inventory slots and unlock more
slots over time through progression, buildings, equipment, upgrades, or trade.
This makes inventory space part of the economy without forcing early players to
manage too much UI.

Hotbar capacity should also be upgradeable, but separately from total inventory
capacity.

The inventory answers what the player owns. The hotbar answers which owned
items are quickly accessible. Increasing one should not automatically increase
the other.

Example player state:

```lua
{
	Slots = {},
	Capacity = {
		InventorySlots = 20,
		HotbarSlots = 5,
	},
	Hotbar = {
		[1] = "item_a1",
		[2] = "Wood",
	}
}
```

Rules:

- the server owns the current inventory and hotbar slot counts,
- inventory slot upgrades increase how many item stacks or item records the
  player can store,
- hotbar slot upgrades increase how many quick-access assignments the player
  can have,
- the client may request hotbar assignment changes, but the server validates
  that the item exists and the target hotbar slot is unlocked,
- items should not be destroyed when capacity changes; if capacity is reduced
  later, overflow behavior must be handled explicitly before shipping.

For MVP, the first version can use fixed starting values and add the upgrade
flow later. The data shape should still leave room for `InventorySlots` and
`HotbarSlots` so the UI and services do not need to be redesigned.

## Held 3D Models

Held items should use Roblox `Tool` instances.

The custom inventory decides what the player owns. When the player equips an
item, the server clones the matching `Tool` from the item's asset folder into
the player's `Backpack` or `Character`.

Example flow:

```text
Player clicks Basic Axe in custom inventory UI
Client fires EquipItemRequest(slotIndex)
Server validates that the slot contains BasicAxe
Server clones Assets.Items.BasicAxe.Tool
Tool appears in Backpack or Character
Player can hold the real 3D axe
```

For resources that should be held, such as wood or stone, create simple `Tool`
assets too. The `Tool` can use a small model or `MeshPart` as its visual handle.

## Backpack Role

`Backpack` is a runtime equip container, not the main inventory.

Use it for:

- currently equipable tools,
- Roblox tool behavior,
- 3D held visuals,
- click or activation behavior on tools.

Do not use it for:

- counting all owned resources,
- storing stack amounts,
- saving inventory,
- deciding whether the player owns an item,
- permanent item state.

## DataStore Save Shape

Saved inventory data should be plain serializable data.

Save:

- `ItemId`,
- `Amount`,
- `UniqueId`,
- `Durability`,
- instance-specific rarity or upgrades,
- slot order if the inventory UI needs stable ordering,
- unlocked inventory slot count,
- unlocked hotbar slot count,
- hotbar assignments if the player can customize them.

Do not save:

- `Tool` instances,
- `Model` instances,
- `MeshPart` instances,
- UI objects,
- temporary equipped state unless it is intentionally part of the design.

## MVP Scope

The first implementation should include:

- per-item `Config` modules,
- shared `ItemRegistry`,
- server-side `InventoryService`,
- in-memory inventory per player,
- stack add/remove logic,
- non-stackable item records with `UniqueId`,
- `InventoryUpdated` remote event,
- simple inventory UI rendering icons and amounts,
- equip request that creates a matching `Tool`,
- starting inventory and hotbar capacity values in the player inventory state.

DataStore saving can be added after the basic inventory behavior is working.

## Open Questions

- What are the starting and maximum inventory slot counts?
- What are the starting and maximum hotbar slot counts?
- Which progression systems unlock more inventory and hotbar slots?
- Should stackable resources occupy regular slots or a separate materials tab?
- Should equipped tools stay visible inside inventory slots?
- Should sorting preserve slot positions or rebuild them automatically?
- Should storage crates use the same inventory data structure as players?
- Should rarity be fixed per item type or roll per item instance?
