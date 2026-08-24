# `felines.obj` owner type-surface receipt

Date: 2026-08-24

Retail owner: `felines.obj`

Source TU: `recon/frontend/common/felines.cpp`

The TU now includes `felines_types.h` instead of the project-wide
`nfs4_types.h`.  Its source-visible graph is limited to the exact retail
dependencies recovered from SYM: the PsyQ/drawing leaf types,
`tTexture_ShapeInfo`, `kernpair`/`KERN`, and the five font callback typedefs.
The source cast uses `unsigned int` because retail records no `uint` typedef in
this object.

Strict compiler-emitted comparison:

- named records: 34/34 exact
- anonymous records: 2/2 exact
- unique typedef semantics: 80/80 covered
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- retail duplicate typedef rows: 8
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/felines.cpp`
  runs: 2/2 PASS
- `python tools/bulkverify.py recon/frontend/common`: 836/838 byte-matches,
  one two-instruction relocation near miss, one constructor residual
- strict declaration audit: zero missing names, type findings, function/global
  storage findings, or global type findings
- `python tools/relink.py --lane both`: GREEN, zero real duplicates, hidden
  phantoms, or relocation-referenced unresolved symbols
- `python tools/audit_vtable_indexing.py`: PASS in 928 files
