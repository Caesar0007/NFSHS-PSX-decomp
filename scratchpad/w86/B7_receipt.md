# W86-B7 receipt вЂ” regional row sealing

Agent: W86-B7. Rows: `scratchpad/w86/B7_rows.tsv` (18 rows).
Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`

## Row status

| # | region | unit | function | before | after |
|---|---|---|---|---|---|
| 1 | USA | frontend/common/femenudefs | AskTheUserToSaveTheGame__Fv | FAIL 6 | **REGION-PASS 30** |
| 2 | USA | frontend/common/femenudefs | GenericMenuLoadGame__Fi | FAIL 2 | **REGION-PASS 37** |
| 3 | USA | frontend/common/femenudefs | GenericMenuSaveGame__Fi | FAIL 4 | **REGION-PASS 71** |
| 4 | USA | frontend/common/femenudefs | MenuExtended_BuyCar__FR12tMenuCommand | FAIL 10 | **REGION-PASS 85** |
| 5 | USA | frontend/common/femenudefs | MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand | FAIL 8 | **REGION-PASS 76** |
| 6 | USA | frontend/common/femenudefs | MenuExtended_ExitTourney__FR12tMenuCommand | FAIL 6 | **REGION-PASS 36** |
| 7 | USA | frontend/common/femenudefs | MenuExtended_GoTo2PlayerRace__FR12tMenuCommand | FAIL 6 | **REGION-PASS 83** |
| 8 | USA | frontend/common/femenudefs | MenuExtended_GoToCarSelect__FR12tMenuCommand | FAIL 2 | **REGION-PASS 229** |
| 9 | USA | frontend/common/femenudefs | MenuExtended_GoToRace__FR12tMenuCommand | FAIL 8 | **REGION-PASS 87** |
| 10 | USA | frontend/common/femenudefs | MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand | FAIL 8 | **REGION-PASS 91** |
| 11 | USA | frontend/common/femenudefs | MenuExtended_GoToTournTrackInfo__FR12tMenuCommand | FAIL 8 | **REGION-PASS 90** |
| 12 | USA | frontend/common/femenudefs | MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand | FAIL 4 | **REGION-PASS 69** |
| 13 | USA | frontend/common/femenudefs | MenuExtended_PurchaseUpgrade__Fi | FAIL 8 | **REGION-PASS 80** |
| 14 | USA | frontend/common/femenudefs | MenuExtended_SellCar__FR12tMenuCommand | FAIL 8 | **REGION-PASS 86** |
| 15 | USA | frontend/common/femenudefs | PinkSlipsPreSave__Fv | FAIL 6 | **REGION-PASS 50** |
| 16 | USA | frontend/common/screentrophyinfo | DrawBackground__17tScreenTrophyInfo | TODO (FAIL 16 measured) | **REGION-PASS 298** |
| 17 | AU | game/psx/loading | Loading_DrawLoadingScreen__Fv | TODO (FAIL 4 measured) | **REGION-PASS 82** |
| 18 | USA | game/common/audiomus | AudioMus_SysStartUp__FiiPc | FAIL 2 | **REGION-PASS 62** |

**18 / 18 rows SEALED. 0 regressions anywhere.**

---

## Block 1 вЂ” femenudefs USA (rows 1-15) : ALL 15 SEALED

Candidate (pre-existing, EDITED IN PLACE, never overwritten):
`regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp`

### Measure-first
Every one of the 15 rows was **count-exact** (ours N / oracle N) with diffs consisting
*only* of `li <reg>,<K>` vs `li <reg>,<K+1>` вЂ” the retail **+1 text-id shift** class.
The per-instruction words in `regiondiff/AUDIT_LO16.txt` (NFS4-R-USA section) matched
the gate diff list exactly (`24040331 -> 24040332` = `li a0,0x331 -> 0x332`, etc.), and
`FAIL n == 2 x AUDIT words` on every row (the audit report truncates its per-fn listing
at 4 entries вЂ” BuyCar's 5th word came from the gate, not the audit).

### The shift is NOT blanket вЂ” it is per-id
Confirmation the audit had to drive the edit rather than a global `+1` sweep:
`MenuExtended_GoToTwoPlayerSingleRace`'s `TextSys_Word(0x42)` is **unchanged** in retail
while the `yesnowords` pair in the same statement block shifts. Only the ids the gate/audit
name were touched.

### 32B-5 (CSE-shared-constant) trap вЂ” checked, did not fire here
The suspicious shape is present: within a single function the shifted value of one site
equals the *pre-shift* value of another site (`GoToRace` 0xf1/0xf2/0xf3 -> 0xf2/0xf3/0xf4;
`GoToSpecialEventTrackInfo` 0xf6/0xf7 -> 0xf7/0xf8; every `yesnowords` pair 0x321/0x322 ->
0x322/0x323). Because the shift is *uniform* across all sites of each function, the values
stay pairwise distinct after the shift, so no `li` merges and the counts stayed exact
(verified: all 15 gate to REGION-PASS at their original instruction counts).
The one genuine multi-use constant, `MenuExtended_SetUpgradeDialogWords`'s
`yesnowords[0]/[1] = 0x321/0x322` (a `static inline` helper), was checked for other
callers first вЂ” it is called **only** from `MenuExtended_PurchaseUpgrade`, so shifting it
could not disturb another row.

### Edits (44 literals, all in existing statements; no structural change)
Line-targeted, each asserted to match its expected old text before rewriting:

* `MenuExtended_GoToTwoPlayerSingleRace` L270/271: `yesnowords[0/1]` 0x321/0x322 -> 0x322/0x323
* `AskTheUserToSaveTheGame` L391 `TextSys_Word(0x331)`->0x332; L392/393 0x321/0x322 -> 0x322/0x323
* `MenuExtended_GoToCarSelect` L487 `TextSys_Word(0xeb)`->0xec
* `GenericMenuSaveGame` L783 `SetMessage(0x27e)`->0x27f; L792 `TextSys_Word(0x282)`->0x283
* `PinkSlipsPreSave` L847 `TextSys_Word(0x273)`->0x274; L848/849 0x321/0x322 -> 0x322/0x323
* `MenuExtended_GoToRace` L980 0xaa->0xab; L988 0xf1->0xf2; L997 0xf2->0xf3; L1010 0xf3->0xf4
* `MenuExtended_GoTo2PlayerRace` L1052 0xaa->0xab; L1063 0xf3->0xf4; L1078 0xf2->0xf3
* `MenuExtended_GoToTournTrackInfo` L1135 0xf6->0xf7; L1142 0xf7->0xf8; L1143 `SetChoices(0x322,0x321,0)`->`(0x323,0x322,0)`
* `MenuExtended_GoToSpecialEventTrackInfo` L1204 0xf6->0xf7; L1211 0xf7->0xf8; L1212 `SetChoices(0x321,0x322,0)`->`(0x322,0x323,0)`
* `MenuExtended_SellCar` L1466 0xa5->0xa6; L1467 `SetChoices` 0x321/0x322 -> 0x322/0x323; L1478 `DisplayMessage(0xa9)`->0xaa
* `MenuExtended_BuyCar` L1563 0xa4->0xa5; L1564/1565 0x321/0x322 -> 0x322/0x323; L1576 0xa7->0xa8; L1580 0x4b->0x4c
* `MenuExtended_PurchaseUpgrade` (via `MenuExtended_SetUpgradeDialogWords`) L1601/1602 0x321/0x322 -> 0x322/0x323; L1671 0xa6->0xa7; L1684 `DisplayMessage(0xa8)`->0xa9
* `GenericMenuLoadGame` L1830 `mc->message = 0x27d`->0x27e
* `MenuExtended_ExitTourney` L2534/2535 0x321/0x322 -> 0x322/0x323; L2538 0x9d->0x9e
* `MenuExtended_ExitPinkSlipsEarly` L2598/2599 0x321/0x322 -> 0x322/0x323; L2601 0x9d->0x9e; L2608 `TextSys_Word(0x297)`->0x298

Explicitly **not** touched: the `tGlobalMenuDefs` ctor initializer list (L3159/3185-3189/3430
carry 0xa4/0xaa/0x9d as *menu item* ids, not text ids вЂ” that row is SEALED at 3207 insns and
stayed SEALED).

### Iron rule вЂ” whole-candidate re-gate after the edit
```
AskTheUserToSaveTheGame__Fv:                             REGION-PASS (30 insns)
GenericMenuLoadGame__Fi:                                 REGION-PASS (37 insns)
GenericMenuSaveGame__Fi:                                 REGION-PASS (71 insns)
MenuExtended_BuyCar__FR12tMenuCommand:                   REGION-PASS (85 insns)
MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand:       REGION-PASS (76 insns)
MenuExtended_ExitTourney__FR12tMenuCommand:              REGION-PASS (36 insns)
MenuExtended_GoTo2PlayerRace__FR12tMenuCommand:          REGION-PASS (83 insns)
MenuExtended_GoToCarSelect__FR12tMenuCommand:            REGION-PASS (229 insns)
MenuExtended_GoToRace__FR12tMenuCommand:                 REGION-PASS (87 insns)
MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand:REGION-PASS (91 insns)
MenuExtended_GoToTournTrackInfo__FR12tMenuCommand:       REGION-PASS (90 insns)
MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand:  REGION-PASS (69 insns)
MenuExtended_PurchaseUpgrade__Fi:                        REGION-PASS (80 insns)
MenuExtended_SellCar__FR12tMenuCommand:                  REGION-PASS (86 insns)
PinkSlipsPreSave__Fv:                                    REGION-PASS (50 insns)
-- previously SEALED rows of the same candidate, re-gated, all still PASS --
MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand:        REGION-PASS (173 insns)
MenuExtended_LoadGame__FR12tMenuCommand:                 REGION-PASS (54 insns)
__15tGlobalMenuDefs:                                     REGION-PASS (3207 insns)
```
15 rows FAIL -> SEALED, 0 regressions.

---

## Block 2 вЂ” audiomus USA (row 18) : SEALED

Candidate (pre-existing, EDITED IN PLACE): `regiondiff/recon/NFS4-R-USA/game/common/audiomus.cpp`

### Measure-first
`AudioMus_SysStartUp__FiiPc: FAIL 2 diffs (ours 62 / oracle 62)` вЂ” `li a1,344` vs `li a1,340`
(0x158 vs 0x154). NOT a text-id row: `AUDIT_LO16` lists 5 words for this fn, but the others
(`sw v0,0x70(v1)` -> `0x6c`, `addiu a0,a0,0xac` -> `0xa8` x2) are struct-field displacements
that the candidate ALREADY reproduces вЂ” its header block declares a regional
`AudioMus_tMusicGlobalsRegional` in which retail's struct has **lost the `failby` field**
(base +0x1C), shifting every later member down 4 bytes. The single surviving diff was the
one place that layout change leaks out as a plain constant.

### Edit (1 literal)

    - AudioMus_g = reservememadr("Music Globals",0x158,0);
    + AudioMus_g = reservememadr("Music Globals",0x154,0);

i.e. `sizeof(AudioMus_tMusicGlobals)` 0x158 -> 0x154, consistent with the regional layout
already declared at the top of the TU. A comment naming the cause was added above the call.

### Iron rule вЂ” whole-candidate re-gate (all 22 audiomus USA rows)
`AudioMus_SysStartUp__FiiPc: REGION-PASS (62 insns)` plus the 21 previously-SEALED rows
(Fail / QueueRequestedSong / Server / AutoVolume / Buffered / BuildPattern / BuildPlayList /
DriverCleanUp / DriverStartUp / GetCurrentSong / GetSongList / InitDriverGlobals /
InitGlobals / PlaySong / RefreshStatus / SetCurrentSongInfo / StopSong / SwitchSong /
SysCleanUp / Threshold / Volume) вЂ” **22/22 REGION-PASS**, 0 regressions.

---

## Block 3 вЂ” screentrophyinfo USA (row 16) : SEALED

Candidate **newly seeded** (no candidate existed; nothing was overwritten):
`regiondiff/recon/NFS4-R-USA/frontend/common/screentrophyinfo.cpp`
= verbatim copy of the base TU `recon/frontend/common/screentrophyinfo.cpp`.

### Measure-first (unedited seed)
`DrawBackground__17tScreenTrophyInfo: FAIL 16 diffs (ours 298 / oracle 298)` вЂ” count-exact,
8 words, all `+1`. (`VA_MAX=60` in the environment raises the gate's 12-line diff cap; the
audit report only listed the first 4 of the 8.)

| # | ours | region | source site |
|---|---|---|---|
| 1 | `addiu a0,a0,833` | 834 | `TextSys_Word(... + 0x341)` |
| 2 | `addiu s0,s5,890` | 891 | `tournID + 0x37a` (2 spellings, CSE'd to one insn) |
| 3 | `li a1,987` | 988 | `MenuTextPositionedJustifyFade(..,0x3db,..)` |
| 4 | `addiu s2,s5,928` | 929 | `tournID + 0x3a0` (3 spellings, one insn) |
| 5 | `li a1,989` | 990 | `..,0x3dd,..` |
| 6 | `addiu s2,s5,909` | 910 | `tournID + 0x38d` (3 spellings, one insn) |
| 7 | `li a1,988` | 989 | `..,0x3dc,..` |
| 8 | `addiu a0,s5,871` | 872 | `tournID + 0x367` |

### The trap that DID fire here (32B-5 family, sequential-edit variant)
The three label ids form a **contiguous run**: `0x3db -> 0x3dc`, `0x3dc -> 0x3dd`,
`0x3dd -> 0x3de`. A naive per-constant sequential rewrite double-shifts `0x3dc` (the
`0x3db -> 0x3dc` rule feeds the `0x3dc -> 0x3dd` rule). Applied as a **single simultaneous
regex substitution** over all 8 ids instead. Also checked: none of the 8 ids occur outside
`DrawBackground` in this TU (GetShapeInfo's constants are 0x20 / 0xb / "zSTI"), so the
whole-file substitution touched exactly the 13 occurrences of the 8 target ids.

### Gate
`DrawBackground__17tScreenTrophyInfo: REGION-PASS (298 insns) [NFS4-R-USA]`
(re-gated again after adding the REGIONAL-DELTA header comment вЂ” still PASS.)

---

## Block 4 вЂ” loading AU (row 17) : SEALED

Candidate **newly seeded** (dir `regiondiff/recon/NFS4-R-AU/game/psx/` created; nothing
overwritten): `regiondiff/recon/NFS4-R-AU/game/psx/loading.cpp` = verbatim copy of
`recon/game/psx/loading.cpp`.

### Measure-first (unedited seed)
`Loading_DrawLoadingScreen__Fv: FAIL 4 diffs (ours 82 / oracle 82)` вЂ” `li a1,240` vs
`li a1,256`, twice (AUDIT_LO16 AU insn 32 / insn 68, `240500f0 -> 24050100`).

### Identification вЂ” NOT a text-id row, a PAL screen-height row
Both sites are the second argument of `Draw_SetEnvironment(0x200, 0xf0, ...)` = the display
height. 0xf0 = 240 (NTSC) -> 0x100 = 256 (PAL). The row group is
`AU+FR-DE+UK-ES-IT+UK-SW` вЂ” exactly the four PAL regionals, with the USA/JPN NTSC builds
absent, which independently confirms the reading. The same 0xf0 -> 0x100 constant appears in
the audit for `CalculateDimensions__11tDialogHelp`,
`CalculateDimensions__20tDialogMessageString`, `CalculateDimensions__12tDialogYesNo` and
`Draw__12tMenuOptions` in the PAL sections вЂ” one coherent display-geometry class, not the
string-table shift.

### Edit (2 literals + a delta comment)

    - Draw_SetEnvironment(0x200,0xf0,1,0,1,0,0,0);
    + Draw_SetEnvironment(0x200,0x100,1,0,1,0,0,0);
    - Draw_SetEnvironment(0x200,0xf0,0,1,0,0,0,0);
    + Draw_SetEnvironment(0x200,0x100,0,1,0,0,0,0);

`Loading_UpdateLoadingScreen` / `Loading_GetInitialMemory` untouched (not corpus rows; the
base bodies stand).

### Gate
`Loading_DrawLoadingScreen__Fv: REGION-PASS (82 insns) [NFS4-R-AU]`

---

## Rules compliance

* No git operations.
* No edits to `tools/*.py`, `regiondiff/tools/*.py`, `MANIFEST.tsv`, `REGION_PROGRESS.txt`,
  boards, or any memory file. (`REGION_PROGRESS.txt` regeneration is left to the
  orchestrator per the W86 prohibition on board edits вЂ” the 18 rows above are all
  gate-verified REGION-PASS and will flip to SEALED on the next
  `update_region_progress.py` run.)
* No base-tree edits: everything lives under `regiondiff/recon/`.
* No existing candidate overwritten вЂ” femenudefs and audiomus were edited in place and
  their previously-SEALED rows were re-gated; the two new candidates are for
  (unit, region) pairs that had no candidate at all.
* Source-level C/C++ only. **No new volatile, no new asm, no pins.** All 47 edits are plain
  integer literals in existing statements, plus documentation comments. (The femenudefs and
  audiomus candidates carry pre-existing devices from earlier waves вЂ” an
  `__asm__("" : "+r"(screenState))` launder in `MenuExtended_GoToTwoPlayerSingleRace`, and a
  volatile-view read plus a launder in `AudioMus_SetCurrentSongInfo`. Those sit inside rows
  that were already SEALED and were left exactly as found; re-pricing them is the D-agents'
  brief, not this row wave.)
* No structural / reshaping change anywhere вЂ” every row was already count-exact before the
  edit and stayed at its identical instruction count after it.

## Reusable notes for the wave

1. **`VA_MAX=<n>` env var** raises `verify_region.py`'s 12-line diff cap (default 12). Needed
   for any row with more than 6 changed words вЂ” and `AUDIT_LO16.txt` truncates its own
   per-function listing at 4 entries, so for a fn reported as "8 words" neither source shows
   you all of them by default. `FAIL n == 2 x AUDIT words` is a reliable cross-check that you
   have the complete set.
2. **Sequential-edit double-shift** is a real, silent failure mode whenever the shifted ids
   form a run (`K -> K+1` where `K+1` is itself a shift target). Always substitute the whole
   id set in ONE pass. This is the edit-side twin of 32B-5's CSE-side blindness.
3. **Not every regional constant delta is the string-table +1.** Three distinct classes
   appeared across these 18 rows: the +1 text-id shift (femenudefs, screentrophyinfo); a
   **struct-size / field-displacement** shift from a dropped member (audiomus `failby`: -4
   everywhere, including the `reservememadr` size literal); and a **PAL display-geometry**
   constant (`0xf0 -> 0x100`: loading plus the four PAL `CalculateDimensions` rows). Read the
   row's REGION GROUP first вЂ” a group that is exactly the four PAL regionals points at
   geometry/timing, not at text.
4. **The +1 shift is per-id, not blanket** вЂ” `TextSys_Word(0x42)` in
   `MenuExtended_GoToTwoPlayerSingleRace` is untouched by retail while the `yesnowords` pair
   three lines below shifts. Drive every edit from the gate/audit word list; a whole-file
   "+1 to all text ids" sweep would have broken that row.
5. **A shared `static inline` helper can own a row's constants** вЂ”
   `MenuExtended_SetUpgradeDialogWords` holds `MenuExtended_PurchaseUpgrade`'s
   `yesnowords` pair. Check its caller set before shifting; here it had exactly one caller,
   so no other row could be disturbed.
