# Game/common SYM-local cleanup (P455, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 618 at P454 to **635**.
- Generic extra-source-local findings fell from 2001 to **1959**.
- Missing SYM locals are **zero**. Type/storage findings, missing/extra
  globals, and vtable findings also remain zero; vtables remain 115/115
  mapped.
- `aidatarecord.cpp` remains 26/26 PASS and `aispeeds.cpp` remains 29/29
  PASS.

## Exact source restorations

All retained changes below are byte-exact.

- `AIDataRecord_CurveSpeedTable_t::Upgrade`: tested the three remaining
  non-SYM temporaries separately and added measured compiler receipts for the
  exact form.
- `AISpeeds_ReadTuningInfo`: direct UDFF-to-field assignments remove two
  decompiler temporaries.
- `AISpeeds_CalcOpponentTopSpeed`: direct repeated slice-lane access removes
  the synthetic `laneCount` local.
- `AISpeeds_NeedToSlowDownForCurve`: restored the two nested inline
  `AIPhysic_BrakeInfo` operations. The recovered helpers naturally recreate
  the SYM `currentSpeed`/`futureSpeed`, two `this`/`speed`/`sIndex` expansion
  scopes, and the exact 41-instruction function without manual table-walk
  temporaries.
- `AISpeeds_GetPrevAICar`: declaration order makes the recorded `carLoop`
  serve the zero-trip guard directly; `zeroTrip` is gone.
- `AISpeeds_GetCaravanFactor`: direct member expressions, signed `/ 256`
  source operations, and the original negated comparison remove all six
  unrecorded temporaries from the exact 239-instruction body.
- `AISpeeds_GetDamageFactor`: natural member assignments plus the recovered
  inline lower-bound shape remove four decompiler locals, the zero-insn asm
  fence, and the volatile reload while preserving all 70 instructions.
- `AISpeeds_CalcTrafficTopSpeed`: direct signed divisions remove four of five
  non-SYM temporaries.
- `AISpeeds_RandomizeTrafficSpeed`, `CalcDesiredSpeed`,
  `SetTrafficSpeedRandomFactor`, and `GetScriptFactor`: direct source forms
  remove eight non-SYM temporaries without changing code.
- All four upgrade-multiplier helpers now use the SYM-recorded `carObj` and
  `accMult`/`brakeMult`/`handlingMult`/`topSpeedMult` declarations instead of
  duplicate Ghidra names; each remains 47/47 PASS.

## Explicit ambiguity and measured carriers

- The unlinked identifiers `GetBrakeDistance`, `GetNeededDistance`, and
  `AISpeeds_Max` do not survive in the SYM. Their bodies, nested local scopes,
  call sites, and code generation are proven, but the semantic helper names
  are explicitly marked as inferred rather than claimed as recovered text.
- `Upgrade::round`: literal `0xffff` is 25 diffs and one instruction shorter.
- `Upgrade::pcVar1`: direct indexing is 16 diffs and two instructions longer.
- `Upgrade::iVar1`: the fixedmult result must remain live across signed
  rounding; folding the chain changes allocation.
- `BTCGetGlueFactor::clampedGlueIndex`: merging it into `glueIndex` is 12
  diffs; moving it to a caller-clean inline helper is still 10 diffs.
- `CalcTrafficTopSpeed::minimumSpeed`: a direct literal clamp is 6 diffs;
  the inline lower-bound form is 12 diffs.

These are compiler receipts, not assertions that the carrier spellings were
present in the lost source.

## Overlay boundary retained

The resident/overlay ownership model remains explicit and unchanged:

- `address.obj`: `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves that resident load window.
- `front.bin` is separately compiled/linked and occupies
  `[0x80010000, 0x80054548)`; its functions are not resident-TU members.

## Audit harness correction

The strict audit now validates inline-local receipts against both
`recon/nfs4_types.h` and the caller's adjacent `<tu>_types.h`, and follows
nested inline-call chains. It still requires a unique real helper definition,
a reachable call, and a matching ctags declaration. An early no-marker return
keeps the full audit runtime bounded.

## Gates

- `aidatarecord.cpp`: 26/26 PASS.
- `aispeeds.cpp`: 29/29 PASS.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean (line-ending conversion warnings only).

Detailed declaration ledger: `game_common_strict_p455_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p455_20260831.json`
- `game_common_local_cleanup_undef_recon_p455_20260831.json`
- `game_common_local_cleanup_undef_src_p455_20260831.json`
