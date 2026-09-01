# Game/common SYM-local cleanup (P471, 2026-09-01)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 702 at P470 to **703**.
- Generic unclassified extra-source-local findings fell from 1800 to
  **1783**.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- Ten anonymous expression/allocation values in `SetupBlockader()` now have
  explicit oracle receipts; source-only carrier findings increased from 83 to
  93 while the function left the generic review queue.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restoration

`AIHigh_BTC_Wingman::SetupBlockader()` is now declaration-clean and remains
340/340 instructions:

- The SLD inline-`this` records are restored as real accessors:
  `humanCop->GetCarObj()` and `humanCop->perpTarget_->GetCarObj()`. This removes
  `pAVar8` and the duplicate `carObj`; direct field access produces only 338
  instructions and 28 diffs.
- Unused decompiler declarations `sVar2`, `uVar4`, and `iVar6` are gone.
- The final raw Speaker temporary is gone; the call is now
  `Speech_Dispatch()->Ready(this->carObj_)` through the proven virtual ABI
  bridge.
- Recorded locals `initSlice`, `copObj`, `blockadeType`,
  `perpToHumanDistance`, `side`, `initializationDistance`, `perpObj`,
  `spikeBeltSide`, `left`, `right`, `slice`, `rightLatPos`, and `timeNow` are
  used semantically in their SLD scopes.
- Generic RNG snapshots `randomValue` and `randomMultiplier` fold naturally
  into `randtemp = fastRandom * randSeed` without changing retail code.
- Generic aliases `iVar3`, `iVar7`, `iVar9`, `bVar1`, `initDistance`,
  `offset`, and `beltSlice` were either eliminated or replaced with named,
  measured semantic carriers.

## Measured non-SYM allocation carriers

- `sliceOffset`: separate distance-to-slice result; reusing
  `initializationDistance` causes 22 diffs.
- `maximumDistance`: separate upper clamp bound; a literal conditional shrinks
  to 337 instructions and causes nine diffs.
- `initializationSliceDistance`: separate `0x53` scale value; a literal is
  strength-reduced, growing to 343 instructions/nine diffs.
- `initSliceCandidate` and `numSlices`: preserve the two branch-local wrap
  candidates and load/copy schedule. Direct member updates are 338/32 diffs;
  unfenced candidates are 338/20; direct `gNumSlices` is 341/five diffs.
- `blockadeDirection` and `blockadeSlice`: preserve the delayed direction and
  wrapped-slice stores. Direct direction reads are 342/20 diffs; updating the
  member slice in place is 340/30 diffs.
- `blockadeFlags`: distinct table-selected byte while recorded
  `blockadeType` remains the selector; folding them causes ten diffs.
- `perpDistance`: separate spline-distance result; folding the call into the
  sign test causes 18 diffs.
- `beltSlice`: snapshot for the global spike-belt store sequence; direct member
  use causes 16 diffs.

The two `initSliceCandidate` fences and the recorded spike-belt `slice` fence
are empty-template, zero-instruction identity fences permitted by the project
guide. The latter is measured at 340/28 diffs when removed; using the local in
place of the subsequent member reads instead shrinks to 337/173 diffs.

## Overlay ownership invariant

`front.bin` remains a separately compiled/linked overlay occupying
`[0x80010000, 0x80054548)`, with `_front_size = 0x44548`. `bigbuf.obj`
reserves that resident load window and `address.obj` owns/describes its
boundaries. Functions in the interval retain their frontend object ownership.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; `SetupBlockader()` is 340/340.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical, including `vars.obj`.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p471_20260901.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p471_20260901.json`
- `game_common_local_cleanup_undef_recon_p471_20260901.json`
- `game_common_local_cleanup_undef_src_p471_20260901.json`

## Next review target

`AIHigh_BTC_Wingman::HighExecute()` is now the sole remaining review entry in
`aih_btccop.cpp`. Reconcile its eleven generic locals against the complete
SLD block and the already documented PC/mobile source-shape comparisons,
testing one state-machine region at a time to preserve the 40/40 TU.
