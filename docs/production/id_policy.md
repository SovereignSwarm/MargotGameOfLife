# ID Policy

## Purpose
This policy defines the canonical ID format for long-lived content. Use these IDs in docs, data tables, saves, and migrations.

## Canonical Format
Use:

`<namespace>/<slug>`

Rules:
- lowercase only
- namespace is singular
- slug uses snake_case
- no spaces
- no display words such as "the" or punctuation-heavy labels

Example shape:
- `item/apple`
- `asset/apple_tree`

## Namespace Rule
Use a controlled namespace set for long-lived content:
- `item`
- `recipe`
- `asset`
- `place`
- `project`
- `npc`
- `commission`
- `event`

Do not invent new namespaces casually.

## Display Name vs Canonical ID
- The **canonical ID** is stable, machine-safe, and save-safe.
- The **display name** is player-facing and may change for clarity, tone, or localization.

Never use display names as save keys or content references.

## Rename Rule
Long-lived canonical IDs may not be renamed casually. Once a content ID is used in data, saves, or migrations, treat it as durable.

If a rename becomes unavoidable:
- deprecate the old ID
- add an explicit migration or alias path
- do not reuse the old ID for new meaning

## Examples
- `item/apple`
- `item/pie`
- `asset/apple_tree`
- `project/bridge_01`
- `npc/baker`
- `place/orchard`

## Engine Names
Engine-facing identifiers may be derived later for Luanti integration, but they should not replace canonical IDs in design docs or saved content references.
