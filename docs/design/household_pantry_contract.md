# Household Pantry Contract

## Purpose
Define the first household pantry authority before Milestone 2 implementation begins. This contract removes withdrawal and use ambiguity without changing the frozen Milestone 1 personal and civic rules.

## Core Rule
`item/apple` and `item/flour` become household only through explicit deposit and remain household until explicit withdrawal.

## What Counts As Household Pantry Scope
The first pantry shape includes only aggregate household counts for `item/apple` and `item/flour`.
`item/pie`, coins, tree ownership or yield, bridge state, and every other good stay outside pantry scope.

## Deposit Rules
Deposit is explicit player action from that player's personal inventory into `world_state.household.inventory`.
A deposit succeeds only if the transfer is atomic: the personal count decreases and the household count increases together in the same accepted action.
No partial transfer is valid. No decrement without a matching increment is valid. If either side cannot be updated, nothing changes.
No automatic pooling from pickup, crafting, tree yield, sale, or co-op presence.

## Withdrawal / Use Rules
Withdrawal is explicit player action from `world_state.household.inventory` into the acting player's personal inventory.
A withdrawal succeeds only if the transfer is atomic: the household count decreases and the personal count increases together in the same accepted action.
No partial transfer is valid. No decrement without a matching increment is valid. If either side cannot be updated, nothing changes.
Household pantry goods cannot be baked, sold, eaten, or otherwise used directly from pantry scope in the first shape.
All crafting still reads only from personal inventory after withdrawal.

## What Stays Personal
- carried inventory by default
- `item/pie`
- `player_state.coins`
- `player_state.owned_assets["asset/apple_tree"]`
- personal tree yield
- sale results
- personal bridge contribution decisions

## Authority Boundaries
Personal authority stays in per-player saves.
Household authority is only `world_state.household.inventory`.
Civic authority stays in `world_state.civic`.
The explicit save and state recommendation for the first shape is one count-based household ledger only: aggregate counts keyed by `item/apple` and `item/flour`.
Do not introduce slots, per-player sub-ownership, metadata-bearing stacks, reservations, or provenance rules in the first shape.
`world_state.players` remains non-authoritative, and `world_state.household.owned_assets` plus `world_state.household.upgrades` stay reserved.
Do not read or write personal, household, and civic state through one mixed path.

## Co-op Rules
Both co-op players in the same world see the same pantry counts.
Both players can deposit to and withdraw from the pantry.
The first shape has no parent or child admin hierarchy.
Withdrawn goods become the acting player's personal goods when the withdrawal succeeds.

## Failure / Ambiguity Rules
Fail cleanly on unknown item IDs, unsupported goods, insufficient personal counts for deposit, insufficient household counts for withdrawal, and any attempt to craft or spend pantry goods directly from household scope.
Never guess which scope to consume from.
Never guess which player owns a pantry count.
Never partially apply a transfer.
If a transfer cannot update both sides together, fail with no state change.

## Smallest Good Implementation Shape
Use one shared count ledger under `world_state.household.inventory` that holds only `item/apple` and `item/flour`.
Provide exactly two explicit transfer actions: deposit from personal to household and withdraw from household to personal.
Provide one shared read surface that shows the current pantry counts to both players.
Keep crafting and sale rules unchanged so they still read only from personal inventory after withdrawal.

## Deferred To Later
- direct baking from pantry
- finished-goods household scope
- household coins
- shared tree ownership
- civic rewrites
- admin permissions
- slots
- metadata-bearing stacks
- provenance
- reservations
- broader pantry goods

## Recommendation
Start with withdraw-first shared storage. It is the narrowest child-legible and save-safe way to make `ours` real.

## Final Rule
Pantry apples and flour are shared household counts until someone intentionally withdraws them; nothing auto-moves, auto-uses, or partially transfers.
