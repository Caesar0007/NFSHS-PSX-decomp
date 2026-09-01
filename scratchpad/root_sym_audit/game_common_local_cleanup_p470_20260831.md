# Game/common SYM-local cleanup (P470, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 699 at P469 to **702**.
- Generic unclassified extra-source-local findings fell from 1807 to
  **1800**.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- Two anonymous allocation values are now explicit, oracle-receipted
  code-generation carriers; the carrier count increased from 81 to 83.
- The complete `aih_btccop.cpp` TU remains 40/40 PASS.

## Exact source restorations

- `AIHigh_BTC_Wingman::CheckForActivation()` now uses exactly the SYM locals
  `spikeBeltRequest`, `carLoop`, block-scoped `otherCarObj`, and nested
  `copHigh`. Decompiler aliases `iVar1`, `WVar3`, `ppCVar4`, and `copTable` are
  gone. Direct `Cars_gList`/`highLevelAIObjs` indexing and the canonical
  `ROLE_BLOCKADER` enumerators remain byte-exact at 76/76.
- `UpdateFreezeModeAndPullOverMode()` replaces generic `_Var1` with the
  semantic `oldFreezeMode` allocation value. The retail instructions load the
  old mode, clear the member, then compare the saved value. Control-flow
  expansion grows the body from 16 to 20 instructions and produces 20 diffs,
  so the value has an explicit carrier receipt. The retained body is 16/16.
- `SetupWingman()` now expresses the retail virtual dispatch as
  `Speech_Dispatch()->Ready(this->carObj_)` through the measured Speaker ABI
  bridge; generic `pSVar1` is gone. The scaled `sideTimes28` product remains an
  explicit carrier because either direct multiplication association preserves
  79 instructions but causes six register diffs. The retained body is 79/79.
- The local Speaker interface now includes the semantic `Ready(Car_tObj *)`
  bridge for the retail virtual-table row at descriptor offsets `0x28/0x2c`.

## Overlay ownership invariant

`front.bin` remains a separately compiled/linked overlay occupying
`[0x80010000, 0x80054548)`, with `_front_size = 0x44548`. `bigbuf.obj`
reserves that resident load window and `address.obj` owns/describes its
boundaries. Functions in the interval retain their frontend object ownership.

## Gates

- `aih_btccop.cpp`: 40/40 PASS; changed bodies are 16/16, 76/76, and 79/79
  instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical, including `vars.obj`.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p470_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p470_20260831.json`
- `game_common_local_cleanup_undef_recon_p470_20260831.json`
- `game_common_local_cleanup_undef_src_p470_20260831.json`

## Next review target

Only `HighExecute()` and `SetupBlockader()` remain in the Wingman section.
Take `SetupBlockader()` first: map its recorded `initSlice`, `copObj`,
`blockadeType`, and nested SLD locals onto the current aliases; also reuse the
now-proven `Ready()` Speaker bridge. Leave the much larger `HighExecute()` for
the following focused round.
