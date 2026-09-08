# P893 coordinated checkpoint, 2026-09-08

Retained source: the nine-file Camera native-slice graph described in
../p893_camera_slices/README.md.105 macro calls and39 invented alias references
now use native Trk_NewSlice fields. The pointer owner/storage is unchanged.
All seven actual production Camera objects remain literally identical to P892.
All266 function instances preserve line partitions;168 raw slice-reference
words and18 target-layout assertions pass. No new source names, macros, asm,
volatile, flags or compiler-output rewriting were introduced.

All three full build lanes completed without skipped/failed TUs. Fresh detailed
regression is665/665 PASS in31 protected base TUs, branch divergence0, source
receipt drift0. **All518 rebuilt objects are literally byte-identical to P892.**
The diagnostic linked ELF is also byte-identical, SHA256
`bf66bf489f36b0c7236bbcff855ed2480f36f1fe4a889c20b22bb3e033e0592e`.
Linker checks, both standing relink lanes, vtable indexing and source policy pass.

Strict frontend/common remains780 declaration-clean,48 extra locals,
438 source-only carriers,0 missing names,9type/9storage findings,3mapping reviews.
Game/common remains1228clean,6extra,478carriers,0missing,28type/28storage,
0mapping review. These declaration counters do not claim original source,
header visibility, inline scopes or native SLD partition completion.

Regional Camera AU's three manifest gates remain PASS. FR-DE/UK-ES-IT/UK-SW's
old3/2/2 misses are unchanged. JPN/USA lack Camera CHANGED oracle slices and
are verified by complete object identity and own-image raw references instead.
No absent regional oracle is advertised as PASS.

CI-style report generation passes: build/p893_report.binpb,321195 bytes,
SHA256 `2f64da5ebcadf1b920d8668e8a02ffed87abf40a1621fd45bfa97b3805ab19c3`.
The user scratchpad/w85/o2.txt retains SHA256
`d433425b806fc8abd1fa60c9f72a09f4c022bfd64a7fecf4df496931169e9546`.

The link still has851 known blob duplicates, prior GP-target/overlap/overrun
debt and permissive diagnostic assumptions. Byte preservation does not resolve
those debts or prove a bootable exact final image. Whole source/SYM/SLD goal
is incomplete and active. No commit/push is performed.

Fresh next evidence: ../p893_slice_alias_audit contains an isolated40/40 AI
native-slice proposal and complete inventory of the other five aliases;
../p893_post_locals contains ScreenPost native-locals/SLD investigation.
These proposals are not part of the P893 full-build snapshot. Replay's true
StatsTimer array restoration was separately retried in scratch only:
G4 gives14/16, G8 gives12/16 and branch regressions. Its false source-model
aliases remain open; see ../p893_replay_stats/README.md for current compiler
size/flag evidence and correction of the old "gp-relative Replay stores" claim.

Primary receipts: before.json, validation_commands.json, source_receipts.json,
final_receipts.json, relink.json and both strict audit reports. Earlier P892
receipts were not overwritten.
