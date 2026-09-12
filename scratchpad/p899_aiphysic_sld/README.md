# P899: AIPhysic_GetDesiredVector statement recovery

**Latest accepted proposal:** the bounded paired follow-up below reaches **7 merges /
0 splits**, preserving all code, homes and native scopes. Use `propose_paired.py`;
the original `candidate` / `proposal_verified.json` 7/184 proofs remain frozen.

Verified source-only proposal, 2026-09-12. Production and all P898 receipts remain
untouched. The fresh baseline is the actual landed P898 source, not its earlier
scratch candidate. The complete nine-file closure and include edges are frozen
in `frozen_inputs.json`, with exact backups under `backups/recon`.

## Retained result

Native SLD merge conflicts **77 to 7**; split conflicts **184 unchanged**;
**zero new bad pairs**. All 42 TU functions remain detailed PASS, branch counts
and distances match, and the entire normal object is literally byte-identical.
All four native scope spans/depths, all 14 native parameter/local types and homes,
and all 41 neighboring source/debug/local/lexical contracts remain exact.
All 378 target words (1512 bytes) equal the raw binary, including 38 reference
words resolved only in verifier memory. No emitted output or labels are rewritten.

Run `python scratchpad/p899_aiphysic_sld/propose.py` from the repository root to
recheck actual input hashes and receipts and print the exact one-file apply_patch
proposal. It does not land the patch. `proposal_verified.json` is the combined
receipt; `before.json`, `candidate.json`, `candidate_scope.json`, and
`candidate_raw.json` retain detailed independent checks.

The retained changes use only existing native locals:

- `sliceLookAhead`: split `fixedmult` from the following bias/divide, matching
  native lines 1126 and 1127 (indices 29..30 versus 31..39).
- `futureBend`: split `AIWorld_CalcRoadBend` from `__builtin_abs`, matching native
  1140 (91..92) versus 1141 (108..110).
- `goodVector`: preserve each lane-index result in the existing native local,
  then call `AIWorld_IsDriveableLane`; separate the final nonzero conversion.
  This restores native 1226, 1230, and 1242 as independent groups without new
  variables, control flow, qualifiers, macros, flags, or helpers.

The source shape is supported by native statement groups plus byte and local-home
evidence. This is not proof of exact original token/macro spelling or physical
source line numbers, and it is not a complete source-restoration claim.

## Frozen experiment ledger

| Stage | Whole-TU PASS | Target words / diff lines | Native merge/split pairs | Disposition |
|---|---:|---|---|---|
| before | 42/42 | 378 / 0 | 77 / 184 | actual P898 baseline |
| abs_split | 42/42 | 378 / 0 | 71 / 184 | retained |
| lookahead_split | 42/42 | 378 / 0 | 53 / 184 | retained |
| lane_split | 41/42 | 376 / 30 | not evaluated | rejected extra shift-value staging through goodVector |
| lane_future | 41/42 | 376 / 46 | not evaluated | rejected extra staging through futureRoadPosition |
| boolean_split | 42/42 | 378 / 0 | 39 / 184 | retained |
| lane_index_split | 42/42 | 378 / 0 | 7 / 184 | retained |
| candidate | 42/42 | 378 / 0 | 7 / 184 | final fresh verification |

Failed variants are preserved in named `.cpp` snapshots and their normal/debug
objects and gate JSON. The fixed-size scope verifier correctly refuses their
376-word target; they are not counted as scope/home successes. The paired return
to call-only staging establishes that the useful split is the call boundary,
not an arbitrary new intermediate assignment.

## Exact remaining source questions

`before_sld_groups.json` and `candidate_sld_groups.json` contain every native
SLD group, every current group, source attribution and all 378 raw instructions.
`remaining_sld.json` holds all seven remaining merge pairs with both exact
instruction records, plus the four split groups.

Remaining merge pairs (instruction indices are zero-based from 8006AC3C):

- Current line 978 joins native 1224 index 313 (shift) with native 1225 indices
  312, 314, 315 (LaneIndex setup/call/delay slot): three pairs.
- Current line 980 joins native 1228 indices 321, 322 (road-position load/shift)
  with native 1229 indices 323, 324 (LaneIndex call/delay slot): four pairs.

Remaining splits:

- Native 1132, indices 54..65: current max-lookahead if and assignment, 11 pairs.
- Native 1208, indices 245..257 and 263: three coordinate fixedmult assignments,
  65 pairs.
- Native 1209, indices 259..261 and 264..270: three coordinate additions, 33 pairs.
- Native 1270, indices 355..369: three desiredVector coordinate subtractions,
  75 pairs.

Next evidence-backed angles: identify the original vector-operation expression
or macro body for the single native 1208/1209/1270 groups, and the native
max-lookahead clamp expression at 1132. Do not merely put unrelated statements
on one line or invent a macro to force partitions. The remaining lane argument
shift/call split needs a source form that preserves the verified local lifetimes
and branch layout; both measured extra-carrier routes above change the code.

## Hash anchors

Actual baseline source:
`494c693f0da1533e01f60db77f1a74a285d387cd8c43a6eaa4c910071e5f7345`.
Final candidate source:
`cd45e05251b6e9789eb43219c2cfe1a3d7c760e0f31f21183c8cfc4c67c2ef83`.
Both isolated normal objects:
`0d657a708c36808770bb2520158ef30a008ddeb9a208d839a248958e0156bc8f`.
Raw target:
`e16f98c5d37155a416fd13f6f21e8949209c8c71329352e79286b583f271d1ac`.

## Authorized paired follow-up: whole-vector groups and clamp

The parent authorized genuine comma-expression recovery, analogous to the
already verified AI_AddCollidableObjects idiom, not same-line semicolon grouping.
Replacing the first two semicolons in each x/y/z vector operation with comma
operators preserves strict left-to-right evaluation and creates one expression
statement per operation. Native 1208, 1209 and 1270 then become exact groups:
7/184 to **7/11**, with unchanged full object, all 42 functions/branches, all four
scopes, all 14 homes and all 41 neighboring debug/source contracts.

The native 1132 clamp becomes one conditional expression using the existing
`sliceLookAhead` and identical max-lookahead reads. That removes the remaining
11 splits: **7/11 to 7/0**, again preserving every gate and adding no bad pairs.
This does not establish original macro names or tokens; none are invented.

Preserved additional stages:

- `vector_grouped`: 42/42, identical normal object, 7/11.
- `max_conditional`: the first patch anchor hit identical earlier SimplePhysics
  clamp text. Code remained byte-identical, but the 41-neighbor source gate
  caught the unintended line-partition change. This scratch-only variant is
  rejected and frozen; it is **not** part of the proposal.
- `max_target`: restores the earlier clamp and edits only the target clamp with
  an explicit following `dirCorrectedSliceLookAhead` anchor; all checks pass, 7/0.
- `paired_candidate`: fresh whole-TU/debug/raw revalidation of the retained
  paired source. Entire normal object still has SHA 0d657a70...156bc8f, and all
  378 raw words remain exact. The proposed textual patch is independently
  asserted to alter only the target function (all preceding/following source
  lines are identical); scratch rollback line endings do not enter the patch.

Run `python scratchpad/p899_aiphysic_sld/propose_paired.py` for the updated,
hash-checked five-hunk proposal. It preserves the old receipts and writes only
new `paired_proposal_verified.json` / `paired_remaining_sld.json` reports.
`paired_candidate_sld_groups.json` holds the complete final native/current/raw
map. The same seven merge pairs remain at the two lane-offset/LaneIndex groups;
the final current attribution lines are 977 and 979. No split groups remain.

Final paired candidate SHA-256:
`f9ff11ba63d78e9c106111b3535bcc955fdd81f0f9db3008934aac829d6cec2d`.
Production remains the actual P898 source SHA 494c693f...5f7345; nothing landed
or published by this subagent.

## Actual P899 landing verification

Root subsequently applied the paired proposal. `landed.json`,
`landed_scope.json`, `landed_raw.json`, and `landed_verified.json` freshly verify
the actual production source with isolated outputs. Every prior baseline,
candidate and rejected experiment remains preserved.

Actual source SHA-256:
`28e7cef69f9aa8dcb00a9cfa17b0e5180195c24863816d15ac040b91d0773aa4`.
It differs from the paired scratch candidate only in line endings: 94920 versus
94909 bytes, with 1740 versus 1729 CRLF endings and 1970 LF endings on both sides.
The full source content is identical after comparing CRLF/LF representations.
All eight actual include-closure header hashes remain unchanged.

Actual object SHA-256:
`f0e2531e355fee1f87a628bd7ad44e5f14c4bb17362df7fa6a787c071b25f2dd`.
`verify_landed.py` proves the complete object differs from the paired scratch
object only by its single exact doubled-backslash C++ STT_FILE pathname. Every
other ordered symbol, payload/storage/header/schema and ordered relocation is
identical. The generic scope probe's literal-object flag remains false only for
that path difference; `landed_verified.json` is the combined strict acceptance.

Actual path: 42/42 PASS, all branches exact, all four native scopes and 14 homes
exact, all 41 neighbor contracts unchanged, 378/378 raw words exact, **7 merges /
0 splits**, zero new bad pairs. No production files or normal build outputs were
modified by this independent validation; publication remains root-owned.
