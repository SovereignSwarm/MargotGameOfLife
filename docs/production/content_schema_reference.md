# Content Schema Reference

## Purpose
This is a compact design-facing reference for early content tables. It defines the stable fields that content records should carry before engine-specific concerns are layered on top.

## General Rule
- use canonical IDs from `id_policy.md`
- keep display names separate from IDs
- prefer optional fields and safe defaults over one-off record shapes

## Authority Clarification
- Content records may describe visible concepts such as `item/coin` and `item/tree_deed`.
- Spendable balances and ownership ledgers must still name one authoritative saved state.
- Do not let a content record imply a second currency authority or a second ownership authority unless the save policy explicitly permits it.

## Item
Required:
- `id`
- `display_name`
- `object_kind`
- `summary`

Optional:
- `tags`
- `sale_value`
- `purchase_value`
- `default_scope`
- `consumption_effect`
- `notes`

## Recipe
Required:
- `id`
- `display_name`
- `inputs`
- `outputs`
- `place_id`

Optional:
- `tool_ids`
- `duration_hint`
- `unlock_condition`
- `notes`

## Asset
Required:
- `id`
- `display_name`
- `asset_kind`
- `summary`
- `default_scope`

Optional:
- `purchase_cost`
- `yield_cycle`
- `yield_outputs`
- `maintenance`
- `related_place_id`
- `notes`

## Place
Required:
- `id`
- `display_name`
- `place_kind`
- `summary`

Optional:
- `default_scope`
- `district_id`
- `available_activity_ids`
- `state_tags`
- `notes`

## Project
Required:
- `id`
- `display_name`
- `summary`
- `site_place_id`
- `default_scope`

Optional:
- `stages`
- `contribution_rules`
- `outcome_ids`
- `related_district_id`
- `notes`

## NPC Profile
Required:
- `id`
- `display_name`
- `actor_kind`
- `summary`

Optional:
- `role`
- `home_place_id`
- `priorities`
- `request_types`
- `memory_tags`
- `notes`

## Commission
Required:
- `id`
- `display_name`
- `issuer_npc_id`
- `summary`
- `requested_outputs`

Optional:
- `related_place_id`
- `deadline_window`
- `reward`
- `consequence_tags`
- `notes`

## Event
Required:
- `id`
- `display_name`
- `event_kind`
- `summary`

Optional:
- `scope`
- `availability_window`
- `affected_place_ids`
- `related_project_id`
- `related_season`
- `notes`
