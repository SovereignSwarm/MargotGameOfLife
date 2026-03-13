local ownership = {
    scopes = {
        personal = true,
        household = true,
        civic = true,
    },
}

local function normalize_saved_day(value, fallback)
    local fallback_day = math.floor(tonumber(fallback) or 0)
    local day = math.floor(tonumber(value) or fallback_day)

    if day < 0 then
        return fallback_day
    end

    return day
end

function ownership.normalize_scope(scope)
    if ownership.scopes[scope] then
        return scope
    end

    return "personal"
end

function ownership.new_claim(scope, owner_id)
    return {
        scope = ownership.normalize_scope(scope),
        owner_id = owner_id,
    }
end

function ownership.get_scope_state(world_state, scope)
    local normalized_scope = ownership.normalize_scope(scope)
    local prepared_world = margot.runtime.state.ensure_world_state_shape(world_state)

    if normalized_scope == "household" then
        return prepared_world.household
    end

    if normalized_scope == "civic" then
        return prepared_world.civic
    end

    return prepared_world.players
end

function ownership.player_owns_personal_asset(player_state, asset_id)
    return ((player_state or {}).owned_assets or {})[asset_id] ~= nil
end

function ownership.get_personal_asset_state(player_state, asset_id, fallback_day)
    if margot.data.assets[asset_id] == nil then
        return nil, nil, false, "unknown_asset"
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)
    local raw_state = next_state.owned_assets[asset_id]

    if raw_state == nil then
        return next_state, nil, false, nil
    end

    local asset_state = {}

    if type(raw_state) == "table" then
        asset_state = margot.runtime.state.clone(raw_state)
    end

    local purchased_day = normalize_saved_day(asset_state.purchased_day, fallback_day)
    local next_ready_day = normalize_saved_day(asset_state.next_ready_day, purchased_day + 1)
    local changed = type(raw_state) ~= "table"
        or asset_state.purchased_day ~= purchased_day
        or asset_state.next_ready_day ~= next_ready_day

    asset_state.purchased_day = purchased_day
    asset_state.next_ready_day = next_ready_day

    if changed then
        next_state.owned_assets[asset_id] = asset_state
    end

    return next_state, asset_state, changed, nil
end

function ownership.grant_personal_asset(player_state, asset_id, asset_state)
    if margot.data.assets[asset_id] == nil then
        return nil, "unknown_asset"
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)

    if next_state.owned_assets[asset_id] ~= nil then
        return nil, "already_owned"
    end

    next_state.owned_assets[asset_id] = margot.runtime.state.clone(asset_state or {})

    return next_state, nil
end

function ownership.update_personal_asset_state(player_state, asset_id, asset_state)
    if margot.data.assets[asset_id] == nil then
        return nil, "unknown_asset"
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)

    if next_state.owned_assets[asset_id] == nil then
        return nil, "missing_asset"
    end

    next_state.owned_assets[asset_id] = margot.runtime.state.clone(asset_state or {})

    return next_state, nil
end

margot.systems.ownership = ownership
