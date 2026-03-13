# Current State

## Purpose
This page is the operational orientation for the repo. Read it to see the active milestone, the current production priority, the top risks, and the next valid steps before broader coding begins.

## Current Milestone
`Milestone 0 - Canon and Repo Foundation`

The repo is still here because IDs, schema consistency, ownership semantics, and save discipline are not yet hardened enough for broader Milestone 1 implementation.

## Current Priority
Foundation hardening that makes Orchard and Bridge safe to implement: freeze starter IDs, normalize starter content records, prove save boundaries, lock ownership semantics, and use the Milestone 1 acceptance gate instead of inventing completion rules in code.

## What Is Already True
- canon, design, and production hierarchy exists
- Orchard and Bridge is the active slice
- Milestone 1 acceptance criteria and the production-scale phase plan now exist
- the Codex workflow and post-task documentation sync rule now exist
- runtime is already split into `data/`, `systems/`, and `runtime/`
- ID policy, save policy, schema reference, operating model, risk register, and title strategy exist
- private co-op, additive growth, visible civic consequence, and money-as-fuel are already locked

## What Is Not Ready Yet
- starter canonical IDs are not yet frozen
- starter content records are not yet fully normalized to the schema reference
- ownership semantics are not yet fully locked for implementation
- save/load plus migration smoke checks are not yet proven
- runtime boundaries are explicit but not yet battle-tested under real features
- the Orchard and Bridge slice is not yet fully implemented

## Top Active Risks Right Now
- casual canonical ID churn before durable saves exist
- schema drift in early content records
- muddy runtime state boundaries
- ownership scope ambiguity
- implementation beginning outside the Milestone 1 acceptance gate
- AI tools drifting from repo truth
- first saves created before migration discipline is real

## Immediate Reinforcement Moves
- freeze starter IDs
- align starter records to the schema reference
- smoke-test save/load and migrations
- lock ownership semantics
- use `docs/design/milestone_1_acceptance_criteria.md` as the implementation gate

## Explicitly Out Of Scope Right Now
- extra districts or professions
- advanced AI NPCs
- taxes, inheritance, or abstract finance
- public-server or MMO assumptions
- lore expansion not attached to playable places or systems
- framework-heavy or UI-polish work

## Approved Next Baby Steps
1. review and freeze starter canonical IDs
2. align starter content records to `content_schema_reference.md`
3. smoke-test save/load and migration entry points
4. lock explicit personal, household, and civic ownership semantics
5. start Milestone 1 implementation only through `docs/design/milestone_1_acceptance_criteria.md`

## Read This Before You Touch...
### Code
- `docs/README.md`
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/design/v1_vertical_slice.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_acceptance_criteria.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

### IDs Or Saves
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/design/architecture.md`
- `docs/production/current_state.md`
- `docs/production/risk_register.md`

### Ownership Or Co-op Semantics
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/canon/society_constitution.md`
- `docs/design/architecture.md`
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

## Open Questions That Must Not Be Silently Decided In Code
- exact implementation boundary between player `coins` state and the `item/coin` content concept
- exact saved-state ownership split for real interactions
- exact tree and deed semantics across personal vs future household scope
- minimum co-op proof required before calling the slice parent-child readable
- exact NPC boundary between systemic feedback and text-heavy commentary

## Final Rule
Do not start coding from partial context.
