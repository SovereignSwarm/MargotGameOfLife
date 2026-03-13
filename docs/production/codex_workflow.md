# Codex Workflow

## Purpose
This document defines how Codex should operate inside MargotGameOfLife so each pass starts from repo truth, stays inside the current milestone, and leaves the repo more synchronized instead of more fragmented.

## Core Rule
Codex should execute inside a stable repo operating model, not improvise project truth.

## When To Use Codex
- repo-grounded doc creation or updates
- production hardening and workflow tightening
- repo coherence audits and post-task sync passes
- implementation scaffolds and structural clarification inside the current milestone
- Milestone 1 work that is already bounded by `docs/design/milestone_1_acceptance_criteria.md`
- small runtime or doc alignment fixes that do not change canon or widen scope

## When Not To Use Codex Alone
- changing canon meaning or constitutional rules
- changing roadmap direction or milestone boundaries
- changing ownership semantics across personal, household, and civic scope
- changing save-shape meaning or migration policy by implication instead of explicit review
- resolving the open `player coins` versus `item/coin` concept boundary without deliberate design treatment
- making any scope-expanding decision that changes project truth rather than implementing it

## Standard Codex Task Types
- **Canon or design doc work**: create or tighten bounded docs without rewriting stable meaning casually.
- **Production hardening**: improve IDs, saves, schemas, navigation, risk handling, and workflow discipline.
- **Repo coherence audit**: check for stale references, missing links, authority drift, and cross-doc contradictions.
- **Implementation scaffold**: add or clarify small structure without adding new gameplay scope.
- **Post-task doc sync**: update only the genuinely affected navigation, state, risk, and decision surfaces after major work.
- **Milestone-specific work**: implement or tighten work that already has an explicit milestone boundary and acceptance gate.

## Standard Read Order
Default first read:
1. `README.md`
2. `AGENTS.md`
3. `docs/README.md`
4. `docs/production/current_state.md`
5. `docs/production/codex_workflow.md`
6. `docs/canon/game_constitution.md`
7. `docs/canon/core_ontology.md`
8. `docs/design/v1_vertical_slice.md`
9. `docs/design/architecture.md`
10. `docs/design/milestone_1_acceptance_criteria.md` when touching Milestone 1 implementation
11. task-specific production docs after that

Task-specific read paths:

### Code Changes
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/design/v1_vertical_slice.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_acceptance_criteria.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

### ID, Save, Or State Changes
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/design/architecture.md`
- `docs/production/risk_register.md`

### Ownership Or Co-op Changes
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`
- `docs/canon/society_constitution.md`
- `docs/design/architecture.md`
- `docs/production/risk_register.md`

### Content Additions
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/core_ontology.md`
- `docs/production/content_schema_reference.md`
- `docs/design/v1_vertical_slice.md`
- `docs/production/backlog.md`

### Lore Changes
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/canon/lore_constitution.md`
- `docs/canon/vision.md`
- `docs/canon/game_constitution.md`
- `docs/canon/core_ontology.md`

### Roadmap, Backlog, Or Production Planning Changes
- `docs/production/current_state.md`
- `docs/production/codex_workflow.md`
- `docs/production/roadmap.md`
- `docs/production/production_scale_phase_plan.md`
- `docs/production/backlog.md`
- `docs/production/risk_register.md`
- `docs/production/development_operating_model.md`
- `docs/production/decision_log.md`

## Standard Output Contract
Every substantial Codex pass should report:
- what changed
- what docs were relied on
- whether IDs were affected
- whether saves were affected
- whether ownership scopes were affected
- what remains unresolved
- whether a post-task documentation sync is still needed

## Post-Task Documentation Sync Rule
The sync pass is mandatory after any substantial design, production, architecture, implementation, milestone-planning, or repo-coherence task.

Always check:
- `README.md`
- `AGENTS.md`
- `docs/README.md`
- `docs/production/README.md`
- `docs/production/current_state.md`
- `docs/production/backlog.md`
- `docs/production/roadmap.md`
- `docs/production/risk_register.md`
- `docs/production/development_operating_model.md`
- `docs/production/decision_log.md`
- directly impacted design or production docs from the completed task

Update only the docs that are genuinely affected.

Use `.agents/skills/post_task_doc_sync/SKILL.md` when the task fits that workflow.

## Plan Mode Guidance
- Use Plan mode for canon, design, or production restructuring; ownership or save questions; milestone planning; multi-file audits; or any task with unresolved scope or meaning.
- Plan mode is usually unnecessary for tiny bounded wording fixes, current-path corrections, or other small edits inside already-explicit docs and gates.

## Anti-Drift Rules
- Never improvise project truth from memory or chat alone.
- Never start code from partial context.
- Never silently decide open ownership, save, or economy-boundary questions in runtime code.
- Never treat Milestone 1 work as done without `docs/design/milestone_1_acceptance_criteria.md`.
- Never finish a substantial task without a post-task documentation sync pass.

## Final Rule
Read from repo truth, work inside repo truth, leave repo truth synchronized.
