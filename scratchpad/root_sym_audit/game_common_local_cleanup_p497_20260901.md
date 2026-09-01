# P497: trigger/schedule/sim one-extra closure

Eight one-extra-local findings across `aitriger.cpp`, `schedule.cpp`, and
`sim.cpp` are now resolved without changing any retail instruction stream.

## Exact source restorations

- `AITrigger_TriggerManager::InsertTrigger`: read `trigger->any.type`
  directly for the type-5 test and switch, removing `iVar1`.
- `AITrigger_TriggerManager::GetTrigger`: use the SYM-recorded integer
  `triggerNum` as the nullable pointer-value carrier, removing `ptVar1`.
- `AITrigger_TriggerManager::CheckForClosestTriggerOfType`: use
  `this->numTriggers_` directly at the loop bound, removing `numTriggers`;
  GCC preserves the intended cached-after-zero-test shape exactly.
- `Sched_DeleteFunction`: use `schedule->numFunctions` directly at each loop
  and shift bound, removing `count`.
- `Sim_ProcessPause`: use the SYM-recorded `r` for the pause-menu result,
  removing `iVar1`.
- `Sim_CheckForPause`: test `Input_Interface(6, 1)` directly, removing
  `iVar1`.

## Measured retained carriers

- `Sched_ExecuteCheck::distanceTemp`: the separate rounded-distance
  destination preserves retail's a0-to-a2 handoff.  In-place reuse is 76
  instructions/5 diffs; reusing parameter `distance` is 77/20, reusing SYM
  `index` is 76/31, and a conditional expression is 79/38.
- `Sim_ProcessSimSchedules::firstSfx`: removing the block-local `0x23`
  shrinks 201 instructions to 197 and produces eight word diffs, changing the
  pre-loop layout and invariant constant materialization.  Its placement is
  also confirmed by the SLD scope.

## Proof

- All eight selected functions individually pass `tools/verify_asm.py`.
- TU gates: `aitriger.cpp` 10/10, `schedule.cpp` 6/6, and `sim.cpp` 8/8 PASS.
- `tools/brdist.py`: zero branch-distance/count divergences in every affected
  translation unit.
- Strict P496 -> P497: declaration-clean functions 855 -> 863; unexplained
  extras 1445 -> 1437; missing names remain 0.
- Explicit codegen carriers: 137 -> 139.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was performed.
