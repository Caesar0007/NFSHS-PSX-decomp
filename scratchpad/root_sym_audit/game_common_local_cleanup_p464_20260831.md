# Game/common SYM-local cleanup (P464, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 678 at P463 to **682**.
- Generic unclassified extra-source-local findings fell from 1870 to
  **1857**. Eight decompiler locals were removed and five unavoidable
  code-generation carriers were closed with measured receipts.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aih_basicperp.cpp` remains 9/9 PASS.

## Exact source restoration

- `AIHigh_BasicPerp::RemoveCloseCops()` now uses every retail SYM local by its
  recorded name and type: `copLoop`, `cop`, `distance`, and `thisCop`.
  Decompiler locals `iVar1`, `iVar4`, `iVar6`, `carObj`, and `pAVar3` are gone.
- The invalid decompiler alias `pAVar3[3].schedulingOff_` is restored as the
  real `AIHigh_Cop::driveAway_` field with `DRIVEAWAY_RESET` and
  `DRIVEAWAY_NORESET`.
- The TU-local `Speaker` graph now carries the canonical virtual order through
  `Purge`: `Report`, `Status`, `Deny`, `Grant`, `Ready`, `Engage`, `Lose`,
  `Accident`, `Catch`, `RoadBlock`, `SpikeBelt`, `Backup`, `ReportBlockade`,
  `Roger`, `Bullhorn`, `Purge`. Consequently the raw `_vf + 0x80/0x84`
  dispatch and `pSVar2` are replaced by the original source-shaped
  `Speech_Mobile(thisCop->carObj_)->Purge()` expression. GCC emits the retail
  84-instruction body exactly.
- `RemoveChaser()` and `AddChaser()` now use the SYM-recorded `pos` local.
  `RemoveChaser()` also uses natural decrement spelling and both functions use
  direct return/source expressions where those reproduce retail exactly.

## Explicit measured carriers

- `CheckForCrimes::speed`: expanding its shared field value into two loads
  produces 169 instructions/14 diffs rather than 163/PASS.
- `CheckForCrimes::wrongWay`: a direct conditional sign expression produces
  164 instructions/7 diffs rather than 163/PASS.
- `RemoveChaser::piBase` and `piVar2`: SYM proves an inlined
  `AICop_BasicPerpInfo::this` block but does not preserve the inline member's
  source name. Direct array spelling produces 14 instructions/7 diffs; a
  collapsed pointer expression retains 15 instructions but gives 8 diffs.
- `AddChaser::piVar2`: the exact two-stage pointer shape is likewise the
  expansion of the SYM-proven inline subobject operation. Direct array spelling
  gives 19 instructions/12 diffs and a collapsed pointer gives 20/13 rather
  than the retail 21/PASS.

These names are reconstruction/code-generation carriers, not asserted retail
debug declarations.

## Separately linked frontend overlay

The five opcode-1 linker records supplied for `front.bin` agree exactly:

- `00010b: _front_obj = 0x80010000`
- `00011b: _front_objend = 0x80054548`
- `00012e: _front_org = 0x80010000`
- `00013e: _front_orgend = 0x80054548`
- `000151: _front_size = 0x44548`

Therefore `front.bin` is separately compiled/linked into the exclusive load
window `[0x80010000, 0x80054548)`. `bigbuf.obj` reserves that window and
`address.obj` describes its bounds; functions in the interval retain their
frontend overlay object ownership and are not resident-executable TU members.

## Gates

- `aih_basicperp.cpp`: 9/9 PASS; target bodies 163/163, 380/380, 84/84,
  15/15, 21/21, 87/87, 15/15, and 18/18 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean apart from line-ending notices.

Detailed declaration ledger: `game_common_strict_p464_20260831.md`.

Durable gate receipts:

- `game_common_local_cleanup_relink_p464_20260831.json`
- `game_common_local_cleanup_undef_recon_p464_20260831.json`
- `game_common_local_cleanup_undef_src_p464_20260831.json`
