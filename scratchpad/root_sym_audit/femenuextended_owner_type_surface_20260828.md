# `FEMenuExtended.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FEMenuExtended.obj`

Source TU: `recon/frontend/common/femenuextended.cpp`

`femenuextended_types.h` replaces the monolithic reconstruction header with
the owner's exact player/input/menu, extended-menu, dialog/application, and
color/physics/car graph.  Foreign `tMenuTextState` and `tMenuTextType` tags are
not retained by this owner; source-spelling constants use `int`, while exact
linkage aliases preserve every retail GCC-v2 symbol name at cross-TU calls.

The former local `tPsyQPrimTag` reconstruction was removed.  Both ordering-
table insertions now use canonical PsyQ 4.3 `P_TAG`/`addPrim` from
`psyq_prim_macros.h`; the existing SDK-carrier audit requires that header's
exact anonymous layout and typedef pair.

The owner retains the public `tSaveRecords[187]` typedef but attributes the
already-seen `tRecordBuffer` element body elsewhere.  The exact 20-byte body is
therefore accepted only through the existing origin-sensitive pair-lock shared
with FETourn, Fecntl, and FECheats.  The audit tool's pre-change backup is
pushed commit `e409f509`.

Strict compiler-emitted comparison:

- named records: 113/113 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive
  `python tools/tugate.py recon/frontend/common/femenuextended.cpp` runs:
  57/57 PASS
- focused graph: `femenuextended_type_graph_p270_20260828.tsv`
- full frontend/common sweep: 20 exact owners, 21 remaining visibility
  residuals; the type-only Fecntl owner is additionally exact outside this
  objdiff-backed board
- strict declaration/global audit and repository-wide regression gates:
  green
