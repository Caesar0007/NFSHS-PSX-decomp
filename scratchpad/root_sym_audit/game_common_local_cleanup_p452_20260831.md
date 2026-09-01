# Game/common SYM-local cleanup (P452, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 584 at P448 to **595**.
- Generic extra-source-local findings fell from 2053 to **2038**.
- Missing SYM locals, type findings, function storage findings, and
  missing/extra globals remain zero.
- Vtable mapping remains 115/115.

## Exact source restorations

All retained edits are byte-exact:

- `AIHigh_BasicCop::ShouldIPerformCutOffBlock`: removed the absent
  `targetLatPosition` temporary and used the target field expression directly.
- `AIHigh_Cop::CheckForNeedyPlayers`: removed decompiler-only `iVar1` and used
  the expression-level absolute-value idiom.
- `AIHigh_Traffic::CheckForCops`: removed `currentBest` and compared against
  the recorded pointer target directly.
- `AIHigh_Traffic::CheckForNewTriggers`: removed the absent `sortedCar`
  pointer-walk and restored indexed `Cars_gTotalSortedList[sortedLoop]` access.
- `AIHigh_BTC_HumanCop::ReleaseAndStartChase`: removed decompiler-only
  `pCVar1` and used `this->carObj_` directly.
- `AIHigh_BTC_HumanCop::HudOn`: replaced invented `pCVar1` with the already
  SYM-recorded `arrestingHumanCop` local, restoring both its assignment and use.
- `AIInit_StartUp1`: restored the sole SYM-recorded `i` as the natural indexed
  `for` variable, removing three decompiler pointer/value temporaries.
- `AIInit_CleanUp2`: restored the two SYM-recorded block-local `carLoop`
  variables and natural indexed loops, removing `carObj`, `ppCVar1`, and
  `iVar2`.
- `AI_TrafficStartUp`: removed `rawTriggers`; the owning
  `AITraffic_rawTriggers` global is assigned, tested, and passed directly.

## Measured compiler carriers

Two absent names could not be removed without changing retail code and are now
explicitly separated from the SYM-restoration queue:

- `FindRandomBarrierFreeArea::doubledFraction`: direct expression folding
  produces 4 oracle diffs.
- `UpdateFreezeModeAndPullOverMode::startingDirection`: direct field assignment
  produces 6 oracle diffs.

## Gates

- `aih_basiccop.cpp`: 9/9 PASS.
- `aih_btccop.cpp`: 40/40 PASS.
- `aih_cop.cpp`: 10/10 PASS.
- `aih_traf.cpp`: 6/6 PASS.
- `aiinit.cpp`: 17/17 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p452_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p452_20260831.json`
- `game_common_local_cleanup_undef_recon_p452_20260831.json`
- `game_common_local_cleanup_undef_src_p452_20260831.json`
