# Decision Log

## 2026-03-13 ADR-001 Luanti Is The Current Runtime
- Status: Accepted
- Decision: Luanti is the current implementation target.
- Consequence: runtime code should stay simple, explicit, and replaceable; game meaning stays in docs rather than engine assumptions.

## 2026-03-13 ADR-002 Private Co-op Is Core
- Status: Accepted
- Decision: private co-op is core; public-online-first design is not.
- Consequence: optimize for 1-2 players sharing a world, not MMO scale or stranger-social loops.

## 2026-03-13 ADR-003 No Runtime LLM Dependency In V1
- Status: Accepted
- Decision: v1 will not depend on runtime LLM features.
- Consequence: NPCs, economy, and progression must remain deterministic and locally understandable.

## 2026-03-13 ADR-004 Additive Growth Beats Replacement
- Status: Accepted
- Decision: the game should deepen by adding districts, content, projects, information layers, and consequences rather than replacing core worldview or loops.
- Consequence: new work should mostly instantiate canon categories and preserve earlier meaning.

## 2026-03-13 ADR-005 Money Is Fuel, Not The Goal
- Status: Accepted
- Decision: currency is a means to capability, beauty, freedom, and shared life.
- Consequence: avoid abstract financialization and reward structures that make accumulation the end state.

## 2026-03-13 ADR-006 Visible Civic Consequence Is Mandatory
- Status: Accepted
- Decision: public contribution must change the world in visible ways.
- Consequence: civic systems should be modeled through places, projects, access, and shared structures rather than invisible town scores.

## 2026-03-13 ADR-007 Productive Assets Stay Tangible Early
- Status: Accepted
- Decision: early productive ownership should be concrete and child-legible.
- Consequence: favor assets such as trees, tools, and market capacity before abstract financial instruments or institutional layers.

## 2026-03-13 ADR-008 Ordered Additive Production Scaling
- Status: Accepted
- Decision: the project should scale through ordered additive production phases rather than solving later-phase problems inside early-phase implementation.
- Consequence: milestone planning should use `production_scale_phase_plan.md`; later-phase concerns should not be smuggled into Milestone 0 or Milestone 1 work.
