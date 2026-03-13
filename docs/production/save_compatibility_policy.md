# Save Compatibility Policy

## Purpose
This policy exists to keep early saves from becoming disposable by accident. It defines how state shape changes, content changes, and ID changes should be handled while the project is still small.

## Version Types
- **save_version**: the version of serialized state shape and semantics
- **content_version**: the version of long-lived content definitions that active saves may reference

Both versions start small, but both must be tracked deliberately.

## Baseline Rules
- Bump `save_version` when serialized state structure or meaning changes.
- Bump `content_version` when long-lived content definitions change in ways that active saves may care about.
- Store both versions on saved data.
- Keep personal, household, and civic state separable so migrations stay local and legible.

## Additive vs Breaking Change
- **Usually additive**: adding new content IDs, adding optional fields with safe defaults, adding new project stages that old saves can default into cleanly
- **Potentially breaking**: renaming canonical IDs, changing ownership scope semantics, changing saved table shape, changing what a stored value means, removing content that active saves may reference

If an old save cannot be loaded without guesswork, the change is breaking.

## Migration Policy
- Every breaking save change needs an explicit migration path.
- Migrations must be deterministic, one-way, and easy to inspect.
- Prefer a chain of small migrations over one opaque rewrite.
- No migration should silently discard meaningful player, household, or civic state.
- Content migrations and save-shape migrations should stay distinct when possible.

## Renaming and Deprecating IDs
- Never casually rename long-lived canonical IDs.
- Prefer deprecation plus migration over direct renaming.
- Do not reuse retired IDs for new meaning.
- If an ID must change, add a clear alias/deprecation mapping and migrate saved references deliberately.

## Early Warning Signs
- save files start mixing design names, engine names, and canonical IDs
- content is referenced by display name
- personal, household, and civic data are stored in one opaque blob
- saved values no longer have a clear meaning
- content is removed before a migration story exists
- IDs are changed to make data "look nicer"

## Default Early-Stage Posture
Be conservative. The repo is small enough to stay disciplined now and expensive enough that casual save breakage will slow future work.
