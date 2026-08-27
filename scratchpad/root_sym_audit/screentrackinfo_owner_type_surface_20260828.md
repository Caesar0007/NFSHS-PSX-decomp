# `ScreenTrackInfo.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenTrackInfo.obj`

Source TU: `recon/frontend/common/screentrackinfo.cpp`

`screentrackinfo_types.h` replaces the monolithic reconstruction header with
the owner's exact input/menu, car/track/tournament, options-widget, dialog,
and screen/video graph.  Relative to the proven ScreenDisplay owner graph,
the retail owner adds only `tPlayer`, `tInputKeyType`, `tMenuCommand`, and
`tVideoWall`, and replaces `tScreenDisplay` with the 676-byte
`tScreenTrackInfo`; the restored surface follows that evidence directly.

The retail owner retains no `tMenuTextState` or `tMenuTextType` records, so
those source spellings are storage-neutral `int` macros here.  The two text
render declarations preserve their retail GCC-v2 linkage names explicitly,
without reintroducing either foreign enum tag.  The broad `libfns.h` dependency
was also removed; only the used C-linkage `sprintf` declaration remains.

Strict compiler-emitted comparison:

- named records: 117/117 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive
  `python tools/tugate.py recon/frontend/common/screentrackinfo.cpp` runs:
  5/5 PASS
- focused graph: `screentrackinfo_type_graph_p272_20260828.tsv`
- full frontend/common sweep: 22 exact owners, 19 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
