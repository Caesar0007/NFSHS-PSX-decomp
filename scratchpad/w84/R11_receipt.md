# W84-R11 receipt — regional-variant matching (16 rows)

Gate: `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>`

Board state at start (regiondiff/REGION_PROGRESS.txt): 10 of my 16 rows already
SEALED by earlier waves, 6 TODO. Plan: re-verify the 10 SEALED (regression
check, no edits unless they fail), then work the 6 TODO.

| # | function | region | class | start board | final | note |
|---|---|---|---|---|---|---|
| 1 | Hud_BuildNumbers__Fi | USA | CHANGED | SEALED | REGION-PASS (758) | re-verified, no edit |
| 2 | Hud_DebugInfo__Fv | USA | CHANGED | SEALED | REGION-PASS (2) | re-verified, no edit |
| 3 | Hud_ParseTime__FiPc | USA | CHANGED | SEALED | REGION-PASS (97) | re-verified, no edit |
| 4 | BWorld_Init__Fv | USA | CHANGED | TODO | REGION-PASS (187) | `SceneNumber = rand()/0x2000` (base /0x4000) |
| 5 | BWorld_OpenContext__Fii | USA | CHANGED | TODO | REGION-PASS (56) | track 8..10 -> chunk clip 0x33a90/0x42040; poly clip 0x3d090 |
| 6 | SetupChunkBuildList__FP13DRender_tView | USA | CHANGED | TODO | REGION-PASS (224) | per-chunk near-clip 0x1fa40 on tracks 8..10, ends of track |
| 7 | Initialize__11tScreenMain | AU | CHANGED | TODO | REGION-PASS (219) | ~90 new insns: both BGs seeded + async-loaded here |
| 8 | SwapBackground__11tScreenMaini | AU | CHANGED | TODO | REGION-PASS (110) | `rand() % 0x1f` (base 0x1c) -- 31 backgrounds |
| 9 | SetupCurrCredit__14tCreditManager | USA | CHANGED | SEALED | REGION-PASS (214) | re-verified, no edit |
| 10 | sprintf | USA | CHANGED | TODO | BODY EXACT 545/545, gate FAIL 3 | 3 pad nops past the fn end -- regional slice lacks `endlabel` |
| 11 | UpdateTrackFinishPoints__18tTournamentManager | USA | CHANGED | SEALED | REGION-PASS (129) | re-verified, no edit |
| 12 | func_80012F6C | AU | REGION-ONLY | SEALED | REGION-PASS (107) | re-verified, no edit |
| 13 | func_800BB2F8 | AU | REGION-ONLY | SEALED | REGION-PASS (57) | re-verified, no edit |
| 14 | PadInfoAct | USA | CHANGED | SEALED | REGION-PASS (53) | re-verified, no edit |
| 15 | func_800A7864 | USA | REGION-ONLY | SEALED | REGION-PASS (8) | re-verified, no edit |
| 16 | func_800DCEA4 | USA | REGION-ONLY | SEALED | REGION-PASS (2) | re-verified, no edit |

## Log
(banked incrementally)

### Phase 1 — regression re-verify of the 10 already-SEALED rows: ALL 10 REGION-PASS, no edits made.
```
verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/hud.cpp Hud_BuildNumbers__Fi,Hud_DebugInfo__Fv,Hud_ParseTime__FiPc --lane-as=recon/game/psx/hud.cpp
  Hud_BuildNumbers__Fi: REGION-PASS (758) / Hud_DebugInfo__Fv: REGION-PASS (2) / Hud_ParseTime__FiPc: REGION-PASS (97)
verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fecredits.cpp SetupCurrCredit__14tCreditManager --lane-as=recon/frontend/common/fecredits.cpp   -> REGION-PASS (214)
verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fetourn.cpp UpdateTrackFinishPoints__18tTournamentManager --lane-as=recon/frontend/common/fetourn.cpp -> REGION-PASS (129)
verify_region.py USA regiondiff/recon/NFS4-R-USA/syslib/psx/libpad/PADENTRY.c PadInfoAct --lane-as=recon/syslib/psx/libpad/PADENTRY.c -> REGION-PASS (53)
verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A7864.cpp func_800A7864 -> REGION-PASS (8)
verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800DCEA4.cpp func_800DCEA4 -> REGION-PASS (2)
verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_80012F6C.cpp func_80012F6C -> REGION-PASS (107)
verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800BB2F8.cpp func_800BB2F8 -> REGION-PASS (57)
```


### Phase 2 — TODO rows

**#5 BWorld_OpenContext__Fii (USA) — REGION-PASS (56 insns).**
Seed measured: FAIL 22 (ours 46 / oracle 56). Regional delta: in `case 1` retail
gates the chunk far-Z clip on the track number — `(u32)(track-8) < 3` → 0x33a90
else 0x42040 (base had a flat 0x52210); poly far-Z clip 0x44944 → 0x3d090.
Global identification (no base symbol_addrs lookup): the sibling BWorld_Init
slice fixes regional `GameSetup_gData` = 0x801144A4 by its field pattern
(unk0=raceType, unk4=numLaps, unkC=commMode, unkD4/D8/DC=Scene*), and the oracle
loads 0x801144E0 = +0x3C = `track`. Natural range form `(track>=8 && track<=10)`
produced the oracle's `addiu -8; sltiu 3` fold first try.
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/bworld.cpp BWorld_OpenContext__Fii --lane-as=recon/game/common/bworld.cpp`

**#4 BWorld_Init__Fv (USA) — REGION-PASS (187 insns).**
Seed measured: FAIL 4, count already EXACT 187/187 — the whole diff was one
division constant: ours `addiu 16383; sra 14` (/0x4000) vs oracle `addiu 8191;
sra 13` (/0x2000). Retail draws the scene number over twice the range:
`SceneNumber = rand() / 0x2000`. The SceneStartLap fallback `random / 0x4000`
is unchanged (m2c slice confirms /16384 there).
Gate: same command, fn `BWorld_Init__Fv`.

**#6 SetupChunkBuildList__FP13DRender_tView (USA) — REGION-PASS (224 insns).**
Seed measured: FAIL 85 (ours 203 / oracle 224). Regional delta = a retail
draw-distance clamp: the chunk far-Z clip is cached in a LOCAL up front and,
on tracks 8..10, forced to 0x1fa40 for the first and last five chunks —
`if (track>=8 && track<=10) if (currentChunk < 5 || Track_header->chunkCount-5 < currentChunk) farZ = 0x1fa40;`
— the loop's `chunkDist <= ...` test then reads the local (oracle spills it:
`sw $t0,100($sp)` / per-iteration `lw $t0,100($sp)`).
Global identification: the new pointer read at regional 0x8013E798 sits exactly
between Track_gInViewCount (0x8013E794) and Track_chunkList (0x8013E79C) — the
same adjacency the base layout has for `Track_header` — and it is dereferenced
at +0x1C = `chunkCount`. Declared in the candidate as a private layout-locked
`BWorld_TrackHeaderCodegenView` (bworld.obj's SYM graph has no TrackHeader
record), matching the sibling *CodegenView pattern; the base tree is untouched.
Two codegen levers were needed after the semantics (85 -> 50 -> 44 -> 0):
  * `chunkCount = 0;` must sit BEFORE the new guard: with it after the merge
    gcc const-folds the walker init (`lui;addiu` only), retail keeps the
    unfolded `sll $v0,$s6,2; addu $s1,$v0,$a3` — moving it made the count
    EXACT 224/224 (44 diffs, pure placement/coloring left).
  * a `tBuildEntry *buildList = BWorld_gChunkBuildList;` local assigned BEFORE
    the guard puts the symbol's `%hi/%lo` pair in the ENTRY block (a pre-loop
    assignment is unmovable, catalog 21B-3) instead of the loop preheader,
    which is where the base tree's direct `BWorld_gChunkBuildList[chunkCount]`
    lvalues put it. That single change took 44 -> 0.
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/bworld.cpp BWorld_Init__Fv,BWorld_OpenContext__Fii,SetupChunkBuildList__FP13DRender_tView --lane-as=recon/game/common/bworld.cpp`
  -> all three REGION-PASS (187 / 56 / 224).

**#8 SwapBackground__11tScreenMaini (AU) — REGION-PASS (110 insns).**
Seed measured: FAIL 7 (ours 111 / oracle 110). One constant: the random
background is drawn `% 0x1f` in the AU build, not `% 0x1c` — oracle magic
0x84210843 + `sll 5; subu` (=*31) vs base 0x92492493 (=*28). 31 selectable
backgrounds instead of 28.

**#7 Initialize__11tScreenMain (AU) — REGION-PASS (219 insns).**
Seed measured: FAIL 218 (ours 129 / oracle 219) — a ~90-instruction retail
addition. The AU build seeds and kicks off BOTH background videos inside
Initialize instead of leaving it to the first SwapBackground:
  * `shapesLoaded = false;` before everything and the shape-wait loop becomes
    TOP-tested (`move $s4,$zero` at entry + `bnez $s4` skip) — base entered it
    unconditionally as a do/while;
  * a 2-iteration loop clearing `fVideoShapes[i].fShapes = 0` and calling
    `InitializeShapes(this, &fVideoShapes[i], 0x10)` (func_80026440, the 3-arg
    tScreen shape init);
  * `fCurrentBG[0] = rand() % 0x1f; fCurrentBG[1] = (fCurrentBG[0] + rand()%0x1e + 1) % 0x1f;`
    — the offset-by-1..30-mod-31 form guarantees the two slots differ (the same
    31-background pool the AU SwapBackground draws from);
  * a 2-iteration `sprintf(buffer,"zyVid%02d",fCurrentBG[i]); AsyncLoadShapeFile(...)`
    loop, which is what grows the frame to -88 with a 32-byte scratch at sp+24
    (args 0..23, buffer 24..55, s0..s5+ra 56..83).
The existing base `short i` counter serves all five loops (retail keeps one
`$s2`). Landed first try once the shape was right; no coloring grind needed.
Gate: `python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/screenmain.cpp Initialize__11tScreenMain,SwapBackground__11tScreenMaini --lane-as=recon/frontend/common/screenmain.cpp`

**#10 sprintf (USA) — BODY EXACT (545/545, zero diffs); gate reports FAIL 3 = slice-boundary artifact.**
Seed measured: FAIL 3 (ours 545 / oracle 548) and the seed is the UNEDITED base
TU. The contexted alignment (scratchpad/w84/R11_sprintf.txt, produced by the
read-only helper scratchpad/w84/R11_rdiff.py) shows **all 545 aligned pairs are
equal — 0 `***` rows**. The only three "diffs" are three trailing `nop`s the
regional oracle slice carries PAST the epilogue:
```
   544 800E5928 | addiu sp,sp,592   | addiu sp,sp,592
+OR      800E592C |                 | nop
+OR      800E5930 |                 | nop
+OR      800E5934 |                 | nop
```
Those are inter-object padding, not code. The BASE oracle for the same function
proves it: `asm/nonmatchings/main/sprintf.s` declares `nonmatching sprintf,
0x884` (0x884/4 = **545** instructions) and places `endlabel sprintf` BEFORE the
identical three pad nops. `regiondiff/oracles/NFS4-R-USA/sprintf.s` has no
`endlabel`, so `verify_region.py` counts the padding. Same class as the catalog
§F `SetSp` row ("the function = EXACTLY its words; the oracle endlabel sits
BEFORE the pad nop; the linker handles inter-obj alignment").
No source-level fix exists (nothing in C emits three nops after the epilogue,
and an `__asm__`/post-compile pad is forbidden by the wave rules), and I may not
edit `regiondiff/tools/*.py`. **ORCHESTRATOR ACTION (the named angle):** have the
slice generator emit an `endlabel`/size for regional oracles the way the base
oracles do (or trim this row's `.s` to 0x884), after which this row is a clean
REGION-PASS with the candidate exactly as left (a verbatim copy of the base TU —
the retail sprintf is byte-for-byte the base body, which is itself the useful
finding: this "CHANGED" row is a pure relocation/layout difference).
Candidate left at: `regiondiff/recon/NFS4-R-USA/syslib/psx/libc/SPRINTF.c` (unedited seed).
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/syslib/psx/libc/SPRINTF.c sprintf --lane-as=recon/syslib/psx/libc/SPRINTF.c`

## Summary

15 of 16 rows REGION-PASS. The 16th (`sprintf`) is byte-for-byte identical to
the base TU over its true 545-instruction extent (0 aligned-pair diffs); its
gate FAIL 3 is entirely three inter-object pad `nop`s that the regional oracle
slice includes because it carries no `endlabel` (the base oracle does, and sizes
the function at 0x884 = 545 insns).

Files created/edited (nothing else was touched; no base-tree / tool / memory /
git changes, and no `update_region_progress.py` run):
  regiondiff/recon/NFS4-R-USA/game/common/bworld.cpp          (new candidate, edited)
  regiondiff/recon/NFS4-R-AU/frontend/common/screenmain.cpp   (new candidate, edited)
  regiondiff/recon/NFS4-R-USA/syslib/psx/libc/SPRINTF.c       (new candidate, verbatim base seed)
  scratchpad/w84/R11_receipt.md, R11_rdiff.py, R11_sprintf.txt
All other candidates for my rows already existed and were left UNCHANGED
(re-verified only).

Cross-row finding worth banking centrally: the whole R-USA data segment for the
game globals is a UNIFORM +0x12B8 shift of the base layout in this
neighbourhood (`GameSetup_gData` base 0x801131EC -> regional 0x801144A4) and
+0x12E4 for the track cluster (`Track_gInViewList` 0x8013D4AC -> 0x8013E790);
both were established by CONTENT (field-offset patterns / symbol adjacency) from
the m2c slices, never by a base symbol_addrs lookup, and both were confirmed
semantically before use. `GameSetup_gData.track` (regional 0x801144E0) is the
gate behind BOTH bworld regional deltas, i.e. the USA retail build carries a
track-specific draw-distance tuning pass that the matched base build does not.
