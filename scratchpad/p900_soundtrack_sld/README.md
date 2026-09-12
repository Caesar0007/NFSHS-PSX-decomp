# P900 SoundTrack related-expression/SLD recovery

Isolated proposal based on actual P899 source7fff98cd. No production source,
headers, tools, normal outputs or previous P898/P899 files were changed.

## Retained source changes

1. The conditional random delay is one initializer of the existing native
   randtick local:
   `int randtick = ((u_char)se->randomDelay > 1) ? (u_int)random() % (u_char)se->randomDelay : 0;`
   Native SLD394 owns the condition, zero/default arm, random call and modulo
   at8007CFBC..CFF4. Its scope1bf25a and REGv1 record1bf263 remain exact.
2. The bounded animation sampling time is one initializer of native next:
   `int next = (max - 1 <= tck + 32) ? max - 1 : tck + 32;`
   Native SLD442 owns8007D128..D144. Its local1bf35b remainsREGs0 and its
   original nextcp/next/time owner span/depth is unchanged.

These are complete related value selections, not independent statements
placed on one physical line. No new name, helper, macro, qualifier, asm,
volatile, pin, compiler flag or output rewrite was introduced.

## Verification

- Native SLD22 merged/76 split pairs ->22 merged/16 split pairs:60 false
  splits removed, ZERO new bad pairs.
- All25 native local owners remain exact. All19 emitted scopes preserve the
  exact ordered native projection; only the two unproved empty CE40 records
  remain absent. No source/name/scope exceptions were added.
- Entire TU6/6 PASS,159 branch checks exact, both normal objects literally
  identical; SHA256c0d7b59c13751bdb82da85dab6a212e4f6d85888b4a33e093b64b80535cc2bf2.
- Both exact-g text payloads equal normal text. Five neighbors preserve
  their complete local/scope/SLD/instruction graph. Reset remains0/0 and
  PreLoad2/5; their previously recovered native owners are unaffected.
- All358 raw SoundTrack words match the ROM after26 relocation evaluations;
  the nonanimated D098->D2F8 edge remains exact. No files/instructions are
  rewritten during raw verification.

## Measured alternatives, all frozen

| Stage | Result | Disposition |
|---|---|---|
| before |6PASS;22/76 |current P899 baseline |
| randtick_select |6PASS;22/31 |retained |
| next_select, `max-1 > tck+32 ? tck+32 : max-1` |8diff/358 |wrong default register/branch shape |
| next_select_le, `max-1 <= tck+32 ? max-1 : tck+32` |6PASS;22/16 |retained |
| end_select, numelems<sum |24diff/358 |register/allocation cascade |
| end_select_le, sum<=numelems |24diff/358 |same cascade |
| end_select_num_le, numelems<=sum |4diff/358 |opposite slt/branch polarity |
| end_gnu_min |4diff/358 |same polarity mismatch; restored |
| candidate |6PASS;22/16 |only the two retained initializers |

The old end initialization/conditional override is restored exactly. Its
single native336 source group remains a recovery question; no invented clamp
macro, self-initialization trick or combined independent statements were
introduced to force the counter down. No velocity components were grouped:
their native449/450/451 and456/457/458 lines remain distinct.

## Important qualification: two NOP line boundaries are assembler-side

The inherited remaining metric includes18 merged pairs and3 split pairs at
8007CF40 and8007D2D0. The saved compiler assembly already places the next
statement's `.loc`/LM note before its hazard boundary. maspsx's instruction
lookahead skips these markers and appends the hazard NOP while processing the
preceding load/remainder; the retained LM therefore lands four bytes AFTER
the NOP. Thus the current assembled-marker reader attributes it to the prior
statement. This is not evidence that CC1's C source-line note is misplaced.

Exact candidate marker windows, addresses and counts are in
nop_attribution_receipt.json. Main-agent and independent reference review
checked maspsx is_instruction/_handle_nop_before_next_instruction and GCC
final_prescan_insn. NO marker or NOP was moved, NO metrics were exempted, and
NO C workaround was used. The current result stays honestly22/16. Authentic
assembler/debug attribution for unchanged compiler input is the next bounded
evidence question, not a confirmed C-source defect or an unavoidable floor.

Other remaining questions: nine split pairs for end's native336 selection,
four for the se address scheduled among vx loads(native329), and four merged
pairs between the loop pointer update(native469) and back edge/index update
(470). remaining_SLD_pairs.json lists every pair without hiding any.

## Proposal and hashes

Candidate source SHA256:
`0f379d28e3396422b51cd929b5cab76f5dc69a7e2b085b195099271ac5e7a285`.
Unchanged production baseline SHA256:
`7fff98cd7b07e474d4e75d92e78fa7ed1125a67f97f2e8a658aee8bc402f3dda`.

proposed.patch contains only the two SoundTrack value-selection edits.
check_proposal.py/proposal.json verify its baseline, candidate and receipt
hashes. candidate_verification.json/final_receipt.json contain all native
scope and SLD proof; candidate_raw_target_receipt.json contains the raw words.
Full original source or SLD exactness is not claimed. Parent must re-gate the
actual source after landing; this task has not published or committed it.
