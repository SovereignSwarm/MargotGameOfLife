local state = {}

local function deep_copy(value)
    if type(value) ~= "table" then
        return value
    end

    local copy = {}

    for key, nested_value in pairs(value) do
        copy[key] = deep_copy(nested_value)
    end

    return copy
end

local function stamp_versions(target)
    target.save_version = margot.runtime.migrations.current_save_version
    target.content_version = margot.runtime.migrations.current_content_version
    return target
end

function state.clone(value)
    return deep_copy(value)
end

function state.new_player_state(player_id)
    return stamp_versions({
        player_id = player_id or "",
        inventory = {},
        coins = 0,
        owned_assets = {},
        known_npcs = {},
        npc_memory = {},
    })
end

function state.new_household_state()
    return {
        inventory = {},
        owned_assets = {},
        upgrades = {},
    }
end

function state.new_civic_state()
    return {
        project_funds = {},
        project_stages = {},
        unlocked_places = {},
    }
end

function state.new_world_state()
    return stamp_versions({
        players = {},
        household = state.new_household_state(),
        civic = state.new_civic_state(),
    })
end

function state.ensure_player_state_shape(existing, player_id)
    local working = existing or {}

    working.player_id = working.player_id or player_id or ""
    working.inventory = working.inventory or {}
    working.coins = working.coins or 0
    working.owned_assets = working.owned_assets or {}
    working.known_npcs = working.known_npcs or {}
    working.npc_memory = working.npc_memory or {}

    return stamp_versions(working)
end

function state.ensure_world_state_shape(existing)
    local working = existing or {}

    working.players = working.players or {}
    working.household = working.household or state.new_household_state()
    working.household.inventory = working.household.inventory or {}
    working.household.owned_assets = working.household.owned_assets or {}
    working.household.upgrades = working.household.upgrades or {}

    working.civic = working.civic or state.new_civic_state()
    working.civic.project_funds = working.civic.project_funds or {}
    working.civic.project_stages = working.civic.project_stages or {}
    working.civic.unlocked_places = working.civic.unlocked_places or {}

    return stamp_versions(working)
end

function state.copy_player_state(player_state, player_id)
    return state.ensure_player_state_shape(deep_copy(player_state or {}), player_id)
end

function state.copy_world_state(world_state)
    return state.ensure_world_state_shape(deep_copy(world_state or {}))
end

margot.runtime.state = state
