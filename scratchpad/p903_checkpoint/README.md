# P903: native audio source restoration and publication checkpoint

2026-09-12. This checkpoint completes the P898-P903 local source-restoration
rounds. Publication was explicitly approved after the combined checks passed;
upstream integration and final commit/push evidence are recorded separately.
The full original-source/SYM/SLD/image goal remains active, not complete.

## P903 source results

| Target | Source improvement | Native SLD merge/split |
|---|---|---|
| AudioMus_PlaySong |pick removed; all9 scopes and3 declarations exact |0/44 ->0/0 |
| AudioCmn_TrafficSFX |fade removed; all15 ordered records and1 scope exact |49/46 ->0/10 |
| AudioCmn_SoundCar |4 gas-ramp locals,2 empty-asm sites,2 labels removed;18 ordinary and1 static native owners exact |37/319 ->37/261 |

PlaySong's paired real-member divisor and declaration placement remove the
modulo join carrier without a GNU block or single-call replacement. Repeated
GetRCnt reads remain real. Traffic uses the existing player for both patch
lookups and value-preserving widened index grouping, with original cast tokens
explicitly unproved. SoundCar uses direct gas-ramp array expressions and
branch-local stores; its early audio-off return restores gas's native depth.

The passing discarded-pitch-clamp experiment is not applied: bytes and SLD do
not recover its erased bound/shift. It would hide unknown source intent behind
another speculative expression. The old product fence remains visible debt.

## Verification before upstream integration

- **1093/1093 oracle-known symbol instances across48TUs PASS**. This is the
  protected closure, not whole-game unique-function coverage.
- **All518 normal objects and regenerated linked ELF/map literally unchanged**.
  Prior complete branch diagnostics, including the existing Speech anomaly,
  are preserved; no new branch discrepancy.
- Vtable, source-policy, both relink lanes, strict declaration audits and the
  CI-style objdiff report pass. P897 full-build lanes are inherited; this round
  uses fresh full-TU gates and exhaustive object/image equality.
- Actual PlaySong validation:23functions/206branches,160raw words/30references,
  all9 native scopes/3 declarations, all22 neighbors and real include closure.
- Actual combined AudioCmn validation:48functions/513branches,693raw words/
  90references,12 switch targets, static cobbleCount and129 Xfade bytes.
  Each source body/comments/debug graph is checked against its own accepted
  proposal; the46 unchanged functions retain their previous full contracts.
- SoundCar retains3 extra scopes and3 pre-existing asm sites. Traffic retains
  10 split pairs. These remain explicit, not hidden by metric exemptions.

The before-integration machine-readable summary is final_receipts.json.
Actual receipts: ../p903_audiomus_landed_20260912/landed_verified.json and
../p903_audiocmn_landed_20260912/combined_verification.json. Per-target frozen
paths and peer reviews are in ../p903_audiomus_playsong,
../p903_audiocmn_traffic and ../p903_audiocmn_soundcar.

## Totals and scope limits

Game/common is **1227 declaration-clean /7 extra /467 carriers** (473->467),
28type /28storage /0mapping review. Frontend/common remains780/48/438,
9type /9storage /3mapping. Missing mapped names are zero in both, but these
audits are not complete original-source proofs. Six carriers were actually
removed this round; none were renamed or excused as recovered.

An existing4-byte AudioCmn rodata packing discrepancy is now explicitly
receipted: the SoundCar table at native8005573C is .rodata+104 and needs fragment
base800556D4, while the loader literals require800556D0. All12 table targets
and the static data are independently verified, but per-fragment reference
evaluation does not prove one correct whole linked layout. Other inherited
GP/overlap and unresolved source/inline/statement work also remains open.

No production header/tool/flag change or postcompile instruction/debug-label
rewrite was added. User edits, including scratchpad/w85/o2.txt, are preserved
and excluded from the publication scope. Generated objects, preprocessor/
assembly output and failed source experiments are not publication candidates.

Actual P903 source hashes:

- audiomus.cpp db13b32a51dc8027ef28afbab0a4ab580c5730c4b33fd9f781b0e08dba74a137
- audiocmn.cpp 9b5e9dafeba7302ba7dd6744637dc31c188f24356e18e8ffb23cbede476c7539
- unchanged pre-integration ELF52800553415581618c04766bca85e3d943de8343f60b78c62ff7c62af9e32ae0

The user-approved publication covers P898-P903 changes in aiphysic.cpp,
audiotrk.cpp, audiomus.cpp, audiocmn.cpp and their explicit source-restoration
backlog/verification documentation. Incoming origin/main commits are preserved,
not overwritten. Consult the integration/publication receipt for final state.
