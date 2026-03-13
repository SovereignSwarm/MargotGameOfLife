This file matters a lot. It is your repo brain for Codex/Cursor.

# AGENTS.md

## Project role
You are working on MargotGameOfLife, a parent-child co-op village life sim built for Luanti.

## Canonical design authority
- `docs/game_constitution.md` is the permanent conceptual source of truth.
- If another design doc conflicts with it, the constitution wins.
- Grow the game additively by instantiating its permanent verbs, entities, loop families, and ownership model rather than replacing them.

## Product goal
Create a living world that teaches through play:
- value creation
- stewardship
- critical thinking
- trade-offs
- ownership
- craft mastery
- visible society systems
- long-term thinking

## Core design rule
Money is fuel, not the goal.
Every purchase must improve one or more of:
- capability
- beauty
- status
- freedom
- shared life

## v1 scope
Only build the smallest possible vertical slice proving:
- apple gathering
- pie crafting
- selling for coins
- saving
- buying one productive asset (tree)
- contributing to one shared bridge fund
- visible village improvement
- simple NPC commentary

## Hard constraints
- Keep code small, readable, and modular.
- Prefer data-driven definitions over hardcoded branching.
- Do not add speculative systems.
- Do not build features outside the current milestone unless required.
- Do not introduce LLM-dependent runtime features.
- Do not optimize for scale before the loop works.
- Use placeholders freely.

## Coding style
- Small files
- Clear naming
- Minimal abstraction
- Avoid cleverness
- Add comments only where they reduce ambiguity
- Prefer deterministic gameplay systems
- Keep multiplayer/state logic explicit

## Architecture rule
Separate logic by domain:
- items
- crafting
- economy
- village progression
- NPC reactions
- player progression

## Decision rule
When unsure, choose the option that:
1. makes the child-readable loop clearer
2. makes the codebase easier for AI agents to modify
3. reduces scope
4. proves the product thesis faster
