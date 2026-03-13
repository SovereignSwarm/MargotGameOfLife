margot.data.npc_profiles = {
    ["npc/baker"] = {
        id = "npc/baker",
        display_name = "Baker",
        actor_kind = "specialist",
        summary = "A craft-focused villager who cares about steady making and useful goods.",
        role = "baker",
        home_place_id = "place/crafting_station",
        priorities = { "craft", "consistency" },
        request_types = { "pie_work" },
        memory_tags = { "reliable", "helpful" },
    },
    ["npc/builder"] = {
        id = "npc/builder",
        display_name = "Builder",
        actor_kind = "specialist",
        summary = "A civic-focused villager who cares about patient progress and shared infrastructure.",
        role = "builder",
        home_place_id = "place/bridge_site",
        priorities = { "public_work", "follow_through" },
        request_types = { "bridge_work" },
        memory_tags = { "generous", "delayed_gratification" },
    },
}
