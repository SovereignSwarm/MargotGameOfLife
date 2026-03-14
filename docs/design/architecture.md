# Architecture

## Purpose
Keep design truth separate from runtime implementation so the project can grow additively without engine-driven rewrites.

## Authority
- canon docs define permanent meaning
- design docs define the current playable expression
- production docs define IDs, saves, roadmap, and change discipline
- Luanti is the current runtime, not the long-term owner of the design

## Runtime Shape
- `init.lua` boots the namespace and explicit load order
- `data/` holds content definitions only
- `systems/` holds game rules over definitions and state
- `runtime/` holds default state shapes, persistence boundaries, migrations, and debug helpers

## Current Module Plan
- `data/items.lua`
- `data/recipes.lua`
- `data/assets.lua`
- `data/places.lua`
- `data/projects.lua`
- `data/npc_profiles.lua`
- `systems/crafting.lua`
- `systems/economy.lua`
- `systems/ownership.lua`
- `systems/household.lua`
- `systems/projects.lua`
- `systems/npc.lua`
- `runtime/state.lua`
- `runtime/persistence.lua`
- `runtime/migrations.lua`
- `runtime/debug.lua`
- `runtime/block_a.lua`
- `runtime/block_b.lua`
- `runtime/block_c.lua`
- `runtime/household_pantry.lua`

## Data Rules
- use stable canonical IDs from `docs/production/id_policy.md`
- keep content definitions readable and data-first
- add new content by adding records before adding special logic
- preserve personal, household, and civic scope in both data and state

## Save Rules
- state shapes must stay explicit
- save-affecting changes must follow `docs/production/save_compatibility_policy.md`
- additive changes are preferred over renames and rewrites

## Networking Assumption
Private co-op only.
Design for 1-2 players sharing a world.
