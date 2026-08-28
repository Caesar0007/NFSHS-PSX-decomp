# Canonical PsyQ LIBGPU environment and move types (2026-08-28)

## Scope

- `recon/syslib/psx/libgpu/EXT.c`
- `recon/syslib/psx/libgpu/P34.c`

Canonical source evidence is PsyQ 4.3.0 `PSX43/psx/include/libgpu.h` under
`C:/Temp/nfs4-clean/psyq43`.

## Source restoration

`EXT.c` previously used a reconstruction-only named, flattened, 28-byte
`DRAWENV` prefix and raw `short *` / `u_char *` views for `DISPENV`. It now
spells the complete canonical PsyQ 4.3 graph:

- `RECT`: 8 bytes
- `DR_ENV`: 64 bytes (`tag` plus fifteen command words)
- `DRAWENV`: 92 bytes, including nested `clip`, `tw`, and reserved `dr_env`
- `DISPENV`: 20 bytes

The two function signatures and every member access now use those real SDK
types. The retail store order is preserved, including the four trailing
`DISPENV` bytes. Both functions remain byte-exact.

`P34.c` already contained the canonical PsyQ `P_TAG`, `RECT`, and `DR_MOVE`
definitions that made `SetDrawMove` PASS. The audit now recognizes only their
complete canonical typedef/tag/layout pairs and exact fundamental aliases in
that exact LIBGPU owner.

These are owner/path/name/size/member/type/offset/dimension locked SDK
exceptions, not name-only or generic allowlists. Any declaration drift remains
visible. The audit-tool and `EXT.c` pre-change backup is Git commit `2fcfdbeb`.

## Matching proof

- `EXT.c`: 2/2 PASS after the complete canonical rewrite
- `P34.c`: 1/1 PASS

Both were repeated after the final source and audit state.

## SYM graph proof

The focused p325 reports are `OK` with zero residual records. The complete
`project_type_graph_p326_20260828.tsv` sweep over 458 audited units reports:

- OK: 366
- DIFF: 51
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared row-for-row with p323, exactly `EXT.c` and `P34.c` changed
`DIFF -> OK`; no other owner changed status.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- undefined calls: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned)
- proven wrong call targets: 0/460
- TU order: 513 owners, zero inversions
- no unsafe direct vtable-row indexing across 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps

The rebuild emitted only the pre-existing optional `2.8.1-norcse` ladder-rung
warning; affected owners used their configured fallback compiler. It does not
affect these owners or the zero-gap result.
