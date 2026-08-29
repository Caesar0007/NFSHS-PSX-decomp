# `replay.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `5a10413c`.

## Source graph restoration

`replay_types.h` now composes the exact 71-definition shared `color.obj`
surface and restores replay's eight-definition delta: `Sched_tSchedule`,
`forceFocus_t`, `Camera_tCamSlot`, `GameSetup_tData`, `tControllerData`,
`tReplayInterface`, `tReplayCameraModes`, and `tReplayBuffer`. Their names,
sizes, bitfields, array extents, nested tags, and member offsets reproduce the
retail SYM records.

Four foreign globals use exact member-shaped compiler-boundary views for the
sim globals, input result, and camera array because replay's linked graph omits
their completed owning tags. The audit pair-locks each view by owner header,
name, size, offsets, fields, and implicit typedef. The two local `PackedBuf`
aggregate-copy carriers are similarly pair-locked to `replay.cpp`; they are
reconstruction devices for the already byte-exact GCC movstrsi expansions,
not claims about source types retained by SYM.

The broad `libfns.h` dependency was replaced with the six exact runtime
declarations used by this TU. No function statement or data definition was
changed.

## SYM and matching proof

Focused board `replay_type_graph_p381_20260829.tsv`:

- named definitions: 79/79 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 16/16 PASS
for `recon/game/common/replay.cpp`. This includes both 200+ instruction
aggregate-copy routines, the 292-instruction interface handler, both camera
selection routines, and every smaller owner function.

Full board `sym_type_graph_board_p382_20260829.tsv` reports 401 `OK`, 16
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p380, exactly `replay.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 995 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
