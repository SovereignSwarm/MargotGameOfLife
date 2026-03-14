# MargotGameOfLife

A private parent-child co-op village life sim where craft, saving, ownership, and civic contribution visibly shape the world over time.

Money is not the goal. Money is fuel.

## Start Here
- Read `docs/README.md` for the full docs map and authority order.
- If you are working through Codex or Cursor, read `AGENTS.md` for the repo operating contract.
- Then read `docs/production/current_state.md` for the active milestone, current priority, top risks, and approved next baby steps.
- If you are implementing Orchard and Bridge, read `docs/design/milestone_1_ownership_semantics.md`, `docs/production/milestone_1_implementation_order.md`, `docs/production/milestone_1_checklist.md`, and `docs/design/milestone_1_acceptance_criteria.md` before coding.
- If you are implementing the first household pantry shape, read `docs/design/household_pantry_contract.md`, `docs/production/milestone_2_plan.md`, and `docs/production/save_compatibility_policy.md` before coding.

## Current Milestone
The repo is currently in `Milestone 2 - Shared Household Layer`.

Milestone 1 is complete and frozen as the verified Orchard and Bridge baseline. The current Milestone 2 work is one narrow household pantry shape only: explicit shared deposit, shared read, and explicit withdraw for apples and flour, with no direct baking from pantry and no broader household expansion yet.

## V1 Loop
Build a tiny Luanti-based multiplayer prototype proving this loop:

- gather apples
- craft pies
- sell pies
- save coins
- buy one productive asset (apple tree)
- contribute to one public project (bridge fund)
- see visible world change
- receive NPC feedback on choices

## Non-Goals For V1
- no MMO
- no public servers
- no advanced AI NPCs
- no inheritance mechanics
- no tax systems
- no abstract finance layers
- no procedural society simulation
- no polished art pipeline
- no mobile-style retention loops

## Success Criteria
The prototype succeeds if:

1. a child can understand the basic loop quickly
2. saving for the tree feels meaningful
3. contributing to the bridge feels meaningful
4. the world visibly responds to decisions
5. parent-child co-op feels natural in one shared world
