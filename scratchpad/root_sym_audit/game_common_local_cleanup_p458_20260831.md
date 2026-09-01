# Game/common SYM-local cleanup (P458, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 648 at P457 to **654**.
- Generic unclassified extra-source-local findings fell from 1935 to
  **1926**; nine decompiler temporaries were removed.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aistate.cpp` remains 52/52 PASS.

## Exact source restorations

- `AIState_Offroad::UnleashIfInRange`: the recorded `distanceAbsMeters`
  directly receives the absolute spline distance, removing `iVar2`; 30/30
  PASS.
- `AIState_GotoSlice::InTargetSliceRange`: restored the recorded
  `distanceMeters` variable throughout, removing `iVar1`; 17/17 PASS.
- `AIState_Purgatory::Execute`: direct `carObj_` accesses remove `pCVar1`;
  26/26 PASS.
- `AIState_RovingTraffic` constructor: source-order direct trigger-field
  assignments and direct `carObj_` access remove `iVar1` and `pCVar2`; 26/26
  PASS.
- `AIState_Offroad` constructor: direct `carObj_` flag update removes
  `pCVar3`; 82/82 PASS.
- `AIState_Cruise::Execute`: direct switch/member/call-result expressions
  remove `cVar2`, `pCVar3`, and `iVar1`; 53/53 PASS.

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

Detailed declaration ledger: `game_common_strict_p458_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p458_20260831.json`
- `game_common_local_cleanup_undef_recon_p458_20260831.json`
- `game_common_local_cleanup_undef_src_p458_20260831.json`
