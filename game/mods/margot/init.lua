local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

margot = rawget(_G, "margot") or {}
margot.modname = modname
margot.modpath = modpath
margot.data = margot.data or {}
margot.systems = margot.systems or {}
margot.runtime = margot.runtime or {}

local function load(relative_path)
    dofile(modpath .. "/" .. relative_path)
end

load("runtime/migrations.lua")
load("runtime/state.lua")
load("runtime/persistence.lua")
load("runtime/debug.lua")

load("data/items.lua")
load("data/recipes.lua")
load("data/assets.lua")
load("data/places.lua")
load("data/projects.lua")
load("data/npc_profiles.lua")

load("systems/crafting.lua")
load("systems/economy.lua")
load("systems/ownership.lua")
load("systems/projects.lua")
load("systems/npc.lua")
load("runtime/block_a.lua")
load("runtime/block_b.lua")

margot.runtime.world_state = margot.runtime.persistence.load_world_state()
