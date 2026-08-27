# `FECheats.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FECheats.obj`

Source TU: `recon/frontend/common/fecheats.cpp`

`fecheats_types.h` replaces the monolithic reconstruction header with the
owner's exact compiler-visible graph: the canonical color/physics tail, core
frontend records, input and track/tournament records, dialogs, and the local
`tCheatCode`/`tCheat` declarations.  The car-manager method declaration is an
opt-in member of the unchanged shared 908-byte layout.

Two foreign completions are required by real source expressions but are not
repeated by the linked owner.  Both are strict compiler-carrier pair-locks:

- `tRecordBuffer` must be complete to form retail's retained
  `tSaveRecords[187]` typedef; its exact 20-byte body is shared with the
  already-proven FETourn/Fecntl carriers.
- `tFEApplication` must be complete for the source-level
  `FEApp->MemCardDialog` access; the retained carrier is exactly the 896-byte
  FEApp owner layout, including the `MemCardDialog` member at byte 568.

The canonical audit suppresses either foreign tag only when its exact body,
same-name typedef, and owner-header origin agree.  A one-sided or altered
carrier remains visible as a graph difference.  The audit tool's pre-change
backup is pushed commit `1880cf75`.

Strict compiler-emitted comparison:

- named records: 112/112 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fecheats.cpp`
  runs: 10/10 PASS
- shared-header neighbors: FECars 46/46 PASS; FETourn 35/35 PASS
- focused graph: `fecheats_type_graph_p269_20260828.tsv`
- full frontend/common sweep: 19 exact owners, 22 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
