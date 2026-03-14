# Decision Log

## 2026-03-13 ADR-001 Luanti Is The Current Runtime
- Status: Accepted
- Decision: Luanti is the current implementation target.
- Consequence: runtime code should stay simple, explicit, and replaceable; game meaning stays in docs rather than engine assumptions.

## 2026-03-13 ADR-002 Private Co-op Is Core
- Status: Accepted
- Decision: private co-op is core; public-online-first design is not.
- Consequence: optimize for 1-2 players sharing a world, not MMO scale or stranger-social loops.

## 2026-03-13 ADR-003 No Runtime LLM Dependency In V1
- Status: Accepted
- Decision: v1 will not depend on runtime LLM features.
- Consequence: NPCs, economy, and progression must remain deterministic and locally understandable.

## 2026-03-13 ADR-004 Additive Growth Beats Replacement
- Status: Accepted
- Decision: the game should deepen by adding districts, content, projects, information layers, and consequences rather than replacing core worldview or loops.
- Consequence: new work should mostly instantiate canon categories and preserve earlier meaning.

## 2026-03-13 ADR-005 Money Is Fuel, Not The Goal
- Status: Accepted
- Decision: currency is a means to capability, beauty, freedom, and shared life.
- Consequence: avoid abstract financialization and reward structures that make accumulation the end state.

## 2026-03-13 ADR-006 Visible Civic Consequence Is Mandatory
- Status: Accepted
- Decision: public contribution must change the world in visible ways.
- Consequence: civic systems should be modeled through places, projects, access, and shared structures rather than invisible town scores.

## 2026-03-13 ADR-007 Productive Assets Stay Tangible Early
- Status: Accepted
- Decision: early productive ownership should be concrete and child-legible.
- Consequence: favor assets such as trees, tools, and market capacity before abstract financial instruments or institutional layers.

## 2026-03-13 ADR-008 Ordered Additive Production Scaling
- Status: Accepted
- Decision: the project should scale through ordered additive production phases rather than solving later-phase problems inside early-phase implementation.
- Consequence: milestone planning should use `production_scale_phase_plan.md`; later-phase concerns should not be smuggled into Milestone 0 or Milestone 1 work.

## 2026-03-13 ADR-009 Codex Workflow And Post-Task Sync Are Mandatory
- Status: Accepted
- Decision: Codex should follow an explicit repo workflow and every substantial task should end with a post-task documentation sync pass.
- Consequence: use `docs/production/codex_workflow.md` as the Codex operating contract, and treat the sync pass as required work rather than optional cleanup.

## 2026-03-13 ADR-010 Milestone 1 Coin Authority Is Singular
- Status: Accepted
- Decision: `player_state.coins` is the only spendable currency authority in Milestone 1, while `item/coin` remains a canonical content concept only.
- Consequence: selling, buying, and contributing should read and write player coin balance directly; Milestone 1 must not create a second inventory-backed currency authority.

## 2026-03-13 ADR-011 Milestone 1 Tree Ownership Authority Is Singular
- Status: Accepted
- Decision: `player_state.owned_assets` is the only ownership authority for `asset/apple_tree` in Milestone 1, while `item/tree_deed` remains non-authoritative if present.
- Consequence: tree purchase, yield, save/load, and migrations must use `owned_assets` as the durable source of truth and must not infer ownership from a deed item.

## 2026-03-13 ADR-012 Milestone 1 Uses Personal And Civic Scope Only
- Status: Accepted
- Decision: Milestone 1 Orchard and Bridge uses only personal and civic gameplay authority; household scope remains reserved for Milestone 2.
- Consequence: co-op in Milestone 1 is one shared world with shared civic consequence plus separate personal inventories, coin balances, and tree ownership.

## 2026-03-13 ADR-013 Milestone 1 Implementation Is Readiness-Gated And Ordered
- Status: Accepted
- Decision: Orchard and Bridge implementation must start with the locked readiness checklist and follow the approved block order from mechanical value to productive ownership to civic consequence to NPC reflection.
- Consequence: Milestone 1 work should begin with Block A and should not pull later-block systems forward for convenience.

## 2026-03-13 ADR-014 Block A Uses One Shared Starter Strip
- Status: Accepted
- Decision: Block A uses one shared civic starter strip bootstrapped once per world near a deterministic starter anchor, plus a temporary bakery flour-bin support node tied to `place/crafting_station`.
- Consequence: Block A remains a single shared-world civic setup rather than per-player convenience seeding, and the flour bin stays explicit scaffolding for the first value loop rather than a permanent full-economy truth.

## 2026-03-13 ADR-015 Block A Uses A Prototype Accessibility Layer
- Status: Accepted
- Decision: Block A runtime accessibility uses one inert prototype substrate node for the required starter-world mapgen aliases, a fixed safe starter anchor and platform, and ordered join or respawn placement that only happens after the shared starter area is ready.
- Consequence: the prototype can be tested from a fresh world without widening into a broader world-generation system, while Block A remains one shared civic strip and keeps gameplay authority in per-player inventory plus `player_state.coins`.

## 2026-03-14 ADR-016 The First Live Household Authority Is Pantry Inventory
- Status: Accepted
- Decision: the first Milestone 2 household authority is `world_state.household.inventory`, count-based only, with aggregate `item/apple` and `item/flour` pantry counts plus explicit deposit, shared read, and explicit withdrawal.
- Consequence: household scope becomes real without activating shared coins, shared tree ownership, direct pantry baking, household `item/pie`, or civic rewrites; `save_version` advances to `2` while `content_version` stays `1`, other reserved household fields stay inactive, and handler-level non-partial pantry transfers do not imply a new transaction or rollback framework.
