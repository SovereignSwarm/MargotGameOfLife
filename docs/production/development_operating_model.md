# Development Operating Model

## Purpose
This document defines how MargotGameOfLife moves from idea to playable change without losing canon, child readability, save safety, or structural clarity. It is the working rulebook for turning a long-lived game vision into small safe steps.

## Core Operating Rule
The game must grow by disciplined additive development, not by uncontrolled feature invention, framework building, or conceptual replacement.

## What This Model Protects
- **Long-term game identity**: canon stays stable while new content deepens the same world.
- **Child legibility**: the game must remain readable to a bright young child before it becomes deep for older players.
- **Additive growth**: new work should extend existing verbs, loops, entities, and lore rather than invalidate them.
- **Save safety**: IDs, state shape, and migration boundaries must be treated as long-lived assets.
- **AI-agent coherence**: humans and AI tools should act from the same repo truth instead of inventing parallel interpretations.
- **Practical shippability**: each step should make the game more playable, inspectable, and maintainable rather than more impressive on paper.

## Development Phases
- **Canon**: define permanent meaning. Outputs belong in `docs/canon/`. Do not put slice-only rules here.
- **Design**: define the current playable expression of canon. Outputs belong in `docs/design/`. Do not smuggle permanent worldview changes in through design docs.
- **Production Planning**: define roadmap, backlog, IDs, schemas, save policy, and decision records. Outputs belong in `docs/production/`. Do not turn this into process theater.
- **Runtime Scaffolding**: create clear implementation boundaries, placeholder-safe state, and stable data shapes. Outputs belong in runtime structure and scaffolds. Do not expand gameplay scope here.
- **Vertical Slice**: make one bounded playable loop real and legible. Outputs are small complete features, not future-facing abstractions.
- **Expansion**: add districts, assets, projects, professions, creature layers, or information layers by reusing canon and existing structures. Do not replace starter content.
- **Balance and Legibility**: tune clarity, pacing, visible consequence, and co-op readability. Do not hide unclear systems behind numbers.
- **Migration / Compatibility Hardening**: protect saved state, IDs, and additive growth as the project matures. Do not leave save-impacting changes undocumented.

## Artifact Ladder
Normal order before code:
1. constitution or canon rule
2. ontology fit
3. progression-tier fit
4. system constitution
5. design spec
6. schema or data shape
7. acceptance criteria
8. implementation scaffold

Compression is allowed only for tiny, obviously local changes that do not touch canon, ontology, save behavior, ID stability, or milestone boundaries.

## Change Classes
- **Canon change**: changes permanent meaning, identity, ontology, or constitutional rules. Matters because it affects all future work. Requires explicit human review and related canon updates first.
- **Design change**: changes the current expression of the game without redefining permanent meaning. Matters because it shapes the slice and near-term implementation. Requires design review against canon and milestone scope.
- **Content addition**: adds new instances of existing categories such as items, places, assets, projects, NPCs, or events. Matters because content can still create drift or save risk. Requires ontology, tier, and additive-growth review.
- **Implementation refactor**: changes structure, boundaries, or internals without intended behavior expansion. Matters because refactors can quietly change save shape or future flexibility. Requires scope and save-risk review.
- **Balancing change**: changes values, pacing, visibility, or tuning inside existing mechanics. Matters because balance can break child readability or loop meaning. Requires legibility and consequence review.
- **Save-impacting change**: changes IDs, serialized state, scope semantics, migration expectations, or content references used by saves. Matters because casual mistakes become long-term drag. Requires migration notes and explicit human review.

## Tooling Roles
- **ChatGPT**: best for canon and design synthesis, framing decisions, reviewing language, and spotting risks. Do not trust it alone for repo truth or file mutation.
- **Codex**: best for repo-grounded planning, refactors, structure work, and doc-code alignment. Do not trust it alone to set product direction or redefine canon.
- **Cursor**: best for fast local editing and iteration inside already-made decisions. Do not trust it alone to invent canon, bypass gates, or widen scope.
- **GitHub / git**: best for history, diffs, commit discipline, rollback context, and review visibility. Do not confuse source control with design judgment.
- **Luanti runtime**: best for proving the current slice and checking whether the game feels legible in practice. It is the current runtime target, not the owner of game meaning.

## Stage Gates
- **Constitution fit**: does this change obey the constitutions? Failure means it replaces worldview, weakens core verbs, or breaks permanent rules.
- **Ontology fit**: does this fit existing categories cleanly? Failure means it invents new nouns because a feature feels special.
- **Comprehension-tier fit**: is the feature readable at Wonder before asking for Strategy or Systems thinking? Failure means depth arrives before clarity.
- **Ownership-layer fit**: is the change clear about personal, household, or civic scope? Failure means benefits, responsibilities, or consequences become muddy.
- **Child-legibility fit**: can a bright young child see what happened and why it matters? Failure means the system only works for adults reading abstractions.
- **Additive-growth fit**: does this extend the game without invalidating earlier content? Failure means old content becomes fake, disposable, or spiritually obsolete.
- **Save-risk review**: does this touch IDs, state shape, migrations, or serialized meaning? Failure means save implications are unclear or undocumented.
- **Implementation-scope review**: is this the smallest change that proves the need? Failure means framework growth, speculative systems, or milestone sprawl.

## Definitions of Done
- **Canon doc**: done when it reduces ambiguity, aligns with higher canon, and gives future contributors a durable rule rather than an opinion.
- **Design doc**: done when it is bounded, slice-specific, canon-aligned, and concrete enough to implement without inventing major new decisions.
- **Schema or template**: done when stable IDs, required fields, scope implications, and save implications are clear.
- **Implementation scaffold**: done when boundaries are explicit, placeholder-safe, and future work has a clean place to go.
- **Vertical slice feature**: done when the intended player-facing loop works, the visible consequence is legible, and the change respects milestone scope.
- **Save-safe refactor**: done only when IDs, state shape, migration impact, and compatibility posture are explicitly reviewed.

## Testing Layers
- **Mechanical correctness**: does the feature or refactor behave as intended?
- **Concept correctness**: does it still express the game's actual philosophy and loop meaning?
- **Child readability**: can a child tell what happened, what changed, and what is possible next?
- **Parent-child co-op readability**: does shared play feel collaborative rather than like two isolated users in one map?
- **World-consequence visibility**: can players see the result in place, access, beauty, workflow, or social response?
- **Expansion safety**: does the change leave room for future districts, projects, and content without rewrite pressure?
- **Save/migration safety**: can old data survive the change cleanly, or is the impact explicitly handled?

## Risk Categories
- **Design drift**: the game starts saying one thing in canon and another in practice.
- **Implementation drift**: runtime structure grows away from documented boundaries and stable IDs.
- **Content bloat**: too many nouns, records, or slice ideas arrive before they earn their place.
- **Save compatibility**: casual renames or state changes create long-term pain.
- **Multiplayer complexity**: private co-op grows toward synchronization or ownership problems before the slice is solid.
- **Child UX confusion**: the game becomes understandable only after explanation.
- **Lore overreach**: worldbuilding grows faster than place-based playable meaning.
- **AI-agent inconsistency**: different tools produce different truths because the repo rules were not followed.
- **Opaque systems**: value, consequence, and trade-offs become hard to see.

## Common Early Failure Modes
- too many nouns before schemas
- IDs changing casually because they "read better"
- runtime state leaking everywhere instead of staying bounded
- NPCs becoming chatter instead of systems
- lore growing faster than playable place design
- co-op becoming two isolated players in the same world
- early content being invalidated by later systems
- speculative abstractions appearing before the first loop feels good
- production docs lagging behind save-affecting changes
- implementation work smuggling in canon changes without review

## Expansion Policy
After the first slice, expand by adding new districts, assets, professions, projects, creature layers, and social systems that reuse existing canon categories and repo structures. New work should make Orchard and Bridge feel like true starter content, not obsolete tutorial debris.

Protect wonder-tier readability while adding depth. New layers should introduce better judgment, richer place meaning, and broader interdependence without demanding heavier abstraction at the point of first contact.

## Escalation Rules
- **Update canon docs** when a change affects permanent meaning, lore, ontology, comprehension tiers, or constitutional rules.
- **Update production docs** when a change affects roadmap intent, IDs, schemas, save policy, decision records, or working process.
- **Add migration notes** when a change affects serialized state, canonical IDs, scope semantics, or saved references.
- **Require explicit human review** for canon changes, save-impacting changes, ownership-layer changes, milestone-boundary changes, and any change that risks replacing rather than extending the game.

## Working Rhythm
Foundation first. One baby step at a time. Keep commits small and intention-revealing. Write or tighten docs before major implementation changes. Use direct-to-`main` only after consciously checking the required gates. End every substantial design, production, architecture, or implementation pass with a post-task documentation sync. Run regular brutal review passes that cut drift, shrink scope, and force clarity before the repo gets bigger.

## Explicit Anti-Goals
- scope-chaotic prototype swamp
- AI-generated feature sprawl
- giant framework before fun
- child-inaccessible systems
- lore-first / play-later drift
- fragile save architecture
- public-MMO thinking
- process-heavy overhead that slows real progress

## Final Rule
Build the next small true thing without breaking the larger one.
