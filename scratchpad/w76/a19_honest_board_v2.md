# W76-A19 — HONEST OPEN LIST v2 (every sub-100% MATCH_PROGRESS row, gated with verify_asm)

Generated 2026-08-23 by `scratchpad/w75/a19/honest_scan.py` against the board committed at
`52cd5920` (the W75 wave commit regenerated MATCH_PROGRESS.txt — timestamp 16:52).
44 sub-100% rows scanned; raw output `scratchpad/w76/a19/honest_scan_v2_raw.txt`.
**verify_asm is the sole seal authority; the board's fuzzy% is triage only.**

## HEADLINE
* **34 genuinely open, 10 gate-PASS.**
* The 8 W75 staleness rows (firstfile, _pad_getbyte, Hud_BuildMapMarkers, MemCardDeleteFile,
  DrawW_BuildObjectFacets, DrawC_Prim, __adddf3, CD_cw) are **all gone from the committed
  board** — resolved as predicted.  Six of them were additionally word-compared this belt
  (objdump word streams, reloc fields zeroed): **all word-exact, 0 differing**.
* **Every 2026 gate-PASS/sub-100 row below was word-compared: ALL WORD-EXACT.  No new gate
  blind spots exist on the current board** (contrast W75, which found 2: the raw40
  `move`→`or` class and the branch-word class, both fixed).
* `_gpu_que_drain` (board 97.17%) has flipped the other way: it now genuinely FAILS 6 —
  this is the W75 policy-withdrawn row-reachable PASS (BRIEF policy #1).  Reclassified open.

## A. GATE-PASS ROWS (board reads sub-100%) — 10 of 44, all accounted
| board % | unit | function | wordcmp verdict |
|---|---|---|---|
| 99.28% | frontend/common/feapp | Redraw__14tFEApplication | word-exact (448 entries, 0 diff) |
| 97.70% | game/common/aih_basicperp | CheckChaserPosition__16AIHigh_BasicPerpii | word-exact |
| 99.82% | game/common/aih_btccop | HighExecute__18AIHigh_BTC_Wingman | **word-exact after normalization**: the EXPECTED object materializes `.L8005E390`/`.L8005E448` as real symbols splitting the fn + carries R_MIPS_PC16 on the branch into them (ours resolves it) — 675/675 insns, 0 differing.  The 0.18% board deficit is this expected-side artifact (W52 fix_symsizes/interior-alabel family), not recon bytes. |
| 99.76% | game/common/nfs3 | NFS3_CheckForFileOperations__Fv | word-exact |
| 99.60% | game/psx/drawc | DrawC_PrimClip__…P13Draw_CarCache | word-exact (1886 entries) — measured on the CURRENT peer-modified working drawc.cpp |
| 97.97% | game/psx/draww | DrawW_BuildCustomObjectFacets__… | word-exact |
| 99.09% | game/psx/draww | DrawW_BuildSpikeBelt__… | word-exact |
| 99.99% | game/psx/hud | Hud_Init__Fv | skipped per orchestrator — word explained in scratchpad/w76/A4_report.md |
| 91.72% | syslib/psx/libetc/INTR | _intrhand | word-exact |
| 99.85% | syslib/psx/libetc/INTR | _set_intr_callback | word-exact |

⇒ all 10 are **board staleness / expected-side representation** — a board regen
(`update_match_progress.py`) clears them; none needs a source fix.

## B. GENUINELY OPEN — 34 of 44
| board % | unit | function | verify_asm |
|---|---|---|---|
| 98.17% | frontend/common/feaudio | FeAudio_InitViv__FPc | FAIL 2 (109/109) |
| 99.91% | frontend/common/front | GetPSXPadValue__Fii | FAIL 12 (222/222) |
| 95.72% | frontend/common/femenudefs | __15tGlobalMenuDefs | FAIL 1138 (3215/3207) |
| 89.60% | frontend/psx/psxfront | FontUpsideDownBlit__FiiPviiP12charactertbli | FAIL 20 (82/82) |
| 92.50% | game/common/aih_opp | CheckForWipeOut__15AIHigh_Opponent | FAIL 9 (121/120) |
| 99.92% | game/common/aih_cop | HighExecute__10AIHigh_Cop | FAIL 20 (1460/1460) |
| 99.47% | game/common/aiphysic | AIPhysic_OutOfControlPhysics__FP8Car_tObj | FAIL 5 (413/412) |
| 99.95% | game/common/bworld | SetupChunkBuildList__FP13DRender_tView | FAIL 4 (203/203) |
| 90.57% | game/common/newton | Newton_DoPostBarrierCollisionHandling__… | FAIL 2 (106/106) |
| 99.66% | game/common/stats | Stats_TrackEndGame__Fv | FAIL 12 (232/232) |
| 99.69% | game/psx/cario | CarIO_ReadInCarTextureData__FPcP8Car_tObjii | FAIL 19 (492/491) |
| 98.97% | game/psx/draww | DrawW_SubdividFacet__… | FAIL 8 (588/588) |
| 98.31% | game/psx/draww | DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry | FAIL 9 (358/359) |
| 95.28% | game/psx/draww | Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark | FAIL 20 (353/353) |
| 99.56% | game/psx/draww | DrawW_OnyxLinePrim__… | FAIL 66 (507/507) |
| 96.51% | game/psx/hrzsku | Hrz_BuildSky__Fv | FAIL 146 (458/458) |
| 99.08% | game/psx/hrzsku | Hrz_BuildHorizon__FP13DRender_tView | FAIL 12 (473/473) |
| 93.26% | game/psx/hud | Hud_BuildNumbers__Fi | FAIL 188 (758/758) |
| 99.65% | game/psx/hud | Hud_BuildCdPlayer__Fii | FAIL 1 (476/475) |
| 95.49% | game/psx/hud | Hud_RenderTacView__Fv | FAIL 11 (72/71) |
| 93.73% | game/psx/overlays | RaceStatistics__Fv | FAIL 70 (475/475) |
| 95.28% | game/psx/night | Night_CreateNightTableElement__FiliPUc | FAIL 26 (113/113) |
| 97.15% | game/psx/psxcontroller | InGame_GetPSXPadValue__Fii | FAIL 76 (235/233) |
| 99.38% | syslib/psx/libc/SPRINTF | sprintf | FAIL 25 (546/545) |
| 99.79% | eaclib/psx/eacpsxz/asinfunc | intarcsin | FAIL 2 (48/48) — W76 receipt in-file: multi-block-base family + pin route both falsified; floor receipt with complete falsification field |
| 97.17% | syslib/psx/libgpu/SYS | _gpu_que_drain | FAIL 6 (152/152) — W75 policy-withdrawn PASS, reclassified open |
| 99.17% | syslib/psx/libmath/DIVDF3 | __divdf3 | FAIL 2 (184/184) |
| 98.99% | syslib/psx/libgpu/FONT | FntFlush | FAIL 2 (199/199) |
| 92.88% | syslib/psx/libcd/stcdint | _st_dma | FAIL 1 (107/106) |
| 95.70% | syslib/psx/libmcrd/LIBMCRD | MemCardGetDirentry | FAIL 23 (153/152) |
| 97.96% | syslib/psx/libmcrd/LIBMCRD | MemCardCreateFile | FAIL 4 (130/130) |
| 99.10% | syslib/psx/libcd/cdread | _read_issue | FAIL 3 (121/122) |
| 99.65% | eaclib/psx/sndpsxz/sdmemman | iSNDpsxmalloc | FAIL 12 (127/127) — W76 receipt in-file: cluster (iii) now STRUCTURALLY BOUNDED (fold keeps %hi live ⇒ retail's self-temp unreachable by conflict); all zero-insn fold-killers receipted dead |
| 91.72→78.60% | syslib/psx/libetc/INTR_DMA | func_80106878 | FAIL 36 (41/43) |

### Caveats
* Diff counts are verify_asm's normalized LCS count — NON-MONOTONE (09K); judge structural
  moves on insn count + structure.
* `recon/game/psx/drawc.cpp` is mid-edit by a concurrent session (`git status` M) — its rows
  re-baseline before use.
* Tool gap found in `scratchpad/w75/a19/objdiff_fn.py` (the wordcmp promotion candidate):
  (1) branch TEXT is compared with objdump's absolute addresses → false "differing" rows
  when the fn sits at different section offsets (words identical); normalize branch text to
  relative form like j/jal.  (2) It stops at the next symbol → truncates expected-side fns
  split by materialized `.L` labels; follow `.L*` continuation blocks.  (3) R_MIPS_PC16 must
  zero the low 16 on BOTH sides (ours resolves what expected relocates).  The corrected
  inline comparer used this belt is embedded in `scratchpad/w76/a19/wordcmp_v2.txt`'s
  generator (see A19_report §4).
* The third gate blind spot (reloc TARGET identity, W64-16D) remains out of scope of this
  scan — `tools/calltarget_audit.py` is the standing check.
