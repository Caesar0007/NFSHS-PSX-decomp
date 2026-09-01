# Game/common SYM-local cleanup (P454, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 606 at P453 to **618**.
- Generic extra-source-local findings fell from 2020 to **2001**.
- Missing SYM locals, type/storage findings, missing/extra globals, and vtable
  findings remain zero; vtables remain 115/115 mapped.

## Exact source restorations

All retained changes are byte-exact:

- `AIDataRecord_t::AddRecordToCollection` and
  `RemoveRecordFromCollection`: natural indexed loops using only the recorded
  `recordLoop`.
- `AIDataRecord_t::StartUp1`: recorded reverse `recordLoop` clears the static
  collection directly.
- `AIDataRecord_t::StartUp2`: recorded index loop replaces the decompiler
  counter/pointer pair; only the measured virtual-dispatch value remains.
- `AIDataRecord_t::Setup`, `Load`, and `SaveAndPurge`: direct member/call source
  forms remove five decompiler temporaries.
- `AIDataRecord_AccTable_t::Setup`: recorded `loop` replaces `speed`; the
  verified goto loop preserves retail control flow.
- BestLine and TrackCurve constructors: chained member assignments share
  `gNumSlices` without source locals absent from SYM.

## Measured compiler carriers

- `AIPhysic_GetRearEndDamageFactor::result`: ternary removal is 21 diffs;
  early-return form is 23.
- `AIDataRecord_t::StartUp2::pAVar1`: direct virtual call through the indexed
  collection element is 11 diffs.
- `AIDataRecord_t::CleanUp1::pa_Var1`: natural delete expressions are 24
  diffs; the shared vtable row preserves retail dispatch allocation.
- `AIDataRecord_AccTable_t::Setup::iVar1`: folding the Get/fixedmult/store chain
  is 6 diffs.

These markers are experimental code-generation receipts, not assertions that
their lexical names survive in SYM.

## Gates

- `aiphysic.cpp`: 42/42 PASS.
- `aidatarecord.cpp`: 26/26 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p454_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p454_20260831.json`
- `game_common_local_cleanup_undef_recon_p454_20260831.json`
- `game_common_local_cleanup_undef_src_p454_20260831.json`
