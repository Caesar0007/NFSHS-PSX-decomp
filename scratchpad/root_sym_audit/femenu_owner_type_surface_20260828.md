# `FEMenu.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FEMenu.obj`

Source TU: `recon/frontend/common/femenu.cpp`

`femenu_types.h` exposes the shared frontend/color graph plus only FEMenu's
input, iterator, menu-item, screen/dialog, and `POLY_F4` records.  The shared
core's full member declarations are opt-in under
`NFS4_FE_CORE_FEMENU_METHODS`, so previously exact consumers remain unchanged.

The former invented `tFEMenuPrimTag` has been replaced with the canonical
PsyQ 4.3 `P_TAG` and `addPrim` macro expansion.  The linked game SYM omits this
SDK-owned anonymous record.  The canonical audit therefore suppresses it only
when the exact 8-byte anonymous struct, all bit widths and members, the matching
`P_TAG` typedef, and the `femenu_types.h` origin agree.  The audit tool's
pre-change backup is pushed commit `3762862e`.

Strict compiler-emitted comparison:

- named records: 107/107 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/femenu.cpp`
  runs: 73/73 PASS
- focused graph: `femenu_type_graph_p268_20260828.tsv`
- full frontend/common sweep: 18 exact owners, 23 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
