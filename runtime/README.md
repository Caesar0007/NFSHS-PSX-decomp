# runtime/ — the NFS4 dynamic-verification lane

Adopted 2026-09-13 from `C:\Temp\PSX-Dynamic-Decomp` (the evidence-based
dynamic-decompilation kit distilled from the Fighting Force xport). Purpose:
add RUNTIME checking on top of the byte-matching pipeline — paired full
save-states, RAM/register/GTE audits, and a queryable analysis database over
the whole corpus.

## The disc — proven provenance (2026-09-13)

`C:\Temp\_from_github\NFS4.CCD/.IMG/.SUB` is the **developer disc** (no
SYSTEM.CNF; boots via PSX.EXE): root carries `NFS4.EXE`, `NFS4.CPE`,
`NFS4.MAP`, `NFS4.SYM`, `FRONT.BIN`. Measured facts:

- The disc's `NFS4.SYM` is **byte-identical** (sha256 `B0DD4316…`) to our
  trusted SYM source (`dumpsym_src\NFS4.SYM` → `nfs4-f-v3.txt`). This disc is
  the origin medium of the project's ground truth.
- `NFS4.EXE` == the memory image of `NFS4.CPE` (same build). vs
  `rom/nfs4-f.exe`: **byte-identical everywhere above 0x80054D90** (game
  code, EA libs, data); all 197,000 differing bytes lie in
  0x80010000..0x80052B27 — the frontend overlay window.
- `FRONT.BIN` (279,880 B) loads at 0x80010000 and is **byte-identical to the
  base image's frontend window, 0 diffs**. So disc EXE + FRONT.BIN overlay
  == `nfs4-f.exe` exactly: runtime state on this disc IS our oracle build.
- Live proof (`probe_boot.py`): all game-code RAM windows MATCH after boot —
  `BASE-IDENTITY VERIFIED`. The frontend windows match once the game loads
  FRONT.BIN (menu entry; needs pad input to get there).

## Layout

| path | what |
|---|---|
| `duckstation/` | **gitignored** 167MB copy of the patched DuckStation (source commit `5fd3668`, `state-api.patch` on `gdb_server.cpp`, v0.1-11752): GDB save/load full state (`qFFSaveState`/`qFFLoadState`) + shared-memory RAM export. Re-seed by copying `C:\Temp\PSX-Dynamic-Decomp\tools\duckstation\api-runtime` and setting `[Debug] GDBServerPort = 2350` in `settings.ini`. |
| `tools/launch.ps1 / stop.ps1` | start/stop the project emulator (headless-windowed, starts PAUSED; `-FastBoot`; `-Exe path` boots a PS-X EXE/CPE directly). Writes `status/duckstation-process.json`. |
| `tools/gdb_remote.py` | GDB-remote client (`Remote('127.0.0.1', 2350)`): breakpoints, regs incl. GTE, RAM reads via shared memory when stopped, `checkpoint(name[, load=True])`. |
| `tools/shared_ram.py` | read-only map of the emulator's exported 2 MiB RAM (`duckstation_<pid>`). |
| `tools/probe_boot.py` | identity gate: sample RAM windows vs `rom/nfs4-f.exe` (`--wait-frontend` polls for the overlay). |
| `tools/checkpoint.py` | `save|load <name>` full-state checkpoints (never overwrites; load clears breakpoints). |
| `tools/ccd_extract.py` | read/extract files from the raw CCD image (identify, `--list`, `--get`). |
| `tools/build_database.py` | (re)build `analysis.sqlite` — derived, never hand-edited. |
| `tools/query.py` | per-function card: `py -3.14 runtime/tools/query.py transmult` or `0x80105F40` (`--image`, `--full`). |

## analysis.sqlite (regenerable; gitignored)

7 images (base + 6 regionals), 5,200 functions, 249,909 instructions (rendered
oracle text + raw word from the image), 11,350 direct-call edges (6
unresolved), 4,783 symbols, 1,459 regional reuse pairs.

- `functions`: identity = (image, address); base statuses from
  `MATCH_PROGRESS.txt` (100% → DONE), regionals from
  `regiondiff/REGION_PROGRESS.txt` (SEALED→DONE / FAIL→WIP / N-A→SKIP; note:
  a variant-group seal is recorded on its representative row only — a
  regional TODO here may be covered by `variants.tsv`).
- `instructions`: from the symdump oracle `C:/Temp/symdump-disasm/disasm-v4.txt`;
  function attribution bins every address against the board VAs, so
  debug-stripped lib fns (no oracle header) still own their bodies.
- `edges`: `&Name()` call sites; `func_<va>` targets resolved by VA.

## Port discipline

- **NFS4 lane = port 2350.** Port 2349 belongs to the TM1 project's copy of
  the same runtime (`C:\Temp\tm1-clean\tools\duckstation\`), 2348 to the
  Fighting Force original. `launch.ps1` refuses a busy port; `stop.ps1` only
  kills a PID whose executable path matches our own record. Never stop
  another project's emulator.
- One controlling GDB client per emulator; snapshot RAM only while stopped.

## How runtime checking serves the byte-matching project

1. **Semantic acceptance for near-miss FAILs** (the 4 vendor-identity
   certificates + 5 regional near-misses): checkpoint before the function,
   patch our candidate's differing words into RAM over GDB, run to the
   return, diff RAM/regs/GTE against the unpatched run — behavioral
   equivalence evidence while the byte identity stays acquisition-gated.
2. **Paired checkpoints** at proven-comparable boundaries (the FF method):
   original disc vs a rebuilt EXE booted with `-Exe`, same absolute-tick
   inputs, first-divergence localization.
3. **Data-table verification live**: watch a regional data symbol's bytes in
   RAM instead of reasoning statically about overlay state.
4. **Call-coverage ground truth**: breakpoint sweeps confirm which board
   functions actually execute on a route (DB `edges` gives the static
   frontier to instrument).

Method contract (adopted from the kit's AGENTS.md): a call marker means
COVERAGE, not correctness; save/load only on a stopped CPU; a loaded state
clears breakpoints; never overwrite an existing checkpoint; compare like
with like (same emulator build, same disc, same schedule).
