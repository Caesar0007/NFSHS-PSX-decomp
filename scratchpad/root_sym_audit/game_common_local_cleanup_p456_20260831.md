# Game/common SYM-local cleanup (P456, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 635 at P455 to **641**.
- Generic unclassified extra-source-local findings fell from 1959 to **1950**;
  three measured residuals are now explicitly classified as codegen carriers.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings also remain zero; vtables remain
  115/115 mapped.
- `aispeeds.cpp` remains 29/29 PASS, `aiscript.cpp` remains 8/8 PASS, and
  `aistate.cpp` remains 52/52 PASS.

## Exact source restorations

- `AISpeeds_CalcHumanCurveSpeed`: replaced the unrecorded `scaled` temporary
  with the original signed `/ 0x10000` expression. The function remains an
  exact 183-instruction match.
- `AIScript_ClearLastReactionIndex`: replaced the decompiler pointer walk with
  direct `lastReactionIndex[initLoop]` indexing, removing `pAVar2`; the
  function remains 9/9 PASS.
- `AIScript_DoReAction`: restored the SYM-recorded `humCarIndex` name and
  removed the duplicate `iVar1`; the function remains 12/12 PASS.
- `AIState_Base::StateExecute`: direct `this->carObj_` accesses remove
  `pCVar1`; the function remains 34/34 PASS.
- `AIState_Idle::Execute`: the SYM-recorded `off` now carries the signed
  quarter-speed calculation, and direct member accesses remove `iVar1` and
  `pCVar2`; the function remains 47/47 PASS.

## Explicit ambiguity and measured carriers

- `CalcHumanCurveSpeed::off`: direct expressions preserve length but allocate
  the offsets to `$v0` (6 diffs); reusing the SYM `curveAhead` local produces
  30 diffs. A separate scalar is required for retail's `$v1` allocation.
- `ClearLastReactionIndex::neg1`: a literal or `const` local preserves the
  9-instruction body but schedules `li $v1,-1` after `li $v0,6` (2 diffs).
  A mutable scalar reproduces the retail order.
- `AIState_Normal::pCVar1`: direct member access CSEs two retail reloads
  (8 diffs and four fewer instructions); retaining the constructor parameter
  across the base-constructor call changes the frame/allocation (26 diffs).

These are measured compiler receipts, not claims that the carrier spellings
were present in the lost source.

## Overlay boundary retained

- `address.obj`: `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves that resident load window.
- `front.bin` is separately compiled/linked and occupies
  `[0x80010000, 0x80054548)`; functions resident in that range belong to the
  front overlay rather than resident translation units.

## Gates

- `aispeeds.cpp`: 29/29 PASS.
- `aiscript.cpp`: 8/8 PASS.
- `aistate.cpp`: 52/52 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p456_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p456_20260831.json`
- `game_common_local_cleanup_undef_recon_p456_20260831.json`
- `game_common_local_cleanup_undef_src_p456_20260831.json`
