# PsyQ SDK and private owner surfaces (2026-08-28)

## Scope

- `recon/syslib/psx/libgpu/P06.c`
- `recon/syslib/psx/libpress/VLC.c`
- `recon/eaclib/psx/spchpsxz/spchevnt.c`
- `recon/syslib/psx/libpad/PADENTRY.c`
- `recon/syslib/psx/libpad/PADMAIN.c`

These linked archive members retain empty retail type graphs, while their
source or instructions require exact SDK/private owner types.

## Source restoration

`P06.c` previously declared a reconstruction-only four-byte prefix and called
it `P_TAG`. PsyQ 4.3 `LIBGPU.H` defines the actual type as an eight-byte
anonymous structure: a 24-bit `addr`, an 8-bit `len`, followed by the four
bytes `r0`, `g0`, `b0`, and `code`. The source now uses that complete canonical
definition. `AddPrim` remains byte-exact.

Canonical evidence:

- `C:/Temp/ps1-decomp-refs/glover/Include.43/LIBGPU.H`
- `C:/Temp/psq44/psx/include/LIBGPU.H`
- PsyQ 4.3 extracted `P06` owner in
  `C:/Temp/nfs4-clean/psyq43/extracted/LIBGPU`

`VLC.c` is PsyQ LIBPRESS hand-written assembly and uses the canonical
`SYS/TYPES.H` aliases `u_int`, `u_long`, and `u_short`. The audit accepts only
those exact fundamental aliases in that exact SDK owner.

## Exact private carriers

- `VoxSlot`: exact 60-byte typed view of aliased `gVoxEvents`, including both
  overlay words, enabled/subtick fields, tick/event words, and ten arguments.
- `_PadDev`: exact 236-byte PADENTRY controller record with every named field,
  padding span, pointer leaf type, and offset locked.
- `_PadIntRP`: exact 16-byte PADMAIN interrupt-path record with self-link,
  handler, verifier, and trailing word locked.

Each aggregate is accepted only as a complete owner/tag/typedef pair. Any
name, size, member, offset, leaf type, compiler-tag link, or owner drift remains
visible. This is not a generic allowlist. The audit-tool pre-change backup is
Git commit `49c32f8e`.

## Matching proof

- `P06.c`: 1/1 PASS, repeated after the source correction
- `VLC.c`: 2/2 PASS
- `spchevnt.c`: 16/16 PASS
- `PADMAIN.c`: 11/11 PASS
- `PADENTRY.c`: 7/8 PASS; only the pre-existing four-diff `PadGetState`
  epilogue residual remains, unchanged by this type-graph work

## SYM graph proof

All five focused p317/p318 reports are `OK` with zero residual records. The
authoritative `project_type_graph_p319_20260828.tsv` reports:

- OK: 361
- DIFF: 56
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared with p315, exactly these five owners changed `DIFF -> OK`; no other
owner changed status.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- undefined calls: zero in both lanes
- proven wrong call targets: 0/460
- TU order: 513 owners, zero inversions
- no unsafe direct vtable-row indexing across 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps

The rebuild emitted only the pre-existing optional `2.8.1-norcse` ladder-rung
warning; affected owners used their configured fallback compiler. It does not
affect these owners or the zero-gap result.
