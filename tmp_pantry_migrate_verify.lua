local runner_name = "pantry_migrate"
local original_chat_send_player = minetest.chat_send_player

local function log(message)
    minetest.log("action", "[pantry_migrate_verify] " .. message)
end

local function copy_player_state(player_name)
    return margot.runtime.persistence.load_player_state(player_name)
end

local function save_player_state(player_name, player_state)
    return margot.runtime.persistence.save_player_state(player_name, player_state)
end

local function copy_world_state()
    return margot.runtime.state.copy_world_state(margot.runtime.persistence.load_world_state())
end

local function save_world_state(world_state)
    local saved = margot.runtime.persistence.save_world_state(world_state)
    margot.runtime.world_state = saved
    return saved
end

local function count_item(state, item_id)
    return margot.runtime.state.get_inventory_count((state or {}).inventory, item_id)
end

local function log_player(label, player_name)
    local state = copy_player_state(player_name)
    local tree_state = ((state.owned_assets or {})["asset/apple_tree"])
    local tree_ready = tree_state and tonumber(tree_state.next_ready_day) or "none"

    log(string.format(
        "player label=%s name=%s apples=%d flour=%d pie=%d coins=%d tree_next=%s save=%s content=%s",
        label,
        player_name,
        count_item(state, "item/apple"),
        count_item(state, "item/flour"),
        count_item(state, "item/pie"),
        tonumber(state.coins) or 0,
        tostring(tree_ready),
        tostring(state.save_version),
        tostring(state.content_version)
    ))
end

local function log_world(label)
    local state = copy_world_state()
    local counts = margot.systems.household.get_pantry_counts(state) or {
        ["item/apple"] = -1,
        ["item/flour"] = -1,
    }
    local civic = state.civic or {}

    log(string.format(
        "world label=%s pantry_apples=%d pantry_flour=%d funds=%d stage=%s unlocked=%s household_assets=%d household_upgrades=%d players=%d save=%s content=%s",
        label,
        counts["item/apple"] or 0,
        counts["item/flour"] or 0,
        tonumber((civic.project_funds or {})["project/bridge_01"]) or 0,
        tostring((civic.project_stages or {})["project/bridge_01"]),
        tostring((civic.unlocked_places or {})["place/bridge"] == true),
        next((state.household or {}).owned_assets or {}) == nil and 0 or 1,
        next((state.household or {}).upgrades or {}) == nil and 0 or 1,
        next(state.players or {}) == nil and 0 or 1,
        tostring(state.save_version),
        tostring(state.content_version)
    ))
end

minetest.chat_send_player = function(player_name, message)
    log("chat player=" .. player_name .. " message=" .. string.gsub(message or "", "\n", "\\n"))
    return original_chat_send_player(player_name, message)
end

minetest.register_on_joinplayer(function(player)
    if player:get_player_name() ~= runner_name then
        return
    end

    minetest.after(2, function()
        local ok, err = xpcall(function()
            log_world("migration_loaded")
            log_player("migration_sanity_tree_loaded", "sanity_tree")
            log_player("migration_verify_a_loaded", "verify_a")
            log_player("migration_verify_b_loaded", "verify_b")
            log_player("migration_verify_c_loaded", "verify_c")

            save_world_state(copy_world_state())
            save_player_state("sanity_tree", copy_player_state("sanity_tree"))
            save_player_state("verify_a", copy_player_state("verify_a"))
            save_player_state("verify_b", copy_player_state("verify_b"))
            save_player_state("verify_c", copy_player_state("verify_c"))

            log_world("migration_saved")
            log_player("migration_sanity_tree_saved", "sanity_tree")
            log_player("migration_verify_a_saved", "verify_a")
            log_player("migration_verify_b_saved", "verify_b")
            log_player("migration_verify_c_saved", "verify_c")

            minetest.request_shutdown("pantry_migrate_verify_complete")
        end, debug.traceback)

        if not ok then
            log("fatal error=" .. tostring(err))
            minetest.request_shutdown("pantry_migrate_verify_failed")
        end
    end)
end)
