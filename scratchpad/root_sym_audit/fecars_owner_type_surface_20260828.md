# `FECars.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FECars.obj`

Source TU: `recon/frontend/common/fecars.cpp`

`fecars_types.h` replaces the monolithic project type header with the exact
shared frontend/core, player, and track graphs plus the thirteen records owned
only by FECars.  `fe_track_types.h` separates the FETracks/FECars overlap from
FETracks' two private save/iterator records; `fe_player_types.h` likewise keeps
the foreign input-key enum out of FECars.

FECars requires the common `tCarManager` field layout before declaring the
real owner class with its complete method surface.  The private
`FECars_CoreCarManagerCodegenView` preserves that compiler-boundary layout.
The canonical audit suppresses it only when its complete 908-byte struct and
typedef pair, all nine member rows, offsets, dimensions, leaf tags, and owning
header agree.

The external cheat API's `tCheatCode` tag is absent from FECars.obj.  Its
declaration therefore uses the proven retail linkage name with the identical
integer calling convention, while the source-only `cheat_AllCops` constant
does not invent a foreign enum record.

Strict compiler-emitted comparison:

- named records: 69/69 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fecars.cpp`
  runs: 46/46 PASS
- shared-header neighbors remain PASS: FETracks 15/15, FEInput 4/4,
  FEMission 5/5, FEScreen 27/27
- focused graph: `fecars_type_graph_p259_20260828.tsv`
- full frontend/common sweep: 9 exact owners, 32 remaining visibility residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
