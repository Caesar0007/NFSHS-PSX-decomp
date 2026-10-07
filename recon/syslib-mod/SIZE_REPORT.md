# Syslib-mod CD memory report

Measured with the project's GCC 2.7.2 syslib lane (`-O2`) on 2026-10-02. Sizes count runtime
`.text`, `.rodata`, `.data`, `.bss`, special text/BSS sections, and COMMON storage; ELF metadata
and relocations are excluded.

## Race-resident core

| Object | Text | Read-only | Data/BSS | Total |
|---|---:|---:|---:|---:|
| `drv_core.c.o` | 5,124 | 80 | 292 | 5,496 |
| `core_api.c.o` | 1,460 | 32 | 8 | 1,500 |
| `media_api.c.o` | 564 | 6 | 0 | 570 |
| **Modified race core** | **7,148** | **118** | **300** | **7,566** |

The corresponding original resident objects (`drv`, `cdcont`, `event`, `TYPE`, `toc`) total
11,186 bytes. The rewritten resident core therefore saves **3,620 bytes**.

That is the object-level ceiling, not the integrated allocator result. The final staged core also
contains the 112-byte movie bridge and a 46-range segmented allocator/table. Its installed store is
8,128 bytes. Redirect veneers and the public CD callback/status/position/mode words remain at their
retail addresses; the exact safely retired ranges total 10,562 bytes. The realized additional gain
over the already compact-GTE image is therefore **2,434 bytes**, and the combined production race
capacity is **61,669 bytes** (46,159 base + 4,948 GTE tail + 10,562 retired CD storage).

## Race overlay saving

The original movie/ISO group in `psx/libcd/race-overlay-objects.txt` totals approximately 18,796
runtime bytes, including the 9,216-byte ISO9660 cache BSS. It is not needed by EAC file/music
streaming during a race. `movie_bridge.c.o` is only 112 bytes and is loaded with that overlay.

Relative to the original complete libcd + DSCB footprint of approximately 29,982 bytes, the
race-resident modified core is 7,566 bytes. Expected race-memory recovery is therefore:

**29,982 - 7,566 = 22,416 bytes**

Alignment and final linker placement can reduce the directly usable amount. The objects must be
collected into explicit resident/overlay ranges; simply dead-linking scattered input objects will
not necessarily create one contiguous arena.

## Compatibility gates completed

- `core_api.c`, `media_api.c`, `movie_bridge.c`, and `drv_core.c` compile with the 2.7.2 lane.
- A relocatable link of the modified race core succeeds.
- Linking that core with the unmodified EAC `cdfs.c.o` leaves no unresolved `Cd*`/`CD_*` symbol.
- Linking the movie/ISO set plus `movie_bridge.c.o` leaves no unresolved CD/stream API symbol;
  remaining imports are ordinary libc/libapi dependencies.

No runtime claim is made yet. Required DuckStation gates are cold boot, `FILE_init`/`CD_Init`,
async file loads, music, speech/SFX, lid-open recovery, cleanup, frontend return, and STR movie
playback after restoring the movie overlay.

## Main changes

- shared compact implementation for `CdControl`, `CdControlB`, and `CdControlF`;
- 32-byte command-property table instead of the original 128-byte integer table;
- removed CD diagnostic formatting and command/interrupt name tables;
- four 32-entry driver attribute tables compacted from integers to bytes;
- `CdDiskReady` narrowed to the only mode NFS4 calls (`mode == 1` behavior);
- `CdGetToc` narrowed to the sole caller's media-validity requirement;
- full sector-16 ISO signature check retained in `CdGetDiskType`;
- the five restored-movie wrappers retained in the compact resident image so the old SYS.OBJ
  bodies can safely become allocator-owned.

## Stage-1 leaf replacements

`psx/libsn/retail_stubs.c` replaces SN development-host `PC*` break services. EAC's unchanged
fileroot still links, but the retail kernel path never enables that backend.

`psx/libgpu/font_stub.c` replaces FONT.OBJ. Whole-program call/reference census finds no
`FntOpen`, `FntLoad`, `FntPrint`, or `SetDumpFnt` consumer; movie's lone `FntFlush(-1)` call is a
no-op because no font stream exists. Runtime paired gates remain required before promotion.

The host-I/O saving is **512 bytes**, not 516: the original 572-byte libsn census includes the
unrelated 4-byte `PUREV` member, which the PC stubs do not replace. The seven public stubs occupy
56 bytes; their replaced public bodies, SNread/SNwrite helpers and SNDEF words occupy 568 bytes.

### FONT actual-reclaim proof

The five exact reclaim ranges total 22,276 bytes: 1,748 text, 156 rodata, 2,960 initialized data,
and 17,412 BSS. The candidate overwrote every byte with deterministic canaries before track load.
After `Track_Init` and 900 driven race frames all five ranges were unchanged, while retail and
candidate matched RAM outside those ranges, registers, scratchpad, framebuffer, 1,086 slices and
2,697 simulation ticks. This is verified reusable memory for the tested race route, not merely a
link-size estimate.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\font-reclaim-race-20261002-01\report.json`.

### Combined race overlay proof

`race_reclaim.json` adds the exact linked libmcrd/libcard text, rodata, data and BSS ranges
(9,703 bytes) to the verified FONT/PC arenas. The cumulative **32,491-byte** candidate overlay was
filled completely with canaries after frontend setup. All ranges remained untouched through track
load and 900 race frames, with exact paired state and framebuffer. Memory-card ranges must be
restored before game cleanup or frontend card activity.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\race-reclaim-32491-20261002-01\report.json`.

### Extended movie/card race overlay

The canary-backed overlay now additionally contains:

- libpress service code/data and proven-unused DCT table portions: 12,961 bytes;
- movie-only PsyQ CD/ISO/STR/libds code and storage: 18,668 bytes.

The movie-CD value corrects the earlier 18,796-byte object-file estimate: 128 bytes belonged to
link-stripped `StGetBackloc`/DS callback bodies and never occupied retail RAM. The cumulative exact
race overlay is therefore **64,120 bytes**. Every byte remained unchanged through track load and
900 race frames while EAC music/file streaming remained live.

The 18,668-byte movie-only CD/ISO/STR/libds overlay and the compact resident core's 10,562 retired
bytes are disjoint. Taken together, the CD strategy makes **29,230 bytes** available during a race,
while restoring the movie side before frontend STR playback. This exceeds the original approximate
22 KiB whole-libcd target without removing EAC music/file streaming from the race.

Receipt: `C:\Temp\nfs4-syslib-pair\reports\race-reclaim-64120-20261002-01\report.json`.

### Restore footprint and net gain

The production restore artifact has 68 entries covering the 41,332-byte restorable portion:

- 31,716 bytes of immutable payload loaded from disc;
- 9,616 bytes reconstructed by zero-fill;
- 478 mutable bytes preserved in a sparse entry-time snapshot.

The production loader, natural hooks, and segmented allocator occupy 1,745 bytes. The 33,368-byte restore
artifact is encoded as a 13,800-byte RefPack stream and preloaded into otherwise-unused FONT BSS
before the race; a 478-byte mutable snapshot and 1,924-byte address map are retained beside it.
Including allocator control and alignment/status storage, these reservations total 17,961 bytes.
The current production manifest therefore exposes **46,159 bytes** for race allocations while requiring no CD read during
cleanup.

Applying static restore plus the 478-byte startup snapshot reproduced all 41,332 retail post-race
bytes exactly; the snapshot values themselves had zero changes during the tested race.

The allocator-backed lifecycle gate independently verified all 82 returned arena segments and every
restored byte after a driven race: 68
entries, 41,332 checked bytes, zero differences against immutable payload plus the captured dynamic
snapshot.

Receipts:

- `C:\Temp\nfs4-syslib-pair\reports\dynamic-restore-audit-20261002-01.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-packed-restore-proof-20261002-01\report.json`
- `C:\Temp\nfs4-syslib-pair\reports\overlay-arena-natural-20261002-02\report.json`

## GTE compact trigonometry stage

`tools/gen_gte_quarter.py` derives a 1,025-entry signed-16 quarter-wave table from retail
`CSTBL.c` and proves both identities over all 4,096 angles:

- packed cosine equals sine at `(angle + 1024) & 4095`;
- quadrant reflection/sign reconstruction equals every retail sine value.

The generated table is 2,050 bytes versus the original 16,384-byte packed table: **14,334 bytes
of exact data reduction** before replacement-code cost. The final compact code/table/config layout
leaves **13,076 bytes** as a contiguous allocator arena before the CD core is layered into it.
Both `RotMatrix` and `RotMatrixZ` are implemented. A 274-case/72-case call differential passed
with zero output mismatches, followed by exact symmetric startup, race lifecycle, memory-card,
movie, split-screen/night/pause, and restoration gates. With the CD core installed, 4,948 bytes of
that tail remain directly allocatable.
