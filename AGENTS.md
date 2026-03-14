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
1. `README.md`
2. `docs/README.md`
3. `docs/production/current_state.md`
4. `docs/production/codex_workflow.md`
5. `docs/canon/game_constitution.md`
6. `docs/canon/core_ontology.md`
7. `docs/design/v1_vertical_slice.md`
8. `docs/design/architecture.md`
9. `docs/design/milestone_1_ownership_semantics.md` when working on Orchard and Bridge semantics
10. Read task-specific docs before changing anything risky.

## Read By Task
### Before Changing Code
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

### Before Touching IDs, Saves, Or State
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/production/milestone_1_checklist.md`
- `docs/design/architecture.md`
- `docs/production/risk_register.md`

### Before Adding Content
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/core_ontology.md`
- `docs/production/content_schema_reference.md`
- `docs/design/v1_vertical_slice.md`
- `docs/production/backlog.md`

### Before Changing Ownership Or Co-op Semantics
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/canon/society_constitution.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_ownership_semantics.md`
- `docs/production/risk_register.md`

### Before Proposing Lore Expansion
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/lore_constitution.md`
- `docs/canon/vision.md`
- `docs/canon/game_constitution.md`

### Before Milestone Planning Or Production Sequencing
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/roadmap.md`
- `docs/production/production_scale_phase_plan.md`
- `docs/production/milestone_1_implementation_order.md`
- `docs/production/milestone_1_checklist.md`
- `docs/production/backlog.md`
- `docs/production/risk_register.md`
- `docs/production/development_operating_model.md`
- `docs/production/decision_log.md`

### Before Post-Task Documentation Sync
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/README.md`
- `docs/production/backlog.md`
- `docs/production/roadmap.md`
- `docs/production/risk_register.md`
- `docs/production/development_operating_model.md`
- `docs/production/decision_log.md`
- directly impacted design or production docs from the completed task

## Implementation Pass Output
Every implementation pass should report:

- what changed
- what docs were relied on
- whether IDs were affected
- whether saves were affected
- whether ownership scopes were affected
- what remains unresolved or intentionally deferred
- whether a post-task documentation sync is still needed

## Hard Rules
- If the required docs were not read, do not implement.
- Stay inside the current milestone and active priority in `docs/production/current_state.md`.
- For Orchard and Bridge implementation, start with Block A in `docs/production/milestone_1_implementation_order.md` and gate every pass through `docs/production/milestone_1_checklist.md`.
- For Milestone 1 implementation, use `docs/design/milestone_1_acceptance_criteria.md` as the completion gate.
- After any substantial design, production, architecture, or implementation task, perform a post-task documentation sync pass before treating the work as complete.
- Use `.agents/skills/post_task_doc_sync/SKILL.md` for the sync pass when the task fits that workflow.
- For housekeeping or documentation passes, prefer no-op over speculative cleanup and only update docs when repo truth has clearly changed.
- Do not widen v1 scope, add speculative systems, or introduce runtime LLM features.
- Keep code small, readable, and explicit. Prefer data-driven definitions and clear state boundaries.
