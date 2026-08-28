# ScreenTracks owner type-surface receipt

Date: 2026-08-28

Owner: `ScreenTracks.obj`
Source: `recon/frontend/common/screentracks.cpp`
Pre-change backup: Git commit `edf2befc`

## Result

- Focused canonical type graph: `OK`.
- Named tags: 164/164 exact.
- Anonymous tags: 2/2 covered.
- Authoritative function matching: 10/10 PASS.
- Frontend/common board after this owner: 37 exact owners, 4 residual owners.

## Restored owner surface

`screentracks_types.h` now provides the exact records retained by
`ScreenTracks.obj`: the 40-byte `POLY_FT4`, the complete `VIDEOSTATE` enum, the
56-byte `tVideoWall`, and the 672-byte `tScreenTrackSelect` owner class.  The
source-visible text-state and text-type constants remain integer constants where
the compiler erased their enum identity.

The foreign FEMenuDefs aggregate is represented by a pair-locked 3,988-byte
view: `iteratorTrack` at `0xc88`, `itemTraffic` at `0xf4c`, and
`itemLocalSpeech` at `0xf70`.  The full aggregate tag is correctly absent from
this owner.  `tTrackSelectPrimTag` is restored as the exact named four-byte
24/8-bit compiler carrier rather than an anonymous source record.

The `ProcessInput` and FE text-helper declarations retain their exact retail
linkage labels while presenting the owner-correct source types.  Shared
ScreenPinkSlips and ScreenTournSelect surfaces are guarded so ScreenTracks keeps
only the records attributed to it by the SYM.

## Proof gates

- Strict source audit: 779/779 functions and 190/190 globals mapped; zero
  name, local, type, storage, or review findings.
- `screentracks.cpp`: 10/10 PASS.
- Shared neighbors: `screenpinkslips.cpp` 8/8, `screentournselect.cpp` 9/9,
  and `screenmemcard.cpp` 15/15 PASS.
- Call-target audit: 0 proven wrong targets.
- Relink both lanes: GREEN; 0 real duplicates, hidden phantoms, or unresolved
  relocation references.
- Undefined-call audit: 0 in both lanes.
- TU order: 513 objects, 0 inversions.
- Vtable audit: PASS across 1,434 files.
- Source-only text-move policy: PASS.
- Full phantom audit: 513/513 TUs compiled, 3,484/3,484 exact retail names,
  0 hidden phantoms, and 0 unmatched ownership gaps.

The generated focused graph is
`screentracks_type_graph_p287_20260828.tsv`; the regenerated whole-cluster graph
and strict audit are `frontend_common_type_graph_p287_20260828.tsv` and
`frontend_common_strict_p287_20260828.md`.
