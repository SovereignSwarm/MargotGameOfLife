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

## Modeling rule
Fit new content into the constitution's stable categories before inventing new system types.

## Data design
Prefer tables for:
- item definitions
- recipes
- asset definitions
- place definitions
- prices
- project stages and milestones
- NPC reaction rules
- commission definitions when needed
- event definitions when needed

## State design
Keep state explicit:
- player coins and inventory
- player-owned asset counts
- household-shared holdings when introduced
- project fund totals
- village or district stage
- simple NPC memory flags if needed

## Ownership model
Keep the three ownership layers legible in data and state:
- personal
- shared household
- town / civic

## Networking assumption
Private co-op only.
Design for 1-2 players sharing a world.
