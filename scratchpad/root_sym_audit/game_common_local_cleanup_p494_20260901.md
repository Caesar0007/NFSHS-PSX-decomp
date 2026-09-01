# P494: `cars.cpp` one-extra family closure

All seven one-extra-local findings selected from `cars.cpp` are now resolved.

## Exact source restorations

- `Car_DoSkiddingStuff`: assign `oldAudioSkidState` directly in both arms,
  removing `uVar1`.
- `Cars_CalculateStartingGridOffset`: reuse the now-dead SYM `totalWidth` for
  the per-lane quotient, removing `laneWidth` while preserving retail's single
  divide and register lifetime.
- `Cars_IniCarObjects`: read the canonical `carObj->carInfo->carType` field in
  each comparison, removing `carType`; GCC CSEs the field exactly.
- `Cars_Initialize`: use the SYM-recorded `i` as the clear-loop counter,
  removing `iVar1`.
- `Cars_CalculateRoadPosition`: return
  `Newton_CalculateRoadPosition(&carObj->N)` directly, removing `iVar1`.

## Measured retained carriers

- `Cars_DoExtraCarCollisionProcessing::player`: repeating the comparison at
  all three camera stores grows retail's 597 instructions to 606 and produces
  33 word diffs.  The named selector is required for GCC 2.8.1 to retain and
  reuse the selected `Camera_gInfo` row.
- `Cars_CalculateRoadSpan::absSpan`: the existing allocator receipt proves the
  split abs destination is required.  An in-place assignment changes the abs
  and `/256` register flow; folded expression variants produce 62--90 diffs.

## Proof

- All seven selected functions individually pass `tools/verify_asm.py`.
- `tools/tugate.py recon/game/common/cars.cpp`: 33/33 PASS.
- `tools/brdist.py recon/game/common/cars.cpp`: 33 functions, zero branch
  distance/count divergences.
- Strict P493 -> P494: declaration-clean functions 833 -> 840; unexplained
  extras 1467 -> 1460; missing names remain 0.
- Explicit codegen carriers: 130 -> 132.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warnings only).

No commit or push was performed.
