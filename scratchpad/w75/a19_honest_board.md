# W75-A19 — HONEST OPEN LIST (every sub-100% MATCH_PROGRESS row, gated with verify_asm)

Generated 2026-08-23 by `scratchpad/w75/a19/honest_scan.py`
(objdiff.json unit → `metadata.source_path` → `python tools/verify_asm.py <tu> <fn>`).
53 sub-100% rows scanned. **verify_asm is the sole seal authority; the board's fuzzy% is triage only.**

---

## THE ACCOUNTING VERDICT (the belt's task 4)

**objdiff does NOT under-count RAW40-spliced functions, and there is no lane gap.**
`tools/update_match_progress.py` runs `tools/build.py` and then `objdiff-cli report generate`
over `objdiff.json`, whose `base_path` for every unit is the SAME `build/recon/**.o` object
that `tools/verify_asm.py` compiles through `build.compile_c`/`compile_cpp` — the RAW40
splice, TEXT_MOVES, epilogue-unfill and every other mechanism apply to both by construction
(this re-confirms W64-16A/A21). The sibling RAW40 function `_padInitDirSeq` reads 100.00%
on the board, which alone falsifies "the splice is penalized".

The two rows that were gate-PASS-but-sub-100 were **real byte differences the GATE cannot
see**, in two different documented blind spots. Both are now fixed:

### 1. `firstfile` 94.17% — the `move`-spelled-as-`or` class (catalog 04M's named gap)
```
ours    00809025  move s2,a0      <- or  rd,rs,$0   (0x25)
retail  00809021  move s2,a0      <- addu rd,rs,$0  (0x21)
```
×10 words. maspsx rewrites `move` → `addu rD,rS,$zero` on every normal-lane object
(`tools/maspsx/maspsx/__init__.py::expand_move`) and `_compile_c_272` does the same textually
— but `compile_c`'s **raw40 branch hands the PsyQ-4.0 cc1's raw text straight to GNU as**,
which spells the `move` pseudo as `or`. The gate is blind because verify_asm normalizes
`move r,r2` ↔ `addu r,r2,zero` in both directions AND objdump prints the `or` form as `move`,
so the two streams are textually identical.
**FIX (tool-side, gate untouched):** apply the existing `_MOVE_RE` rewrite to the spliced
region in `build.py`'s raw40 branch. Objdump word-compare **10 differing → 0**; `firstfile`
and `_first_patch` gate PASS 103/103 and 64/64, TU 2/2 PASS, gated twice; `_padInitDirSeq`
(the other raw40 fn) unchanged at 0 differing.

### 2. `_pad_getbyte` 99.89% — the class-d branch-word blind spot
One `j` word. The `M` arm jumps to the DEFAULT arm's copy of the shared `lbu $2,0($2)` tail;
retail jumps to CASE 0's copy. Both copies exist in both objects and both continue to the
same `jr $ra`, so it is pure label selection — and verify_asm normalizes every branch target
to `T`, so the gate reads PASS.
**Why no source form reaches it:** case 0 carries the W71-A15 read-only fence *between* its
`lbu` and its `return` (that fence is what won 5 → PASS). An `__asm__` with no outputs is
implicitly volatile, and `find_cross_jump` (jump.c:2632-35) refuses a volatile `ASM_OPERANDS`
— so `M` can never merge onto case 0's copy. Giving the DEFAULT arm the same fence blocks
that merge too (measured 3 diffs @50 insns) instead of redirecting it.
**FIX:** one `PER_FN_BRANCH_RETARGET` row (plants a fresh label at case 0's `lbu`, re-points
only the `M` arm's `j`, removes nothing). Word-compare **1 differing → 0**, gate PASS 47/47
twice, TU 8/8 PASS twice, `tools/brdist.py` clean (8 fns, 0 divergence — the 17C pairing).

### 3. Everything else in section A below is BOARD STALENESS
`MATCH_PROGRESS.txt` only moves when `update_match_progress.py` is re-run (full build +
report). Peers land seals continuously during a wave, so re-generate the board before
treating any section-A row as work. (W48/W52/W61 all recorded stale-row epidemics; "baseline
first" is the standing rule.)

---

## A. GATE-PASS ROWS (board reads sub-100%) — 10 of 53

| board % | unit | function | verify_asm |
|---|---|---|---|
|  94.14% | syslib/psx/libgpu/SYS      | _gpu_que_drain                                             | PASS (152 insns) |
|  94.17% | syslib/psx/libapi/FIRST    | firstfile                                                  | PASS (103 insns) — **fixed, now word-exact** |
|  96.17% | game/psx/hud               | Hud_BuildMapMarkers__Fi                                    | PASS (308 insns) |
|  98.19% | syslib/psx/libmcrd/LIBMCRD | MemCardDeleteFile                                          | PASS (111 insns) |
|  98.86% | game/psx/draww             | DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo | PASS (189 insns) |
|  99.69% | game/psx/drawc             | DrawC_Prim__FP10matrixtdef...P13Draw_CarCache               | PASS (1389 insns) |
|  99.73% | syslib/psx/libmath/ADDDF3  | __adddf3                                                   | PASS (221 insns) |
|  99.89% | syslib/psx/libpad/PADPORTD | _pad_getbyte                                               | PASS (47 insns) — **fixed, now word-exact** |
|  99.96% | syslib/psx/libcd/drv       | CD_cw                                                      | PASS (259 insns) |
|  99.99% | game/psx/hud               | Hud_Init__Fv                                               | PASS (624 insns) |

---

## B. GENUINELY OPEN ROWS — 43 of 53

| board % | unit | function | verify_asm |
|---|---|---|---|
|  78.60% | syslib/psx/libetc/INTR_DMA | func_80106878                                              | FAIL 36 diffs (ours 41 / oracle 43) |
|  89.60% | frontend/psx/psxfront      | FontUpsideDownBlit__FiiPviiP12charactertbli                | FAIL 20 diffs (ours 82 / oracle 82) |
|  90.57% | game/common/newton         | Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef | FAIL 23 diffs (ours 105 / oracle 106) |
|  91.64% | syslib/psx/libetc/INTR     | _intrhand                                                  | FAIL 20 diffs (ours 116 / oracle 116) |
|  92.50% | game/common/aih_opp        | CheckForWipeOut__15AIHigh_Opponent                         | FAIL 9 diffs (ours 121 / oracle 120) |
|  92.52% | game/psx/hud               | Hud_RenderTacView__Fv                                      | FAIL 13 diffs (ours 72 / oracle 71) |
|  92.74% | syslib/psx/libcd/stcdint   | _st_dma                                                    | FAIL 21 diffs (ours 107 / oracle 106) |
|  93.26% | game/psx/hud               | Hud_BuildNumbers__Fi                                       | FAIL 188 diffs (ours 758 / oracle 758) |
|  93.73% | game/psx/overlays          | RaceStatistics__Fv                                         | FAIL 71 diffs (ours 474 / oracle 475) |
|  94.50% | frontend/common/femenudefs | __15tGlobalMenuDefs                                        | FAIL 1238 diffs (ours 3215 / oracle 3207) |
|  95.05% | game/psx/hrzsku            | Hrz_BuildSky__Fv                                           | FAIL 146 diffs (ours 458 / oracle 458) |
|  95.23% | game/psx/draww             | Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark                 | FAIL 20 diffs (ours 353 / oracle 353) |
|  95.28% | game/psx/night             | Night_CreateNightTableElement__FiliPUc                     | FAIL 26 diffs (ours 113 / oracle 113) |
|  95.53% | game/psx/draww             | DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache     | FAIL 30 diffs (ours 268 / oracle 268) |
|  95.70% | syslib/psx/libmcrd/LIBMCRD | MemCardGetDirentry                                         | FAIL 23 diffs (ours 153 / oracle 152) |
|  95.77% | game/psx/hud               | Hud_BuildTach__Fi                                          | FAIL 76 diffs (ours 269 / oracle 269) |
|  96.42% | syslib/psx/libmcrd/LIBMCRD | MemCardCreateFile                                          | FAIL 4 diffs (ours 130 / oracle 130) |
|  96.80% | game/psx/hud               | Hud_BuildCdPlayer__Fii                                     | FAIL 33 diffs (ours 476 / oracle 475) |
|  97.15% | game/psx/psxcontroller     | InGame_GetPSXPadValue__Fii                                 | FAIL 76 diffs (ours 235 / oracle 233) |
|  97.70% | game/common/aih_basicperp  | CheckChaserPosition__16AIHigh_BasicPerpii                  | FAIL 2 diffs (ours 85 / oracle 87) |
|  97.73% | syslib/psx/libmath/DIVDF3  | __divdf3                                                   | FAIL 6 diffs (ours 184 / oracle 184) |
|  98.17% | frontend/common/feaudio    | FeAudio_InitViv__FPc                                       | FAIL 2 diffs (ours 109 / oracle 109) |
|  98.20% | game/psx/hrzsku            | Hrz_BuildHorizon__FP13DRender_tView                        | FAIL 12 diffs (ours 473 / oracle 473) |
|  98.31% | game/psx/draww             | DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry            | FAIL 9 diffs (ours 358 / oracle 359) |
|  98.97% | game/psx/draww             | DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss | FAIL 8 diffs (ours 588 / oracle 588) |
|  98.99% | syslib/psx/libgpu/FONT     | FntFlush                                                   | FAIL 2 diffs (ours 199 / oracle 199) |
|  99.09% | syslib/psx/libc/SPRINTF    | sprintf                                                    | FAIL 25 diffs (ours 546 / oracle 545) |
|  99.10% | syslib/psx/libcd/cdread    | _read_issue                                                | FAIL 3 diffs (ours 121 / oracle 122) |
|  99.28% | frontend/common/feapp      | Redraw__14tFEApplication                                   | FAIL 10 diffs (ours 393 / oracle 393) |
|  99.39% | game/psx/drawc             | DrawC_PrimClip__FP10matrixtdef...P13Draw_CarCache          | FAIL 62 diffs (ours 1877 / oracle 1877) |
|  99.47% | game/common/aiphysic       | AIPhysic_OutOfControlPhysics__FP8Car_tObj                  | FAIL 5 diffs (ours 413 / oracle 412) |
|  99.56% | game/psx/draww             | DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache | FAIL 66 diffs (ours 507 / oracle 507) |
|  99.65% | eaclib/psx/sndpsxz/sdmemman | iSNDpsxmalloc                                             | FAIL 12 diffs (ours 127 / oracle 127) |
|  99.66% | game/common/stats          | Stats_TrackEndGame__Fv                                     | FAIL 12 diffs (ours 232 / oracle 232) |
|  99.69% | game/psx/cario             | CarIO_ReadInCarTextureData__FPcP8Car_tObjii                | FAIL 19 diffs (ours 492 / oracle 491) |
|  99.72% | game/psx/draww             | DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi | FAIL 6 diffs (ours 200 / oracle 200) |
|  99.76% | game/common/nfs3           | NFS3_CheckForFileOperations__Fv                            | FAIL 2 diffs (ours 21 / oracle 21) |
|  99.79% | eaclib/psx/eacpsxz/asinfunc | intarcsin                                                 | FAIL 2 diffs (ours 48 / oracle 48) |
|  99.82% | game/common/aih_btccop     | HighExecute__18AIHigh_BTC_Wingman                          | FAIL 4 diffs (ours 675 / oracle 675) |
|  99.85% | syslib/psx/libetc/INTR     | _set_intr_callback                                         | FAIL 4 diffs (ours 82 / oracle 82) |
|  99.91% | frontend/common/front      | GetPSXPadValue__Fii                                        | FAIL 12 diffs (ours 222 / oracle 222) |
|  99.92% | game/common/aih_cop        | HighExecute__10AIHigh_Cop                                  | FAIL 20 diffs (ours 1460 / oracle 1460) |
|  99.95% | game/common/bworld         | SetupChunkBuildList__FP13DRender_tView                     | FAIL 4 diffs (ours 203 / oracle 203) |

### Caveats
* The `game/psx/draww` rows could not be gated on the first pass (a concurrent session had
  `recon/game/psx/draww.cpp` mid-edit — `parse error at end of input`); the numbers above are
  from the re-run after it compiled again, and several of its rows moved a lot in the
  meantime — re-baseline before using them.
* Diff counts are verify_asm's normalized LCS count, which is NON-MONOTONE (09K) — judge a
  structural move on the instruction count and the structure, never on this number alone.
* A *third* gate blind spot exists and is NOT covered by this scan: reloc TARGET identity
  (W64-16D) — `tools/calltarget_audit.py` is the standing check for it.
