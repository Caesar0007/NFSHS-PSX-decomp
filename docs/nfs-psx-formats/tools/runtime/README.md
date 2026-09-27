# Runtime probes (NFS4 and NFS3 in modified DuckStation)

Uses the **PSX-Dynamic-Decomp** DuckStation build (GDB server + `qFFSaveState`/`qFFLoadState` full-state
API), run from an **isolated copy** so other projects' runtimes are never touched.

| Item | Value |
|------|-------|
| Runtime copy | `C:\Temp\nfs4-runtime\duckstation` (copied from `C:\Temp\PSX-Dynamic-Decomp\tools\duckstation\api-runtime`) |
| GDB port | **2350** (Fighting Force uses 2348, TM2 2349) |
| GDB client | `C:\Temp\nfs4-runtime\gdb_remote.py` (copied), run with `FF_GDB_RAM_BACKEND=rsp` |
| Disc | `C:\Temp\nfs4iso\NFS4.cue` → `NFS4.IMG` (the image the pristine files came from) |
| Addresses | retail `C:\Temp\nfs4iso\NFS4.MAP` |

## Pad injection
Breakpoint on `PAD_update`'s `jr ra` (0x800E4310); after each tick the host writes the raw active-low
button word of `gPadinfo.buf[0]` (0x8013E8A2). Every input reader (`PAD_state` and the direct
`gPadinfo` readers in `device.cpp`) sees it. Masks after inversion: Start 0x0008, Cross 0x4000.
The default pattern (Cross 4 ticks of every 24, Start every 4th cycle) reaches a race from a cold boot
in about 7,000 ticks (~4.5 minutes in interpreter mode).

## Scripts
- `nfs4_track_probe.py <outdir>` — boot, drive the front end, stop after `Track_Init` returns, dump
  header / chunk list / visibility / slices / centers / light table, save checkpoint
  `nfs4_after_track_init`.
- `compare_track_init.py <outdir> <GRP>` — compare that dump with the file-spec predictions (8 checks).

## Result log
- 2026-09-27: `zTr06.grp` (track 06, day). 8/8 checks byte-exact.

## NFS3 (SLUS-006.20)
Same runtime copy and port. Disc: `C:\Temp\nfs3_iso\NFS3.cue` (local copy of the share's `NFS3.bin`).
Addresses from the NFS3 raw oracle (`C:\Temp\nfs3-clean\nfs3-raw-L.txt`).
- Pad injection: breakpoint on `func_800DE180`'s `jr ra` (0x800DE38C); write `{0, 0x41, buttons}` to the pad
  record at 0x8012E2F0 (same active-low masks). The Cross/Start pattern reaches a race (track 00A) in ~7,000 ticks.
- `nfs3_track_probe.py <outdir>`: capture chunks at 0x8007A728 (after copy + bind + relocation), dump TRK
  header/tables, save checkpoint `nfs3_after_chunks`.
- `nfs3_track_probe2.py <outdir> --colbuf ... --slices ... --matlist ...`: resume from the checkpoint, dump COL
  data, hold accelerate and capture more chunks. For track 00A: `--colbuf 0x800247ec --colsize 42064
  --slices 0x80026560 --nslices 959 --matlist 0x80022d6c --nmat 403`.
- `compare_nfs3_chunks.py <outdir> <TRK> [<COL>]`: compare with the file spec.
- `nfs3_watch_probe.py <log.json> --addr 0xADDR:LEN ...`: from the checkpoint, hold accelerate and set GDB read
  watchpoints (`Z3`, supported by this runtime; 52 at once worked); logs every PC that reads the watched bytes.
  Used to find the readers of COL slice +21/+24/+26/+34 and material +2 (NFS3_TRACK_FILES.md §2).
- 2026-09-27: track 00A, 56 chunk captures (48 distinct chunks) byte-exact after the predicted relocation; all
  `Chunk_tChunkDat` slots, tables, slices and materials match (NFS3_TRACK_FILES.md §1.7).
