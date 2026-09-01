# Game/common SYM-local cleanup (P461, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 661 at P460 to **673**.
- Generic unclassified extra-source-local findings fell from 1907 to
  **1887**: twelve decompiler temporaries were removed and eight required
  code-generation carriers were classified with measured receipts.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `AIWORLD.cpp` remains 22/22 PASS.

## Exact source restorations

- The four `AIWorld_ApxSplineDistance` overloads now express their arithmetic
  through the recovered SYM names `a` and `b`, or directly when the retail
  source left no local. Generic `iVar1`/`iVar2` temporaries were removed.
- `AIWorld_SplineDistance(Car_tObj *, int, coorddef *)` now uses the recovered
  `distance` local directly.
- `AIWorld_CalculateLaneInfo` assigns the result directly to `laneIndex`.
- `AIWorld_CalcSpeed` now uses the recovered `optVar1` and `optVar2` locals.
- `AIWorld_FindBarrierLessLaneAndPosition` now tests the call result directly.

All of these restorations retain exact retail instruction matches.

## Explicit ambiguity and measured carriers

- `AIWorld_IsDriveableLaneInSliceRange`: replacing `sliceDelta` by mutation of
  `startSlice`/`direction` produces 31 diffs and one fewer instruction;
  replacing `i` by destructive use of `numSlicesToCheck` produces 14 diffs
  and two fewer instructions.
- `AIWorld_LaneIndex`: reusing `laneWidth` produces 26 diffs; reusing
  `position` produces 25 diffs and one additional instruction.
- `AIWorld_CalculateDeltaRoadYaw`: reusing the recorded delta chain for
  `iVar2`, updating that carrier in place instead of `nextSlice`, or folding
  `gnLess1` each produces 8 diffs. Reading the globals directly instead of
  retaining `numSlices` produces 15 diffs and one additional instruction.
- `AIWorld_CalcRoadBend`: computing the expression directly instead of
  retaining `bend` produces 24 diffs with the same instruction count.

The exact bodies were restored after each experiment. These names therefore
remain explicitly identified as compiler/code-generation carriers; they are
not asserted to be recoverable retail source declarations.

## Separately linked frontend overlay

- `address.obj` records `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves this load window in the resident image.
- Frontend functions are compiled and linked into `front.bin` separately and
  occupy `[0x80010000, 0x80054548)`. They are overlay members, not resident-TU
  members merely because their runtime addresses fall inside the reserved
  range.

## Gates

- `AIWORLD.cpp`: 22/22 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean.

Detailed declaration ledger: `game_common_strict_p461_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p461_20260831.json`
- `game_common_local_cleanup_undef_recon_p461_20260831.json`
- `game_common_local_cleanup_undef_src_p461_20260831.json`
