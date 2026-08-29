# SST canonical stream-type restoration

Date: 2026-08-29

Pre-change source/tool backup: Git commit `82858a01`.

## Source correction

`recon/eaclib/psx/sndpsxz/sst.c` no longer uses the synthetic
`PackedRate`, `Hdr5`, `Prio5`, or `ReqRec` aggregate-copy tags.

- Retained `NFS4.SYM` records prove `SNDSAMPLEFORMAT` is four bytes with
  `samplerate` at +0, `channels` at +2, and `samplerep` at +3.
- Retained `NFS4.SYM` records prove `SNDPLAYOPTS` is twenty bytes and fix all
  thirteen member names, leaf types, and offsets.
- `iSNDpatchtohdr` and `SNDPKTPLAY_start` instruction use proves that SST's
  current/locked twenty-byte copies are `SNDPLAYOPTS`, while its four-byte
  rate copy is `SNDSAMPLEFORMAT`.
- The matching NFS3/NFS4-PC streamer in
  `C:\Temp\nfs4-sound\nfshssnd\stream_impl.c` corroborates the private
  0x2c-byte request record's field roles and layout. The PSX oracle fixes its
  size and offsets. SST.OBJ retains no private type graph, so the exact
  `SndStreamReq` tag spelling remains unprovable; the audit locks the complete
  recovered graph and keeps this naming limit explicit.

The packed attribute on `SNDSAMPLEFORMAT` is source-level ABI information:
without byte alignment GCC cannot emit the retail unaligned-safe aggregate
copy. It is not a post-compile rewrite.

## Matching and audit evidence

- `python tools/tugate.py recon/eaclib/psx/sndpsxz/sst.c`: 16/16 PASS.
- Focused type graph: `sst_type_graph_p352_20260829.tsv`: OK.
- Full type graph: `project_type_graph_p353_20260829.tsv`: 383 OK / 34 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p351, SST is the only status transition: DIFF -> OK.
- Both relink lanes GREEN: zero real duplicates, hidden phantoms, and
  reloc-referenced unresolved symbols.
- Undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned).
- Call-target audit: 0/460 proven wrong targets.
- TU order: 513 objects, zero inversions.
- Vtable indexing: 983 files, zero unsafe row-index sites.
- Text moves: none configured.
- Phantom audit: 513/513 TUs compile; 3,484/3,484 oracle functions exact,
  zero hidden phantoms and zero ownership gaps.
