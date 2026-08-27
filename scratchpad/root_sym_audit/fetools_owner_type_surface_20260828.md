# `Fetools.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `Fetools.obj`

Source TU: `recon/frontend/common/fetools.cpp`

The retail graph proves Fecntl.obj's complete 88 named-record graph is a strict
subset of Fetools.  `fetools_types.h` reuses that owner surface and adds only
the three retained PsyQ/kernel records plus the eight screen/menu records
present in Fetools.  Fetools does not retain Fecntl's public `tSaveRecords`
typedef, so the existing Fecntl record-carrier guard is disabled for this
consumer.

Strict compiler-emitted comparison:

- named records: 99/99 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fetools.cpp`
  runs: 6/6 PASS
- focused graph: `fetools_type_graph_p264_20260828.tsv`
- full frontend/common sweep: 14 exact owners, 27 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
