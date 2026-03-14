# Milestone 3 Station Condition Plan

## Purpose
This document defines the implementation plan for the Milestone 3 crafting-station place condition: the specific trigger, restore action, state shape, runtime shape, and boundary rules. It does not authorize implementation.

## Chosen Place And Specialist
`place/crafting_station` with `npc/baker` as the linked specialist.

The Baker's `home_place_id` is already `place/crafting_station` in `data/npc_profiles.lua`. The Baker's priorities are `craft` and `consistency`. The station's readiness is what makes the Baker's local responsibility meaningful.

## Trigger Options
### Option A: Bridge completion one-time seed
When `project/bridge_01` reaches `complete` stage, the station condition field is seeded to `not_ready` once. After that one-time seed, the field is the sole authority. The bridge does not re-disrupt the station on every load or re-derive the condition continuously.

### Option B: Cumulative bake threshold
After N successful bakes across all players, the station transitions to not ready. Requires a use counter in saved state. Recurring and use-based.

### Option C: Station starts not ready in fresh worlds
The station's initial condition in new worlds is not ready. Players must prepare it before baking works. One-time initial setup only.

## Best Trigger
Option A: bridge completion one-time seed.

Bridge completion is the most specific possible disruption. It is one concrete world event, not passive decay, not a timer, and not a recurring tax. The major construction project disrupted the adjacent work area, and now the station needs recommissioning before baking can resume.

One-time seed semantics:
- When bridge reaches `complete` AND station condition field does not yet exist, set `place_conditions["place/crafting_station"]` to `"not_ready"`.
- After the field exists, only the explicit player restore action changes it.
- The bridge does not re-disrupt the station on every load or session.

Migration for v2 saves:
- Bridge already complete: seed `place_conditions["place/crafting_station"] = "not_ready"`.
- Bridge not yet complete: seed `place_conditions["place/crafting_station"] = "ready"`. The one-time trigger will overwrite this to `"not_ready"` when the bridge completes later.

This is the safest trigger because:
- It avoids cumulative-counter maintenance-tax framing entirely.
- It ties the condition to the biggest existing village event, so the disruption feels meaningful rather than arbitrary.
- It proves persistent world through one clear cycle: bridge completes, station needs recommissioning, player restores it, station stays ready.
- The one-time seed pattern avoids permanent coupling between bridge state and station condition.

## Restore Action Options
### Option 1: Deliver 1 flour from personal inventory
The acting player brings 1 flour from personal inventory to a recommission interaction surface. Flour is consumed, station condition changes to ready.

### Option 2: Multi-interact with no resource cost
The player interacts with the station several times to recommission it. No resource cost. Simple but empty.

### Option 3: Deliver 2 apples and 1 flour from personal inventory
The player brings a full pie-input set to recommission the station. Higher cost, mirrors the pie recipe.

## Best Restore Action
Option 1: deliver 1 flour from personal inventory.

The acting player's personal inventory is the only source. No pantry shortcut, no household withdrawal, no mixed personal-household consumption. The transfer is personal to civic: 1 flour leaves personal inventory, and the station condition changes to ready in civic world state. This matches the same scope boundary pattern as bridge coin contributions (personal coins to civic project).

This is the safest restore action because:
- 1 flour is a real cost without being punitive. Flour is the scarce non-free ingredient in the production loop.
- It keeps the personal-to-civic scope boundary explicit. The player must have flour in personal inventory, not in the pantry.
- It is immediately child-legible: you prepare the baking station with baking supplies.
- It does not heavily compete with the household reserve. The reserve protects 2 apples + 1 flour in the pantry; this spends 1 personal flour.
- It is a single explicit action, not a timer or grind.

## State / Save Recommendation
The station condition cannot be derived from existing state. The crafting system has no side effects and no use counter. One narrow saved field is necessary.

Field: `world_state.civic.place_conditions["place/crafting_station"]`
Values: `"ready"` or `"not_ready"`
Location: under civic world state, because the crafting station is civic scope
Shape: `world_state.civic.place_conditions` is a string-keyed table defaulting to `{}`

`save_version` advances from 2 to 3. `content_version` stays at 1 unless content definitions change.

Migration from v2 to v3:
- Add `world_state.civic.place_conditions` as `{}` if absent.
- One-time bridge-aware seed: if `project_stages["project/bridge_01"] == "complete"`, set station to `"not_ready"`. Otherwise set to `"ready"`.
- This seed runs once during migration. After migration, the field is the sole authority.

`ensure_world_state_shape` in `runtime/state.lua` should initialize `working.civic.place_conditions` to `{}` if absent, matching the existing pattern for other civic subtables.

Do not create a general place-condition framework, world-activity ledger, or mixed-scope persistence layer.

## What Must Stay Unchanged
- `player_state.coins` remains the only personal coin authority
- `player_state.owned_assets["asset/apple_tree"]` remains the only tree ownership authority
- `player_state.inventory` remains the only personal inventory authority
- `world_state.household.inventory` remains the only household authority
- `world_state.civic.project_funds`, `project_stages`, and `unlocked_places` remain the civic project authorities
- Block A pickup, Block B tree, Block C bridge, and Block D NPC reflection stay frozen at their verified scopes
- Pantry deposit, withdrawal, reserve, and house-ready messaging stay unchanged
- No direct pantry baking, no household `item/pie`, no shared coins, no shared tree ownership
- No new ownership scope layer
- No mixed personal-household-civic write paths
- Restore action must consume from personal inventory only, never from pantry or household scope
- No broader NPC memory, dialogue, or routine systems
- No new districts or content chains

## Smallest Good Milestone 3 Runtime Shape
One binary civic place-condition field persists across save/load. One existing crafting-station node gains a condition check before baking proceeds: if not ready, baking is blocked with a clear message. One new interaction surface or mode at the station lets a player spend 1 personal flour to recommission the station. Bridge completion triggers a one-time seed that sets the condition to not ready. Both co-op players see the same station condition. The Baker specialist link is already in data and does not require NPC behavior changes in this milestone.

Files that would change in a later implementation pass:
- `runtime/state.lua`: add `place_conditions` to civic state shape
- `runtime/migrations.lua`: add v2-to-v3 migration with bridge-aware seed
- `runtime/block_a.lua`: add condition check before `handle_craft` and new recommission handler
- `runtime/block_c.lua`: add one-time seed after bridge-completion event
- `systems/crafting.lua`: no change (condition check lives in the runtime handler, not the system)

## Failure / Overreach Risks
### This becomes a maintenance tax if:
- The trigger becomes recurring or timer-based instead of staying a one-time bridge-completion seed.
- The restore cost escalates beyond 1 flour or requires multiple resources.
- Future milestones add more place conditions without individual justification.

### This becomes fake simulation if:
- The station condition starts being continuously derived from bridge state instead of using the one-time seed.
- Visual changes imply ongoing world activity that does not exist.
- The Baker gains NPC reactions without a separate NPC-scope approval pass.

### The biggest authority risk is:
- The restore action accidentally consuming from household pantry instead of personal inventory, creating a mixed-scope write path.

### The biggest scope risk is:
- `world_state.civic.place_conditions` being treated as a reusable framework instead of a single-purpose field for this one place.

## Recommendation
Implement the crafting-station condition as one binary civic field, one bridge-completion seed, and one personal-flour restore action. This is the narrowest possible Milestone 3 proof: one place, one condition, one trigger, one restore, one dependency. It proves persistent world through all three dimensions without new districts, new NPCs, broader simulation, or scope expansion.

## Final Rule
The station needs recommissioning once after the bridge is built. After that, it stays ready.
