# Milestone 3 Place Condition Contract

## Purpose
This contract chooses the exact Milestone 3 persistent-world place, defines its durable condition, links it to one specialist, and describes the smallest later dependency it creates. It does not authorize implementation.

## Chosen Place
`place/crafting_station`

The crafting station is the only existing village work place with a direct specialist link and a central role in the proven production loop.

## Why This Place Is Best
The crafting station is the strongest practical Milestone 3 proof for four reasons.

First, the Baker (`npc/baker`) already has `home_place_id: "place/crafting_station"` in data. The specialist link exists without inventing a new NPC or reassigning an existing one.

Second, the crafting station sits at the center of the production loop: gather apples and flour, bake pies at the station, sell pies for coins. A durable condition here creates the most legible dependency because it touches the step every player must pass through.

Third, the Baker's defined priorities are `craft` and `consistency`. A station condition that affects whether baking can proceed reliably maps directly to what the Baker already cares about.

Fourth, the alternatives are weaker. The orchard and market stall have no specialist link in data. The bridge is a one-time civic unlock whose meaning comes from completion; adding a condition to it would punish the civic win rather than deepen it. The crafting station is the only place where persistent condition, specialist relationship, and production dependency all converge inside the already-known village footprint.

## Specialist Link
The Baker is the linked specialist. The Baker's role is defined in `data/npc_profiles.lua` as a craft-focused villager tied to `place/crafting_station` with priorities of craft and consistency. The station's readiness is what makes the Baker's local responsibility meaningful: the Baker cares whether the station is ready because the Baker's identity depends on reliable making happening there.

This link does not require broad NPC memory, dialogue trees, or new NPC systems. It requires only that the Baker's existing relationship to the crafting station becomes visible through the station's durable condition.

## Durable Condition
The crafting station holds one binary condition: **ready** or **not ready**.

**Ready** means the station is prepared for normal baking. Pies can be crafted as they are now. The Baker's place is in working order.

**Not ready** means the station needs player care before reliable baking can resume. The station stays not ready until a player explicitly restores it.

Key framing rules:
- The condition is not passive decay. The station does not wear down over time from a hidden timer.
- The condition is not a maintenance tax. It does not punish players for existing or for being away.
- The condition changes because of a specific disruption or significant use threshold, not because of ambient deterioration.
- Once ready, the station stays ready until something specific makes it not ready.
- Once not ready, the station stays not ready until a player explicitly acts to restore it.
- The condition is visible on return. A player who leaves and comes back can see whether the station is ready or not.
- Both co-op players see the same station condition because it is shared civic-place truth.

## What This Condition Changes Later
When the station is not ready, baking is blocked or visibly impaired at that place. This creates the smallest real dependency: players who want to continue the production loop must restore the station before they can bake reliably.

This dependency is legible to a child: the place where you make pies needs to be ready, and if it is not, you fix it before baking. It connects player care to future capability without requiring abstract reasoning.

The Baker's specialist relationship becomes meaningful because the Baker is the village role most affected by whether this place works. Later passes may let the Baker react to the station's condition, but this contract does not authorize NPC behavior changes.

## What It Must Not Change
- `player_state.coins` remains the only personal coin authority
- `player_state.owned_assets["asset/apple_tree"]` remains the only tree ownership authority
- `player_state.inventory` remains the only personal inventory authority
- `world_state.household.inventory` remains the only household authority, count-based apples and flour only
- `world_state.civic.project_funds`, `world_state.civic.project_stages`, and `world_state.civic.unlocked_places` remain the civic authorities
- Block A pickup, Block B tree, Block C bridge, and Block D NPC reflection stay frozen at their verified scopes
- Pantry deposit, withdrawal, reserve, and house-ready messaging stay unchanged
- Personal, household, and civic write paths must not be mixed
- No new ownership scope layer is created
- No household scope expansion beyond the frozen baseline
- No direct pantry baking or household `item/pie`

## State / Save Recommendation
The station condition should stay derived if possible. If the condition is determined entirely by facts already in world state or player state, no new saved field is needed.

If derivation alone proves insufficient during a later implementation-planning pass, one narrow saved field may be justified. That field should be:
- a single-purpose civic place condition, not a general world-activity ledger
- scoped to `place/crafting_station` only, not a reusable place-condition framework
- stored under civic world state because the crafting station is civic scope
- binary or near-binary in shape (ready versus not ready, or a small integer threshold)

Do not create a world-activity counter, timer grid, general place-health system, background-sim state, or mixed personal-household-civic persistence layer.

`save_version` should advance only if a new saved field is added. `content_version` should advance only if content definitions change in ways active saves care about. Neither version should change in this planning pass.

## Smallest Good Milestone 3 Expression
One existing civic work place (`place/crafting_station`) holds one durable binary condition (ready or not ready). The condition persists across save/load. It is visible to both co-op players. It blocks or impairs baking when not ready. One existing specialist (`npc/baker`) is already linked to this place by data. Restoring the station is an explicit player action. The dependency is that the production loop requires the station to be ready.

This is enough to prove persistent world through all three dimensions:
- **Persistent place**: the crafting station keeps its condition across sessions
- **Persistent role**: the Baker is the specialist whose identity depends on station readiness
- **Persistent dependency**: later baking depends on whether the station was restored

## Deferred To Later
- what specific event or threshold makes the station not ready (implementation-planning decision)
- what specific player action restores the station (implementation-planning decision)
- Baker NPC behavioral reaction to station condition (requires separate NPC-scope approval)
- visual node changes for ready versus not ready station (implementation detail)
- broader place-condition systems for other places
- new district expansion
- general NPC memory or routine systems
- timer-based or upkeep-based condition triggers
- household scope expansion
- civic rewrites

## Recommendation
Use `place/crafting_station` as the Milestone 3 persistent-world proof. It is the only existing village place where specialist link, production dependency, and durable condition converge without inventing new content or expanding scope. Keep the condition binary, keep the framing active rather than passive, and defer implementation details to a separate approved pass.

## Final Rule
The station is ready or not ready. That is enough to prove a place can hold meaning over time.
