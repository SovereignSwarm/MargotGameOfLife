local ownership = {
    scopes = {
        personal = true,
        household = true,
        civic = true,
    },
}

function ownership.normalize_scope(scope)
    if ownership.scopes[scope] then
        return scope
    end

    return "personal"
end

function ownership.new_claim(scope, owner_id)
    return {
        scope = ownership.normalize_scope(scope),
        owner_id = owner_id,
    }
end

function ownership.get_scope_state(world_state, scope)
    local normalized_scope = ownership.normalize_scope(scope)
    local prepared_world = margot.runtime.state.ensure_world_state_shape(world_state)

    if normalized_scope == "household" then
        return prepared_world.household
    end

    if normalized_scope == "civic" then
        return prepared_world.civic
    end

    return prepared_world.players
end

margot.systems.ownership = ownership
