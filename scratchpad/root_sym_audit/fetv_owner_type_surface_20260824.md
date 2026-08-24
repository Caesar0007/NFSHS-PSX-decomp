# `fetv.obj` owner type-surface receipt

Date: 2026-08-24

Retail owner: `fetv.obj`

Source TU: `recon/frontend/common/fetv.cpp`

The TU now includes `fetv_types.h` instead of the project-wide
`nfs4_types.h`.  Its visible graph consists only of the exact retail PsyQ and
drawing leaf dependencies plus `tTexture_ShapeInfo`, `tTVState`, `tTVConfig`,
`kernpair`/`KERN`, `tActiveLine`, `tDrawShapeExtended`, and the five font
callback typedefs.  The source-only packed packet-tag bitfield was removed;
word/byte packet macros express the retail operations without adding a type to
the owner graph.

Strict compiler-emitted comparison:

- named records: 40/40 exact
- anonymous records: 2/2 exact
- unique typedef semantics: 94/94 covered
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- retail/source duplicate typedef rows: 8/11
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fetv.cpp` runs:
  5/5 PASS
- `DrawTVLines`: PASS, 213 instructions
- `python tools/relink.py --lane both`: GREEN, zero real duplicates, hidden
  phantoms, or relocation-referenced unresolved symbols
- `python tools/audit_vtable_indexing.py`: PASS in 930 files

The branch-local `palette` and `paletteTag` names are source-level carriers for
the SDK packet macro expansion.  Removing them changes retail scheduling; the
SYM does not expose macro-lowered compiler temporaries, so they are not treated
as owner-visible type records.
