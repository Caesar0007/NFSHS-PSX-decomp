# Game/common SYM-local cleanup (P462, 2026-08-31)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 673 at P461 to **674**.
- Generic unclassified extra-source-local findings fell from 1887 to
  **1885**.
- Missing SYM locals remain **zero**. Type/storage findings,
  missing/extra globals, and vtable findings remain zero; vtables remain
  115/115 mapped.
- `aidelaycar.cpp` remains 3/3 PASS.

## Exact source restoration

`AIDelayCar::Update` now contains exactly the local declarations recorded by
the retail SYM:

- `coorddef currentDeltaPosition` at stack offset `-0x28`;
- `coorddef changeDeltaPosition` at stack offset `-0x18`;
- register local `int currentDeltaRoadPosition`.

The decompiler-only `newDeltaMeters` name was removed by updating
`deltaMeters_` directly. The decompiler-only `iVar1` lifetime was folded into
the real `currentDeltaRoadPosition` local, which the compiler reuses before
its later road-position calculation. The resulting function remains an exact
148-instruction PASS with the retail frame size and register mask unchanged.

## Separately linked frontend overlay

- `address.obj` records `_front_obj == _front_org == 0x80010000`,
  `_front_objend == _front_orgend == 0x80054548`, and
  `_front_size == 0x44548`.
- `bigbuf.obj` reserves this resident load window.
- Functions occupying `[0x80010000, 0x80054548)` are compiled and linked into
  `front.bin` separately. They are overlay members, not members of a resident
  translation unit merely because they execute at the reserved addresses.

## Gates

- `aidelaycar.cpp`: 3/3 PASS; `AIDelayCar::Update`: 148/148 instructions.
- Both relink lanes GREEN: real duplicates 0, hidden phantoms 0,
  relocation-referenced unresolved 0.
- Undefined calls: recon 15,781/0; source 15,779/0.
- Data-only payload audit: 11/11 byte-identical.
- `git diff --check`: clean.

Detailed declaration ledger: `game_common_strict_p462_20260831.md`.

Durable link receipts:

- `game_common_local_cleanup_relink_p462_20260831.json`
- `game_common_local_cleanup_undef_recon_p462_20260831.json`
- `game_common_local_cleanup_undef_src_p462_20260831.json`
