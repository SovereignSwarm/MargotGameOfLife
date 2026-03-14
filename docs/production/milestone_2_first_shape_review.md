# Milestone 2 First Shape Review

## Status
The first household pantry shape is implemented and honestly verified. Milestone 2 now has one proven household layer: explicit shared deposit, shared read, and explicit withdrawal for `item/apple` and `item/flour`.

## What The Pantry Shape Proved
- Household authority can exist cleanly between personal and civic scope.
- Explicit deposit, shared read, and explicit withdrawal make `ours` legible without auto-pooling.
- Withdraw-first preserves Milestone 1 personal coin, tree, civic, and NPC boundaries.
- A count-based apples-and-flour ledger is a valid first household layer.

## What The Pantry Shape Does Not Yet Prove
- It does not yet prove a strong reason to keep goods household-owned once deposited.
- It does not yet prove shared obligation, household planning pressure, or a meaningful household-level tension.
- Right now the pantry reads more as shared storage than shared life.

## Strongest Parts
- Scope is clear: personal, household, and civic are still easy to tell apart.
- The shape is narrow, readable, and uses existing goods and verbs.
- Co-op meaning improved without shared coins, shared tree ownership, or civic rewrites.

## Weakest / Thinnest Parts
- Deposit is meaningful structurally, but still thin emotionally.
- After deposit, very little new tension appears until someone withdraws.
- Withdrawal is clear, but not yet weighty enough as a household choice.

## Main Household Question Now
What is the smallest reason to leave apples and flour in the pantry for us later instead of pulling them back out for me now?

## Candidate Next Tensions
1. Shared reserve vs immediate personal baking.
2. Replenish vs consume.
3. Complete the set vs cannibalize the set.

## Best Next Household Tension
Shared reserve vs immediate personal baking.

This is the best next step because it grows directly out of the pantry, stays inside current goods and the existing pie loop, and makes withdrawal matter without authorizing direct pantry baking. It is the smallest next tension that can make household storage feel like household planning.

## What Must Not Change Yet
- `world_state.household.inventory` stays the only live household authority.
- Pantry scope stays limited to `item/apple` and `item/flour`.
- Transfers stay explicit, count-based, and withdraw-first.
- No direct pantry baking and no household `item/pie`.
- No shared coins, household spending, shared tree ownership, shared tree yield, or civic rewrite.
- No household NPC commentary, no admin hierarchy, and no Milestone 1 Block A-D scope drift.

## Recommendation
The pantry succeeded as a boundary proof, not yet as a full household meaning proof. Keep the verified first shape frozen, and use the next pass to make one shared reserve decision matter before adding any broader household breadth.

## Final Rule
Make the pantry matter before making it bigger.
