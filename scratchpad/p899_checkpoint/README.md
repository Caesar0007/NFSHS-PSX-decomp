# P899: native local ownership and statement recovery

Verified local checkpoint, 2026-09-12. The full original-source/SYM/SLD goal
remains active and incomplete. P898 and P899 source changes are uncommitted.

## Applied improvements

| Function | Native SLD merged/split pairs before | After | Native ownership |
|---|---:|---:|---|
| AIPhysic_GetDesiredVector |77/184 |7/0 |4 scopes, 14 homes preserved |
| AudioTrk_Reset |20/60 |0/0 |Both i owners and 7 nonempty scopes now exact |
| AudioTrk_SoundTrack |115/132 |22/76 |All 25 local owners and 19 emitted scopes now exact |

There are no new bad SLD pairs. Every changed function remains code-PASS.
PreLoad's P898 2/5 SLD result and five native local owners remain preserved.

The AI recovery splits native call/result boundaries through the existing
sliceLookAhead, futureBend and goodVector locals. Real comma expressions group
the three native whole-vector operations; a conditional expression restores the
native clamp group. Evaluation order and all scalar types remain unchanged.
Failed extra shift-value staging was frozen and rejected. The seven remaining
pairs concern argument shift/call boundaries, not unnamed replacement locals.

Reset's scoped for-loops restore both native i owners. Removing its redundant
void return closes the last instruction-line split. Its existing unproved se
name remains explicitly open; no exemption is added. Fresh indexed trials and
actual compiler diagnostics explain their extra base arithmetic, but do not
prove an original source name or an unavoidable pointer variable.

SoundTrack's early guards, nested delay predicate and combined animation test
restore the native scope tree. The complete repeated type/null check is preserved
outside the animation body; it is not replaced with a cached value across calls.
Three related conditional distance expressions recover native lines 405/406/407.
Velocity components remain separate because their native SLD lines are distinct.
P898's curBack removal and its qualified widening expression are unchanged.

## Actual-source and byte verification

Independent actual-path checks use the production headers, not staged includes.
All input hashes are recorded. The main complete-source regression covers
**1,013 oracle-known symbol instances across 45 TUs**, all retaining PASS.
This is not a unique-function or whole-game percentage. Complete prior branch
diagnostics are preserved, including the known Speech SubmitRequest discrepancy.

All **518 normal objects**, the regenerated linked ELF and the entire map are
literally identical to P898. No production header, build tool or flag changes.
Actual raw checks cover AI378, Reset56, SoundTrack358 and protected PreLoad116
words; relocation evaluation happens only in verifier memory. No instruction
or debug-label output is rewritten. Six existing AddCustomObject source-label
records retain their exact PCs despite natural compiler label-number changes.

Linked ELF SHA256:
`52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0`.

Relink policy, vtable indexing, source-only policy and CI-style report generation
pass. As CPP-only edits with exhaustive object equality, this round inherits
P897's three full build lanes; it does not falsely claim three new full builds.

## Remaining work, not a completed-source claim

Reset is instruction-line-partition exact but still has an unproved source
cursor name and two missing empty inline records. SoundTrack retains 22/76
pairs and two missing zero-width CE40 records. AI retains seven merged pairs.
Original macro/operator/helper spellings and physical source lines are not
uniquely established by these checks. Do not manufacture empty blocks, names
or qualifiers to claim those records restored.

Strict counts remain game/common 1227 clean / 7 extra / 477 carriers,
28 type findings / 28 storage findings / 0 mapping review; frontend/common
780 clean / 48 extra / 438 carriers, 9 / 9 / 3 respectively. Neither cluster
has missing mapped SYM names. These declaration counters do not measure the
native ownership and statement improvements above. Broader source and data
layout debt remains, including the inherited known link overlaps and GP targets.

Receipts: final_receipts.json, regression_receipt.json, source_receipts.json,
strict reports and relink.json; detailed native/raw/actual-path records in
../p899_aiphysic_sld, ../p899_audio_reset, ../p899_soundtrack_scope,
../p899_soundtrack_expressions and ../p899_audio_landed_20260912.
Historical failed probes and the user's unrelated w85/o2.txt remain preserved.
No network operation, commit or push was performed for this checkpoint.
