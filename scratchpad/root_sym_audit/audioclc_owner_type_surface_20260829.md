# `audioclc.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `53de1ff6`.

## Source graph restoration

`audioclc_types.h` now composes the exact 71-definition shared `color.obj`
surface and restores audioclc's 22-definition delta: `POLY_GT4`,
`Draw_SubdivStruct`, `Track_tArtresource`, `Track_tMaterial`, `SNDSYSCAP`,
`SNDSYSSET`, `SNDSYSVEC`, `SNDSAMPLEFORMAT`, `Sched_tSchedule`,
`Trk_AnimateInst`, `SceneElem`, `SceneSortedElem`, `TCB`, `EXEC`, `DIRENTRY`,
`Skidmark_Segment`, `Skidmark_Chunk`, `forceFocus_t`, `kernpair`,
`AudioClc_tSource`, `AudioClc_tPlayer`, and `AudioClc_tCLCache`. Their names,
sizes, bitfields, arrays, nested tags, and member offsets reproduce the retail
SYM records. The owner header also restores its exact callback, font, KERN,
input-device, observation-array, and aggregate typedef semantics.

`GameSetup_gData` and `Camera_gInfo` are dereferenced by this owner although
their completed tags are absent from the linked `audioclc.obj` graph. Their
two private compiler-boundary views retain the complete known retail layouts,
including every original member name and offset; the audit accepts them only
when the owner header, private name, size, members, fields, and typedef pair
all match. The completed `s_type` enum is likewise absent here, so its two
external arguments use the underlying `int` representation while explicit
canonical symbol labels preserve the retail C++ ABI names.

The broad monolithic `nfs4_types.h` and `libfns.h` dependencies were replaced
with this exact owner surface and three fixed-math runtime declarations. No
function statement or data definition was changed.

## SYM and matching proof

Focused board `audioclc_type_graph_p387_20260829.tsv`:

- named definitions: 93/93 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 18/18 PASS
for `recon/game/common/audioclc.cpp`, spanning 2 through 461 instructions per
function.

Full board `sym_type_graph_board_p388_20260829.tsv` reports 404 `OK`, 13
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p386, exactly `audioclc.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 998 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
