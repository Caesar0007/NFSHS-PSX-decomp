# `ScreenTrophyInfo.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `ScreenTrophyInfo.obj`

Source TU: `recon/frontend/common/screentrophyinfo.cpp`

`screentrophyinfo_types.h` replaces the monolithic project header with the
exact 71-record `color.obj` graph, the shared frontend/tournament records, and
ScreenTrophyInfo's nine owner-only screen/menu records.  The retail owner does
not retain `tTrophySize`, `tMenuTextState`, or `tMenuTextType`; integer ABI
declarations with exact GCC-v2 linkage aliases preserve the external symbols
without inventing those foreign enum records.

The source-visible `screenTrophyRoom` pointer is retained, but its complete
foreign class is absent from this owner's SYM graph.  Two storage-neutral
inline views on the already-retained `tScreen` record expose the proven
0xd0/0xd4 tail offsets.  This preserves GCC's component-reference allocation
and all retail instructions without emitting a false `tScreenTrophyRoom`
record.

Strict compiler-emitted comparison:

- named records: 108/108 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/screentrophyinfo.cpp`
  runs: 3/3 PASS
- exact neighbors remain PASS: FETourn 35/35, FECars 46/46, FEScreen 27/27,
  FETracks 15/15, FEInput 4/4, FEMission 5/5
- focused graph: `screentrophyinfo_type_graph_p261_20260828.tsv`
- full frontend/common sweep: 11 exact owners, 30 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
