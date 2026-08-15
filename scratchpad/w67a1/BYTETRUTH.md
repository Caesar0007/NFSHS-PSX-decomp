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

## LIBMCRD (psyq43 vendor objects)

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| BIOS | funcEvSpIOE | export | 5 | 2 | 0x80109550 | **reloc-only** |
| BIOS | funcEvSpError | export | 5 | 2 | 0x80109564 | **reloc-only** |
| BIOS | funcEvSpTimeout | export | 5 | 2 | 0x80109578 | **reloc-only** |
| BIOS | funcEvSpNewcard | export | 5 | 2 | 0x8010958C | **reloc-only** |
| BIOS | funcEvSpIOEx | export | 5 | 2 | 0x801095A0 | **reloc-only** |
| BIOS | funcEvSpErrorx | export | 5 | 2 | 0x801095B4 | **reloc-only** |
| BIOS | funcEvSpTimeoutx | export | 5 | 2 | 0x801095C8 | **reloc-only** |
| BIOS | funcEvSpNewcardx | export | 5 | 2 | 0x801095DC | **reloc-only** |
| BIOS | _card_open | export | 12 | 3 | 0x801095F0 | **reloc-only** |
| BIOS | _card_start | export | 119 | 67 | 0x80109620 | **reloc-only** |
| BIOS | _card_close | export | 8 | 1 | 0x801097FC | **reloc-only** |
| BIOS | _card_stop | export | 45 | 26 | 0x8010981C | **reloc-only** |
| BIOS | _clr_card_event | export | 66 | 52 | 0x801098D0 | **reloc-only** |
| BIOS | _get_card_event | export | 54 | 34 | 0x801099D8 | **reloc-only** |
| BIOS | _get_card_event_x | export | 54 | 34 | 0x80109AB0 | **reloc-only** |
| BIOS | _chk_card_event | export | 15 | 8 | 0x80109B88 | **reloc-only** |
| BIOS | _chk_card_event_x | export | 15 | 8 | 0x80109BC4 | **reloc-only** |
| LIBMCRD | MemCardInit | export | 11 | 5 | 0x800FAAAC | **reloc-only** |
| LIBMCRD | MemCardEnd | export | 8 | 1 | 0x800FAAD8 | **reloc-only** |
| LIBMCRD | MemCardStart | export | 20 | 7 | 0x800FAAF8 | **reloc-only** |
| LIBMCRD | MemCardStop | export | 16 | 4 | 0x800FAB48 | **reloc-only** |
| LIBMCRD | MemCardExist | export | 143 | 53 | 0x800FAB88 | **reloc-only** |
| LIBMCRD | MemCardAccept | export | 167 | 64 | 0x800FADC4 | **reloc-only** |
| LIBMCRD | MemCardOpen | export | 98 | 27 | - | **absent** |
| LIBMCRD | MemCardClose | export | 17 | 3 | - | **absent** |
| LIBMCRD | MemCardReadData | export | 125 | 41 | 0x800FB060 | **reloc-only** |
| LIBMCRD | MemCardWriteData | export | 125 | 41 | 0x800FB254 | **reloc-only** |
| LIBMCRD | MemCardReadFile | export | 136 | 40 | 0x800FB448 | **reloc-only** |
| LIBMCRD | MemCardWriteFile | export | 136 | 40 | 0x800FB668 | **reloc-only** |
| LIBMCRD | MemCardGetDirentry | export | 152 | 34 | 0x800FB888 | **reloc-only** |
| LIBMCRD | MemCardCallback | export | 5 | 2 | 0x800FBAE8 | **reloc-only** |
| LIBMCRD | MemCardSync | export | 71 | 14 | 0x800FBAFC | **reloc-only** |
| LIBMCRD | MemCardCreateFile | export | 130 | 38 | 0x800FBC18 | **reloc-only** |
| LIBMCRD | MemCardDeleteFile | export | 111 | 33 | 0x800FBE20 | **reloc-only** |
| LIBMCRD | MemCardFormat | export | 35 | 15 | 0x800FBFDC | **reloc-only** |
| LIBMCRD | MemCardUnformat | export | 122 | 22 | 0x800FC068 | **reloc-only** |
| USERFUNC | UserFuncInit | export | 4 | 2 | 0x80109C00 | **reloc-only** |
| USERFUNC | UserFuncOpen | export | 31 | 12 | 0x80109C10 | **reloc-only** |
| USERFUNC | UserFuncExecute | export | 27 | 10 | 0x80109C8C | **reloc-only** |
| USERFUNC | UserFuncComplete | export | 6 | 2 | 0x80109CF8 | **reloc-only** |

## LIBPAD (psyq43 vendor objects)

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| GUNHOOK | _InitGun | export | 29 | 14 | - | **absent** |
| GUNHOOK | _ExitGun | export | 28 | 11 | - | **absent** |
| GUNHOOK | _check_gun_flag | export | 4 | 2 | - | **absent** |
| GUNHOOK | _clear_gun_flag | export | 12 | 4 | - | **absent** |
| GUNHOOK | read_gun_v | export | 3 | 2 | - | **absent** |
| GUNHOOK | read_gun_h | export | 124 | 27 | - | **absent** |
| PADCMD | _padSetAct | export | 3 | 0 | 0x801055F0 | **identical** |
| PADCMD | _padSetCmd | export | 4 | 0 | - | **absent** |
| PADCMD | _padSendAtLoadInfo | export | 33 | 7 | 0x801055FC | **reloc-only** |
| PADCMD | _padRecvAtLoadInfo | export | 83 | 9 | 0x80105680 | **reloc-only** |
| PADCMD | _padGetActSize | export | 14 | 0 | 0x801057CC | **identical** |
| PADCMD | _padLoadActInfo | export | 252 | 29 | 0x80105804 | **reloc-only** |
| PADCMD | _padSetActAlign | export | 83 | 7 | 0x80105BF4 | **reloc-only** |
| PADCMD | _padSetMainMode | export | 83 | 12 | 0x80105D40 | **reloc-only** |
| PADCMD | _padCmdParaMode | export | 45 | 0 | 0x80105E8C | **identical** |
| PADENTRY | PadChkVsync | export | 8 | 1 | - | **absent** |
| PADENTRY | PadStartCom | export | 8 | 1 | 0x800EFE60 | **reloc-only** |
| PADENTRY | PadStopCom | export | 8 | 1 | 0x800EFE80 | **reloc-only** |
| PADENTRY | PadChkMtap | export | 19 | 5 | - | **absent** |
| PADENTRY | PadGetState | export | 48 | 5 | 0x800EFEA0 | **reloc-only** |
| PADENTRY | PadInfoMode | export | 62 | 10 | 0x800EFF60 | **reloc-only** |
| PADENTRY | PadInfoAct | export | 53 | 10 | 0x800F0058 | **reloc-only** |
| PADENTRY | PadInfoComb | export | 42 | 5 | - | **absent** |
| PADENTRY | PadSetActAlign | export | 14 | 3 | 0x800F012C | **reloc-only** |
| PADENTRY | PadSetMainMode | export | 18 | 3 | 0x800F0164 | **reloc-only** |
| PADENTRY | PadSetAct | export | 20 | 3 | 0x800F01AC | **reloc-only** |
| PADGUN | PadInitGun | export | 86 | 51 | - | **absent** |
| PADGUN | PadEnableGun | export | 3 | 2 | - | **absent** |
| PADGUN | PadRemoveGun | export | 395 | 145 | - | **absent** |
| PADMAIN | PadEnableCom | export | 70 | 30 | - | **absent** |
| PADMAIN | _padSetVsyncParam | export | 128 | 50 | 0x80104A1C | **reloc-only** |
| PADMAIN | _padChkVsync | export | 5 | 4 | - | **absent** |
| PADMAIN | _padStartCom | export | 51 | 23 | 0x80104C1C | **reloc-only** |
| PADMAIN | _padStopCom | export | 17 | 6 | 0x80104CE8 | **reloc-only** |
| PADMAIN | _padInitSioMode | export | 255 | 79 | 0x80104D2C | **reloc-only** |
| PADMAIN | _padSioRW | export | 118 | 23 | 0x80105128 | **reloc-only** |
| PADMAIN | _padSioRW2 | export | 142 | 20 | 0x80105300 | **reloc-only** |
| PADMAIN | _padClrIntSio0 | export | 36 | 9 | 0x80105538 | **reloc-only** |
| PADMAIN | _padWaitRXready | export | 10 | 2 | 0x801055C8 | **reloc-only** |
| PADPORTD | PadInitDirect | export | 408 | 89 | 0x800FDD28 | **reloc-only** |
| PADPORTM | PadInitMtap | export | 536 | 100 | - | **absent** |
| PADSEQD | _padInitDirSeq | export | 225 | 35 | 0x8010A0B0 | **reloc-only** |
| PADSEQD | _dirFailAuto | export | 67 | 4 | 0x8010A434 | **reloc-only** |
| PADSEQM | _padInitMtapSeq | export | 359 | 46 | - | **absent** |
| PADSEQM | _mtapFailAuto | export | 229 | 9 | - | **absent** |
| WAITRC2 | setRC2wait | export | 8 | 4 | 0x8010BFE8 | **reloc-only** |
| WAITRC2 | chkRC2wait | export | 40 | 12 | 0x8010C008 | **reloc-only** |

### LIBMCRD + LIBPAD ANALYSIS (resolved)

- **ZERO DRIFT on both.** All retail-linked fns reloc-only/identical.
- LIBMCRD: retail ELIDES `MemCardOpen`(98w)+`MemCardClose`(17w) — vendor
  MemCardAccept span ends exactly at retail MemCardReadData (same elide-and-shift
  pattern as LIBETC INTR's thunks: retail lib = slightly later revision, all
  shared code byte-identical). BIOS.obj (funcEvSp*, _card_*, events) + USERFUNC
  fully green — the w48 funcEvSp*/.data-attribute class now has vendor proof.
- LIBPAD: retail elides `PadChkVsync`, `PadChkMtap`, `PadInfoComb`, `_padSetCmd`,
  `_padChkVsync`, `PadEnableCom` (+ all GUN/MTAP members). Everything else green
  incl. the whole PADMAIN sio machinery and PadInitDirect (408w).

## LIBMATH (psyq43 vendor objects)

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| ADDDF3 | __adddf3 | export | 224 | 18 | 0x800F5A54 | **reloc-only** |
| ADDMANT | _add_mant_d | export | 44 | 0 | 0x80106F70 | **identical** |
| ADDSF3 | __addsf3 | export | 108 | 6 | - | **absent** |
| ARC | atan | export | 133 | 39 | - | **absent** |
| ARC | atan2 | export | 160 | 38 | - | **absent** |
| ARC | asin | export | 95 | 30 | - | **absent** |
| ARC | acos | export | 52 | 18 | - | **absent** |
| DBSHIFT | _dbl_shift | export | 48 | 1 | 0x80106E40 | **reloc-only** |
| DBSHIFTU | _dbl_shift_us | export | 48 | 1 | 0x801048E8 | **reloc-only** |
| DIVDF3 | __divdf3 | export | 184 | 15 | 0x800F5DD4 | **reloc-only** |
| DIVDF3 | _comp_mant | export | 20 | 1 | 0x800F60B4 | **reloc-only** |
| DIVSF3 | __divsf3 | export | 84 | 5 | 0x800F66E4 | **reloc-only** |
| EQDF2 | __eqdf2 | export | 20 | 0 | - | **absent** |
| EQSF2 | __eqsf2 | export | 12 | 0 | - | **absent** |
| EXP | exp | export | 140 | 36 | - | **absent** |
| EXTSFDF2 | __extendsfdf2 | export | 88 | 4 | 0x800F57C4 | **reloc-only** |
| FERR | _err_math | export | 28 | 7 | 0x80106A54 | **reloc-only** |
| FIXDFSI | __fixdfsi | export | 64 | 6 | 0x800F6834 | **reloc-only** |
| FIXSFSI | __fixsfsi | export | 48 | 6 | 0x800F3938 | **reloc-only** |
| FIXUDFSI | __fixunsdfsi | export | 68 | 7 | - | **absent** |
| FIXUSFSI | __fixunssfsi | export | 52 | 6 | - | **absent** |
| FLOOR | floor | export | 54 | 11 | - | **absent** |
| FLOOR | ceil | export | 122 | 29 | - | **absent** |
| FLTSIDF | __floatsidf | export | 64 | 2 | 0x800EB7E4 | **reloc-only** |
| FLTSISF | __floatsisf | export | 48 | 2 | 0x800F6224 | **reloc-only** |
| GEDF2 | __gedf2 | export | 56 | 2 | - | **absent** |
| GESF2 | __gesf2 | export | 40 | 1 | - | **absent** |
| GTDF2 | __gtdf2 | export | 56 | 2 | 0x800F0514 | **reloc-only** |
| GTSF2 | __gtsf2 | export | 40 | 1 | - | **absent** |
| HYPOT | hypot | export | 128 | 19 | - | **absent** |
| LDEXP | ldexp | export | 48 | 8 | - | **absent** |
| LDEXP | frexp | export | 76 | 10 | - | **absent** |
| LEDF2 | __ledf2 | export | 56 | 2 | - | **absent** |
| LESF2 | __lesf2 | export | 44 | 2 | - | **absent** |
| LOG | log | export | 144 | 31 | - | **absent** |
| LOG | log10 | export | 36 | 8 | - | **absent** |
| LTDF2 | __ltdf2 | export | 56 | 2 | 0x800EB8E4 | **reloc-only** |
| LTSF2 | __ltsf2 | export | 44 | 2 | - | **absent** |
| MAINASU | _mainasu | export | 28 | 1 | 0x80106F00 | **reloc-only** |
| MODF | modf | export | 40 | 4 | - | **absent** |
| MODF | fmod | export | 80 | 8 | - | **absent** |
| MULDF3 | __muldf3 | export | 197 | 17 | 0x800F62E4 | **reloc-only** |
| MULDF3 | _mul_mant_d | export | 59 | 2 | 0x800F65F8 | **reloc-only** |
| MULSF3 | __mulsf3 | export | 80 | 5 | 0x800F34B0 | **reloc-only** |
| NEDF2 | __nedf2 | export | 20 | 0 | - | **absent** |
| NEGDF2 | __negdf2 | export | 16 | 0 | - | **absent** |
| NEGSF2 | __negsf2 | export | 8 | 1 | - | **absent** |
| NESF2 | __nesf2 | export | 12 | 0 | - | **absent** |
| POW | pow | export | 140 | 32 | - | **absent** |
| PRINTF2 | printf2 | export | 16 | 1 | - | **absent** |
| PRINTF2 | sprintf2 | export | 1364 | 178 | - | **absent** |
| SIN | tan | export | 34 | 11 | - | **absent** |
| SIN | sin | export | 55 | 14 | - | **absent** |
| SIN | cos | export | 77 | 24 | - | **absent** |
| SINH | sinh | export | 78 | 31 | - | **absent** |
| SINH | cosh | export | 29 | 10 | - | **absent** |
| SINH | tanh | export | 89 | 36 | - | **absent** |
| SQRT | sqrt | export | 80 | 15 | - | **absent** |
| STRTOD | atof | export | 8 | 1 | - | **absent** |
| STRTOD | strtod | export | 332 | 75 | - | **absent** |
| SUBDF3 | __subdf3 | export | 32 | 4 | - | **absent** |
| SUBSF3 | __subsf3 | export | 24 | 4 | - | **absent** |
| TRUDFSF2 | __truncdfsf2 | export | 76 | 5 | 0x800F5924 | **reloc-only** |

## LIBC (psyq43 vendor objects)

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| A56 | exit | export | 4 | 0 | - | **absent** |
| A58 | getc | export | 4 | 0 | - | **absent** |
| A59 | putc | export | 4 | 0 | - | **absent** |
| A60 | getchar | export | 4 | 0 | - | **absent** |
| A61 | putchar | export | 4 | 0 | - | **absent** |
| A62 | gets | export | 4 | 0 | - | **absent** |
| A63 | puts | export | 6 | 0 | 0x800E80CC | **identical** |
| BCMP | bcmp | export | 20 | 2 | - | **absent** |
| BSEARCH | bsearch | export | 48 | 2 | 0x801091DC | **reloc-only** |
| C10 | todigit | export | 4 | 0 | - | **absent** |
| C12 | strtoul | export | 4 | 0 | - | **absent** |
| C13 | strtol | export | 4 | 0 | - | **absent** |
| C14 | abs | export | 4 | 0 | - | **absent** |
| C15 | labs | export | 4 | 0 | - | **absent** |
| C16 | atoi | export | 4 | 0 | 0x800EB100 | **identical** |
| C17 | atol | export | 4 | 0 | - | **absent** |
| C18 | atob | export | 4 | 0 | - | **absent** |
| C19 | setjmp | export | 4 | 0 | 0x8010668C | **identical** |
| C20 | longjmp | export | 4 | 0 | - | **absent** |
| C21 | strcat | export | 4 | 0 | 0x800E78E8 | **identical** |
| C22 | strncat | export | 4 | 0 | - | **absent** |
| C23 | strcmp | export | 4 | 0 | 0x800E5D7C | **identical** |
| C24 | strncmp | export | 4 | 0 | 0x800EB1D0 | **identical** |
| C25 | strcpy | export | 4 | 0 | 0x800E5B28 | **identical** |
| C26 | strncpy | export | 4 | 0 | 0x800F6104 | **identical** |
| C27 | strlen | export | 4 | 0 | 0x800E9F74 | **identical** |
| C28 | index | export | 4 | 0 | - | **absent** |
| C29 | rindex | export | 4 | 0 | - | **absent** |
| C30 | strchr | export | 4 | 0 | 0x800F6214 | **identical** |
| C31 | strrchr | export | 4 | 0 | 0x80103590 | **identical** |
| C32 | strpbrk | export | 4 | 0 | - | **absent** |
| C33 | strspn | export | 4 | 0 | - | **absent** |
| C34 | strcspn | export | 4 | 0 | - | **absent** |
| C36 | strstr | export | 4 | 0 | 0x800E62CC | **identical** |
| C37 | toupper | export | 4 | 0 | 0x8010907C | **identical** |
| C38 | tolower | export | 4 | 0 | 0x801035A0 | **identical** |
| C39 | bcopy | export | 4 | 0 | - | **absent** |
| C40 | bzero | export | 4 | 0 | 0x8010A540 | **identical** |
| C42 | memcpy | export | 4 | 0 | 0x800EAAC4 | **identical** |
| C43 | memset | export | 4 | 0 | 0x800E4318 | **identical** |
| C46 | memchr | export | 4 | 0 | 0x800FE388 | **identical** |
| C47 | rand | export | 4 | 0 | 0x800EAAD4 | **identical** |
| C48 | srand | export | 4 | 0 | - | **absent** |
| C51 | malloc | export | 4 | 0 | - | **absent** |
| C52 | free | export | 4 | 0 | - | **absent** |
| C53 | lsearch | export | 4 | 0 | - | **absent** |
| C55 | calloc | export | 4 | 0 | - | **absent** |
| C56 | realloc | export | 4 | 0 | - | **absent** |
| C63 | printf | export | 4 | 0 | 0x801028AC | **identical** |
| ITOA | itoa | export | 16 | 5 | - | **absent** |
| MEMCMP | memcmp | export | 20 | 2 | 0x80103734 | **reloc-only** |
| MEMMOVE | memmove | export | 28 | 1 | 0x800FE398 | **reloc-only** |
| QSORT | qsort | export | 100 | 7 | 0x800E5D8C | **reloc-only** |
| SPRINTF | sprintf | export | 548 | 34 | 0x800E44BC | **reloc-only** |
| STRTOK | strtok | export | 72 | 12 | - | **absent** |

## LIBCD (psyq43 vendor objects)

$Id inventory:
- BIOS: `$Id: bios.c,v 1.86 1997/03/28 07:42:42 makoto Exp yos $`

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| BIOS | CD_sync | export | 160 | 52 | 0x801075DC | **reloc-only** |
| BIOS | CD_ready | export | 178 | 55 | 0x8010785C | **reloc-only** |
| BIOS | CD_cw | export | 259 | 89 | 0x80107B24 | **reloc-only** |
| BIOS | CD_vol | export | 34 | 14 | - | **absent** |
| BIOS | CD_flush | export | 53 | 20 | 0x80107F30 | **reloc-only** |
| BIOS | CD_initvol | export | 60 | 18 | 0x80108004 | **reloc-only** |
| BIOS | CD_initintr | export | 19 | 12 | 0x801080F4 | **reloc-only** |
| BIOS | CD_init | export | 120 | 52 | - | **absent** |
| BIOS | CD_datasync | export | 90 | 36 | 0x80108320 | **reloc-only** |
| BIOS | CD_getsector | export | 64 | 22 | 0x80108488 | **reloc-only** |
| BIOS | CD_getsector2 | export | 59 | 20 | 0x80108588 | **reloc-only** |
| BIOS | CD_set_test_parmnum | export | 57 | 18 | 0x80108674 | **reloc-only** |
| CDPLAY | CdPlay | export | 344 | 137 | - | **absent** |
| CDREAD | CdReadBreak | export | 35 | 11 | - | **absent** |
| CDREAD | CdRead | export | 64 | 18 | 0x80108DDC | **drifted(60)** |
|  |  |  |  |  |  | drift @words 0,1,2,3,4,6,7,8,9,10,11,12... |
| CDREAD | CdReadSync | export | 50 | 7 | 0x80108F78 | **drifted(45)** |
|  |  |  |  |  |  | drift @words 1,2,3,4,8,9,10,11,12,13,14,15... |
| CDREAD | CdReadCallback | export | 5 | 4 | - | **absent** |
| CDREAD | CdReadMode | export | 5 | 4 | - | **absent** |
| CDREAD2 | CdRead2 | export | 44 | 14 | 0x800F8F48 | **reloc-only** |
| CDREADE | CdReadFile | export | 94 | 18 | - | **absent** |
| CDREADE | CdReadExec | export | 54 | 9 | - | **absent** |
| CDROM | StSetRing | export | 12 | 5 | 0x800F99F8 | **reloc-only** |
| C_002 | StClearRing | export | 24 | 17 | 0x800F8968 | **reloc-only** |
| C_003 | StUnSetRing | export | 32 | 13 | 0x800F8EC8 | **reloc-only** |
| C_004 | data_ready_callback | export | 35 | 16 | 0x80108798 | **reloc-only** |
| C_004 | StGetBackloc | export | 25 | 9 | - | **absent** |
| C_005 | StSetStream | export | 36 | 17 | 0x800F8FF8 | **reloc-only** |
| C_006 | StSetEmulate | export | 28 | 11 | - | **absent** |
| C_007 | StFreeRing | export | 44 | 8 | 0x800FA994 | **reloc-only** |
| C_008 | init_ring_status | export | 16 | 2 | 0x80108758 | **reloc-only** |
| C_009 | StGetNext | export | 48 | 18 | 0x800F9A28 | **reloc-only** |
| C_010 | StSetMask | export | 8 | 6 | 0x8010885C | **reloc-only** |
| C_011 | StCdInterrupt | export | 700 | 306 | 0x800F7E78 | **reloc-only** |
| C_012 | StSetChannel | export | 16 | 6 | - | **absent** |
| C_013 | StGetNextS | export | 32 | 12 | - | **absent** |
| C_014 | StNextStatus | export | 40 | 18 | - | **absent** |
| C_015 | StRingStatus | export | 52 | 11 | - | **absent** |
| EVENT | CdInit | export | 84 | 25 | 0x8010908C | **reloc-only** |
| ISO9660 | CdSearchFile | export | 604 | 174 | 0x800F9088 | **reloc-only** |
| SYS | CdStatus | export | 4 | 2 | 0x800F7780 | **reloc-only** |
| SYS | CdMode | export | 4 | 2 | 0x800F7790 | **reloc-only** |
| SYS | CdLastCom | export | 4 | 2 | - | **absent** |
| SYS | CdLastPos | export | 3 | 2 | 0x800F77A0 | **reloc-only** |
| SYS | CdReset | export | 27 | 4 | 0x800F77AC | **reloc-only** |
| SYS | CdFlush | export | 8 | 1 | 0x800F7818 | **reloc-only** |
| SYS | CdSetDebug | export | 5 | 4 | 0x800F7838 | **reloc-only** |
| SYS | CdComstr | export | 13 | 5 | - | **absent** |
| SYS | CdIntstr | export | 13 | 5 | - | **absent** |
| SYS | CdSync | export | 8 | 1 | 0x800F784C | **reloc-only** |
| SYS | CdReady | export | 8 | 1 | 0x800F786C | **reloc-only** |
| SYS | CdSyncCallback | export | 5 | 4 | 0x800F788C | **reloc-only** |
| SYS | CdReadyCallback | export | 5 | 4 | 0x800F78A0 | **reloc-only** |
| SYS | CdControl | export | 79 | 15 | 0x800F78B4 | **reloc-only** |
| SYS | CdControlF | export | 77 | 15 | 0x800F79F0 | **reloc-only** |
| SYS | CdControlB | export | 83 | 17 | 0x800F7B24 | **reloc-only** |
| SYS | CdMix | export | 8 | 1 | - | **absent** |
| SYS | CdGetSector | export | 8 | 1 | 0x800F7C70 | **reloc-only** |
| SYS | CdGetSector2 | export | 8 | 1 | 0x800F7C90 | **reloc-only** |
| SYS | CdDataCallback | export | 9 | 1 | 0x800F7CB0 | **reloc-only** |
| SYS | CdDataSync | export | 8 | 1 | 0x800F7CD4 | **reloc-only** |
| SYS | CdIntToPos | export | 65 | 0 | 0x800F7CF4 | **identical** |
| SYS | CdPosToInt | export | 32 | 0 | 0x800F7DF8 | **identical** |
| TOC | CdGetToc | export | 9 | 1 | 0x8010929C | **reloc-only** |
| TOC | CdGetToc2 | export | 139 | 22 | 0x801092C0 | **reloc-only** |
| TYPE | CdDiskReady | export | 79 | 9 | 0x800E8448 | **reloc-only** |
| TYPE | CdGetDiskType | export | 85 | 16 | 0x800E8584 | **reloc-only** |

## LIBAPI (psyq43 vendor objects)

| member | fn | linkage | words | relocs | retail VA | verdict |
|---|---|---|---|---|---|---|
| A07 | DeliverEvent | export | 4 | 0 | 0x8010C6F8 | **identical** |
| A08 | OpenEvent | export | 4 | 0 | 0x80106E20 | **identical** |
| A09 | CloseEvent | export | 4 | 0 | 0x8010C864 | **identical** |
| A10 | WaitEvent | export | 4 | 0 | - | **absent** |
| A11 | TestEvent | export | 4 | 0 | 0x8010C874 | **identical** |
| A12 | EnableEvent | export | 4 | 0 | 0x80106E10 | **identical** |
| A13 | DisableEvent | export | 4 | 0 | 0x80106E30 | **identical** |
| A14 | OpenTh | export | 4 | 0 | - | **absent** |
| A15 | CloseTh | export | 4 | 0 | - | **absent** |
| A16 | ChangeTh | export | 4 | 0 | - | **absent** |
| A18 | InitPAD2 | export | 4 | 0 | - | **absent** |
| A19 | StartPAD2 | export | 4 | 0 | - | **absent** |
| A20 | StopPAD2 | export | 4 | 0 | - | **absent** |
| A21 | PAD_init2 | export | 4 | 0 | - | **absent** |
| A22 | PAD_dr | export | 4 | 0 | - | **absent** |
| A23 | ReturnFromException | export | 4 | 0 | 0x8010697C | **identical** |
| A24 | ResetEntryInt | export | 4 | 0 | 0x8010699C | **identical** |
| A25 | HookEntryInt | export | 4 | 0 | 0x8010669C | **identical** |
| A32 | UnDeliverEvent | export | 4 | 0 | - | **absent** |
| A36 | EnterCriticalSection | export | 4 | 0 | 0x8010698C | **identical** |
| A37 | ExitCriticalSection | export | 4 | 0 | 0x8010696C | **identical** |
| A38 | Exception | export | 4 | 0 | - | **absent** |
| A39 | SetSp | export | 4 | 0 | 0x800E44AC | **identical** |
| A40 | SwEnterCriticalSection | export | 8 | 0 | - | **absent** |
| A41 | SwExitCriticalSection | export | 8 | 0 | - | **absent** |
| A50 | open | export | 4 | 0 | 0x80109D70 | **identical** |
| A51 | lseek | export | 4 | 0 | 0x80109D90 | **identical** |
| A52 | read | export | 4 | 0 | 0x80109DA0 | **identical** |
| A53 | write | export | 4 | 0 | 0x80109DB0 | **identical** |
| A54 | close | export | 4 | 0 | 0x80109D80 | **identical** |
| A55 | ioctl | export | 4 | 0 | - | **absent** |
| A64 | cd | export | 4 | 0 | - | **absent** |
| A65 | format | export | 4 | 0 | 0x8010A080 | **identical** |
| A66 | firstfile2 | export | 4 | 0 | 0x8010C884 | **identical** |
| A67 | nextfile | export | 4 | 0 | 0x8010A060 | **identical** |
| A68 | rename | export | 4 | 0 | - | **absent** |
| A69 | erase | export | 4 | 0 | 0x8010A070 | **identical** |
| A70 | undelete | export | 4 | 0 | - | **absent** |
| A71 | AddDrv | export | 4 | 0 | - | **absent** |
| A72 | DelDrv | export | 4 | 0 | - | **absent** |
| A81 | Krom2RawAdd | export | 4 | 0 | - | **absent** |
| A84 | _get_errno | export | 4 | 0 | - | **absent** |
| A85 | _get_error | export | 4 | 0 | - | **absent** |
| A91 | ChangeClearPAD | export | 4 | 0 | 0x80106654 | **identical** |
| A94 | GetGp | export | 4 | 0 | - | **absent** |
| A95 | GetSp | export | 4 | 0 | - | **absent** |
| A96 | GetCr | export | 4 | 0 | - | **absent** |
| A97 | GetSr | export | 4 | 0 | - | **absent** |
| C112 | _bu_init | export | 4 | 0 | 0x8010C854 | **identical** |
| C113 | _96_init | export | 4 | 0 | - | **absent** |
| C114 | _96_remove | export | 6 | 0 | 0x80106954 | **identical** |
| C157 | GetConf | export | 4 | 0 | - | **absent** |
| C159 | SetMem | export | 4 | 0 | - | **absent** |
| C160 | _boot | export | 4 | 0 | - | **absent** |
| C161 | SystemError | export | 4 | 0 | - | **absent** |
| C167 | bufs_cb_0 | export | 4 | 0 | - | **absent** |
| C168 | bufs_cb_1 | export | 4 | 0 | - | **absent** |
| C169 | bufs_cb_2 | export | 4 | 0 | - | **absent** |
| C170 | bufs_cb_3 | export | 4 | 0 | - | **absent** |
| C174 | bufs_cb_4 | export | 4 | 0 | - | **absent** |
| C57 | InitHeap | export | 4 | 0 | 0x800FDD18 | **identical** |
| C58 | _exit | export | 4 | 0 | - | **absent** |
| C65 | LoadTest | export | 4 | 0 | - | **absent** |
| C66 | Load | export | 4 | 0 | - | **absent** |
| C67 | Exec | export | 4 | 0 | - | **absent** |
| C68 | FlushCache | export | 4 | 0 | 0x800F43D4 | **identical** |
| C73 | GPU_cw | export | 4 | 0 | 0x80104A0C | **identical** |
| C81 | LoadExec | export | 4 | 0 | - | **absent** |
| C82 | GetSysSp | export | 4 | 0 | - | **absent** |
| CALLOC2 | calloc2 | export | 36 | 4 | - | **absent** |
| CALLOC3 | calloc3 | export | 32 | 3 | - | **absent** |
| CHCLRPAD | _remove_ChgclrPAD | export | 28 | 7 | - | **absent** |
| COUNTER | SetRCnt | export | 39 | 6 | 0x800E9E70 | **reloc-only** |
| COUNTER | GetRCnt | export | 14 | 3 | 0x800E9F0C | **reloc-only** |
| COUNTER | StartRCnt | export | 12 | 4 | 0x800E9F44 | **reloc-only** |
| COUNTER | StopRCnt | export | 13 | 4 | - | **absent** |
| COUNTER | ResetRCnt | export | 14 | 3 | - | **absent** |
| FIRST | firstfile | export | 168 | 24 | 0x80109DC0 | **reloc-only** |
| FREE2 | free2 | export | 16 | 4 | - | **absent** |
| FREE3 | free3 | export | 84 | 15 | - | **absent** |
| I_HEAP2 | InitHeap2 | export | 20 | 12 | - | **absent** |
| I_HEAP3 | InitHeap3 | export | 24 | 2 | - | **absent** |
| L02 | SysEnqIntRP | export | 4 | 0 | 0x8010BFD8 | **identical** |
| L03 | SysDeqIntRP | export | 4 | 0 | 0x8010BFC8 | **identical** |
| L10 | ChangeClearRCnt | export | 4 | 0 | 0x80106664 | **identical** |
| MALLOC2 | malloc2 | export | 136 | 34 | - | **absent** |
| MALLOC3 | malloc3 | export | 44 | 10 | - | **absent** |
| PAD | SetInitPadFlag | export | 3 | 2 | - | **absent** |
| PAD | ReadInitPadFlag | export | 4 | 2 | 0x8010C9B0 | **reloc-only** |
| PAD | PAD_init | export | 36 | 9 | - | **absent** |
| PAD | InitPAD | export | 36 | 9 | - | **absent** |
| PAD | StartPAD | export | 12 | 3 | - | **absent** |
| PAD | StopPAD | export | 101 | 28 | - | **absent** |
| PATCH | EnablePAD | export | 5 | 2 | - | **absent** |
| PATCH | DisablePAD | export | 5 | 2 | - | **absent** |
| PATCH | _patch_pad | export | 30 | 10 | - | **absent** |
| REALLOC2 | realloc2 | export | 148 | 21 | - | **absent** |
| REALLOC3 | realloc3 | export | 108 | 20 | - | **absent** |
| SC2B | SetConf | export | 204 | 22 | - | **absent** |

### LIBMATH + LIBC + LIBCD + LIBAPI ANALYSIS (resolved)

- **LIBMATH: ALL 20 retail-linked soft-float fns reloc-only/identical.** The 04X
  "Sony prebuilt vendor object" identity is now BYTE-PROVEN and the exact drop
  IDENTIFIED: retail libmath == psyq43 LIBMATH.LIB members verbatim
  (__adddf3/__muldf3/_mul_mant_d/__divdf3/_comp_mant/__divsf3/__mulsf3/
  __gtdf2/__ltdf2/__fix*/__float*/__extendsfdf2/__truncdfsf2/_dbl_shift{,_us}/
  _add_mant_d/_mainasu/_err_math). Per-fn compiler-ladder rungs were
  approximations; the vendor objects ARE the truth for every remaining residual.
- **LIBC**: `sprintf` (548w) **reloc-only** + memcmp/memmove/qsort/bsearch green;
  20 BIOS thunks identical. absent rows = the A0-table thunks NFS4 didn't link
  + strtol/strtoul/ctype family.
- **LIBCD**: 46 green / 2 drifted. **The multi-wave floor set CD_sync(160w)/
  CD_ready(178w)/CD_cw(259w) is reloc-only** — retail's cdbios IS the psyq43
  BIOS.obj (bios.c $Id v1.86). SYS/EVENT/TOC/CDREAD2/ISO9660 green.
  **GENUINE DRIFT (honest record): CDREAD member only** — retail
  CdRead@0x80108DDC / CdReadSync@0x80108F78 are a DIFFERENT (later) cdread.c
  revision (different frame/regs from word 0; consistent with the W60 12G
  per-fn 2.8.1 ver-splice evidence). Vendor CDREAD does NOT witness retail.
- **CD_init IS IN RETAIL, unnamed**: probe CONFIRMED reloc-only at
  **0x80108140** (the 120-word gap between CD_initintr and CD_datasync).
  -> candidate symbol_addrs addition: `CD_init = 0x80108140; // type:func`.
  CD_vol however is genuinely ELIDED (CD_cw ends exactly at CD_flush).
- **LIBAPI**: 28 BIOS thunks byte-identical + COUNTER (SetRCnt/GetRCnt/
  StartRCnt), FIRST (firstfile 168w), ReadInitPadFlag reloc-only.

## CROSS-CHECK LAYER: SpongeBob drop vs psyq43 (per-member identity)

- **ASPSX provenance**: SpongeBob bin = **ASPSX 2.81**; our psq43 SDK = **ASPSX
  2.77** (production-lane law). Where the two drops differ, RETAIL MATCHES THE
  PSYQ43 (2.77-era) OBJECTS: LIBGPU SYS carries the SAME `sys.c v1.140` $Id in
  both drops but SpongeBob's member is a REBUILD (.text 12032 vs 12304 B,
  differs) — and retail matched psyq43's byte-for-byte. => NFS4 linked the 4.3
  originals, not the later rebuild; ASPSX 2.81 shows up ONLY as the SpongeBob
  rebuild delta, never in retail.
- Byte-identical members across drops (spot inventory): LIBETC INTR (v1.75,
  md5 420c6e2f) + most of LIBC (51/56), LIBAPI (86/89), LIBMATH (33/59 — the
  NFS4-linked double-precision core is identical). LIBPAD/LIBMCRD/LIBCD were
  RESTRUCTURED in the later SDK (split/renamed members: BIOS_1..3, S_0xx,
  PDMAIN1..). $Id anchors preserved: bios.c v1.86, intr.c v1.75, sys.c v1.140.

## TOTALS

| lib | identical | reloc-only | drifted | absent |
|---|---|---|---|---|
| LIBETC | 0 | 12 | 2 (v1.75 thunks not in retail — see analysis) | 5 |
| LIBGPU | 11 | 22 | 0 | 72 |
| LIBMCRD | 0 | 38 | 0 | 2 |
| LIBPAD | 3 | 26 | 0 | 18 |
| LIBMATH | 1 | 19 | 0 | 43 |
| LIBC | 20 | 5 | 0 | 30 |
| LIBCD | 2 | 44 | 2 (CDREAD revision skew — genuine) | 18 |
| LIBAPI | 30 | 5 | 0 | 64 |
| **SUM** | **67** | **171** | **4** | **252** |

238/242 retail-anchored vendor fns byte-match reloc-masked; the only genuine
revision skew in the whole target set is LIBCD/CDREAD (2 fns).
