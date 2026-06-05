## Project Overview

This project uses:

* Roblox Studio
* Rojo
* VS Code
* Codex
* Roblox Studio MCP

Rojo is the source of truth for all code.

## Source of Truth

### Code

All Lua/Luau code must be modified in files managed by Rojo.

Examples:

* src/server
* src/client
* src/shared

Never edit code directly inside Roblox Studio if the script is managed by Rojo.

### Roblox Studio

Roblox Studio is used for:

* testing
* models
* maps
* terrain
* UI layout
* object properties
* pivots
* attachments
* constraints
* particle effects
* sounds

Studio is NOT the source of truth for code.

## MCP Usage Rules

The Roblox Studio MCP may be used for:

* inspecting hierarchy
* reading object properties
* creating test objects
* creating folders
* creating parts
* positioning objects
* running play tests
* reading output logs
* debugging runtime issues

The Roblox Studio MCP must NOT:

* modify Rojo-managed scripts
* create business logic inside Studio
* change code that exists in src/

If a code change is required:

1. Identify the corresponding file in the repository.
2. Modify the file in the repository.
3. Let Rojo synchronize the change into Studio.

## Script Ownership

### Rojo-owned

Any script located under:

* src/server
* src/client
* src/shared

is considered Rojo-owned.

Changes must be performed in the repository only.

### Studio-owned

The following may be edited through Studio or MCP:

* Parts
* Models
* Folders
* Attachments
* Constraints
* SurfaceGui
* BillboardGui
* UI layout objects
* Terrain
* Lighting settings

unless otherwise specified.

## Architecture Principles

Prefer:

* ModuleScripts
* small reusable modules
* server-authoritative gameplay
* shared code in src/shared

Avoid:

* large monolithic scripts
* duplicated logic
* business logic inside UI scripts

## Development Workflow

When implementing a feature:

1. Inspect current architecture.
2. Reuse existing modules where possible.
3. Create or update code in src/.
4. Allow Rojo to sync changes.
5. Use Studio only for testing and visual setup.

## Before Making Changes

Always:

* search for existing implementation first
* avoid creating duplicate systems
* follow existing naming conventions
* keep solutions simple
* prefer MVP implementations over premature optimization

## Goal

Build maintainable Roblox game systems while keeping all source code under version control and synchronized through Rojo.
