# `FECredits.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FECredits.obj`

Source TU: `recon/frontend/common/fecredits.cpp`

`fecredits_types.h` exposes the shared frontend/color graph plus only the
credit, screen, dialog, TV, and NFS4-menu records retained by this owner.  The
original nested `MIN`/`MAX` source macros are local to this surface and preserve
all seven matched bodies.

FECredits dereferences the foreign `tScreenMain` singleton.  The compiler must
therefore know its 1,464-byte layout, while the linked SYM attributes that
completed tag to ScreenMain.obj.  The canonical audit suppresses this necessary
carrier only when its struct and typedef are both present, every member and
offset agree, and the carrier originates in `fecredits_types.h` (with only the
compiler's local repeated typedef accepted from `fecredits.cpp`).  The audit
tool's pre-change backup is pushed commit `62fb562f`.

Strict compiler-emitted comparison:

- named records: 105/105 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fecredits.cpp`
  runs: 7/7 PASS
- focused graph: `fecredits_type_graph_p267_20260828.tsv`
- full frontend/common sweep: 17 exact owners, 24 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
