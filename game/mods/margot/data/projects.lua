margot.data.projects = {
    ["project/bridge_01"] = {
        id = "project/bridge_01",
        display_name = "Bridge Fund",
        summary = "A shared project to complete the village bridge.",
        site_place_id = "place/bridge_site",
        default_scope = "civic",
        contribution_rules = {
            currency = "coins",
            fixed_coin_amount = 5,
        },
        stages = {
            {
                id = "foundation",
                threshold = 0,
            },
            {
                id = "framing",
                threshold = 25,
            },
            {
                id = "complete",
                threshold = 50,
            },
        },
        outcome_ids = {
            "place/bridge",
        },
    },
}
