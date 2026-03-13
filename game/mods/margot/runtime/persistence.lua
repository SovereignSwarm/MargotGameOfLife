local persistence = {}
local storage = minetest.get_mod_storage()

local function deserialize(raw_value)
    if raw_value == nil or raw_value == "" then
        return nil
    end

    local ok, decoded = pcall(minetest.deserialize, raw_value)

    if ok then
        return decoded
    end

    return nil
end

local function player_storage_key(player_id)
    return "player/" .. tostring(player_id)
end

function persistence.load_world_state()
    local loaded_state = deserialize(storage:get_string("world_state"))
    loaded_state = margot.runtime.migrations.migrate_world_state(loaded_state)
    return margot.runtime.state.ensure_world_state_shape(loaded_state)
end

function persistence.save_world_state(world_state)
    local prepared_state = margot.runtime.state.copy_world_state(world_state)
    prepared_state = margot.runtime.migrations.migrate_world_state(prepared_state)

    storage:set_string("world_state", minetest.serialize(prepared_state))

    return prepared_state
end

function persistence.load_player_state(player_id)
    -- Milestone 1 durable personal state lives in per-player persistence, not in world_state.players.
    local loaded_state = deserialize(storage:get_string(player_storage_key(player_id)))
    loaded_state = margot.runtime.migrations.migrate_player_state(loaded_state, player_id)
    return margot.runtime.state.ensure_player_state_shape(loaded_state, player_id)
end

function persistence.save_player_state(player_id, player_state)
    -- Keep personal authority singular and save-safe by writing player state through the per-player key only.
    local prepared_state = margot.runtime.state.copy_player_state(player_state, player_id)
    prepared_state = margot.runtime.migrations.migrate_player_state(prepared_state, player_id)

    storage:set_string(player_storage_key(player_id), minetest.serialize(prepared_state))

    return prepared_state
end

margot.runtime.persistence = persistence
