# Block D Plan

## Purpose
Block D lightly acknowledges already-verified orchard, tree, and bridge consequences so the world feels socially noticed without letting text carry the slice.

## Core Rule
Block D is reflection, not exposition. It is event-driven, sparse, and subordinate to verified Block A, B, and C truth. It does not change canonical IDs, save authorities, or ownership scopes.

## What Block D Must Do
- Notice a very small set of real milestone outcomes that already matter in Milestone 1.
- Attach one short reflection line from the right NPC after the success result is already known.
- Reinforce the difference between personal progress and civic progress.
- Stay mechanically passive and never become a second source of game meaning.

## What Block D Must Not Become
- Freeform dialogue or chat trees.
- NPC memory or reputation systems.
- Household semantics or co-op governance.
- Generalized narrative or event frameworks.
- Chatter on routine actions or failed actions.

## Candidate Trigger Events
Block D should use only these trigger events in Milestone 1:
- successful apple tree purchase
- first successful bridge contribution in the world
- bridge reaches `framing`
- bridge reaches `complete`

Detection should use only pre/post success-state transitions:
- Tree purchase: pre ownership false, post ownership true.
- First bridge contribution: pre funds `0`, post funds `> 0`.
- Framing: pre stage not `framing`, post stage `framing`.
- Complete: pre stage not `complete`, post stage `complete`.

## Reflection Surfaces
Possible surfaces include appended NPC chat lines, ambient world messages, talk nodes, or dedicated dialogue UI. Milestone 1 should use only one surface: a single NPC-attributed follow-up chat line appended to the existing success message at the relevant interaction point. Ambient chatter, talk nodes, dedicated dialogue UI, and world broadcasts should stay out of Block D.

## State Model Recommendation
Two shapes are possible:
- Stateless: derive reflection from the triggering action plus pre/post player and world state.
- Tiny stateful: save once-only reflection flags.

Milestone 1 should use the stateless shape. Block D should not use `known_npcs`, `npc_memory`, or any new saved reflection ledger. Saves remain unchanged.

## Message Design Rules
- Warm and concrete.
- Child-legible on first read.
- One short sentence only.
- One reflection line max per trigger.
- Success-only.
- No lectures, fake wisdom, lore dumps, or abstract economy language.
- No reflection on pickup, routine crafting, routine harvest, failures, or repeated bridge or tree actions beyond the listed triggers.

## Co-op Rules
Personal reflection goes only to the acting player. Civic reflection reads shared bridge truth, never private hidden counters. No partner comparison, blame, praise, or household framing. The visible world change remains the main civic proof.

## Best Practical Block D Shape
Use one closed trigger-to-line selector invoked directly from existing Block B and Block C success handlers. Baker handles tree-purchase reflection. Builder handles first bridge contribution, `framing`, and `complete`. Keep output fixed:
- line 1: existing mechanical result or status
- line 2: optional Baker or Builder reflection

This shape is stateless, event-time, NPC-attributed, and limited to the four trigger events above. It does not add an event bus, dialogue state machine, memory layer, or new NPC placement system.

## Deferred To Later
- talk nodes
- commissions
- branching dialogue
- NPC memory
- rumor or trust systems
- household commentary
- extra NPCs
- ambient barks
- generalized narrative tooling

## Recommendation
Ship the smallest earned reaction layer, let the tree and bridge outcomes do most of the explanatory work, and keep Block D subordinate to visible consequence.

## Final Rule
If the player can already see it, Block D should only help it land.
