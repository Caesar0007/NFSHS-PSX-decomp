# Game/common SYM-local cleanup (P466, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 685 at P465 to **689**.
- Generic unclassified extra-source-local findings fell from 1851 to
  **1846**; five decompiler locals were removed with no new carrier.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restorations

- `AIHigh_BTC_Cop::GetCheckChasePosition()` now uses the SYM-recorded
  `newPosition` as the `CheckChaserPosition()` result. The later chase-position
  table access correctly indexes with `this->chaseIndex_` directly. Generic
  `iVar2` is gone and the function remains 39/39.
- `AIHigh_BTC_Cop::StartArrest()` now accesses `this->carObj_` directly and
  expresses the canonical speech operation as
  `Speech_Mobile(this->carObj_)->Catch(1)`. Generic `carObj` and `pSVar1` are
  gone; the function remains 28/28.
- The `Speaker::Catch(int)` declaration is represented as an inline semantic
  method over this TU's existing manual Speaker ABI view. This is an interim
  layout bridge: it emits the exact canonical virtual slot-9 dispatch while
  allowing the call site to recover its original C++ statement shape. The
  bridge can disappear when all Speaker calls in this large TU migrate as one
  complete virtual-class conversion.
- `AIHigh_BTC_Cop::FinishArrest()` dispatches through `this->_vf` directly;
  the redundant `pa_Var1` copy is gone and the function remains 24/24. The
  virtual hierarchy itself remains a separately identified whole-type
  restoration task because this slot is overridden by HumanCop.
- `AIHigh_BTC_HumanCop` construction writes `this->carObj_->unlap` directly.
  Generic `pCVar2` is gone and the constructor remains 135/135.

## Overlay ownership invariant

`front.bin` remains the separately compiled/linked payload for
`[0x80010000, 0x80054548)`, size `0x44548`; `bigbuf.obj` reserves this window
and `address.obj` provides its load bounds.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; changed bodies are 39/39, 28/28, 24/24, and
  135/135 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p466_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p466_20260831.json`
- `game_common_local_cleanup_undef_recon_p466_20260831.json`
- `game_common_local_cleanup_undef_src_p466_20260831.json`

## Next review target

Continue within `aih_btccop.cpp` with the small HumanCop helpers
`ClearTrafficToPurgatory`, `ResetClearTrafficToPurgatory`, `SetDesiredSpeed`,
and `HighExecute` before returning to the larger arrest/stage state machines.
