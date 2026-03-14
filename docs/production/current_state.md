# Current State

## Purpose
This page is the operational orientation for the repo. Read it to see the active milestone, the current production priority, the top risks, and the next valid steps before broader coding begins.

## Current Milestone
`Milestone 2 - Shared Household Layer`

Milestone 1 remains the frozen verified Orchard and Bridge baseline. Milestone 2 has now begun in one narrow verified form only: a first shared household pantry shape for apples and flour.

## Current Priority
Keep the verified first household pantry shape plus the new reserve-aware withdrawal step narrow and honest. The active work is dedicated verification of the reserve-aware withdrawal runtime shape only; do not widen into direct pantry baking, shared coins, shared tree ownership, civic rewrites, broader household systems, or household NPC commentary.

## What Is Already True
- canon, design, and production hierarchy exists
- Orchard and Bridge is the active slice
- Milestone 1 acceptance criteria and the production-scale phase plan now exist
- Milestone 1 ownership semantics are now explicit in `docs/design/milestone_1_ownership_semantics.md`
- Milestone 1 implementation order is now explicit in `docs/production/milestone_1_implementation_order.md`
- Milestone 1 readiness, build, and review checks are now explicit in `docs/production/milestone_1_checklist.md`
- the Codex workflow and post-task documentation sync rule now exist
- runtime is already split into `data/`, `systems/`, and `runtime/`
- ID policy, save policy, schema reference, operating model, risk register, and title strategy exist
- starter canonical IDs are now frozen for the Orchard and Bridge slice
- starter save-state boundaries and smoke expectations are now documented for Milestone 1
- private co-op, additive growth, visible civic consequence, and money-as-fuel are already locked
- Block A nodes now exist in runtime for orchard pickup, bakery flour pickup, pie crafting, and pie sale
- a one-time shared starter civic strip bootstrap now exists for the Block A places
- a prototype accessibility layer now fixes the Block A starter anchor at a safe shared platform, maps the missing starter-world mapgen aliases to inert substrate, and places fresh or obviously broken players at the starter area after bootstrap completes
- Block A still keeps personal inventory and `player_state.coins` as the only personal authorities it touches
- Block A has now been verified in-engine for starter-strip bootstrap, apple pickup, flour pickup, pie crafting success/failure, pie sale success/failure, save/load round-trip, and separate personal state for two players sharing the same civic strip
- Block B now adds one shared starter-strip apple tree interaction surface that resolves to each player's own personal ownership and readiness state
- Block B now records starter tree ownership only in `player_state.owned_assets["asset/apple_tree"]` and reads tree cost and apple yield from the existing asset definition
- Block B purchase success, purchase failure, no double purchase, same-day not-ready behavior, save/load round-trip, and separate personal ownership state have now been runtime-verified
- Block B recurring yield and two-player harvest separation have now been runtime-verified under a verification-world day-count advance
- Block B startup no longer tries to place its shared tree surface during a disallowed init phase
- the normal shared starter-strip path now comes up cleanly on first player join, and `bootstrap/block_a_starter_strip` now lands on `placed` instead of stalling at `pending`
- Block B is now honestly verified end-to-end in-engine for normal-path bootstrap, purchase success, purchase failure, no double purchase, same-day not-ready behavior, next-day harvest, save/load round-trip, and two-player separation at the shared tree surface
- Block C now adds one shared starter-strip bridge site that spends a fixed 5-coin contribution from the acting player's personal `player_state.coins` only
- Block C now records bridge contribution total, bridge stage, and bridge completion outcome only in `world_state.civic.project_funds`, `world_state.civic.project_stages`, and `world_state.civic.unlocked_places`
- Block C now derives bridge stages from saved civic funds, renders the bridge from saved civic truth on join, and keeps all bridge walkable surface nodes at the same surface height as the existing placed starter nodes
- Block C now turns `project/bridge_01` completion into a visible shared `place/bridge` outcome by placing a walkable bridge span for everyone in the same world
- Block C has now been honestly verified end-to-end in-engine for insufficient-funds failure, contribution success, stage progression, completion outcome, save/load round-trip, and shared-civic plus separate-personal co-op behavior
- Block D now appends one optional NPC-attributed follow-up line to success output only for tree purchase, first world bridge contribution, bridge framing, and bridge completion
- Block D trigger detection is stateless, event-time only, and derived from pre/post personal or civic truth already required by Blocks B and C
- Block D does not add new save data, does not change ownership scope, and does not change canonical IDs
- Block D has now been honestly verified end-to-end in-engine for approved success triggers only, non-trigger silence including ready-tree harvest, co-op targeting, output shape, and save/load neutrality
- Milestone 2 now activates `world_state.household.inventory` as the first live household authority
- the first household pantry shape is count-based only and stores aggregate counts for `item/apple` and `item/flour`
- the first pantry shape now exposes five fixed-action starter-strip surfaces on exact pantry-owned cells at `z = -1`: apple deposit, flour deposit, pantry read, apple withdraw, and flour withdraw
- pantry transfers are explicit, fixed at quantity `1`, and intended to be non-partial at the handler and validation level
- pantry crafting, sale, and other use do not exist; Block A crafting and sale still read only from personal inventory
- the first pantry shape is now honestly verified end-to-end in-engine for deposit, withdrawal, shared visibility, save/load round-trip, and two-player household correctness
- reserve-aware withdrawal now treats `2 apples + 1 flour` as one derived complete reserve only, with no saved reserve field
- pantry read now reports reserve-ready versus reserve-incomplete status from shared pantry counts
- surplus withdrawal remains normal, while a reserve-breaking withdrawal now requires explicit same-player same-surface confirmation before state changes
- reserve-break confirmation is ephemeral runtime-only, clears on non-matching pantry interaction or leave, resets on relaunch, and is not saved as gameplay truth
- `save_version` is now `2` while `content_version` remains `1`

## What Is Not Ready Yet
- reserve-aware withdrawal is now implemented in runtime, but it has not yet been honestly verified end-to-end in-engine
- no direct baking from pantry, no pantry `item/pie` scope, no shared coins, no shared tree ownership, and no civic rewrite are approved
- no broader household framework, no extra household goods, and no household NPC commentary are approved
- save smoke expectations now include household pantry state as live gameplay state and must stay explicit as Milestone 2 grows

## Top Active Risks Right Now
- personal, household, and civic boundaries leaking into one mixed runtime path
- pantry transfer handlers being mistaken for a full transaction or rollback framework
- AI tools drifting from repo truth
- co-op readability slipping if reserve-warning and reserve-break messaging stop feeling obviously shared
- Milestone 2 widening beyond the reserve-aware withdrawal step before that narrow step is honestly verified

## Immediate Reinforcement Moves
- keep Blocks A, B, C, and D frozen at their verified Milestone 1 scope
- keep household authority singular and explicit at `world_state.household.inventory` only
- keep the pantry count-based only for `item/apple` and `item/flour`
- keep pantry interaction bounded to the exact `z = -1` starter-strip row cells already chosen for deposit, read, and withdrawal
- keep crafting and sale personal-inventory-only after explicit withdrawal
- keep the persistence caveat honest: intended non-partial handler behavior does not yet mean transaction-wrapped cross-write persistence

## Explicitly Out Of Scope Right Now
- extra districts or professions
- advanced AI NPCs
- taxes, inheritance, or abstract finance
- public-server or MMO assumptions
- lore expansion not attached to playable places or systems
- framework-heavy or UI-polish work
- direct baking from pantry
- shared coins or household spending
- shared tree ownership
- household `item/pie` scope
- civic rewrites

## Approved Next Baby Steps
1. run a dedicated in-engine verification pass for reserve-ready read output, surplus withdrawal, reserve-warning no-op behavior, reserve-break confirmation, reset behavior, co-op correctness, and save/load neutrality
2. keep the first pantry shape frozen at apples-and-flour-only runtime scope plus reserve-aware withdrawal only
3. preserve Milestone 1 personal, civic, coin, tree, and NPC boundaries unchanged under the new pantry layer
4. do not begin broader household mechanics or wider Milestone 2 work until the reserve-aware withdrawal step is honestly verified

## Read This Before You Touch...
### Code
- `docs/README.md`
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/design/v1_vertical_slice.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_ownership_semantics.md`
- `docs/production/milestone_1_implementation_order.md`
- `docs/production/milestone_1_checklist.md`
- `docs/design/milestone_1_acceptance_criteria.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

### IDs Or Saves
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/production/milestone_1_checklist.md`
- `docs/design/architecture.md`
- `docs/production/current_state.md`
- `docs/production/risk_register.md`

### Ownership Or Co-op Semantics
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/canon/society_constitution.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_ownership_semantics.md`
- `docs/production/risk_register.md`

### Lore Or World Expansion
- `docs/canon/lore_constitution.md`
- `docs/canon/vision.md`
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/production/current_state.md`

### Milestone Planning
- `docs/production/roadmap.md`
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/production_scale_phase_plan.md`
- `docs/production/backlog.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

## Deferred Questions That Must Not Be Smuggled Into Code
- whether `item/tree_deed` should become a visible receipt item later without becoming a second ownership authority
- how wider household use rules should evolve after the withdraw-first pantry proof
- how deeper NPC memory and judgment systems are introduced after Milestone 1

## Final Rule
Do not start coding from partial context.
