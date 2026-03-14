# Backlog

This backlog is intentionally near-term. It turns the roadmap and risk register into the next valid steps without duplicating long-range planning.

## Milestone 0 - Canon and Repo Foundation
The Milestone 1 readiness lock is now in place. Do not create more foundation tasks unless a new blocking structural risk appears.

## Milestone 1 - Orchard and Bridge
Milestone 1 may begin only through `docs/production/milestone_1_checklist.md`, `docs/production/milestone_1_implementation_order.md`, and `docs/design/milestone_1_acceptance_criteria.md`.

### Block A - Mechanical Value Loop
- verified end-to-end in-engine on 2026-03-13
- keep frozen at current scope while Block B begins

### Block B - Productive Ownership
- implemented in runtime on 2026-03-13 in a narrow personal-ownership form
- dedicated runtime verification pass completed on 2026-03-13
- starter-surface bootstrap-order fix landed on 2026-03-13; the shared starter strip and shared tree surface now come up through the normal first-join path without leaving Block A bootstrap pending
- honestly verified end-to-end in-engine on 2026-03-13 for normal-path bootstrap, personal purchase, recurring yield, save/load, and two-player separation
- keep frozen at current scope while Block C begins

### Block C - Civic Consequence
- implemented in runtime on 2026-03-13 in a narrow civic-only form
- one shared starter-strip bridge site now turns fixed 5-coin personal contributions into shared civic bridge state
- bridge stages now progress from foundation to framing to complete from saved civic funds, and completion now unlocks the shared `place/bridge` outcome as a visible walkable span
- dedicated Block C verification pass completed on 2026-03-13
- honestly verified end-to-end in-engine on 2026-03-13 for insufficient-funds failure, contribution success, stage progression, completion outcome, save/load round-trip, and shared-civic plus separate-personal co-op behavior
- keep frozen at current scope while Block D begins

### Block D - Reflective Social Layer
- implemented in runtime on 2026-03-13 in a narrow stateless success-only form
- one optional Baker line now appends only on successful `asset/apple_tree` purchase
- one optional Builder line now appends only on first shared bridge contribution, `framing`, and `complete`
- no new save data, ownership scope, or canonical IDs were introduced for Block D
- dedicated Block D verification pass completed on 2026-03-14
- honestly verified end-to-end in-engine on 2026-03-14 for approved success triggers only, ready-tree harvest silence, non-trigger silence, co-op targeting, output shape, and save/load neutrality
- keep frozen at current scope; do not begin broader NPC or dialogue work from this block alone

## Milestone 2 - Shared Household Layer
- first pantry-only implementation landed in runtime on 2026-03-14
- first pantry-only shape is now honestly verified end-to-end in-engine for deposit, withdrawal, shared visibility, save/load round-trip, and two-player household correctness
- one shared starter-strip pantry row now provides explicit `item/apple` deposit, explicit `item/flour` deposit, one shared pantry read, explicit `item/apple` withdrawal, and explicit `item/flour` withdrawal
- `world_state.household.inventory` is now the only live household authority, count-based only, for aggregate `item/apple` and `item/flour` counts
- pantry transfers now use fixed quantity `1` and are intended to be non-partial at the handler and validation level
- `save_version` is now `2`; `content_version` remains `1`
- direct baking from pantry, household `item/pie`, shared coins, shared tree ownership, civic rewrites, and household NPC commentary remain out of scope
- `docs/design/household_reserve_contract.md` now defines the next narrow Milestone 2 step: one derived reserve for `2 apples + 1 flour` plus explicit break-reserve withdrawal, with no new saved fields or broader household scope
- reserve-aware withdrawal is now implemented in runtime: pantry read reports reserve state, surplus withdrawal stays normal, reserve-breaking withdrawal warns first and confirms only on the next same-player same-surface interaction, and confirmation remains unsaved runtime-only state
- dedicated reserve-aware in-engine verification completed on 2026-03-14
- reserve-aware withdrawal is now honestly verified end-to-end in-engine for reserve-ready and reserve-incomplete read output, normal surplus withdrawal, reserve-warning no-op behavior, reserve-break confirmation, confirmation reset on read, deposit, different withdraw surface, leave or rejoin, relaunch, co-op invalidation on changed pantry counts, and save-load neutrality
- keep frozen at current pantry-plus-reserve scope until the next Milestone 2 household step is explicitly documented

## Milestone 3 - First District Expansion
- no active backlog items until the reserve-aware withdrawal step is honestly verified

## Milestone 4 - First True Judgment / Information Loop
- no active backlog items until the reserve-aware withdrawal step is honestly verified
