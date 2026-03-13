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

function economy.apply_coin_delta(player_state, delta)
    local next_state = margot.runtime.state.copy_player_state(player_state)
    next_state.coins = math.max((next_state.coins or 0) + (delta or 0), 0)
    return next_state
end

margot.systems.economy = economy
