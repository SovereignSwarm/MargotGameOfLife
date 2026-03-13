local block_a = {}
local storage = minetest.get_mod_storage()

local bootstrap_key = "bootstrap/block_a_starter_strip"
local bootstrap_layout_version = 2
local node_names = {
    prototype_substrate = "margot:prototype_substrate",
    orchard = "margot:block_a_orchard",
    flour_bin = "margot:block_a_flour_bin",
    crafting_station = "margot:block_a_crafting_station",
    market_stall = "margot:block_a_market_stall",
}
local starter_origin = { x = 0, y = 4, z = 0 }
local safe_spawn = { x = 1.5, y = 5.5, z = 2.0 }
local platform_bounds = {
    min = { x = -1, y = 3, z = -1 },
    max = { x = 4, y = 3, z = 2 },
}
local clear_bounds = {
    min = { x = -1, y = 4, z = -1 },
    max = { x = 4, y = 7, z = 2 },
}
local starter_nodes = {
    orchard = { x = 0, y = 0, z = 0 },
    flour_bin = { x = 1, y = 0, z = 0 },
    crafting_station = { x = 2, y = 0, z = 0 },
    market_stall = { x = 3, y = 0, z = 0 },
}
local bootstrap_in_progress = false
local bootstrap_waiters = {}

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
end

local function copy_pos(pos)
    if pos == nil then
        return nil
    end

    return {
        x = pos.x,
        y = pos.y,
        z = pos.z,
    }
end

local function get_starter_anchor()
    return copy_pos(starter_origin)
end

local function get_safe_spawn()
    return copy_pos(safe_spawn)
end

local function player_storage_key(player_name)
    return "player/" .. tostring(player_name)
end

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

local function get_bootstrap_state()
    return deserialize(storage:get_string(bootstrap_key))
end

local function is_current_bootstrap_state(state)
    return type(state) == "table"
        and state.status == "placed"
        and tonumber(state.layout_version) == bootstrap_layout_version
end

local function get_starter_area_bounds(anchor)
    return add_pos(anchor, platform_bounds.min), add_pos(anchor, clear_bounds.max)
end

local function for_each_pos(minp, maxp, fn)
    for x = minp.x, maxp.x do
        for y = minp.y, maxp.y do
            for z = minp.z, maxp.z do
                fn({ x = x, y = y, z = z })
            end
        end
    end
end

local function flush_bootstrap_waiters(layout)
    local waiters = bootstrap_waiters
    bootstrap_waiters = {}

    for _, waiter in ipairs(waiters) do
        waiter(layout)
    end
end

local function is_broken_world_position(pos)
    return pos ~= nil and (tonumber(pos.y) or 0) < -100
end

local function player_has_saved_personal_state(player_name)
    return storage:get_string(player_storage_key(player_name)) ~= ""
end

local function place_player_at_safe_spawn(player_name)
    local player = minetest.get_player_by_name(player_name)

    if player == nil then
        return
    end

    player:set_pos(get_safe_spawn())
end

local function ensure_player_access(player)
    if player == nil then
        return
    end

    local player_name = player:get_player_name()
    local should_place_player = (not player_has_saved_personal_state(player_name))
        or is_broken_world_position(player:get_pos())

    block_a.ensure_starter_strip(function()
        if should_place_player then
            minetest.after(0, function()
                place_player_at_safe_spawn(player_name)
            end)
        end
    end)
end

local function format_status(player_state)
    local inventory = player_state.inventory or {}

    return string.format(
        "Apple %d | Flour %d | Pie %d | Coins %d",
        margot.runtime.state.get_inventory_count(inventory, "item/apple"),
        margot.runtime.state.get_inventory_count(inventory, "item/flour"),
        margot.runtime.state.get_inventory_count(inventory, "item/pie"),
        math.floor(tonumber(player_state.coins) or 0)
    )
end

local function tell_player(player, message)
    minetest.chat_send_player(player:get_player_name(), "[Margot] " .. message)
end

local function load_player_state(player)
    return margot.runtime.persistence.load_player_state(player:get_player_name())
end

local function save_player_state(player, player_state)
    return margot.runtime.persistence.save_player_state(player:get_player_name(), player_state)
end

local function report_result(player, summary, player_state)
    tell_player(player, summary .. " | " .. format_status(player_state))
end

local function report_failure(player, reason, player_state)
    local message_by_reason = {
        invalid_quantity = "That amount does not work.",
        invalid_sale_value = "That item cannot be sold here.",
        missing_input = "Need 2 apples and 1 flour.",
        missing_item = "Need a pie to sell.",
        unknown_item = "That item is not ready.",
        unknown_place = "That place is not ready.",
        unknown_recipe = "That recipe is not ready.",
        wrong_place = "This action belongs somewhere else.",
    }

    report_result(player, message_by_reason[reason] or "That action failed.", player_state)
end

local function handle_pickup(player, item_id, amount, summary)
    local player_state = load_player_state(player)
    local next_inventory, reason = margot.runtime.state.apply_inventory_delta(player_state.inventory, item_id, amount)

    if next_inventory == nil then
        report_failure(player, reason, player_state)
        return
    end

    player_state.inventory = next_inventory
    player_state = save_player_state(player, player_state)
    report_result(player, summary, player_state)
end

local function handle_craft(player)
    local player_state = load_player_state(player)
    local next_state, reason = margot.systems.crafting.craft_at_place(
        player_state,
        "recipe/pie",
        "place/crafting_station"
    )

    if next_state == nil then
        report_failure(player, reason, player_state)
        return
    end

    next_state = save_player_state(player, next_state)
    report_result(player, "Baked 1 Pie.", next_state)
end

local function handle_sale(player)
    local player_state = load_player_state(player)
    local next_state, reason, proceeds = margot.systems.economy.sell_item_at_place(
        player_state,
        "place/market_stall",
        "item/pie",
        1
    )

    if next_state == nil then
        report_failure(player, reason, player_state)
        return
    end

    next_state = save_player_state(player, next_state)
    report_result(player, string.format("Sold 1 Pie for %d coins.", proceeds), next_state)
end

local function new_node_def(description, tiles, action)
    local definition = {
        description = description,
        tiles = { tiles },
        groups = {
            not_in_creative_inventory = 1,
        },
        drop = "",
        can_dig = function(_, player)
            return player ~= nil and minetest.check_player_privs(player, { server = true })
        end,
        on_blast = function() end,
    }

    if action ~= nil then
        definition.on_rightclick = function(_, _, player)
            if player ~= nil then
                action(player)
            end
        end

        definition.on_punch = function(_, _, puncher)
            if puncher ~= nil and puncher:is_player() then
                action(puncher)
            end
        end
    end

    return definition
end

local function place_starter_area(anchor)
    local platform_min = add_pos(anchor, platform_bounds.min)
    local platform_max = add_pos(anchor, platform_bounds.max)
    local clear_min = add_pos(anchor, clear_bounds.min)
    local clear_max = add_pos(anchor, clear_bounds.max)

    for_each_pos(platform_min, platform_max, function(pos)
        minetest.set_node(pos, { name = node_names.prototype_substrate })
    end)

    for_each_pos(clear_min, clear_max, function(pos)
        minetest.set_node(pos, { name = "air" })
    end)

    minetest.set_node(add_pos(anchor, starter_nodes.orchard), { name = node_names.orchard })
    minetest.set_node(add_pos(anchor, starter_nodes.flour_bin), { name = node_names.flour_bin })
    minetest.set_node(add_pos(anchor, starter_nodes.crafting_station), { name = node_names.crafting_station })
    minetest.set_node(add_pos(anchor, starter_nodes.market_stall), { name = node_names.market_stall })
end

function block_a.ensure_starter_strip(on_ready)
    local current_state = get_bootstrap_state()

    if is_current_bootstrap_state(current_state) then
        if on_ready ~= nil then
            on_ready(current_state)
        end
        return
    end

    if on_ready ~= nil then
        table.insert(bootstrap_waiters, on_ready)
    end

    if bootstrap_in_progress then
        return
    end

    bootstrap_in_progress = true

    local anchor = get_starter_anchor()
    local minp, maxp = get_starter_area_bounds(anchor)

    storage:set_string(bootstrap_key, "pending")
    minetest.emerge_area(minp, maxp, function(_, _, remaining)
        if remaining ~= 0 then
            return
        end

        place_starter_area(anchor)

        local layout = {
            anchor = anchor,
            layout_version = bootstrap_layout_version,
            status = "placed",
        }

        storage:set_string(bootstrap_key, minetest.serialize(layout))
        bootstrap_in_progress = false
        flush_bootstrap_waiters(layout)
    end)
end

minetest.register_node(node_names.prototype_substrate, new_node_def(
    "Margot Prototype Substrate (Admin Recovery)",
    "[fill:16x16:#7a7466",
    nil
))

minetest.register_alias_force("mapgen_stone", node_names.prototype_substrate)
minetest.register_alias_force("mapgen_water_source", node_names.prototype_substrate)
minetest.register_alias_force("mapgen_river_water_source", node_names.prototype_substrate)

minetest.register_node(node_names.orchard, new_node_def(
    "Margot Block A Orchard (Admin Recovery)",
    "[fill:16x16:#89b35b",
    function(player)
        handle_pickup(player, "item/apple", 1, "Picked 1 Apple.")
    end
))

minetest.register_node(node_names.flour_bin, new_node_def(
    "Margot Block A Flour Bin (Admin Recovery)",
    "[fill:16x16:#d8c38a",
    function(player)
        handle_pickup(player, "item/flour", 1, "Took 1 Flour.")
    end
))

minetest.register_node(node_names.crafting_station, new_node_def(
    "Margot Block A Crafting Station (Admin Recovery)",
    "[fill:16x16:#a67449",
    handle_craft
))

minetest.register_node(node_names.market_stall, new_node_def(
    "Margot Block A Market Stall (Admin Recovery)",
    "[fill:16x16:#be8c52",
    handle_sale
))

minetest.register_on_joinplayer(function(player)
    ensure_player_access(player)
end)

minetest.register_on_respawnplayer(function(player)
    ensure_player_access(player)
    return true
end)

minetest.register_chatcommand("margot_status", {
    description = "Show read-only Margot Block A status.",
    privs = {},
    func = function(name)
        local player = minetest.get_player_by_name(name)

        if player == nil then
            return false, "Player not found."
        end

        local player_state = load_player_state(player)
        tell_player(player, format_status(player_state))
        return true, ""
    end,
})

margot.runtime.block_a = block_a
