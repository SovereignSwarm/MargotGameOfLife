# Production-Scale Phase Plan

## Purpose
This document defines the ordered production-scale path from foundation hardening through the first meaningful expansion phases. It exists to make sequencing, bottlenecks, and reinforcement work clear before later-phase problems become expensive.

## Core Rule
The project must scale by ordered additive phases, not by solving later-phase problems inside early-phase implementation.

## Why This Document Exists
- `roadmap.md` defines milestone intent and proof of success.
- `backlog.md` defines near-term actionable work.
- `development_operating_model.md` defines how work is done safely.
- `risk_register.md` defines what can go wrong and what to watch.

This document explains when major categories of work should happen, what each phase must produce, and what structural problems must be solved before moving on.

## Ordered Production Phases
### Phase 0 - Foundation Lock
- **Goal**: harden IDs, schemas, ownership semantics, save discipline, and Milestone 1 completion standards
- **Why it comes now**: the repo is still here; current active risks say broader implementation is premature
- **What must already be true before entering it**: the current canon, design, and production stack exists; starter content and runtime scaffold exist
- **What outputs it should produce**:
  - frozen starter IDs
  - starter records aligned to the schema reference
  - Milestone 1 acceptance criteria
  - save/load and migration smoke-check posture
  - explicit current ownership semantics
- **What it must not try to solve yet**:
  - shipping the full slice
  - household gameplay
  - districts
  - judgment or information systems
  - polish

### Phase 1 - First Truth / Orchard and Bridge
- **Goal**: implement the smallest complete production, saving, ownership, and civic loop and prove it is legible
- **Why it comes now**: once the foundation is locked, the project needs one true playable proof
- **What must already be true before entering it**:
  - Phase 0 outputs are in place
  - Milestone 1 acceptance criteria are explicit
- **What outputs it should produce**:
  - the ten Milestone 1 features working to their acceptance gates
  - visible bridge progress and completion
  - child-readable value flow
  - simple NPC feedback tied to state
- **What it must not try to solve yet**:
  - household gameplay
  - deeper market simulation
  - advanced NPC intelligence
  - content expansion

### Phase 2 - Shared Life
- **Goal**: make co-op feel meaningfully shared through explicit household semantics and at least one real shared trade-off
- **Why it comes now**: private parent-child co-op is core, and this meaning cannot be bolted on after expansion
- **What must already be true before entering it**:
  - Phase 1 is complete enough that Orchard and Bridge is playable and stable
  - personal and civic semantics are already legible
- **What outputs it should produce**:
  - clear personal vs household vs civic distinction in play
  - one household-level trade-off
  - safe state shape for shared ownership
- **What it must not try to solve yet**:
  - deep institutions
  - town politics
  - profession explosion
  - district expansion

### Phase 3 - Additive Expansion Proof
- **Goal**: prove the game can grow by adding one district without invalidating the original slice
- **Why it comes now**: additive growth is a core promise and must be proven before broader scaling
- **What must already be true before entering it**:
  - Orchard and Bridge still matters
  - household semantics are stable enough not to force rewrites
  - content schemas are strong enough for a second content chain
- **What outputs it should produce**:
  - one new district
  - one new specialist
  - one new civic project or structure
  - one new content chain that reuses existing loops
- **What it must not try to solve yet**:
  - many districts
  - full economy layering
  - broad creature systems
  - major systemic rewrites

### Phase 4 - Judgment and Information
- **Goal**: introduce incomplete information, conflicting advice, and consequence without breaking child readability
- **Why it comes now**: judgment should deepen an already-working world, not replace basic legibility
- **What must already be true before entering it**:
  - base loops and one expansion proof are stable
  - NPCs already function as systemic feedback
- **What outputs it should produce**:
  - one hint, rumor, or record path
  - one commission or dilemma with incomplete information
  - one trust or consequence loop with visible downstream effect
- **What it must not try to solve yet**:
  - opaque simulation
  - adult-only abstraction
  - deep reputation webs
  - high-complexity NPC cognition

### Phase 5 - Durable World Layer
- **Goal**: make the world feel more persistent and layered across places, assets, social memory, and longer-term consequences
- **Why it comes now**: persistence should deepen an already-proven readable game rather than complicate a fragile one
- **What must already be true before entering it**:
  - additive expansion works
  - judgment systems are legible
  - save discipline is reliable enough for longer-lived state
- **What outputs it should produce**:
  - stronger place persistence
  - richer asset consequences over time
  - simple durable social or world-state carryover
- **What it must not try to solve yet**:
  - inheritance systems
  - taxes or governance layers
  - large-scale simulation
  - public-online features

### Phase 6 - Product Hardening
- **Goal**: make the game durable, maintainable, and honest enough to support broader content growth or external playtesting
- **Why it comes now**: hardening too early becomes framework theater; too late becomes expensive cleanup
- **What must already be true before entering it**:
  - prior phases proved the game's core loops, co-op meaning, additive growth, and judgment depth
- **What outputs it should produce**:
  - stronger save compatibility discipline
  - cleaner data and implementation boundaries
  - broader content-readiness and testing discipline
  - product-level stability and clarity
- **What it must not try to solve yet**:
  - MMO assumptions
  - giant tooling or service architecture
  - speculative platform scaling

## Cross-Phase Dependencies
- **IDs**: must stabilize before saves and content volume grow.
- **Schemas**: must hold across Orchard and Bridge before district expansion.
- **Save/migration discipline**: must be proven before the first durable world layer.
- **Ownership semantics**: must be explicit before Shared Life and before any household or later district interactions.
- **Child-legibility**: must remain true at every phase gate, not just Phase 1.
- **Additive content rules**: must protect Orchard and Bridge from obsolescence as phases expand.
- **Co-op readability**: must be preserved from Phase 1 through later household and district work.

## Predicted Bottlenecks By Phase
### Phase 0
- starter ID freezing drifting into late renames
- schema normalization lagging behind content changes
- ownership semantics remaining too vague
- save smoke-checks not happening before coding pressure increases

### Phase 1
- visible consequence weakening into internal state only
- NPC commentary drifting into chatter
- coin and item authority becoming inconsistent
- bridge completion and save state getting out of sync

### Phase 2
- household semantics bolted onto a player-only state model
- co-op reading as two solo loops
- ownership benefits and responsibilities getting muddy
- save shape expansion causing migration friction

### Phase 3
- second district forcing schema or ontology rewrites
- starter content becoming spiritually obsolete
- content definitions proliferating faster than structure
- lore expanding faster than playable places

### Phase 4
- information systems becoming opaque too early
- NPC partial perspective becoming complexity theater
- trust or reputation semantics drifting without stable save meaning
- adult-readable strategy overwhelming Wonder readability

### Phase 5
- durable world state becoming too implicit
- persistence depth forcing refactors across older slice logic
- old places and assets not keeping meaning over time
- social or world memory expanding faster than tooling discipline

### Phase 6
- hardening work being mistaken for feature expansion
- save compatibility debt surfacing too late
- content scale exposing weak doc or code boundaries
- structure cleanup competing with ongoing content demand

## Failure Modes To Anticipate Early
- starter content becoming obsolete instead of remaining humble but meaningful
- household semantics being bolted on too late
- district expansion forcing schema or ontology rewrites
- lore outrunning place-based play
- NPC systems outgrowing legibility
- save state becoming too implicit
- co-op remaining spatially shared but not meaningfully shared
- later layers introducing abstractions children cannot read at first contact

## Reinforcement Moves To Do Before Each Phase
### Before Phase 0
- no extra reinforcement section beyond current repo truth; Phase 0 is already active

### Before Phase 1
- freeze starter canonical IDs
- align starter records to the schema reference
- lock explicit current ownership semantics
- smoke-test save/load and migration entry points
- use Milestone 1 acceptance criteria as the implementation gate

### Before Phase 2
- confirm Milestone 1 is truly complete, not partially playable
- map which current assets and places can become household scope later
- define one real household trade-off before implementation
- review save impact of any new shared state

### Before Phase 3
- prove Orchard and Bridge still matters after Shared Life changes
- review schemas against second-district needs before adding content
- reject any need for new ontology categories unless repeated across content
- define district success in additive, not replacement, terms

### Before Phase 4
- verify NPCs already function as requests and reactions rather than chatter
- keep information structures grounded in observation, hint, rumor, record, or feedback
- define one bounded judgment loop before adding multiple information systems
- check Wonder readability before Systems readability

### Before Phase 5
- confirm save and migration discipline is already reliable under existing content
- identify which world and social states truly need durability
- avoid adding persistence to systems whose semantics are still unstable
- review older slice content for long-term meaning preservation

### Before Phase 6
- stop adding speculative layers and audit existing structural debt first
- review save compatibility posture end to end
- tighten doc and code boundaries where content growth exposed ambiguity
- decide what "stable enough for broader testing" actually means

## Phase Exit Conditions
### Phase 0
- starter IDs, schema alignment, ownership semantics, save smoke checks, and Milestone 1 acceptance criteria are explicit enough to begin implementation safely

### Phase 1
- Orchard and Bridge is fully implemented to its acceptance criteria and reads clearly to both child and co-op play

### Phase 2
- players can feel the difference between personal, household, and civic scope without explanation-heavy scaffolding

### Phase 3
- one new district proves additive growth without invalidating the original slice

### Phase 4
- one bounded information or judgment loop works without breaking child readability

### Phase 5
- the world carries more durable consequences without forcing unclear or brittle state semantics

### Phase 6
- the project is structurally stable enough to support broader content growth or external testing without hidden debt dominating progress

## What Should Stay Deferred
- public-online or MMO assumptions
- taxes, inheritance, governance, and other abstract social systems
- advanced NPC intelligence
- opaque economy simulation
- large-scale district proliferation
- broad creature-system growth not tied to places and care
- framework-heavy architecture not earned by current bottlenecks
- polish-first work before legibility and structure are proven

## How To Use This Plan
- `current_state.md` tells you where the repo is today.
- `roadmap.md` tells you the official milestones and success proofs.
- `backlog.md` tells you the next near-term actions.
- `risk_register.md` tells you what can go wrong now.
- This doc tells you what phase should come next, what it depends on, and what must be reinforced before moving forward.

## Final Rule
Solve the next scale problem before it becomes the current one.
