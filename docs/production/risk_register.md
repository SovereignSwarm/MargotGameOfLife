# Risk Register

## Purpose
This document is the repo's living early-warning register. It exists to catch structural weakness before it becomes design debt, save debt, or content debt during early pre-production and first-playable development.

## Core Rule
Identify and reinforce structural weaknesses before they become design debt, save debt, or content debt.

## How To Use This Register
- consult it before major Codex or Cursor implementation passes
- consult it before save-impacting changes
- consult it at milestone transitions
- consult it during brutal review passes
- use `roadmap.md` to understand when a risk becomes likely
- use `backlog.md` to capture reinforcement work
- use `development_operating_model.md` for the gates and workflow this register sharpens

## Risk Rating Model
- **Likelihood**: Low / Medium / High
- **Impact**: Low / Medium / High
- **Detection**: Easy / Moderate / Hard
- **Status**: Active / Watch / Later / Mitigated

Notes:
- `Likelihood` is how likely the risk is to show up soon.
- `Impact` is how expensive it is if ignored.
- `Detection` is how easy it is to notice before damage spreads.
- `Status` is the current operating posture.

## Risk Categories
- **Canon drift**: implementation or planning starts violating permanent game meaning.
- **Ontology drift**: new classes, namespaces, or nouns are invented too casually.
- **Production/process drift**: work begins without the required doc and gate discipline.
- **Content/schema drift**: content records stop following stable schema and ID rules.
- **Runtime architecture drift**: state, systems, and persistence boundaries blur.
- **Save / migration risk**: IDs, save shape, or content references become unstable.
- **Co-op / ownership ambiguity**: personal, household, and civic meanings diverge or blur.
- **Child readability failure**: systems become understandable only through adult explanation.
- **Lore overreach**: lore grows faster than place-based playable meaning.
- **NPC design failure**: villagers become chatter, exposition, or gimmicks instead of systemic actors.
- **AI-agent inconsistency**: tools act from different assumptions than the repo truth.
- **Scope / framework bloat**: scaffolding and speculative abstraction outrun the slice.

## Active Early-Stage Risks
### Casual Canonical ID Churn
- **Risk Name**: Casual Canonical ID Churn
- **Category**: Save / migration risk
- **Why It Matters**: Canonical IDs already exist in data and are expected to become save references. Casual cleanup later becomes migration debt.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Moderate
- **Status**: Active
- **Early Warning Signs**: IDs renamed to "read better"; display names used as references; mismatched doc and data identifiers.
- **Likely Trigger Point**: first serious content cleanup or first playable save
- **Prevention Now**: review and freeze slice IDs before durable saves; use `id_policy.md` as the single naming authority
- **Containment If Triggered**: stop further renames; restore old IDs or add deprecation plus explicit migration before more content lands
- **Owner / Watcher**: Human Owner, Save Watcher

### Schema Drift In Early Content Records
- **Risk Name**: Schema Drift In Early Content Records
- **Category**: Content/schema drift
- **Why It Matters**: Once a few records diverge, every later item, place, project, and NPC becomes slower to normalize.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Easy
- **Status**: Active
- **Early Warning Signs**: similar content uses different fields; ad hoc fields appear; required fields are skipped silently
- **Likely Trigger Point**: first new content pass beyond the starter set
- **Prevention Now**: align the first content records to `content_schema_reference.md` before content volume grows
- **Containment If Triggered**: pause new content additions and normalize existing records first
- **Owner / Watcher**: Schema Watcher, Runtime Watcher

### Muddy Runtime State Boundaries
- **Risk Name**: Muddy Runtime State Boundaries
- **Category**: Runtime architecture drift
- **Why It Matters**: Unclear state ownership creates save pain and makes co-op harder to reason about later.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Moderate
- **Status**: Active
- **Early Warning Signs**: systems read or write across player, household, and civic state without clear rules; personal state access depends on world blobs
- **Likely Trigger Point**: implementing sell, buy, contribute, and first shared-state features
- **Prevention Now**: keep player, household, and civic write paths explicit and review runtime boundary assumptions before feature work expands
- **Containment If Triggered**: freeze new state fields; map current ownership of every saved field; isolate leaked responsibilities before continuing
- **Owner / Watcher**: Runtime Watcher, Save Watcher

### Ownership Scope Ambiguity
- **Risk Name**: Ownership Scope Ambiguity
- **Category**: Co-op / ownership ambiguity
- **Why It Matters**: The game's philosophy depends on clear differences between mine, ours, and town.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Moderate
- **Status**: Active
- **Early Warning Signs**: the same asset or place changes scope without rule; docs and runtime disagree about who owns or benefits
- **Likely Trigger Point**: tree ownership, bridge contribution logic, and especially Milestone 2 household work
- **Prevention Now**: define scope semantics before household implementation and treat ownership-layer review as mandatory
- **Containment If Triggered**: block household-scope changes until semantics and save impact are explicit
- **Owner / Watcher**: Human Owner, Slice Watcher

### NPCs Becoming Text-Heavy Instead Of Systemically Useful
- **Risk Name**: NPCs Becoming Text-Heavy Instead Of Systemically Useful
- **Category**: NPC design failure
- **Why It Matters**: NPCs are supposed to support requests, feedback, trade-offs, and consequence, not become content chatter.
- **Likelihood**: High
- **Impact**: Medium
- **Detection**: Easy
- **Status**: Active
- **Early Warning Signs**: commentary grows faster than state logic; lines exist without requests, reactions, or consequence hooks
- **Likely Trigger Point**: implementing baker and builder commentary in Milestone 1
- **Prevention Now**: require each NPC behavior to map to a request, reaction, trade-off, or consequence
- **Containment If Triggered**: cut exposition-first dialogue and reduce NPC behavior back to systemic feedback primitives
- **Owner / Watcher**: Slice Watcher, Canon Watcher

### Lore Growing Faster Than Playable Place Design
- **Risk Name**: Lore Growing Faster Than Playable Place Design
- **Category**: Lore overreach
- **Why It Matters**: This project already has strong lore scaffolding. If place-based playable meaning lags, the repo drifts toward decorative worldbuilding.
- **Likelihood**: High
- **Impact**: Medium
- **Detection**: Easy
- **Status**: Active
- **Early Warning Signs**: new customs, mysteries, or motifs appear without attached places, projects, creatures, or visible consequence
- **Likely Trigger Point**: new district, creature, or mystery planning before Orchard and Bridge is proven
- **Prevention Now**: only add lore when it is attached to a place, project, route, creature behavior, or visible world response
- **Containment If Triggered**: defer lore growth until the related playable place or system exists
- **Owner / Watcher**: Canon Watcher, Human Owner

### New Content Categories Invented Too Easily
- **Risk Name**: New Content Categories Invented Too Easily
- **Category**: Ontology drift
- **Why It Matters**: Early ontology drift creates long-term category debt and makes additive growth harder.
- **Likelihood**: Medium
- **Impact**: High
- **Detection**: Moderate
- **Status**: Watch
- **Early Warning Signs**: proposals for new namespaces or one-off classes like "business," "quest system," or special district-only types
- **Likely Trigger Point**: first district expansion or first judgment or information mechanic
- **Prevention Now**: force new proposals through `core_ontology.md` first and prefer combinations over new categories
- **Containment If Triggered**: reject the new category, remap the feature to existing ontology, and clean docs before it spreads
- **Owner / Watcher**: Canon Watcher

### Vertical Slice Content Invalidated By Later Expansion
- **Risk Name**: Vertical Slice Content Invalidated By Later Expansion
- **Category**: Canon drift
- **Why It Matters**: If Orchard and Bridge becomes disposable tutorial debris, additive growth has already failed.
- **Likelihood**: Medium
- **Impact**: High
- **Detection**: Hard
- **Status**: Watch
- **Early Warning Signs**: later content is described as a replacement tier; starter assets become fake or meaningless; Orchard and Bridge is called "beginner-only"
- **Likely Trigger Point**: Milestone 3 district planning and later content-chain additions
- **Prevention Now**: require expansion proposals to explain how apples, pies, the tree, and the bridge stay meaningful
- **Containment If Triggered**: rebalance or reframe later content so it extends rather than erases the starter loop
- **Owner / Watcher**: Human Owner, Slice Watcher

### Co-op Treated As Two Solo Players Sharing Space
- **Risk Name**: Co-op Treated As Two Solo Players Sharing Space
- **Category**: Co-op / ownership ambiguity
- **Why It Matters**: The project's social frame is private parent-child co-op, not parallel single-player.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Moderate
- **Status**: Active
- **Early Warning Signs**: shared world but no shared trade-offs; no meaningful household layer; both players just run isolated loops
- **Likely Trigger Point**: multiplayer implementation that stops at shared map presence
- **Prevention Now**: keep Milestone 2 ownership goals visible while implementing Milestone 1 and review features for shared consequence
- **Containment If Triggered**: stop calling the feature "co-op complete" and re-anchor on household and shared-scope decisions
- **Owner / Watcher**: Human Owner, Slice Watcher

### Implementation Beginning Outside The Milestone 1 Acceptance Gate
- **Risk Name**: Implementation Beginning Outside The Milestone 1 Acceptance Gate
- **Category**: Production/process drift
- **Why It Matters**: This is the fastest path to vague passes, repeated rewrites, and AI-generated churn disguised as progress.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Easy
- **Status**: Active
- **Early Warning Signs**: backlog item implemented directly from chat; `milestone_1_acceptance_criteria.md` is not referenced; no feature-level proof of success; unclear stop condition
- **Likely Trigger Point**: any major Codex or Cursor pass on Milestone 1 items
- **Prevention Now**: use `docs/design/milestone_1_acceptance_criteria.md` as the implementation gate for Milestone 1 work
- **Containment If Triggered**: stop the pass, reconcile the work against the acceptance doc, backfill the missing criteria mapping, and resume only when the gate is explicit
- **Owner / Watcher**: Production Watcher, Human Owner

### AI Tools Drifting From Repo Truth
- **Risk Name**: AI Tools Drifting From Repo Truth
- **Category**: AI-agent inconsistency
- **Why It Matters**: Multiple AI tools are already part of the workflow, and drift creates parallel truths fast.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Hard
- **Status**: Active
- **Early Warning Signs**: proposals contradict canon or production docs; IDs and scopes differ across passes; undocumented decisions appear in code or chat only; major tasks end without a post-task sync and leave current_state, backlog, or decision_log stale
- **Likely Trigger Point**: long prompt chains, partial doc reading, or implementation started from memory instead of repo truth
- **Prevention Now**: require `docs/README.md`, `docs/production/current_state.md`, and `docs/production/codex_workflow.md` first, then read canon before design and production, and keep authority order explicit in prompts
- **Containment If Triggered**: run a brutal reconciliation pass against canon, design, and production; reject ungrounded changes; restate the current source of truth
- **Owner / Watcher**: Human Owner, AI Workflow Watcher

### First Saves Created Before Migration Discipline Is Real
- **Risk Name**: First Saves Created Before Migration Discipline Is Real
- **Category**: Save / migration risk
- **Why It Matters**: Save versions and migrations exist, but they are still early scaffolding without smoke-test proof.
- **Likelihood**: High
- **Impact**: High
- **Detection**: Moderate
- **Status**: Active
- **Early Warning Signs**: live saves created before smoke checks; version fields exist but are not actively reviewed; save-impacting changes land without migration notes
- **Likely Trigger Point**: first playable runtime that writes meaningful world and player state
- **Prevention Now**: smoke-test save/load and migration entry points before any save is treated as durable
- **Containment If Triggered**: mark early saves disposable; freeze save-impacting changes; add migration discipline before expanding feature work
- **Owner / Watcher**: Save Watcher, Runtime Watcher

## Stage-Specific Risk Hotspots
### Milestone 0 - Canon and Repo Foundation
- Casual canonical ID churn
- Schema drift in early content records
- Muddy runtime state boundaries
- AI tools drifting from repo truth

### Milestone 1 - Orchard and Bridge
- Implementation beginning outside the Milestone 1 acceptance gate
- NPCs becoming text-heavy instead of systemically useful
- First saves created before migration discipline is real
- Child-readable visible consequence weakening into abstract progress

### Milestone 2 - Shared Household Layer
- Ownership scope ambiguity
- Co-op treated as two solo players sharing space
- Save-shape expansion without clear household semantics
- Personal / household / civic boundary leakage

### Milestone 3 - First District Expansion
- New content categories invented too easily
- Vertical slice content invalidated by later expansion
- Lore growing faster than playable place design
- Schema drift across district-specific content

### Milestone 4 - First True Judgment / Information Loop
- NPC partial perspective turning into chatter or overcomplexity
- Information systems becoming opaque before child-legible
- Trust or reputation semantics drifting without save discipline
- Wonder-tier readability collapsing under Systems-tier mechanics

## Problems To Solve Now, Not Later
- tighten the first content records against `content_schema_reference.md`
- use `docs/design/milestone_1_acceptance_criteria.md` as the implementation gate before Milestone 1 implementation passes
- lock explicit personal, household, and civic ownership semantics before Milestone 2
- smoke-test save/load plus migration entry points before first durable saves
- review and freeze the starter canonical IDs before feature work makes them expensive to change

## Decision Gates Tied To Risk
### Before Adding New Content
- Does it fit an existing ontology category and schema shape?
- What is its canonical ID and scope?
- How does it preserve Orchard and Bridge as meaningful starter content?

### Before Changing Schemas
- Which existing records break or need defaults?
- Is the change additive or semantic?
- Does save or content versioning need attention?

### Before Renaming IDs
- Is the rename truly unavoidable?
- What saves, docs, or data references are affected?
- What migration or deprecation path exists?

### Before Adding Household Scope
- What belongs to personal, household, and civic layers?
- Who decides, benefits, and maintains it?
- Where is it stored in save state?

### Before Introducing A New District
- Which permanent loops and ontology categories does it reuse?
- What visible shared consequence does it add?
- How does it avoid obsoleting the starter slice?

### Before Introducing A New Information Or Judgment Mechanic
- What is readable at Wonder first?
- Which existing information structure does it use?
- How does it create fair uncertainty without hiding cause and effect?

## Review Cadence
- before major Codex passes
- before any save-impacting change
- at every roadmap milestone transition
- during regular brutal review passes

If a risk changes status, update this register in the same pass that discovered the shift.

## Exit Criteria For The Highest-Risk Items
### Casual Canonical ID Churn
- starter slice IDs are reviewed and treated as frozen
- any unavoidable rename requires explicit deprecation or migration handling

### Schema Drift In Early Content Records
- current starter records align with the schema reference or have documented intentional exceptions
- new content additions stop introducing ad hoc record shapes

### Muddy Runtime State Boundaries
- every saved field has a clear owner layer
- player, household, and civic state paths are explicit and reviewed before feature expansion

### Implementation Beginning Outside The Milestone 1 Acceptance Gate
- Milestone 1 feature work cites `docs/design/milestone_1_acceptance_criteria.md` before implementation begins
- backlog items are no longer interpreted directly from vague chat intent

### First Saves Created Before Migration Discipline Is Real
- save/load smoke checks exist
- `save_version` and `content_version` round-trip cleanly
- save-impacting changes are reviewed against the migration policy before more durable saves are created

## Explicit Anti-Goals
- reactive firefighting culture
- invisible structural debt
- "we'll fix it later" save architecture
- cute but brittle lore growth
- AI-generated drift disguised as progress
- feature work outrunning foundations

## Final Rule
Harden the weak point before building on top of it.
