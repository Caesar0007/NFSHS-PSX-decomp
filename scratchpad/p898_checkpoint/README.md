# P898: native scopes and audio statement restoration

Verified on 2026-09-12, continuing the paused candidates from the published
P897 checkpoint `b36aebd0`. The main original-source/SYM/SLD goal remains active
and incomplete. No new commit or push is implied by this local checkpoint.

## Applied source changes

**AIPhysic_GetDesiredVector:** move the existing `checkSide` declaration into
its native conditional and remove the redundant unnamed wrapper. All four
native lexical ranges/depths and all 14 parameter/local types and homes now
match. The code remains 378/378 raw words exact, with all 42 TU functions and
41 neighboring source/debug contracts preserved. Native SLD remains at
77 merged pairs / 184 split pairs; that separate work is not declared solved.

**AudioTrk_SoundTrack:** remove `curBack` using the grouped widened subtraction
`fadeOut - (long long)(cur - 128)`. Native SYM has no such local; contrary to
the old comment, the former reconstruction actually emitted it in REG v0.
The guarded arithmetic is bounded and equivalent, and all 358 raw words are
unchanged. The cast spelling is not claimed original. All 25 native local
definitions and their existing owners are preserved; induced blocks fall from
29 to 23, versus 21 native blocks. Remaining native ownership discrepancies
are active work, not accepted as irrecoverable or hidden by a new exemption.

**AudioTrk_PreLoad:** restore separate early guards, one expression for each
distance calculation, three nested tests, the separate `se++` statement and
the conditional return shape. All 116 raw words remain exact. Native SLD pair
differences improve from **178 merges / 43 splits to 2 merges / 5 splits**,
with no new bad pair. The five corrected native `se/i/x/z/d` owners stay exact.

The remaining PreLoad pairs concern the list-access expression feeding the
loop setup. Its CAudioList implicit receiver record and two zero-width inline
blocks still lack an established original accessor identity. No invented
GetData/GetElements helper or new variable is supplied to disguise that gap.

## Evidence-directed steps and rejected forms

PreLoad's frozen successful sequence is 178/43 -> 158/43 (separate guards)
-> 158/5 (grouped distances) -> 39/5 (separate nested tests) -> 35/5 (separate
pointer increment) -> 2/5 (conditional return). A one-line guard/return spelling
kept code PASS but failed the no-new-SLD-pairs check; separate source statements
closed it. Every accepted step preserved the native local-owner ranges.

For AIPhysic, moving the declaration alone or moving the wrapper boundary kept
the code matched but duplicated a parent block and placed `checkSide` at depth 4.
Removing the redundant wrapper restored the exact four-block native tree.

SoundTrack's plain expression was FAIL 20 at 358 instructions; mutating native
`cur` emitted an extra stack store (FAIL 1 at 359). Widening preserved the
grouping without that store or a substitute local. Full failed-stage receipts
remain isolated; no failed form was applied to production.

IDA folds both audio targets to trivial returns, so it is not a useful body
oracle here. Raw instructions, updated split M2C and Ghidra provide the needed
independent control-flow checks. Native SYM remains the name/type/scope authority.

## Actual production and regression checks

Both changed files were compiled through actual production paths and headers.
Independent validation excludes scratch headers and checks exact input hashes.
The actual normal objects are byte-identical to their P897 production objects;
scratch comparisons permit only the specifically asserted STT_FILE pathname.
Comments/line endings may change physical counters, not code or ownership.

- **1,013/1,013 oracle-known symbol instances across 45 TUs retain PASS.**
  This includes two documented static helper copies, not 1,013 unique global
  function identities or a whole-game percentage.
- Complete branch diagnostics match the baseline. The existing Speech
  SubmitRequest distance discrepancy is preserved, not counted as clean.
- All **518 normal source objects**, the regenerated linked ELF and the full
  map are literally unchanged. The earlier native data/reference proofs remain
  applicable; their known layout debt is not newly solved.
- Relink policy, vtable indexing, source-only policy and CI-style report
  generation pass. No production build tool, flag, header, asm/volatile device,
  instruction or debug label was added or rewritten.
- These CPP-only changes use fresh complete-TU regressions and exhaustive
  object equality. P897's three full build lanes are inherited, not falsely
  reported as a new three-lane build in P898.

Linked ELF SHA256:
`52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.

Strict game/common remains 1227 declaration-clean, 7 extra local names,
28 type findings, 28 storage findings and zero mapping review; source-only
carriers fall **478 -> 477**. Frontend/common remains 780 clean / 48 extra /
438 carriers, with 9 type findings, 9 storage findings and 3 mapping reviews.
Both have zero missing mapped SYM names. These figures do not prove complete
source or SLD restoration. The broader carrier/scope/data queues remain active.

Primary receipts: `final_receipts.json`, `regression_receipt.json`,
`source_receipts.json`, strict reports and `relink.json`. Detailed actual-source
receipts are in ../p898_aiphysic_scope_resume_20260912,
../p898_audio_soundtrack_landed_20260912 and ../p898_audio_preload.
The user's unrelated `scratchpad/w85/o2.txt` and all prior experiments remain
preserved. No network operation, commit or push was performed in this round.
