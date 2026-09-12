# P902 AudioMus_Server: three source-only locals removed

2026-09-12. Applied source-only restoration, not a new code PASS. The complete
300-word function was already PASS; the improvement is its source objects,
control flow and native statement ownership. No new identifier, macro, helper,
qualifier, asm/volatile device, compiler flag or output rewrite is used.

## Accepted result

- Removed **randomMusic, randomRange and switchMode**, including all three
  generic carrier markers. Native SYM has only mode/ticks parameters and no
  ordinary locals; the accepted source now has no ordinary locals either.
- Five reconstruction labels removed through structured conditions and
  duplicated source tails that GCC merges naturally. The existing **done**
  label remains explicitly unproved; it is not reclassified as native.
- Native SLD **39 merges/170 splits ->39/29**, with zero new bad pairs.
- All300 raw instructions, including56 reference words, exactly match the
  executable after read-only native-address evaluation. All23 TU functions
  and206 branches remain exact; the whole actual normal object is unchanged.
- All22 neighbors, including P901 Threshold's empty scope/SLD0/0, preserve
  their full local/type/home, scope, source-line and debug instruction graphs.
- Native mode/ticks homes, frame40/mask800f0000,-8, and root span
  8007A3D0..8007A864/depth0 are unchanged. Root declarations are NOT fully native:
  one SCL6 done record remains where native has none.

Actual source and object checks are in landed_verified.json;
landed_inspection.json and landed_raw_target_receipt.json contain full scope,
SLD and raw receipts. The campaign regression is ../p902_checkpoint.

## Paired source recovery, not single-edit necessity claims

The two old random-expression comments each claimed a four-diff failure when
one alias was removed. Removing BOTH aliases and spelling the direct left-
associated expression produces the exact instruction stream. The two source
perturbations were coupled; neither individual failure proved a required
source variable. Right-association was measured299/25 and rejected.

The remaining switchMode constant was not resolved by an ordinary switch or
literal replacement alone (300/16). The native SLD test lines are separate,
and M2C/IDA describe a nested if with a positively guarded default state.
That positive default guard allows GCC to reuse the anonymous constant2
across AudioMus_QueueRequestedSong, preserving s0 without a named source local.
The full mechanism and measured receipts are in compiler_angle.md. The cited
GCC2.8.1 force_reg/CSE/call-invalidation/path/allocation code explains the
route; exact instrumented CSE region decisions were not captured, and that
source version is not claimed to be the canonical compiler's byte oracle.

Compound disk/default/zero-state conditions restore complete related native
tests. Nested state branches replace dispatch labels. Duplicating the failby
source assignment at its two legitimate sites lets GCC share the retail tail
without an invented source label. Calls still occur only on the same paths.

## Frozen stages

| Stage | Instructions/diff | SLD merge/split | Disposition |
|---|---|---|---|
| before |300/PASS |39/170 |P901 actual baseline |
| native_switch |300/16 |not retained |constant reuse wrong |
| random_right_group |299/25 |not aligned/scored |wrong arithmetic association |
| random_direct |300/PASS |39/95 |two aliases removed together |
| condition_groups |300/PASS |39/39 |native compound tests |
| switch_breaks_carrier |300/PASS |51/39 |12 new merges; rejected |
| structured_if |300/PASS |39/37 |native separate state tests |
| duplicate_time_tail |300/PASS |39/29 |two shared-tail labels removed |
| direct_returns |303/21 |not aligned/scored |shared return/call-tail changed |
| structured_candidate |300/PASS |39/29 |intermediate, switchMode still present |
| positive_default |300/PASS |39/29 |last ordinary carrier removed |
| full_structured |299/25 |not aligned/scored |return-zero slot/epilogue differences |
| candidate / landed |300/PASS |39/29 |final measured source |

Failed experiments remain private and frozen; production has only the final
improvement. No failed source form is called a floor. Full no-goto rewriting
was tried and changed return-zero placement; the remaining done label and
source-line groups are active source-recovery work.

## Authority and qualification

Native record19f34b..19f3d1 in
C:/Temp/claud/dumpsym_clean/dumpsym_src/nfs4-f-v3.txt; raw body
rom/nfs4-f.exe8007A3D0..8007A880. Independent split M2C:
C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007A3D0.c; IDA's positive
default guard is also present in nfs4-psx-IDA.c around65289. Neither
decompiler's temporary names are original-name authority.

GAS-L diagnostics retain existing anchors only; compiler assembly hashes
and all code/data payloads are unchanged. Unchanged neighboring source-label
IDs may be naturally renumbered; their exact native PCs and complete debug
graphs are compared, never rewritten or ignored. Scratch-to-actual FILE
symbol differences are checked exactly; actual-to-P901 object bytes match.
Raw native-reference equality does not claim final linked-layout correctness.
Original token spelling and full SYM/SLD restoration remain unproven.

Actual final source SHA256:
db92197177b06499a823b8c2be5ed3041f714eee536790a0fb8574f47998c5e9.
Unchanged actual normal object:
f6e556413410b4b0d3879ed8ae420b67df328f82cdf1e37add8e3ae6eee4a87b.
Raw target SHA256:
654deb9aad3cb66fa0fc0b5c5d0833e5854bef14b8e35535a51a17253e9f7dde.
