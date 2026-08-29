# EACPSXZ cdfs canonical CD graph (2026-08-29)

## Evidence and restoration

`cdfs.obj` is stripped: retail SYM retains ownership but no private types.
Canonical PsyQ 4.3 `LIBCD.H` proves that `CdlLOC` is an anonymous four-byte
struct typedef with `minute`, `second`, `sector`, and `track` bytes. The source
previously invented a named `struct CdlLOC`; it now uses the exact SDK form.

Two repeated anonymous local layouts are now explicit semantic types:
`CDReadState` is the 16-byte view shared by `CD_Read` and `CdReadyHandler`, and
`CDReadyScratch` is the callback's 312-byte stack record containing three
`CdlLOC` headers, the payload tail, position bytes, and savegp context. The raw
oracle fixes these plus the complete `0x83c`-byte `CD_ctx_t`. It also fixes the
packed one-word `rd_le32_unaligned` carrier that produces the required
unaligned `lwl/lwr` loads.

Only `CdlLOC` has recoverable original spelling. The three private EA type
names and packed carrier tag remain conventional because the owner has no type
records; their layouts, roles, offsets, storage, and behavior are proven. The
audit locks the canonical anonymous `CdlLOC` pair, all three private completed
tag/typedef pairs, and the exact packed carrier. Any drift reopens the failure.
Pre-change backup: Git commit `8f87889d`.

## Proof

- `cdfs.c`: 14/14 PASS before and after;
- focused `cdfs_type_graph_p350_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p351_20260829.tsv`: 382 OK / 35 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- versus p349, exactly `cdfs.c` changed `DIFF -> OK`.

Both relink lanes are GREEN; both undefined-call lanes are zero (15,782 recon
and 15,779 source relocations); wrong targets are 0/460; 513 owners have zero
order inversions; 983 files have no unsafe vtable indexing; source-only policy
is clean. The phantom rebuild compiled 513/513 owners and exact-matched
3484/3484 oracle symbols with zero hidden phantoms or ownership gaps. The sole
warning is the pre-existing unavailable optional `2.8.1-norcse` rung.
