# Game/common SYM-local cleanup (P457, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 641 at P456 to **648**.
- Generic unclassified extra-source-local findings fell from 1950 to
  **1935**: eight decompiler temporaries were removed and seven measured
  residuals were classified as codegen carriers.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aistate.cpp` remains 52/52 PASS.

## Exact source restorations

- `AIState_Chase::SetTarget`: direct comparisons against `targetCar_`
  dimensions and `relPosition_` remove `iVar1` and `iVar3`; 56/56 PASS.
- `AIState_Chase::DoNitrous`: direct `carObj_` member accesses remove
  `pCVar2`; 83/83 PASS.
- `AIState_Chase::SetUp`: removed the wholly unused `pCVar1`; 87/87 PASS.
- `AIState_Chase::CheckForBarriersAndTargetAroundThem`: direct absolute-value,
  `carObj_`, and slice-byte expressions remove `lm`, `pCVar3`, `bVar1`, and
  `bVar2`; 84/84 PASS.

## Explicit ambiguity and measured carriers

- `SetUp::pCVar2`: direct target-position member accesses produce 8 diffs and
  four extra reload instructions.
- `SetUp::iVar2`: folding its two direction selections and spline-call result
  changes 75 instructions and adds one.
- `SetUp::dc`: direct `delayCar_` access changes 20 instructions and shortens
  the body by four; retail retains the address in a saved register across
  `Update()`.
- `Execute::lmAbs`: folding it changes 25 instructions and adds one; reusing
  the dead recorded `velocityToHitInTime` changes 28 and adds two.
- `FindBarrierEndSlice::numSlicesLess6`: folding both branch-scoped values
  changes 21 instructions and shortens the function by three.
- `ApproachTargeting::pCVar4`: direct `carObj_` accesses change 14 instructions
  and add two reloads.
- `ApproachTargeting::iVar5`: replacing its global/aggression/result web with
  direct expressions and recorded `minSpeed` changes 25 instructions and
  shortens the body by one.

These are compiler receipts, not claims that the carrier spellings were in
the lost source.

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

Detailed declaration ledger: `game_common_strict_p457_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p457_20260831.json`
- `game_common_local_cleanup_undef_recon_p457_20260831.json`
- `game_common_local_cleanup_undef_src_p457_20260831.json`
