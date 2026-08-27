# `ScreenCongrats.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenCongrats.obj`

Source TU: `recon/frontend/common/screencongrats.cpp`

`screencongrats_types.h` composes the exact shared FEDialog/ScreenCarSelect
frontend graph and restores ScreenCongrats's nine owner additions:
`tMenuCommand`, `tTrophyClass`, `tSmallSpinningThing`,
`tScreenCongratsMessage`, and the five ScreenCongrats class records.  The
ScreenCarSelect-only song, draw-area, car-stat/state, duel, pink-slips, and
foreign singleton-view records are suppressed at this owner boundary.

The retail `tMenuCommand` record describes `nextMenu` as an opaque `tMenu *`
even though the same owner later emits the complete `tMenu` body.  Declaring
`tMenuCommand` before the shared menu graph reproduces that debug-emission
order exactly: eight bytes, enum `type` at offset zero, and opaque `nextMenu`
at offset four.  `tTrophySize`, `tMenuTextState`, and `tMenuTextType` remain
source constants/ABI spellings because ScreenCongrats.obj retains none of
their completed enum records.  Exact GCC-v2 asm labels on the external text
and trophy APIs preserve their retail symbols without inventing foreign types.

Strict compiler-emitted comparison:

- named records: 181/181 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- repeated `python tools/tugate.py recon/frontend/common/screencongrats.cpp`
  runs after the full rebuild: 28/28 PASS
- exact shared-header neighbors: ScreenCarSelect 59/59 PASS and FEDialog
  33/33 PASS; focused canonical graphs remain `OK`
- focused graph: `screencongrats_type_graph_p279_20260828.tsv`
- full frontend/common sweep: 29 exact owners, 12 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing names, extras, type findings,
  storage findings, or mapping-review entries
- full phantom rebuild: 513/513 TUs compiled, 3,484 exact-matched symbols,
  zero hidden phantoms, and zero unmatched ownership/missing gaps
- both relink lanes and all undefcall, TU-order, vtable, text-move, and
  call-target gates are green
- the known missing optional `2.8.1-norcse` ladder rung warning remains; this
  does not affect ScreenCongrats or the zero-phantom/ownership result
