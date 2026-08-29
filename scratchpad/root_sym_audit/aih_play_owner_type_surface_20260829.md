# `aih_play.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `5d5c7937`.

## Source graph restoration

`aih_play_types.h` now composes the exact shared AI hierarchy and restores the
owner's 20-definition delta.  Nineteen definitions are shared with
`aih_basicperp.obj`; `AITrigger_TriggerManager` is the sole additional named
definition retained by `aih_play.obj`.  The three Speech bank aggregates and
seven exact function typedefs are retained with their original semantics.

Five referenced foreign globals have private member-shaped views because their
completed owning tags are absent from the linked owner graph.  Their complete
extents, members, offsets, bounds, and leaf tags are pair-locked by the
canonical audit.  These include the proven 2600-byte `GameSetup` extent and
the canonical `mirrorTrack` +44 / `reverseTrack` +48 sequence.

`AITrigger_TriggerManager::CheckForClosestTriggerOfType` requires the enum
parameter name in its retail C++ symbol.  The linked owner omits the completed
header enum, so the exact seven-value `triggerType` tag and its two compiler-
emitted typedef rows are treated atomically as a compiler-boundary carrier.
Any name, value, size, owner, tag, or typedef drift remains visible.

## SYM and matching proof

Focused board `aih_play_type_graph_p376_20260829.tsv`:

- named definitions: 128/128 exact;
- anonymous definitions: 10/10 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report 10/10 PASS
for `recon/game/common/aih_play.cpp`.  This includes the 674-instruction
`AIHigh_Player::SetupBlockade` and 307-instruction
`AIHigh_Player::HandlePullOver` bodies.

Full board `sym_type_graph_board_p376_20260829.tsv` reports 398 `OK`, 19
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p375, exactly `aih_play.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 992 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
