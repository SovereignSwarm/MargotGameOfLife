# Milestone 2 Plan

## Purpose
Milestone 2 should introduce household scope and the first meaningful household trade-off. Its job is to make "ours" real between personal and civic life without resetting or casually rewriting the verified Milestone 1 baseline. This doc remains the scope and boundary anchor for Milestone 2; the first pantry-only implementation shape is now active, but this plan still does not authorize silent widening beyond that shape.

## Why Household Comes Next
Milestone 1 proved personal agency and civic consequence. The next missing layer is the shared household authority between "mine" and "town," which the roadmap and phase plan already identify as the next clean co-op problem.

## Core Question
What should become "ours" while protecting what remains "mine" and what already belongs to town?

## What Household Must Mean In This Game
Household is a narrow shared authority layer for intentionally committed shared holdings and the decisions attached to them. Goods enter household scope only through explicit player action, never automatically from personal inventory, world pickup, or co-op presence. Household is not automatic pooling, not civic state, and not a blur of personal inventories.

## What Must Stay Personal
- `player_state.coins`
- carried inventory by default unless a player intentionally transfers goods out of it
- personal `asset/apple_tree` ownership in `player_state.owned_assets`
- personal tree yield and related timing state
- personal sale outcomes and personal spending decisions
- personal-to-civic bridge contribution; it does not become a household spend path

## What May Become Household Scope
- one explicit household holdings store for selected existing slice goods
- initial candidate goods: `item/apple` and `item/flour` committed by choice into shared household use
- one narrow shared-use layer around those holdings for later household baking decisions

## First Household Trade-Off Recommendation
Start with one shared household pantry / baking reserve for `item/apple` and `item/flour` only. The first trade-off should be whether those inputs stay personal for the acting player's immediate baking or saving plan, or are deliberately committed into shared household holdings for later shared use.

## State / Save Boundary Recommendation
Milestone 2 should activate only one deliberate household authority under `world_state.household`, not treat the whole reserved table as live by default. The safest first candidate is `world_state.household.inventory`, while `household.owned_assets` and `household.upgrades` stay reserved. `world_state.players` remains non-authoritative for personal state, per-player saves remain the only personal authority, and civic bridge state remains under `world_state.civic`. Do not let personal, household, and civic writes drift into one mixed path. Deposit is the easy part; withdrawal and use rules are the real boundary risk and must be defined explicitly before implementation.

## Co-op Rules
- household is shared by the two co-op players in the same world
- both players should be able to see the same household holdings
- goods enter household scope only through explicit deposit
- personal goods remain personal and do not become household goods automatically
- household use must read from household authority when invoked, not silently from personal inventories
- no parent/child admin hierarchy is assumed in the first Milestone 2 shape
- civic bridge state and civic contributions remain civic, not household-governed

## What Milestone 2 Must Not Break
- `player_state.coins` remains the only spendable personal coin authority
- `player_state.owned_assets["asset/apple_tree"]` remains the only starter tree ownership authority
- per-player persistence remains the durable authority for personal inventory, coins, and owned assets
- `world_state.civic.project_funds`, `project_stages`, and `unlocked_places` remain the civic bridge authorities
- Block D remains stateless, success-only, four-trigger, and outside household semantics

## Smallest Good Milestone 2 Shape
Milestone 2 should prove one explicit household pantry layer only: a small shared reserve for intentionally deposited `item/apple` and `item/flour`, plus one real decision about whether those inputs stay personal or become household-ready. That is enough to make "ours" real without shared coins, shared tree conversion, new civic projects, NPC expansion, or a home-building system.

## Deferred To Later
- household-owned productive assets, including any shared tree
- household coins, budgeting, or pooled spending
- finished-goods defaulting into household property
- governance, politics, or broader civic institutions
- deeper NPC household commentary, memory, trust, or commission systems
- extra districts, professions, or broader social simulation

## Recommendation
Treat Milestone 2 as the smallest possible proof of household meaning. Prove one explicit shared holding and one real shared trade-off first, then judge whether the household layer is legible and save-safe before expanding it.

## Final Rule
Protect mine, define ours, leave town alone.
