# P445 game/common render scratchpad-storage closure

## Scope

The strict game/common SYM audit reported eleven extra definitions in
`render.cpp`:

- `Render_gPacketLenLo`, `Render_gPacketLenHi`, `Render_gPacketEnd`
- `Render_gMenuRenderFlag`
- `Render_gWorldMat`, `Render_gNightMat`, `Render_gCopMat`
- `INT_1f800084`, `INT_1f800088`, `INT_1f80008c`, `INT_1f800090`

## Evidence and correction

None of these names exists in the trusted SYM, `NFS4.MAP`, linker symbol
maps, or `configs/symbol_addrs.txt`.  A tree-wide reference census found no
executable use of any linked definition: the remaining mentions were
definitions, unused extern declarations, one unused fixed-address helper, or
historical comments.

Retail instructions access the represented data through literal
`0x1F8000xx` PSX scratchpad addresses and typed draw-cache views.  A linked
BSS definition is therefore not merely unproved storage; it is the wrong
storage class and cannot represent the retail address.  The eleven fabricated
definitions and their stale declarations were removed.  Existing typed
scratchpad access and fixed-address lvalue macros were left unchanged.

## Verification

- Strict game/common audit: 547/547 SYM data records mapped; missing globals
  remain 0; extra definitions reduced from 167 to 156.
- Whole-TU authoritative gates:
  - `render.cpp`: 23/23 PASS
  - `bworld.cpp`: 21/21 PASS
  - `r3dcar.cpp`: 27/27 PASS
  - `draw.cpp`: 25/25 PASS
  - `draww.cpp`: 35/35 PASS
  - `hrzsku.cpp`: 22/22 PASS
  - `flare.cpp`: 27/27 PASS
- Both relink lanes GREEN: zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved names.
- Undefined-call audit: recon 15,781 calls and src 15,779 calls, zero
  undefined targets.
- Unsafe vtable indexing audit: PASS across 1,017 files.

Authoritative receipts accompany this report as
`game_common_strict_p445_20260831.md`,
`game_common_render_storage_relink_p445_20260831.json`, and the two
`game_common_render_storage_undef_*_p445_20260831.json` files.
