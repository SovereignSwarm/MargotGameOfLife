local debug_api = {}

local function count_keys(values)
    local count = 0

    for _ in pairs(values or {}) do
        count = count + 1
    end

    return count
end

function debug_api.snapshot_world_state(world_state)
    local state = world_state
        or margot.runtime.world_state
        or margot.runtime.state.new_world_state()

    return {
        save_version = state.save_version,
        content_version = state.content_version,
        player_count = count_keys(state.players),
        household_asset_count = count_keys(state.household.owned_assets),
        civic_project_count = count_keys(state.civic.project_funds),
    }
end

function debug_api.log_world_summary(world_state)
    local summary = debug_api.snapshot_world_state(world_state)

    minetest.log(
        "action",
        string.format(
            "[margot] save=%s content=%s players=%s household_assets=%s civic_projects=%s",
            summary.save_version,
            summary.content_version,
            summary.player_count,
            summary.household_asset_count,
            summary.civic_project_count
        )
    )

    return summary
end

margot.runtime.debug = debug_api
