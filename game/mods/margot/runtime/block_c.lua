local block_c = {}

local bridge_project_id = "project/bridge_01"
local bridge_site_place_id = "place/bridge_site"
local bridge_outcome_place_id = "place/bridge"
local node_names = {
    site = "margot:block_c_bridge_site",
    span = "margot:block_c_bridge_span",
    support = "margot:block_c_bridge_support",
}
local bridge_positions = {
    surface = {
        { x = 5, y = 0, z = 1 },
        { x = 6, y = 0, z = 1 },
        { x = 7, y = 0, z = 1 },
        { x = 8, y = 0, z = 1 },
        { x = 9, y = 0, z = 1 },
        { x = 10, y = 0, z = 1 },
    },
    support = {
        { x = 5, y = -1, z = 1 },
        { x = 6, y = -1, z = 1 },
        { x = 7, y = -1, z = 1 },
        { x = 8, y = -1, z = 1 },
        { x = 9, y = -1, z = 1 },
        { x = 10, y = -1, z = 1 },
    },
}

local function add_pos(base, offset)
    return {
        x = base.x + offset.x,
        y = base.y + offset.y,
        z = base.z + offset.z,
    }
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

local function bridge_places_ready()
    return margot.data.places[bridge_site_place_id] ~= nil
        and margot.data.places[bridge_outcome_place_id] ~= nil
end

local function get_bridge_layout_bounds(layout)
    local minp = add_pos(layout.anchor, { x = 5, y = -1, z = 1 })
    local maxp = add_pos(layout.anchor, { x = 10, y = 0, z = 1 })
    return minp, maxp
end

local function set_node_for_offset(layout, offset, node_name)
    minetest.set_node(add_pos(layout.anchor, offset), { name = node_name })
end

local function get_surface_node_name(index, stage_id)
    if index == 1 then
        return node_names.site
    end

    if stage_id == "framing" and index <= 3 then
        return node_names.span
    end

    if stage_id == "complete" then
        return node_names.span
    end

    return "air"
end

local function get_support_node_name(index, stage_id)
    if index == 1 then
        return node_names.support
    end

    if stage_id == "framing" and index <= 3 then
        return node_names.support
    end

    if stage_id == "complete" then
        return node_names.support
    end

    return "air"
end

local function get_world_stage(world_state)
    local stage_id, total_funds = margot.systems.projects.get_current_stage(world_state, bridge_project_id)

    return stage_id or "foundation", total_funds or 0
end

local function format_bridge_status(world_state)
    local stage_id, total_funds = get_world_stage(world_state)
    return string.format("Bridge %s | Shared Coins %d", stage_id, total_funds)
end

local function sync_bridge_world_state(world_state)
    return margot.systems.projects.sync_project_state(world_state, bridge_project_id)
end

local function render_bridge(layout, world_state)
    local stage_id = get_world_stage(world_state)

    for index, offset in ipairs(bridge_positions.surface) do
        set_node_for_offset(layout, offset, get_surface_node_name(index, stage_id))
    end

    for index, offset in ipairs(bridge_positions.support) do
        set_node_for_offset(layout, offset, get_support_node_name(index, stage_id))
    end
end

function block_c.ensure_bridge_surface(on_ready)
    if not bridge_places_ready() then
        return
    end

    margot.runtime.block_a.ensure_starter_strip(function(layout)
        local minp, maxp = get_bridge_layout_bounds(layout)

        minetest.emerge_area(minp, maxp, function(_, _, remaining)
            if remaining ~= 0 then
                return
            end

            local world_state = load_world_state()
            local synced_world, changed = sync_bridge_world_state(world_state)

            if synced_world == nil then
                return
            end

            if changed then
                synced_world = save_world_state(synced_world)
            end

            render_bridge(layout, synced_world)

            if on_ready ~= nil then
                on_ready(layout, synced_world)
            end
        end)
    end)
end

local function report_failure(player, reason, player_state, world_state)
    local message_by_reason = {
        already_complete = "The shared bridge is already finished.",
        insufficient_coins = "Need 5 coins to help build the bridge.",
        invalid_amount = "That bridge contribution is not ready.",
        invalid_contribution = "That bridge contribution is not ready.",
        unknown_place = "The bridge site is not ready.",
        unknown_project = "The bridge project is not ready.",
    }

    tell_player(
        player,
        string.format(
            "%s | Coins %d | %s",
            message_by_reason[reason] or "That bridge action failed.",
            math.floor(tonumber((player_state or {}).coins) or 0),
            format_bridge_status(world_state or load_world_state())
        )
    )
end

local function report_success_message(player_state, world_state, reflection_line)
    local message = string.format(
        "You added 5 coins to the shared bridge. | Coins %d | %s",
        math.floor(tonumber((player_state or {}).coins) or 0),
        format_bridge_status(world_state)
    )

    if reflection_line ~= nil and reflection_line ~= "" then
        message = message .. "\n" .. reflection_line
    end

    return message
end

local function report_success(player, player_state, world_state, reflection_line)
    tell_player(player, report_success_message(player_state, world_state, reflection_line))
end

local function select_block_d_trigger(pre_stage, pre_funds, post_stage, post_funds)
    if pre_stage ~= "complete" and post_stage == "complete" then
        return "bridge_complete"
    end

    if pre_stage ~= "framing" and post_stage == "framing" then
        return "bridge_framing"
    end

    if pre_funds == 0 and post_funds > 0 then
        return "bridge_first_contribution"
    end

    return nil
end

local function handle_bridge_contribution(player)
    if not bridge_places_ready() then
        report_failure(player, "unknown_place", load_player_state(player), load_world_state())
        return
    end

    local player_state = load_player_state(player)
    local world_state = load_world_state()
    local synced_world, changed, reason = sync_bridge_world_state(world_state)

    if synced_world == nil then
        report_failure(player, reason, player_state, world_state)
        return
    end

    if changed then
        synced_world = save_world_state(synced_world)
    end

    local pre_stage, pre_funds = get_world_stage(synced_world)

    local fixed_coin_amount
    fixed_coin_amount, reason = margot.systems.projects.get_fixed_coin_amount(bridge_project_id)

    if fixed_coin_amount == nil then
        report_failure(player, reason, player_state, synced_world)
        return
    end

    local next_player_state
    next_player_state, reason = margot.systems.economy.spend_coins(player_state, fixed_coin_amount)

    if next_player_state == nil then
        report_failure(player, reason, player_state, synced_world)
        return
    end

    local next_world_state
    next_world_state, reason = margot.systems.projects.apply_coin_contribution(
        synced_world,
        bridge_project_id,
        fixed_coin_amount
    )

    if next_world_state == nil then
        report_failure(player, reason, player_state, synced_world)
        return
    end

    local post_stage, post_funds = get_world_stage(next_world_state)
    local reflection_trigger = select_block_d_trigger(pre_stage, pre_funds, post_stage, post_funds)
    local reflection_line = margot.systems.npc.get_block_d_reflection_line(reflection_trigger)

    if pre_stage ~= "complete" and post_stage == "complete" then
        if next_world_state.civic.place_conditions["place/crafting_station"] == nil then
            next_world_state.civic.place_conditions["place/crafting_station"] = "not_ready"
        end
    end

    next_player_state = save_player_state(player, next_player_state)
    next_world_state = save_world_state(next_world_state)

    block_c.ensure_bridge_surface(function(_, rendered_world_state)
        report_success(player, next_player_state, rendered_world_state or next_world_state, reflection_line)
    end)
end

minetest.register_node(node_names.site, {
    description = "Margot Block C Bridge Site (Admin Recovery)",
    tiles = { "[fill:16x16:#7c6745" },
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
            handle_bridge_contribution(player)
        end
    end,
    on_punch = function(_, _, puncher)
        if puncher ~= nil and puncher:is_player() then
            handle_bridge_contribution(puncher)
        end
    end,
})

minetest.register_node(node_names.span, {
    description = "Margot Block C Bridge Span (Admin Recovery)",
    tiles = { "[fill:16x16:#9b7a52" },
    groups = {
        not_in_creative_inventory = 1,
    },
    drop = "",
    can_dig = function(_, player)
        return player ~= nil and minetest.check_player_privs(player, { server = true })
    end,
    on_blast = function() end,
})

minetest.register_node(node_names.support, {
    description = "Margot Block C Bridge Support (Admin Recovery)",
    tiles = { "[fill:16x16:#5d4f3a" },
    groups = {
        not_in_creative_inventory = 1,
    },
    drop = "",
    can_dig = function(_, player)
        return player ~= nil and minetest.check_player_privs(player, { server = true })
    end,
    on_blast = function() end,
})

minetest.register_on_joinplayer(function()
    block_c.ensure_bridge_surface()
end)

margot.runtime.block_c = block_c
