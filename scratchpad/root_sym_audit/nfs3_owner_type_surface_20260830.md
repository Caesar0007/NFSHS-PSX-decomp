# `nfs3.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source/tool backup: Git commit `10cdd025`.

## Source graph restoration

`nfs3_types.h` now composes NFS3's exact source-visible graph from the verified
CopSpeak/AudioCmn/AudioClc surface plus its thirty owner-specific definitions.
Conditional guards expose only the shared `BW_tContext`, `forceFocus_t`, and
input callback semantics retained by `nfs3.obj`; the default shared-owner
surfaces remain unchanged.

The broad `nfs4_types.h` and `libfns.h` imports were replaced with this owner
header and a narrow runtime boundary. The actual frontend manager, tournament,
mission, dialog, credit, record, and lighting types are restored with their
retail layouts. An exact private 28-byte sim-system view preserves access to
the foreign `simVar` storage while correctly omitting its completed owner tag;
the canonical audit pair-locks every field of that carrier.

Speech construction and destruction use their actual ABI functions
`__6Speech` and `___6Speech`, avoiding an invented completed `Speech` tag in
this owner. Calls whose enum types are intentionally absent from the retail
graph bind directly to the existing retail C++ symbols
`FECheat_ActivateBonus__F10tCheatCode` and
`Front_Menu__F21tFront_ProcessingType`. No post-compiler rewrite is used.

## SYM and matching proof

Focused board `nfs3_type_graph_p417_20260830.tsv`:

- named definitions: 148/148 exact;
- anonymous definitions: 5/5 exact;
- missing typedef semantics: 0;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 11 NFS3 functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`. Every affected shared owner remains byte exact in both
lanes: Cars is 33/33 PASS, CopSpeak is 27/27 PASS, Audiocmn is 48/48 PASS,
and AudioClc is 18/18 PASS. Their focused neighbor graphs remain `OK` at
131/131 plus 5/5, 124/124 plus 5/5, 111/111 plus 2/2, and 93/93 plus 2/2,
respectively.

Full board `sym_type_graph_board_p417_20260830.tsv` reports 417 `OK`, zero
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved library-owner
mappings. Every currently auditable mapped owner is now canonical-type exact;
no owner regressed.

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
