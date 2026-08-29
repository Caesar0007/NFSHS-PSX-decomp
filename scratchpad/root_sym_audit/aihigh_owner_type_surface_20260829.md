# `aihigh.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `997ff63f`.

## Source graph restoration

`aihigh_types.h` now composes the exact 108-definition shared AI hierarchy and
adds only the three definitions retained by this owner:

- `AIHigh_CopGameType_t`;
- `AIState_None`;
- `AIHigh_None`.

AIHIGH.CPP placement-constructs seven foreign derived classes. Their canonical
names, inheritance, extents, members, and constructor surfaces are retained so
that generated member symbols remain correct, while the canonical audit
pair-locks those completed foreign definitions because the linked owner graph
omits their tags. `GameSetup_gData` similarly uses a private member-shaped view.

The GameSetup carrier must retain the canonical 2600-byte aggregate extent.
A one-member, four-byte truncation changed GCC's first address allocation in
`AIHigh_StartUp` and produced four instruction diffs; restoring the full extent
returned the function immediately to PASS. The retained 2600-byte view therefore
records measured compiler evidence, not decorative padding.

## SYM and matching proof

Focused board `aihigh_type_graph_p371_20260829.tsv`:

- named definitions: 111/111 exact;
- anonymous definitions: 7/7 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report `14/14 PASS`
for `recon/game/common/aihigh.cpp`.

Full board `sym_type_graph_board_p372_20260829.tsv` reports 396 `OK`, 21
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p370, exactly `aihigh.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 990 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
