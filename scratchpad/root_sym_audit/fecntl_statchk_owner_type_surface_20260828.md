# `Fecntl.obj` / `Statchk.obj` owner type-surface receipt

Date: 2026-08-28

Retail owners: `Fecntl.obj`, `Statchk.obj`

Source TUs: `recon/frontend/common/fecntl.cpp`,
`recon/frontend/common/statchk.cpp`

The retail graph proves that the type-only Fecntl owner is a strict 88-record
subset of Statchk, whose sole named-record addition is `tRecordBuffer`.
`fecntl_types.h` now reconstructs that shared owner surface directly from the
exact `color.obj` graph, shared frontend records, and the retained legacy-menu
records.  `statchk_types.h` adds only its record-buffer body.

Fecntl retains `tSaveRecords[187]` while the linked SYM attributes the element
tag body to an earlier owner.  The canonical audit therefore pair-locks the
exact 20-byte compiler carrier in `fecntl_types.h`, using the same guarded rule
already proven for FETourn.  Statchk disables that carrier and emits its own
real owner record.  Its SYM omits the foreign 2600-byte `GameSetup_tData` body,
so the sole observed field is expressed as the exact word-seven view of
`GameSetup_gData`; all five retail functions remain byte-identical.

Strict compiler-emitted comparison:

- Fecntl: 88/88 named, 2/2 anonymous, zero source-only semantics (`OK`)
- Statchk: 89/89 named, 2/2 anonymous, zero source-only semantics (`OK`)
- Fecntl: 0/0 code/data functions PASS (type-only TU)
- Statchk: 5/5 functions PASS on successive verification runs

Broad verification:

- focused graphs: `fecntl_type_graph_p262_20260828.tsv` and
  `statchk_type_graph_p262_20260828.tsv`
- frontend/common board: 12 exact owners, 29 remaining visibility residuals;
  Fecntl is additionally exact outside the objdiff-backed 41-owner board
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
