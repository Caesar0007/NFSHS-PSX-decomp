# P495: compact singleton one-extra closure

Seven one-extra-local findings across seven `game/common` translation units
are now resolved without changing any retail instruction stream.

## Exact source restorations

- `AILife_ReencarnateCopByLatPosAndRotation`: replace `iVar3` with a chained
  assignment of the road-position result, preserving retail's three-store
  order, then assign the road-span call directly.
- `AudioEng_LoadDef`: assign the reservation directly through `ed` and test
  `*ed`, removing `pAVar1`.
- `Clock_SystemCleanUp`: remove the unused `gp` declaration.
- `DashHUD_HUDCalc`: shift and store `DashHUD_gInfo.topspeed` directly after
  the speed absolute-value update, removing `topSpeed`.
- `Input_WingCommandMode`: index `Input_gMode` with `player & 1` at the shared
  label, removing `mode`.

## Measured retained carriers

- `AudioClc_GetClosestCars::viewpos`: the existing sealed receipt proves that
  only a pointer declared before the loop gives GCC one loop-invariant address
  pseudo and retail's single rematerialized base.  In-body/direct component
  forms retain an extra `lui`; an identity-laundered pointer regresses farther.
- `Control_Human::lights`: IDA confirms the selected byte in `$a1`.  Direct
  field reuse grows 288 instructions to 289 and produces 17 word diffs,
  moving the byte store into the branch delay slot and losing the retained
  value used by the headlight-off call.

## Proof

- All seven selected functions individually pass `tools/verify_asm.py`.
- TU gates: `ailife.cpp` 20/20, `audioclc.cpp` 18/18,
  `audioeng.cpp` 9/9, `clock.cpp` 3/3, `control.cpp` 2/2,
  `dashhud.cpp` 6/6, and `input.cpp` 8/8 PASS.
- `tools/brdist.py`: zero branch-distance/count divergences in every affected
  translation unit.
- Strict P494 -> P495: declaration-clean functions 840 -> 847; unexplained
  extras 1460 -> 1453; missing names remain 0.
- Explicit codegen carriers: 132 -> 134.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was performed.
