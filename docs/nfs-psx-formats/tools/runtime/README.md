# Runtime probes (NFS4 in modified DuckStation)

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
