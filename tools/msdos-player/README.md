# tools/msdos-player

`msdos.exe` — **MS-DOS Player for Win32-x64 console** (Takeda Toshiya and contributors), the i486 build. It runs a 16-bit
DOS program directly from a 64-bit Windows console, with the host's files and environment.

Used here for exactly one thing: Sony's `CPE2X.EXE` (16-bit DOS) in the native link route, which turns PSYLINK's
`NFS4.CPE` into the PS-X EXE `NFS4.EXE`. See `BUILDING.md`, Route B, and `tools/psyq_pipe/psylink_disc.py`.

```bash
tools/msdos-player/msdos.exe CPE2X.EXE /CA NFS4.CPE
```

`CPE2X.EXE` itself is Sony's and is **not** in this repository; it comes with the PsyQ SDK (`PSX/BIN/CPE2X.EXE`).

## Licence and source

MS-DOS Player is free software under the GNU General Public License v2 — see `license/COPYING.txt`, and the notices of the
components it embeds in `license/np21w`, `license/softfloat`, `license/softfloat3`. `readme.txt` is the upstream readme.

This binary was built from <https://github.com/Caesar0007/msdos-player> at commit `9128b9b`
(`binary/msdos_i486.exe` there). The complete corresponding source is that repository.
