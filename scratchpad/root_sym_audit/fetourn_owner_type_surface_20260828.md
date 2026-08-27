# `FETourn.obj` owner type-surface receipt

Date: 2026-08-28

Retail owner: `FETourn.obj`

Source TU: `recon/frontend/common/fetourn.cpp`

`fetourn_types.h` replaces the monolithic project header with the exact
71-record `color.obj` graph plus the shared frontend/tournament records and
FETourn's owner-only save, trophy, manager, and iterator declarations.
`fe_tournament_types.h` now holds the tournament data records proven identical
between FECars.obj and FETourn.obj.  `fe_core_types.h` reuses the already exact
GameSetup leaf header instead of maintaining duplicate declarations.

FETourn's linked SYM omits the foreign `tPlayer` and `tCheatCode` tags despite
retaining their GCC-v2 names in external linkage.  Integer ABI declarations
with exact linkage aliases preserve those symbols without inventing owner
records.  The two private compiler-boundary views are pair-locked in the
canonical audit: the 908-byte shared car-manager layout, and the 20-byte
`tRecordBuffer` body required by CC1PL to emit the retained
`tSaveRecords[187]` typedef whose tag body is attributed to an earlier owner.

Strict compiler-emitted comparison:

- named records: 102/102 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

Verification:

- two successive `python tools/tugate.py recon/frontend/common/fetourn.cpp`
  runs: 35/35 PASS
- shared-header neighbors remain PASS: FECars 46/46, FETracks 15/15,
  FEInput 4/4, FEMission 5/5, FEScreen 27/27
- focused graph: `fetourn_type_graph_p260_20260828.tsv`
- full frontend/common sweep: 10 exact owners, 31 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions and 190/190
  object-owned globals, with zero missing/extra/type/storage findings
- both relink lanes and all undefcall, TU-order, vtable, text-move, phantom,
  and call-target gates: green
