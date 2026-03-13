local economy = {}

function economy.get_item_sale_value(item_id)
    local item_definition = margot.data.items[item_id]

    if item_definition == nil then
        return 0
    end

    return item_definition.sale_value or 0
end

function economy.quote_item_sale(item_id, quantity)
    local amount = math.max(quantity or 0, 0)
    return economy.get_item_sale_value(item_id) * amount
end

function economy.get_asset_purchase_cost(asset_id)
    local asset_definition = margot.data.assets[asset_id]

    if asset_definition == nil then
        return nil
    end

    return margot.runtime.state.clone(asset_definition.purchase_cost or {})
end

function economy.can_afford_asset(player_state, asset_id)
    local purchase_cost = economy.get_asset_purchase_cost(asset_id)

    if purchase_cost == nil then
        return false, "unknown_asset"
    end

    local current_coins = (player_state or {}).coins or 0

    if current_coins < (purchase_cost.coins or 0) then
        return false, "insufficient_coins"
    end

    return true, nil
end

function economy.purchase_asset(player_state, asset_id, owned_asset_state)
    if margot.data.assets[asset_id] == nil then
        return nil, "unknown_asset"
    end

    if margot.systems.ownership.player_owns_personal_asset(player_state, asset_id) then
        return nil, "already_owned"
    end

    local purchase_cost = economy.get_asset_purchase_cost(asset_id)
    local allowed, reason = economy.can_afford_asset(player_state, asset_id)

    if not allowed then
        return nil, reason
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)
    next_state.coins = math.max(next_state.coins - (purchase_cost.coins or 0), 0)

    next_state, reason = margot.systems.ownership.grant_personal_asset(next_state, asset_id, owned_asset_state)

    if next_state == nil then
        return nil, reason
    end

    return next_state, nil
end

function economy.apply_coin_delta(player_state, delta)
    local next_state = margot.runtime.state.copy_player_state(player_state)
    next_state.coins = math.max((next_state.coins or 0) + (delta or 0), 0)
    return next_state
end

function economy.spend_coins(player_state, amount)
    local spend_amount = math.floor(tonumber(amount) or 0)

    if spend_amount <= 0 then
        return nil, "invalid_amount"
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)

    if next_state.coins < spend_amount then
        return nil, "insufficient_coins"
    end

    next_state.coins = next_state.coins - spend_amount

    return next_state, nil
end

function economy.sell_item_at_place(player_state, place_id, item_id, quantity)
    if margot.data.places[place_id] == nil then
        return nil, "unknown_place"
    end

    if place_id ~= "place/market_stall" then
        return nil, "wrong_place"
    end

    if margot.data.items[item_id] == nil then
        return nil, "unknown_item"
    end

    local amount = math.floor(tonumber(quantity) or 0)

    if amount <= 0 then
        return nil, "invalid_quantity"
    end

    local available_amount = margot.runtime.state.get_inventory_count((player_state or {}).inventory, item_id)

    if available_amount < amount then
        return nil, "missing_item"
    end

    local proceeds = economy.quote_item_sale(item_id, amount)

    if proceeds <= 0 then
        return nil, "invalid_sale_value"
    end

    local next_state = margot.runtime.state.copy_player_state(player_state)
    local next_inventory, reason = margot.runtime.state.apply_inventory_delta(next_state.inventory, item_id, -amount)

    if next_inventory == nil then
        return nil, reason
    end

    next_state.inventory = next_inventory
    next_state.coins = next_state.coins + proceeds

    return next_state, nil, proceeds
end

margot.systems.economy = economy
