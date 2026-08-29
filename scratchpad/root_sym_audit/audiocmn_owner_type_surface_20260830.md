# `audiocmn.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source/tool backup: Git commit `d9c3fa21`.

## Source graph restoration

`audiocmn_types.h` now composes the exact 89-definition overlap with the
verified `audioclc.obj` graph and restores Audiocmn's twenty-two owner-specific
definitions. The shared AudioClc graph excludes only its four owner-only
records, its integer `s_type` ABI alias, and an unrelated input callback while
Audiocmn is being compiled; every default AudioClc declaration is unchanged.

Audiocmn now uses a narrow C-linkage runtime boundary instead of importing the
whole-game `nfs4_types.h` and `libfns.h` surfaces. Exact private full-layout
views preserve the foreign `GameSetup_tData`, `camera_info`,
`Sim_tSimGlobalVar`, and `tReplayInterface` storage used by retail code. The
canonical audit locks the two new Sim/Replay views and the repeated local
GameSetup typedef. The linked `tSaveRecords` typedef remains public while its
exact 20-byte foreign `tRecordBuffer` carrier is pair-locked. No post-compiler
rewrite is used.

## SYM and matching proof

Focused board `audiocmn_type_graph_p413_20260830.tsv`:

- named definitions: 111/111 exact;
- anonymous definitions: 2/2 exact;
- missing typedef semantics: 0;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 48 Audiocmn functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`, spanning 4 through 530 instructions. The guarded shared
owner `audioclc.cpp` remains 18/18 PASS in both lanes and retains its exact
93/93 named plus 2/2 anonymous graph
(`audioclc_type_graph_neighbor_p413_20260830.tsv`).

Full board `sym_type_graph_board_p413_20260830.tsv` reports 413 `OK`, 4
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
Audiocmn moved from `DIFF` to `OK`; no owner regressed.

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
