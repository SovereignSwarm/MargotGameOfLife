This file matters a lot. It is your repo brain for Codex/Cursor.

# AGENTS.md

## Project Role
You are working on MargotGameOfLife, a parent-child co-op village life sim built for Luanti.

## Authority
- `docs/canon/game_constitution.md` is the highest design authority.
- Canon beats design.
- Design beats runtime placeholders.
- Production governs IDs, saves, risk, and implementation discipline.

## Required Read Order
1. `docs/README.md`
2. `docs/production/current_state.md`
3. `docs/canon/game_constitution.md`
4. `docs/canon/core_ontology.md`
5. `docs/design/v1_vertical_slice.md`
6. `docs/design/architecture.md`
7. Read task-specific docs before changing anything risky.

## Read By Task
### Before Changing Code
- `docs/production/current_state.md`
- `docs/design/v1_vertical_slice.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_acceptance_criteria.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

### Before Touching IDs, Saves, Or State
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/design/architecture.md`
- `docs/production/risk_register.md`

### Before Adding Content
- `docs/canon/core_ontology.md`
- `docs/production/content_schema_reference.md`
- `docs/design/v1_vertical_slice.md`
- `docs/production/backlog.md`

### Before Changing Ownership Or Co-op Semantics
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/canon/society_constitution.md`
- `docs/design/architecture.md`
- `docs/production/risk_register.md`

### Before Proposing Lore Expansion
- `docs/canon/lore_constitution.md`
- `docs/canon/vision.md`
- `docs/canon/game_constitution.md`
- `docs/production/current_state.md`

### Before Milestone Planning Or Production Sequencing
- `docs/production/current_state.md`
- `docs/production/roadmap.md`
- `docs/production/production_scale_phase_plan.md`
- `docs/production/backlog.md`
- `docs/production/risk_register.md`

## Implementation Pass Output
Every implementation pass should report:

- what changed
- what docs were relied on
- whether IDs, saves, or ownership scopes were affected
- what remains unresolved or intentionally deferred

## Hard Rules
- If the required docs were not read, do not implement.
- Stay inside the current milestone and active priority in `docs/production/current_state.md`.
- For Milestone 1 implementation, use `docs/design/milestone_1_acceptance_criteria.md` as the completion gate.
- Do not widen v1 scope, add speculative systems, or introduce runtime LLM features.
- Keep code small, readable, and explicit. Prefer data-driven definitions and clear state boundaries.
