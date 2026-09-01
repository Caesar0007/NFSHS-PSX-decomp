# P490: `r3dcar.cpp` one-extra family closure

All eight remaining one-extra-local findings in `r3dcar.cpp` are now resolved.

## Exact source restorations

- `R3DCar_StartUp`: assign `loadfileadr` directly to
  `R3DCar_LicenseShapeFile`, removing `pcVar1`.
- `R3DCar_PostStartUp`: pass `otSize << 2` directly to all four allocation
  calls, removing `otBytes` while retaining the retail 57-instruction body.
- `R3DCar_DeInstantiate3DCar`: test and purge `palCopy` directly, removing
  `addr`.
- `R3DCar_TurnHeadLightOn` and `R3DCar_TurnHeadLightOff`: restore direct field
  bit tests/updates, removing `uVar1` from both empty SYM scopes.
- `R3DCar_MATRIX3DT_Copy`: restore the direct `*to = *from` copy loop, removing
  `iVar1` while retaining SYM local `i`.

## Measured retained carriers

- `R3DCar_GetCarName::copIdx`: folding the unsigned offset into the range test
  and table index produced 38 instructions and 13 oracle diffs.  The retained
  value gives the exact 37-instruction lifetime of unadjusted `carType`.
- `R3DCar_Visibilty::modeOne`: the existing measured pin-free identity fence
  keeps the retail mask and later `inCarCam` rematerialization distinct;
  literal spellings retain two diffs.  Its detailed source evidence is now
  recognized by an explicit `SYM-CODEGEN-CARRIER` receipt.

## Proof

- `tools/tugate.py recon/game/common/r3dcar.cpp`: 27/27 PASS.
- `tools/brdist.py recon/game/common/r3dcar.cpp`: 27 functions, zero branch
  distance/count divergences.
- Strict P489 -> P490: declaration-clean functions 803 -> 811; unexplained
  extras 1497 -> 1489; missing names remain 0.
- Explicit codegen carriers: 119 -> 121.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warning only).

No commit or push was performed.
