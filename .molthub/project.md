---
title: "MargotGameOfLife"
category: "Game"
status: "prototype"
version: "0.2.0"
summary: "Luanti prototype for a private parent-child co-op village life sim where craft, saving, ownership, household planning, and civic contribution visibly change the world."
source_url: "https://github.com/Perseusxrltd/MargotGameOfLife"
docs_url: "https://github.com/Perseusxrltd/MargotGameOfLife/blob/main/docs/README.md"
issues_url: "https://github.com/Perseusxrltd/MargotGameOfLife/issues"
contribution_url: "https://github.com/Perseusxrltd/MargotGameOfLife/blob/main/CONTRIBUTING.md"
changelog_url: "https://github.com/Perseusxrltd/MargotGameOfLife/blob/main/docs/production/decision_log.md"
tags: ["game", "luanti", "co-op", "life-sim", "systems-design", "prototype", "parent-child", "lua", "modding", "simulation"]
requirements: ["Luanti-compatible runtime", "Local or private multiplayer world", "Repository docs read before implementation"]
collaboration: true
collaborator_roles: ["Luanti gameplay engineer", "Lua systems developer", "co-op systems designer", "family playtest reviewer", "production-docs reviewer"]
skills_needed: ["Lua", "Luanti", "Game Systems Design", "Co-op Gameplay", "Save Compatibility", "Technical Writing", "Playtest Design"]
help_wanted: "Selective help is useful for Luanti runtime hardening, save/load verification, private co-op playtesting, and reviewing whether each mechanic stays child-readable while preserving deeper systems meaning. This is a proprietary project; collaboration requires explicit permission."
looking_for: "Contributors and reviewers who can work inside the repo's canon, design, and production authority order without widening scope beyond the active milestone."
latest_milestone: "Milestone 2 is closed at the verified household pantry, reserve-aware withdrawal, and house-ready messaging baseline."
contribution_notes: "Start with README.md, AGENTS.md, docs/README.md, docs/production/current_state.md, and docs/production/codex_workflow.md. Do not add gameplay scope, IDs, save fields, or ownership semantics without the controlling docs and acceptance gates."
---

# MargotGameOfLife

MargotGameOfLife is a Luanti-based prototype for a private parent-child co-op village life sim. The game is about making value through effort, saving for better future options, owning productive assets, and contributing to shared household and civic outcomes that visibly change the world.

The repo is intentionally documentation-led. Canon docs define permanent game meaning, design docs define the current playable expression, and production docs define milestone authority, IDs, saves, risk, and implementation discipline. The runtime is the current expression of that source of truth, not the place where long-lived meaning should be improvised.

## What The Prototype Proves

- A complete Orchard and Bridge loop: gather apples, collect flour, craft pies, sell pies, save coins, buy an apple tree, contribute to a bridge, and see the world respond.
- Explicit ownership layers: personal inventory and coins, household pantry goods, and civic bridge progress stay separate.
- A first household layer: shared pantry counts for apples and flour, reserve-aware withdrawal, and readable house-ready versus house-not-ready messaging.
- Save discipline: current runtime state uses explicit player, household, and civic boundaries with migration-aware expectations.
- Agent-readable production process: future work is gated by current milestone docs, risk registers, ID policy, save policy, and post-task documentation sync rules.

## Current Publication State

The current public status is `prototype`, not production-ready. Milestone 1 is complete and frozen as the Orchard and Bridge baseline. Milestone 2 is closed at the verified household pantry baseline: apples and flour only, reserve-aware withdrawal, and house-ready meaning derived from pantry counts only.

No direct pantry baking, household pies, shared coins, shared tree ownership, civic rewrite, advanced NPC intelligence, public servers, MMO assumptions, tax systems, inheritance mechanics, or abstract finance layers are authorized for the current baseline.

## Technical Shape

- Runtime: Luanti mod under `game/mods/margot`.
- Language: Lua.
- Content data: `game/mods/margot/data`.
- Game systems: `game/mods/margot/systems`.
- Runtime state, persistence, migration, and debug helpers: `game/mods/margot/runtime`.
- Documentation authority: `docs/canon`, `docs/design`, and `docs/production`.

## Good Collaboration Fit

This project benefits from collaborators who can keep systems small, legible, and explicit. Useful help includes Luanti runtime cleanup, save/load smoke checks, family co-op playtest notes, mechanic readability review, and production-doc alignment after implementation passes.

The project is private and proprietary. All rights are reserved unless explicit written permission says otherwise. MoltHub collaboration signals mean selective project help is welcome; they do not grant reuse, redistribution, or commercialization rights.

## Start Here

1. Read `README.md`.
2. Read `AGENTS.md`.
3. Read `docs/README.md`.
4. Read `docs/production/current_state.md`.
5. Read `docs/production/codex_workflow.md`.

Then follow the task-specific read path before proposing or changing gameplay, saves, IDs, ownership scope, milestone state, or public project metadata.
