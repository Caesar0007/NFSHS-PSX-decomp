# `cars.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source/tool backup: Git commit `2d590bb0`.

## Source graph restoration

`cars_types.h` now composes Cars' exact source-visible graph from the verified
CopSpeak/AudioCmn/AudioClc surface plus its owner-specific definitions. Narrow
conditional guards omit only records absent from `cars.obj`; the default
surfaces of all shared owners remain unchanged.

Cars now uses a narrow C-linkage runtime boundary instead of importing the
whole-game `nfs4_types.h` and `libfns.h` surfaces. Two exact private views
retain the foreign `Trk_NewSlice` and `Object_tIMassObjInfo` storage layouts
required by matched code while correctly omitting their completed foreign
tags. The canonical audit pair-locks every field of both views. The completed
`forceFocus_t` enum, `CarLogic_tObservations` array typedef, and completed
`Udff_tHandle` referent semantics are restored at their actual source-visible
points. No post-compiler rewrite is used.

## SYM and matching proof

Focused board `cars_type_graph_p416_20260830.tsv`:

- named definitions: 131/131 exact;
- anonymous definitions: 5/5 exact;
- missing typedef semantics: 0;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 33 Cars functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`. Every guarded shared owner also remains byte exact in
both lanes: CopSpeak is 27/27 PASS, Audiocmn is 48/48 PASS, AudioClc is 18/18
PASS, and Color is 2/2 PASS. Their focused neighbor graphs remain `OK` at
124/124 plus 5/5, 111/111 plus 2/2, 93/93 plus 2/2, and 71/71 plus 2/2,
respectively.

Full board `sym_type_graph_board_p416_20260830.tsv` reports 416 `OK`, 1
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
Cars moved from `DIFF` to `OK`; no owner regressed. The only remaining
authoritative game-owner delta is `nfs3.cpp`.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audits: 0 in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong-target sites;
- TU order audit: 513 objects, 0 inversions;
- vtable indexing audit: 1007 files, PASS;
- text-move audit: PASS;
- phantom audit: 513/513 TUs compiled, 3,484/3,484 exact, zero hidden or
  ownership gaps;
- phantom census: zero `__Fe` bases.
