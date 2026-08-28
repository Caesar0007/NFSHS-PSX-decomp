# Canonical PsyQ CDREAD callback types (2026-08-28)

## Evidence and scope

The linked `libcd.lib(CDREAD.obj)` member is stripped and retains no owner type
records in the NFS4 SYM. Its public interface is nevertheless fixed by the
canonical PsyQ 4.3 header at
`C:/Temp/nfs4-clean/psyq43/PSX43/psx/include/libcd.h`:

- `CdlCB` is `void (*)(u_char, u_char *)`;
- `CdlLOC` is the four-byte minute/second/sector/track record;
- `CdRead`, `CdReadCallback`, `CdReadyCallback`, `CdSyncCallback`,
  `CdDataCallback`, and `CdLastPos` have the canonical pointer types.

The callback flow was cross-checked against the retail instructions at
`0x80108AE4..0x80108B0C` and `0x80108BC8..0x80108BE0`, the split M2C bodies in
`C:/Temp/nfs4-psx/nfs4-psx-m2c/functions`, and the reconstructed PsyQ CDREAD
source in Xenogears. Retail passes the result-buffer pointer in `$a1`; the old
local `int (*)(int, int)` reconstruction was therefore only an untyped integer
view, not the SDK source signature.

## Source restoration

`recon/syslib/psx/libcd/cdread.c` now uses:

- canonical `CdlCB`, `CdlLOC *CdLastPos(void)`, and callback API prototypes;
- `CdlCB CD_cbread` instead of an integer global declaration;
- `_read_int(u_char intr, u_char *result)` and a pointer-typed saved result;
- pointer-typed saved sync, ready, data, and result fields in the exact 56-byte
  private `_cdr` carrier.

The offset-named `CdrEnv` fields remain because the stripped member does not
prove original private field names. Their types, offsets, and uses are now
semantically exact, without guessing unavailable names.

## Matching proof

`python tools/tugate.py recon/syslib/psx/libcd/cdread.c` remains:

- `_read_sync`: PASS
- `_read_int`: PASS
- `_read_data_int`: PASS
- `CdRead`: PASS
- `CdReadSync`: PASS
- `_read_issue`: the same three authoritative residuals as before this change

Thus the type restoration introduced no PASS regression and did not alter the
known `_read_issue` residual count.

## SYM graph proof

Because the retail archive member is stripped, the audit accepts only exact,
owner-local carrier graphs:

- complete four-byte `CdlLOC` named-tag/typedef pair;
- complete 56-byte `CdrEnv` named-tag/typedef pair, including all fourteen
  fields, offsets, and pointer leaf types;
- exact standalone `CdlCB`, `u_char`, and `u_long` typedefs.

Any owner, tag, typedef, size, member, offset, or leaf-type drift remains a
failure. The source/tool pre-change backup is Git commit `59233e9b`.

The focused `cdread_type_graph_p334_20260828.tsv` report is `OK` with zero
residual records. The full `project_type_graph_p335_20260828.tsv` sweep reports:

- OK: 374
- DIFF: 43
- COMPILE_FAIL: 30
- OWNER_MAP: 11

Compared row-for-row with p333, exactly `cdread.c` changed `DIFF -> OK`; all
other status/counter rows are unchanged. The COMPILE_FAIL detail strings differ
only in nondeterministic compiler temporary filenames.

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

The rebuild emitted only the pre-existing warning for the unavailable optional
`2.8.1-norcse` compiler rung; affected owners used their configured fallback.
