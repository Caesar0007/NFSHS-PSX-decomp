# Game/common SYM-local cleanup (P459, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 654 at P458 to **659**.
- Generic unclassified extra-source-local findings fell from 1926 to
  **1913**: five decompiler temporaries were removed and eight measured
  residuals were classified as codegen carriers.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aistate.cpp` remains 52/52 PASS.

## Exact source restorations

- `AIState_Offroad::Execute`: direct desired-speed member expressions remove
  `pCVar1` and `pCVar2`; 107/107 PASS.
- `AIState_Donuts::Execute`: direct slice-center copy and repeated `slice + 3`
  expression remove `sliceCenter` and `candidateSlice`; 319/319 PASS.
- Offroad deleting destructor: direct `carObj_` flag RMW removes `pCVar2` and
  naturally creates retail's required fresh pseudo; 29/29 PASS.

## Explicit ambiguity and measured carriers

- Chase constructor `direction`: direct field reads change 16 instructions
  and add eight load/delay instructions.
- Chase constructor `reverseDirCheck`: folding it into the identical-arm
  condition lets GCC delete the five-instruction test (61 versus 66 insns).
- Chase deleting destructor `pCVar1`: direct target-position accesses add four
  reloads and produce 8 diffs.
- Offroad deleting destructor `pCVar1`: the same direct form adds four reloads
  and produces 8 diffs.
- `AIState_Offroad::Execute::iVar4`: folding the spline-call result changes 73
  instructions and adds one by changing the frame/saved-register web.
- `AIState_Offroad::Execute::pCVar3`: direct target-position accesses add three
  redundant reload instructions.
- `AIState_Donuts::Execute::carObj`: direct member expressions change 14
  instructions and add two reloads.
- `AIState_Donuts::Execute::numSlicesLess3`: folding both wrap expressions
  changes 37 instructions and shortens the body by three.

These receipts classify irreducible current source/compiler ambiguity; they
do not claim that the decompiler spellings were present in the lost source.

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

Detailed declaration ledger: `game_common_strict_p459_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p459_20260831.json`
- `game_common_local_cleanup_undef_recon_p459_20260831.json`
- `game_common_local_cleanup_undef_src_p459_20260831.json`
