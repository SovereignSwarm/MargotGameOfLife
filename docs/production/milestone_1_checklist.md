# Milestone 1 Checklist

## Purpose
This checklist keeps Milestone 1 implementation honest by making the structural readiness checks visible before broader coding starts and by keeping each implementation pass inside the locked slice.

## Core Rule
Milestone 1 is not ready to implement broadly unless structural checks are green.

## Readiness Checklist
- starter IDs frozen
- starter records schema-aligned
- ownership semantics explicit
- save smoke expectations defined
- implementation order defined
- acceptance criteria doc present and current

## Build Checklist
- feature stays within scope
- ownership scope is explicit
- visible consequence exists
- save impact is known
- co-op meaning is not broken
- no later-phase systems are smuggled in

## Review Checklist
- child readability
- co-op readability
- schema consistency
- ID consistency
- save/migration safety
- docs sync needed or not

## Go / No-Go Rule
Milestone 1 may begin only when starter IDs are frozen, starter records are schema-aligned, ownership semantics are explicit, save smoke expectations are defined, implementation order is locked, and the first implementation pass starts with Block A plus `docs/design/milestone_1_acceptance_criteria.md`.

## Final Rule
Do not code past unclear structure.
