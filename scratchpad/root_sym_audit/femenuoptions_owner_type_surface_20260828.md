# FeMenuOptions owner type-surface receipt

Date: 2026-08-28

Owner: `FeMenuOptions.obj`
Source: `recon/frontend/common/femenuoptions.cpp`
Pre-change backup: Git commit `55686f9c`

## Result

- Focused canonical type graph: `OK`.
- Unique named tags: 165/165 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 91/91 PASS.
- The previously unmatched
  `__20tMenuItemSlidingMenuUissssb` constructor now passes byte-exactly.
- Frontend/common board after this owner: 39 exact owners, 2 residual owners.

## Restored owner surface

`femenuoptions_types.h` reuses ScreenController's exact shared frontend graph
and adds only the seven completed records absent from that surface but retained
by FeMenuOptions: `tPlayer`, `tMenuCommand`, `AudioMus_tSongEntry`,
`AudioMus_tSongList`, `DR_AREA`, `POLY_G4`, and the complete 896-byte
`tFEApplication`.

The owner header also restores the non-layout method declarations needed to
compile the 16 option-widget classes from their narrow shared definitions.
Those declarations are enabled only for FeMenuOptions and do not alter the
shared class bodies or neighboring owners.

The linked owner keeps the public `tSaveRecords[187]` typedef while attributing
the already-seen 20-byte element body elsewhere; that compiler-required body is
pair-locked.  Three other exact source-only carriers are pair-locked: the
124-byte audio-object member view, the 10,208-byte FEMenuDefs slice ending at
`menuPlayListMenu`, and the four-byte 24/8-bit `tPsyQPrimTag`.  The inherited
84-byte pad view is likewise accepted only with its exact field layout.

`tMenuTextType` and `tMenuTextState` remain integer source constants because
their completed enum tags are absent from this owner.  Exact retail asm labels
on the three fade-helper declarations preserve their GCC-v2 linkage names and
eliminate otherwise invisible phantom calls.  The private PsyQ `_physadr`
referent remains incomplete on this owner surface.

## Proof gates

- Strict source audit: 779/779 functions and 190/190 globals mapped; zero
  name, local, type, storage, or review findings.
- `femenuoptions.cpp`: 91/91 PASS.
- Shared neighbors: `screencontroller.cpp` 22/22 and
  `screendisplay.cpp` 3/3 PASS.
- Call-target audit: 0 proven wrong targets.
- Relink both lanes: GREEN; 0 real duplicates, hidden phantoms, or unresolved
  relocation references.
- Undefined-call audit: 0 in both lanes.
- TU order: 513 objects, 0 inversions.
- Vtable audit: PASS across 978 source files.
- Source-only text-move policy: PASS.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The generated focused graph is `femenuoptions_type_graph_p289_20260828.tsv`;
the regenerated whole-cluster graph and strict audit are
`frontend_common_type_graph_p289_20260828.tsv` and
`frontend_common_strict_p289_20260828.md`.

The optional `2.8.1-norcse` rung was unavailable during the phantom census, so
affected TUs used their configured compiler fallback; the FeMenuOptions
91/91 result and zero-phantom/zero-gap ownership proof are unaffected.
