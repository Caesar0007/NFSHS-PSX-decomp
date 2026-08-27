# `FETracks.obj` owner type-surface receipt

Date: 2026-08-27

Retail owner: `FETracks.obj`

Source TU: `recon/frontend/common/fetracks.cpp`

`fetracks_types.h` now exposes the exact shared frontend/core graph plus only
the seven records present in this owner: `tTrackClassType`, `tPlayer`,
`tListIteratorIndexed`, `tTrackInformation`, `tSaveTrackInfo`,
`tTrackManager`, and `tListIteratorTrack`.  The `uchar` spelling is a source
macro because FETracks.obj contains no typedef record for it.

Strict compiler-emitted comparison:

- named records: 58/58 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fetracks.cpp`
  runs: 15/15 PASS
- focused graph: `fetracks_type_graph_p257_20260827.tsv`
- full frontend/common sweep: 7 exact owners, 34 remaining visibility residuals
- both relink lanes and all structural/call-target gates: green
