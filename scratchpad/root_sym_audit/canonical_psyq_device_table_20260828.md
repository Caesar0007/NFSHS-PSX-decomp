# Canonical PsyQ device table in FIRST (2026-08-28)

## Scope and source evidence

`recon/syslib/psx/libapi/FIRST.c` previously reconstructed the BIOS device
table as a private `DCB` with two padding arrays and an untyped handler slot.
PsyQ 4.3.0 supplies the original public declaration in
`C:/Temp/nfs4-clean/psyq43/PSX43/psx/include/fs.h` as
`struct device_table`.

## Source restoration

The source now reproduces the complete canonical 80-byte SDK structure:

- `dt_string`, `dt_type`, `dt_bsize`, and `dt_desc`
- all sixteen function-pointer slots from `dt_init` through `dt_else`
- `dt_firstfile` at offset 52, the slot patched by this owner

The reconstructed `DCB` and callback-only `FirstFn` names are removed. The BIOS
table base, both searches, saved callback, patch install/restore, and size
arithmetic now use `struct device_table` and `dt_firstfile` directly. The old
PsyQ no-prototype function-pointer spelling is preserved.

The stripped-owner audit accepts only the exact owner/tag/80-byte layout with
all twenty field names, leaf types, and offsets locked. Any drift remains
visible. The source and audit-tool pre-change backup is Git commit `065be180`.

## Matching proof

- `firstfile`: PASS
- `_first_patch`: PASS
- owning TU: 2/2 PASS after the canonical rewrite and after final audit state

## SYM graph proof

The focused `first_type_graph_p332_20260828.tsv` report is `OK` with zero
residual records. The complete `project_type_graph_p333_20260828.tsv` sweep over
458 audited units reports:

- OK: 373
- DIFF: 44
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared row-for-row with p330, only `FIRST.c` changed `DIFF -> OK`; no other
owner changed status.

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
affect FIRST or the zero-gap result.
