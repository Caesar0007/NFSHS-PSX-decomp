# P903 PlaySong: remove pick and restore native source structure

Verified proposal only, 2026-09-12. **Plain C++ final form**, no invented
identifier/helper/macro, asm, volatile, new qualifier/flag or output rewrite.
Production and all prior checkpoints remain unchanged.

## Result and checked patch

Run `python scratchpad/p903_audiomus_playsong/verify_final.py` to validate actual
input hashes and receipts and print the exact source-only patch. It does not
apply it. `candidate_verified.json` is the combined receipt.

- **23/23 PASS**, **206 exact branch checks**, entire normal object literally
  byte-identical before/after.
- PlaySong **160/160 raw words**, including **30 reference words**, exact.
- **pick removed**, with only native pattern/title/newsong declarations.
- **All nine native scopes** match ordered spans, depths and declaration owners.
  Native title and newsong homes and pattern parameter type/home are exact.
- Native SLD **0 merges /44 splits to0/0**, with zero new bad pairs.
- All22 neighbors retain complete source/debug/local/label-PC/scope contracts;
  P902 Server stays39/29 with no ordinary locals, and Threshold stays0/0.

## The source path that worked

The final paired changes are:

1. Replace the volume!=0 wrapper with an early return for volume==0. This
   restores newsong's native lexical depth4 instead of6.
2. Initialize native newsong **after** `AudioMus_g->randomize = 1`.
3. In the pattern arm, divide the repeated-GetRCnt conditional result by the
   real `AudioMus_g->availablesongs` member, not the overwritten newsong local.
   This keeps the single modulo join and original caller-register-to-newsong
   copy without a separate pick declaration.
4. Put the outer null-global return in an explicit else. This restores the
   empty depth1 block endpointB294 instead ofB290.

The six textual GetRCnt call sites are retained: each selected random branch
performs the first test call and then its chosen second call. No abs(single
call) substitution or cached counter read was introduced. All actual instruction
words and references match, including the original field sampling across calls.

## GCC evidence, not a new necessity claim

The inspected GCC2.8.1 `extracted/fold-const.c` lines3869..3969 distribute binary
operations into COND_EXPR branches. A non-simple other operand can use SAVE_EXPR;
VAR_DECL/PARM_DECL are specifically treated differently. This motivated the
real-member divisor probe. `expr.c` store_expr/COND_EXPR handling distinguishes
result targets and temporary joins. These sources explain the selected angle;
the actual CC1PLPSX compile is the byte authority, and a complete instrumented
RTL/CSE trace is not claimed here.

The member divisor alone is161words/31diffs. Pairing it with initialization after
the randomize store restores160/PASS. The declaration order is therefore part
of this measured result, not cosmetic cleanup.

The old W55 comments claimed a second-use fence and a required pick carrier.
The current baseline already contains **no fence** and passes160 with bare pick.
Direct removal still reproduces171words/15diffs, so that historical count result
was re-confirmed; necessity/fence claims were not. The final source replaces the
obsolete claims with these measured paired-source facts. Older historical files
and receipts were not edited.

## Frozen experiment ledger

| Stage | Words / diff lines | Important evidence | Retained? |
|---|---|---|---|
| before |160 /0 |15 scopes, newsong wrong depth6, SLD0/44 |baseline |
| direct |171 /15 |pick removal distributes modulo; branch count grows |no |
| volume_guard |171 /15 |structural early-return direction alone does not fix modulo |paired |
| field_divisor |161 /31 |real member gives one modulo, but extra load/allocation mismatch |paired |
| expression_scope |160 /0 |anonymous GNU block gives SLD0/0 but14 scopes |diagnostic only |
| scalar_value |171 /15 |scalar compound-value syntax folds back to the direct miss |no |
| native_init |160 /0 |plain C++, no pick,9 scopes, both local owners exact, SLD0/0 |paired |
| outer_else |160 /0 |all9 native scope endpoints now exact |retained |
| candidate |160 /0 |final comments/indentation freshly gated and raw-verified |final |

Every named stage has a frozen source snapshot and gate/output receipt. The
unequal-length direct/volume stages cannot use the old fixed-offset neighbor
SLD inspection: its attempted Volume comparison encountered shifted object
offsets. Those stages are recorded by the reliable per-symbol gate/branch
results, not misreported as neighbor source regressions. All final equal-length
neighbor checks pass. The first title parser recognized only simple dimensions;
its original before inspection is retained as
`before_inspection_initial_title_parser.json`, and the corrected parser checks
the full native ARY CHAR title[128] record.

## Native and raw anchors

SYM record19fbba..19fcf1; parameter19fc0b, title19fc5f, newsong19fcaf.
Frame168, mask800f0000,-8. Pattern is PTR CHAR/REGPARM s3; title is CHAR[128]
AUTO-152; newsong is INT/REG s0. `candidate_inspection.json` contains all nine
native/current scopes and every statement group.

Updated M2C `C:/Temp/nfs4-clean/Binaries/NFS4-B-USA/c/func_8007B030.c` confirms
the control/data structure and repeated counter calls. The old split IDA body
collapses this function to return0 and is not useful source authority here.

`candidate_raw_target_receipt.json` proves all640 bytes; its two .rodata
relocations are anchored specifically to the byte-exact `*-%s` literal at
8013C724 (compiler pool offset100). This is not an assumed linear retail address
for the whole module's string pool. No object is patched during resolution.

Source before:
`db92197177b06499a823b8c2be5ed3041f714eee536790a0fb8574f47998c5e9`.
Candidate:
`3e0c7376f6a75d66c8d0111c7d5da747782ef03fd7cd69fabb253e0db6b98742`.
Both normal scratch objects:
`99f591c31f7273ee3106d16e2da4076983abce640b0ace61d804b87805641d09`.
Raw160-word target:
`9a47656b9d23ebfab0c115afc09d984aeb03d9b3952cf0d79391cfa2d62c5d7e`.

Original physical line numbers and unique macro/token spelling remain unsealed.
This is verified native declaration/scope/statement-group recovery, not a claim
that the entire project or original physical source text is complete.
