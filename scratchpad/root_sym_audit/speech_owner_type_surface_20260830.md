# `Speech.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source backup: Git commit `c083e86f`.

## Source graph restoration

`speech_types.h` now composes Speech's exact source-visible graph from the
verified AudioClc surface plus its twenty-seven owner-specific definitions.
Conditional guards remove only AudioClc records absent from `Speech.obj`; the
default AudioClc owner surface is unchanged. The restored Speech definitions
retain the old-GCC class declarations, inline array-element constructors,
three anonymous bank aggregates, and genuine eight-byte vtable-entry ABI.

Speech now uses a narrow C-linkage runtime boundary instead of importing the
whole-game `nfs4_types.h` and `libfns.h` surfaces. The foreign
`GameSetup_tData` storage continues through the already-proven private
AudioClc layout view. No post-compiler rewrite is used.

The source-only `SpeechLocationWord` helper tag was removed from
`Speaker::FindLocation`. Its required aggregate copy from address 8 now uses
the existing retail `SPCHNFSType_POSITION` record, preserving the null-address
load and the function's exact 190-instruction output without adding a debug
type absent from SYM.

## SYM and matching proof

Focused board `speech_type_graph_p415_20260830.tsv`:

- named definitions: 112/112 exact;
- anonymous definitions: 5/5 exact;
- missing typedef semantics: 0;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 102 Speech functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`. The guarded shared owner `audioclc.cpp` remains 18/18
PASS in both lanes and retains its exact 93/93 named plus 2/2 anonymous graph
(`audioclc_type_graph_neighbor_p415_20260830.tsv`).

Full board `sym_type_graph_board_p415_20260830.tsv` reports 415 `OK`, 2
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
Speech moved from `DIFF` to `OK`; no owner regressed. The only remaining
authoritative game-owner deltas are `cars.cpp` and `nfs3.cpp`.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audits: 0 in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong-target sites;
- TU order audit: 513 objects, 0 inversions;
- vtable indexing audit: 1009 files, PASS;
- text-move audit: PASS;
- phantom audit: 513/513 TUs compiled, 3,484/3,484 exact, zero hidden or
  ownership gaps;
- phantom census: zero `__Fe` bases.
