# SMEMMAN private allocator graph

Date: 2026-08-29

Pre-change source/tool backup: Git commit `0e579de8`.

## Source correction

`recon/eaclib/psx/sndpsxz/smemman.c` previously described the allocator's
+0x0c table as a flat `unsigned short entries[256]`, while its insertion loop
already proved that storage is 128 four-byte `{block,size}` records.

The source now defines a named four-byte `SndMemEnt` with unsigned `blk` and
`sz` halfwords, then embeds `SndMemEnt entries[128]` in the 524-byte
`SNDMemState`. The state count and pool-size fields are also unsigned
halfwords, matching every retail `lhu` consumer. This changes only the debug
type graph; object instructions remain byte-identical.

SMEMMAN.OBJ retains no private type records, so exact private tag spellings
remain unprovable. The audit therefore accepts only the complete recovered
graphs—tag, typedef, size, member names, member types, offsets, nested tag, and
array bound—and documents the naming limit here.

## Evidence

- `python tools/tugate.py recon/eaclib/psx/sndpsxz/smemman.c`: 4/4 PASS.
- Focused type graph `smemman_type_graph_p354_20260829.tsv`: OK.
- Full type graph `project_type_graph_p355_20260829.tsv`: 384 OK / 33 DIFF /
  30 COMPILE_FAIL / 11 OWNER_MAP.
- Compared with p353, SMEMMAN is the only status transition: DIFF -> OK.
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
