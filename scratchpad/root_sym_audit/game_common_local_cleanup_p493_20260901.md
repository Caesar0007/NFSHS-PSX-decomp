# P493: `object.cpp` one-extra family closure

All eight one-extra-local findings in `object.cpp` are now resolved.

## Exact source restorations

- `CalcObjYawAngle`: return the adjusted `fixedatan` expression directly,
  removing `angle`.
- `CalcObjExtentPoints`: update `resultPts[2].x` directly after transform,
  removing `tmpx`.
- `Object_InitCustomObjects`: pass `Object_customSimObjs + 1` directly to
  `blockfill`, removing `dst`.
- `SetCautionSurface`: use `slicePos->simQuad` directly for the test and save,
  removing `simQuad`.
- `ObjectFinishedSignAnim::Draw`: use the implicit `this` parameter directly,
  removing the duplicate `pThis` alias.

## Measured retained carriers

- `Object_InitCollisionCheckLoop::altSlice`: direct indexed/pointer expressions
  retain 134 instructions but reverse two retail `addu` operand pairs (four
  diffs); an integer-address form drops an instruction and gives 11 diffs.  The
  cached pointer preserves the exact address-construction order in both arms.
- `ObjectMultiAnim` constructor `z`: reading `impactVel->z` at the final store
  keeps 62 instructions but moves eight load/shift/store slots.  The early
  cached component reproduces retail scheduling around intervening member
  assignments.
- `ObjectMultiAnim::Draw::t3`: direct third-result stores retain 265
  instructions but move 14 matrix stores/call delay slots.  The shared result
  reproduces retail's three-column fixed-point scaling schedule.

## Proof

- `tools/tugate.py recon/game/common/object.cpp`: 37/37 PASS.
- `tools/brdist.py recon/game/common/object.cpp`: 37 functions, zero branch
  distance/count divergences.
- Strict P492 -> P493: declaration-clean functions 825 -> 833; unexplained
  extras 1475 -> 1467; missing names remain 0.
- Explicit codegen carriers: 127 -> 130.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: no errors (repository line-ending warning only).

No commit or push was performed.
