# SNDPSXZ sbremove private-view cleanup (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/sndpsxz/sbremove.c` belongs to a stripped library owner and
previously emitted two reconstruction-only tags. The PSX oracle, the Sled
Storm PSX body, and the NFS4 PC implementation all agree that each bank-table
entry is a 12-byte byte-offset record. `SNDBankEntry` was therefore removed;
the platform-allocation flag at `+9` and platform pointer at `+4` are now read
directly from an `unsigned char *` entry. All three functions remain PASS.

The 156-byte `sndgs` aggregate was also experimentally flattened to byte
accesses. That spelling preserved behavior but regressed `cSNDbankremove` by
five authoritative instructions. The exact aggregate MEM shape is therefore
load-bearing for retail code generation and remains as the private
`SNDGlobals` carrier. Because the owner has no retained SYM graph, the audit
accepts it only with this exact owner, tag, 156-byte size, nine members, leaf
types, array bounds, and offsets. Any drift remains a failure. The source/tool
pre-change backup is Git commit `1ec26a06`.

## Matching and SYM proof

- `sbremove.c`: 3/3 PASS;
- focused `sbremove_type_graph_p338_20260828.tsv`: OK, zero residual records;
- full `project_type_graph_p339_20260828.tsv`: 376 OK / 41 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p337, exactly `sbremove.c` changed `DIFF -> OK`; all other
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
`2.8.1-norcse` rung, unrelated to this owner.
