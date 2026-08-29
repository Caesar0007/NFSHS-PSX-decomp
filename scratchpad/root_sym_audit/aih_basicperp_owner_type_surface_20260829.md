# `aih_basicperp.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `12a431a8`.

## Source graph restoration

`aih_basicperp_types.h` now composes the exact shared AI hierarchy and adds
only this owner's 19-definition delta: `forceFocus_t`, `BW_tContext`,
`AIHigh_Cop`, the twelve `SPCHNFSType_*` records, `CarBank`, `LocationBank`,
`CallSignBank`, and `Speaker`.  The three retained anonymous Speech bank
aggregates and seven exact function typedefs are restored as well.

The owner references three foreign globals whose completed source tags are not
retained in its linked debug graph.  Private member-shaped views preserve the
compiler-visible extents and fields without importing unrelated application
definitions.  The canonical audit pair-locks those views by size, member kind,
offset, array bounds, and referenced leaf tag.

## GameSetup layout correction

Oracle instructions and the retail owner graph prove that the canonical
`GameSetup_tData` sequence is `instantReplay` at +40, `mirrorTrack` at +44,
and `reverseTrack` at +48.  Omitting `mirrorTrack` made
`AIHigh_BasicPerp::RemoveCloseCops` load +44 instead of the oracle's +48 and
introduced two instruction diffs.  Restoring `mirrorTrack` returned the owner
to 9/9 PASS.

The same correction was applied to `AIH_Opp_GameSetupCodegenView`: its extent
is now 52 bytes with both fields at their canonical offsets.  `aih_opp.cpp`
remains 6/6 PASS in both verification lanes.  This replaces an accidentally
matching incomplete view with the source-accurate layout without sacrificing
binary identity.

## SYM and matching proof

Focused boards:

- `aih_basicperp_type_graph_p373_20260829.tsv`: 127/127 named definitions,
  10/10 anonymous definitions, zero source-only type semantics, `OK`;
- `aih_opp_type_graph_p374_20260829.tsv`: 110/110 named definitions, 7/7
  anonymous definitions, zero source-only type semantics, `OK`.

Both the normal gate and explicit `NFS4_SOURCE_ONLY=1` gate report:

- `aih_basicperp.cpp`: 9/9 PASS;
- `aih_opp.cpp`: 6/6 PASS.

Full board `sym_type_graph_board_p375_20260829.tsv` reports 397 `OK`, 20
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p372, exactly `aih_basicperp.cpp` moved from `DIFF` to `OK`; no
owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 991 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
