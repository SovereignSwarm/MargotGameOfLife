# Architecture

## Tech choice
- Engine: Luanti
- Scripting: Lua
- Goal: small modular game logic, AI-friendly repo structure

## Initial module plan
- init.lua
- items.lua
- crafting.lua
- economy.lua
- village.lua
- npc.lua

## Data design
Prefer tables for:
- item definitions
- recipes
- prices
- village milestones
- NPC reaction rules

## State design
Keep state explicit:
- player coins
- player-owned tree count
- bridge fund total
- village stage
- simple NPC memory flags if needed

## Networking assumption
Private co-op only.
Design for 1-2 players sharing a world.
