# EACLIB alias and control-record cleanup (2026-08-28)

## Scope

- `recon/eaclib/psx/spchpsxz/spchrule.c`
- `recon/eaclib/psx/eacpsxz/fileroot.c`
- `recon/eaclib/psx/eacpsxz/syncfile.c`

## Source restoration

`spchrule.c` no longer invents the unused `bool`, `true`, and `false` surface
or the callback-only `SentenceRuleSetFn` and `SentenceRuleTestFn` aliases. The
two callback tables retain their required unsized-array declaration shape, but
now spell the function-pointer types directly. This removes four source-only
typedef/macro names without changing generated code.

`fileroot.c` no longer includes unused `<stddef.h>`. Its owner-local `ReadCmd`
record is accepted only as the exact 20-byte SYM/codegen carrier: five named
`int` members (`pending`, `handle`, `dest`, `offset`, and `len`) at offsets
0, 4, 8, 12, and 16.

`syncfile.c` no longer invents the callback-only `SyncIoFn` typedef. The
callback type is written directly in `SyncCtrl::iofn` and the `syncblockio`
declaration/definition. `SyncCtrl` is accepted only as its exact 36-byte
owner-local view: seven leading `int` fields, the function pointer at offset
28, and `op` at offset 32.

The audit exceptions are complete owner/tag/size/member/type/offset locks, not
generic allowlists. Any drift in these records remains visible. The audit-tool
pre-change backup is Git commit `c0950c17`.

## Matching proof

- `spchrule.c`: 9/9 PASS
- `fileroot.c`: 9/9 PASS
- `syncfile.c`: 8/8 PASS

All three were repeated after the final source and audit state.

## SYM graph proof

The focused p321/p322 reports are `OK` with zero residual records. The complete
`project_type_graph_p323_20260828.tsv` sweep over 458 audited units reports:

- OK: 364
- DIFF: 53
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared row-for-row with p319, exactly `spchrule.c`, `fileroot.c`, and
`syncfile.c` changed `DIFF -> OK`; no other owner changed status.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols
- undefined calls: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned)
- proven wrong call targets: 0
- TU order: 513 owners, zero inversions
- no unsafe direct vtable-row indexing across 983 files
- no post-compiler text moves or branch retargets
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps

The rebuild emitted only the pre-existing optional `2.8.1-norcse` ladder-rung
warning; affected owners used their configured fallback compiler. It does not
affect these owners or the zero-gap result.
