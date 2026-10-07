# NFS4 PSX memory-oriented syslib variant

This tree is an experimental, API-compatible syslib variant for a mod build.  It does not replace
or modify `recon/eaclib`; the EAC `CD_* -> FILE_* -> STREAM_*` stack remains the file and audio
streaming owner.

## CD split

`psx/libcd/core_api.c` is the race-resident public API layer.  It is intended to be linked with the
existing low-level `recon/syslib/psx/libcd/drv.c` and `psx/libcd/media_api.c`.  It replaces the
resident portions of `cdcont.c` and `event.c` with a compact shared command implementation.

`media_api.c` replaces `TYPE.c` and `toc.c` according to the actual NFS4 call graph: all
`CdDiskReady` calls pass mode 1, while the sole `CdGetToc` caller checks only zero/nonzero and never
reads the returned table.  `CdGetDiskType` still performs the sector-16 ISO9660 signature check.

The following original objects form the restorable frontend/movie overlay and must not be resident
during a race:

- `iso9660.c`, `cdread.c`, `cdread2.c`, `stcdint.c`, `CDROM.c`;
- `C_002.c`, `C_003.c`, `C_004.c`, `C_005.c`, `C_007.c`, `C_008.c`, `C_009.c`, `C_010.c`;
- `recon/syslib/psx/libds/DSCB.c`.

The overlay also links `psx/libcd/movie_bridge.c`, which provides the handful of thin public API
wrappers needed by `cdread.c` without charging them to the race-resident core.

Do not link the mod files together with the original `cdcont.c`, `event.c`, `TYPE.c`, or `toc.c`;
they export the same public symbols and own the same callback words.  Movie playback must restore the movie overlay
before calling `CdSearchFile`, `CdRead`, `CdRead2`, or any `St*` function.

## Required validation

Before enabling this in the game linker, validate cold boot, EAC filesystem initialization, music,
speech/SFX streams, asynchronous file reads, pause/race completion, lid-open recovery, cleanup,
frontend return, and movie playback after overlay restoration.  Put entry breakpoints over the
movie overlay during every race-mode test; any hit invalidates the overlay set.

## Production packed race overlay

`tools/build_overlay_candidate.py` builds the current bootable experiment. A final diagnostic
`largestunused()` call is redirected to `SyslibMod_EnterRace`, which asynchronously preloads the
1,924-byte dynamic map and a 13,800-byte RefPack restore stream before the race. The cleanup call to
`AudioCmn_DeInit` is redirected to `SyslibMod_CleanupAudioAndRestore`; the wrapper calls the original
audio teardown and restores syslib entirely from RAM. The retail instructions following that call
are untouched, including their R3000 load-delay `nop`.

The current production manifest reclaims **46,159 bytes** after reserving the 1,745-byte loader,
478-byte snapshot, dynamic map, packed restore stream, status/alignment bytes, and permanent FONT/
PC stubs. The loader exports `SyslibMod_ArenaReset`, `SyslibMod_ArenaAlloc`, and
`SyslibMod_ArenaCapacity`; its generated 82-segment table makes every declared byte consumable by
race code. `production_race_reclaim.json` is generated from the gross 64,120-byte manifest and must
equal `image-report.json.net_reclaim`.

Verified paired gates currently cover cold boot, 2,281 game ticks, replay-loop exit, natural
cleanup, exact 41,332-byte restoration, loading icon, frontend overlay load, 600 neutral frontend
frames, 900 frames of synchronized frontend navigation, and high-level memory-card load/write.
The allocator-backed control is byte-exact outside the declared arena and has identical registers,
scratchpad, and framebuffer.

The base allocator image has exact paired receipts for native STR playback, coherent two-player
split-screen, night/weather, hot pursuit, pause/resume, memory-card load/write, replay/cleanup/
frontend return, and a 5,000-frame/19,043-tick soak.

The compact GTE/CD extension raises the measured race allocation capacity to **61,669 bytes**
without changing eaclib. It uses the exact quarter-wave RotMatrix implementation, a compact
resident CD core, and a redirect-aware segmented allocator over 10,562 bytes of retired libcd
bodies while preserving every public callback/status word and every eight-byte entry veneer.
The extension has passed exact symmetric startup, 2,643 race ticks with live EAC streaming,
natural replay/cleanup/frontend return, cold native STR playback, and memory-card load/write.
See `production_race_reclaim_cd.json`, `SIZE_REPORT.md`, and `RUNTIME_REPORT.md`.

Future integration work outside this generic syslib allocator is a concrete track-extension
consumer, converted-track testing (that separate task is paused), and deterministic physical
lid-open testing when the emulator exposes tray control.
