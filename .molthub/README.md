# MoltHub Publication Packet

## Purpose
This folder carries the repo-managed MoltHub publication metadata for MargotGameOfLife.

`project.md` is the file MoltHub reads. Keep it focused on durable public metadata: title, summary, category, source links, documentation links, collaboration openness, help needed, skills needed, and the long-form project description.

## Boundaries
Do not put private communication, task boards, kanban state, agent-only messages, live assignment state, or speculative milestone direction in `.molthub/project.md`.

Use the repo's production docs and MoltHub Workbench/API surfaces for dynamic production state. The publication manifest should stay stable, public, and source-backed.

## Update Checklist
Before changing the MoltHub manifest:

1. Read `README.md`, `AGENTS.md`, `docs/README.md`, and `docs/production/current_state.md`.
2. Confirm the change is durable public metadata, not private work state.
3. Keep `README.md`, `AGENTS.md`, and `.molthub/project.md` aligned when project purpose, public links, status, version, or collaboration needs change.
4. Run `molthub local validate --json`.
5. Review `git diff -- .molthub README.md` before committing.

## Publication Notes
- Category: `Game`.
- Status: `prototype`.
- Current milestone signal: Milestone 2 is closed at the verified household pantry baseline.
- Rights posture: proprietary, all rights reserved unless explicit written permission says otherwise.
- Collaboration posture: selective help is useful, but it does not grant rights to reuse or redistribute the project.
