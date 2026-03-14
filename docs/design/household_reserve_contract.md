# Household Reserve Contract

## Purpose
Define the smallest household rule that makes the pantry a real `ours later` choice without changing the frozen Milestone 1 personal and civic rules.

## Core Rule
The household reserve protects one future pie-input set in household scope. It exists to preserve future baking capacity, not to authorize direct pantry crafting.

## What Counts As A Complete Reserve
The reserve is complete only when `world_state.household.inventory` contains at least:
- `item/apple = 2`
- `item/flour = 1`

Anything above that is surplus. Do not define multiple reserve tiers or stacked reserves in this step.

## What The Reserve Changes
Once a complete reserve exists, the pantry stops being only shared storage.
The household now has:
- protected reserve: the first `2 apples + 1 flour`
- surplus: any pantry amount above that reserve

Surplus can be withdrawn normally. Taking from the protected reserve becomes an explicit household choice.

## What The Reserve Does Not Change
The reserve does not change:
- personal inventory defaults
- `player_state.coins`
- `player_state.owned_assets["asset/apple_tree"]`
- personal tree yield
- bridge state or civic contribution rules
- Block A crafting inputs or sale flow
- pantry authority boundaries

All baking still happens only after personal withdrawal.

## Withdrawal Rule Options
- unrestricted withdraw: simplest, but leaves the reserve too easy to erase accidentally
- hard reserve lock: protects the reserve, but removes the meaningful household choice
- explicit break-reserve withdraw: keeps normal surplus use while making reserve-breaking deliberate

## Recommended Withdrawal Rule
Use explicit break-reserve withdraw.

Normal withdraw may remove only surplus. If a withdraw would drop pantry counts below `2 apples + 1 flour`, the system must first warn the acting player and require a second immediate interaction on the same withdraw surface to confirm breaking the reserve.

That confirmation is ephemeral runtime-only behavior. It must not be saved, must not become a new household authority or hidden reserve ledger, and should reset on relaunch instead of persisting as gameplay truth.

## Failure / Friction Rules
Create tension through clarity, not punishment.

- no hidden penalties
- no timers
- no NPC reaction
- no silent scope change
- no partial transfer behavior

Messages should clearly distinguish:
- reserve ready
- reserve incomplete
- reserve broken by explicit choice

If the pantry is already below reserve, withdraw behaves normally because no complete reserve exists to protect.

## Co-op Rules
Both players in the same world read the same reserve state because reserve status is derived from shared pantry counts.

Either player may:
- complete the reserve
- withdraw surplus
- explicitly break the reserve

Breaking the reserve changes shared pantry truth for both players immediately. No player-specific claim, provenance, or admin priority exists in this step.

## Authority Boundaries
- personal: carried goods, pies, coins, tree ownership, tree yield, and all post-withdraw baking
- household: only aggregate pantry counts in `world_state.household.inventory`, with reserve status derived from those counts and not stored separately
- civic: bridge and project state only

Do not create a separate reserve field, reserve owner, or reserve memory.

## Smallest Good Implementation Shape
The next narrow implementation step is reserve-aware pantry read and withdraw behavior on the existing pantry nodes only.

That step should:
- show reserve status in pantry read output
- allow ordinary withdraw from surplus
- require same-surface confirm-to-break when a withdraw would consume the protected reserve

Do not add new saved fields, new goods, crafting changes, or new household authorities.

## Deferred To Later
- stacked reserves
- household `item/pie`
- direct pantry baking
- reservations
- provenance
- shared coins or household spending
- shared tree ownership
- civic rewrites
- household NPC commentary
- admin hierarchy

## Recommendation
Keep the rule recipe-shaped and singular. One protected future pie set is enough to make the pantry feel like household planning instead of neutral storage.

## Final Rule
The household pantry protects one future pie set: `2 apples` and `1 flour` stay ours until someone explicitly breaks that reserve, and all baking still happens only after personal withdrawal.
