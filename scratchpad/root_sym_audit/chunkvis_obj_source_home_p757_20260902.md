# `chunkvis.obj` source-home audit — P757 (2026-09-02)

## Result

`chunkvis.obj` is a real retail object member and is retained as
`recon/game/common/chunkvis.cpp`. It is metadata-only: the raw SYM object
interval contains no function, SLD span, label, external/static storage
definition, code, or data. The reconstructed translation unit must therefore
remain empty after preprocessing its type environment.

The previous source comment was wrong to claim an inlined-function body or a
four-byte `Chunkvis` symbol at `0x8008B934`. No such symbol exists in the raw
SYM, compact symbol table, MAP, or project address config. `0x8008B934` is the
`nop` return-delay slot of `Chunk_DeInit__Fv`, whose exact retail interval is
`0x8008B930..0x8008B938`.

## Raw evidence

- Opening FILE record: SYM record offset `0x206049`, line 94295, name
  `chunkvis.obj`.
- Closing FILE record: SYM record offset `0x2086D7`, line 94697, name
  `chunkvis.obj`.
- Interior records: 401.
- Record classes: 41 `STRTAG`, 1 `UNTAG`, 204 `MOS`, 4 `MOU`, 13 `FIELD`,
  42 `EOS`, and 96 `TPDEF`.
- Function starts/ends: 0/0.
- SLD records/spans: 0/0.
- `EXT`, `STAT`, or other storage definitions: 0.
- The next object owner is `clock.obj`; its first function is
  `Clock_MasterInterruptHandler__Fv @ 0x8008B938`.

The type records are the compiler's included declaration environment, not
object-owned storage. They include the PsyQ vector/draw types and the shared
EA draw, pad, track, stream, and fixed-point types. The current
`chunkvis.h -> nfs4_types.h` edge supplies that environment, but the exact
original include spelling/order cannot be uniquely recovered from these debug
records alone and remains type-graph provenance work rather than a fabricated
body.

The corrected object census identifies the same formerly hidden class in 11
retail objects: `aispeech`, `chunkvis`, `Ddvfont`, `debug`, `Draw2`, `filedbg`,
`nfs2mem`, `profile`, `Fecntl`, `cache`, and `vsprintf`. All 11 already have
explicit reconstructed translation-unit owners, and all 11 rebuilt objects
have zero `.text`, `.data`, and `.bss` program bytes. The new census therefore
closes their object-presence question while leaving exact include provenance
in the type-graph queue.

## Verification

- `Chunk_DeInit__Fv`: detailed PASS, 2/2 instructions.
- Rebuilt `build/recon/game/common/chunkvis.cpp.o` has zero-length `.text`,
  `.data`, and `.bss` sections and no program symbol.
- The full source build completed and relinked after the comment correction;
  the rebuilt executable retains the branch's pre-existing 1,239,008-byte
  size. No generated instruction or linked byte changed at this site.
- `tools/relink.py --lane both`: GREEN; both lanes have zero real duplicates,
  zero hidden phantoms, and zero relocation-referenced unresolved symbols.
  Receipt: `chunkvis_obj_relink_p757_20260902.json`.
- Regenerated object census: `sym_object_member_census_p758_20260902.md`;
  11 metadata-only type-graph objects are no longer misreported as opaque.

Backups of the corrected comments are retained as
`chunkvis.cpp.pre_p757_backup` and `chunkvis.h.pre_p757_backup` in this audit
directory.
