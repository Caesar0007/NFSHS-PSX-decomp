# `fefades.obj` owner type-surface receipt

Date: 2026-08-24

Retail owner: `fefades.obj`

Source TU: `recon/frontend/common/fefades.cpp`

The TU now includes `fefades_types.h` instead of the project-wide
`nfs4_types.h`.  Its visible source graph is limited to the exact retail
dependencies recovered from SYM: the PsyQ/drawing leaf types,
`tTexture_ShapeInfo`, `kernpair`/`KERN`, `tMenuTextType`, and the five font
callback typedefs.  `byte` remains a source macro because the owner has no
retail typedef record for that spelling.

Strict compiler-emitted comparison:

- named records: 35/35 exact
- anonymous records: 2/2 exact
- unique typedef semantics: 81/81 covered
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- retail duplicate typedef rows: 8
- result: `OK`

Verification:

- `python tools/tugate.py recon/frontend/common/fefades.cpp`: 6/6 PASS
- `python tools/bulkverify.py recon/frontend/common`: 836/838 byte-matches,
  one two-instruction relocation near miss, one constructor residual
- `python tools/relink.py --lane both`: GREEN, zero real duplicates, hidden
  phantoms, or relocation-referenced unresolved symbols
- `python tools/audit_vtable_indexing.py`: PASS in 927 files
