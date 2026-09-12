# P898 PreLoad: source-line partition recovery

The complete source/oracle instruction trace isolated five discrepancies in
PreLoad: combined early guards, split distance selections, a combined three-test
condition, a combined pointer/index increment, and the final return/epilogue
source group. Native lines are respectively 479/482, 506/507/508, 510/511/512,
514/515 and 519/527. The native five local owners were already fixed in P897.

All successful forms retain 6/6 PASS, exact branches and the entire normal
object. Stages and native SLD merged/split pair counts:

| Stage | Merges | Splits |
|---|---:|---:|
| before |178|43|
| guards_lines |158|43|
| distance |158|5|
| conditionals |39|5|
| increment |35|5|
| return_if_resume |2|5|

The initial one-line `if (...) return 1;` guard form preserved code but failed
the strict SLD no-regression check. Separate condition and return statements
fixed that attribution. The last return-if variant was code-PASS before the
pause; its SLD, scope and full raw proof were completed after resuming on
2026-09-12. Prior outputs were preserved in their original stage namespaces.

The accepted PreLoad body contains no new local, helper, macro, volatile, asm,
compiler flag or invented name. All five native local address spans/depths are
unchanged. Full **116/116 words** match raw ROM: 23 relocated reference words
and 93 unmodified instructions. Relocations are evaluated in verifier memory,
not written into any compiler output. Existing compiler labels are retained
with diagnostic GAS -L only; no label is injected or renamed.

Candidate and landed stages also include the independently verified SoundTrack
`curBack` removal. The combined checker compares SoundTrack against its accepted
local/scope/instruction contract, PreLoad against its native owner constraints
and no-new-SLD-pairs condition, and all other functions against the unchanged
baseline. It does not disable neighbor checks to accommodate a second edit.

Remaining 2/5 pairs concern the list-access expression and loop setup. The
native inline CAudioList receiver and two empty blocks still lack a proved
original accessor name. The existing arithmetic pointer expression remains
explicit; no guessed method is introduced. Original macro/operator spellings
and physical line numbers are not claimed uniquely recovered.

Read `landed_verification.json` and `landed_raw_target_receipt.json`, plus
../p898_audio_soundtrack_landed_20260912/combined_verification.json for the
independent combined actual-source proof. The parent ../p898_checkpoint records
the full normal-object, source-gate and linked-image regression results.
