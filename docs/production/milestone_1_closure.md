# Milestone 1 Closure

## Status
Milestone 1 is complete and verified as a baseline slice. Blocks A, B, C, and D are proven at their approved Orchard and Bridge boundaries and should stay frozen as the baseline until explicit post-Milestone-1 decisions change them.

## What Milestone 1 Proves
- Block A proves a child-readable personal value loop works in-engine: gather, craft, sell, and retain personal state across save/load.
- Block B proves saving can become personal productive ownership that changes tomorrow through repeatable yield.
- Block C proves personal sacrifice can become shared civic progress, visible project staging, and a durable world change.
- Block D proves sparse stateless NPC reflection can reinforce consequence without carrying the slice or adding new authorities.

## What Exists In Runtime
- One shared starter strip with bootstrap and accessibility support for orchard, flour bin, crafting station, market stall, tree surface, and bridge surface.
- Per-player persistence for inventory, `coins`, and `owned_assets`, plus versioned player and world save migration entry points.
- Apple pickup, flour pickup, pie crafting, and pie sale.
- One shared tree interaction surface that resolves to personal `asset/apple_tree` purchase and daily personal apple yield.
- One shared bridge site that takes fixed 5-coin personal contributions, tracks civic funds/stages/unlocked places, renders visible stages, and unlocks the walkable bridge outcome.
- One optional Baker follow-up line on tree purchase and one optional Builder follow-up line on first contribution, framing, and completion.

## What Was Intentionally Excluded
- Household authority, shared household inventory, shared household spending, and mixed-scope holdings.
- Broader NPC dialogue, memory, trust, commission, or social systems beyond Block D reflection.
- Extra districts, projects, professions, or content chains beyond Orchard and Bridge.
- Deeper economy, governance, inheritance, tax, or abstract finance systems.
- Speculative framework, UI-polish, or generalized narrative tooling.

## Stable Boundaries To Preserve
- `player_state.coins` is the only spendable coin authority in Milestone 1.
- `player_state.owned_assets["asset/apple_tree"]` is the only tree ownership authority; `item/tree_deed` stays non-authoritative.
- Durable personal authority lives in per-player persistence; `world_state.players` remains reserved and non-authoritative.
- Civic bridge truth lives in `world_state.civic.project_funds`, `world_state.civic.project_stages`, and `world_state.civic.unlocked_places`.
- Co-op in this slice means shared civic world plus separate personal inventory, coins, and tree yield; household scope is still deferred.
- Block D stays stateless and narrow: success-only, one line max, four approved triggers only, and no saved NPC memory or dialogue framework.

## Strongest Parts Of The Slice
- The gather -> make -> sell -> save -> own -> contribute chain is readable and mechanically complete.
- Bridge completion creates a clear shared world change instead of an abstract meter.
- Personal and civic authorities are explicit in docs, save shape, and runtime behavior.
- The split between `data/`, `systems/`, and `runtime/` is small, clear, and adequate for the slice.
- NPC reflection is restrained enough to support consequence without replacing it.

## Weakest / Most Fragile Parts
- The starter strip still depends on prototype bootstrap and accessibility scaffolding plus fixed local layout assumptions.
- Reserved-but-unused save fields and scopes (`household`, `world_state.players`, `known_npcs`, `npc_memory`) are easy future misuse points.
- Block B verification required care around local Luanti day-count behavior; future time-driven mechanics should treat day progression, test setup, and save/load timing carefully.

## Milestone 2 Entry Rules
- Planning may explore which current assets and places could later move into household scope.
- Planning may define the first true household-level trade-off before any implementation starts.
- Planning may examine save-shape, migration, and authority implications of introducing household state.
- Implementation refinements are acceptable only if they preserve the proven Milestone 1 boundaries and do not change milestone truth by implication.
- Milestone 2 must not casually rewrite frozen Milestone 1 IDs, coin authority, tree ownership authority, civic bridge authority, or Block D limits without explicit decision.
- Milestone 2 must not treat Orchard and Bridge as disposable tutorial content or use new mechanics to invalidate what this slice already proved.

## Recommendation
Treat Milestone 1 as the frozen baseline proof of Orchard and Bridge. Start Milestone 2 with bounded household planning, explicit authority mapping, and one real shared trade-off definition before any new mechanics or runtime expansion.

## Final Rule
Carry Milestone 1 forward; do not rewrite it just to begin Milestone 2.
