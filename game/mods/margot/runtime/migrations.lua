local migrations = {
    current_save_version = 1,
    current_content_version = 1,
}

local function stamp_versions(state)
    state.save_version = migrations.current_save_version
    state.content_version = migrations.current_content_version
    return state
end

function migrations.migrate_world_state(state)
    local working = state or {}
    local version = tonumber(working.save_version) or 0

    if version < 1 then
        working.players = working.players or {}
        working.household = working.household or {}
        working.civic = working.civic or {}
    end

    return stamp_versions(working)
end

function migrations.migrate_player_state(state, player_id)
    local working = state or {}
    local version = tonumber(working.save_version) or 0

    if version < 1 then
        working.player_id = working.player_id or player_id or ""
        working.inventory = working.inventory or {}
        working.coins = working.coins or 0
        working.owned_assets = working.owned_assets or {}
        working.known_npcs = working.known_npcs or {}
        working.npc_memory = working.npc_memory or {}
    end

    return stamp_versions(working)
end

margot.runtime.migrations = migrations
