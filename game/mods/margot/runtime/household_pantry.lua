local pantry = {}
local _

local node_names = {
    apple_deposit = "margot:household_pantry_apple_deposit",
    flour_deposit = "margot:household_pantry_flour_deposit",
    read = "margot:household_pantry_read",
    apple_withdraw = "margot:household_pantry_apple_withdraw",
    flour_withdraw = "margot:household_pantry_flour_withdraw",
}
local pantry_surfaces = {
    {
        node_name = node_names.apple_deposit,
        item_id = "item/apple",
        offset = { x = 0, y = 0, z = -1 },
        action = "deposit",
    },
    {
        node_name = node_names.flour_deposit,
        item_id = "item/flour",
        offset = { x = 1, y = 0, z = -1 },
        action = "deposit",
    },
    {
        node_name = node_names.read,
        offset = { x = 2, y = 0, z = -1 },
        action = "read",
    },
    {
        node_name = node_names.apple_withdraw,
        item_id = "item/apple",
        offset = { x = 3, y = 0, z = -1 },
        action = "withdraw",
    },
    {
        node_name = node_names.flour_withdraw,
        item_id = "item/flour",
        offset = { x = 4, y = 0, z = -1 },
        action = "withdraw",
    },
}
local pending_withdraw_confirmations = {}
local withdraw_surface_keys = {
    ["item/apple"] = "apple_withdraw",
    ["item/flour"] = "flour_withdraw",
}

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
end

local function get_item_display_name(item_id)
    local item_definition = margot.data.items[item_id]

    if item_definition == nil then
        return item_id
    end

    return item_definition.display_name
end

local function get_item_requirement_text(item_id, amount)
    if item_id == "item/apple" then
        if amount == 1 then
            return "1 Apple"
        end

        return string.format("%d Apples", amount)
    end

    if item_id == "item/flour" then
        return string.format("%d Flour", amount)
    end

    return string.format("%d %s", amount, get_item_display_name(item_id))
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

local function load_world_state()
    return margot.runtime.state.copy_world_state(
        margot.runtime.world_state or margot.runtime.persistence.load_world_state()
    )
end

local function save_world_state(world_state)
    local saved_world = margot.runtime.persistence.save_world_state(world_state)
    margot.runtime.world_state = saved_world
    return saved_world
end

local function format_personal_status(player_state)
    local inventory = (player_state or {}).inventory or {}

    return string.format(
        "Personal Apples %d | Personal Flour %d",
        margot.runtime.state.get_inventory_count(inventory, "item/apple"),
        margot.runtime.state.get_inventory_count(inventory, "item/flour")
    )
end

local function format_pantry_status(world_state)
    local counts, reason = margot.systems.household.get_pantry_counts(world_state)

    if counts == nil then
        return nil, reason
    end

    return string.format(
        "Pantry Apples %d | Pantry Flour %d",
        counts["item/apple"] or 0,
        counts["item/flour"] or 0
    ), nil
end

local function format_house_purpose_status(world_state)
    local reserve_status, reason = margot.systems.household.get_pantry_reserve_status(world_state)

    if reserve_status == nil then
        return nil, nil, reason
    end

    if reserve_status.reserve_ready then
        return "House ready for later pie.", reserve_status, nil
    end

    local missing_parts = {}
    local missing_apples = reserve_status.missing["item/apple"] or 0
    local missing_flour = reserve_status.missing["item/flour"] or 0

    if missing_apples > 0 then
        table.insert(missing_parts, get_item_requirement_text("item/apple", missing_apples))
    end

    if missing_flour > 0 then
        table.insert(missing_parts, get_item_requirement_text("item/flour", missing_flour))
    end

    return string.format(
        "House not ready for later pie. Need %s.",
        table.concat(missing_parts, " and ")
    ), reserve_status, nil
end

local function build_counts_line(player_state, world_state)
    local pantry_status, reason = format_pantry_status(world_state)

    if pantry_status == nil then
        return nil, reason
    end

    return format_personal_status(player_state) .. " | " .. pantry_status, nil
end

local function build_action_summary_with_house_status(action_summary, world_state)
    local house_status, _, reason = format_house_purpose_status(world_state)

    if house_status == nil then
        return nil, reason
    end

    return action_summary .. " " .. house_status, nil
end

local function report_result(player, summary, player_state, world_state)
    local status_line, reason = build_counts_line(player_state, world_state)

    if status_line == nil then
        tell_player(player, "The pantry is not ready.")
        return reason
    end

    tell_player(player, summary .. " | " .. status_line)
    return nil
end

local function report_read(player, world_state)
    local pantry_status, reason = format_pantry_status(world_state)

    if pantry_status == nil then
        tell_player(player, "The pantry is not ready.")
        return reason
    end

    local house_status
    house_status, _, reason = format_house_purpose_status(world_state)

    if house_status == nil then
        tell_player(player, "The pantry is not ready.")
        return reason
    end

    tell_player(player, pantry_status .. " | " .. house_status)
    return nil
end

local function get_failure_message(action, item_id, reason)
    local item_name = get_item_display_name(item_id)

    if reason == "insufficient_personal_items" then
        return string.format("Need 1 %s to deposit.", item_name)
    end

    if reason == "insufficient_household_items" then
        return string.format("The pantry does not have 1 %s.", item_name)
    end

    local message_by_reason = {
        invalid_household_state = "The pantry is not ready.",
        invalid_quantity = "That pantry amount does not work.",
        unsupported_item = "That item does not belong in the pantry.",
        unknown_item = "That pantry item is not ready.",
    }

    if action == "read" then
        return message_by_reason[reason] or "That pantry action failed."
    end

    return message_by_reason[reason] or "That pantry action failed."
end

local function report_failure(player, action, item_id, reason, player_state, world_state)
    local summary = get_failure_message(action, item_id, reason)
    local status_line = nil

    if action ~= "read" and player_state ~= nil and world_state ~= nil then
        status_line = select(1, build_counts_line(player_state, world_state))
    elseif action == "read" and world_state ~= nil then
        status_line = select(1, format_pantry_status(world_state))
    end

    if status_line ~= nil then
        tell_player(player, summary .. " | " .. status_line)
        return
    end

    tell_player(player, summary)
end

local function clear_pending_confirmation(player_name)
    pending_withdraw_confirmations[player_name] = nil
end

local function get_current_pantry_counts(world_state)
    local reserve_status, reason = margot.systems.household.get_pantry_reserve_status(world_state)

    if reserve_status == nil then
        return nil, reason
    end

    return reserve_status.counts, nil
end

local function counts_match_snapshot(counts, snapshot)
    return (counts or {})["item/apple"] == (snapshot or {})["item/apple"]
        and (counts or {})["item/flour"] == (snapshot or {})["item/flour"]
end

local function set_pending_confirmation(player_name, item_id, surface_key, counts)
    pending_withdraw_confirmations[player_name] = {
        item_id = item_id,
        surface_key = surface_key,
        counts = {
            ["item/apple"] = (counts or {})["item/apple"] or 0,
            ["item/flour"] = (counts or {})["item/flour"] or 0,
        },
    }
end

local function report_reserve_warning(player, item_id, player_state, world_state)
    report_result(
        player,
        string.format(
            "This will break the house pie set. Nothing taken yet. Tap again to take 1 %s.",
            get_item_display_name(item_id)
        ),
        player_state,
        world_state
    )
end

local function report_withdraw_result(player, item_id, player_state, world_state)
    local summary, reason = build_action_summary_with_house_status(
        string.format("Took 1 %s.", get_item_display_name(item_id)),
        world_state
    )

    if summary == nil then
        report_failure(player, "withdraw", item_id, reason, player_state, world_state)
        return
    end

    report_result(player, summary, player_state, world_state)
end

local function persist_deposit_states(player, next_player_state, next_world_state)
    -- This is not transactional; save order only narrows the bounded crash-window trade-off.
    next_world_state = save_world_state(next_world_state)
    next_player_state = save_player_state(player, next_player_state)
    return next_player_state, next_world_state
end

local function persist_withdraw_states(player, next_player_state, next_world_state)
    -- This is not transactional; save order only narrows the bounded crash-window trade-off.
    next_player_state = save_player_state(player, next_player_state)
    next_world_state = save_world_state(next_world_state)
    return next_player_state, next_world_state
end

local function handle_deposit(player, item_id)
    local player_name = player:get_player_name()
    clear_pending_confirmation(player_name)
    local player_state = load_player_state(player)
    local world_state = load_world_state()
    local next_player_state, next_world_state, reason = margot.systems.household.deposit_item(
        player_state,
        world_state,
        item_id,
        1
    )

    if next_player_state == nil or next_world_state == nil then
        report_failure(player, "deposit", item_id, reason, player_state, world_state)
        return
    end

    next_player_state, next_world_state = persist_deposit_states(player, next_player_state, next_world_state)
    local summary, summary_reason = build_action_summary_with_house_status(
        string.format("Deposited 1 %s.", get_item_display_name(item_id)),
        next_world_state
    )

    if summary == nil then
        report_failure(player, "deposit", item_id, summary_reason, next_player_state, next_world_state)
        return
    end

    report_result(player, summary, next_player_state, next_world_state)
end

local function handle_withdraw(player, item_id)
    local player_name = player:get_player_name()
    local surface_key = withdraw_surface_keys[item_id]
    local pending_confirmation = pending_withdraw_confirmations[player_name]

    if pending_confirmation ~= nil and (
        pending_confirmation.item_id ~= item_id
        or pending_confirmation.surface_key ~= surface_key
    ) then
        clear_pending_confirmation(player_name)
        pending_confirmation = nil
    end

    local player_state = load_player_state(player)
    local world_state = load_world_state()
    local withdrawal_mode, reserve_status, reason = margot.systems.household.classify_withdrawal(
        world_state,
        item_id,
        1
    )

    if withdrawal_mode == nil then
        clear_pending_confirmation(player_name)
        report_failure(player, "withdraw", item_id, reason, player_state, world_state)
        return
    end

    if pending_confirmation ~= nil then
        local current_counts, counts_reason = get_current_pantry_counts(world_state)

        if current_counts == nil then
            clear_pending_confirmation(player_name)
            report_failure(player, "withdraw", item_id, counts_reason, player_state, world_state)
            return
        end

        if not counts_match_snapshot(current_counts, pending_confirmation.counts) or withdrawal_mode ~= "reserve_breaking" then
            clear_pending_confirmation(player_name)
            pending_confirmation = nil
        end
    end

    if withdrawal_mode == "reserve_breaking" and pending_confirmation == nil then
        set_pending_confirmation(player_name, item_id, surface_key, reserve_status.counts)
        report_reserve_warning(player, item_id, player_state, world_state)
        return
    end

    clear_pending_confirmation(player_name)

    local next_player_state, next_world_state, withdraw_reason = margot.systems.household.withdraw_item(
        player_state,
        world_state,
        item_id,
        1
    )

    if next_player_state == nil or next_world_state == nil then
        report_failure(player, "withdraw", item_id, withdraw_reason, player_state, world_state)
        return
    end

    next_player_state, next_world_state = persist_withdraw_states(player, next_player_state, next_world_state)

    local next_reserve_status, next_reason = margot.systems.household.get_pantry_reserve_status(next_world_state)

    if next_reserve_status == nil then
        report_failure(player, "withdraw", item_id, next_reason, next_player_state, next_world_state)
        return
    end

    if withdrawal_mode == "reserve_breaking" then
        report_withdraw_result(player, item_id, next_player_state, next_world_state)
        return
    end

    if next_reserve_status.reserve_ready then
        report_withdraw_result(player, item_id, next_player_state, next_world_state)
        return
    end

    report_withdraw_result(player, item_id, next_player_state, next_world_state)
end

local function handle_read(player)
    clear_pending_confirmation(player:get_player_name())
    local world_state = load_world_state()
    report_read(player, world_state)
end

local function place_pantry_surfaces(layout)
    if layout == nil or layout.anchor == nil then
        return
    end

    for _, surface in ipairs(pantry_surfaces) do
        minetest.set_node(add_pos(layout.anchor, surface.offset), { name = surface.node_name })
    end
end

function pantry.ensure_surface()
    margot.runtime.block_a.ensure_starter_strip(function(layout)
        place_pantry_surfaces(layout)
    end)
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

minetest.register_node(node_names.apple_deposit, new_node_def(
    "Margot Household Pantry Apple Deposit (Admin Recovery)",
    "[fill:16x16:#6fa84d",
    function(player)
        handle_deposit(player, "item/apple")
    end
))

minetest.register_node(node_names.flour_deposit, new_node_def(
    "Margot Household Pantry Flour Deposit (Admin Recovery)",
    "[fill:16x16:#d5c08a",
    function(player)
        handle_deposit(player, "item/flour")
    end
))

minetest.register_node(node_names.read, new_node_def(
    "Margot Household Pantry Read (Admin Recovery)",
    "[fill:16x16:#8f7e65",
    handle_read
))

minetest.register_node(node_names.apple_withdraw, new_node_def(
    "Margot Household Pantry Apple Withdraw (Admin Recovery)",
    "[fill:16x16:#5d8d3f",
    function(player)
        handle_withdraw(player, "item/apple")
    end
))

minetest.register_node(node_names.flour_withdraw, new_node_def(
    "Margot Household Pantry Flour Withdraw (Admin Recovery)",
    "[fill:16x16:#bda36c",
    function(player)
        handle_withdraw(player, "item/flour")
    end
))

minetest.register_on_joinplayer(function()
    pantry.ensure_surface()
end)

minetest.register_on_leaveplayer(function(player)
    if player ~= nil then
        clear_pending_confirmation(player:get_player_name())
    end
end)

margot.runtime.household_pantry = pantry
