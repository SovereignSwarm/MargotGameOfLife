local projects = {}

function projects.get_project(project_id)
    return margot.data.projects[project_id]
end

function projects.get_fixed_coin_amount(project_id)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, "unknown_project"
    end

    local contribution_rules = project_definition.contribution_rules or {}

    if contribution_rules.currency ~= "coins" then
        return nil, "invalid_contribution"
    end

    local fixed_coin_amount = math.floor(tonumber(contribution_rules.fixed_coin_amount) or 0)

    if fixed_coin_amount <= 0 then
        return nil, "invalid_contribution"
    end

    return fixed_coin_amount, nil
end

function projects.get_stage_for_funds(project_id, total_funds)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, "unknown_project"
    end

    local funds = math.max(math.floor(tonumber(total_funds) or 0), 0)
    local active_stage = nil

    for _, stage in ipairs(project_definition.stages or {}) do
        if active_stage == nil or funds >= (stage.threshold or 0) then
            active_stage = stage.id
        end
    end

    if active_stage == nil then
        return nil, "invalid_project_stages"
    end

    return active_stage, nil
end

function projects.get_current_stage(world_state, project_id)
    local stage, reason = projects.get_stage_for_funds(
        project_id,
        ((margot.runtime.state.ensure_world_state_shape(world_state)).civic.project_funds or {})[project_id] or 0
    )

    if stage == nil then
        return nil, 0
    end

    local prepared_world = margot.runtime.state.ensure_world_state_shape(world_state)
    local total_funds = prepared_world.civic.project_funds[project_id] or 0

    return stage, total_funds
end

function projects.is_complete(world_state, project_id)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return false
    end

    local current_stage = select(1, projects.get_current_stage(world_state, project_id))
    local final_stage = project_definition.stages[#project_definition.stages]

    return current_stage ~= nil and final_stage ~= nil and current_stage == final_stage.id
end

function projects.ensure_project_state(world_state, project_id)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, false, "unknown_project"
    end

    local next_world = margot.runtime.state.copy_world_state(world_state)
    local changed = false

    if next_world.civic.project_funds[project_id] == nil then
        next_world.civic.project_funds[project_id] = 0
        changed = true
    end

    local expected_stage, reason = projects.get_stage_for_funds(project_id, next_world.civic.project_funds[project_id])

    if expected_stage == nil then
        return nil, false, reason
    end

    if next_world.civic.project_stages[project_id] == nil then
        next_world.civic.project_stages[project_id] = expected_stage
        changed = true
    end

    return next_world, changed, nil
end

function projects.sync_project_state(world_state, project_id)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, false, "unknown_project"
    end

    local next_world, changed, reason = projects.ensure_project_state(world_state, project_id)

    if next_world == nil then
        return nil, false, reason
    end

    local total_funds = next_world.civic.project_funds[project_id] or 0
    local expected_stage
    expected_stage, reason = projects.get_stage_for_funds(project_id, total_funds)

    if expected_stage == nil then
        return nil, false, reason
    end

    if next_world.civic.project_stages[project_id] ~= expected_stage then
        next_world.civic.project_stages[project_id] = expected_stage
        changed = true
    end

    local outcome_id = (project_definition.outcome_ids or {})[1]
    local complete = projects.is_complete(next_world, project_id)

    if outcome_id ~= nil then
        if complete then
            if next_world.civic.unlocked_places[outcome_id] ~= true then
                next_world.civic.unlocked_places[outcome_id] = true
                changed = true
            end
        elseif next_world.civic.unlocked_places[outcome_id] ~= nil then
            next_world.civic.unlocked_places[outcome_id] = nil
            changed = true
        end
    end

    return next_world, changed, nil
end

function projects.apply_coin_contribution(world_state, project_id, amount)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, "unknown_project"
    end

    local contribution = math.floor(tonumber(amount) or 0)

    if contribution <= 0 then
        return nil, "invalid_contribution"
    end

    local next_world, _, reason = projects.sync_project_state(world_state, project_id)

    if next_world == nil then
        return nil, reason
    end

    if projects.is_complete(next_world, project_id) then
        return nil, "already_complete"
    end

    next_world.civic.project_funds[project_id] = (next_world.civic.project_funds[project_id] or 0) + contribution

    next_world, _, reason = projects.sync_project_state(next_world, project_id)

    if next_world == nil then
        return nil, reason
    end

    return next_world, nil
end

margot.systems.projects = projects
