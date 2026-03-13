# Milestone 1 Ownership Semantics

## Purpose
This document locks the ownership meaning for Orchard and Bridge so Milestone 1 implementation does not invent scope rules in code, saves, or NPC logic.

## Core Rule
Ownership scope must be explicit and never implied in Milestone 1.

## Scope Layers Used In Milestone 1
- **Personal**: one player's carried goods, coin balance, owned tree state, and personal consequences.
- **Civic**: the shared world layer for common places, bridge progress, and bridge completion outcomes.
- **Household** is deferred for now. It remains a future scope layer, not an active Milestone 1 gameplay authority.

## Ownership Matrix
| Slice element | Ownership scope | Milestone 1 rule |
| --- | --- | --- |
| inventory items | Personal | Each player's inventory is separate and save-owned by that player. |
| coins | Personal | `player_state.coins` is the only spendable authority in Milestone 1. |
| crafted pies | Personal | Crafted pies stay personal until sold or used by that same player. |
| `item/tree_deed` if it exists | Personal, non-authoritative | The deed may exist as a visible concept or receipt, but it never grants ownership by itself. |
| placed `asset/apple_tree` | Personal | `player_state.owned_assets["asset/apple_tree"]` is the only ownership authority for the starter tree. |
| bridge contribution value | Personal -> Civic at contribution commit | Coins leave personal state and become civic value only when the contribution is accepted. |
| bridge progress | Civic | Bridge fund totals, stage state, and completion state belong to the civic layer. |
| bridge completion outcome | Civic | The completed bridge is a shared access change for the world, not a personal unlock. |
| baker commentary trigger context | Personal player state read by a civic NPC | The baker reacts to personal craft, sale, or productive progress without creating a new shared scope. |
| builder commentary trigger context | Civic bridge state, with explicit personal contribution facts only if directly read | The builder reacts to the shared project state first and only reads personal contribution facts when they are explicitly available. |

## Co-op Semantics For Milestone 1
Co-op in Milestone 1 means one shared world with shared civic places, shared bridge state, and shared NPC presence. It does not mean shared inventories, shared coin balances, shared tree ownership, shared tree yield, shared household spending, or mixed-scope inventory. The point at this stage is to make "my things" and "the town's things" legible without letting two solo players accidentally share everything.

## Out Of Scope For Milestone 1
- household asset semantics
- shared household spending
- true mixed-scope inventory
- more advanced co-owned systems

## Final Rule
If scope is not named, it is not ready.
