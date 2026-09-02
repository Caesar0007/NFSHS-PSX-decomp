# W84-R12 receipt (regional-variant matching)

Gate used for every row (exact form):
```
python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>
```
(REGION-ONLY rows: no `--lane-as`.)

## Status board — **25/25 REGION-PASS** (all rows gated green in their final on-disk state)

| # | fn | region | status |
|---|---|---|---|
| 1 | CopSpeak_Alloc__FP17CopSpeak_tRequest | USA | REGION-PASS (32) |
| 2 | CopSpeak_DirectRequest__FillP8Car_tObjPc | USA | REGION-PASS (49) |
| 3 | CopSpeak_Free__FP17CopSpeak_tRequest | USA | REGION-PASS (45) |
| 4 | CopSpeak_GenericBankRequest__FiP8Car_tObj | USA | REGION-PASS (47) |
| 5 | CopSpeak_InitRequest__FP17CopSpeak_tRequest | USA | REGION-PASS (13) |
| 6 | CopSpeak_InitVars__Fv | USA | REGION-PASS (32) |
| 7 | CopSpeak_LoadNextRequest__Fv | USA | REGION-PASS (135) |
| 8 | CopSpeak_PlayNextRequest__Fv | USA | REGION-PASS (81) |
| 9 | CopSpeak_ReadyNextRequest__Fv | USA | REGION-PASS (176) |
| 10 | CopSpeak_Request__FP17CopSpeak_tRequest | USA | REGION-PASS (84) |
| 11 | Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj | USA | REGION-PASS (492) |
| 12 | DrawCongratsMessage__23tScreenBeTheCopCongrats | USA | REGION-PASS (48) |
| 13 | DrawCongratsMessage__23tScreenTournamentTrophy | USA | REGION-PASS (185) |
| 14 | GetShapeInfo__15tScreenCongratsRsT1PPcT3 | USA | REGION-PASS (148) |
| 15 | Initialize__11tScreenMain | USA | REGION-PASS (221) |
| 16 | PreLoad__11tScreenMain | USA | REGION-PASS (39) |
| 17 | Hud_CreateHudViews__Fv | AU | REGION-PASS (187) |
| 18 | Draw__25tPMenuItemLeftRightChoiceb | JPN | REGION-PASS (44) |
| 19 | Draw__25tPMenuItemLeftRightSliderb | JPN | REGION-PASS (96) |
| 20 | func_80012FDC | UK-ES-IT | REGION-PASS (107) |
| 21 | Weather_DoSplats__FiP18Weather_tSplatInfo | AU | REGION-PASS (97) |
| 22 | s_lower__FPc | JPN | REGION-PASS (8) |
| 23 | s_upper__FPc | JPN | REGION-PASS (8) |
| 24 | func_800A77C4 | AU | REGION-PASS (9) |
| 25 | func_800DCED8 | AU | REGION-PASS (2) |

## Notes per row

### Rows 1-10 (copspeak, USA) — REGION-PASS, verified this session
Candidate `regiondiff/recon/NFS4-R-USA/game/common/copspeak.cpp` already existed from
earlier wave work; re-gated all ten fns in one call and all ten are REGION-PASS.
No edits made.

### Rows 17, 20, 22-25 — REGION-PASS, verified this session
Existing candidates re-gated green, no edits:
- `regiondiff/recon/NFS4-R-AU/game/psx/hud.cpp` (Hud_CreateHudViews__Fv, 187)
- `regiondiff/recon/NFS4-R-UK-ES-IT/regiononly/func_80012FDC.cpp` (107)
- `regiondiff/recon/NFS4-R-JPN/frontend/common/fetools.cpp` (s_lower/s_upper, 8 each)
- `regiondiff/recon/NFS4-R-AU/regiononly/func_800A77C4.cpp` (9)
- `regiondiff/recon/NFS4-R-AU/regiononly/func_800DCED8.cpp` (2)

### Rows 15-16 (screenmain, USA) — REGION-PASS, first gate after the edit
Candidate `regiondiff/recon/NFS4-R-USA/frontend/common/screenmain.cpp` (seeded from
`recon/frontend/common/screenmain.cpp`).
Unedited seed measured: Initialize FAIL 220 (ours 129 / oracle 221), PreLoad FAIL 114
(ours 131 / oracle 39).

Regional delta: retail MOVED the tail of `PreLoad` into `Initialize`. PreLoad now stops
after `tScreen::PreLoad()` (39 insns); Initialize runs, right after `tScreen::Initialize()`,
the fVideoShapes init loop + the two `rand()` background picks + the async-load loop,
then the base body. Two shape details had to be right:
- `bool shapesLoaded = false;` is declared/zeroed at the TOP of Initialize (prologue
  `move $s4,$zero`, and the first loop counter takes that same zero: `move $s2,$s4`), and
  the wait loop is a `while (!shapesLoaded)`, not the base's `do/while` — the oracle keeps
  the un-folded rotation guard `bnez $s4,.L80038B78` (m2c prints it as `if (0 == 0)`; cse
  does not reach across the intervening calls, gotcha #12 / §3.2c).
- one fn-scope `short i` still serves every loop (base MATCH note preserved).
Falsified angles: none needed — PASS on the first gate after the move.

### Rows 12-14 (screencongrats, USA) — REGION-PASS
Candidate `regiondiff/recon/NFS4-R-USA/frontend/common/screencongrats.cpp`.
Unedited seed: BeTheCop FAIL 13 (47/48), TournamentTrophy FAIL 25 (182/185),
GetShapeInfo FAIL 6 (150/148).

Regional deltas (all source-level, no shape rewrite — the base bodies were already right):
- **String-table shift**: every `TextSys_Word*` index >= 0x121 is ONE higher in retail
  (0x121->0x122, 0x3b3->0x3b4, 0x3e1->0x3e2, 0x3c6->0x3c7, 800->801); the money word 0x40
  sits below the insertion point and is unchanged. That single fact explains most of the
  constant diffs in both DrawCongratsMessage fns.
- **Layout**: BeTheCop message RECT w 200->420; TournamentTrophy RECT y 60->53, w 200->420,
  and the second message is re-narrowed to `r.w = 200` inside the `secondmessage` arm.
- **Text state**: retail draws these messages `textState_Hilighted` (2), base `Selected` (1)
  — one arg in BeTheCop, two in TournamentTrophy.
- **GetShapeInfo**: the switch default stores a NULL swap filename (`sw zero`), not the
  address of an empty string literal — exactly the 2-instruction over-count (150 vs 148).
- **TournamentTrophy y advance**: retail biases by -14 before adding the wrapped height.
  Lever (measured, 4 forms): the bias must be written on the LOADED y with a short cast,
  `r.y = (short)(r.y - 14) + (short)FETextRender_WordWrapHeight(r.w,buffer1);`
    * `r.y = r.y - 14 + (short)f(...)`        -> FAIL 3 (gcc reassociates: `addiu v0,v0,-14`
                                                 on the call result, filling the load-delay
                                                 slot the oracle leaves as `nop`)
    * `int h = f(...); r.y = r.y - 14 + h;`   -> FAIL 3 (same reassociation)
    * `r.y = (short)f(...) + (r.y - 14);`     -> FAIL 3 (same)
    * `r.y = r.y + (short)f(...) - 14;`       -> FAIL 2 (185/185, bias lands after the add)
    * `(short)(r.y - 14) + (short)f(...)`     -> REGION-PASS 185. The cast blocks the
      reassociation and costs no extension insns (the sum is truncated by the short store).

### Rows 18-19 (pausemenu, JPN) — REGION-PASS
Candidate `regiondiff/recon/NFS4-R-JPN/game/common/pausemenu.cpp`.
Unedited seed: Choice FAIL (ours 74 / oracle 44), Slider FAIL 199 (ours 169 / oracle 96).

Regional delta (one fact, both fns): the Japanese build draws **no left/right arrow
prims** — the entire `selected && GameSetup_gData.userSetting.language == 0` block
(two `Hud_BuildGT4` packet appends) is absent from both Draw bodies. Removing it:
- Choice: the `x`/`y` locals go with it; the second word x is consumed inline in the
  call argument (`(short)TextSys_WordX((int)index)`). PASS 44 on the first gate.
- Slider: the base seal's TWO allocation fences (`__asm__("" : : ...)`) were shaping
  pressure created by that block (10 saved regs base, 6 here) — both were DELETED, so
  this candidate contains no `__asm__` at all (W84 rule) and still PASSes 96. The
  giv-shaping `int off = i * 5 + 66; xpos = x + off;` block-local is kept verbatim from
  the base seal: it is what gives retail's `li s1,66` / `addiu s1,s1,5` stepping form.

### Row 21 (weather, AU) — REGION-PASS
Candidate `regiondiff/recon/NFS4-R-AU/game/psx/weather.cpp`.
Unedited seed: FAIL 34 (ours 113 / oracle 97).

Regional delta (three facts, all source-level):
1. **`random() & 0xFF` instead of `(u_int)random() % 0xf0`** — retail masks where the
   base build divides; two sites, each replacing a 9-insn multu/mfhi magic-divide chain.
   That is the entire 16-instruction count gap.
2. **ONE vy store**, not one per commMode arm (oracle merges at `.L800E458C`,
   `sh $v0,2($s1)` in a jal delay slot). Writing `vy = ...` in each arm and storing once
   drops `q` from 3 refs to 2, which flips the local-alloc tie to retail's handout
   (walker `$s0` / q `$s1` / i `$s2`). With two stores the count is already exact 97/97
   but every walker/q line is an `$s0`<->`$s1` swap.
3. **No allocation fences needed**: the base seal's two `__asm__` fences (the ref-count
   dial on `i` and the CSE-opaque launder on `q`) are both deleted — this function now
   contains no asm and no volatile and still PASSes. `q` itself must stay (it is retail's
   `move $s1,$s0` copy).

Falsified angles (each a real gate run): andi only 18 @97 (pure s0<->s1) | i-fence
dropped, inert 18 | local decl-order swap 18 | `q` block-local 43 @96 | `q` assigned
before the vx store 71 @102 | `q` also carrying the startTick store 16 @97 (wrong: that
store goes through the walker in the oracle) | one-store + asm launder PASS | one-store +
`(long long)` launder PASS | one-store, no asm **PASS (adopted)** | one-store with no `q`
at all 46 @95 (loses the delay-slot copy).

### Row 11 (newton, USA) — REGION-PASS
Candidate `regiondiff/recon/NFS4-R-USA/game/common/newton.cpp`.
Unedited seed: FAIL 24 (ours 470 / oracle 492).

Regional delta — two additions to the base body, nothing else changed (all the base
seal's match devices, including its `"m"`-constraint fence and the two quadPt identity
launders, are inherited untouched; no new asm/volatile introduced):
1. **A fifth arm on the FindEdgeOff dispatch** (@800A3C54): retail adds
   `else if ((check == 0) || (check == 12)) { normal = -newtonObj->linearVel; }` — when
   the edge test reports no edge, or both pairs, the surface normal is the negated
   linear velocity instead of a generated edge vector. Oracle:
   `beqz $s0,.L800A3C64; li $v0,12; bne $s0,$v0,.L800A3C98` + three
   `lw 172/176/180($s1); negu; sw 16/20/24($sp)` into `&normal`. Worth 18 insns
   (470 -> 488, 24 -> 6 diffs).
2. **A second `memset`** (@800A39D0): retail clears `normal` (12 bytes at sp+16) as well,
   BEFORE the road-centre copy — the base build only clears `speedVec` (sp+64). Worth the
   last 4 insns; 488 -> **REGION-PASS 492**.

## Gate command lines used (verbatim)
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/copspeak.cpp CopSpeak_Alloc__FP17CopSpeak_tRequest,CopSpeak_DirectRequest__FillP8Car_tObjPc,CopSpeak_Free__FP17CopSpeak_tRequest,CopSpeak_GenericBankRequest__FiP8Car_tObj,CopSpeak_InitRequest__FP17CopSpeak_tRequest,CopSpeak_InitVars__Fv,CopSpeak_LoadNextRequest__Fv,CopSpeak_PlayNextRequest__Fv,CopSpeak_ReadyNextRequest__Fv,CopSpeak_Request__FP17CopSpeak_tRequest --lane-as=recon/game/common/copspeak.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/newton.cpp Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj --lane-as=recon/game/common/newton.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screencongrats.cpp DrawCongratsMessage__23tScreenBeTheCopCongrats,DrawCongratsMessage__23tScreenTournamentTrophy,GetShapeInfo__15tScreenCongratsRsT1PPcT3 --lane-as=recon/frontend/common/screencongrats.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screenmain.cpp Initialize__11tScreenMain,PreLoad__11tScreenMain --lane-as=recon/frontend/common/screenmain.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/game/psx/hud.cpp Hud_CreateHudViews__Fv --lane-as=recon/game/psx/hud.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/game/psx/weather.cpp Weather_DoSplats__FiP18Weather_tSplatInfo --lane-as=recon/game/psx/weather.cpp
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/game/common/pausemenu.cpp Draw__25tPMenuItemLeftRightChoiceb,Draw__25tPMenuItemLeftRightSliderb --lane-as=recon/game/common/pausemenu.cpp
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/fetools.cpp s_lower__FPc,s_upper__FPc --lane-as=recon/frontend/common/fetools.cpp
python regiondiff/tools/verify_region.py UK-ES-IT regiondiff/recon/NFS4-R-UK-ES-IT/regiononly/func_80012FDC.cpp func_80012FDC
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800A77C4.cpp func_800A77C4
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800DCED8.cpp func_800DCED8
```
(`VA_MAX=<n>` in the environment widens the printed diff list; it changes nothing else.)

## Scope / hygiene
- Files written: ONLY the six candidate TUs under `regiondiff/recon/**` listed above
  (screenmain, screencongrats, newton — all NFS4-R-USA; pausemenu — JPN; weather — AU)
  plus this receipt. The copspeak / hud / fetools / regiononly candidates were already
  present and were re-gated WITHOUT edits.
- No base-tree, tool, MANIFEST, progress-board or memory-dir file was touched; no git
  operation was run; `update_region_progress.py` was NOT run (per the wave guide).
- No `register ... asm("$N")` pins, no volatile and no `__asm__` were INTRODUCED. Two
  inherited base fences were DELETED (pausemenu slider x2, weather x2) because the
  regional bodies pass without them; the remaining `__asm__`/`volatile` occurrences in
  newton.cpp / weather.cpp / screenmain.cpp / pausemenu.cpp are pre-existing base-seal
  code in functions that are NOT my rows (or, for screenmain/pausemenu, the base MATCH
  devices inside my rows that retail still needs).
