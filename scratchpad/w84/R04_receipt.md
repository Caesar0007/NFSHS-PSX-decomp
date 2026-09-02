# W84 R04 receipt — regional-variant matching

Agent W84-R04. Rows: `scratchpad/w84/R04_rows.tsv` (12 rows).
Gate (authoritative): `python regiondiff/tools/verify_region.py <REGION> <candidate> <fns> --lane-as=recon/<unit>.<ext>`

## Status table

| # | function | region | class | status |
|---|---|---|---|---|
| 1 | R3DCar_InsertCarFacetII__FP8Car_tObj | USA | CHANGED | **REGION-PASS (382)** |
| 2 | R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView | USA | CHANGED | FAIL 6 — **all 6 are oracle-generator artifacts; the 1153 real instructions match 1:1** |
| 3 | CD_get_intr | USA | CHANGED | **REGION-PASS (343)** (unedited base-TU seed) |
| 4 | DoLanguageScreen__Fv | UK-ES-IT | CHANGED | FAIL 50 (193/193, structure + all callee-saved regs match) |
| 5 | Draw_CheckFirstFrameRender__Fv | AU | CHANGED | **REGION-PASS (36)** |
| 6 | Draw_DirectSetEnvironment__Fiiiiiiiiii | AU | CHANGED | **REGION-PASS (69)** |
| 7 | Draw_InitRenderEngine__Fiiiiii | AU | CHANGED | **REGION-PASS (47)** |
| 8 | DrawCar__FR8tCarInfossffcbUl7tPlayer | AU | CHANGED | **REGION-PASS (125)** (pre-existing candidate, re-gated green) |
| 9 | func_800BB2F4 | USA | REGION-ONLY | **REGION-PASS (57)** (pre-existing, re-gated green) |
| 10 | func_8009A5AC | USA | REGION-ONLY | **REGION-PASS (44)** (pre-existing, re-gated green) |
| 11 | func_800A77E4 | USA | REGION-ONLY | **REGION-PASS (10)** (pre-existing, re-gated green) |
| 12 | func_800A7868 | AU | REGION-ONLY | **REGION-PASS (8)** (pre-existing, re-gated green) |

**10 of 12 rows REGION-PASS; row 2 is provably instruction-for-instruction identical
(its 6 residual diffs are lines the oracle GENERATOR injected, see appendix); row 4 is
FAIL 50 with an exact instruction count and every callee-saved register matching.**

Per-row detail lives in two appendices next to this file:
* `R04_receipt_rows12.md` — the two `r3dcar` rows @ USA (+ the jump-table oracle artifact).
* `R04_receipt_rows34.md` — `CD_get_intr` @ USA and `DoLanguageScreen` @ UK-ES-IT
  (incl. the new `do{}while(0)` LICM-shield lever).

Final gate sweep (all 12 rows, one run each):
```
  R3DCar_InsertCarFacetII__FP8Car_tObj: REGION-PASS (382 insns) [NFS4-R-USA]
  R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView: FAIL 6 diffs (ours 1153 / oracle 1159) [NFS4-R-USA]
  CD_get_intr: REGION-PASS (343 insns) [NFS4-R-USA]
  DoLanguageScreen__Fv: FAIL 50 diffs (ours 193 / oracle 193) [NFS4-R-UK-ES-IT]
  Draw_CheckFirstFrameRender__Fv: REGION-PASS (36 insns) [NFS4-R-AU]
  Draw_DirectSetEnvironment__Fiiiiiiiiii: REGION-PASS (69 insns) [NFS4-R-AU]
  Draw_InitRenderEngine__Fiiiiii: REGION-PASS (47 insns) [NFS4-R-AU]
  DrawCar__FR8tCarInfossffcbUl7tPlayer: REGION-PASS (125 insns) [NFS4-R-AU]
  func_800BB2F4: REGION-PASS (57 insns) [NFS4-R-USA]
  func_8009A5AC: REGION-PASS (44 insns) [NFS4-R-USA]
  func_800A77E4: REGION-PASS (10 insns) [NFS4-R-USA]
  func_800A7868: REGION-PASS (8 insns) [NFS4-R-AU]
```

Scope discipline: only the six candidate files under `regiondiff/recon/**` named by
`R04_rows.tsv` were written (four of them newly seeded). No base-tree, tool, manifest,
board, or memory-dir file was touched; no git operation was run;
`update_region_progress.py` was NOT run. Working copies of the intermediate
`psxfront.cpp` states are parked under `scratchpad/w84/r04/`.

---

## Rows 5-7 — `game/psx/draw` @ NFS4-R-AU (the PAL display-window delta) — SEALED

Candidate `regiondiff/recon/NFS4-R-AU/game/psx/draw.cpp` (seed = verbatim copy of
`recon/game/psx/draw.cpp`).

Seed measurement (the regional delta, `-` ours / `+` AU oracle):
```
Draw_CheckFirstFrameRender__Fv     FAIL 4  (36/36)  - li a3,240        + addu a3,a1,zero   (x2)
Draw_DirectSetEnvironment__F...    FAIL 6  (65/69)  + li v0,21; sh v0,34(sp); li v0,256; sh v0,38(sp)
Draw_InitRenderEngine__Fiiiiii     FAIL 8  (41/47)  + li v0,21; sh 34(s0),10(s0); li v0,256; sh 38(s0),14(s0)
```

**Regional delta (one line): the PAL build sets a 256-line display window** — every
`DISPENV.screen.y = 21` / `.screen.h = 256` (PAL top border + active lines), and
`Draw_CheckFirstFrameRender` passes height `0x100` instead of NTSC `0xf0`.

Decode of the raw offsets (no symbol lookup through the base layout — the offsets are
struct-internal, layout-independent):
* `Draw_DirectSetEnvironment`: the shared env buffer is at `sp+0x18`, so oracle
  `sh …,0x22(sp)` = buffer `+0xA` = `DISPENV.screen.y`, `sh …,0x26(sp)` = `+0xE` =
  `DISPENV.screen.h`. Matches the m2c reference's `sp22 = 0x15; sp26 = 0x100;`.
* `Draw_InitRenderEngine`: `s0` = `&gEnviro[0]`, `struct dflip` stride `0x18`
  (`DISPENV disp; char *server;` — the m2c ref's `unk14`/`unk2C` server stores confirm
  the stride). So `0xA/0xE` = page 0 and `0x22/0x26` = page 1 screen.y/.h.
* `Draw_CheckFirstFrameRender`: `addu a3,a1,zero` = the h argument reusing the y
  argument's register, i.e. both are `0x100`; the NTSC source's `0xf0` cannot produce it.

Fixes applied (source-level only; no volatile/asm/pins):
1. `Draw_CheckFirstFrameRender`: both `Draw_DirectSetEnvironment(...,0xf0,...)` → `...,0x100,...`.
   gcc then coalesces the shared `0x100` into `addu a3,a1,zero` on its own. → PASS.
2. `Draw_DirectSetEnvironment`: after `SetDefDispEnv`, added
   `((DISPENV *)&e)->screen.y = 21; ((DISPENV *)&e)->screen.h = 256;`. → PASS.
3. `Draw_InitRenderEngine`: added the four page stores after the two `SetDefDispEnv`s.
   **STORE ORDER IS LOAD-BEARING**: `[0]` before `[1]` gave `FAIL 8 (47/47)` — the count
   was already exact and the only diffs were the four `sh` displacements pairwise swapped.
   Writing page **`[1]` first, then `[0]`, per constant** (`[1].y,[0].y,[1].h,[0].h`)
   reproduces the oracle's emission order exactly. → PASS.
   (Falsified angle: `[0]`-first source order, 8 diffs — pure ordering, no coloring
   component, so it was an ordering fix and not a lever hunt.)

Gate:
```
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/game/psx/draw.cpp \
  Draw_CheckFirstFrameRender__Fv,Draw_DirectSetEnvironment__Fiiiiiiiiii,Draw_InitRenderEngine__Fiiiiii \
  --lane-as=recon/game/psx/draw.cpp
  Draw_CheckFirstFrameRender__Fv: REGION-PASS (36 insns) [NFS4-R-AU]
  Draw_DirectSetEnvironment__Fiiiiiiiiii: REGION-PASS (69 insns) [NFS4-R-AU]
  Draw_InitRenderEngine__Fiiiiii: REGION-PASS (47 insns) [NFS4-R-AU]
```

## Rows 8-12 — pre-existing candidates re-gated (no edits made)

```
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/screencarselect.cpp DrawCar__FR8tCarInfossffcbUl7tPlayer --lane-as=recon/frontend/common/screencarselect.cpp
  DrawCar__FR8tCarInfossffcbUl7tPlayer: REGION-PASS (125 insns) [NFS4-R-AU]
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800BB2F4.cpp func_800BB2F4   -> REGION-PASS (57)
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_8009A5AC.cpp func_8009A5AC   -> REGION-PASS (44)
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A77E4.cpp func_800A77E4   -> REGION-PASS (10)
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800A7868.cpp func_800A7868    -> REGION-PASS (8)
```
(Board `REGION_PROGRESS.txt` already listed these five as SEALED; confirmed still green.)
