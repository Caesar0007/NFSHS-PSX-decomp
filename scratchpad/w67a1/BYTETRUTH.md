# W67-A1 BYTETRUTH -- vendor(psyq43) vs retail nfs4-f.exe
comparison: reloc-masked word compare (w62 RELOP); '-'=vendor unlinked field

## LIBETC (psyq43 vendor objects)

$Id inventory:
- INTR: `$Id: intr.c,v 1.75 1997/02/07 09:00:36 makoto Exp $`

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| HWCONFIG | get_hwconfig | export | 64 | 15 | - | **absent** |
| INTR | ResetCallback | export | 12 | 2 | 0x800F284C | **reloc-only** |
| INTR | InterruptCallback | export | 12 | 2 | 0x800F287C | **reloc-only** |
| INTR | DMACallback | export | 12 | 2 | 0x800F28AC | **reloc-only** |
| INTR | VSyncCallback | export | 13 | 2 | 0x800F28DC | **reloc-only** |
| INTR | VSyncCallbacks | export | 12 | 2 | 0x800F2910 | **reloc-only** |
| INTR | StopCallback | export | 12 | 2 | 0x800F2D58 | **drifted(12)** |
|  |  |  |  |  |  | drift @words 0,1,2,3,4,5,6,7,8,9,10,11 |
| INTR | RestartCallback | export | 12 | 2 | 0x800F2DF8 | **drifted(12)** |
|  |  |  |  |  |  | drift @words 0,1,2,3,4,5,6,7,8,9,10,11 |
| INTR | CheckCallback | export | 4 | 2 | 0x800F2940 | **reloc-only** |
| INTR | GetIntrMask | export | 6 | 2 | - | **absent** |
| INTR | SetIntrMask | export | 337 | 96 | 0x800F2950 | **reloc-only** |
| INTR_DMA | startIntrDMA | export | 168 | 35 | 0x801066AC | **reloc-only** |
| INTR_VB | startIntrVSync | export | 72 | 20 | 0x80106534 | **reloc-only** |
| PAD | PadInit | export | 19 | 9 | - | **absent** |
| PAD | PadRead | export | 10 | 3 | - | **absent** |
| PAD | PadStop | export | 11 | 1 | - | **absent** |
| VMODE | SetVideoMode | export | 5 | 4 | 0x800F1770 | **reloc-only** |
| VMODE | GetVideoMode | export | 7 | 2 | 0x800F1784 | **reloc-only** |
| VSYNC | VSync | export | 132 | 42 | 0x800F231C | **reloc-only** |

### LIBETC ANALYSIS (resolved)

- **INTR.obj = intr.c $Id v1.75** — byte-identical member in psyq43 AND the SpongeBob
  drop (md5 420c6e2ffae5, 8181 B). Retail carries this object's .text byte-exactly
  (reloc-masked) over 0x800F284C..0x800F2E94 **except** retail's variant DROPS three
  compat exports present in v1.75: the `StopCallback`/`RestartCallback` jalr-thunks
  (vendor .text 0xF4/0x124) and `GetIntrMask` (0x164) — 0x78 bytes elided; every
  fn after shifts down by 0x78. The retail MAP names `StopCallback`@0x800F2D58 /
  `RestartCallback`@0x800F2DF8 are the REAL implementations that exist in BOTH
  vendor and retail after the statics (vendor: unnamed statics; matched reloc-only).
  => the two `drifted(12)` rows above are the vendor THUNKS compared against
  retail's same-NAMED different fns — not code drift. Retail INTR is a
  v1.75-derived build with the thunk block removed (v1.76 candidate; xenogears
  carries v1.76 per W66 15F).
- **Statics region ground truth for A2** (all reloc-only, annotated in
  `truth/LIBETC/SetIntrMask.txt`): SetIntrMask(6w) -> _initIntr(0x2968) ->
  **_intrhand(0x2A40)** -> _set_intr_callback(0x2C10) -> StopCallback(0x2D58) ->
  RestartCallback(0x2DF8) -> _bzero_w(0x2E70).
- INTR_VB (`startIntrVSync` + helpers 1-3), INTR_DMA (`startIntrDMA` + `_dma_isr`),
  VMODE, VSYNC (incl `_VSync_wait`): **all reloc-only**.
- PAD / PADSTOP / HWCONFIG: absent from retail (NFS4 uses libpad).

## LIBGPU (psyq43 vendor objects)

$Id inventory:
- SYS: `$Id: sys.c,v 1.140 1998/01/12 07:52:27 noda Exp yos $`

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| BREAK | BreakDraw | export | 37 | 6 | - | **absent** |
| BREAK | IsIdleGPU | export | 24 | 3 | - | **absent** |
| BREAK | ContinueDraw | export | 95 | 19 | - | **absent** |
| EXT | LoadTPage | export | 58 | 6 | - | **absent** |
| EXT | LoadClut | export | 25 | 2 | - | **absent** |
| EXT | LoadClut2 | export | 25 | 2 | - | **absent** |
| EXT | SetDefDrawEnv | export | 45 | 2 | 0x800F222C | **reloc-only** |
| EXT | SetDefDispEnv | export | 15 | 0 | 0x800F22E0 | **identical** |
| FONT | SetDumpFnt | export | 16 | 8 | - | **absent** |
| FONT | FntLoad | export | 40 | 13 | - | **absent** |
| FONT | FntOpen | export | 174 | 57 | - | **absent** |
| FONT | FntFlush | export | 199 | 18 | 0x800F6D18 | **reloc-only** |
| FONT | FntPrint | export | 243 | 20 | 0x800F7034 | **reloc-only** |
| KPRINTF | KanjiFntOpen | export | 196 | 63 | - | **absent** |
| KPRINTF | KanjiFntClose | export | 7 | 6 | - | **absent** |
| KPRINTF | KanjiFntFlush | export | 243 | 56 | - | **absent** |
| KPRINTF | KanjiFntPrint | export | 282 | 23 | - | **absent** |
| KROM2TIM | GetTimSize | export | 43 | 2 | - | **absent** |
| KROM2TIM | Krom2Tim | export | 321 | 15 | - | **absent** |
| KTRANS | Krom2RawAdd2 | export | 43 | 7 | - | **absent** |
| KTRANS | kanjitrans | export | 331 | 47 | - | **absent** |
| KTRANS | hankanjitrans | export | 78 | 17 | - | **absent** |
| OTAG | DrawOTagIO | export | 42 | 2 | - | **absent** |
| OTAG | DumpOTag | export | 124 | 39 | - | **absent** |
| OTAG | CheckPrim | export | 74 | 17 | - | **absent** |
| P00 | GetTPage | export | 16 | 0 | 0x800F1BFC | **identical** |
| P01 | GetClut | export | 8 | 0 | 0x800F4450 | **identical** |
| P02 | DumpTPage | export | 24 | 4 | - | **absent** |
| P03 | DumpClut | export | 16 | 4 | - | **absent** |
| P04 | NextPrim | export | 8 | 0 | - | **absent** |
| P05 | IsEndPrim | export | 8 | 0 | - | **absent** |
| P06 | AddPrim | export | 16 | 0 | 0x80107040 | **identical** |
| P07 | AddPrims | export | 16 | 0 | - | **absent** |
| P08 | CatPrim | export | 12 | 0 | - | **absent** |
| P09 | TermPrim | export | 8 | 0 | 0x80107020 | **identical** |
| P10 | SetSemiTrans | export | 12 | 1 | 0x800F30FC | **reloc-only** |
| P11 | SetShadeTex | export | 12 | 1 | 0x800F611C | **reloc-only** |
| P12 | SetPolyF3 | export | 8 | 0 | 0x800F35F0 | **identical** |
| P13 | SetPolyFT3 | export | 8 | 0 | - | **absent** |
| P14 | SetPolyG3 | export | 8 | 0 | - | **absent** |
| P15 | SetPolyGT3 | export | 8 | 0 | - | **absent** |
| P16 | SetPolyF4 | export | 8 | 0 | 0x800F3610 | **identical** |
| P17 | SetPolyFT4 | export | 8 | 0 | 0x800F3650 | **identical** |
| P18 | SetPolyG4 | export | 8 | 0 | 0x800F3630 | **identical** |
| P19 | SetPolyGT4 | export | 8 | 0 | 0x800F3490 | **identical** |
| P20 | SetSprt8 | export | 8 | 0 | - | **absent** |
| P21 | SetSprt16 | export | 8 | 0 | - | **absent** |
| P22 | SetSprt | export | 8 | 0 | - | **absent** |
| P23 | SetTile1 | export | 8 | 0 | - | **absent** |
| P24 | SetTile8 | export | 8 | 0 | - | **absent** |
| P25 | SetTile16 | export | 8 | 0 | - | **absent** |
| P26 | SetTile | export | 8 | 0 | - | **absent** |
| P27 | SetLineF2 | export | 8 | 0 | - | **absent** |
| P28 | SetLineG2 | export | 8 | 0 | - | **absent** |
| P29 | SetLineF3 | export | 8 | 0 | - | **absent** |
| P30 | SetLineG3 | export | 12 | 0 | - | **absent** |
| P31 | SetLineF4 | export | 8 | 0 | - | **absent** |
| P32 | SetLineG4 | export | 12 | 0 | - | **absent** |
| P33 | SetDrawTPage | export | 12 | 0 | - | **absent** |
| P34 | SetDrawMove | export | 24 | 0 | 0x8010C698 | **identical** |
| P35 | SetDrawLoad | export | 28 | 0 | - | **absent** |
| P36 | MargePrim | export | 16 | 1 | - | **absent** |
| P37 | DumpDrawEnv | export | 66 | 24 | - | **absent** |
| P37 | DumpDispEnv | export | 42 | 16 | - | **absent** |
| PARAM | GetDrawMode | export | 23 | 3 | - | **absent** |
| PARAM | GetTexWindow | export | 13 | 1 | - | **absent** |
| PARAM | GetDrawArea | export | 18 | 2 | - | **absent** |
| PARAM | GetDrawOffset | export | 26 | 5 | - | **absent** |
| SYS | ResetGraph | export | 93 | 32 | 0x800ED670 | **reloc-only** |
| SYS | SetGraphDebug | export | 23 | 6 | - | **absent** |
| SYS | SetGraphQueue | export | 41 | 9 | - | **absent** |
| SYS | GetGraphDebug | export | 4 | 2 | - | **absent** |
| SYS | DrawSyncCallback | export | 24 | 6 | - | **absent** |
| SYS | SetDispMask | export | 38 | 9 | 0x800ED7E4 | **reloc-only** |
| SYS | DrawSync | export | 97 | 22 | 0x800ED87C | **reloc-only** |
| SYS | ClearImage | export | 36 | 5 | 0x800EDA00 | **reloc-only** |
| SYS | ClearImage2 | export | 38 | 5 | - | **absent** |
| SYS | LoadImage | export | 24 | 5 | 0x800EDA90 | **reloc-only** |
| SYS | StoreImage | export | 24 | 5 | 0x800EDAF0 | **reloc-only** |
| SYS | MoveImage | export | 46 | 8 | 0x800EDB50 | **reloc-only** |
| SYS | ClearOTag | export | 50 | 10 | - | **absent** |
| SYS | ClearOTagR | export | 43 | 12 | 0x800EDC08 | **reloc-only** |
| SYS | DrawPrim | export | 23 | 4 | - | **absent** |
| SYS | DrawOTag | export | 28 | 8 | 0x800EDCB4 | **reloc-only** |
| SYS | PutDrawEnv | export | 48 | 10 | 0x800EDD24 | **reloc-only** |
| SYS | DrawOTagEnv | export | 54 | 10 | - | **absent** |
| SYS | GetDrawEnv | export | 13 | 3 | - | **absent** |
| SYS | PutDispEnv | export | 318 | 39 | 0x800EDDE4 | **reloc-only** |
| SYS | GetDispEnv | export | 13 | 3 | - | **absent** |
| SYS | GetODE | export | 12 | 2 | - | **absent** |
| SYS | SetTexWindow | export | 14 | 1 | 0x800EE2DC | **reloc-only** |
| SYS | SetDrawArea | export | 32 | 2 | 0x800EE314 | **reloc-only** |
| SYS | SetDrawOffset | export | 16 | 1 | - | **absent** |
| SYS | SetPriority | export | 10 | 0 | - | **absent** |
| SYS | SetDrawStp | export | 10 | 1 | 0x800EE394 | **reloc-only** |
| SYS | SetDrawMode | export | 21 | 2 | 0x800EE3BC | **reloc-only** |
| SYS | SetDrawEnv | export | 1600 | 433 | 0x800EE410 | **reloc-only** |
| SYS | LoadImage2 | export | 59 | 21 | - | **absent** |
| SYS | StoreImage2 | export | 59 | 21 | - | **absent** |
| SYS | MoveImage2 | export | 81 | 24 | - | **absent** |
| SYS | DrawOTag2 | export | 84 | 27 | 0x800EFD10 | **reloc-only** |
| TMD | OpenTIM | export | 4 | 2 | - | **absent** |
| TMD | ReadTIM | export | 25 | 8 | - | **absent** |
| TMD | OpenTMD | export | 16 | 9 | - | **absent** |
| TMD | ReadTMD | export | 1523 | 145 | - | **absent** |

### LIBGPU ANALYSIS (resolved)

- **ZERO DRIFT.** Every retail-linked LIBGPU fn = identical (11) or reloc-only (22).
- **SYS.obj = sys.c $Id v1.140** — the brief's exact NFS4 revision, CONFIRMED against
  retail bytes. The `SetDrawEnv` carve (1600 words, vendor .text tail) covers the
  ENTIRE static machinery reloc-only; 27 retail statics localized+annotated in
  `truth/LIBGPU/SetDrawEnv.txt` (+`DrawSync/ClearOTagR/PutDispEnv` spans):
  _set_drawenv, _set_draw_mode, _set_clip_tl/_br, _get_tw, _get_status,
  _clearOTagR_dma, _BlitClear, _dws, _drs, _send_gp0/gp1, _get_gp1, _get_gpuinfo,
  _gpu_dma_chain, _que_ref, _gpu_que_push/_drain, _reset, _sync,
  _gpu_arm_timeout/_check_timeout, _gpu_init_videomode, _install_drain_cb,
  _memset, _image. => the 04Y SYS.c clamp identity now has vendor-object ground
  truth: retail SYS *is* this v1.140 object, so every remaining SYS diff is
  OUR-side codegen, never revision skew.
- FONT: retail links only FntFlush + FntPrint (both reloc-only); FntLoad/FntOpen/
  SetDumpFnt not in retail MAP (absent).
- absent rows = not linked by NFS4 (BREAK/KANJI/TMD/PARAM/OTAG-extras etc.).
