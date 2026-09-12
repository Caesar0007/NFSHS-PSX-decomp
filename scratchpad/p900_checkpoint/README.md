# P900 AudioTrk source/SYM/SLD checkpoint

2026-09-12, local uncommitted checkpoint on main after b36aebd0.
Production changes this round are confined to audiotrk.cpp plus the source
recovery backlog. Prior P898/P899 aiphysic/audio changes remain intact.
No network operation, commit, push, scheduler, shared-header edit, production
build-tool/flag change, asm/volatile device, or postcompile rewrite occurred.

## Source restoration, without PASS regression

| Function | Native SLD conflicts before -> after (merge/split) | Native scopes/local owners |
|---|---|---|
| AudioTrk_AddCustomObject |1/174 -> **0/0** |**31/31 blocks, 18/18 owners**; 7 reconstruction labels removed |
| AudioTrk_StartUp |0/3 -> **0/0** |4/4 blocks, original scoped i restored |
| AudioTrk_CleanUp |0/9 -> **0/0** |4/4 blocks, original scoped i restored |
| AudioTrk_SoundTrack |22/76 -> **22/16** |25/25 owners and 19-block native projection preserved |
| AudioTrk_Reset |0/0 unchanged |2 i owners and 7 nonempty native blocks preserved |
| AudioTrk_PreLoad |2/5 unchanged |5 recovered owners preserved |

AddCustomObject recovers structured rejection/selection/reclaim/repeat guards,
two scoped for-loops, native local declaration owners and volume if/else.
The final correction restores ambdist as the unshifted named source value;
the shift belongs in the fixedmult arguments on native SLD293, not the
initializer on292. The actual 413 instructions are unchanged. This is source
restoration, not a newly gained code PASS or a relabeled synthetic local.

Lifecycle changes use native i in for initializers, StartUp's single-statement
loop and CleanUp's natural void exit. SoundTrack's randtick/next initializers
are related conditional value expressions; its separate velocity-component
statements remain separate, and branch8007D098 still targets8007D2F8.

## Regression evidence

`regression_receipt.json`, `source_receipts.json` and `checks.json` record:

- **1013/1013 oracle-known symbol instances across45TUs PASS**, including two
  static SPCH helper copies. This is the protected closure, not whole-game
  unique-function coverage or a changed board percentage.
- Complete prior branch diagnostics preserved, including the existing
  Speech SubmitRequest anomaly. It is not falsely counted branch-clean.
- **All518 normal objects literally unchanged** from P899; the regenerated
  linked ELF and map are also literally identical.
- Both relink lanes, vtable indexing, source-policy, strict declaration audits
  and the CI-style objdiff report pass. Full three-build lanes are inherited
  from P897; this CPP-only round does not claim a new full three-build sweep.
- User scratchpad/w85/o2.txt unchanged; existing EOL/status-only files and
  every unrelated user edit preserved. No broad Git staging or cleanup.

Independent actual-path six-function native/raw validation is recorded in
../p900_audio_landed_20260912/combined_verification.json. Per-proposal native
records and frozen paired experiments are in ../p900_audio_addcustom,
../p900_audio_lifecycle and ../p900_soundtrack_sld. `final_receipts.json` ties
that evidence to the actual source, all regression hashes, and current status.

## Remaining work is explicit

- Reset's se remains an unproved source spelling, not an original-name claim.
  Two native zero-width C6A0 blocks remain unrecovered.
- SoundTrack still has22/16 SLD conflicts. Two assembler-side hazard-NOP line
  attributions account for18 merges/3 splits; the compiler already places the
  source notes appropriately. These pairs remain counted. No metric exception,
  marker rewriting or C workaround was introduced. The end selection, se
  address and loop-tail source groups remain open, not confirmed floors.
- SoundTrack's two empty CE40 blocks and original P898 cast spelling, plus
  PreLoad's implicit CAudioList this/accessor and two D410 blocks, are unproved.
  No helper/accessor names were invented to fill those records.
- Game/common strict totals remain1227 clean /7 extra /477 carriers,
  28type /28storage /0mapping findings; frontend/common remains780/48/438,
  9type /9storage /3mapping. Missing mapped names are zero in both. Scope and
  source-order improvements do not manipulate these name-audit counters.
- Native-image/link placement debt remains unchanged: inherited overlap and
  GP-binding issues are not cured by a code-PASS or an unchanged permissive
  relink. Full original source text, every SYM/SLD record and final image layout
  are not claimed complete. The active goal remains open.

## Actual hashes

- audiotrk.cpp:
  abe4b13ef1e6e0fb8647e93bd54323c01a81561cf77cfd0fdc43a73af3afa1da
- normal audiotrk.cpp.o (unchanged):
  d57d2dcfda69e37d673af8256b7b2823778956967d09a72db500a3d0e6036bb2
- linked ELF (unchanged):
  52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0
- report build/p900_report.binpb (unchanged):
  2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3

The link map's exact SHA is in before.json. Original macro/token spelling and
physical line numbers are not implied by equal instruction-line partitions.
