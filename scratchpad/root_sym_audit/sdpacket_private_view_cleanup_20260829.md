# SNDPSXZ sdpacket private-view cleanup (2026-08-29)

## Evidence and source restoration

`recon/eaclib/psx/sndpsxz/sdpacket.c` belongs to a stripped library owner and
previously emitted two reconstruction-only tags. The voice-table access does
not require an aggregate carrier: replacing `SNDPDVoiceTableView::table` with
the direct byte address `sndpd + vt + 0xd8` preserves all thirteen exact
matches, so that synthetic tag was removed.

The packet-pointer view was tested independently. Both a direct
`*(int *)(sndpd + 0x4f8 + p * 4)` load and an indexed
`((int *)(sndpd + 0x4f8))[p]` load preserve behavior but regress
`iSNDpacketpurgeframes` by four authoritative instructions. The split
aggregate MEM shape is therefore load-bearing for retail allocation and
remains as the private `SNDPDPacketPtrView` carrier. Because the owner has no
retained SYM graph, the audit accepts it only with this exact owner, tag,
1276-byte size, two members, leaf types, array bounds, and offsets. Any drift
remains a failure. The source/tool pre-change backup is Git commit
`3c5f9a77`.

## Matching and SYM proof

- `sdpacket.c`: 13/13 PASS;
- focused `sdpacket_type_graph_p340_20260829.tsv`: OK, zero residual records;
- full `project_type_graph_p341_20260829.tsv`: 377 OK / 40 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP;
- compared with p339, exactly `sdpacket.c` changed `DIFF -> OK`; all other
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
