# Milestone 1 Acceptance Criteria

## Purpose
This document defines the exact implementation gate for Milestone 1 - Orchard and Bridge so coding can begin without silently inventing completion standards, ownership semantics, save assumptions, or child-readability assumptions.

## Scope
Milestone 1 includes only the Orchard and Bridge slice, the ten features listed below, the current starter items, places, projects, and NPCs, private co-op for 1-2 players, and the existing personal and civic state split.

Milestone 1 does not define later districts, household gameplay, judgment or information loops, advanced NPC memory, or tuning-heavy economy design.

## Core Rule
Milestone 1 is done only when the slice is mechanically correct, child-legible, co-op-legible, and structurally safe for future growth.

## Milestone 1 Feature List
- apple source / pickup
- pie recipe / crafting
- pie sale / coin earning
- apple tree purchase
- recurring tree yield
- bridge contribution
- bridge stage progression
- bridge completion outcome
- basic baker commentary
- basic builder commentary

## Acceptance Criteria Format
Each feature entry below is a gate, not a brainstorm. Every entry must define:

- Goal
- Player-facing behavior
- Required inputs/state
- Ownership scope
- Visible consequence
- Save impact
- Failure cases to handle
- Done when

## Feature Criteria
### Apple Source / Pickup
- **Goal**: Let the player gather apples from `place/orchard` into usable personal inventory.
- **Player-facing behavior**: A player can interact with the orchard and receive `item/apple` for later crafting, selling, or saving decisions.
- **Required inputs/state**: `place/orchard`, `item/apple`, player inventory, valid canonical IDs.
- **Ownership scope**: `place/orchard` stays civic; gathered `item/apple` enters personal inventory.
- **Visible consequence**: The player can immediately see apples appear in inventory and use them in later slice actions.
- **Save impact**: Gathered apples must persist in player inventory across save/load.
- **Failure cases to handle**: unknown source ID, unknown item ID, gather action granting nothing, gather action duplicating or losing apples on reload.
- **Done when**: Apples can be gathered, seen in inventory, used later, and preserved across save/load without guesswork.

### Pie Recipe / Crafting
- **Goal**: Let the player turn apples and flour into pie using `recipe/pie` at `place/crafting_station`.
- **Player-facing behavior**: A player with the required ingredients can craft `item/pie`; a player without them cannot.
- **Required inputs/state**: `recipe/pie`, `place/crafting_station`, `item/apple`, `item/flour`, `item/pie`, player inventory.
- **Ownership scope**: Inputs and outputs are personal; `place/crafting_station` stays civic.
- **Visible consequence**: Inputs are removed on success, pie appears in inventory, and the player can immediately use the result for sale or saving.
- **Save impact**: Inventory changes from successful crafting must survive reload cleanly.
- **Failure cases to handle**: unknown recipe, missing inputs, consuming inputs on failure, output not matching the recipe.
- **Done when**: Crafting succeeds only with the required inputs, consumes the correct inputs on success, consumes nothing on failure, and produces a sellable `item/pie`.

### Pie Sale / Coin Earning
- **Goal**: Let the player sell pie at `place/market_stall` and earn spendable coin state.
- **Player-facing behavior**: A player can exchange `item/pie` for increased player coin state.
- **Required inputs/state**: `place/market_stall`, `item/pie`, player `coins`, and the `item/coin` content concept.
- **Ownership scope**: Pie is personal before sale; earned coin state is personal after sale.
- **Visible consequence**: Pie leaves inventory and the player's coins increase in a way the player can see and use later.
- **Save impact**: Inventory reduction and coin increase must both persist across save/load.
- **Failure cases to handle**: invalid sale quantity, sale with no pie, negative coin outcomes, coin and inventory desync, two competing authorities for spendable currency.
- **Done when**: Selling removes the correct pie amount, increases player coin state, preserves the result across save/load, and does not create a second hidden authority that competes with player `coins`.

### Apple Tree Purchase
- **Goal**: Let the player spend coins to acquire personal ownership of `asset/apple_tree`.
- **Player-facing behavior**: A player who can afford the tree can buy it and unlock a future-yield path.
- **Required inputs/state**: `asset/apple_tree`, `item/tree_deed`, player `coins`, personal `owned_assets`, current asset cost from content data.
- **Ownership scope**: Personal only in Milestone 1.
- **Visible consequence**: Coins go down, the player gains clear ownership of the tree, and the tree now matters for later yield.
- **Save impact**: Coin reduction and owned asset state must persist across save/load; any `item/tree_deed` state used must be explicit and save-safe.
- **Failure cases to handle**: insufficient coins, unknown asset, ownership granted twice, deed state competing with `owned_assets` as a second ownership authority.
- **Done when**: Purchase spends the current asset cost from the content definition, records personal ownership in `owned_assets`, and exposes the future-yield path without ambiguous ownership semantics.

### Recurring Tree Yield
- **Goal**: Let an owned `asset/apple_tree` produce repeatable apple value over time.
- **Player-facing behavior**: A player who owns a tree receives recurring apple output under a clear rule.
- **Required inputs/state**: `asset/apple_tree`, current yield definition, personal `owned_assets`, player inventory.
- **Ownership scope**: Personal only in Milestone 1.
- **Visible consequence**: The player can tell the owned tree is changing tomorrow by producing usable apples again.
- **Save impact**: Owned tree state and resulting apple output must survive save/load without duplication or loss.
- **Failure cases to handle**: yield without ownership, reload duplication, wrong-scope output, unclear or non-repeatable yield rule.
- **Done when**: An owned tree produces repeatable `item/apple` output under a clear recurring rule, only after ownership exists, and the rule survives save/load cleanly.

### Bridge Contribution
- **Goal**: Let the player move personal value into shared civic progress for `project/bridge_01`.
- **Player-facing behavior**: A player can contribute coins at `place/bridge_site` and see the shared project move forward.
- **Required inputs/state**: `project/bridge_01`, `place/bridge_site`, player `coins`, civic `project_funds`.
- **Ownership scope**: Coins are personal before contribution and civic after contribution.
- **Visible consequence**: Player coins decrease and the shared bridge fund increases in a way that can lead to visible stage change.
- **Save impact**: Personal coin loss and civic project fund increase must both survive reload.
- **Failure cases to handle**: insufficient funds, unknown project, negative or zero-invalid contribution handling, money spent without civic progress recording.
- **Done when**: A contribution reduces personal coins, increases the shared bridge fund, and both states persist across save/load without guesswork.

### Bridge Stage Progression
- **Goal**: Turn shared bridge funding into visible staged progress before completion.
- **Player-facing behavior**: As contributions increase, the bridge advances through the currently defined stages for `project/bridge_01`.
- **Required inputs/state**: `project/bridge_01`, civic `project_funds`, civic `project_stages`, current stage set for the project.
- **Ownership scope**: Civic.
- **Visible consequence**: Players can tell the bridge is moving from early work toward completion, not just filling an invisible meter.
- **Save impact**: Current bridge stage must persist and match the saved project fund state after reload.
- **Failure cases to handle**: project fund total and stage getting out of sync, stage order breaking, stage state resetting or skipping incorrectly on reload.
- **Done when**: Stage changes track the current project definition, remain legible before completion, and stay in sync after save/load.

### Bridge Completion Outcome
- **Goal**: Turn bridge completion into a durable visible world change.
- **Player-facing behavior**: Completing `project/bridge_01` unlocks the completed bridge outcome and the world stays changed.
- **Required inputs/state**: `project/bridge_01`, `place/bridge_site`, `place/bridge`, civic `unlocked_places` or equivalent current civic outcome state.
- **Ownership scope**: Civic.
- **Visible consequence**: The bridge is complete as a shared access outcome and players can tell the world is meaningfully different.
- **Save impact**: Completion state and unlocked outcome state must persist across save/load.
- **Failure cases to handle**: outcome unlocking early, outcome not unlocking at completion, completion state reverting after reload.
- **Done when**: Completion unlocks the defined bridge outcome, the changed place remains changed after reload, and the result reads as a civic world change rather than only an internal flag.

### Basic Baker Commentary
- **Goal**: Let `npc/baker` reflect the craft and trade loop through simple state-based feedback.
- **Player-facing behavior**: The baker comments differently based on relevant slice state such as making, selling, or productive progress.
- **Required inputs/state**: `npc/baker`, basic craft and progress state actually used by the implementation.
- **Ownership scope**: NPC identity is civic or place-based; commentary should react to player state without introducing new scope systems.
- **Visible consequence**: The player hears simple commentary that reflects what they did in the slice.
- **Save impact**: If any baker-related NPC state is stored, it must be explicit and survive reload; stateless commentary is acceptable.
- **Failure cases to handle**: generic chatter, lore dumping, commentary detached from real slice state, hidden new NPC systems.
- **Done when**: The baker has at least simple conditional commentary tied to the slice loop and that commentary remains structurally simple, state-based, and save-safe.

### Basic Builder Commentary
- **Goal**: Let `npc/builder` reflect civic contribution and bridge progress through simple state-based feedback.
- **Player-facing behavior**: The builder comments differently based on contribution, stage progression, and completion state.
- **Required inputs/state**: `npc/builder`, bridge contribution state, bridge stage state, bridge completion state.
- **Ownership scope**: NPC identity is civic or place-based; commentary should react to civic progress without introducing deeper social systems.
- **Visible consequence**: The player gets simple feedback that the bridge work matters and is changing.
- **Save impact**: If any builder-related NPC state is stored, it must be explicit and survive reload; stateless commentary is acceptable.
- **Failure cases to handle**: commentary detached from project state, exposition dumping, silent introduction of deeper judgment or social systems.
- **Done when**: The builder's commentary changes with bridge state, remains structurally simple, and does not depend on hidden later-scope systems.

## Cross-Feature Requirements
- Canonical IDs are used consistently across doc, data, runtime references, and saves.
- Starter records align to `content_schema_reference.md` before features claim done.
- Ownership scope is explicit for every feature and never implied.
- Save/load does not require guesswork about player, household, or civic state.
- Visible world response exists across the slice, not just internal counters.
- Parent-child co-op remains legible in one shared world.
- No feature silently introduces later-scope systems such as household gameplay, governance, rumors, or advanced NPC intelligence.

## Child and Co-op Legibility Checks
### Young Child Readability
- Can a child point to where apples come from?
- Can a child see why pie is worth making?
- Can a child tell why the tree matters later and not only now?
- Can a child notice that the bridge changed because people contributed?

### Parent-Child Co-op Readability
- Can each player tell what is personal and what is shared?
- Is shared bridge progress legible to both players?
- Does the slice read as one shared world rather than two isolated loops happening side by side?

## Save and Migration Checks
- A fresh load with no prior save produces valid player and world state.
- Milestone 1 flows preserve the relevant state on reload:
  - player inventory
  - player coins
  - player owned assets
  - civic `project_funds`
  - civic `project_stages`
  - civic completion or unlocked-place outcome state
  - any NPC state actually used
- `save_version` and `content_version` must be present after these flows.
- No feature may depend on display names or engine-facing names as save keys.
- Reload must not duplicate or erase apples, coins, tree ownership, project progress, or completion state.

## Explicit Non-Goals
- advanced NPC intelligence
- deeper economy simulation
- taxes, inheritance, or governance systems
- new districts
- advanced UI polish
- public multiplayer assumptions

## Exit Condition
Milestone 1 implementation is complete only when:

- all ten feature entries meet their own `Done when` criteria
- cross-feature requirements hold across the whole slice
- child and co-op legibility checks pass in practice
- save and migration checks pass without guesswork
- no Milestone 1 feature depends on undocumented ownership, save, or future-system assumptions

## Final Rule
If the slice is not clear, visible, and save-safe, it is not done.
