local household = {}
local supported_item_ids = {
    ["item/apple"] = true,
    ["item/flour"] = true,
}
local supported_item_order = {
    "item/apple",
    "item/flour",
}

local function is_supported_item(item_id)
    return supported_item_ids[item_id] == true
end

local function normalize_quantity(quantity)
    local amount = math.floor(tonumber(quantity) or 0)

    if amount <= 0 then
        return nil
    end

    return amount
end

local function get_household_inventory(world_state)
    local prepared_world = margot.runtime.state.ensure_world_state_shape(world_state)
    return prepared_world.household.inventory or {}
end

local function get_valid_household_count(inventory, item_id)
    if margot.data.items[item_id] == nil then
        return nil, "unknown_item"
    end

    local raw_value = (inventory or {})[item_id]

    if raw_value == nil then
        return 0, nil
    end

    local numeric_value = tonumber(raw_value)

    if numeric_value == nil then
        return nil, "invalid_household_state"
    end

    local amount = math.floor(numeric_value)

    if numeric_value ~= amount or amount < 0 then
        return nil, "invalid_household_state"
    end

    return amount, nil
end

local function apply_household_delta(inventory, item_id, delta)
    if not is_supported_item(item_id) then
        return nil, "unsupported_item"
    end

    local current_count, reason = get_valid_household_count(inventory, item_id)

    if current_count == nil then
        return nil, reason
    end

    local next_inventory = margot.runtime.state.copy_inventory(inventory)
    local next_count = current_count + math.floor(tonumber(delta) or 0)

    if next_count < 0 then
        return nil, "insufficient_household_items"
    end

    if next_count == 0 then
        next_inventory[item_id] = nil
    else
        next_inventory[item_id] = next_count
    end

    return next_inventory, nil
end

function household.is_supported_pantry_item(item_id)
    return is_supported_item(item_id)
end

function household.get_supported_pantry_item_ids()
    return margot.runtime.state.clone(supported_item_order)
end

function household.get_pantry_counts(world_state)
    local counts = {}
    local inventory = get_household_inventory(world_state)

    for _, item_id in ipairs(supported_item_order) do
        local amount, reason = get_valid_household_count(inventory, item_id)

        if amount == nil then
            return nil, reason
        end

        counts[item_id] = amount
    end

    return counts, nil
end

function household.deposit_item(player_state, world_state, item_id, quantity)
    if not is_supported_item(item_id) then
        return nil, nil, "unsupported_item"
    end

    local amount = normalize_quantity(quantity)

    if amount == nil then
        return nil, nil, "invalid_quantity"
    end

    local next_player_state = margot.runtime.state.copy_player_state(player_state)
    local next_world_state = margot.runtime.state.copy_world_state(world_state)
    local _, reason = household.get_pantry_counts(next_world_state)

    if reason ~= nil then
        return nil, nil, reason
    end

    local next_personal_inventory, reason = margot.runtime.state.apply_inventory_delta(
        next_player_state.inventory,
        item_id,
        -amount
    )

    if next_personal_inventory == nil then
        if reason == "insufficient_items" then
            reason = "insufficient_personal_items"
        end

        return nil, nil, reason
    end

    local next_household_inventory
    next_household_inventory, reason = apply_household_delta(next_world_state.household.inventory, item_id, amount)

    if next_household_inventory == nil then
        return nil, nil, reason
    end

    next_player_state.inventory = next_personal_inventory
    next_world_state.household.inventory = next_household_inventory

    return next_player_state, next_world_state, nil
end

function household.withdraw_item(player_state, world_state, item_id, quantity)
    if not is_supported_item(item_id) then
        return nil, nil, "unsupported_item"
    end

    local amount = normalize_quantity(quantity)

    if amount == nil then
        return nil, nil, "invalid_quantity"
    end

    local next_player_state = margot.runtime.state.copy_player_state(player_state)
    local next_world_state = margot.runtime.state.copy_world_state(world_state)
    local _, reason = household.get_pantry_counts(next_world_state)

    if reason ~= nil then
        return nil, nil, reason
    end

    local next_household_inventory, reason = apply_household_delta(next_world_state.household.inventory, item_id, -amount)

    if next_household_inventory == nil then
        return nil, nil, reason
    end

    local next_personal_inventory
    next_personal_inventory, reason = margot.runtime.state.apply_inventory_delta(
        next_player_state.inventory,
        item_id,
        amount
    )

    if next_personal_inventory == nil then
        return nil, nil, reason
    end

    next_world_state.household.inventory = next_household_inventory
    next_player_state.inventory = next_personal_inventory

    return next_player_state, next_world_state, nil
end

margot.systems.household = household
