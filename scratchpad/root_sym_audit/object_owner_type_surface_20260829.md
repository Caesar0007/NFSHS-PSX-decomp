# `object.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `581ad8b6`.

## Source graph restoration

`object_types.h` composes Object's exact 116-definition overlap with the
already verified Sim graph while omitting four Sim-only records. It restores
the 21 Object-owned definitions present only in `object.obj`, including the
five animation classes, `AnimScript`, `AnimDef`, the track instance families,
`Chunk`, render types, Object collision/state records, `tQuat`, and the SYM
alias `Quatern_quat`. The broad `nfs4_types.h`, `libfns.h`, and `new.h`
dependencies are no longer part of Object's translation-unit boundary.

Three completed foreign tags are absent from Object's linked SYM graph even
though retail dereferences their storage. Narrow private views preserve the
exact consumed `Trk_NewSlice`, `Sim_tSimGlobalVar`, and `SaveSurface` member
layouts. The canonical audit accepts these carriers only when their owner,
private name, size, members, offsets, and implicit typedef halves match their
recorded fingerprints. The SaveSurface methods retain the retail C++ linkage
names, runtime calls retain C linkage, and no post-compiler rewrite is used.

## SYM and matching proof

Focused board `object_type_graph_p410_20260829.tsv`:

- named definitions: 137/137 exact;
- anonymous definitions: 7/7 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 37 functions in `recon/game/common/object.cpp` remain PASS under both the
normal gate and explicit `NFS4_SOURCE_ONLY=1`, spanning 2 through 265
instructions per function. The neighboring `sim.cpp` owner remains exact at
120/120 named and 7/7 anonymous definitions
(`sim_type_graph_neighbor_p410_20260829.tsv`).

Full board `sym_type_graph_board_p410_20260829.tsv` reports 410 `OK`, 7
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
Object moved from `DIFF` to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,004 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- intended-compiler phantom census: 513/513 TUs available, 3,484/3,484 oracle
  names exact, zero hidden phantoms, and zero ownership gaps.
