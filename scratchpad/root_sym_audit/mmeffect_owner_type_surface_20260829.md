# `mmeffect.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source backup: Git commit `369be63f`.

## Source graph restoration

`mmeffect_types.h` now composes the exact 71-definition shared `color.obj`
surface and restores mmeffect's eleven-definition delta: `kernpair`,
`tActiveLine`, `tListIterator`, `tListIteratorRange`, `tMenu`,
`tMenuCommandType`, `tMenuItem`, `tMenuItemInteractive`, `tScreen`,
`tShapeInformation`, and `tTexture_ShapeInfo`. Their names, sizes,
inheritance, bitfields, array extents, nested tags, and member offsets
reproduce the retail SYM records. The owner header also retains the exact
`KERN`, font-callback, and `tItemList` typedef semantics.

The broad monolithic `nfs4_types.h` and `libfns.h` dependencies were replaced
with this owner surface and the two PsyQ runtime declarations used by the TU.
The render cursors remain their canonical fixed scratchpad lvalues. No
function statement or data definition was changed.

## SYM and matching proof

Focused board `mmeffect_type_graph_p385_20260829.tsv`:

- named definitions: 82/82 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report PASS for
`FeDraw_SetABRMode__Fi` (39/39 instructions).

Full board `sym_type_graph_board_p386_20260829.tsv` reports 403 `OK`, 14
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p384, exactly `mmeffect.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 997 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
