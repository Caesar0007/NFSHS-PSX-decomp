# SPKTPLAY canonical packet graph

Date: 2026-08-29

Pre-change source/tool backup: Git commit `206f78eb`.

## Source correction

`recon/eaclib/psx/sndpsxz/spktplay.c` no longer uses the unused `PktCopy6`
type or opaque `PktCopy4`, `PktCopy2`, and `Unal4` arrays.

- The rate-word aggregate is the canonical packed four-byte
  `SNDSAMPLEFORMAT` proven by retained NFS4.SYM records.
- The 24-byte ring entry is a translation-unit `PacketFrame` with `reserved`,
  `size`, and four channel pointers/addresses.
- Purge's two required movstrsi batches use semantic `PacketFramePrefix` and
  `PacketFrameTail` layouts. The split is code-generation significant because
  it references `wrptr` twice and preserves the retail allocno; a single full
  frame assignment is not byte-exact.
- The stale header status now records the authoritative 13/13 PASS result.

SPKTPLAY.OBJ retains no private type graph. The instruction stream fixes all
packet-frame sizes and offsets, while exact private tag spellings remain
unprovable; the audit locks the complete graphs and records that naming limit.

## Evidence

- `python tools/tugate.py recon/eaclib/psx/sndpsxz/spktplay.c`: 13/13 PASS.
- Focused type graph `spktplay_type_graph_p358_20260829.tsv`: OK.
- Full type graph `project_type_graph_p359_20260829.tsv`: 388 OK / 29 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p357, SPKTPLAY is the only status transition: DIFF -> OK.
- Both relink lanes GREEN; zero real duplicates, hidden phantoms, and
  reloc-referenced unresolved symbols.
- Undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned).
- Call-target audit: 0/460 proven wrong targets.
- TU order: 513 objects, zero inversions.
- Vtable indexing: 983 files, zero unsafe row-index sites.
- Text moves: none configured.
- Phantom audit: 513/513 TUs compile; 3,484/3,484 oracle functions exact,
  zero hidden phantoms and zero ownership gaps.
