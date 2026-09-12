# P902: Server locals and async-loader control flow restored

2026-09-12. Local uncommitted checkpoint on main after b36aebd0. No network
operation, publication, scheduler, shared-header/build-tool/flag change or
compiler-output rewrite. Existing user changes and P898-P901 work are intact.

## Source changes

- **AudioMus_Server** removes three unproved ordinary locals:
  randomMusic/randomRange together, then switchMode through the positive
  default-state guard supported by M2C/IDA and GCC CSE source. Five reconstruction
  labels also disappear. SLD **39/170 ->39/29** with no new bad pairs;
  all300 raw words/56 references, native params/frame/root span and23/23 music
  functions/206 branches remain exact. One non-native done label remains,
  explicitly unsealed; no claim of complete native declaration coverage.
- **AudioCmn_LoadAsyncSfx** removes both failure labels and the artificial
  do/while(0). Natural failure exits, a complete success/header condition and
  loop-test increment restore SLD **0/58 ->0/9**. All105 raw words/23 references,
  48/48 functions/513 branches and native slot/check owners are preserved.
  The unproved s alias and extra empty block remain. The incorrect old s4
  claim is corrected: the slot GIV is s0, while s4 holds a string address.
- **AudioEng_CleanUp** is deliberately unchanged. Fresh9/9,128branches,
  56rawwords/7references and all four native scopes/g/i homes pass. Its player
  declaration probe was neutral and reverted. Remaining SLD1/2 traces exactly
  to an assembler-attributed NOP; no source/metric workaround was introduced.

These are improvements to actual source, not additional code-PASS percentages.
No replacement identifiers or fabricated macro/accessor names were added.
Each failed/intermediate form is frozen with its measured result, rather than
used as a necessity or impossibility claim. Server's fully no-goto rewrite was
tried but changes return-zero placement; its remaining label stays open.

## Verification

- **1093/1093 oracle-known symbol instances across48TUs PASS**, extending the
  P901 protected closure by AudioCmn48 and AudioEng9. It is not the whole game's
  unique-function coverage.
- **All518 normal objects literally unchanged**, together with the regenerated
  linked ELF/map. Complete prior branch diagnostics are preserved, including
  the separately known Speech SubmitRequest anomaly; no new discrepancy.
- Both relink lanes, vtable indexing, source-policy, strict audits and the
  CI-style objdiff report pass. P897's three full-build lanes are inherited;
  this source-only round uses fresh complete-TU gates and exhaustive object/
  image identity, not a claimed new full three-build sweep.
- Server's independent peer rechecks23functions/206branches/all22neighbor
  contracts and all300raw words, including all56references. It explicitly
  verifies done still denotes nativeA860 without declaring that label native.
- Async's actual-path validation compares every function's code, complete
  metadata, local/scope/line and debug graph against its accepted reference,
  and validates the105words plus diagnostic/header string payloads.
- Actual include closures contain no staged headers. Scratch/actual STT_FILE
  differences are checked exactly; actual-to-prior object identity is literal.
  Diagnostic GAS-L only retains existing anchors; no label/instruction is moved.

`final_receipts.json` ties the actual source and artifact hashes to these
results. Per-function evidence: ../p902_audiomus_server (including peer review
and compiler_angle.md), ../p902_audiocmn_async and
../p902_audiocmn_landed_20260912, ../p902_audioeng_cleanup. Campaign evidence:
regression_receipt.json, source_receipts.json, checks.json and strict reports.

## Remaining scope

Game/common: **1227 clean /7 extra /473 carriers** (476->473),
28type /28storage /0mapping findings. Frontend/common stays780/48/438,
9type /9storage /3mapping. Both have zero missing mapped SYM names, but the
source-review queues are not empty. These counters are not used to claim that
unrecoverable or unexamined source objects are exact.

Server's done and39/29 SLD, async's s/extra block/0/9, Cleanup's player and
assembler1/2, and all previously recorded inline/SLD/source-token/data-layout
gaps remain explicit. Existing linked-image overlaps/GP bindings are unchanged;
code/raw-reference equality does not prove the final whole linked layout.
The full original-source/SYM/SLD/image goal remains active and incomplete.

Actual source hashes:

- audiomus.cpp db92197177b06499a823b8c2be5ed3041f714eee536790a0fb8574f47998c5e9
- audiocmn.cpp ea914b6e9f5a712cf7f176385268e890fb9651f38396a062f4c5a3a4316cd629
- unchanged linked ELF52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0

No commit or push was performed for this local checkpoint.
