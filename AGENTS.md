## Project Overview

This project uses:

* Roblox Studio
* VS Code
* Codex
* Roblox Studio MCP

## Architecture Principles

Prefer:

* ModuleScripts
* small reusable modules
* server-authoritative gameplay

Avoid:

* large monolithic scripts
* duplicated logic
* business logic inside UI scripts

## Development Workflow

When implementing a feature:

1. Inspect current architecture.
2. Reuse existing modules where possible.
3. Use Studio only for testing and visual setup.

## Before Making Changes

Always:

* search for existing implementation first
* avoid creating duplicate systems
* follow existing naming conventions
* keep solutions simple
* prefer MVP implementations over premature optimization
