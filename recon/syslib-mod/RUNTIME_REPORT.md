# Syslib-mod paired runtime report

Dual DuckStation methodology follows the TM1/TM2 model: isolated runtime directories, ports 2350
and 2351, independent cold boots, hash-bound process/image records, natural semantic boundaries,
candidate-code normalization only, and full checkpoint restoration.

## Harness control

Retail versus retail reached `Nfs2_GameModuleStartUp` (`0x800A41A8`) at pad frame 6,926 on both
sides. Comparison: zero RAM, scratchpad, register, kernel-timing, and dead-stack differences.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\retail-control-20261002-01\report.json`.

## Stage 1: SN host-I/O stubs

The first combined image was rejected because its patch recipe incorrectly treated the range
`0x80106CD0..0x80106D1C` as all of `PCcreat`; EAC's `psxdevelopmentsystem` actually occupies
`0x80106CF0..0x80106D1C`. The recipe now limits `PCcreat` to 32 bytes. This is a harness-negative
receipt: range manifests must follow real symbol extents, not next-library-symbol distance.

With the corrected PC-only image:

- startup pair: PASS at frame 6,926, zero state differences;
- `Track_Init("zTr06.grp")`: both returned with 1,086 slices;
- 900 driven pad frames: PASS, 2,697 simulation ticks on each side;
- zero RAM, scratchpad, or register differences;
- identical embedded framebuffer;
- zero `PCread/open/init/creat/lseek/close/write` entries observed.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\stage1-pc-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\stage1-pc-race-20261002-02\report.json`

## Stage 1: FONT stub

With only `FntFlush` replaced by `jr ra; return 0` in its retail slot:

- startup pair: PASS at frame 6,926, zero state differences;
- `Track_Init("zTr06.grp")`: both returned with 1,086 slices;
- 900 driven pad frames: PASS, 2,697 simulation ticks on each side;
- zero RAM, scratchpad, or register differences;
- identical embedded framebuffer;
- zero FONT entries observed in startup/race.

An actual-reclaim pass then filled all five former FONT text/rodata/data/BSS ranges (22,276 bytes)
with candidate-only canaries before track load. Every canary remained unchanged after 900 frames;
after normalizing only those declared free ranges, the paired state and framebuffer were exact.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\stage1-font-startup-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\stage1-font-race-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\font-reclaim-race-20261002-01\report.json`

## Additional future hardening

- physical lid-open/disc-swap recovery when the emulator exposes a deterministic tray-control API;
- converted NFS3 layout smoke tests (the converter task was separately paused by user request);
- wiring a specific track-extension format to the generic verified segmented allocator.

## Combined race overlay

The corrected combined FONT+PC candidate and `race_reclaim.json` were tested with all FONT, PC,
libmcrd and libcard reclaim ranges overwritten after frontend setup. Total candidate-owned space is
**32,491 bytes**. Every canary remained intact through `Track_Init` and 900 race frames; RAM outside
the arenas, registers, scratchpad, framebuffer, slice count and ticks matched retail exactly.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\race-reclaim-32491-20261002-01\report.json`.

This proved the race-phase overlay before the production restore hook was added. The packed natural
lifecycle and memory-card receipts below now cover restoration and post-race card access.

## Libpress and movie-CD expansion

Two further layered manifests were canary-tested:

- `race_reclaim_plus_libpress.json`: 45,452 bytes total, preserving the live 59,292-byte CF range;
- `race_reclaim_plus_cd_movie.json`: 64,120 bytes total, retaining the EAC/core PsyQ CD driver while
  overwriting only ISO9660, `CdRead`, `St*`, libds and movie callback storage.

Both passed `Track_Init` plus 900 race frames with every canary unchanged and exact paired RAM,
registers, scratchpad, framebuffer, slice count and ticks. The 64,120-byte group must be restored
before STR playback, card access, or cleanup.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\race-reclaim-64120-20261002-01\report.json`.

## Restore artifact

`tools/build_restore_blob.py` creates `SYSLIB.RSO`; `tools/build_dynamic_map.py` creates the sparse
mutable-byte map. `psx/overlay_restore.c` provides resident save/static-restore/dynamic-restore
entry points and flushes the instruction cache after copying code.

The current blob restores 41,332 bytes from 31,716 payload bytes plus 9,616 zero-fill bytes. A
478-byte snapshot preserves all runtime-mutated fields. A paired checkpoint audit restored every
declared byte exactly (zero differences), and the captured mutable values were unchanged from
overlay entry through the tested race.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\dynamic-restore-audit-20261002-01.json`.

The production disc image stores `SYSLIB.RSO` in the unused retail `NFS4.SYM` file and the sparse
dynamic map in `NFS4.MAP`. It boots to `Nfs2_GameModuleStartUp` at the same pad frame (6,926) with
identical live registers, scratchpad and game state. The comparison explicitly normalizes only the
two ISO directory-entry size words changed by replacing those files; the remaining two differing
words are classified kernel timing state. This proves the loader and artifacts are packaged at the
intended addresses without disturbing startup. Invoking the save/restore entry points around a
complete race and cleanup remains a promotion gate.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\overlay-packaged-startup-20261002-03\report.json`.

Subsequent loader integration established three additional constraints. The injected in-memory
`SyslibMod_SaveDynamic` API passed and returned all 478 snapshot bytes. Synchronous EAC `FILE_*`
calls are not usable from the transition hook, and BIOS A0:A5 cannot take CD interrupt ownership
after the PsyQ stack initializes; both paths were rejected. Retaining a PsyQ `CdRead` bootstrap
worked for one sector but competed with live streaming during multi-sector restoration.

The accepted design performs all disc I/O at overlay entry through NFS4's normal asynchronous EAC
scheduler. `SYSLIB.RSO` is RefPack-compressed from 33,368 to 13,800 bytes, loaded into reserved FONT
BSS before the race, and decompressed into `bigBuf` after audio teardown. Restoration then runs
entirely from RAM. The entry hook returned 478. The cleanup patch is a call-target replacement:
its wrapper first calls the original `AudioCmn_DeInit`, then restores the overlay, preserving the
retail load-delay sequence that follows the call. Cache flushing is enclosed in a short critical
section to avoid the documented BIOS `k0` interrupt race.

The symmetric allocation-only control ran 2,281 game ticks, entered one replay loop, completed the
natural cleanup chain, restored the overlay, drew the loading icon, loaded `front.bin`/DCT, and
stopped at frontend initialization. Every byte of the earlier packed production manifest retained
its canary until cleanup. All 68 restorable entries (41,332 bytes) then matched the packaged payload
plus captured snapshot with zero differences. Final comparison was exact: zero RAM/register/
scratchpad differences and identical framebuffer, track, slices, and ticks. A further 600-frame
neutral frontend soak also passed exactly after normalizing only the declared reclaim arena, with
zero FONT, memory-card, STR, or `CdRead` entries.

A synchronized 900-frame frontend navigation run with eight Cross pulses also passed with zero
normalized RAM/register/scratchpad/framebuffer differences. The restored memory-card path was then
exercised through `Front_SecondaryMemCardCheck`: both sides entered MCRD once, its BIOS layer seven
times, card-info 31 times, and card load/write once each. The paired result remained exact.

The final image also passed a cold-boot native movie gate. `Init_PSX_FrontEnd` entered one
`Movie_Play`, decoded three frames, and completed `Movie_DeInit`; both sides recorded identical
`StSetStream`, `StSetRing`, `StInitRing`, `StSetMask`, and `StUnSetRing` counts. RAM, registers and
scratchpad were exact at the rendering-environment boundary.

Additional symmetric production-arena gates passed:

- pause/resume: one pause-menu entry and one audio pause/unpause on each side, 1,000 pad frames and
  2,779 simulation ticks;
- night/weather: setup opcodes 20/23 selected the `zTr06S.grp` variant, 900 frames and 2,236 ticks;
  a second run completed native replay, cleanup, exact restore and frontend return at 2,001 ticks;
- hot pursuit: race type 1 with one perpetrator, 900 frames and 2,687 ticks; a second run completed
  native replay, speech teardown, cleanup, exact restore and frontend return at 2,000 ticks;
- long soak: 5,000 frames and 19,048 ticks.

All four runs had zero normalized RAM/register/scratchpad/framebuffer differences and unchanged
reclaim canaries. A direct `commMode=1`/two-player override was rejected because the original stream
lacked a coherent second-player/car setup; both controls stalled identically, so it is not counted
as split-screen coverage.

The final loader adds a generated 82-segment bump allocator. In the authoritative allocator-backed
natural lifecycle both sides made the same allocation calls; capacity was **46,159 bytes**, every
returned pointer and size matched `production_race_reclaim.json`, and only the candidate filled the
allocations. The race, replay, cleanup, 41,332-byte restore and frontend return remained byte-exact.
The allocator image also passed restored memory-card load/write and a combined night/weather plus
pause/resume race gate.

Final-image route closure additionally includes:

- cold-boot native STR playback: one `Movie_Play`, three decoded frames, movie teardown, identical
  STR ring lifecycle counts and zero RAM/register/scratchpad differences;
- coherent split-screen: communication mode 1, two players, the existing player-1 record cloned
  from player 0, 900 race frames/2,669 ticks, followed by native replay, cleanup, exact restoration
  and frontend return at 2,002 ticks;
- hot pursuit on the allocator image: 900 frames/2,672 ticks;
- allocator-image soak: 5,000 frames/19,043 ticks.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\overlay-symmetric-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-symmetric-natural-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-symmetric-frontend-soak-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-symmetric-frontend-cross-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-symmetric-memcard-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-pause-resume-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-mode-night-weather-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-mode-hot-pursuit-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-mode-night-weather-natural-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-mode-hot-pursuit-natural-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-long-soak-5000-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-natural-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-memcard-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-frontend-soak-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-night-pause-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-movie-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-split-screen-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-split-screen-natural-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-hot-pursuit-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-long-soak-5000-20261002-01\report.json`

## GTE compact-table experiment

The generated 1,025-entry table exactly reconstructs all 4,096 retail sine/cosine pairs. The final
implementations preserve retail's low-word `multu` fixed-point behavior and instruction-order
formulas. Direct call differential covered 274 `RotMatrix` and 72 `RotMatrixZ` inputs with zero
output mismatches. The compact image then passed exact symmetric startup and allocator-backed
natural race/replay/cleanup/frontend return, memory-card, cold movie, and combined split-screen +
night/weather + pause routes. Its dedicated tail allocator exposes 13,076 bytes before the compact
CD stage is layered onto it.

Equal wall-frame comparison against retail remains inappropriate because the replacement code has
different execution time. Semantic output tests and identical-image lifecycle controls are used for
promotion instead.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\gte-call-diff-20261002-05\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\gte-arena-natural-20261002-02\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\gte-arena-memcard-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\gte-arena-movie-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\gte-arena-split-night-pause-20261002-01\report.json`

## Compact resident CD core extension

The CD core is compiled independently on the PsyQ 2.7.2 `-G0` lane and linked over unchanged
eaclib. Thirty-six public/driver entries redirect to the compact store. Public callback, status,
position, mode, DMA-mode, and `StMode` storage stays at the retail addresses. A separate segmented
allocator exposes only the bytes between the eight-byte redirect veneers plus private data/BSS:
10,562 bytes over 46 ranges. Together with the remaining 4,948-byte GTE tail and the 46,159-byte
base arena, the measured race capacity is **61,669 bytes**.

The final image passed:

- exact symmetric cold startup at frame 6,639;
- 900 race frames / 2,643 game ticks with live EAC file/music streaming;
- all 46 retired-CD canaries plus both older allocators unchanged;
- native replay, cleanup, exact 41,332-byte restore, loading icon, and frontend overlay return;
- cold native STR playback through one `Movie_Play`, three decoded frames, and teardown, with
  identical STR lifecycle counts and zero RAM/register/scratchpad differences;
- Hot Pursuit with speech/copspeak active: 900 frames / 2,659 ticks, native `speech_destroy`,
  cleanup, restoration, and frontend return with every reclaim canary unchanged;
- coherent split-screen plus night/weather and pause/resume in one route: 900 frames / 2,099
  ticks, one pause-menu entry, audio pause/unpause, natural cleanup/restoration/frontend return;
- 5,000-frame / 19,043-tick soak with exact paired state and every reclaim canary unchanged;
- restored memory-card activity: MCRD once, BIOS layer seven times, card-info 31 times, and one
  load/write each, with exact normalized RAM/register/scratchpad/framebuffer state.

An asymmetric GTE-vs-CD run reaches the same track, slice count, and 2,603 game ticks but diverges
in wall-time-sensitive state, as expected for rewritten CD polling paths; it is retained as timing
evidence, not treated as a byte-state gate. Physical lid-open testing remains unavailable until the
emulator exposes deterministic tray control.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-startup-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-natural-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-cold-movie-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-memcard-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-hot-pursuit-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-split-night-pause-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-final-soak-5000-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-vs-gte-race-20261002-01\report.json`

### 2026-10-07 rebuild and Route-D source-link control

The fixed-address production image was rebuilt from `recon/syslib-mod` and reproduced SHA-256
`65c731055426ee1428975804026f4153847f222f2369bfb04bd32c87c3cd9173`, byte-for-byte identical to
the fully promoted image above. A fresh isolated two-DuckStation run again passed exact startup at
frame 6,639 and the natural 900-frame race/restore route at 2,643 game ticks. All reclaim canaries,
RAM, live registers, scratchpad and framebuffer matched.

Fresh receipts:

- `C:\Temp\nfs4-syslib-pair\reports\cd-core-refresh-symmetric-startup-20261007-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\cd-core-refresh-natural-20261007-01\report.json`

The clean Route-D source link now also closes the former `EVENT.obj`/`CdInit` duplicate: the
Route-D-only `route_d_exports.c` owns `CD_cbread` and `CD_read_dma_mode`, while the production
fixed-address build continues to bind the original EVENT cells and pays no extra bytes. The clean
link measures a 3,308-byte heap gain because the movie/ISO members intentionally remain resident.
It is not promoted as a runtime image: a control link using the original PsyQ libcd archive fails
at the same `Track_Init` CD-read point, proving the remaining fault is in the broader reconstructed
Route-D base rather than compact libcd. Production therefore remains the fixed-address patch route,
which preserves the retail game/EAC layout and has the complete lifecycle evidence above.

## BIOS reuse experiments

BIOS `qsort`, BIOS `bsearch`, and a combined low-level GPU helper substitution were independently
rejected by the paired startup gate. See `BIOS_REUSE_REPORT.md`; none of these failed candidates is
part of the proposed compacted build.
