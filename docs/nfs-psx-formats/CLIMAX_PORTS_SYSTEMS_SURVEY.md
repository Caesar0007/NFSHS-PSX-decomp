# Climax PSX ports vs NFS4: what is transferable to the mod lane

Survey made 2026-10-05 from the Warcraft II PSX source (`C:/temp/ps1-decomp-refs/warcraft2`,
Climax 1996-97, "Steve!/Climax"), the Diablo PSX matching decomp (`C:/temp/diablo-psx/psx_decomp/recon`,
Climax 1998 on the DCI **GLIB** base library) and SpongeBob SuperSponge
(`C:/temp/ps1-decomp-refs/Spongebob_SuperSponge`, THQ/Climax 2001), compared with NFS4 retail
(`recon/`, EAC libs `recon/eaclib/psx/eacpsxz`). Scope: ideas for the **mod lane** (`recon/mod`,
route D). Nothing here applies to the byte-matching tree -- none of it may touch retail bytes.

## Headline

The question was whether these ports replace PsyQ libgpu/libgte with faster code. They do not:

- **Diablo** still links Sony libgpu (`DrawOTag2` x12 sites, `LoadImage` x15, `DrawSync` x22,
  `SetDrawEnv` x185, `GPU_cw`, `ClearImage`, `MoveImage`); `GPUQ_*`/`PRIM_*` are layers on top.
  No GTE (2D).
- **Warcraft II** calls Sony libgpu directly (`VSync` x56, `LoadImage` x33, `DrawSync` x24);
  the only replaced Sony routine is `memcpy` (`FUCKSONY.ASM`, aligned 8-byte copy loop).
  The other `.ASM` files are untouched DOS x86 originals; PSX-side `.S` are cc1 output + `VSEX.S`.
- **SpongeBob** is the only one that "replaces" GTE: `source/utils/cmxmacro.h` redefines
  `RotTransPers/3/4` and `RotTrans` as `gte_ldv0 -> gte_rtps -> gte_stsxy` sequences,
  `gtemisc.h`/`system/gte.h` add component-wise `ctc2/mfc2/swc2` macros (~100 inline sites).
- **NFS4 already did that wholesale**: zero `RotTransPers`/`RotTrans`/`ApplyMatrix`/`MulMatrix0`
  call sites, 1036 inline `gte_*` sites in `recon/game` plus the `drawc`/`draww` hand-scheduled
  template blocks. libgte linked = `InitGeom`, `SetGeomScreen`, `RotMatrix`, `RotMatrixZ` only.
  libgpu linked = the same entry points everyone uses (`DrawOTag`, `DrawOTag2`, `DrawSync`,
  `LoadImage`, `StoreImage`, `MoveImage`, `ClearImage`, `PutDispEnv`, `PutDrawEnv`, `SetDrawEnv`,
  `ResetGraph`, `VSync`, `GPU_cw`, `DMACallback`, `ClearOTagR`, `AddPrim`).

So the value of the Climax ports is their **systems layer**, not GPU/GTE replacement.

## Side by side

| Concern | Climax (WC2 -> Diablo) | NFS4 retail / EAC | Verdict |
|---|---|---|---|
| Frame flip | WC2 `gfx.c`: `render_prims` spins `DrawSync(1)` and sets a flag; the VBlank handler (`psxinit.c psx_vb_handler` -> `do_swap_buffers`) does `PutDispEnv + PutDrawEnv + DrawOTag`. Diablo `primpool.cpp PRIM_Flush`: waits on a `volatile Drawing` flag cleared by a `DrawSyncCallback` (`PrimDrawSycnCallBack`), posts `PutDispEnv` to run at the next VSync via `vid.cpp VID_DoThisNextSync`, flushes the GPU upload queue, then `DrawOTag`; ring of `BufferDepth` prim buffers; `PROF_CpuStart/End` + `PROF_DrawStart/End` bracket CPU vs GPU time. | `game/psx/draw.cpp Draw_StopFrameRender`: `DrawSync(0)` -> optional `VSync(0)` -> `PutDispEnv` -> `DrawOTag` per view, `gFlip ^= 1`. Blocking. 28 blocking `DrawSync(0)` sites in game+frontend (`r3dcar` x4, `draw` x3, `drawc` x2, `nfs3` x2, `psxfront` x2, `movie` x2, `screentracks` x2, ...). | Transferable: removes the main-thread GPU stall. |
| VRAM uploads | Diablo `gpuq.cpp`: 30-entry queue of `LoadImage`/`MoveImage`/CLUT uploads drained once per frame at flip; GAL handle lock/unlock/free done after `DrawSync(0)` so the source buffer is released only when DMA is done (`GPUQ_LoadImage/LoadClutAddr/MoveImage/DiscardHandle/FlushQ`). WC2 `psxvram.c load_vram`: two half-buffers ping-ponged by a `DrawSyncCallback` (`load_vram_callback` clears `vram_dma[buf]`) while `decrunch()` fills the other half -- decompression and DMA overlap. | `Texture_Vramcf`/`eacpsxz/vramfxya.c` upload immediately; track/car texture loads are synchronous `LoadImage` + `DrawSync(0)`. | Transferable; biggest load-time win. |
| CD streaming | WC2 `cdstream.c` (Diablo: inside `FMV.CPP`): `CdReadyCallback`-driven sector ring, subcode position check (`CdGetSector(subcode,3)` -> resync on out-of-sequence sector), stall/resume, chunk borrow. Diablo `ASYNC.CPP`/`BIGLUMP.CPP` (`BL_*`, `AS_*`). | EAC `stream.c`/`nasync.c`: request queue with priorities and greedy levels, `STREAM_queuefile/queuemem`, `asyncloadsegment`. | Not needed; EAC's is more capable. |
| CD-DA / audio | WC2 `cdaudio.c`: CD audio streamed through SPU with a DMA queue serviced from the HSync interrupt; `snd.c` channel finder. Diablo `STREAM.CPP` (`STR_DMAControl`, `STR_AsyncTASK`). | `sndpsxz` (EA SND) XA/SPU streaming. | Not needed. |
| Memory | GLIB `glibdev/gal.c` (DCI 1996): handle-based allocator with named memory types, alignment, per-type `MemMove`; `GAL_Lock/Unlock` so unlocked blocks can be moved/compacted; 70 functions of plain C. WC2 `VMEM.C` (Blizzard 1993): LRU handle cache evicting least-recently-used blocks. Diablo `TMALLOC.CPP` temp heap. | EAC `meminit.c`/`memstd.c`, game `SimpleMem` arena (467,420 B track), `bigBuf` render arena. `NFS4_RACE_MEMORY_BUDGET.md`: 12,096 B free / 11,944 B largest at race time. | Transferable as a design: a lockable handle heap is what makes the 151,208 B `bigBuf` tail and the 87,740 B phase-overlay set reclaimable; EA's allocator cannot move blocks. Check the DCI licence before lifting code rather than design. |
| Scheduling | GLIB `tasker.c`: cooperative tasks with own stacks (`TSK_AddTask/Sleep/Die`, `DoEpi/DoPro` hooks), used for card update, CD-wait icon, stream service. | EAC `threads.c`/`systask.c`. | Not needed. |
| Debug / robustness | WC2 `EXCEPT.C` + `VSEX.S`: on-screen exception handler (registers, cause, EPC, pad-driven memory browser; `break 0xbeef` enters it on demand). Diablo `prof.cpp`: on-screen CPU/GPU bars from `GTIMSYS_GetTimer` (root-counter timer). `GSYS_IsStackCorrupted/MarkStack`. `SCRATCH.CPP` palette cache. | None in retail; the mod lane debugs via DuckStation/GDB. | Transferable, cheap; useful on real hardware. |
| libc | WC2 `FUCKSONY.ASM` aligned 8-byte `memcpy`. | `memcpy` = BIOS A0:0x2A thunk (`libc.lib(C42.OBJ)`, kernel byte loop), ~30 sites incl. `BWorld_Init`, `Front_InitTrack`, `PreLoad__11tScreenMain`, `Stats_TrackStats`; `memset` 54 game + 6 frontend + 15 eaclib sites. eacpsxz already has `blkmov.c`/`blkfill.c`/`fastmovf.c`. | Transferable, trivial. |
| GTE/GPU inlining | SpongeBob macros only. | Already maximal. | Nothing to gain. |

## Recommended order for the mod lane

1. `memcpy`/`memset` off the BIOS: route to eacpsxz `blkmov`/`blkfill` (already linked) or a
   WC2-style word copy. Zero design work; the BIOS copy sits on the track-load path.
2. WC2 half-buffer VRAM loader (`load_vram` + `load_vram_callback`): decrunch chunk N+1 while
   chunk N DMAs. Direct fit for Phase-3 streaming of converted (larger) tracks.
3. Diablo `GPUQ` upload queue for in-race texture/CLUT changes (`Texture_Vramcf` sites): defer to
   the flip, release source memory only after `DrawSync`.
4. Diablo-style flip (`PRIM_Flush` + `VID_DoThisNextSync`): replace `Draw_StopFrameRender`'s
   `DrawSync(0)` spin with a `DrawSyncCallback`-cleared flag and a VSync-posted `PutDispEnv`;
   add `PROF` bars so the gain is measurable. Split-screen frame time comes from here.
5. Handle-based lockable heap (GAL design) for the track arena -- the structural fix behind the
   memory-budget doc's "space has to come from overlays and right-sizing".
6. WC2 exception screen + `break 0xbeef` for hardware testing of mod builds.

Not worth taking: Climax CD streaming, CDDA/SPU DMA, the tasker -- EAC `stream.c`/`nasync.c`/
`sndpsxz`/`threads.c` already cover them at least as well.

## Pointers

- Diablo matched sources: `diablo-psx/psx_decomp/recon/psxsrc/{gpuq,primpool,vid,prof}.cpp`,
  `recon/glibdev/{gal,tasker}.c`; module map from `diablo-psx/sym_fns.json` (`file` field;
  `GLIBDEV\SOURCE\*.C` = GLIB: GAL 70 fns, TASKER 41, GSYS 7, GTIMSYS 3, TICK 7, GUTILS 6, GDEBUG 9).
- Warcraft II PSX: `warcraft2/{cdstream,psxvram,gfx,psxinit,mdec,cdaudio,snd,memcard,psxinput}.c`,
  `EXCEPT.C`, `VSEX.S`, `FUCKSONY.ASM`, `VMEM.C`.
- SpongeBob: `source/utils/cmxmacro.h`, `source/utils/gtemisc.h`, `source/system/gte.h`,
  `source/gfx/prim.h`, `source/gfx/primplus.h`.
- NFS4: `recon/game/psx/draw.cpp` (flip), `recon/eaclib/psx/eacpsxz/{stream,nasync,vramfxya,blkmov,blkfill}.c`,
  retail `memcpy` thunk at `0x800EAAC4` (`C:/Temp/symdump-disasm/disasm-v4.txt`),
  `docs/nfs-psx-formats/NFS4_RACE_MEMORY_BUDGET.md` (runtime budget, other session).
