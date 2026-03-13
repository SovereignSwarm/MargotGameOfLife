# Docs Map

## Purpose
This folder is the navigation map and authority order for MargotGameOfLife. Use it to understand what the game is, what matters now, and which docs control which decisions.

## Start Here
- Read `docs/README.md` first.
- Then read `docs/production/current_state.md` for the active milestone, current priority, top risks, and approved next baby steps.

## Folder Meanings
- `canon/`: permanent identity rules that should survive engine changes and years of additive growth.
- `design/`: the current playable expression of the canon, including the active slice and runtime shape.
- `production/`: operational docs for milestone control, risk, IDs, saves, schemas, and working discipline.

## Current Reading Order
1. `docs/README.md`
2. `docs/production/current_state.md`
3. `docs/canon/vision.md`
4. `docs/canon/game_constitution.md`
5. `docs/canon/core_ontology.md`
6. `docs/canon/progression_by_comprehension_tier.md`
7. `docs/canon/economy_constitution.md`
8. `docs/canon/society_constitution.md`
9. `docs/canon/npc_constitution.md`
10. `docs/canon/lore_constitution.md`
11. `docs/design/v1_vertical_slice.md`
12. `docs/design/architecture.md`
13. `docs/design/milestone_1_acceptance_criteria.md`
14. `docs/production/README.md`
15. `docs/production/development_operating_model.md`
16. `docs/production/risk_register.md`
17. `docs/production/roadmap.md`
18. `docs/production/production_scale_phase_plan.md`
19. `docs/production/backlog.md`
20. `docs/production/decision_log.md`
21. `docs/production/id_policy.md`
22. `docs/production/save_compatibility_policy.md`
23. `docs/production/content_schema_reference.md`
24. `docs/production/title_strategy.md`

## Read By Task
### Changing Code
- `docs/production/current_state.md`
- `docs/design/v1_vertical_slice.md`
- `docs/design/architecture.md`
- `docs/design/milestone_1_acceptance_criteria.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

### Touching IDs Or Saves
- `docs/production/id_policy.md`
- `docs/production/save_compatibility_policy.md`
- `docs/design/architecture.md`
- `docs/production/current_state.md`
- `docs/production/risk_register.md`

### Adding Content
- `docs/canon/core_ontology.md`
- `docs/production/content_schema_reference.md`
- `docs/design/v1_vertical_slice.md`
- `docs/production/backlog.md`

### Ownership Or Co-op Work
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
- `docs/production/production_scale_phase_plan.md`
- `docs/production/backlog.md`
- `docs/production/development_operating_model.md`
- `docs/production/risk_register.md`

## Authority Order
1. canon
2. design
3. production
4. runtime placeholders
5. chat or commit messages

If code and docs disagree during early pre-production, fix the code unless the docs are clearly stale.

## When To Update Docs
Update the relevant docs when:

- a permanent design rule changes
- a long-lived content category changes
- a milestone objective or banned scope changes
- a stable ID rule changes
- a save shape or migration expectation changes
- a major runtime boundary changes in a way other contributors must follow
- the active milestone changes
- the current production priority changes
- current risks or approved next steps change materially

Do not let large design decisions live only in chat, commits, or code.
