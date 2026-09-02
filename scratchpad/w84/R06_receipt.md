# W84-R06 receipt — regional-variant matching

Gate (all rows): `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>`

## Status table

| # | function | class | region | words | candidate | status |
|---|---|---|---|---|---|---|
| 1 | CD_Read | CHANGED | USA | 162 | regiondiff/recon/NFS4-R-USA/eaclib/psx/eacpsxz/cdfs.c | REGION-PASS |
| 2 | CD_systaskfunc | CHANGED | USA | 108 | (same) | REGION-PASS |
| 3 | CD_timerfunc | CHANGED | USA | 24 | (same) | REGION-PASS |
| 4 | CdReadyHandler | CHANGED | USA | 300 | (same) | REGION-PASS |
| 5 | DrawHelpIcons__14tFEApplication | CHANGED | JPN | 136 | regiondiff/recon/NFS4-R-JPN/frontend/common/feapp.cpp | REGION-PASS |
| 6 | Redraw__14tFEApplication | CHANGED | JPN | 373 | (same) | REGION-PASS |
| 7 | Draw__20tMenuItemSlidingMenuiib | CHANGED | AU | 402 | regiondiff/recon/NFS4-R-AU/frontend/common/femenuoptions.cpp | REGION-PASS |
| 8 | DrawBackground__18tScreenTrackSelect | CHANGED | AU | 301 | regiondiff/recon/NFS4-R-AU/frontend/common/screentracks.cpp | REGION-PASS |
| 9 | MPause_MusicLogic__Fc | CHANGED | USA | 192 | regiondiff/recon/NFS4-R-USA/game/common/mpause.cpp | REGION-PASS |
| 10 | Render_InitBlurMode__Fv | CHANGED | USA | 27 | regiondiff/recon/NFS4-R-USA/game/common/render.cpp | REGION-PASS |
| 11 | Render_RenderWorld__FP13DRender_tView | CHANGED | USA | 41 | (same) | REGION-PASS |
| 12 | Render_Render__Fi | CHANGED | USA | 82 | (same) | REGION-PASS |
| 13 | Init_MemcardFile__FR12MCRDFILE_defsb | CHANGED | AU | 32 | regiondiff/recon/NFS4-R-AU/frontend/common/fememcard.cpp | REGION-PASS |
| 14 | Init_Memcard__FbT0 | CHANGED | AU | 90 | (same) | REGION-PASS |
| 15 | Platform_SysStartUp__Fv | CHANGED | USA | 58 | regiondiff/recon/NFS4-R-USA/game/psx/platform.cpp | REGION-PASS |
| 16 | func_8009A5B0 | REGION-ONLY | AU | 44 | regiondiff/recon/NFS4-R-AU/regiononly/func_8009A5B0.cpp | REGION-PASS |
| 17 | func_800A77E8 | REGION-ONLY | AU | 10 | regiondiff/recon/NFS4-R-AU/regiononly/func_800A77E8.cpp | REGION-PASS |
| 18 | func_800A7828 | REGION-ONLY | AU | 8 | regiondiff/recon/NFS4-R-AU/regiononly/func_800A7828.cpp | REGION-PASS |

(18 rows = 17 manifest rows; CD_* share one candidate file.)

## Verified-pass gate transcripts (re-run this session, 2026-09-02)

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/eaclib/psx/eacpsxz/cdfs.c CD_Read,CD_systaskfunc,CD_timerfunc,CdReadyHandler --lane-as=recon/eaclib/psx/eacpsxz/cdfs.c
  CD_Read: REGION-PASS (162 insns) [NFS4-R-USA]
  CD_systaskfunc: REGION-PASS (108 insns) [NFS4-R-USA]
  CD_timerfunc: REGION-PASS (24 insns) [NFS4-R-USA]
  CdReadyHandler: REGION-PASS (300 insns) [NFS4-R-USA]

python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/screentracks.cpp DrawBackground__18tScreenTrackSelect --lane-as=recon/frontend/common/screentracks.cpp
  DrawBackground__18tScreenTrackSelect: REGION-PASS (301 insns) [NFS4-R-AU]

python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/mpause.cpp MPause_MusicLogic__Fc --lane-as=recon/game/common/mpause.cpp
  MPause_MusicLogic__Fc: REGION-PASS (192 insns) [NFS4-R-USA]

python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/render.cpp Render_InitBlurMode__Fv,Render_RenderWorld__FP13DRender_tView,Render_Render__Fi --lane-as=recon/game/common/render.cpp
  Render_InitBlurMode__Fv: REGION-PASS (27 insns) [NFS4-R-USA]
  Render_RenderWorld__FP13DRender_tView: REGION-PASS (41 insns) [NFS4-R-USA]
  Render_Render__Fi: REGION-PASS (82 insns) [NFS4-R-USA]

python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/platform.cpp Platform_SysStartUp__Fv --lane-as=recon/game/psx/platform.cpp
  Platform_SysStartUp__Fv: REGION-PASS (58 insns) [NFS4-R-USA]

python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_8009A5B0.cpp func_8009A5B0 --lane-as=recon/game/common/render.cpp
  func_8009A5B0: REGION-PASS (44 insns) [NFS4-R-AU]
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A77E8.cpp func_800A77E8 --lane-as=recon/game/common/render.cpp
  func_800A77E8: REGION-PASS (10 insns) [NFS4-R-AU]
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A7828.cpp func_800A7828 --lane-as=recon/game/common/render.cpp
  func_800A7828: REGION-PASS (8 insns) [NFS4-R-AU]
```

These 12 rows were pre-existing candidates from earlier waves; re-gated this session
and confirmed still REGION-PASS (no edits made by R06).

## Work log — rows R06 actually edited

### 13. Init_MemcardFile__FR12MCRDFILE_defsb (AU @80034A5C) — REGION-PASS (32 insns)

Seed measured first: `FAIL 44 diffs (ours 58 / oracle 32)`.

Regional delta: AU retail **deletes the per-player card title**. The base body's
`else` arm is `if (PlayerNameExist(cardnum==5)) sprintf(TITLE,"%s%s",TextSys_Word(0x278),
PlayerName(...)) else sprintf(TITLE, TextSys_Word(0x279));`; the AU oracle's `else` arm
is a single `sprintf(TITLE, "NEED FOR SPEED")`.

Identification (no symbol_addrs lookups — regional layout):
- `func_800E5094` = **sprintf**: disassembled from `NFS4-R-AU.EXE`, prologue
  `sw a1,4(sp); sw a2,8(sp); sw a3,12(sp)` (varargs spill) then `lb a1,0(a1)` on the
  format pointer.
- `$a1 = 0x8001168C` is a rodata string: read straight out of `NFS4-R-AU.EXE`
  (`t_addr 0x80010000`, `off = VA-t_addr+0x800`) → `"NFS4\0\0\0\0NEED FOR SPEED\0"`,
  so 0x80011684 = `"NFS4"` (the `.name` store) and 0x8001168C = `"NEED FOR SPEED"`.
- Consequence: `cardnum` ($a1) is dead in this build — the oracle prologue latches only
  `$a0`→`$s1` and `$a2`→`$s0`, which the seed's 44-diff frame/arg shift already showed.

Edit = replace the two-way title branch with the one-call literal form. No other change;
the base's `if (notitle)` arm order (beqz-skips-the-rare-case polarity) was already right.

### 14. Init_Memcard__FbT0 (AU @8003484C) — REGION-PASS (90 insns)

Seed measured first: `FAIL 5 diffs (ours 87 / oracle 90)` —
`+ li v0,2 / + sw v0,16(sp) / - sw zero,16(sp) / + jal T / + nop`.

Two regional deltas, both read off `regiondiff/m2c/NFS4-R-AU/Init_Memcard__FbT0.c`:
1. `mcrdopts.productLocation = (PRODUCTLOC)2` (m2c `sp10 = 2`) where the base build
   stores 0 — the PAL/AU product location. Accounts for `li v0,2; sw v0,16(sp)` vs
   `sw zero,16(sp)` (+1 insn).
2. One extra no-arg call appended to the tail, after the final `timedwait(0x14)`
   (m2c's trailing `func_800DCED0()`). Accounts for the `jal`+`nop` (+2 insns).
   `func_800DCED0` is REGION-ONLY (no base counterpart), so it keeps the mechanical
   `func_<region_va>` name with an `[INFERRED]` identity-TBD comment (§8.3); its own
   regional body is the empty leaf already banked at
   `regiondiff/recon/NFS4-R-AU/regiononly/func_800DCED0.cpp`.

Declared TU-locally as `extern "C" void func_800DCED0(void);`. No volatile/asm added
(the pre-existing `SavingDataProc` volatile cast is inherited base-TU state, left as-is).

Gate:
```
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/fememcard.cpp Init_MemcardFile__FR12MCRDFILE_defsb,Init_Memcard__FbT0 --lane-as=recon/frontend/common/fememcard.cpp
  Init_MemcardFile__FR12MCRDFILE_defsb: REGION-PASS (32 insns) [NFS4-R-AU]
  Init_Memcard__FbT0: REGION-PASS (90 insns) [NFS4-R-AU]
```

### 5. DrawHelpIcons__14tFEApplication (JPN @8001348C) — REGION-PASS (136 insns)

Seed measured first: `FAIL 184 diffs (ours 254 / oracle 136)`.

Regional delta — JPN retail strips **all of the pad-ID `'#'` icon handling** and
shifts the help-text word indices by one:
- every `if (gPadinfo.buf[0].ID == '#' || gPadinfo.buf[4].ID == '#')` arm is gone
  (the 0x36 and 0x38 `DrawShapeExtended` blocks, and with them the trailing
  `x += 0xf`); the surviving `nopad == 0 && ID != '#'` gate is unchanged.
- the horizontal path's leading 0x35 icon block is gone too, so `x` is provably
  still 0xe at the width fixup and retail constant-folds `0xe + 5` into the
  oracle's `+ 0x13` (m2c: `var_s1 = (textpixels - strlen) + 0x13`) — the source
  expression `x += 5 + (textpixels(..) - strlen(..))` is unchanged.
- the vertical path loses its whole post-loop tail (`y += 8` and both icon blocks).
- TextSys word ids shift +1: 0xfc → 0xfd and 0xfd → 0xfe (JPN string table).

Everything else (the SLD-verified `Col`/`x`/`y` named-int carriers, the De-Morgan
arm order, the split-load-from-decrement rotated loop) was already correct and was
left untouched. First gate after the edit: PASS.

### 6. Redraw__14tFEApplication (JPN @800136AC) — REGION-PASS (373 insns)

Seed measured first: `FAIL 196 diffs (ours 393 / oracle 373)`.
NOTE: the BASE body of this fn is a documented 10-diff near-miss at 393/393 (the
scratchpad address-window residual, see the long in-source W60→W74 receipt). The
JPN build lands in a different basin and reaches a clean REGION-PASS.

Three regional deltas, applied in two steps (measured in between):

1. **The on-screen debug overlay is absent from retail.** Both
   `sprintf(buffer, D_800100xx, ...)` + `FETextRender_FullText(buffer, ...)` pairs
   (largestunused; AudioMus_Buffered/Threshold) are deleted, along with the
   `char buffer[32]` local they filled. Oracle evidence: `jal func_800BEB98`
   (Draw_StartRenderingView) is immediately followed by `jal func_800BE970`
   (Draw_GetDRAWENV), and the frame is `addiu sp,sp,-72` vs the base's `-112`
   (32-byte buffer + alignment). After step 1: `FAIL 19 diffs (ours 360 / oracle 373)`.
2. **The two-player-race gate is widened by the two pad-ID tests**:
   `nopad0 || nopad4` → `nopad0 || nopad4 || ID0 == '#' || ID4 == '#'`
   (oracle `lbu 4(v1);bnez / lbu 36(v1);bnez / lbu 5(v1);li a0,35;beq /
   lbu 37(v1);bne` over one shared `addiu v1,v0,-1648` gPadinfo base).
3. **The one-player-race gate likewise**: `nopad0` → `nopad0 || ID0 == '#'`
   (oracle `lbu 4(v1);bnez / lbu 5(v1);li v0,35;bne`).

Steps 2+3 supplied exactly the missing 13 instructions and the shared-base form.

Gate:
```
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/feapp.cpp DrawHelpIcons__14tFEApplication,Redraw__14tFEApplication --lane-as=recon/frontend/common/feapp.cpp
  DrawHelpIcons__14tFEApplication: REGION-PASS (136 insns) [NFS4-R-JPN]
  Redraw__14tFEApplication: REGION-PASS (373 insns) [NFS4-R-JPN]
```

### 7. Draw__20tMenuItemSlidingMenuiib (AU @8001D7CC) — REGION-PASS (402 insns)

Seed measured first: `FAIL 1 diffs (ours 401 / oracle 402)` — one extra oracle
instruction, `addiu v0,v0,8` at region VA 8001DC7C.

Regional delta: the **second `SetDrawArea` clip rect starts 8 scanlines lower**.
Oracle window (the `temp` RECT fill):
```
sh   $s4,40($sp)        ; temp.x  = xx
lw   $t2,76($sp)        ; drenv
lhu  $v0,2($t2)
addu $v0,$v0,$s5        ; + yy
addiu $v0,$v0,8         ; <-- AU only
sh   $v0,42($sp)        ; temp.y
sh   $s8,44($sp)        ; temp.w = ww
sh   $s2,46($sp)        ; temp.h = hh
```
Localisation argument: with the seed at exactly ONE diff, every other use of `yy`
(the two `SubtractiveBox` calls, the currMenu vtable draw, the fill-back
`DrawShapeExtended`/`PSXDrawSquare` chain) already aligned instruction-for-
instruction, so the `+8` belongs to `temp.y` and NOT to `yy` — a `yy` shift would
have moved all of those too.

Edit (one line):
`temp.y = *(short*)((char*)drenv+2) + (short)yy;`
→ `temp.y = (*(short*)((char*)drenv+2) + (short)yy) + 8;`

Gate:
```
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/femenuoptions.cpp Draw__20tMenuItemSlidingMenuiib --lane-as=recon/frontend/common/femenuoptions.cpp
  Draw__20tMenuItemSlidingMenuiib: REGION-PASS (402 insns) [NFS4-R-AU]
```

---

## FINAL: 17/17 manifest rows (18 function entries) REGION-PASS

Full re-gate transcript, run after the last edit:

```
CD_Read: REGION-PASS (162 insns) [NFS4-R-USA]
CD_systaskfunc: REGION-PASS (108 insns) [NFS4-R-USA]
CD_timerfunc: REGION-PASS (24 insns) [NFS4-R-USA]
CdReadyHandler: REGION-PASS (300 insns) [NFS4-R-USA]
DrawHelpIcons__14tFEApplication: REGION-PASS (136 insns) [NFS4-R-JPN]
Redraw__14tFEApplication: REGION-PASS (373 insns) [NFS4-R-JPN]
Draw__20tMenuItemSlidingMenuiib: REGION-PASS (402 insns) [NFS4-R-AU]
DrawBackground__18tScreenTrackSelect: REGION-PASS (301 insns) [NFS4-R-AU]
MPause_MusicLogic__Fc: REGION-PASS (192 insns) [NFS4-R-USA]
Render_InitBlurMode__Fv: REGION-PASS (27 insns) [NFS4-R-USA]
Render_RenderWorld__FP13DRender_tView: REGION-PASS (41 insns) [NFS4-R-USA]
Render_Render__Fi: REGION-PASS (82 insns) [NFS4-R-USA]
Init_MemcardFile__FR12MCRDFILE_defsb: REGION-PASS (32 insns) [NFS4-R-AU]
Init_Memcard__FbT0: REGION-PASS (90 insns) [NFS4-R-AU]
Platform_SysStartUp__Fv: REGION-PASS (58 insns) [NFS4-R-USA]
func_8009A5B0: REGION-PASS (44 insns) [NFS4-R-AU]
func_800A77E8: REGION-PASS (10 insns) [NFS4-R-AU]
func_800A7828: REGION-PASS (8 insns) [NFS4-R-AU]
```

Exact command lines used (one per candidate):
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/eaclib/psx/eacpsxz/cdfs.c CD_Read,CD_systaskfunc,CD_timerfunc,CdReadyHandler --lane-as=recon/eaclib/psx/eacpsxz/cdfs.c
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/feapp.cpp DrawHelpIcons__14tFEApplication,Redraw__14tFEApplication --lane-as=recon/frontend/common/feapp.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/femenuoptions.cpp Draw__20tMenuItemSlidingMenuiib --lane-as=recon/frontend/common/femenuoptions.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/screentracks.cpp DrawBackground__18tScreenTrackSelect --lane-as=recon/frontend/common/screentracks.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/mpause.cpp MPause_MusicLogic__Fc --lane-as=recon/game/common/mpause.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/render.cpp Render_InitBlurMode__Fv,Render_RenderWorld__FP13DRender_tView,Render_Render__Fi --lane-as=recon/game/common/render.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/fememcard.cpp Init_MemcardFile__FR12MCRDFILE_defsb,Init_Memcard__FbT0 --lane-as=recon/frontend/common/fememcard.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/platform.cpp Platform_SysStartUp__Fv --lane-as=recon/game/psx/platform.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_8009A5B0.cpp func_8009A5B0 --lane-as=recon/game/common/render.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A77E8.cpp func_800A77E8 --lane-as=recon/game/common/render.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A7828.cpp func_800A7828 --lane-as=recon/game/common/render.cpp
```
(The three REGION-ONLY leaves are standalone TUs with no base unit; `--lane-as`
is passed only to pick a C++ lane, and the manifest default resolves the same way.)

## Falsified angles / dead ends

None needed — every one of the five open rows fell on the first or second measured
edit. Worth recording as *negative* findings for the wave:
- **No coloring/scheduling grind was required anywhere in this belt.** All five
  deltas were pure SEMANTIC changes (deleted call blocks, widened boolean gates,
  a constant, an extra call, a `+8`). The "measure the unedited seed first" rule
  paid for itself on every row: the seed diff pointed straight at the delta, and
  the m2c reference named it.
- **`Redraw__14tFEApplication` is a documented 10-diff near-miss in the BASE tree**
  (its long in-source W60→W74 receipt describes the scratchpad address-window
  residual and ~25 falsified spellings). The JPN build's shorter frame lands in a
  different basin and the residual is simply **not present** — REGION-PASS with the
  base body's `pc`/`pal2` carriers untouched. So an unmatched base fn does NOT
  imply an unmatchable regional row; gate the seed before assuming inheritance of
  the residual.

## Compliance

- No git operations. No edits to `tools/*.py`, `regiondiff/tools/*.py`,
  `MANIFEST.tsv`, `REGION_PROGRESS.txt`, `.github/**`, or the memory dir.
- `update_region_progress.py` NOT run (per wave rule).
- Base tree untouched: `git status` over `recon/ src/ asm/ configs/ include/` shows
  only the three pre-existing user-live probes (`syslib/psx/libcd/stcdint.c`,
  `libgpu/FONT.c`, `libmcrd/LIBMCRD.c`) — none of them read or written by R06.
- Files R06 created/edited, all under `regiondiff/recon/`:
  `NFS4-R-JPN/frontend/common/feapp.cpp` (new),
  `NFS4-R-AU/frontend/common/femenuoptions.cpp` (new),
  `NFS4-R-AU/frontend/common/fememcard.cpp` (new).
  The other 6 candidates were pre-existing and were only re-gated, not edited.
- No `volatile` and no `__asm__` introduced; no `register ... asm("$N")` pins; no
  post-compile instruction moves. (The pre-existing `SavingDataProc` volatile cast
  and `ticks`/`MEMCARDFRONTENDISINITTED` asm-label redecls in fememcard.cpp are
  inherited base-TU state, carried verbatim and not extended.)
- Naming: the one new callee introduced (`func_800DCED0`, region-only) keeps its
  mechanical `func_<region_va>` name with an `[INFERRED]` identity-TBD comment;
  no regional address was resolved through `configs/symbol_addrs.txt` — every
  identification came from the regional EXE bytes, the m2c slice, or `INDEX.tsv`.
