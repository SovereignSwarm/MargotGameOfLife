# CLAUDE.md - MargotGameOfLife

## Project Overview
Private parent-child co-op village life sim built on Luanti. Players gather, craft, sell, save, own productive assets, and contribute to civic projects. Money is fuel, not the goal. Optimized for 1-2 players sharing one world.

## Current Project State
- **Active milestone**: Milestone 2 (Shared Household Layer) - CLOSED and FROZEN
- **save_version**: 3 | **content_version**: 1
- **Closure anchor**: `docs/production/milestone_2_baseline_decision.md`
- **Milestone 3**: Station condition implemented. `place/crafting_station` has durable ready/not_ready condition.

## Frozen Milestone Truths

### Milestone 1 - Orchard and Bridge (FROZEN)
Verified end-to-end. Blocks A-D proven at approved boundaries.
- Block A: gather apples, pick up flour, craft pies, sell pies (personal value loop)
- Block B: save coins, buy apple tree, recurring personal yield
- Block C: contribute coins to shared bridge, visible civic stages and completion
- Block D: sparse stateless NPC reflection on success events only (4 triggers)
- Authorities: `player_state.coins`, `player_state.owned_assets["asset/apple_tree"]`, civic state in `world_state.civic.*`

### Milestone 2 - Shared Household Layer (FROZEN at verified baseline)
- Pantry: `world_state.household.inventory` with count-based `item/apple` and `item/flour`
- Reserve: derived `2 apples + 1 flour` protection with explicit break-reserve confirm
- Purpose: house-ready / house-not-ready legibility through pantry messaging only
- NO direct pantry baking, NO household `item/pie`, NO shared coins, NO shared tree ownership
- NO saved readiness/purpose/debt/owner fields - all derived from pantry counts

### Milestone 3 - Persistent World (PLANNING ONLY)
Defined in `docs/production/milestone_3_persistent_world_definition.md`. Three dimensions:
1. Persistent place - one known place keeps a durable condition
2. Persistent role - one specialist stays tied to that place condition
3. Persistent dependency - later use depends on whether that condition holds

Best shape: one specialist-linked existing-village place with durable ready/restored condition. NOT new district expansion, NOT broad simulation, NOT NPC memory sprawl.

## Non-Negotiable Authority Boundaries
| Scope | Authority | Save Location |
|---|---|---|
| Personal | inventory, coins, owned_assets, tree yield, pies, sale results | per-player saves |
| Household | `world_state.household.inventory` only (apple + flour counts) | world save |
| Civic | `world_state.civic.project_funds/stages/unlocked_places/place_conditions` | world save |

These three scopes MUST stay explicit and MUST NOT blur into mixed read/write paths.

## What Must Not Be Changed Casually
- Frozen canonical IDs (see `docs/production/id_policy.md`)
- Save shape or version without explicit migration
- Ownership scope assignments (personal vs household vs civic)
- Block A-D runtime behavior
- Pantry transfer semantics (explicit, fixed qty 1, non-partial)
- NPC scope (stateless, success-only, 4 triggers, no memory)

## Doc Authority Order
1. `docs/canon/*` - permanent identity rules
2. `docs/design/*` - current playable expression
3. `docs/production/*` - change control and discipline
4. Runtime code - implements the above
5. Chat/commits - lowest authority

If code and docs disagree, fix the code (unless docs are clearly stale).

## Required Read Order for New Sessions
1. This file (CLAUDE.md)
2. `docs/production/current_state.md`
3. `docs/production/milestone_2_baseline_decision.md`
4. Task-specific docs from `AGENTS.md` "Read By Task" sections

For deeper context: `docs/README.md` has the full 38-doc reading order.

## Do First Before Coding
1. Read `docs/production/current_state.md` for active state and approved next steps
2. Read task-specific docs listed in `AGENTS.md`
3. Confirm the change is inside the current milestone scope
4. Confirm no frozen IDs, save shape, or ownership boundaries are affected
5. Confirm personal/household/civic separation is preserved

## Do Not Do
- Do not implement Milestone 3 features without explicit authorization
- Do not widen Milestone 2 beyond its frozen baseline
- Do not add new saved fields to household state
- Do not create mixed personal/household/civic write paths
- Do not rename canonical IDs without migration
- Do not add direct pantry baking or household `item/pie`
- Do not expand NPC behavior beyond Block D scope
- Do not add speculative frameworks, UI polish, or extra districts
- Do not treat Milestone 2 closure as automatic Milestone 3 start
- Do not code from partial doc context or chat-only intent

## Key Runtime Structure
```
game/mods/margot/
  init.lua              -- load order: migrations, state, persistence, debug, data/*, systems/*, runtime/*
  data/                 -- items, recipes, assets, places, projects, npc_profiles
  systems/              -- crafting, economy, ownership, household, projects, npc
  runtime/              -- state, persistence, migrations, debug, block_a/b/c, household_pantry
```

## Active Risks to Watch
- Personal/household/civic boundary leakage
- AI tools drifting from repo truth (read docs, not memory)
- Pantry handlers mistaken for transaction framework
- Co-op readability slipping in reserve messaging
- Milestone 2 widening without explicit authorization
