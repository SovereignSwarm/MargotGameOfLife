local phase = tonumber(minetest.settings:get("pantry_verify_phase") or "1") or 1
local runner_by_phase = {
    [1] = "pantry_a",
    [2] = "pantry_b",
    [3] = "pantry_a",
}
local players = {
    a = "pantry_a",
    b = "pantry_b",
}
local offsets = {
    orchard = { x = 0, y = 0, z = 0 },
    flour_bin = { x = 1, y = 0, z = 0 },
    crafting_station = { x = 2, y = 0, z = 0 },
    market_stall = { x = 3, y = 0, z = 0 },
    apple_tree = { x = 4, y = 0, z = 0 },
    bridge_site = { x = 5, y = 0, z = 1 },
    apple_deposit = { x = 0, y = 0, z = -1 },
    flour_deposit = { x = 1, y = 0, z = -1 },
    pantry_read = { x = 2, y = 0, z = -1 },
    apple_withdraw = { x = 3, y = 0, z = -1 },
    flour_withdraw = { x = 4, y = 0, z = -1 },
}
local original_chat_send_player = minetest.chat_send_player

local function log(message)
    minetest.log("action", "[pantry_verify] " .. message)
end

local function encode_message(message)
    return string.gsub(message or "", "\n", "\\n")
end

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
end

local function get_place_pos(layout, offset)
    return add_pos(layout.anchor, offset)
end

local function count_item(state, item_id)
    return margot.runtime.state.get_inventory_count((state or {}).inventory, item_id)
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

local function fresh_player_state(player_name)
    return margot.runtime.state.new_player_state(player_name)
end

local function pantry_counts(world_state)
    local counts = margot.systems.household.get_pantry_counts(world_state)
    return counts or {
        ["item/apple"] = -1,
        ["item/flour"] = -1,
    }
end

local function log_player(label, player_name)
    local state = copy_player_state(player_name)
    local asset_state = ((state.owned_assets or {})["asset/apple_tree"])
    local tree_ready = asset_state and tonumber(asset_state.next_ready_day) or "none"

    log(string.format(
        "player label=%s name=%s apples=%d flour=%d pie=%d coins=%d tree_next=%s save=%s content=%s known=%d memory=%d",
        label,
        player_name,
        count_item(state, "item/apple"),
        count_item(state, "item/flour"),
        count_item(state, "item/pie"),
        tonumber(state.coins) or 0,
        tostring(tree_ready),
        tostring(state.save_version),
        tostring(state.content_version),
        next(state.known_npcs or {}) == nil and 0 or 1,
        next(state.npc_memory or {}) == nil and 0 or 1
    ))
end

local function log_world(label)
    local state = copy_world_state()
    local pantry = pantry_counts(state)
    local civic = state.civic or {}

    log(string.format(
        "world label=%s pantry_apples=%d pantry_flour=%d funds=%d stage=%s unlocked=%s household_assets=%d household_upgrades=%d players=%d save=%s content=%s",
        label,
        pantry["item/apple"] or 0,
        pantry["item/flour"] or 0,
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

local function interact_with_node(pos, player)
    local node = minetest.get_node(pos)
    local def = minetest.registered_nodes[node.name]

    if def == nil then
        error("missing node definition for " .. tostring(node.name))
    end

    if def.on_rightclick ~= nil then
        def.on_rightclick(pos, node, player, nil, nil)
        return
    end

    if def.on_punch ~= nil then
        def.on_punch(pos, node, player, nil)
        return
    end

    error("node has no interaction callback: " .. tostring(node.name))
end

local function reset_runtime_state()
    save_world_state(margot.runtime.state.new_world_state())
    save_player_state(players.a, fresh_player_state(players.a))
    save_player_state(players.b, fresh_player_state(players.b))
end

local function with_world_ready(callback)
    margot.runtime.block_c.ensure_bridge_surface(function(layout)
        minetest.after(0.2, function()
            callback(layout)
        end)
    end)
end

local function log_layout(layout, label)
    for key, offset in pairs(offsets) do
        local pos = get_place_pos(layout, offset)
        log(string.format(
            "node label=%s key=%s pos=%s name=%s",
            label,
            key,
            minetest.pos_to_string(pos),
            minetest.get_node(pos).name
        ))
    end

    log(string.format(
        "surface label=%s orchard_y=%d pantry_y=%d tree_y=%d bridge_y=%d",
        label,
        get_place_pos(layout, offsets.orchard).y,
        get_place_pos(layout, offsets.apple_deposit).y,
        get_place_pos(layout, offsets.apple_tree).y,
        get_place_pos(layout, offsets.bridge_site).y
    ))
end

local function phase_1(player)
    with_world_ready(function(layout)
        log_layout(layout, "startup")
        reset_runtime_state()
        log_player("phase1_reset_a", players.a)
        log_player("phase1_reset_b", players.b)
        log_world("phase1_reset")

        interact_with_node(get_place_pos(layout, offsets.apple_deposit), player)
        log_player("phase1_after_apple_fail", players.a)
        log_world("phase1_after_apple_fail")

        interact_with_node(get_place_pos(layout, offsets.flour_deposit), player)
        log_player("phase1_after_flour_fail", players.a)
        log_world("phase1_after_flour_fail")

        do
            local _, _, reason = margot.systems.household.deposit_item(
                copy_player_state(players.a),
                copy_world_state(),
                "item/pie",
                1
            )
            log("system label=phase1_unsupported_deposit reason=" .. tostring(reason))
        end

        interact_with_node(get_place_pos(layout, offsets.orchard), player)
        interact_with_node(get_place_pos(layout, offsets.orchard), player)
        interact_with_node(get_place_pos(layout, offsets.flour_bin), player)
        log_player("phase1_after_pickups", players.a)

        interact_with_node(get_place_pos(layout, offsets.apple_deposit), player)
        log_player("phase1_after_apple_deposit_1", players.a)
        log_world("phase1_after_apple_deposit_1")

        interact_with_node(get_place_pos(layout, offsets.apple_deposit), player)
        log_player("phase1_after_apple_deposit_2", players.a)
        log_world("phase1_after_apple_deposit_2")

        interact_with_node(get_place_pos(layout, offsets.flour_deposit), player)
        log_player("phase1_after_flour_deposit", players.a)
        log_world("phase1_after_flour_deposit")

        interact_with_node(get_place_pos(layout, offsets.pantry_read), player)
        interact_with_node(get_place_pos(layout, offsets.crafting_station), player)
        log_player("phase1_after_craft_fail", players.a)
        log_world("phase1_after_craft_fail")

        interact_with_node(get_place_pos(layout, offsets.market_stall), player)
        log_player("phase1_after_market_fail", players.a)
        log_world("phase1_after_market_fail")

        interact_with_node(get_place_pos(layout, offsets.bridge_site), player)
        log_player("phase1_after_bridge_fail", players.a)
        log_world("phase1_after_bridge_fail")

        minetest.after(0.5, function()
            minetest.request_shutdown("pantry_verify_phase_1_complete")
        end)
    end)
end

local function phase_2(player)
    with_world_ready(function(layout)
        log_layout(layout, "reload_b")
        log_player("phase2_reload_a", players.a)
        log_player("phase2_reload_b", players.b)
        log_world("phase2_reload")

        interact_with_node(get_place_pos(layout, offsets.pantry_read), player)

        interact_with_node(get_place_pos(layout, offsets.apple_withdraw), player)
        log_player("phase2_after_apple_withdraw", players.a)
        log_player("phase2_after_apple_withdraw_b", players.b)
        log_world("phase2_after_apple_withdraw")

        interact_with_node(get_place_pos(layout, offsets.flour_withdraw), player)
        log_player("phase2_after_flour_withdraw", players.b)
        log_world("phase2_after_flour_withdraw")

        interact_with_node(get_place_pos(layout, offsets.crafting_station), player)
        log_player("phase2_after_craft_fail", players.b)
        log_world("phase2_after_craft_fail")

        interact_with_node(get_place_pos(layout, offsets.flour_withdraw), player)
        log_player("phase2_after_flour_withdraw_fail", players.b)
        log_world("phase2_after_flour_withdraw_fail")

        interact_with_node(get_place_pos(layout, offsets.apple_withdraw), player)
        log_player("phase2_after_second_apple_withdraw", players.b)
        log_world("phase2_after_second_apple_withdraw")

        interact_with_node(get_place_pos(layout, offsets.crafting_station), player)
        log_player("phase2_after_craft_success", players.b)
        log_world("phase2_after_craft_success")

        interact_with_node(get_place_pos(layout, offsets.orchard), player)
        log_player("phase2_after_pickup_for_redeposit", players.b)

        interact_with_node(get_place_pos(layout, offsets.apple_deposit), player)
        log_player("phase2_after_redeposit", players.a)
        log_player("phase2_after_redeposit_b", players.b)
        log_world("phase2_after_redeposit")

        interact_with_node(get_place_pos(layout, offsets.pantry_read), player)

        minetest.after(0.5, function()
            minetest.request_shutdown("pantry_verify_phase_2_complete")
        end)
    end)
end

local function phase_3(player)
    with_world_ready(function(layout)
        log_layout(layout, "reload_a")
        log_player("phase3_reload_a", players.a)
        log_player("phase3_reload_b", players.b)
        log_world("phase3_reload")

        do
            local tree_ready = copy_player_state(players.a)
            tree_ready.owned_assets["asset/apple_tree"] = {
                purchased_day = 0,
                next_ready_day = 0,
            }
            save_player_state(players.a, tree_ready)
        end

        interact_with_node(get_place_pos(layout, offsets.apple_tree), player)
        log_player("phase3_after_tree_yield", players.a)
        log_world("phase3_after_tree_yield")

        interact_with_node(get_place_pos(layout, offsets.pantry_read), player)
        interact_with_node(get_place_pos(layout, offsets.apple_withdraw), player)
        log_player("phase3_after_player_a_withdraw", players.a)
        log_player("phase3_after_player_a_withdraw_b", players.b)
        log_world("phase3_after_player_a_withdraw")

        minetest.after(0.5, function()
            minetest.request_shutdown("pantry_verify_phase_3_complete")
        end)
    end)
end

minetest.chat_send_player = function(player_name, message)
    log("chat player=" .. player_name .. " message=" .. encode_message(message))
    return original_chat_send_player(player_name, message)
end

minetest.register_on_joinplayer(function(player)
    if player:get_player_name() ~= runner_by_phase[phase] then
        return
    end

    minetest.after(2, function()
        local ok, err = xpcall(function()
            if phase == 1 then
                phase_1(player)
            elseif phase == 2 then
                phase_2(player)
            else
                phase_3(player)
            end
        end, debug.traceback)

        if not ok then
            log("fatal phase=" .. tostring(phase) .. " error=" .. tostring(err))
            minetest.request_shutdown("pantry_verify_failed")
        end
    end)
end)
