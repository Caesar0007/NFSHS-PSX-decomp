# SNDPSXZ ssysinit canonical sound options (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/sndpsxz/ssysinit.c` previously used the synthetic
`SndOptsBlock15` and packed `SndOptsBlock` tags to force 60-byte and 44-byte
aggregate copies. Retail SYM repeatedly retains the public sound graph in
game owners: `SNDSYSCAP` is 12 bytes, `SNDSYSSET` is 44 bytes, `SNDSYSVEC` is
4 bytes, and `SNDSYSOPTS` is their exact 60-byte `cap`/`set`/`vec`
composition. Every field name, leaf type, offset, and array bound also agrees
with the canonical graph already reconstructed in `recon/nfs4_types.h`.

The synthetic copy tags were replaced with those four canonical public types.
`SNDSYS_getopts` and `SNDSYS_setopts` now take `SNDSYSOPTS *`; structure
assignment uses the real `set` and `vec` fields; and `SNDSYS_init` names
`maxbanks` and `inputvoices` rather than indexing integer/byte slices. All four
functions remain byte-exact.

SSYSINIT.OBJ is a stripped library owner and therefore retains no local type
rows. The audit filters these public definitions only when the complete four
tag/typedef pairs match their exact cross-owner retail SYM layouts in this
owner. Any name, member, type, offset, dimension, size, typedef, or ownership
drift remains a failure. The pre-change source/tool backup is Git commit
`b48a475f`.

The `D_80147898` spelling remains only as the exact linker alias for
`sndgs + 0x38`, the storage occupied by `SNDSYSOPTS::vec`. A direct typed
destination assignment was tested and lost `SNDSYS_setopts` PASS, while the
alias store preserves the retail jal-delay-slot schedule.

## Matching and SYM proof

- `ssysinit.c`: 4/4 PASS;
- focused `ssysinit_type_graph_p342_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p343_20260829.tsv`: 378 OK / 39 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p341, exactly `ssysinit.c` changed `DIFF -> OK`; all other
  status rows are unchanged.

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
`2.8.1-norcse` rung, unrelated to this owner.
