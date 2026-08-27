# FEApp.obj owner-type restoration receipt

## Result

- `recon/frontend/common/feapp.cpp`: 15/15 authoritative functions PASS.
- `FEApp.obj`: 171/171 named type keys exact, 2/2 anonymous records covered,
  with zero missing, mismatched, or source-extra named/anonymous records.
- The final retail call-target audit proves both `Redraw__14tFEApplication`
  calls resolve to `ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand`;
  zero wrong-call-target sites remain project-wide.
- Neighbor regressions: `ScreenMemcard.obj` remains 15/15 PASS and graph-exact;
  `FEDialog.obj` remains 33/33 PASS and graph-exact.

## Source-shape evidence

`ScreenMemcard.obj` was the nearest exact graph, sharing 160 named records with
`FEApp.obj`.  The owner header retains that common surface while replacing the
11 owner-specific records.  `tMenuCommand` is declared before the shared graph
so its `tMenu *` referent remains opaque at the retail emission point.  The
three foreign singleton aggregates used by FEApp are represented by exact-size,
exact-offset views, and the audit accepts those views only when their complete
tag/typedef pairs and source origins match.  The primitive packet carriers are
similarly pair-locked rather than generically ignored.

## Full-scope validation

- Frontend/common owner-type board: 30 exact, 11 residual owners.
- Strict declaration audit: 779/779 reconstructed definitions declaration-clean;
  190/190 object-owned globals mapped; zero missing/extra names, type findings,
  storage findings, or mapping-review findings.
- Full phantom audit: 513/513 reconstruction TUs compiled, 3484/3484 declared
  oracle names exact, zero hidden phantoms, zero unmatched ownership gaps.
- Relink gate: both lanes green, zero real duplicates, zero hidden phantoms,
  zero relocation-referenced unresolved symbols.
- Undefined-call audit: zero undefined calls in both reconstruction and source
  lanes.
- TU-order audit: 513 objects, zero inversions.
- Vtable-index audit: zero unsafe row indexing in 969 files.
- Text-move policy: source-only, with no post-compiler text moves or branch
  retargets.
- Call-target audit: zero proven wrong-target calls.

The compiler ladder continues to emit the known warning that the optional
`2.8.1-norcse` rung is unavailable; no validated owner in this checkpoint
depends on that optional rung.
