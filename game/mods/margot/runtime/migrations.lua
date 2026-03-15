local migrations = {
    current_save_version = 3,
    current_content_version = 1,
}

local function stamp_versions(state)
    state.save_version = migrations.current_save_version
    state.content_version = migrations.current_content_version
    return state
end

local function normalize_household_pantry_inventory(working)
    local household = working.household or {}
    local inventory = household.inventory or {}
    local supported_item_ids = {
        "item/apple",
        "item/flour",
    }

    for _, item_id in ipairs(supported_item_ids) do
        local raw_value = inventory[item_id]
        local amount = math.floor(tonumber(raw_value) or 0)

        if amount <= 0 then
            inventory[item_id] = nil
        else
            inventory[item_id] = amount
        end
    end

    household.inventory = inventory
    working.household = household
end

function migrations.migrate_world_state(state)
    local working = state or {}
    local version = tonumber(working.save_version) or 0

    if version < 1 then
        working.players = working.players or {}
        working.household = working.household or {}
        working.civic = working.civic or {}
    end

    if version < 2 then
        normalize_household_pantry_inventory(working)
    end

    if version < 3 then
        working.civic = working.civic or {}
        working.civic.place_conditions = working.civic.place_conditions or {}
        working.civic.project_stages = working.civic.project_stages or {}

        if working.civic.place_conditions["place/crafting_station"] == nil then
            if working.civic.project_stages["project/bridge_01"] == "complete" then
                working.civic.place_conditions["place/crafting_station"] = "not_ready"
            end
        end
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
