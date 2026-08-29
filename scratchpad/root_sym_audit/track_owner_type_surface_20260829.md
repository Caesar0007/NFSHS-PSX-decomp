# `Track.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `ee7fa53d`.

## Source graph restoration

`track_types.h` now composes the exact 67-definition overlap with the verified
`chunk.obj` graph, guarded only around five Chunk-only records, and restores
Track's seventeen owner-specific definitions. These include the track file,
material, palette, mip-map, scheduler, world-context, and environment-spec
records plus the real `SaveSurface` class. The broad `nfs4_types.h`,
`libfns.h`, and `new.h` dependencies are no longer part of Track's source,
public, or extern boundary.

Three completed foreign global tags are absent from Track's linked SYM graph
even though retail reads their storage. Private full-layout views preserve the
exact `CTrackSpec`, `GameSetup_tData`, and `Sim_tSimGlobalVar` member shapes.
The block-local `LightTableData` carrier preserves the semantic 256-element
`CVECTOR` copy that produces the retail `movstrsi` allocation. The canonical
audit pair-locks every private name, owner, size, member, offset, and implicit
typedef half. Runtime and shape-library calls retain C linkage; no
post-compiler rewrite is used.

## SYM and matching proof

Focused board `track_type_graph_p411_20260829.tsv`:

- named definitions: 84/84 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 29 Track functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`, spanning 2 through 283 instructions. The guarded shared
owner `chunk.cpp` remains 4/4 PASS in both lanes, including its 329-instruction
`Chunk::InstanceGroup`, and retains its exact 72/72 named plus 2/2 anonymous
graph (`chunk_type_graph_neighbor_p411_20260829.tsv`).

Full board `sym_type_graph_board_p411_20260829.tsv` reports 411 `OK`, 6
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
Track moved from `DIFF` to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,005 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- intended-compiler phantom census: 513/513 TUs available, 3,484/3,484 oracle
  names exact, zero hidden phantoms, and zero ownership gaps.
