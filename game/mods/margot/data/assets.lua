margot.data.assets = {
    ["asset/apple_tree"] = {
        id = "asset/apple_tree",
        display_name = "Apple Tree",
        asset_kind = "productive_asset",
        summary = "A small productive asset that yields apples over time.",
        default_scope = "personal",
        purchase_cost = {
            coins = 25,
        },
        yield_cycle = "daily_placeholder",
        yield_outputs = {
            ["item/apple"] = 2,
        },
        related_place_id = "place/orchard",
        notes = "Starter productive asset for Orchard and Bridge.",
    },
}
