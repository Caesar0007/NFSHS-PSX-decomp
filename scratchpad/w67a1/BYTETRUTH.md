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
