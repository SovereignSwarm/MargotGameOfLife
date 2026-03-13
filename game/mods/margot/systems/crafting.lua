local crafting = {}

local function is_known_item(item_id)
    return margot.data.items[item_id] ~= nil
end

local function validate_recipe_items(recipe)
    for item_id in pairs(recipe.inputs or {}) do
        if not is_known_item(item_id) then
            return false, "unknown_item"
        end
    end

    for item_id in pairs(recipe.outputs or {}) do
        if not is_known_item(item_id) then
            return false, "unknown_item"
        end
    end

    return true, nil
end

function crafting.get_recipe(recipe_id)
    return margot.data.recipes[recipe_id]
end

function crafting.can_craft(inventory, recipe_id)
    local recipe = crafting.get_recipe(recipe_id)

    if recipe == nil then
        return false, "unknown_recipe"
    end

    local valid_recipe, valid_reason = validate_recipe_items(recipe)

    if not valid_recipe then
        return false, valid_reason
    end

    for item_id, required_amount in pairs(recipe.inputs) do
        local available_amount = margot.runtime.state.get_inventory_count(inventory, item_id)

        if available_amount < required_amount then
            return false, "missing_input"
        end
    end

    return true, nil
end

function crafting.apply_recipe(inventory, recipe_id)
    local allowed, reason = crafting.can_craft(inventory, recipe_id)

    if not allowed then
        return nil, reason
    end

    local next_inventory = margot.runtime.state.copy_inventory(inventory)
    local recipe = crafting.get_recipe(recipe_id)

    for item_id, required_amount in pairs(recipe.inputs) do
        next_inventory = select(1, margot.runtime.state.apply_inventory_delta(next_inventory, item_id, -required_amount))
    end

    for item_id, output_amount in pairs(recipe.outputs) do
        next_inventory = select(1, margot.runtime.state.apply_inventory_delta(next_inventory, item_id, output_amount))
    end

    return next_inventory, nil
end

function crafting.craft_at_place(player_state, recipe_id, place_id)
    local player = margot.runtime.state.copy_player_state(player_state)
    local recipe = crafting.get_recipe(recipe_id)

    if recipe == nil then
        return nil, "unknown_recipe"
    end

    if margot.data.places[place_id] == nil then
        return nil, "unknown_place"
    end

    if recipe.place_id ~= place_id then
        return nil, "wrong_place"
    end

    local next_inventory, reason = crafting.apply_recipe(player.inventory, recipe_id)

    if next_inventory == nil then
        return nil, reason
    end

    player.inventory = next_inventory

    return player, nil
end

margot.systems.crafting = crafting
