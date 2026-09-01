# Game/common SYM-local cleanup (P460, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 659 at P459 to **661**.
- Generic unclassified extra-source-local findings fell from 1913 to
  **1907**: five decompiler temporaries were removed and one ABI residual was
  classified with a measured receipt.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aistate.cpp` remains 52/52 PASS.

## Exact source restorations

- `AIState_Purgatory` constructor is now fully SYM-declared. The random product
  is carried by the real `randtemp` global; direct `strcmp` conditions remove
  `bVar2`/`iVar3`; direct physics-timer and AI-flag RMWs remove `pCVar4` and
  `pCVar5`; `uVar1` is also gone. The function remains 108/108 PASS.

## Explicit ambiguity and measured carrier

- Donuts deleting destructor `pCVar1`: direct target-position accesses add
  four reload instructions and produce 8 diffs (29 versus retail's 25
  instructions). The deleting-destructor ABI body has no surviving local
  record, so this is retained as an explicit compiler carrier rather than a
  claimed recovered spelling.

## Overlay boundary retained

- `address.obj`: `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves the load window; separately linked `front.bin`
  functions occupy `[0x80010000, 0x80054548)` and are not resident-TU members.

## Gates

- `aistate.cpp`: 52/52 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p460_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p460_20260831.json`
- `game_common_local_cleanup_undef_recon_p460_20260831.json`
- `game_common_local_cleanup_undef_src_p460_20260831.json`
