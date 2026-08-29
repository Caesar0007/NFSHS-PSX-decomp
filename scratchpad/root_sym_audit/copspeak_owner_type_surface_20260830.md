# `CopSpeak.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source/tool backup: Git commit `0d60e074`.

## Source graph restoration

`copspeak_types.h` now composes CopSpeak's exact source-visible type graph from
the verified Audiocmn/AudioClc surface plus its twenty-one owner-specific
definitions. Narrow conditional guards remove only records absent from
`CopSpeak.obj`; the default Audiocmn and AudioClc owner surfaces are unchanged.

CopSpeak now uses a narrow C-linkage runtime boundary instead of importing the
whole-game `nfs4_types.h` and `libfns.h` surfaces. An exact private 12-byte
sound-bank view preserves the foreign `SndBnk_t` storage used by matched code.
An exact private 864-byte Speech carrier restores the three retained anonymous
bank aggregates while correctly omitting Speech's completed outer tag. The
canonical audit pair-locks those two private views while leaving the three
anonymous children visible to the owner comparison. No post-compiler rewrite
is used.

## SYM and matching proof

Focused board `copspeak_type_graph_p414_20260830.tsv`:

- named definitions: 124/124 exact;
- anonymous definitions: 5/5 exact;
- missing typedef semantics: 0;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 27 CopSpeak functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`. The two guarded shared owners also remain byte exact in
both lanes: Audiocmn is 48/48 PASS and AudioClc is 18/18 PASS. Their neighbor
graphs remain `OK` at 111/111 named plus 2/2 anonymous and 93/93 named plus 2/2
anonymous, respectively (`audiocmn_type_graph_neighbor_p414_20260830.tsv` and
`audioclc_type_graph_neighbor_p414_20260830.tsv`).

Full board `sym_type_graph_board_p414_20260830.tsv` reports 414 `OK`, 3
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
CopSpeak moved from `DIFF` to `OK`; no owner regressed. The remaining
authoritative game-owner deltas are `cars.cpp`, `nfs3.cpp`, and `speech.cpp`.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audits: 0 in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong-target sites;
- TU order audit: 513 objects, 0 inversions;
- vtable indexing audit: 1008 files, PASS;
- text-move audit: PASS;
- phantom audit: 513/513 TUs compiled, 3,484/3,484 exact, zero hidden or
  ownership gaps;
- phantom census: zero `__Fe` bases.
