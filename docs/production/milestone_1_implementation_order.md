# Milestone 1 Implementation Order

## Purpose
This document locks the safest build sequence for Orchard and Bridge so implementation follows dependency and meaning instead of whatever feels most convenient in the moment.

## Core Rule
Implementation order must follow dependency and meaning, not convenience.

## Ordered Build Blocks
### Block A — Mechanical Value Loop
Build the first complete personal value loop from gathering through earning.

### Block B — Productive Ownership
Add the tree only after the player can already create and save value.

### Block C — Civic Consequence
Add the bridge only after personal value can be converted into visible shared consequence.

### Block D — Reflective Social Layer
Add NPC commentary only after the underlying state changes they reflect already exist.

## Feature Order Inside Each Block
1. **Block A — Mechanical Value Loop**: apple source / pickup -> pie recipe / crafting -> pie sale / coin earning
2. **Block B — Productive Ownership**: apple tree purchase -> recurring tree yield
3. **Block C — Civic Consequence**: bridge contribution -> bridge stage progression -> bridge completion outcome
4. **Block D — Reflective Social Layer**: basic baker commentary -> basic builder commentary

## Why This Order
This order proves the smallest true meaning chain first: make value, keep value, invest value, then reflect on the consequences. It prevents Milestone 1 from hiding missing mechanics behind NPC text, civic meters, or speculative co-op systems, and it keeps each later block dependent on a real earlier block instead of on placeholder intent.

## Exit Condition For Each Block
- **Block A**: a player can gather apples, craft pies, sell pies for personal coin balance, and preserve that loop across save/load.
- **Block B**: a player can spend personal coins on `asset/apple_tree`, record ownership only in `owned_assets`, and receive repeatable personal yield under a clear saved rule.
- **Block C**: a player can convert personal coin value into civic bridge progress, see staged change, and preserve civic progress and completion across save/load.
- **Block D**: the baker and builder both react to real slice state without introducing new ownership, save, or social systems.

## What Must Not Be Pulled Forward
- recurring tree yield before tree purchase works
- bridge stages or completion before bridge contribution works
- baker or builder commentary before the underlying loop state exists
- household semantics
- mixed-scope inventory
- advanced NPC memory or judgment systems
- extra districts, professions, or civic projects

## Final Rule
Build meaning before reflection.
