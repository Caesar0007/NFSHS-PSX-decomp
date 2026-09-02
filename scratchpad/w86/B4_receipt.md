# W86-B4 receipt (regional rows) — 12/12 rows REGION-PASS

Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`
Iron rule honoured: for every candidate touched, EVERY manifest row hosted by
that candidate (mine + previously SEALED siblings) was re-gated in the SAME run.
No candidate was overwritten — the four pre-existing candidates were edited in
place; the two USA candidates that did not exist were seeded `cp -n` verbatim
from the base TU. No git, no tool/board/MANIFEST/memory edits (the board regen
`update_region_progress.py` is deliberately NOT run — board writes are
prohibited for this agent; the orchestrator should regen).

Every row in B4_rows.tsv turned out to be a word-level constant delta (the
AUDIT_LO16 hidden-changed class), not a logic delta — each was located from the
audit's exact base/region word, cross-checked against the measured seed diff,
and applied at source level (literal constants / enum values only; no devices,
no volatile, no asm, no pins).

## 1-3. USA `frontend/common/screencongrats` (candidate pre-existing, edited in place)
`regiondiff/recon/NFS4-R-USA/frontend/common/screencongrats.cpp`

| fn | before | delta applied | after |
|---|---|---|---|
| `DrawBackground__15tScreenCongrats` | FAIL 12 | money-block text words +1: `0x317->0x318` (MenuTextFade), `0x318->0x319` (WordX **and** WordY), `0x316->0x317`, `0x319->0x31a` (WordX **and** WordY) | REGION-PASS 541 |
| `DrawCongratsMessage__23tScreenPinkSlipCongrats` | FAIL 10 | `TextSys_Word(0x275)->0x276` in BOTH language branches, car word `+0x121->+0x122` in BOTH branches, `textState_Selected -> textState_Hilighted` | REGION-PASS 71 |
| `DrawCongratsMessage__25tScreenTournamentCongrats` | FAIL 6 | `r.w` 200 -> 420, `textState_Selected -> textState_Hilighted` at BOTH WordWrapText call sites | REGION-PASS 51 |

The two non-text-id deltas (420-wide RECT, Selected->Hilighted) were already
documented by this file's own sealed sibling rows (BeTheCop / TournamentTrophy) —
retail draws every congrats message hilighted in a 420 column.

**32B-5 (CSE-shared constant) check.** `0x318` and `0x319` each emit TWO separate
`li`s (WordX + WordY) and the audit lists each index twice — both sites patched;
`textState_Selected` appears twice in TournamentCongrats and both audit words
flip — both patched. Grep-verified that `0x316-0x319`, `0x275`, `+0x121` and the
`200` RECT width have no other use in the TU, so no semantic use was collaterally
moved. Instruction counts stayed exact on every fn (541/541, 71/71, 51/51),
which is the count-drift tell 32B-5 warns about.

Siblings re-gated same run: `DrawCongratsMessage__23tScreenBeTheCopCongrats` (48),
`DrawCongratsMessage__23tScreenTournamentTrophy` (185),
`GetShapeInfo__15tScreenCongratsRsT1PPcT3` (148) — all still REGION-PASS.

## 4-5. AU `game/common/camera` (candidate pre-existing, edited in place)
`regiondiff/recon/NFS4-R-AU/game/common/camera.cpp`

`Camera_NextMode__Fi` FAIL 2 and `Camera_SetMode__Fii` FAIL 2 were the same one
word: `TrsProj_SetProjection(0,0,0x140,0xf0)` -> `0x100` — the PAL builds project
to a 256-line screen, the NTSC base to 240; width unchanged. Both call sites
(the only two `0xf0`s in the TU) patched. -> REGION-PASS 237 / 133.
Sibling re-gated: `Camera_GetViewInfo__FiP17DRender_tCalcViewi` REGION-PASS 206.
DATA row on the same candidate re-gated: `Camera_gFlags` DATA-PASS (verify_data).

## 6. AU `frontend/psx/psxfront` (candidate pre-existing, edited in place)
`Quick_DD__Fiii` FAIL 2 -> the same PAL height word:
`Draw_DirectSetEnvironment(0,0,0x200,0xf0,...)` -> `0x100`. REGION-PASS 17.
Siblings re-gated: `DoTitleScreen__Fv` (66), `Init_RenderingEnvironment__Fv` (62).

## 7. JPN `game/psx/device` (candidate pre-existing, edited in place)
`Device_SetHardCodedKeys__Fv` FAIL 4 = two face-button re-bindings (the Japanese
confirm/cancel convention), decoded from the audit's `lui` words:
`Input_gHandler[0x9d]` `0x400003` (CROSS `0x0040<<16`) -> `0x200003` (CIRCLE), and
`Input_gHandler[0xb0]` `0x100003` (TRIANGLE) -> `0x400003` (CROSS). The `| 3` low
halves and all eight other entries unchanged; the two words live in different
registers so no `lui` is shared (count stayed 25/25). REGION-PASS 25.
Sibling re-gated: `Device_VerifyType__Fi` REGION-PASS 47.

## 8-11. USA `frontend/common/femenuoptions` (candidate CREATED, seeded verbatim)
`regiondiff/recon/NFS4-R-USA/frontend/common/femenuoptions.cpp` (`cp -n` of
`recon/frontend/common/femenuoptions.cpp`; no candidate existed for this
(unit, region) pair — the AU one is a different file and was not touched).

| fn | seed | delta applied | after |
|---|---|---|---|
| `DrawLeftFlare__FiiiRi` | FAIL 2 | `TextSys_WordX(0x1de) -> 0x1df` | REGION-PASS 87 |
| `Draw__29tMenuItemOnOffLeftRightChoiceiib` | FAIL 4 | ON/OFF pair `0x66/0x67 -> 0x67/0x68` | REGION-PASS 94 |
| `DrawOneSong__18tInsideBoxSongMenussssss` | FAIL 4 | ON/OFF pair `0x66/0x67 -> 0x67/0x68` | REGION-PASS 139 |
| `TransitionOn__17tUserNameMenuItem` | FAIL 2 | row-label base `i + 0x1fb -> i + 0x1fc` | REGION-PASS 141 |

CSE check: the `0x66/0x67` pair occurs in exactly two functions (verified by
grep + enclosing-function check) — both are audit-listed changed rows, so no
un-changed consumer shares the constants; `tMenuItemDisplayLeftRightChoice::Draw`
(the neighbouring, unchanged Draw) does NOT use them. `0x1de` and `0x1fb` are
each unique in the TU. Counts exact throughout.

## 12. USA `frontend/common/screentracks` (candidate CREATED, seeded verbatim)
`Initialize__18tScreenTrackSelect` FAIL 2 ->
`SetAvailableText(&fVideoWall,0xf8,...)` -> `0xf9` (the same +1 string-table
shift; the neighbouring `SetAvailableIcon` indices sit below the insertion point
and are unchanged). REGION-PASS 111. Sole row on that candidate.

## Cross-row observation (for the wave)
Every USA frontend row in this batch is one retail string-table INSERTION: the
whole USA text-id range at/after ~0x66 shifts by exactly +1 (0x66, 0xf8, 0x121,
0x1de, 0x1fb, 0x275, 0x316-0x319 all +1), while indices below it (0x40 money
word, the SetAvailableIcon ids) are untouched. The two PAL rows (AU camera,
AU psxfront) are the 240->256 display-height change, and the JPN row is the
face-button swap — three distinct, self-consistent regional causes.
