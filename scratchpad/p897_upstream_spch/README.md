# P897 upstream SPCH integration receipt

2026-09-09. Bounded integration review only, not a new matching campaign.
The parent performed the actual fast-forward; this agent did no checkout,
merge, commit, push, production-source edit or normal-build-output write.
All compilations and comparisons here use isolated outputs.

## Pinned incoming state and include closure

Reviewed `acbe34775f4e5dfce7e93d2ec25d515c61416e66` through
`7728c5ea6ca9cc21e8aff19b18292da04fcce03c`:

- c652c79a: sample descriptor/offset-helper/source-shape recovery.
- 373adb47: typed choice record and CHOICE/PICK retirement.
- 7728c5ea: typed sentence-choice record and its interior chosen field.

The incoming diff touches exactly nine files in spchpsxz. No local edit
overlapped them when frozen. The closure is **32 source/header files and11
translation units**: all9 spchpsxz C units plus base/USA Speech C++ units,
whose `speech_externs.h` includes the SPCH umbrella. `closure.json` records
every include edge and frozen input hash.

Unchanged closure files were copied byte-for-byte. Incoming files were staged
with `git show` plus `apply_patch` and verified against the pinned commit's
exact UTF-8 text (only standard newline decoding). An initial patch-generation
attempt used the Windows default text encoding and failed validation on an
emoji comment; no production content was involved. Explicit UTF-8 staging
corrected that harness issue.

## Compiler identities actually used

All9 C units use the current canonical `g_value:0` wiring, CC1PSX and the
ordinary maspsx pipeline: `-O2 -G0 -g1 -mgpOPT -fgnu-linker`. Base and USA
Speech use the current empty per-TU setting, hence ordinary CC1PLPSX `-O2
-G4`. An old Speech source comment mentions G8/conserve-space, but that is
not the current observed build wiring and was not substituted for it.
Exact preprocessing/compiler commands are retained per row in before.json,
after.json and actual.json. Source-only policy disables non-vendor per-function
interventions; no output instruction rewriting was added.

## Exact gates, including the manifest-count distinction

| TU | Scaffold manifest | Full tugate oracle-known symbols | Before / after / actual |
|---|---:|---:|---|
| spchbank |8|8|8/8 PASS |
| spchdata |6|6|6/6 PASS |
| spchevnt |14|16|16/16 PASS |
| spchinit |7|7|7/7 PASS |
| spchpick |27|27|27/27 PASS |
| spchrand |4|4|4/4 PASS |
| spchrslv |1|1|1/1 PASS |
| spchrule |9|9|9/9 PASS |
| spchsamp |2|2|2/2 PASS |
| base Speech |102|102|102/102 detailed PASS; existing branch discrepancy below |
| USA Speech |not reached|not reached|same pre-existing compile failure |

Thus the direct scaffold count is180/180, while the actual tugate census is
**182/182 =80 SPCH +102 Speech**. Only spchevnt adds two oracle-known static
copies, `VoxEvent_GetFilterLengthFlag` and `iSPCH_GetOffset16`. The wider census
was computed on the already-built objects using tugate's exact symbol loop,
without recompilation. `full_census.json` records all results and omissions
for all three stages. No expected count was silently loosened.

Every SPCH manifest branch count/distance is unchanged and clean. The base
Speech discrepancy is preserved exactly, not counted green:
`SubmitRequest__6Speechlll`,61 instructions, branch index6, ours distance-2
versus oracle+8. Its normal code is unchanged by the incoming headers.

USA Speech remains compile-broken at source714 and804: char* arguments to
`SPCH_ResolveData(VoxEventDat *)` and `SPCH_AddBank(VoxBank *)`. All compiler
diagnostics are exactly unchanged after only the known source-root prefix
normalization. It was neither repaired nor counted as a successful regional
build. No claim of full closure green is made.

## Whole-object and reference proof

Among the **10 compilable objects**, nine have no code/data/storage/relocation
change whatsoever. Their staged file hashes differ only because the exact
STT_FILE source pathname contains before versus after (C and C++ retain
different escaping, both checked explicitly).

`spchpick` has exactly three unlinked immediate changes, with no instruction
count, opcode/register or other payload change:

| Object .text byte offset | Before word | After word |
|---:|---|---|
|3804|ac400000|ac40000c|
|3876|ac620000|ac62000c|
|3884|8c420000|8c42000c|

The corresponding exact six HI16/LO16 relocation records at
3796/3804,3864/3876,3880/3884 change referent from
`DAT_80148448` (defined `.bss+12`) to `gSentenceChoice` (`.bss+0`) with the
compensating+12 addend. No relocation order, count or type changes.

Both labels remain exported and unchanged in the same **312-byte BSS run**:
gSentenceChoice+0, DAT_80148448+12, pick-sample pool+64 (100 bytes),
gChooseShort+164 (4 bytes), choice array+168 (144 bytes). The existing data-only
asm reservation block is unchanged. All other named and local symbols,
bindings, storage offsets, section schemas and data bytes are identical.

The verifier resolves only these six known references in memory and proves
the **entire text section equal** before/after. This holds at the retail base
8014843C and four HI16 signed-low carry boundary controls (10007FF0,
10007FF8,10008000,1000FFF8), so the proof is not accidental at one placement.
Each of the six reference instruction words matches raw retail before and
after,12 explicit receipts total. The fixed target is always BSS+12.
No compiled/linked output is modified by this diagnostic resolution.

The newly typed records pass22 actual-header target-compiler assertions:
VoxSample16 bytes, VoxChoice12 bytes/12 records144 bytes,
VoxSentenceChoice64 bytes with chosen+12 and eventArgs+16/48 bytes.
This proves layouts, not original identifier spelling. The upstream comments
describe access-census-derived names; this review does not promote them to
SYM-name or SLD/source-token proof. The generic recon/lib/eaclib.h still carries
old integer offset-helper declarations; no new call sites outside the covered
closure were found, and no prototype cleanup was added to this integration.

## Actual-path validation after the parent's fast-forward

`actual.json` was built from real recon/regiondiff source paths with actual
headers, not staged sources. `actual_integration_receipt.json` repeats all
before-to-incoming reference proofs and also directly compares every actual
successful object to the accepted staged-after object: all payloads and ordered
relocations identical; all ordered symbols identical except the exact STT_FILE
input path. All known-symbol gates/statuses and USA diagnostics are preserved.
The actual changed files are checked against the pinned git-show source text.

This leaves **zero new instruction, storage or reference regressions**, while
explicitly retaining the two pre-existing Speech issues. No unrelated matching
experiments or source changes were attempted.

## Required parent publication checks

1. Keep the pre-existing USA failure and SubmitRequest branch discrepancy in
   the backlog; neither invalidates preservation, neither is a green result.
2. Rebuild the actual10 compilable consumers using the full counts above;
   expected/oracle scaffolds remain unchanged.
3. Regenerate the real link and compare its code/data/global bindings to the
   frozen premerge ELF/map. Picker's three unlinked differences must disappear
   when the six relocations resolve to the same interior label address.
4. Preserve the whole-project verified PASS set and vtable/relink/source-policy
   gates before publication. Do not weaken a generic metadata checker by
   ignoring all text/relocation differences; the exact picker exception above
   is narrowly proved and can be audited independently.

Artifacts: closure.json; before/after/actual.json; full_census.json;
object_difference_inventory.json; integration_receipt.json;
actual_integration_receipt.json; layout_receipt.json; staged source trees and
isolated objects. Parent owns all integration/publication actions.
