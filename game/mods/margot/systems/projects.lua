local projects = {}

function projects.get_project(project_id)
    return margot.data.projects[project_id]
end

function projects.get_current_stage(world_state, project_id)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, 0
    end

    local prepared_world = margot.runtime.state.ensure_world_state_shape(world_state)
    local total_funds = prepared_world.civic.project_funds[project_id] or 0
    local active_stage = project_definition.stages[1].id

    for _, stage in ipairs(project_definition.stages) do
        if total_funds >= stage.threshold then
            active_stage = stage.id
        end
    end

    return active_stage, total_funds
end

function projects.apply_coin_contribution(world_state, project_id, amount)
    local project_definition = projects.get_project(project_id)

    if project_definition == nil then
        return nil, "unknown_project"
    end

    local contribution = math.max(amount or 0, 0)
    local next_world = margot.runtime.state.copy_world_state(world_state)

    next_world.civic.project_funds[project_id] = (next_world.civic.project_funds[project_id] or 0) + contribution

    local next_stage = projects.get_current_stage(next_world, project_id)
    next_world.civic.project_stages[project_id] = next_stage

    return next_world, nil
end

margot.systems.projects = projects
