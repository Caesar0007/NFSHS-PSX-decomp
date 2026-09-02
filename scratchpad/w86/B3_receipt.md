# W86-B3 receipt — regional row sealing

**ALL 9 ASSIGNED ROWS SEALED (REGION-PASS, count-exact).** No base-tree edits, no
tool/board/MANIFEST/memory edits, no git, no asm/volatile/pins. Every candidate
that already existed was edited IN PLACE and every previously-SEALED fn it hosts
was re-gated (all still PASS).

Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`
(`VA_MAX=60` env used to print full diff lists — read-only use of the tool.)

| # | region | unit | function | before | after |
|---|---|---|---|---|---|
| 1 | USA | frontend/common/fetracks | TextValue__18tListIteratorTrack7tPlayer | TODO (seed FAIL 2) | **REGION-PASS 16/16** |
| 2 | AU | frontend/common/fescreen | DisplayLoadingText__7tScreen | FAIL 8 | **REGION-PASS 80/80** |
| 3 | JPN | frontend/psx/psxfront | PSXFront_AllocateDrawMemory__Fv | TODO (seed FAIL 6) | **REGION-PASS 29/29** |
| 4 | AU | game/psx/hrzsku | Hrz_BuildSky__Fv | TODO (seed FAIL 4) | **REGION-PASS 458/458** |
| 5 | AU | game/psx/hrzsku | Sky_RenderStars__FP13Draw_SkyCachei | TODO (seed FAIL 4) | **REGION-PASS 111/111** |
| 6 | AU | frontend/common/fedialog | CalculateDimensions__12tDialogYesNo | TODO (seed FAIL 2) | **REGION-PASS 46/46** |
| 7 | AU | frontend/common/fedialog | CalculateDimensions__20tDialogMessageString | TODO (seed FAIL 2) | **REGION-PASS 133/133** |
| 8 | AU | frontend/common/fedialog | CalculateDimensions__11tDialogHelp | TODO (seed FAIL 20) | **REGION-PASS 359/359** |
| 9 | USA | frontend/common/screentournselect | DrawBackground__18tScreenTournSelect | FAIL 28 | **REGION-PASS 415/415** |

Every row turned out to be the pure-constant class (no logic delta anywhere in
this batch); all nine were count-exact on the unedited seed, which is the
signature. Two distinct constant families appeared:
* **retail string-table +1 shift** (rows 1, 2, 8, 9) — every literal text id in
  the function moves +1, *including* id arithmetic done on a register.
* **PAL / display-geometry constants** (rows 2, 4, 5, 6, 7) and one
  **memory-budget** constant (row 3) — genuine per-region tuning values, not a
  table shift.

---

## 1. TextValue__18tListIteratorTrack7tPlayer (USA, 16 words) — SEALED
Candidate CREATED (none existed): `regiondiff/recon/NFS4-R-USA/frontend/common/fetracks.cpp`
= verbatim copy of `recon/frontend/common/fetracks.cpp`.
Seed gate: `FAIL 2 (ours 16 / oracle 16)` — `addiu v0,v0,213` vs `214`
(AUDIT_LO16 insn 15 `244200d5` -> `244200d6`).
Edit: the text-id base of the return expression `0xd5` -> `0xd6`.
32B-5 check: single occurrence in the TU, no CSE-shared `li`.
Result: **REGION-PASS (16 insns)**. Only row on this candidate.

## 2. DisplayLoadingText__7tScreen (AU, 80 words) — SEALED
Candidate ALREADY EXISTED (hosts SEALED `GoNonInterlaced__7tScreen`) — edited in
place, nothing overwritten.
Seed gate: `FAIL 8 (ours 80 / oracle 80)` = 4 constants: `li a0,637` x2 -> 638,
`li a2,220` x2 -> 228 (AUDIT_LO16 insns 30/32/40/45).
Edits, both inside the 2-iteration loop body:
* text id `0x27d` -> `0x27e` (the +1 shift) — appears twice
  (`FETextRender_MenuTextPositionedJustify` and `TextSys_Word` inside
  `PSXDrawSquare`);
* loading-text y `0xdc` (220) -> `0xe4` (228) — the 256-line PAL field, also
  twice.
32B-5 check: retail emits a separate `li` per site (the diff shows two of each),
so both source occurrences shift together — no shared-`li` pair to break.
Re-gate of the whole candidate: `GoNonInterlaced__7tScreen: REGION-PASS (51)`
(unchanged) + `DisplayLoadingText__7tScreen: **REGION-PASS (80)**`.

## 3. PSXFront_AllocateDrawMemory__Fv (JPN, 29 words) — SEALED
Candidate CREATED: `regiondiff/recon/NFS4-R-JPN/frontend/psx/psxfront.cpp`
(verbatim copy of the base TU).
Seed gate: `FAIL 6 (ours 29 / oracle 29)` — `ori a1,a1,14464` x3 -> `20864`
(AUDIT_LO16 insns 7/13/22 `34a53880` -> `34a55180`; the `lui $a1,0x1` halves are
identical, so the constant is `0x13880` = 80000 -> `0x15180` = 86400).
Edit: the per-view draw-memory budget `80000` -> `86400` at all three sites
(`reservememadr("ps0"/"ps1", …)` + `Draw_SetViewMemBudget`). Not a text shift —
a genuine JPN tuning value (+6400 bytes per view).
Result: **REGION-PASS (29 insns)**. Only row on this candidate.

## 4/5. Hrz_BuildSky__Fv + Sky_RenderStars__FP13Draw_SkyCachei (AU, 458 + 111) — SEALED
Candidate CREATED: `regiondiff/recon/NFS4-R-AU/game/psx/hrzsku.cpp` (verbatim
copy of the base TU; it hosts both rows).
Seed gate: `Hrz_BuildSky FAIL 4 (458/458)` — `li s0,120`->128, `li s0,60`->64;
`Sky_RenderStars FAIL 4 (111/111)` — the same pair in `$s1`
(AUDIT_LO16 `24100078/2410003c` and `24110078/2411003c`).
Both functions carry the identical two-line idiom:
`X = 0x78; if (HRZ_GAMESETUP_COMM_MODE == 1) X = 0x3c;` — the sky's vertical
centre (`otz_old` in BuildSky, `pshift` in RenderStars), i.e. half of the field
height and half again for split-screen link mode.
Edit: `0x78/0x3c` -> `0x80/0x40` in both = the 256-line PAL field. Purely a
display-geometry constant, no logic delta.
32B-5 check: `0x3c` also occurs in `Hrz_BuildSky` as a GPU primitive code
(`prim->code = 0x3c`) which retail does NOT shift — only the two `li`s that feed
the centre variable were touched, and the gate confirms nothing else moved.
Result: **REGION-PASS 458/458 and 111/111** (both rows of the candidate).

## 6/7/8. fedialog CalculateDimensions x3 (AU, 46 + 133 + 359) — SEALED
Candidate CREATED: `regiondiff/recon/NFS4-R-AU/frontend/common/fedialog.cpp`
(verbatim copy of the base TU; hosts all three rows).
(The JPN sibling candidate is a *different* body — the Japanese build drops the
whole `helpcontrollers` fan-out — so nothing was copied from it; AU is the base
body plus constants.)
Seed gate: YesNo `FAIL 2 (46/46)` and MessageString `FAIL 2 (133/133)`, both
`li v0,240` -> `256`; Help `FAIL 20 (359/359)`, ten `li a1,<id>` each +1.
Edits:
* **tDialogHelp::CalculateDimensions** — all ten `AddItem` text ids +1:
  `0x59->0x5a, 0x52->0x53, 0x53->0x54, 0x56->0x57, 0x55->0x56, 0x54->0x55,
  0x57->0x58, 0x58->0x59`, and BOTH `AddItem(0x56,8)` arms -> `0x57`.
  32B-5 check: the source has exactly ten id sites and the audit reports ten
  changed words — a 1:1 site/word match, so no `li` is shared between two
  semantic uses; every site shifts.
* **the shared `0xf0` screen height -> `0x100`** in three places: the two
  `(0xf0 - height) / 2` centring expressions in
  `tDialogMessageString::CalculateDimensions` and `tDialogYesNo::Calculate-
  Dimensions`, plus the one inside the file-static inline
  `DialogHelpPositionAndClamp` (which is what the *Help* row's last residual
  `li v0,240` turned out to be — it is inlined into Help only, so changing the
  helper affects no other gated fn).
Result: all three **REGION-PASS (46 / 133 / 359)**.

## 9. DrawBackground__18tScreenTournSelect (USA, 415 words) — SEALED
Candidate ALREADY EXISTED (hosts SEALED `DrawForeground__18tScreenTournSelect`)
— edited in place.
Seed gate: `FAIL 28 (ours 415 / oracle 415)` = 14 constants; the full list was
read with `VA_MAX=60` (the tool prints only 12 lines by default — worth knowing,
the visible 6 pairs are NOT the whole delta).
The 14 words are the +1 string-table shift, in three forms:
* plain ids, all sites: `0x7b` x3, `0x99` x4, `0x9a` x3 (each `li` distinct —
  source-site count matches the audit word count exactly, 32B-5 clear);
* an id computed with a register: `TextSys_Word(i + 0x2d4)` -> `+ 0x2d5`
  (`addiu a0,s1,724` -> `725`) and `0x3db` -> `0x3dc`;
* **id ARITHMETIC that shifts the OTHER way**: `j = i - 0x367;` -> `- 0x368`
  (`addiu s1,s2,-871` -> `-872`) with `j += 0x37a;` -> `+= 0x37b`. `i` here is a
  `TextValue()` result, which is ALREADY +1 in the regional build, so the
  subtraction constant must ALSO be +1 to keep `j` numerically identical, and the
  later addend then carries the +1 into the final id. A naive "+1 everything"
  would have got the subtraction backwards; the pair was derived from the
  oracle's own words, and the semantics check out (`j_final = i_base + 0x14`
  = base's `i_base + 0x13`, +1).
The three-form structure is the general lesson for this class: **a +1 text-shift
is not always +1 in the source — an id held in a register makes one of the
constants move the opposite way.**
Re-gate of the whole candidate: `DrawForeground: REGION-PASS (42)` (unchanged) +
`DrawBackground: **REGION-PASS (415)**`.

---

## Notes for the orchestrator
* `regiondiff/tools/update_region_progress.py` was **NOT** run — the W86 GUIDE
  prohibits board edits and concurrent row agents would race on
  `REGION_PROGRESS.txt`. Nine rows are ready to flip TODO/FAIL -> SEALED:
  USA fetracks TextValue; AU fescreen DisplayLoadingText; JPN psxfront
  PSXFront_AllocateDrawMemory; AU hrzsku Hrz_BuildSky + Sky_RenderStars; AU
  fedialog CalculateDimensions x3; USA screentournselect DrawBackground.
* Regression check done manually and per-candidate instead: both pre-existing
  candidates I touched were re-gated over ALL their manifest rows (fescreen AU:
  GoNonInterlaced still PASS; screentournselect USA: DrawForeground still PASS).
  The four candidates I created host only my own rows.
* Candidates created this session (each a verbatim base-TU copy + the regional
  constants, nothing else): `NFS4-R-USA/frontend/common/fetracks.cpp`,
  `NFS4-R-JPN/frontend/psx/psxfront.cpp`, `NFS4-R-AU/game/psx/hrzsku.cpp`,
  `NFS4-R-AU/frontend/common/fedialog.cpp`.
* Adjacent rows NOT in my assignment that the same constants very likely close
  (a cheap follow-up for whoever owns them): **USA**
  `CalculateDimensions__11tDialogHelp` (359 words, TODO — the USA fedialog
  candidate needs the same ten `AddItem` +1 shifts; whether its `0xf0` moves is
  region-specific and must be measured), and **USA**
  `DisplayLoadingText__7tScreen` (80 words, TODO — AUDIT_LO16's USA section will
  say whether the y constant shifts as well as the text id).
