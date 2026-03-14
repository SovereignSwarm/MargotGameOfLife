# Household Purpose Contract

## Purpose
This contract defines the smallest durable reason the household should preserve or rebuild one future pie set in pantry scope: the house should stay ready for one later pie, even though the actual baking still happens only after personal withdrawal.

## Core Rule
Household scope keeps one future pie set ready for us later; if that set is broken, the household is not ready again until `2 apples` and `1 flour` are rebuilt.

## What The Purpose Is For
Keeping the reserve intact means the household can honestly say we still have one pie set ready for later. It turns the pantry from temporary staging into shared pie-readiness without turning the pantry into a direct crafting surface.

## What The Purpose Is Not
- not a second currency
- not a civic goal or bridge input
- not a broad family-sim routine system
- not a blame, debt, or fairness ledger between players
- not direct pantry crafting or household `item/pie`

## Candidate Purpose Shapes
1. **Keep one pie set ready**: the household should stay pie-ready unless someone explicitly chooses to break that readiness.
2. **Restore the pie set after it is broken**: once the reserve is broken, the next household pressure is to rebuild that same set.
3. **Complete the set before treating pantry goods as surplus**: partial pantry goods matter first as progress toward one complete future pie set.

## Best Purpose Shape
`Keep one pie set ready` is the best next step after pantry plus reserve-aware withdrawal. It fits the current reserve rule directly, makes rebuild pressure obvious without adding mechanics, and stays child-legible and co-op-legible because both players can understand one shared ready or not-ready household state.

## How The Purpose Should Create Tension
`Mine now` means withdrawing apples or flour so I can bake or sell personally now. `Ours later` means leaving the house pie-ready. Breaking the reserve helps one player now, but it leaves the household not ready again until someone rebuilds `2 apples + 1 flour`.

## What Must Stay Unchanged
- personal scope still owns carried inventory, pies, coins, tree ownership, tree yield, sale outcomes, and all post-withdraw crafting choices
- household scope still owns only aggregate pantry counts for `item/apple` and `item/flour` in `world_state.household.inventory`
- civic scope still owns bridge contribution, bridge progress, bridge completion, and shared place unlocks
- pantry goods still do not bake, sell, or auto-move directly from household scope

## State / Save Boundary Recommendation
This purpose should stay purely derived from pantry counts. Do not add a saved purpose field, readiness field, debt field, owner field, or partner claim. The biggest authority risk is creating a second household truth that competes with `world_state.household.inventory`.

## Co-op Rules
Both players should read the same shared household state: pie-ready or not pie-ready. Either player may help preserve the set, break it, or rebuild it. No admin hierarchy, no hidden partner-specific claims, and no private ownership of the reserve exist in this step.

## Smallest Good Implementation Shape
If a later pass is explicitly approved, the narrowest next implementation shape is to use this contract as the meaning anchor for existing pantry interactions only, so the shared state reads as household ready or household not ready. This contract does not authorize runtime changes by itself; any implementation still requires a separate approved pass.

## Deferred To Later
- shared coins or household spending
- shared tree ownership or shared tree yield
- household `item/pie`
- direct pantry baking
- obligation ledgers or partner debt
- civic linkage or civic rewrite
- household NPC commentary
- broader household routines, upgrades, or systems

## Recommendation
Treat this as the smallest real household purpose: keep one pie set ready for us later. That is enough to make the reserve matter durably, keep the household layer legible, and hold Milestone 2 inside its current narrow boundary until a separate implementation pass is approved.

## Final Rule
Keep one pie set ready for us later.
