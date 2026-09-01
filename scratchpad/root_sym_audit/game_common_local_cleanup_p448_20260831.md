# Game/common SYM-local cleanup (P448)

## Result

- `recon/game/common` remains 1193/1193 function-mapped.
- Declaration-clean functions improved from 569 to 584.
- Generic extra-source-local findings fell from 2068 to 2053.
- Missing SYM locals, type findings, and function storage findings remain zero.
- Object globals remain 547/547 and vtables 115/115, with no missing/extra
  global definitions.

## Exact source restorations

The following changes use the SYM names directly and remain byte-exact:

- `AI_ClearLaneMerits`: used `o` as the loop counter.
- `AI_SetupOncomingLaneDemerits`: used `opposingLaneMerit` for the computed value.
- `AI_CalcBestLineMerits`: used `latPos` for the lane position.
- `AI_AvoidSpikeBelt`: removed the result-only temporary by using the calls in
  their conditions.
- `AI_SubmitObstacle`: removed `edgeIndex` and used the lane-index expressions.
- `AI_CheckPreferredLateralPosition`: removed an unused result declaration.
- `AI_ChooseNewLaneSlack`: restored a no-local expression shape that GCC CSEs
  while preserving the retail load/store schedule.
- `AIDelayCar::SetNewTargetCar`: assigned the call result directly.
- `AIInit_InitAICar2`: used returned values directly.
- `AIInit_IsNonStandardCarFile`: restored the conditional return with only the
  SYM-recorded `nonStandardList` local.
- `AILife_RCPickDesiredLatPosition`: assigned the final field without the
  decompiler-only `finalLatPos`.

## Measured compiler carriers

These source-only names are not asserted as lost retail debug locals.  Natural
removal was tested and rejected against the instruction oracle:

- `AI_TryToShareLanes::laneWidth`: reusing `gapLeft` causes 64 diffs.
- `AILife_PlaceCarAtLocation::direction`: direct field use causes 3 diffs and
  adds a load-delay nop (130 vs 129 instructions).
- `AILife_ReencarnateTraffic::colorIdx`: inlining causes 29 diffs and produces
  43 vs 44 instructions.
- `AILife_ReencarnateTrafficByPosition::colorIdx`: inlining causes 30 diffs at
  the same 131-instruction length.

Each carrier has an inline `SYM-CODEGEN-CARRIER` receipt so it is separated
from unresolved SYM review work.

## Gates

- `ai.cpp`: 40/40 PASS.
- `aidelaycar.cpp`: 3/3 PASS.
- `aiinit.cpp`: 17/17 PASS.
- `ailife.cpp`: 20/20 PASS.
- Relink both lanes: GREEN; real duplicates 0, hidden phantoms 0, unresolved
  call relocations 0.

Detailed declaration ledger: `game_common_strict_p448_20260831.md`.
