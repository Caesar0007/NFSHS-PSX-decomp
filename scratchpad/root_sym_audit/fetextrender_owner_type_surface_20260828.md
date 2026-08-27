# `FETextRender.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FETextRender.obj`

Source TU: `recon/frontend/common/fetextrender.cpp`

The retail graph is the shared exact frontend/color core without its unrelated
car-manager tail, plus the text enums and the screen/dialog/application records
used by this owner.  `fetextrender_types.h` exposes only that graph.  The
existing seventeen function bodies and the guide-approved linkage alias are
unchanged.

Strict compiler-emitted comparison:

- named records: 93/93 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive
  `python tools/tugate.py recon/frontend/common/fetextrender.cpp` runs:
  17/17 PASS
- focused graph: `fetextrender_type_graph_p266_20260828.tsv`
- full frontend/common sweep: 16 exact owners, 25 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
