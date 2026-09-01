# Game/common SYM-local cleanup (P453, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 595 at P452 to **606**.
- Generic extra-source-local findings fell from 2038 to **2020**.
- Missing SYM locals, type findings, storage findings, missing/extra globals,
  and vtable findings remain zero; vtables remain 115/115 mapped.

## Exact source restorations

All retained source-shape changes are byte-exact:

- `AIInit_RestartAICar`: removed both absent matching-aid locals; a chained
  direction assignment shares the value naturally and the direct
  `originalDesiredSpeed` store remains exact.
- `AIInit_LoadPhysicsConfig`: uses only the SYM-recorded `model` and `loop`;
  eleven configuration fields receive `Udff_GetInt` directly.
- `AIPerson_Startup`: removed `pathBase` and indexes `Paths_Paths` directly.
- `AIPhysic_CalculateGear`: removed `rawSpeed`; direct absolute-value and
  top-speed call expressions remain exact.
- `AILife_EvaluateLife`: removed both decompiler temporaries and assigns/tests
  `carObj->basisCar` directly.
- `AILife_IsTrafficCarInAnyLiveArea`: restored the natural indexed loop using
  only SYM-recorded `racerLoop` and `tPos`.
- `AILife_IsCarInAnyVisibleArea`: returns the callee directly.
- `AILife_IsPositionInAnyVisibleArea`: restored the natural indexed loop using
  only the SYM-recorded `racerLoop`.

## Measured compiler carriers

- `AIPhysic_RevEngine::deadfrm`: SYM explicitly reports fsize=8/mask=0 but no
  AUTO local; removing the two-word frame carrier produces 3 oracle diffs.
- `AIPhysic_CalculateGear::found`: nested and compound no-local branch shapes
  both produce 54 oracle diffs.
- `AILife_IsSliceInAnyVisibleArea::ppCVar2`: direct indexed goto form produces
  23 diffs; natural indexed for-loop produces 49.
- `AILife_IsSliceCloseToAnyCopCar::ppCVar2`: direct indexed form produces 23
  diffs in the parallel cop-list loop.

These are explicit experimental dispositions, not claims that the lexical
names are recovered from SYM.

## Gates

- `aiinit.cpp`: 17/17 PASS.
- `aiperson.cpp`: 8/8 PASS.
- `aiphysic.cpp`: 42/42 PASS.
- `ailife.cpp`: 20/20 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p453_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p453_20260831.json`
- `game_common_local_cleanup_undef_recon_p453_20260831.json`
- `game_common_local_cleanup_undef_src_p453_20260831.json`
