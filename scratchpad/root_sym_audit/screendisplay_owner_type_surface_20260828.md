# `ScreenDisplay.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenDisplay.obj`

Source TU: `recon/frontend/common/screendisplay.cpp`

`screendisplay_types.h` replaces the monolithic reconstruction header with
the owner's exact core menu/list, track/tournament, options-widget, dialog,
and screen/video graph.  `tDrawShapeExtended` remains deliberately incomplete:
the owner only passes a null pointer to that foreign API and its retail graph
contains no completed `tDrawShapeExtended` tag.

`DrawBackground` dereferences only `tGlobalMenuDefs::menuDisplayOptions`.  The
owning aggregate belongs to `FEMenuDefs.obj`, so the consumer header exposes an
explicit compiler-boundary view with the exact retail access shape: a 10,856-
byte prefix followed by the complete 128-byte `tOptionsMenu` leaf at `0x2a68`.
The canonical audit suppresses this synthetic name only when its entire
10,984-byte tag/typedef pair, member graph, leaf tag, and owner origins match.
The audit tool's pre-change backup is pushed commit `604f472d`.

Strict compiler-emitted comparison:

- named records: 113/113 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive
  `python tools/tugate.py recon/frontend/common/screendisplay.cpp` runs:
  3/3 PASS
- focused graph: `screendisplay_type_graph_p271_20260828.tsv`
- full frontend/common sweep: 21 exact owners, 20 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
