# Game/common SYM-local cleanup (P467, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 689 at P466 to **693**.
- Generic unclassified extra-source-local findings fell from 1846 to
  **1837**; nine decompiler locals were removed with no new carrier.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restorations

- `AIHigh_BTC_HumanCop::ClearTrafficToPurgatory()` now uses the complete
  SYM-recorded local chain: `trafficLoop`, `testTrafficCarObj`, and
  `testTrafficHigh`. The decompiler's `highLevelAIObjs[index][1].state_` alias
  is restored to the real `AIHigh_Traffic::forcePurgatory_` field. Generic
  `iVar5`, `pCVar3`, and the unused `ppCVar4` are gone; the body remains 22/22.
- `ResetClearTrafficToPurgatory()` receives the same source restoration with
  the zero assignment. Generic `iVar5` and `pCVar3` are gone; it remains 21/21.
- `SetDesiredSpeed()` now uses only the SYM-recorded `curveSpeed`. A conditional
  assignment to `this->carObj_->desiredSpeed` preserves the retail load
  schedule; the initially tested statement form hoisted `carObj_` and produced
  25 instructions/11 diffs, while the retained expression is 24/24. Generic
  `iVar1` and `carObj` are gone.
- `AIHigh_BTC_HumanCop::HighExecute()` now accesses `perpTarget_` and
  `carObj_->control.queuedEvent` directly. Generic `pAVar2` and `pCVar1` are
  gone, leaving only the SYM-recorded stack local `notUsed`; the body remains
  118/118.

## Overlay ownership invariant

`front.bin` remains the separately compiled/linked payload for
`[0x80010000, 0x80054548)`, size `0x44548`; `bigbuf.obj` reserves the window
and `address.obj` provides its bounds.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; changed bodies are 22/22, 21/21, 24/24, and
  118/118 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p467_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p467_20260831.json`
- `game_common_local_cleanup_undef_recon_p467_20260831.json`
- `game_common_local_cleanup_undef_src_p467_20260831.json`

## Next review target

Continue the remaining HumanCop helpers in increasing complexity:
`UpdateAndCheckTimeLeft`, `RequestWingman`, and `RequestBlockader`. Their
speech temporaries should be migrated through the same canonical Speaker
method bridge used by `StartArrest`, while every non-speech local is checked
against its SLD block before removal.
