# Game/common SYM-local cleanup (P468, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 693 at P467 to **696**.
- Generic unclassified extra-source-local findings fell from 1837 to
  **1824**; thirteen decompiler locals were removed with no new carrier.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restorations

- `AIHigh_BTC_HumanCop::UpdateAndCheckTimeLeft()` now uses only its recorded
  function-local static `sayLose`. The six decompiler-only temporaries
  `_Var3`, `pAVar1`, `pSVar2`, `perpname`, `timeleft`, and `iVar4` are gone;
  member accesses are direct and `Speech_Mobile(...)->Lose()` expresses the
  source-level virtual call. The body remains byte-exact at 69/69.
- `RequestWingman()` now uses the real SYM local
  `wingmanActivationTime` instead of `iVar2`. The two raw Speaker temporaries
  are gone and the calls are expressed as `Backup()` and `Deny()` through the
  measured Speaker ABI bridge. The body remains byte-exact at 71/71.
- `RequestBlockader()` retains only its SYM-recorded `availableTime` local.
  Four raw Speaker temporaries are gone and the source-level operations are
  named `SpikeBelt()`, `RoadBlock()`, `Grant()`, and `Deny()`. The body remains
  byte-exact at 118/118.
- `Speaker` now has interim inline ABI bridges for the seven virtual operations
  used by the restored HumanCop bodies. These retain the retail cfront
  adjustment-and-dispatch sequence while making the reconstructed call sites
  semantic. A later whole-type migration can replace the remaining manual
  `_vf` representation once every user in the TU is converted together.

## Overlay ownership invariant

The five authoritative SYM boundary records are:

- `_front_obj = _front_org = 0x80010000`
- `_front_objend = _front_orgend = 0x80054548`
- `_front_size = 0x44548`

Therefore `front.bin` is a separately compiled/linked overlay occupying
`[0x80010000, 0x80054548)`. `bigbuf.obj` reserves that exact window in the
resident image, while `address.obj` owns/describes the start, end, and size
symbols. Functions within this range retain their overlay object/module
ownership and must not be reassigned to ordinary resident objects.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; changed bodies are 69/69, 71/71, and 118/118
  instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical, including `vars.obj`.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p468_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p468_20260831.json`
- `game_common_local_cleanup_undef_recon_p468_20260831.json`
- `game_common_local_cleanup_undef_src_p468_20260831.json`

## Next review target

Continue the remaining HumanCop helpers in increasing source-restoration
complexity: `FreezeAndEndChase`, `CheckConditionWithCop0`, and `NewStage`.
Their SLD blocks record no ordinary locals currently represented by the
decompiler temporaries, so each removal must be verified independently before
retention.
