local block_b = {}

local tree_asset_id = "asset/apple_tree"
local tree_node_name = "margot:block_b_apple_tree"
local tree_offset = { x = 4, y = 0, z = 0 }

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
end

local function get_current_day()
    local current_day = math.floor(tonumber(minetest.get_day_count()) or 0)

    if current_day < 0 then
        return 0
    end

    return current_day
end

local function get_tree_asset_definition()
    return margot.data.assets[tree_asset_id]
end

local function get_next_ready_day(asset_definition, current_day)
    if asset_definition == nil then
        return nil, "unknown_asset"
    end

    if asset_definition.yield_cycle ~= "daily_placeholder" then
        return nil, "unsupported_yield_cycle"
    end

    return current_day + 1, nil
end

local function load_player_state(player)
    return margot.runtime.persistence.load_player_state(player:get_player_name())
end

local function save_player_state(player, player_state)
    return margot.runtime.persistence.save_player_state(player:get_player_name(), player_state)
end

local function tell_player(player, message)
    minetest.chat_send_player(player:get_player_name(), "[Margot] " .. message)
end

local function format_tree_label(asset_state, current_day)
    if asset_state == nil then
        return "Tree not owned"
    end

    if current_day >= (asset_state.next_ready_day or (current_day + 1)) then
        return "Tree ready"
    end

    return "Tree growing"
end

local function format_status(player_state, asset_state, current_day)
    local inventory = player_state.inventory or {}

    return string.format(
        "Apple %d | Coins %d | %s",
        margot.runtime.state.get_inventory_count(inventory, "item/apple"),
        math.floor(tonumber(player_state.coins) or 0),
        format_tree_label(asset_state, current_day)
    )
end

local function report_result(player, summary, player_state, asset_state, current_day)
    tell_player(player, summary .. " | " .. format_status(player_state, asset_state, current_day))
end

local function report_failure(player, reason, player_state, asset_state, current_day)
    local message_by_reason = {
        already_owned = "You already own your own Apple Tree here.",
        insufficient_coins = "Need more coins to buy your own Apple Tree.",
        invalid_yield_outputs = "The Apple Tree yield is not ready.",
        missing_asset = "You do not own your own Apple Tree here yet.",
        unknown_asset = "The Apple Tree is not ready.",
        unknown_item = "The Apple Tree yield is not ready.",
        unsupported_yield_cycle = "The Apple Tree is not ready.",
    }

    report_result(
        player,
        message_by_reason[reason] or "That Apple Tree action failed.",
        player_state,
        asset_state,
        current_day
    )
end

local function format_yield_summary(outputs)
    local parts = {}

    for item_id, amount in pairs(outputs or {}) do
        local item_definition = margot.data.items[item_id]
        local display_name = item_definition and item_definition.display_name or item_id
        local unit_label = amount == 1 and display_name or (display_name .. "s")
        table.insert(parts, string.format("%d %s", amount, unit_label))
    end

    table.sort(parts)

    return table.concat(parts, " and ")
end

local function apply_yield_outputs(inventory, outputs)
    local next_inventory = margot.runtime.state.copy_inventory(inventory)
    local has_output = false

    for item_id, amount in pairs(outputs or {}) do
        local reason
        has_output = true
        next_inventory, reason = margot.runtime.state.apply_inventory_delta(next_inventory, item_id, amount)

        if next_inventory == nil then
            return nil, reason
        end
    end

    if not has_output then
        return nil, "invalid_yield_outputs"
    end

    return next_inventory, nil
end

local function place_tree_surface(layout)
    if layout == nil or layout.anchor == nil then
        return
    end

    minetest.set_node(add_pos(layout.anchor, tree_offset), { name = tree_node_name })
end

function block_b.ensure_tree_surface()
    margot.runtime.block_a.ensure_starter_strip(function(layout)
        place_tree_surface(layout)
    end)
end

local function handle_tree_interaction(player)
    local current_day = get_current_day()
    local asset_definition = get_tree_asset_definition()
    local player_state = load_player_state(player)
    local normalized_state, asset_state, changed, reason = margot.systems.ownership.get_personal_asset_state(
        player_state,
        tree_asset_id,
        current_day
    )

    if normalized_state == nil then
        report_failure(player, reason, player_state, nil, current_day)
        return
    end

    player_state = normalized_state

    if asset_definition == nil then
        report_failure(player, "unknown_asset", player_state, asset_state, current_day)
        return
    end

    if asset_state == nil then
        local next_ready_day
        next_ready_day, reason = get_next_ready_day(asset_definition, current_day)

        if next_ready_day == nil then
            report_failure(player, reason, player_state, nil, current_day)
            return
        end

        local purchase_state = {
            purchased_day = current_day,
            next_ready_day = next_ready_day,
        }
        local next_state
        next_state, reason = margot.systems.economy.purchase_asset(player_state, tree_asset_id, purchase_state)

        if next_state == nil then
            report_failure(player, reason, player_state, nil, current_day)
            return
        end

        next_state = save_player_state(player, next_state)
        report_result(player, "You bought your own Apple Tree. It will grow apples tomorrow.", next_state, purchase_state, current_day)
        return
    end

    if changed then
        player_state = save_player_state(player, player_state)
    end

    if current_day < asset_state.next_ready_day then
        report_result(player, "Your Apple Tree is still growing. Come back tomorrow.", player_state, asset_state, current_day)
        return
    end

    local next_inventory
    next_inventory, reason = apply_yield_outputs(player_state.inventory, asset_definition.yield_outputs)

    if next_inventory == nil then
        report_failure(player, reason, player_state, asset_state, current_day)
        return
    end

    local next_ready_day
    next_ready_day, reason = get_next_ready_day(asset_definition, current_day)

    if next_ready_day == nil then
        report_failure(player, reason, player_state, asset_state, current_day)
        return
    end

    asset_state.next_ready_day = next_ready_day
    player_state.inventory = next_inventory

    local next_state
    next_state, reason = margot.systems.ownership.update_personal_asset_state(player_state, tree_asset_id, asset_state)

    if next_state == nil then
        report_failure(player, reason, player_state, asset_state, current_day)
        return
    end

    next_state = save_player_state(player, next_state)
    report_result(
        player,
        "Your Apple Tree gave you " .. format_yield_summary(asset_definition.yield_outputs) .. ".",
        next_state,
        asset_state,
        current_day
    )
end

minetest.register_node(tree_node_name, {
    description = "Margot Block B Apple Tree (Admin Recovery)",
    tiles = { "[fill:16x16:#6f9f45" },
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
            handle_tree_interaction(player)
        end
    end,
    on_punch = function(_, _, puncher)
        if puncher ~= nil and puncher:is_player() then
            handle_tree_interaction(puncher)
        end
    end,
})

minetest.register_on_joinplayer(function()
    block_b.ensure_tree_surface()
end)

margot.runtime.block_b = block_b
