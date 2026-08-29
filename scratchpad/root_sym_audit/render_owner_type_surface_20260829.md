# `render.obj` owner type-surface receipt

Date: 2026-08-29

Pre-change source/tool backup: Git commit `88b7d527`.

## Source graph restoration

`render_types.h` now composes the exact 90-definition overlap with
`night.obj` and restores render's ten-definition delta: `AudioMus_tSongEntry`,
`BW_tContext`, `DR_STP`, `FLARE_PIECE_DEF`, `kernpair`, `POLY_F4`,
`POLY_FT4`, `SceneElem`, `SceneSortedElem`, and `tTexture_ShapeInfo`. Their
names, sizes, bitfields, arrays, nested tags, and member offsets reproduce the
retail SYM records. `night_types.h` exposes its two owner-private records only
to night by default; a narrow include switch omits them for render, and the
focused night regression proves its original 92-definition surface unchanged.

`gEnviro` and `gFlare_LensFlare` are dereferenced although their completed
tags are absent from `render.obj`. Exact private views retain their complete
known retail layouts. `Render_PTag` and local `StampTag` express the canonical
PsyQ packet-link macro shapes required by the PASS bodies. The audit accepts
all four carriers only when their owner, private name, size, members,
bitfields, offsets, and typedef pair match exactly.

The broad monolithic `nfs4_types.h` and `libfns.h` dependencies were replaced
with the exact owner surface and six PsyQ runtime declarations. One null
callback cast now spells its function-pointer type directly instead of using
the non-retail `fn_void` helper typedef; this is semantically and
instruction-identical.

## SYM and matching proof

Focused board `render_type_graph_p389_20260829.tsv`:

- named definitions: 100/100 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

The focused shared-header regression reports `night.cpp` at 92/92 named and
2/2 anonymous definitions. Both the normal gate and explicit
`NFS4_SOURCE_ONLY=1` gate report 23/23 PASS for
`recon/game/common/render.cpp`, spanning 2 through 120 instructions per
function.

Full board `sym_type_graph_board_p390_20260829.tsv` reports 405 `OK`, 12
`DIFF`, 30 known debug-compile failures, and 11 unresolved owner mappings.
Compared with p388, exactly `render.cpp` moved from `DIFF` to `OK`; no owner
regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audit: zero in both lanes (15,782 recon and 15,779 source
  call relocations scanned);
- call-target audit: 0/460 proven wrong targets;
- TU order: 513 objects, zero inversions;
- vtable indexing: 999 files, zero unsafe row-index sites;
- no post-compiler text moves or branch retargets;
- full intended-compiler phantom rebuild: 513/513 TUs compiled, 3,484/3,484
  oracle names exact, zero hidden phantoms, and zero ownership gaps.
