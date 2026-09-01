# P492: `bworldsm.cpp` one-extra family closure

All six one-extra-local findings in `bworldsm.cpp` are now resolved.

## Exact source restorations

- `RawFindClosestQuad`: use the signed `slicePos->quad` expression directly in
  the initial range test and `startQuadInd` assignment, removing `currentQuad`
  while retaining the exact 491-instruction body.
- `BWorldSm_FindClosestQuadMaxIterations`: return
  `BWorldSm_FindClosestQuadRez` directly, removing `iVar1`.
- `BWorldSm_QuadLight`: replace the unrecorded `vertices` declaration with the
  repeated `GetData` macro expression implied by the SYM-recorded inlined
  member receiver.  GCC CSEs this source shape to the exact 100-instruction
  body.

## Measured retained carriers

- `GetStmQuadPts::vertices`: repeating the same inlined `GetData` macro in the
  heavier coordinate builder produces 101 instructions and 119 oracle diffs;
  its cached result is required for the exact 74-instruction schedule.
- `FindClosestQuad::sliceChanged`: loading the stored byte adds one instruction,
  while recomputing the comparison produces 117 instructions/four diffs.  The
  shared boolean gives the exact 115-instruction dual-store logic.
- `NormalCache_Init::invalid`: literal `-1` stores produce 16 instructions and
  five diffs by merging constants into `$a1`; the retained value preserves
  retail's separate `$a2=-1` and `$a1=255` values and exact 15-instruction loop.

The contrasting `vertices` results are significant: the source-level macro is
correct for `BWorldSm_QuadLight`, but oracle evidence proves that
`GetStmQuadPts` needs a cached compiler carrier.  They are not being given one
blanket disposition.

## Proof

- `tools/tugate.py recon/game/common/bworldsm.cpp`: 28/28 PASS.
- `tools/brdist.py recon/game/common/bworldsm.cpp`: 28 functions, zero branch
  distance/count divergences.
- Strict P491 -> P492: declaration-clean functions 819 -> 825; unexplained
  extras 1481 -> 1475; missing names remain 0.
- Explicit codegen carriers: 124 -> 127.
- Type/storage findings remain 0; globals remain 547/547 and vtables remain
  115/115.
- `tools/relink.py --lane both -v`: GREEN, with no real duplicates, hidden
  phantoms, or unresolved relocations.
- Data-only payload audit: PASS, all 11 members byte exact.
- `git diff --check`: clean.

No commit or push was performed.
