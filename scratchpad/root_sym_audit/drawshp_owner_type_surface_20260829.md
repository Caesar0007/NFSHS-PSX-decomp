# `drawshp.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `c3055163`.

## Source graph restoration

`drawshp_types.h` now composes the exact 71-definition shared `color.obj`
surface and restores drawshp's six-definition delta: `LINE_F2`, `POLY_G4`,
`kernpair`, `tActiveLine`, `tTexture_ShapeInfo`, and
`tDrawShapeExtended`. Their names, sizes, bitfields, array extents, nested
tags, and member offsets reproduce the retail SYM records.

The local `DrawShp_PTag` aggregate-copy carrier represents the canonical
PsyQ `addPrim` address/length word without claiming a retail owner record.
The audit pair-locks its anonymous four-byte body and implicit typedef to
`drawshp.cpp`. The linked owner graph retains neither completed
`tMenuTextState` nor `tMenuTextType` enum, so this TU represents their call
arguments as `int` while binding the external declaration to the canonical
retail function symbol. The broad monolithic `nfs4_types.h` and `libfns.h`
dependencies were replaced with the exact owner surface and two runtime
declarations used by this TU. No function statement or data definition was
changed.

## SYM and matching proof

Focused board `drawshp_type_graph_p383_20260829.tsv`:

- named definitions: 77/77 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 4/4 PASS
for `recon/frontend/psx/drawshp.cpp`: 108, 131, 200, and 74 instructions.

Full board `sym_type_graph_board_p384_20260829.tsv` reports 402 `OK`, 15
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p382, exactly `drawshp.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 996 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
