local block_a = {}
local storage = minetest.get_mod_storage()

local bootstrap_key = "bootstrap/block_a_starter_strip"
local node_names = {
    orchard = "margot:block_a_orchard",
    flour_bin = "margot:block_a_flour_bin",
    crafting_station = "margot:block_a_crafting_station",
    market_stall = "margot:block_a_market_stall",
}
local starter_offsets = {
    orchard = { x = 0, y = 0, z = 0 },
    flour_bin = { x = 1, y = 0, z = 0 },
    crafting_station = { x = 2, y = 0, z = 0 },
    market_stall = { x = 3, y = 0, z = 0 },
}

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
end

local function round_pos(pos)
    return {
        x = math.floor((pos.x or 0) + 0.5),
        y = math.floor((pos.y or 0) + 0.5),
        z = math.floor((pos.z or 0) + 0.5),
    }
end

local function parse_spawn_anchor(raw_value)
    if raw_value == nil or raw_value == "" then
        return nil
    end

    local parsed = minetest.string_to_pos(raw_value)

    if parsed ~= nil then
        return parsed
    end

    local x, y, z = string.match(raw_value, "^%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*$")

    if x == nil then
        return nil
    end

    return {
        x = tonumber(x) or 0,
        y = tonumber(y) or 0,
        z = tonumber(z) or 0,
    }
end

local function get_starter_anchor()
    local spawn_anchor = parse_spawn_anchor(minetest.settings:get("static_spawnpoint"))
    return round_pos(spawn_anchor or { x = 0, y = 0, z = 0 })
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
    return {
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
        on_rightclick = function(_, _, player)
            if player ~= nil then
                action(player)
            end
        end,
        on_punch = function(_, _, puncher)
            if puncher ~= nil and puncher:is_player() then
                action(puncher)
            end
        end,
    }
end

local function place_starter_strip(anchor)
    minetest.set_node(add_pos(anchor, starter_offsets.orchard), { name = node_names.orchard })
    minetest.set_node(add_pos(anchor, starter_offsets.flour_bin), { name = node_names.flour_bin })
    minetest.set_node(add_pos(anchor, starter_offsets.crafting_station), { name = node_names.crafting_station })
    minetest.set_node(add_pos(anchor, starter_offsets.market_stall), { name = node_names.market_stall })
end

function block_a.ensure_starter_strip()
    local marker = storage:get_string(bootstrap_key)

    if marker ~= "" then
        return
    end

    local anchor = get_starter_anchor()
    local minp = add_pos(anchor, { x = -1, y = -1, z = -1 })
    local maxp = add_pos(anchor, { x = 4, y = 1, z = 1 })

    storage:set_string(bootstrap_key, "pending")
    minetest.emerge_area(minp, maxp, function(_, _, remaining)
        if remaining ~= 0 then
            return
        end

        place_starter_strip(anchor)
        storage:set_string(bootstrap_key, minetest.serialize({
            anchor = anchor,
            status = "placed",
        }))
    end)
end

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

minetest.register_on_joinplayer(function()
    block_a.ensure_starter_strip()
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
