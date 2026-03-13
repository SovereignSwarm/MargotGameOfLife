local npc = {}

function npc.get_profile(npc_id)
    return margot.data.npc_profiles[npc_id]
end

function npc.get_commentary_flags(context)
    local flags = {}
    local owned_assets = context.owned_assets or {}
    local project_funds = context.project_funds or {}

    if (context.player_coins or 0) > 0 then
        flags.earned_coins = true
    end

    if (owned_assets["asset/apple_tree"] or 0) > 0 then
        flags.owns_tree = true
    end

    if (project_funds["project/bridge_01"] or 0) > 0 then
        flags.helped_bridge = true
    end

    if context.project_stage == "complete" then
        flags.bridge_complete = true
    end

    return flags
end

function npc.get_memory_bucket(reliability_score)
    if reliability_score == nil or reliability_score <= 0 then
        return "unknown"
    end

    if reliability_score < 3 then
        return "emerging"
    end

    return "trusted"
end

margot.systems.npc = npc
