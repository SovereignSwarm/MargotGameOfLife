local crafting = {}

local function copy_inventory(inventory)
    local next_inventory = {}

    for item_id, amount in pairs(inventory or {}) do
        next_inventory[item_id] = amount
    end

    return next_inventory
end

function crafting.get_recipe(recipe_id)
    return margot.data.recipes[recipe_id]
end

function crafting.can_craft(inventory, recipe_id)
    local recipe = crafting.get_recipe(recipe_id)

    if recipe == nil then
        return false, "unknown_recipe"
    end

    for item_id, required_amount in pairs(recipe.inputs) do
        local available_amount = (inventory or {})[item_id] or 0

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

    local next_inventory = copy_inventory(inventory)
    local recipe = crafting.get_recipe(recipe_id)

    for item_id, required_amount in pairs(recipe.inputs) do
        next_inventory[item_id] = next_inventory[item_id] - required_amount
    end

    for item_id, output_amount in pairs(recipe.outputs) do
        next_inventory[item_id] = (next_inventory[item_id] or 0) + output_amount
    end

    return next_inventory, nil
end

margot.systems.crafting = crafting
