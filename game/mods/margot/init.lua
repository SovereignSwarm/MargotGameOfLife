local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

margot = rawget(_G, "margot") or {}
margot.modname = modname
margot.modpath = modpath

dofile(modpath .. "/items.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/economy.lua")
dofile(modpath .. "/village.lua")
dofile(modpath .. "/npc.lua")

