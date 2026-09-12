# P901 actual AudioTrk validation

The actual production source was compiled with actual headers into an isolated
output directory and compared against each accepted function's own reference.
No production source, normal build output or compiler instruction/label rewrite
is performed by these diagnostics.

- Actual source SHA256 ad651673e6664118a0d6925bc581c20d8ae9bdbc3978d30022fb87f3580e690e
- Actual object SHA256 d57d2dcfda69e37d673af8256b7b2823778956967d09a72db500a3d0e6036bb2,
  literally identical to actual P900 and P897 objects.
- 6/6 PASS and159 exact branch checks. All1004 raw words exact, including112
  reference words evaluated only in verifier memory.
- SoundTrack matches P901 candidate_comment: native SLD18/7, all25 local
  owners and19 emitted native blocks. Reset0/0, StartUp0/0, AddCustomObject0/0,
  CleanUp0/0 and PreLoad2/5 remain unchanged.
- Every function's full ordered definitions, lexical scopes, line partitions
  and debug instruction/local-label graph equal its own accepted reference.
  Actual nine-file source/header closure contains no staged headers.
- Source labels are not exempted or rewritten. AddCustomObject has none;
  ordinary compiler label-ID comparison does not alter generated files.

See combined_verification.json and landed_*_raw_target_receipt.json. Raw
reference comparison does not claim that the permissive whole-project linked
layout is native-exact. Original text/macro tokens and the existing empty
inline records remain unproved; the full goal is not complete.
