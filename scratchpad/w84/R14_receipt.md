# W84-R14 receipt (regional variants) — banked incrementally

Gate command form:
`python regiondiff/tools/verify_region.py <REGION> <candidate> <fns> --lane-as=recon/<unit>.<ext>`

| # | function | region | status | note |
|---|---|---|---|---|
| 1 | StatChk_IsRecordLapTime__FP10Car_tStatssPs | USA | REGION-PASS 207 | `<` -> `<=` on the record compare |
| 2 | StatChk_IsTopTime__FP10Car_tStatss | USA | REGION-PASS 299 | same `<` -> `<=`, three sites |
| 3 | StatChk_SaveTopTime__FP10Car_tStatss | USA | REGION-PASS 437 | `<=` + tail replaced by an 8-slot time+name rescan (+21 insns) |
| 4 | func_80075F28 (REGION-ONLY) | USA | REGION-PASS 465 | already sealed by an earlier wave; re-gated, no edit |
| 5 | AudioMus_Fail__Fi | USA | REGION-PASS 39 | struct loses `failby`; new `errorcode==-5` early exit |
| 6 | AudioMus_QueueRequestedSong__Fv | USA | REGION-PASS 40 | `failby = gettick()+0x280` deleted |
| 7 | AudioMus_Server__Fii | USA | REGION-PASS 242 | CD-swap preamble + failby watchdog deleted |
| 8 | Lose__Q26Speech13MobileSpeaker | USA | REGION-PASS 209 | blockade-flags guard dropped; already sealed, re-gated |
| 9 | FECheat_ActivateBonusByCode__FPc | USA | REGION-PASS 46 | bonusList 3 -> 2 |
| 10 | FECheat_ActivateCheat__FPc | USA | REGION-PASS 66 | cheatList 10 -> 3; TextSys_Word 634 -> 635 |
| 11 | FECheat_HandleActivation__F10tCheatCode | USA | REGION-PASS 36 | 31-case switch -> 11 cases (8 classes + 3 SetCarAvailable) |
| 12 | FECheat_LoadBonus__FRUl | USA | REGION-PASS 30 | 31 -> 15 cheat bits |
| 13 | DoTitleScreen__Fv | AU | REGION-PASS 66 | per-language title art `sprintf(buf,"ttl%d.psh",lang)` |
| 14 | Init_RenderingEnvironment__Fv | AU | REGION-PASS 62 | PAL 256 lines + `screen.y = 21` on both DISPENVs |
| 15 | Render_CreatePlayerViews__Fv | AU | REGION-PASS 59 | PAL: 0x78->0x80, 0x178->0x180, 0xf0->0x100 |
| 16 | Render_InitTrackRender__Fv | AU | REGION-PASS 46 | PAL: Draw_InitRenderEngine height 0xf0 -> 0x100 |
| 17 | func_800702E4 (REGION-ONLY) | USA | REGION-PASS 19 | already sealed by an earlier wave; re-gated, no edit |
| 18 | func_80070330 (REGION-ONLY) | USA | REGION-PASS 15 | already sealed by an earlier wave; re-gated, no edit |
| 19 | func_800DCEAC (REGION-ONLY) | USA | REGION-PASS 2 | already sealed by an earlier wave; re-gated, no edit |

**ALL 19 ROWS REGION-PASS** (re-gated together at the end of the session).
Base tree untouched: `git status --porcelain -- recon src asm configs include tools`
shows only the user's own pre-existing FONT.c / LIBMCRD.c edits.

---

## Row 1-3 — frontend/common/statchk (USA) — ALL THREE REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/statchk.cpp`
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/statchk.cpp StatChk_IsRecordLapTime__FP10Car_tStatssPs,StatChk_IsTopTime__FP10Car_tStatss,StatChk_SaveTopTime__FP10Car_tStatss --lane-as=recon/frontend/common/statchk.cpp`

Seed measurement (unedited copy of base TU):
  IsRecordLapTime FAIL 4 (207/207) · IsTopTime FAIL 12 (299/299) · SaveTopTime FAIL 395 (416/437)

**Regional delta #1 — record comparison `<` becomes `<=` (5 sites, all three fns).**
Every "is this a new record" test flips from `slt v0,a0,v1; bnez` (ours, `time < record`)
to `slt v0,v1,a0; beqz` (retail, `time <= record`) — retail counts a TIE as a record.
Sites: IsRecordLapTime `finalBestLap <= RecordHolder.nBestLap`; IsTopTime the three
`nCheckTotalTime <= RecordHolders[nLapIndicator + {6,7,0}].nTime`; SaveTopTime the
`nCheckTotalTime <= RecordHolders[nLapIndicator + 7].nTime`.
  -> IsRecordLapTime REGION-PASS 207, IsTopTime REGION-PASS 299 with this alone.

**Regional delta #2 — SaveTopTime tail REPLACED (+21 insns).**
The base build's placement-collision fixup
(`if (topPlacements[0]==topPlacements[1]) topPlacements[1]=topPlacements[0]+1; else if ...;`
 then `for k<2: if (tp[k] && tp[k]<9) NewRecords[tp[k]-1]=1;`)
is gone.  Retail instead rescans the eight top-ten slots per player:
```
for k in 0..1:                     /* while(1){ if (k>=2) break; ... k=k+1; } */
  if (topPlacements[k] != 0)
    for (nRec = 1; nRec < 9; nRec++)              /* int counter */
      if (RecordHolders[nLapIndicator+nRec-1].nTime == dummyCars[k].finalTotalTime
          && strcmp(RecordHolders[nLapIndicator+nRec-1].sName, PlayerName(k)) == 0) {
        NewRecords[nRec-1] = 1;
        RecordHolders[nLapIndicator+nRec-1].nTime = 0;   /* so player 2 can't re-claim it */
      }
```
(oracle @8004ABF4..8004ACB4; nLapIndicator is reloaded `lhu 112(sp)` into $s8, dummyCars
re-read from its home slot `lw t1,184(sp)`, NewRecords base rematerialised per iteration
with the strength-reduced `$s4 += 4` induction variable = index form.)
  395 -> 15 diffs (440/437).

**Residual levers (both catalog rows, both measured):**
 - outer loop topology: oracle is TOP-test + unconditional `j` back-edge.
   `for (k=0;k<2;k++)` ROTATES = 15 diffs (440); `k=0; while (k<2){...k=k+1;}` = 15 (440);
   `for(...){ if(tp[k]==0) goto NextK; ... NextK:; }` = 15 (440);
   `k=0; NextPlayer: if (k<2){ ...; k=k+1; goto NextPlayer; }` = **312 diffs (433)** —
   the deeper-nested increment recolors s0/s1/s5/s6/s7 through the WHOLE function;
   `k=0; while (1) { if (k>=2) break; ...; k=k+1; }` = **4 diffs, count EXACT 437**.
   (catalog §B "EXIT-IN-THE-MIDDLE prevents rotation" — and its "only when the body is
    coloring-free" nuance is exactly what the goto spelling violated.)
 - last 4 diffs = prologue save/init ORDER only: ours `sw s8;li s8,20; sw s6;move s6,zero`,
   retail `sw s6;move s6,zero; sw s8;li s8,20`.  Fix = move `uRecSz = sizeof(tRecordBuffer);`
   BELOW the three flag inits (still same BB, still above the topPlacements zero-loop so
   W71's basic-block-local-cse opacity is preserved).  All three placements
   (after bDoRecordCheck / after bTopTenFlag / after nPlace) gate REGION-PASS; landed the
   last one.  -> REGION-PASS 437/437.

---

## Row 9-12 — frontend/common/fecheats (USA) — ALL FOUR REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/fecheats.cpp`
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fecheats.cpp FECheat_HandleActivation__F10tCheatCode,FECheat_ActivateCheat__FPc,FECheat_LoadBonus__FRUl,FECheat_ActivateBonusByCode__FPc --lane-as=recon/frontend/common/fecheats.cpp`

Seed measurement: HandleActivation FAIL 112 (116/36) · ActivateCheat FAIL 4 (66/66)
· LoadBonus FAIL 2 (30/30) · ActivateBonusByCode FAIL 2 (46/46).

**The regional delta is one thing: retail SHRANK the cheat system.**
 - `FECheat_HandleActivation`: the 31-case effect switch collapses to 11 cases
   (`sltiu v0,a1,31` -> `sltiu v0,a1,11`, 116 insns -> 36).  Cases 0..7 keep
   `carManager.SetClassAvailable((tCarClassType)cheat,true)`; cases 8/9/10 are
   three `carManager.SetCarAvailable(19|20|28, true)` calls that gcc cross-jumps
   into one shared `jal` (oracle .L80023418, `j` + `li a1,K` in the delay slot).
   Everything from AllCars upward (recursion, trackManager unlocks, money,
   default records, AllCheats, the 0x40 placement loop) is GONE.
   Callee identification: the oracle's two callees are func_80016EB0 and
   func_80016F34 (delta 0x84) sharing ONE object base 0x8011552C; in the BASE
   image `SetClassAvailable__11tCarManager13tCarClassTypeb`@0x80016D68 and
   `SetCarAvailable__11tCarManager10tCarModelsb`@0x80016DEC have exactly that
   0x84 delta and the same receiver — so 8/9/10 are bonus-CAR unlocks, not the
   base enum's FiveFingerDiscount/FreeRepairs/NoDamage.  Case labels are spelled
   numerically with an [INFERRED] note (no invented names).
 - `FECheat_ActivateCheat`: `if (9 < i) break;` -> `if (2 < i) break;`
   (cheatList 10 -> 3 entries) and `TextSys_Word(0x27a)` -> `TextSys_Word(0x27b)`.
 - `FECheat_LoadBonus`: `while (i < 0x1f)` -> `while (i < 0xf)` (31 -> 15 bits).
 - `FECheat_ActivateBonusByCode`: `while (i < 3)` -> `while (i < 2)`
   (bonusList 3 -> 2 entries).

Build note: `fecheats_types.h` deliberately exposes only ONE tCarManager member
("Add only the one car-manager member used by this owner"), so `SetCarAvailable`
does not exist on the filtered type.  Since the base tree must not be edited, the
candidate declares a free-function view bound to the cfront symbol
(`void CarManager_SetCarAvailable(tCarManager*,int,bool) asm("SetCarAvailable__11tCarManager10tCarModelsb");`)
— `this` rides $a0 exactly like the method, byte-neutral (methodology 3.23b).

Not chased (data, not code, and not gate-visible): the regional `cheatList`/`bonusList`
tables must really be 3 and 2 entries; the candidate keeps the base 10/3-entry tables
since the regional oracles are code slices only.  Flagged in-source.

---

## Row 5-7 — game/common/audiomus (USA) — ALL THREE REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/game/common/audiomus.cpp`
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/audiomus.cpp AudioMus_Fail__Fi,AudioMus_QueueRequestedSong__Fv,AudioMus_Server__Fii --lane-as=recon/game/common/audiomus.cpp`

Seed measurement: Fail FAIL 28 (31/39) · QueueRequestedSong FAIL 38 (44/40)
· Server FAIL 112 (300/242).

**Regional delta — retail deleted the `failby` watchdog and the CD-swap arm.**
1. `AudioMus_tMusicGlobals` LOSES `failby` (base +0x1C).  Offsets 0x0C/0x10/0x14/0x18
   (requestsong/firstswitch/switchsong/newswitch) are UNCHANGED; everything from
   `errorcode` on drops 4 bytes: errorcode 0x20->0x1C, fadetime 0x24->0x20,
   songname 0x2C->0x28, streambuffer 0x70->0x6C, streamhandle 0x74->0x70,
   greedy 0x84->0x80, threshold 0x88->0x84, bigfileheader 0x8C->0x88,
   streamstatus 0x90->0x8C, requeststatus 0xA0->0x9C, current 0x118->0x114.
   Expressed as a candidate-local `AudioMus_tMusicGlobalsRegional` +
   `#define AudioMus_tMusicGlobals AudioMus_tMusicGlobalsRegional` right after the
   includes (the base shared header must not be edited); the tentative def
   `AudioMus_tMusicGlobals *AudioMus_g;` — and therefore its %gp_rel addressing —
   is untouched.
2. `AudioMus_Fail`: retail adds an early exit
   `if (errorcode == -5) { AudioMus_g->switchsong = 2; return; }` in front of the
   newswitch/firstswitch/songname/switchsong/requestsong reset (oracle keeps the
   arg in $s0 across the two calls and puts `li v1,1` in the `bne` delay slot).
3. `AudioMus_QueueRequestedSong`: `iVar4 = gettick(); AudioMus_g->failby = iVar4 + 0x280;`
   deleted (the regional oracle has no `jal` between the switchsong store and the
   current-song clear).
4. `AudioMus_Server`: the entire CD-swap preamble is gone — the
   `bigfilename[0]=='.'` / `CdDiskReady(1)!=0x10` disc-present arm AND the
   `errorcode == -2` "wait for disc" arm — leaving
   `if (bigfileheader == 0) goto done; AudioMus_RefreshStatus(); ...`.
   The `update_failby:` block (`gettick() + 0x280`) is deleted too; the
   `switchsong = 2` branch just falls to `done`.
All three REGION-PASS on the first gate after these edits (39 / 40 / 242).

**Corpus observation (not a row, reported for the pipeline owner):** the struct
shift necessarily changes `AudioMus_RefreshStatus` too, and it DOES — the regional
EXE at 0x8007A960 reads `lw a0,112(a1)` / `addiu a1,a1,140` / `lw v0,140(a1)` /
`lw a0,144(a1)` / `addiu a1,a1,152` where base 0x80079EF4 uses 0x74/0x90/0x94/0x9C.
`AudioMus_RefreshStatus__Fv` is NOT in `regiondiff/MANIFEST.tsv` or
`oracles/NFS4-R-USA/INDEX.tsv`, so regiondiff.py's CHANGED detection missed at
least this one (verified by disassembling NFS4-R-USA.EXE directly).

---

## Row 8 — game/common/speech (USA) `Lose__Q26Speech13MobileSpeaker` — REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/game/common/speech.cpp` (this file already
existed in the tree when R14 started, seeded + edited by an earlier pass).
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/speech.cpp Lose__Q26Speech13MobileSpeaker --lane-as=recon/game/common/speech.cpp`
Result: **REGION-PASS (209 insns)** — re-gated, no edit needed from R14.

Regional delta (the file's only diff vs the current base TU, confirmed by
`diff --strip-trailing-cr recon/game/common/speech.cpp <candidate>`):
`if (((this->_base_Speaker).fBlockade.flags == 0) && (Leader == (Speaker *)0x0))`
becomes `if (Leader == (Speaker *)0x0)` — retail drops the blockade-flags guard.

---

## Row 13-14 — frontend/psx/psxfront (AU) — BOTH REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-AU/frontend/psx/psxfront.cpp`
Gate: `python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/psx/psxfront.cpp DoTitleScreen__Fv,Init_RenderingEnvironment__Fv --lane-as=recon/frontend/psx/psxfront.cpp`

Seed measurement: DoTitleScreen FAIL 2 (64/66) · Init_RenderingEnvironment FAIL 7 (59/62).

 - `DoTitleScreen`: the only extra oracle pair is `lui v0,0x8011 / lbu a2,23588(v0)`
   — the first `sprintf` gains ONE argument.  The AU rodata at 0x800127C0 reads
   `"ttl%d.psh"` (base @0x80012808 is `"title.psh"`), so retail loads a
   per-language title image: `sprintf(artfilename,"ttl%d.psh",<language byte>)`.
   The byte lives at regional VA 0x80115C24 and has no base counterpart, so it is
   kept mechanical: `extern "C" u_char RDAT_80115C24;` with an [INFERRED] note.
   Identification evidence (NOT symbol_addrs — regional layout): `grep -rn "23588("
   regiondiff/oracles/NFS4-R-AU/` shows it STORED by `main`,
   `Front_InitialMemCardCheck`, `LoadGame` and READ by `DoTitleScreen`,
   `PreLoad__11tScreenMain`, `GetShapeInfo__15tScreenCongrats`,
   `DrawForeground__18tScreenTournSelect`, `UserNameUpperCaseOneLetter`
   => a language index.
 - `Init_RenderingEnvironment`: PAL 256-line display.
   `SetDefDispEnv(&gEnviro[i].disp, ..., 0xf0)` -> `0x100` for BOTH envs (the
   height then CSEs with the first call's y=0x100 — retail's `addu s1,a2,zero`
   where ours emitted `li s1,240`), `Draw_SetView(...,0xf0,...)` -> `0x100`, and
   retail ADDS `gEnviro[0].disp.screen.y = 21; gEnviro[1].disp.screen.y = 21;`
   before `Draw_InitViews()` (oracle `li v0,21; sh v0,10(s0); sh v0,34(s0)` —
   DISPENV.screen at +8, .y at +10; gEnviro stride 24).

## Row 15-16 — game/common/render (AU) — BOTH REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-AU/game/common/render.cpp`
Gate: `python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/game/common/render.cpp Render_CreatePlayerViews__Fv,Render_InitTrackRender__Fv --lane-as=recon/game/common/render.cpp`

Seed measurement: CreatePlayerViews FAIL 6 (59/59) · InitTrackRender FAIL 2 (46/46).
Same PAL-height delta, pure constants (counts already exact):
 - split-screen view height `0x78` -> `0x80` (both Draw_SetView calls),
 - player-2 y origin `0x178` -> `0x180`,
 - full-screen height `0xf0` -> `0x100` in `Draw_SetView` and in
   `Draw_InitRenderEngine(0x140,0x100,0,0x100,0x140,0xf0)` — in both functions
   the 0x100 then CSEs with the x-origin already in $a1, which is exactly the
   oracle's `addu v0,a1,zero` where ours emitted `li v0,240`.

---

## Rows 4, 17, 18, 19 — REGION-ONLY (USA) — already SEALED before R14, re-gated only

`regiondiff/REGION_PROGRESS.txt` already carried these four as SEALED and the
candidates existed under `regiondiff/recon/NFS4-R-USA/regiononly/`.  Re-gated
verbatim, no edit made:

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800DCEAC.cpp func_800DCEAC   -> REGION-PASS (2 insns)
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800702E4.cpp func_800702E4   -> REGION-PASS (19 insns)
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_80070330.cpp func_80070330   -> REGION-PASS (15 insns)
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_80075F28.cpp func_80075F28   -> REGION-PASS (465 insns)
```
(`func_800702E4` / `func_80070330` are the alloc/free pair over a 10 x 0xA0 slot
array at regional 0x8010EA70 with its 10-int in-use flag array at 0x8010F0B0.)

## Files touched by R14 (candidates only)
```
regiondiff/recon/NFS4-R-USA/frontend/common/statchk.cpp      (new, seeded from base TU)
regiondiff/recon/NFS4-R-USA/frontend/common/fecheats.cpp     (new, seeded from base TU)
regiondiff/recon/NFS4-R-USA/game/common/audiomus.cpp         (new, seeded from base TU)
regiondiff/recon/NFS4-R-AU/frontend/psx/psxfront.cpp         (new, seeded from base TU)
regiondiff/recon/NFS4-R-AU/game/common/render.cpp            (new, seeded from base TU)
```
No other file was written (speech.cpp and the four regiononly/*.cpp were read and
re-gated only).  `update_region_progress.py` NOT run (per the wave guide).
