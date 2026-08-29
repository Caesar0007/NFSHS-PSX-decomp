# `PauseMenu.obj` owner type-surface receipt

Date: 2026-08-30

Pre-change source/tool backup: Git commit `d8a7b2aa`.

## Source graph restoration

`pausemenu_types.h` now composes the exact 87-definition overlap with the
verified `mpause.obj` graph and restores PauseMenu's fifteen owner-specific
definitions. The shared header excludes only the five MPause-only definitions
when it is consumed by PauseMenu, so the default MPause source graph remains
unchanged. PauseMenu also enables the exact `tPlayer` enum required by its
retail member-function signatures.

Two completed foreign tags are absent from PauseMenu's linked SYM graph even
though retail code reads their storage. Private full-layout views preserve the
exact `GameSetup_tData` and `HudPmx_tShape` storage layouts without injecting
their foreign tag definitions into this owner. The Hud helper declaration has
an explicit retail symbol alias, preserving the original
`Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl` ABI while accepting the exact
private view. The canonical type audit locks both private layouts, the local
`PMenuTag`, and the conditional `tPlayer` enum/typedef pair. No post-compiler
rewrite is used.

## SYM and matching proof

Focused board `pausemenu_type_graph_p412_20260829.tsv`:

- named definitions: 102/102 exact;
- anonymous definitions: 2/2 exact;
- source-only named definitions: 0;
- source-only anonymous definitions: 0;
- source-only typedef semantics: 0;
- result: `OK`.

All 60 PauseMenu functions remain PASS under both the normal gate and explicit
`NFS4_SOURCE_ONLY=1`, spanning 2 through 169 instructions. The guarded shared
owner `mpause.cpp` remains 10/10 PASS in both lanes and retains its exact
92/92 named plus 2/2 anonymous graph
(`mpause_type_graph_neighbor_p412_20260829.tsv`).

Full board `sym_type_graph_board_p412_20260829.tsv` reports 412 `OK`, 5
`DIFF`, 30 known SDK debug-compile failures, and 11 unresolved owner mappings.
PauseMenu moved from `DIFF` to `OK`; no owner regressed.

## Repository integrity

- both relink lanes green; zero real duplicates, hidden phantoms, or
  relocation-referenced unresolved symbols;
- undefined-call audits: 0 in both lanes (15,782 recon and 15,779 source call
  relocations scanned);
- call-target audit: 0/460 proven wrong-target sites;
- TU order audit: 513 objects, 0 inversions;
- vtable indexing audit: 1006 files, PASS;
- text-move audit: PASS;
- phantom audit: 513/513 TUs compiled, 3,484/3,484 exact, zero hidden or
  ownership gaps;
- phantom census: zero `__Fe` bases.
