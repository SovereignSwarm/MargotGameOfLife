# Current State

## Purpose
This page is the operational orientation for the repo. Read it to see the active milestone, the current production priority, the top risks, and the next valid steps before broader coding begins.

## Current Milestone
`Milestone 1 - Orchard and Bridge`

Milestone 1 has now started. Block A has been verified end-to-end in-engine for the personal apple -> pie -> coin loop, and Block B now exists in runtime in a minimal personal-ownership form. The next honest gate is a dedicated Block B verification pass before Block C begins.

## Current Priority
Verify Block B only through `docs/production/milestone_1_checklist.md`, `docs/production/milestone_1_implementation_order.md`, `docs/design/milestone_1_ownership_semantics.md`, and `docs/design/milestone_1_acceptance_criteria.md`. Keep Block A frozen, keep Block B narrow, and do not begin Block C until Block B exit conditions are honestly true.

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
- Block B purchase and recurring yield are now implemented, but not yet verified end-to-end in-engine

## What Is Not Ready Yet
- the Orchard and Bridge slice is not yet fully implemented
- Block B is not yet verified end-to-end against its exit condition
- Blocks C and D are still unbuilt
- household semantics remain deferred to Milestone 2
- save smoke expectations are defined, but feature passes still need to verify them as real gameplay state lands

## Top Active Risks Right Now
- implementation beginning outside the Milestone 1 acceptance gate
- AI tools drifting from repo truth
- co-op being treated like two solo players sharing space
- NPC commentary drifting into chatter instead of state-based consequence

## Immediate Reinforcement Moves
- keep Block A limited to the verified shared starter strip, personal inventory, crafting, sale, and coin flow only
- keep the current prototype accessibility layer only as the minimum starter-area support needed for Block A and future Block B verification
- verify Block B before any Block C implementation begins
- keep personal and civic authorities singular and explicit
- verify the Milestone 1 save smoke expectations as each block becomes real

## Explicitly Out Of Scope Right Now
- extra districts or professions
- advanced AI NPCs
- taxes, inheritance, or abstract finance
- public-server or MMO assumptions
- lore expansion not attached to playable places or systems
- framework-heavy or UI-polish work

## Approved Next Baby Steps
1. verify Block B `apple tree purchase`
2. verify Block B `recurring tree yield` and save/load behavior
3. verify two-player personal ownership isolation at the shared tree surface
4. do not begin Block C until Block B exit conditions are true

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
- when and how household scope becomes a real gameplay authority
- whether `item/tree_deed` should become a visible receipt item later without becoming a second ownership authority
- what the first true household trade-off is in Milestone 2
- how deeper NPC memory and judgment systems are introduced after Milestone 1

## Final Rule
Do not start coding from partial context.
