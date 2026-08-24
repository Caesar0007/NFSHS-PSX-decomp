# `fevideowall.obj` owner type-surface receipt

Date: 2026-08-24

Retail owner: `fevideowall.obj`

Source TU: `recon/frontend/common/fevideowall.cpp`

The TU now includes `fevideowall_types.h` instead of the project-wide
`nfs4_types.h`.  Its visible graph consists only of the exact retail PsyQ and
drawing leaf dependencies plus `tTexture_ShapeInfo`, `tTVState`, `tTVConfig`,
`tVideoWall`, `kernpair`/`KERN`, `tDrawShapeExtended`, and the five font
callback typedefs.

Strict compiler-emitted comparison:

- named records: 38/38 exact
- anonymous records: 2/2 exact
- unique typedef semantics: 115/115 covered
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- retail/source duplicate typedef rows: 41/31
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fevideowall.cpp`
  runs: 12/12 PASS
- full frontend type sweep: 3 exact owners, 38 remaining visibility residuals
- strict declaration audit: zero missing names, type findings, function/global
  storage findings, or global type findings
- `python tools/bulkverify.py recon/frontend/common`: 836/838 byte-matches,
  one two-instruction relocation near miss, one constructor residual
- `python tools/relink.py --lane both`: GREEN, zero real duplicates, hidden
  phantoms, or relocation-referenced unresolved symbols
- `python tools/audit_vtable_indexing.py`: PASS in 929 files
