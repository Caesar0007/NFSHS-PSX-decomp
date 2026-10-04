# `recon/mod` — the NFS4 mod tree (build route D)

Purpose: make NFS3's converted tracks playable in the NFS4 engine. The two largest NFS3 layouts
(01B, 04B) cannot be loaded by the retail `Track_Init` (whole-GRP resident, `fileSize + 0x9080`
in one heap block, 0x9080 head start; see `docs/nfs-psx-formats/formats/NFS4_TRACK_GRP.md`,
"Loading and memory limits"), so the engine itself has to change. Those changes live here, and
only here.

## Rules
- `recon/game`, `recon/frontend`, `recon/eaclib`, `recon/syslib` and build routes A–C are
  **never edited** for this work. They stay the byte-exact reconstruction.
- A mod source mirrors the path of the module it replaces (`recon/mod/game/common/chunk.cpp`
  replaces `recon/game/common/chunk.cpp`) or is a new module beside it. `manifest.json` is the
  only place that says which objects route D swaps, adds, or links ahead of the Sony libraries.
- Mod sources include the main tree's headers by relative path (`../../../game/common/…`), so the
  types stay those of the reconstruction.
- Nothing here is byte-matched; route D output is **bootable, not identical**. Every change is
  verified at runtime in the isolated DuckStation (`docs/nfs-psx-formats/tools/runtime`).
- Origin: the streaming loader comes from `recon/game-mod` (GRH/GRX companions, chunk cache) and
  the compact syslib pieces from `recon/syslib-mod`. Those two trees stay as the experiment
  record; this tree is what route D builds.

## Build (route D)
`python tools/route_d.py` — see `ROUTE_D.md` for the stages and the current state.
