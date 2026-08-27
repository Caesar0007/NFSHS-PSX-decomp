# `FEScreen.obj` owner type-surface receipt

Date: 2026-08-27

Retail owner: `FEScreen.obj`

Source TU: `recon/frontend/common/fescreen.cpp`

`fescreen_types.h` now exposes the exact shared frontend/core and input-enum
graphs plus only the thirteen screen/dialog records present in this owner.
`tMenuCommand` is deliberately emitted before the complete `tMenu` definition,
restoring the retail pointer-to-incomplete-`tMenu` debug record.

FEScreen.obj manipulates the foreign `gEnviro` and `Draw_gView` globals but
retains neither owning aggregate tag.  The two private codegen views preserve
their measured 24-byte and 200-byte layouts.  The canonical audit suppresses
them only when their complete struct/typedef pairs, member graphs, sizes, and
owning `fescreen_externs.h` agree.  The menu-text enum tags are likewise absent
from this owner; the declaration uses their proven linkage name while integer
constants preserve the identical calling convention and byte output.

Strict compiler-emitted comparison:

- named records: 66/66 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fescreen.cpp`
  runs: 27/27 PASS
- shared-header neighbors remain PASS: FEInput 4/4, FETracks 15/15,
  FEMission 5/5
- focused graph: `fescreen_type_graph_p258_20260827.tsv`
- full frontend/common sweep: 8 exact owners, 33 remaining visibility residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all structural/call-target gates: green
