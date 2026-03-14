# Milestone 2 Household Slice Closure

## Status
The current household slice is implemented and honestly verified. Milestone 2 now has one proven household layer: explicit pantry deposit, shared read, and explicit withdrawal for `item/apple` and `item/flour`, plus reserve-aware withdrawal with explicit break-reserve choice.

## What This Household Slice Proves
- Household authority can exist cleanly between personal and civic scope through one shared pantry ledger.
- `Ours later` is now more than neutral storage: one future pie set can be protected without authorizing direct pantry baking.
- Both co-op players can read the same pantry truth and make deliberate reserve-breaking choices against that shared truth.
- Milestone 1 personal and civic authorities survived intact under the household layer.

## What It Still Does Not Prove
- It still does not prove a strong ongoing reason to keep household goods in the pantry beyond the protected reserve.
- It still does not prove richer shared obligation, household routine, or household identity beyond one narrow storage-and-withdraw decision.
- It still does not prove that broader household scope should expand yet.

## Stable Boundaries To Preserve
- Personal scope still owns carried inventory, `item/pie`, `player_state.coins`, `player_state.owned_assets["asset/apple_tree"]`, personal tree yield, sale outcomes, and all post-withdraw crafting.
- Household scope is still only aggregate `item/apple` and `item/flour` counts in `world_state.household.inventory`; reserve status stays derived from those counts and is not saved as separate gameplay truth.
- Civic scope still owns bridge contribution, bridge progress, bridge completion, and shared place unlocks under `world_state.civic`.
- Pantry goods still do not bake, sell, or auto-move directly from household scope.
- Mixed personal, household, and civic write paths are still not acceptable.

## Strongest Parts
- Scope is clear and teachable: mine, ours, and town are still easy to tell apart.
- The reserve rule creates deliberate household friction without hidden penalties or new authorities.
- The slice improves co-op meaning while staying narrow, readable, and save-safe.

## Weakest / Thinnest Parts
- The household layer is still strongest as a boundary proof, not yet as a rich lived routine.
- Most of the slice's meaning sits in withdrawal restraint; outside that moment, the pantry can still feel structurally useful but emotionally thin.
- The current slice protects one future use, but it does not yet make household upkeep or household sacrifice feel durable.

## Current Household Question
What is the smallest durable reason to keep or rebuild one future pie set in household scope for us later instead of treating the pantry as temporary staging before personal baking?

## What Must Not Change Yet
- `world_state.household.inventory` stays the only live household authority.
- Pantry scope stays limited to `item/apple` and `item/flour`.
- Reserve status stays singular, derived, and unsaved.
- Crafting and sale stay personal-inventory-only after explicit withdrawal.
- No direct pantry baking, household `item/pie`, shared coins, shared tree ownership, civic rewrite, household NPC commentary, or broader household framework.

## Recommendation
The household slice has succeeded as a real scope proof and a first shared-planning proof. Keep it frozen as the verified household baseline, and use the next Milestone 2 design pass to answer one question only: why should the household keep or restore that protected future pie set before any broader household breadth is authorized?

## Final Rule
Deepen household meaning before widening household scope.
