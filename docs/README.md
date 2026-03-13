# Docs Map

## Purpose
This folder is the authority map for MargotGameOfLife. Use it to understand what the game is, what the current slice is, and how production changes should be governed.

## Folder Meanings
- `canon/`: permanent identity rules that should survive engine changes and years of additive growth.
- `design/`: the current playable expression of the canon, including the active vertical slice and current architecture shape.
- `production/`: process, roadmap, backlog, IDs, save compatibility, and change-control rules.

## Reading Order
1. `docs/README.md`
2. `docs/canon/vision.md`
3. `docs/canon/game_constitution.md`
4. `docs/canon/core_ontology.md`
5. `docs/canon/progression_by_comprehension_tier.md`
6. `docs/canon/economy_constitution.md`
7. `docs/canon/society_constitution.md`
8. `docs/canon/npc_constitution.md`
9. `docs/design/v1_vertical_slice.md`
10. `docs/design/architecture.md`
11. `docs/production/roadmap.md`
12. `docs/production/backlog.md`
13. `docs/production/id_policy.md`
14. `docs/production/save_compatibility_policy.md`
15. `docs/production/content_schema_reference.md`
16. `docs/production/decision_log.md`

## Authority Map
- Canonical docs: everything under `docs/canon/`
- Design-expression docs: everything under `docs/design/`
- Production and governance docs: everything under `docs/production/`

Within canon:
- `game_constitution.md` defines the permanent design rules.
- `core_ontology.md` defines the stable world grammar.
- the other canon docs refine specific permanent domains and must conform to the constitution.

## Conflict Resolution
- Canon beats design.
- Design beats runtime placeholders.
- Production docs do not overrule canon, but they do govern IDs, saves, migrations, and milestone discipline.
- If code and docs disagree during early pre-production, fix the code unless the docs are clearly stale.

## When Docs Must Be Updated
Update the relevant docs when:
- a permanent design rule changes
- a long-lived content category changes
- a milestone objective or banned scope changes
- a stable ID rule changes
- a save shape or migration expectation changes
- a major runtime boundary changes in a way other contributors must follow

Do not let large design decisions live only in chat, commits, or code.
