# `libcard.lib(INIT.obj)` translation-unit restoration

Date: 2026-08-30

Pre-change source/tool backup: Git commit `279b1f52`.

## Authoritative organization evidence

Canonical PsyQ 4.3
`C:\Temp\nfs4-clean\psyq43\extracted\INDEX.tsv` records one archive member,
`LIBCARD/INIT.obj`, with this exact public-text order and member-relative
offsets:

- `InitCARD` at `0x00`;
- `StartCARD` at `0x6c`;
- `StopCARD` at `0xa4`.

Those offsets agree with the retail NFS4 addresses `0x8010C784`, `0x8010C7F0`,
and `0x8010C828`.  PsyQ 4.3 `libapi.h` independently confirms the source
prototypes `void InitCARD(long)`, `long StartCARD(void)`, and
`long StopCARD(void)`.

The reconstruction had incorrectly split `StartCARD` and `StopCARD` into a
synthetic `CARDINIT.c`.  Their bodies and required declarations now follow
`InitCARD` in `INIT.c`, and the synthetic source file is removed.  The objdiff
compatibility unit for the already split oracle object points at the single
canonical base object; this changes no expected/oracle bytes and performs no
post-compile rewrite.

## Matching proof

The recombined `INIT.c` uses the object's proven GCC 2.7.2 lane.  Detailed
`verify_asm.py` results in both normal and explicit `NFS4_SOURCE_ONLY=1` modes:

- `InitCARD`: PASS, 27 instructions;
- `StartCARD`: PASS, 14 instructions;
- `StopCARD`: PASS, 10 instructions.

Fresh objdiff output retains exactly the three expected rows at 100%.  The
full type board `sym_type_graph_board_p419_20260830.tsv` now covers 457 source
TUs: 151 retained-type `OK`, 302 `SYM_UNTYPED`, two `SOURCE_MERGE`, and two
`OWNER_MAP`.  Both former `SOURCE_SPLIT` findings are gone.  The focused syslib
board is `syslib_type_graph_init_join_p419_20260830.tsv`.

## Repository integrity

- recon relink: green with 751 objects, zero real duplicates, hidden phantoms,
  or relocation-referenced unresolved symbols;
- undefined-call audit: zero across 15,782 call relocations;
- focused libcard call-target audit: zero proven wrong-target sites;
- TU-order audit: 512 objects, zero inversions;
- phantom audit: 512/512 TUs compile, 3,484/3,484 exact oracle names, zero
  hidden phantoms and zero ownership gaps;
- phantom census: zero `__Fe` bases.
