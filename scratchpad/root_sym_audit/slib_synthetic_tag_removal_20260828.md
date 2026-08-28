# SNDPSXZ slib synthetic-tag removal (2026-08-28)

## Source restoration

`recon/eaclib/psx/sndpsxz/slib.c` had two source-only local structure tags in
the stripped `slib.obj` owner:

- `InitWaitSpu` was a 432-byte padding shell around the SPU status halfword at
  hardware base `0x1f801c00 + 0x1ae`;
- `RestoreVoice` was never dereferenced as a structure. Its pointer was only a
  byte walker over the `sndpd` voice table at a `0x2c` stride.

Both artificial data models are removed. `iSNDinit` now keeps the original
base-plus-displacement machine shape with an `unsigned char *` and an explicit
volatile halfword access. `iSNDrestore` uses the honest `unsigned char *` table
walker directly. No audit suppression or post-compiler rewrite was added.

The first direct-address spelling of the SPU status register was measured and
rejected because it changed `iSNDinit` by four instructions. The retained
base-plus-`0x1ae` spelling restores PASS and documents why the address is kept
in that form.

## Matching and SYM proof

- `slib.c`: 5/5 PASS after both tag removals;
- focused `slib_type_graph_p336_20260828.tsv`: OK, zero residual records;
- full `project_type_graph_p337_20260828.tsv`: 375 OK / 42 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p335, exactly `slib.c` changed `DIFF -> OK`; all other
  status/counter rows are unchanged.

## Integrity proof

- both relink lanes GREEN; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined calls: zero in both lanes (15,782 reconstruction and 15,779 source
  call relocations scanned);
- proven wrong call targets: 0/460;
- TU order: 513 owners, zero inversions;
- no unsafe direct vtable-row indexing across 983 files;
- no post-compiler text moves or branch retargets;
- full phantom rebuild: 513/513 owners compiled, 3484/3484 oracle symbols
  exact-matched, zero hidden phantoms, and zero ownership/missing gaps.

The only rebuild warning is the pre-existing unavailable optional
`2.8.1-norcse` rung, unrelated to `slib.c`.
