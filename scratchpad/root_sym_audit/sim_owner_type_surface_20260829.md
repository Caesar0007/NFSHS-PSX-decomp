# `sim.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `d979cd2f`.

## Source graph restoration

`sim_types.h` now composes the exact 106-definition overlap with the shared
AI hierarchy graph, omitting only the two AIPhysic records absent from
`sim.obj`. It restores Sim's fourteen owner-visible definitions, including
`Sim_tSimGlobalVar`, `Sim_tSimSystemVar`, the PsyQ runtime records, render and
track records, skidmark records, `AudioMus_tSongEntry`, `BW_tContext`, and
`forceFocus_t`. The broad `nfs4_types.h` and `libfns.h` dependencies are no
longer part of this translation unit or its public/extern boundary.

The completed `GameSetup_tData`, `tReplayInterface`, and `Clock_tGameClock`
tags are absent from Sim's linked SYM graph even though retail dereferences
their storage. Three private compiler-boundary views retain the exact consumed
layouts. The canonical audit accepts each view only when its owner header,
private name, size, members, offsets, and implicit C++ typedef pair match the
recorded fingerprint. EA runtime calls retain C linkage; no post-compiler
rewrite is used.

## SYM and matching proof

Focused board `sim_type_graph_p404_20260829.tsv`:

- named definitions: 120/120 exact;
- anonymous definitions: 7/7 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 8/8 PASS
for `recon/game/common/sim.cpp`, spanning 32 through 321 instructions per
function. This includes `Sim_ProcessSimSchedules` (201) and
`Sim_MainGameLoop` (321). The shared hierarchy neighbor `aih_hum.cpp` remains
2/2 PASS in both lanes and retains its exact 109/109 named plus 7/7 anonymous
owner graph (`aih_hum_neighbor_type_graph_p405_20260829.tsv`).

Full board `sym_type_graph_board_p406_20260829.tsv` reports 409 `OK`, 8
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Sim moved from `DIFF` to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 1,003 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- intended-compiler phantom census: 513/513 TUs available, 3,484/3,484 oracle
  names exact, zero hidden phantoms, and zero ownership gaps.
