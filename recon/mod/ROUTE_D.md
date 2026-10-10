# Route D — mod build plan and state

## What route D is
Route C (SLINK `/strip` + Sony's prebuilt libraries, byte-identical) with the `recon/mod`
overrides from `manifest.json` spliced into the link. Same compilers, assembler, linker and
CPE2X; a different object list. Output: `build/route_d/disc/NFS4.EXE` + `FRONT.BIN`, then a
disc image carrying converted NFS3 tracks.

Why a source relink rather than the retail-binary patches of `recon/syslib-mod`: everything the
link leaves out moves `endofcode` down, and the EA heap is `endofcode+8 … 0x801FC000`
(`Platform_InitMemory`), so the heap grows by itself — no arena, no restore blob, no reserved
FONT BSS. The retail-patch route exists because it had to keep the retail image; route D does not.

## Memory targets
| Item | Retail | Route D |
|---|---|---|
| EA heap | 734,452 B | + whatever the link drops (FONT.obj 22,276 B; `rcossin_tbl` 16,384 → 2,050 B; PC stubs 512 B; compact libcd ≈ 3,620 B) |
| Track block | `fileSize + 0x9080`, whole GRP | streamed: GRH resident part + chunk cache (game-mod measured 365,964 B worst case for 01B with a 42-slot cache) |
| 0x9080 head start | caps at ≈185 chunks | not used on the streamed route |

## Milestones
1. **Link.** `tools/route_d.py --stage A`: route C objects + game overrides → `nfs4_d.cpe` →
   CPE2X → `NFS4.EXE`/`FRONT.BIN`. Gate: slink has no errors, `endofcode` and section sizes are
   reported, the image boots to the front end and into a retail track (runtime probe =
   `Track_Init` returns, 900 driven frames). Then `--stage B` adds the syslib replacements; the
   gate is the same plus the measured heap gain and no duplicate-symbol pulls from the Sony LIBs.
2. **Wire the streaming loader.** `bworld.cpp`'s `Track_Init`/`Track_DeInit` calls go to
   `TrackMod_TrackInit`/`TrackMod_TrackDeInit` (a `recon/mod/game/common/bworld.cpp` override
   with exactly those two call edits). Fitting tracks keep the retail path; oversized ones take
   GRH/GRX. Gate: converted 00A on the retail path and forced-stream 00A both complete 900 frames.
3. **Finish the streaming prototype.** Known open fault from game-mod: on 01B the first deferred
   chunk transition jumps through `-1` (Address Error, EPC = BadVAddr = 0xFFFFFFFF) around tick
   570; the audit found no unloaded-Chunk access, so a saved-RA / callback slot is corrupted.
   Gate: 01B and 04B complete 900 frames, replay, cleanup and return to the front end.
4. **Disc.** `tools/route_d.py --disc`: dumpsxiso-extracted tree + mkpsxiso XML with the
   converted track files (`.GRP`/`.GRH`/`.GRX`, textures, aux files) added as new entries.
5. **Full gates** (from the game-mod list): pause, split-screen, night/weather, Hot Pursuit with
   speech, memory card, native movie, 5,000-frame soak — run on the route D image.

## Relink hazard found (and fixed in the mod tree)
`recon/eaclib/psx/eacpsxz/savegp.c` reloads the library `$gp` from a linked literal
(`lui $28,0x8012; lw $28,0x34E8($28)` = `0x801234E8`), transcribed to byte-match retail. Any
relink that moves `.data` restores a garbage `$gp` on the first EA interrupt callback and the
image dies at the first gp-relative load of the async-read engine (`front.bin` never loads).
Proven by a bisect: route C's byte-identical output boots through the same harness; adding one
0x130-byte `.rdata` object crashes it; with `recon/mod/eaclib/psx/eacpsxz/savegp.c` (symbolic
`%hi/%lo(D_801234E8)`, manifest `fixes_before_libs`, linked ahead of `eacpsxz.lib` so the member
is not pulled) the same image reaches `PAD_update`. It is the only inline-asm literal address in
the reconstruction (`lui` immediates 32768–32800 swept), and every address word in the data
sections relocates correctly (453/453 checked on the pad bisect).

## Second hazard: the simulation runs on the 1 KB scratchpad stack
`Sim_ProcessSimSchedules` does `gWSavePtr = SetSp(&gScratchLastWord)` and runs the schedules on the
scratchpad; the retail road-query chain (`AIPhysic_Main → Newton_FindGroundElevationAndNormal`
[448-byte frame] `→ BWorldSm_FindClosestTriangleRez → BWorldSm_FindClosestQuadRez → FindClosestQuad
→ RawFindClosestQuad`) nearly fills it. The streaming veneers that replace `BWorld_SetSimSlice` and
`BWorldSm_FindClosestQuadRez` may load a chunk from disc, which overflowed the scratchpad on the
streamed 01B (sp underflowed to `0x1F7FFFB4`, saved ra/s-registers read back as `0xFFFFFFFF`, the sim
returned into −1 — the game-mod report's "jump through −1"). Fix: `trackmod_stack.c` provides
`TrackMod_OnMainStack(fn, a0, a1, a2)`, which switches to the main stack below `gWSavePtr` (the
engine's own trick, cf. `draww.cpp:2193`) for the veneer calls and switches back.

## State
- 2026-10-04: tree scaffolded; `tools/route_d.py` builds stage A (streaming code linked, EXE
  1,241,088 B) and stage B (FONT/PC/GTE replacements; heap +19,144 B — the sine table is still
  pulled by other libgte members, so only FONT counts yet); stage C (compact libcd) was blocked by
  `EVENT.obj` being pulled for symbols the core does not define (duplicate `CdInit`) -- closed
  2026-10-10, see below. Disc tree
  extracted to `build/cd/nfs4-route-d` (+ mkpsxiso XML). Boot gates: see the table kept below.
- Runtime probes: `docs/nfs-psx-formats/tools/runtime/nfs4_track_probe_map.py` resolves every
  address from a link MAP, so it works on route D images.
- Milestone 1 passed: stage A and stage B images boot, load retail track 06 and race (stage B:
  1,500 driven frames, 5,110 ticks). Milestone 2 wiring is in: `bworld.cpp` / `bworldSm.cpp` /
  `chunk.cpp` overrides hand `Track_Init`, `Track_DeInit`, `BWorld_SetSimSlice`,
  `BWorldSm_FindClosestQuadRez` and `Chunk_UpdateSys` to the streaming code; `tools/route_d_disc.py`
  builds the disc (mkpsxiso) with the streamed companions the converter emits (`--streamed`).

## Third hazard: the chunk cache had no eviction
The game-mod cache gave every chunk its own slot and its own `reservememadr` block and never freed
one, so on the 212-chunk 01B the 80 chunks preloaded at init (187 KB) plus the AI cars' chunks
exhausted the EA heap (`TrackMod_allocFailures` 7,941 in 280 frames), `TrackMod_EnsureChunksBlocking`
spun 4,096 × `systemtask(0)` per failed load, and a `BWorldSm_Pos` was left pointing at a chunk whose
record was still zero (`vertexBuf == NULL` → `GetFirstStmQuadPts` read `4 + ...` → bus error). The
sim veneers also called `TrackMod_EnsureVisibleSync(chunk, chunk)`, which pulls the chunk's whole
32-entry visibility row and bumps the pump generation on every sim tick.
Fix (`chunk_cache.cpp`, `track.cpp`, `bworldSm_veneer.cpp`): residency is bounded by
`cache->storageBytes` (largestunused − 0x30000 at init); `TrackMod_LoadChunkSync` evicts the least
recently used slot whose generation is older than the current pump generation when no free slot /
budget / heap block is available (`TrackMod_EvictOldest`: zero the retail `Chunk` record, `purgememadr`
the block, `TrackMod_evictedChunks++`); the pump (`TrackMod_PrefetchNext → EnsureVisibleSync`) is the
only generation bump and re-stamps the in-view set each frame; the sim veneers use
`TrackMod_EnsureSimChunkBlocking(chunk)` (one chunk, no visibility row, 256 retries).

## Fourth hazard: a veneer that is not retail-equivalent when streaming is off
`TrackMod_BWorldSmFindClosestQuadRez` re-derived the chunk with `FindAbsClosestSliceCrude` whenever
`slicePos->chunk >= TrackMod_ChunkCount()`, and `TrackMod_ChunkCount()` is 0 on the retail route, so
every call took that path: the player ended at `slice == gNumSlices` (00A: SLC 959) and never
accelerated (0 km/h, AI cars fine). Bisected with manifest variants (pure relink → drives; +0x130 data
shift → drives; all mod code minus the bworldSm override → drives). The veneer now only ensures the
chunk the position already names (or the one its valid slice maps to) and is otherwise the retail body.

## State (2026-10-04, later)
- `tools/route_d.py` now compiles (`build.py --only build/recon/mod/**.o`) and assembles the mod TUs
  itself (the main lane skips the recon/ side trees since a26eced3); `--no-compile`, `--manifest`.
- Milestone 3 passed: streamed 01B (212 chunks / 1,690 slices, GRH 215,436 + GRX 564,016) boots,
  initialises through `TrackMod_TrackInit`, and is driven 3,600 pad frames / 13,538 ticks with no
  load failures (95 loads, 12 evictions, 83 resident = 192 KB). Streaming is retail-equivalent: 00A
  and 02A driven with `--poke TrackMod_forceStreaming=1` end at the same slice / speed / spot as the
  retail-route drive of the same converted track (00A: SLC 150, 60 km/h; 02A: SLC 52).
- Known, NOT route D: an accelerate-only drive leaves the road on the converted tracks (01B at
  ~frame 900 / slice ~103 into the town buildings; 02A at slice 52) on the retail route as well —
  converter border/barrier coverage to check next.
- Probe fixes: `nfs4_track_probe_map.py` resolves every drive-loop address from the MAP (it used to
  write retail literals into relinked images — the primitive-buffer compaction is now `--compact`
  only), `--poke SYM=hex`; `nfs4_drive_shots.py` takes `PAD_RET PAD_STATE TICKS` for relinked
  images. DuckStation refuses to overwrite an existing state name (`qFFSaveState E12`): delete
  `savestates/ff-audit-<tag>-*.sav` first.

## User test 1: Lost Canyons (01B), non-default car, two laps with a restart (2026-10-04)
Three more hazards fell out of the user driving the streamed track with their own car and settings
(the scripted probes use the default car and never restart):

- **Heap exhaustion, kernel wipe.** The race start with that car ran the EA heap dry inside
  `AIDataRecord::Load → loadpackadrz`; retail never checks `reservememadr`, unpacked the AI data to
  address 0 and wiped the kernel (exception vectors zero, `*0x108 == 0`, exception loop). Fix:
  `recon/mod/eaclib/psx/eacpsxz/memstd.c` is the retail allocator verbatim plus a wrapper that retries
  once after `TrackMod_heapHook[0]` (a 16-byte `.data` slot installed by `TrackMod_InitStreamed`,
  cleared by DeInit — calling the mod hook directly hung the front end at frame 0) gives memory back.
- **Per-chunk heap blocks fragment the heap.** Hundreds of evictions left 2–4 KB holes everywhere:
  163 KB free but the largest hole 52 KB, so the cache thrashed (505 urgent failures in 30 s, missing
  geometry on screen) and the sim walked a NULL chunk. Fix: `chunk_cache.cpp` takes ONE pool block
  (`TrkModPool`, class 0x10 = high end of the heap, `largestunused − 0x30000` at init), sub-allocates
  first-fit by address, slot i == chunk i, LRU by pump generation (ahead row stamped one generation back;
  the pump never evicts the current frame's chunks, sim loads may as a last resort); under heap
  pressure the pool is dropped and re-taken smaller (`TrackMod_poolShrinks`).
- **Restart while a prefetch is in flight.** `Restart` moves every car to the start chunks while the
  streamer still has an async meta read pending for the old position; the sim-side loads only spun a
  few hundred `systemtask(0)` and gave up (547 urgent failures in 2 s). Fix: `TrackMod_LoadMetaBlocking`
  waits for the pending read and reads the needed meta synchronously into the spare buffer; the render
  pump keeps its non-blocking prefetch.

Result: lap 1 (slice 1689 → 1680 in ~330 s at 100% emulation speed), Restart → Yes, second start:
0 load / allocation / urgent / prefetch failures over the whole session (log in the session scratch,
`live_01B_run4`). Tracer: scratch `live_trace.py` (RSP interrupt once per second). Emulation speed in the
runtime DuckStation was unlimited for the probes; `EmulationSpeed = 1` now.

## Memory levers measured (2026-10-04, evening)
- **Race memory is two pools.** `bigBuf[282000]` (the front.bin overlay region) becomes the race's
  `Platform_ReserveMemory` / `BWAllocMem` arena: the two ordering tables and the two primitive buffers
  (`gTotalMem` 0x22500 each, draw.cpp:245) fill it completely (680 B free in a race). The EA heap
  (`endofcode+8 … 0x801FC000`) holds everything else, including the streaming chunk pool.
- **Route F (front-only Sony libs into the overlay) is zero-sum.** Linking LIBPRESS/LIBCARD/LIBMCRD
  members with `,front` works (`--stage F`, manifest `front_libs`; endofcode 0x80132988, heap
  +90,492 B) but the overlay grows by 86 KB (the 70 KB DCT table is data) and overflows bigBuf, which
  would have to grow by the same amount: net ≈ +4 KB. Kept as a stage for reference, not used.
- **Stage C = compact libcd, live (2026-10-10).** `recon/mod/syslib/psx/libcd/` now holds verbatim copies
  of `recon/syslib-mod/psx/libcd/{core_api,media_api,drv_core,movie_bridge,route_d_exports}.c`
  (syslib-mod stays canonical; only drv_core.c's `link_stripped.h` include path differs by one `../`).
  `route_d_exports.c` owns `CD_cbread`/`CD_read_dma_mode`, the two EVENT words core_api references, so
  slink no longer extracts EVENT.obj and the duplicate `CdInit` is gone. The manifest's new `tu_flags`
  compiles these five TUs with gcc 2.7.2 at -G0 (the lane syslib-mod verified them under; route_d.py
  now compiles in-process so per-TU flags apply without touching tools/build.py). Result on top of
  stage B: endofcode 0x80146CF8 -> 0x8014600C, heap 742,144 -> 745,452 B (+3,308; +11,000 vs retail).
  Only the resident core shrinks: the movie/ISO/STR/libds members (18.6 KB) stay resident in a source
  relink -- syslib-mod's bigger number comes from its fixed-address overlay/restore of that group,
  which route D does not have. Verified: `routed-01B-ms-c` boots, Track_Init completes (7,065 frames),
  3,000 pad frames of race (11,142 ticks): 59 chunk loads, 0 evictions/failures, music started and
  stayed clean (errorcode 0, 0 underruns), EA heap 36 KB free in race (the extra heap lands in the
  chunk pool by the reserve rule, not in free space).
- ⚠️ `build/route_d/` is shared with `recon/syslib-mod/tools/build_route_d_stage_c.py --syslib-only`
  (run 2026-10-07): that control link overwrote disc/NFS4.EXE, nfs4_d.map and the CPE with an image
  that has NO recon/mod content. Always rebuild (`route_d.py --stage C`) before `route_d_disc.py`.
- **Future integration: movie/ISO/STR/libds group as a second disc overlay (assessed 2026-10-10, not built).**
  The 14 objects of `recon/syslib-mod/psx/libcd/race-overlay-objects.txt` (iso9660, cdread, cdread2,
  stcdint, CDROM, C_002..C_010, libds DSCB) total 18,668 B of which 9,216 B is the iso9660 directory
  cache in BSS and ~9.1 KB is code/rodata; nothing in the race calls them (EAC streams through cdfs.c
  over the libcd core; syslib-mod's breakpoint census saw zero race entries). Options: (1) `,front`
  into the front overlay = zero-sum (FRONT.BIN 279,880 B in bigBuf[282,000]); (2) syslib-mod's in-RAM
  RefPack restore = only needed for a fixed-address patch; (3) **a second SLINK overlay group
  `over(...) file("movie.bin")` in resident text, reloaded from disc where the engine reloads
  FRONT.BIN (Nfs2_CleanUpGameModule path) with a guard before STR start / CdSearchFile; BSS re-zeroed
  on reload; the region becomes race storage (chunk-cache arena slots or the music globals, letting
  the pool reserve drop).** Needs: link-script group + disc entry (route_d.py / route_d_disc.py),
  reload hook, EvictAll before the reload if the pool uses the region, and an entry-breakpoint census
  of every member through race/restart/quit/replay + cold STR playback on the route D image.
  Expected: ~18.6 KB resident gain for one ~9 KB disc read per return to the front end.
- **DONE 2026-10-10: race music moved from the EA heap into bigBuf (user idea).** Measured race music =
  33,100 B of heap (Music Globals 344, Music Buffer 29,980 = 0x6000 ring + 5,404 stream/packet overhead,
  big-file header 2,704, Song List 8; the 0x14000 SPU packet buffer is in SPU RAM). Implementation, all in
  recon/mod: `game/common/music_arena.cpp` (TrackMod_InitMusicArena reserves TRACKMOD_MUSIC_ARENA = 0x9000 B
  from the bigBuf bump arena and makes it EA memory class 2 via creatememclass; TrackMod_KillMusicArena;
  TrackMod_MusicClass), `game/psx/platform.cpp` override (Platform_InitMemory ends with
  TrackMod_InitMusicArena -- it must exist before Nfs2_StartUp starts the music, which is BEFORE the first
  render frame reserves the primitive buffers), `game/psx/draw.cpp` override (AllocatePrimitivesBuffer caps
  gTotalMem: 0x12000 single player / 0x1C000 split screen instead of 0x1F600 / 0x22500, which is what makes
  room: measured peaks 51,340 B 1P light, 109,200 B 2P night+weather+HP), `game/common/audiomus.cpp`
  override (SysStartUp allocates the three blocks with class TrackMod_MusicClass(), each falling back to
  the heap and counting TrackMod_musicHeapFallbacks; SysCleanUp ends with TrackMod_KillMusicArena so
  front-end music stays on the heap). Verified on routed-01B-ms-c: music globals 0x80010100 / ring
  0x80010268 / header 0x80017798 (all in bigBuf), 0 fallbacks, errorcode 0, 1,500-frame drive clean, EA heap
  free in race 36 KB -> 69 KB, bigBuf still 73 KB unused in 1P (gCurrentMemory 0x80042E68 of 0x80054D10);
  Restart race OK (ticks reset, 0 failures); Quit Race -> front end: class 0, front-end music on the heap
  (AudioMus_g 0x8015B5B8) and playing (requestsong 3). Open: the quit sequence logged 176 `meta read`
  load failures (TrackMod_loadFail[2]) and 8 extra loads during the post-race phase -- streaming pump
  after the geometry stream closed; not caused by this change, to be looked at. Heavy-load (2P) prim cap
  not yet user-tested: 0x1C000 leaves ~5 KB over the measured 2P peak.
- **Real levers left:** the GTE sine table (4.9 KB, needs compact libgte members; syslib-mod's
  quarter-wave RotMatrix is the candidate), and capping the primitive buffers
  (0x22500 → ~0xD000 each would free ~170 KB of arena for a pool there; untested for overflow).
- **Music.** `Nfs2_StartUp` (nfs3.cpp:236) starts race music only if `largestunused() > 0xB000` after
  `Sim_StartUp`; the pool's 0x30000 reserve left ~38 KB, so Lost Canyons had no music. Reserve is
  now 0x3C000: music globals allocate at race start (AudioMus_g set, EA heap ~36 KB free afterwards).
- The modding-studio pipeline (`tools/mod-studio` `--from-nfs3 --replace` → `--repack-psh` →
  `--stream-from-grp` → `route_d_disc.py`) is the track conversion path now; see the memory hub.
