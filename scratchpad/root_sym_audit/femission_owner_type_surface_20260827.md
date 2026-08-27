# `FEMission.obj` owner type-surface receipt

Date: 2026-08-27

Retail owner: `FEMission.obj`

Source TU: `recon/frontend/common/femission.cpp`

The TU now includes `femission_types.h` instead of the project-wide
`nfs4_types.h`.  Its visible graph is the exact frontend/core graph shared
with FETracks.obj and FEInput.obj, plus only the five mission records present
in the retail owner.  `byte` and `uint` remain source macros because
`FEMission.obj` contains no typedef records for those spellings.

Strict compiler-emitted comparison:

- named records: 56/56 exact
- anonymous records: 2/2 exact
- source-only named records: 0
- source-only anonymous records: 0
- source-only typedef semantics: 0
- result: `OK`

The uncovered typedef count consists only of duplicate retail debug records
for already-covered semantics.  Repeating those records in C++ source would
require illegal duplicate definitions and is therefore retained as evidence,
not treated as a source gap.

Verification:

- two successive `python tools/tugate.py recon/frontend/common/femission.cpp`
  runs: 5/5 PASS
- `Initialize`: PASS, 7 instructions
- `LoadDescription`: PASS, 79 instructions
- `ReleaseDescription`: PASS, 15 instructions
- `GetMissionStages`: PASS, 26 instructions
- `GetMissionToRace`: PASS, 17 instructions
- full frontend/common type sweep: 7 exact owners, 34 remaining visibility
  residuals
- strict declaration/global audit: 779/779 mapped definitions clean and
  190/190 object-owned globals mapped, with zero missing/extra/type/storage
  findings
- `python tools/relink.py --lane both`: GREEN, zero real duplicates, hidden
  phantoms, or relocation-referenced unresolved symbols
- recon/src undefined-call audits: zero
- TU-order audit: zero inversions
- unsafe-vtable-indexing audit: zero
- call-target audit: zero proven wrong targets
- source-only text-move audit: PASS

