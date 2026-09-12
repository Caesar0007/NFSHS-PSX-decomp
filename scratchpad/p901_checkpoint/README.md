# P901: source-only carrier removal and native statement recovery

2026-09-12. Local uncommitted checkpoint on main after b36aebd0. The full goal
remains active; no scheduler, publication, network operation or unrelated edit
is included. P898/P899/P900 changes and the user's w85 file are preserved.

## Actual source changes

- **AudioMus_Threshold**: removes unproved `music`, its generic carrier marker,
  and four reconstruction goto labels. Separate early returns use AudioMus_g
  directly, reproducing the native empty scope and **SLD0/4 ->0/0**. All33 raw
  words and both backward return edges remain exact. All23 music functions,
  206 branches and22 complete neighboring source/debug contracts are preserved.
  Independent review additionally emulates8100 signed-boundary/guard cases.
- **AudioTrk_SoundTrack**: conditional assignment arms to existing `end` recover
  native336's single selection; a positive eligibility guard plus body-tail
  se++ separates native469/470 correctly while preserving skipped iterations.
  **SLD22/16 ->18/7**, with all25 local owners and the19-block native projection
  intact. No new name/helper/macro/qualifier/device is introduced.

The code bodies remain PASS. These are source restoration improvements,
not an increase in code-match board percentage. The selected conditional
assignment form is not claimed to be the uniquely recovered original tokens.
GCC2.8.1 fold-const/expr source explains its distinction from MIN_EXPR lowering;
actual canonical-compiler measurements establish the resulting bytes.

## Verification

`final_receipts.json` ties actual source and include hashes to the following:

- **1036/1036 oracle-known symbol instances across46TUs PASS**, extending the
  previous protected closure by AudioMus's23 functions. This is not a claim
  about the whole game's unique-function coverage.
- Every prior branch diagnostic preserved, including the separately known
  Speech SubmitRequest discrepancy. No new branch discrepancy.
- **All518 normal objects literally unchanged**, as are the regenerated linked
  ELF and map. Both relink lanes, vtable indexing, source-policy, strict audits
  and the CI-style objdiff report pass.
- All1004 AudioTrk raw words and112 native reference words rechecked against
  the actual combined source. Its six functions match their accepted native/
  debug contracts individually; actual inputs contain no staged headers.
- Music's33 raw words include one independently checked GP relocation.
  The peer review rechecks the normal object, all22 neighbors and signed logic.
- No production header/build-tool/flag change or postcompile instruction/
  debug-label rewrite. P897's full three-build lanes are inherited; this
  CPP-only round uses fresh full-TU gates and exhaustive object/image equality.

Primary receipts: ../p901_audiomus_threshold/landed_verified.json and
peer_receipt.json; ../p901_audio_landed_20260912/combined_verification.json;
../p901_soundtrack_sld/final_comment_receipt.json. Failed/intermediate source
forms remain frozen in those directories. `regression_receipt.json`,
`source_receipts.json` and `checks.json` contain the campaign checks.

## Strict totals and honest remaining work

Game/common: **1227 clean /7 extra /476 carriers** (477->476),
28type /28storage /0mapping findings. Frontend/common:780/48/438,
9type /9storage /3mapping. Both have zero missing mapped SYM names. The queue
is not empty, and declaration-clean coverage is not original-source proof.

SoundTrack's remaining18 merges and3 of its7 splits are the already traced
assembler hazard-NOP line-attribution gaps. Four splits concern the list-data
address among vx loads on native329. These remain counted; no metric exception
or C workaround masks them. Reset's se name, its two zero-width blocks,
SoundTrack's empty CE40 blocks and P898 cast spelling, plus PreLoad's original
CAudioList accessor/implicit this/two D410 blocks remain unproved.

The bounded CAudioList audit accounts for all20 raw SYM classname strings in
13 dump records and finds no named member/function record or header line.
Checked PC data uses a different layout. Evidence is in
../p901_audio_inline_identity; no accessor name is invented to fill the gap.
Another original EA header/debug artifact could supply the missing identity;
this does not block the broader source-recovery campaign.

Inherited linked-image overlap and GP-binding debt remains unchanged. A
permissive relink or equal object does not establish final native data layout.
Full original token spelling, every source/SLD record and final image equality
are not proven, so the goal remains incomplete.

## Hashes

- Actual audiomus.cpp:
  ece741259dcb13d2f7f320d8e3f0464d42397061121b16dd9d9bbabf07635607
- Actual audiotrk.cpp:
  ad651673e6664118a0d6925bc581c20d8ae9bdbc3978d30022fb87f3580e690e
- Unchanged linked ELF:
  52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0
- Unchanged report build/p901_report.binpb:
  2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3

No commit or push was performed for this local checkpoint.
