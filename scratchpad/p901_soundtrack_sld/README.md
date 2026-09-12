# P901 SoundTrack selection and loop-tail source recovery

Latest proposal: **proposed_with_comment.patch**, from actual P900 source
abe4b13e. Latest source: **candidate_with_comment.cpp**. Earlier unannotated
candidate, proposed.patch and all intermediate receipts remain frozen.
No production file, header, tool, normal object or prior-round receipt was
changed by this task.

## Verified result

- Native SLD22 merged/16 split pairs ->18 merged/7 split pairs: four false
  merges and nine false splits removed; ZERO new bad pairs.
- All six functions PASS;159 branch-distance checks exact; entire normal
  object literally unchanged before/after;358 raw SoundTrack words exact,
  including26 relocation words and the D098->D2F8 edge.
- All25 native SoundTrack local owners and all19 emitted scope records retain
  exact native address spans, depths, order and ownership. Only the two
  already-unproved zero-width CE40 records remain absent.
- All five neighbors preserve their complete code/local/scope/SLD graph.
  Reset, StartUp, AddCustomObject and CleanUp remain0/0; PreLoad remains2/5.
  The prior AddCustom31-block/18-owner and lifecycle owner restoration is
  preserved, not counted as a new P901 improvement.

## Source changes and compiler mechanism

### Native336 end selection

```cpp
int end;
(numelems < start + quater) ? (end = numelems) : (end = start + quater);
```

This initializes the existing native end on every path with no self-read,
new local, macro, qualifier, flag or helper. Both branches are assignments in
one related conditional expression. It restores native336's one complete
selection rather than packing independent statements onto one line.

The four bare-min variants falsified in P900 were not repeated. GCC source
explains their failure: fold-const.c5631..5660 recognizes A op B ? A:B and
chooses the equality-winning operand first in MIN_EXPR (a C++ lvalue rule).
expr.c6528 evaluates operand1 first and operand0 toward the target; its
fallback6575..6585 skips the copy on target<=operand1. That either swaps the
default operand/allocation or gives the observed wrong compare polarity.
The assignment arms are MODIFY_EXPRs rather than the bare compared values;
ordinary COND_EXPR expansion can preserve the strict test. The resulting
retail register/control-flow sequence was measured directly, not inferred
from source alone. No compiler-source modification or code-generation flag
was used. This selected spelling is NOT claimed to be the uniquely recovered
original tokens.

### Native469/470 loop tail

The for-header now advances only i. The final skip is expressed as the full
complementary type/animation guard around AudioTrk_AddCustomObject, followed
by se++ at the loop-body tail. Thus se advances exactly once on BOTH called
and skipped paths; simply moving se++ while retaining continue would be wrong.
The complete repeated post-call type test remains, so no cached predicate
assumption is introduced. Native469's two pointer updates are now separated
from native470's loop back edge/index update, with unchanged real scope ends.

GCC's archived cp/parse.y expands the for-update after the scoped body and
emits its line note at that point; stmt.c expand_loop_continue_here /
expand_end_loop control the continuation/back edge and respect block notes.
The measured body-tail form produces the native line partition without
moving emitted scope owners or rewriting debug labels.

## Frozen progression

| Stage | Code | Native SLD | Disposition |
|---|---|---|---|
| before |6PASS;whole object exact |22/16 |actual P900 |
| se_declaration_init |6PASS;whole object exact |22/16 |neutral; restored |
| end_arm_assignments |6PASS;whole object exact |22/7 |retained |
| loop_tail |6PASS;whole object exact |18/7 |retained |
| candidate |6PASS;whole object exact |18/7 |unannotated frozen proposal |
| candidate_comment |6PASS;whole object exact |18/7 |latest, concise MATCH comment |

## Remaining gaps and qualifications

The18 merged pairs and three of the seven splits are the previously traced
assembler-side hazard-NOP/debug-marker sites CF40 and D2D0. They remain in the
reported metrics: no exemptions, marker moves or C workarounds were added.
The other four splits concern the se address among native329 vx loads. A
natural declaration initializer was code-identical but did not improve that
partition, so it was restored. Original inline/accessor identity near the two
empty CE40 records remains a future source/debug attribution question.
No unrelated se/vx comma grouping or invented accessor was used.

The P898 widening-cast token spelling remains unproved. Full original source
or SLD exactness is not claimed, despite the exact named local ownership.

## Latest hashes and receipts

Production baseline:
`abe4b13ef1e6e0fb8647e93bd54323c01a81561cf77cfd0fdc43a73af3afa1da`.
Latest candidate:
`ad651673e6664118a0d6925bc581c20d8ae9bdbc3978d30022fb87f3580e690e`.
Before/after isolated normal object:
`e57faac5c481330260b1a1fca89edbddee000d00ad9bafb17050d6437b4824f0`.

final_comment_receipt.json and candidate_comment_verification.json contain
the complete proof. candidate_comment_raw_target_receipt.json covers all358
raw words. remaining_SLD_pairs_comment.json lists every remaining pair.
check_proposal.py/proposal_with_comment.json check source/header/artifact
hashes without applying the patch. Parent must validate the ACTUAL source
after landing; this task has not committed or published the proposal.
