# Game/common SYM-local cleanup (P469, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 696 at P468 to **699**.
- Generic unclassified extra-source-local findings fell from 1824 to
  **1807**.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- Four values in `NewStage` are now explicit, oracle-receipted allocation
  carriers instead of generic review findings; the source-only carrier count
  therefore increased from 77 to 81.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restorations

- `AIHigh_BTC_HumanCop::FreezeAndEndChase()` now uses the four exact
  block-scoped names and types recorded by SYM: `startDirection`, `startSlice`,
  `startMovement`, and `addToSlice`. Decompiler aliases `direction`, `iVar1`,
  `movement`, and `iVar2` are gone. The body remains 117/117.
- `CheckConditionWithCop0()` now uses the recorded `leadCop` and nested
  `startDirection`, `startSlice`, `startMovement`, and `addToSlice` locals in
  their SLD scopes. The decompiler's `AIHigh_Base[]` row arithmetic is restored
  to semantic `AIHigh_BTC_HumanCop` fields: `currentStage_`,
  `initialDirection_`, and `initialMovement_`. Five generic aliases are gone;
  the body remains 59/59.
- `NewStage()` now uses its recorded `initialDirection` and
  `initialMovement` values when storing the corresponding members. Raw
  integer-slice address arithmetic is restored to canonical `Trk_NewSlice`
  fields (`laneCount`, `avgPavedWidthLf`, `avgPavedWidthRt`, `leftDrive`, and
  `rightDrive`). Generic `pCVar1`, `slice`, `rightWidth`, and `oldTimeLeft` are
  eliminated; direct member access and direct `timeLeft_` accumulation remain
  byte-exact at 220/220.

## Measured non-SYM allocation carriers

The only non-SYM names retained in `NewStage()` are four anonymous
expression/allocation values, now individually classified:

- `laneBits`: the saved high nibble used by the left-width multiplication and
  driveable-lane call.
- `leftWidth`: keeping the byte-to-FIX15 conversion separate reproduces the
  retail multiply destination. Folding it directly into `leftPos` preserves
  220 instructions but causes 40 register diffs.
- `limitR` and `limitL`: distinct caller-saved results of the two MIN-style
  clamps. A direct `MIN` source expansion grows the body to 225 instructions
  and causes 173 diffs; sharing the bounds also changes the branch/delay-slot
  allocation.

These are explicit proof dispositions, not claims that the names survive in
SYM. The retail instructions prove the values and their separate allocation;
SYM cannot uniquely recover their original source spelling.

## Overlay ownership invariant

`front.bin` remains a separately compiled/linked overlay occupying
`[0x80010000, 0x80054548)`, with `_front_size = 0x44548`. `bigbuf.obj`
reserves that resident load window and `address.obj` owns/describes its
boundaries. Functions in the interval retain their frontend object ownership.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; changed bodies are 117/117, 59/59, and
  220/220 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical, including `vars.obj`.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p469_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p469_20260831.json`
- `game_common_local_cleanup_undef_recon_p469_20260831.json`
- `game_common_local_cleanup_undef_src_p469_20260831.json`

## Next review target

The HumanCop portion is now declaration-clean. Continue into the Wingman
portion of the same exact TU, beginning with the smallest residuals:
`UpdateFreezeModeAndPullOverMode`, `CheckForActivation`, and `SetupWingman`.
Canonical field access and Speaker dispatch should be tested independently
before the large `HighExecute` and `SetupBlockader` bodies.
