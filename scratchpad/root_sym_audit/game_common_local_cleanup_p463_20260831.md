# Game/common SYM-local cleanup (P463, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 674 at P462 to **678**.
- Generic unclassified extra-source-local findings fell from 1885 to
  **1870**: ten decompiler locals were removed and five necessary
  code-generation carriers were closed with measured receipts.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aihigh.cpp` remains 14/14 PASS.

## Exact C++ source restorations

- `AIHigh_Base::AIHigh_Base(Car_tObj *)` now uses the natural inline source
  expression `SetState(new AIState_None(...), STATE_NONE)`. The corresponding
  inline `AIState_None(Car_tObj *)` constructor expresses the derived vptr
  installation. The manual `this_00` and `pAVar1` expansion is gone; the
  function remains an exact 43-instruction PASS.
- `AIHigh_Base::~AIHigh_Base()` now accesses `state_` directly. GCC performs
  the required common-subexpression carry itself, eliminating `pAVar1` while
  retaining the exact 29-instruction body.
- `AIHigh_StartUp` uses ordinary C++ `new T(...)` expressions for the concrete
  AI classes and a restored inline `AIHigh_None(Car_tObj *)` constructor.
  The generic allocation pointer `p` is gone; the function remains an exact
  234-instruction PASS.
- `AIHigh_Execute` now uses the SYM-recorded `carLoop` and `carObj` names,
  directly tests `Sched_ExecuteCheck`, directly reads the vtable, and indexes
  `highLevelAIObjs`/`Cars_gList`. GCC recreates the two strength-reduced array
  pointers automatically. `iVar2`, `iVar7`, `pa_Var3`, `pCVar4`, `ppAVar5`,
  and `ppCVar6` are gone; the function remains an exact 66-instruction PASS.

## Explicit measured carriers

- `AIHigh_StartUp::newHigh`: the reconstructed manual-vtable model needs one
  result carrier for the inline allocation/constructor branches. A natural
  BTC-perp-to-human-perp constructor chain compiles to 231 instructions with
  3 diffs because GCC deletes the intermediate base vptr store; a read fence
  retains it but produces 236 instructions and 12 diffs.
- `AIHigh_StartUp::slot`: direct indexed assignment produces 235 instructions
  and 25 diffs by changing the three-quantity local-allocation order.
- `AIHigh_StartUp::carFlags` and `copCarFlag`: these are the receipted
  local-allocator basin. The two-operand read fence on `copCarFlag` crosses the
  `QTY_CMP_PRI` reference step; removing the carrier or one required reference
  produces the known 8-diff allocation.
- `AIHigh_Execute::bVar1`: direct short-circuit spelling produces 61
  instructions and 33 diffs rather than the retail 66-instruction lifetime.

These names are explicitly treated as reconstruction/code-generation
carriers, not asserted retail debug declarations.

## Separately linked frontend overlay

- `address.obj` records `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves the resident load window. Frontend functions in that
  interval belong to separately compiled/linked `front.bin`, not to resident
  translation units merely because of their runtime addresses.

## Gates

- `aihigh.cpp`: 14/14 PASS.
- Target functions: 234/234, 66/66, 43/43, and 29/29 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean.

Detailed declaration ledger: `game_common_strict_p463_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p463_20260831.json`
- `game_common_local_cleanup_undef_recon_p463_20260831.json`
- `game_common_local_cleanup_undef_src_p463_20260831.json`
