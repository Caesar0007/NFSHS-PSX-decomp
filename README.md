# nfs4-decomp — Need for Speed: High Stakes (PSX) matching decompilation

A byte-matching decompilation of the PSX build of *Need for Speed: High Stakes*
(`nfs4-f`, EA 1999), in the [Silent Hill decomp](https://github.com/Vatuu/silent-hill-decomp)
mould: splat-split asm, `INCLUDE_ASM`-based mixed translation units, and objdiff
per-function matching against the original binary.

> **Goal**: recompile each function to a byte-identical object (per-function
> 100% matching, objdiff/decomp.dev). This is the *matching* track — distinct
> from the sibling "compile + link + run" reconstruction
> (`reconstructed_headers/tree`).

## 👉 Read [METHODOLOGY.md](METHODOLOGY.md) FIRST

[**METHODOLOGY.md**](METHODOLOGY.md) is the matching playbook — the two hard
rules (100%-only; the `disasm-v4.txt` oracle), the per-function workflow, the
technique catalog (symptom → fix), permuter usage, the data-mat pass, and the
live status. **If you're an agent resuming after `/compact`, open it before
touching anything.**

## Status

The full pipeline is wired and proven end-to-end (splat → real PsyQ `cc1` 2.8.0
→ maspsx/aspsx 2.77 → GNU `as` → ELF → objdiff), CI-green on a Windows runner,
and live on [decomp.dev](https://decomp.dev/Caesar0007/NFSHS-PSX-decomp).

**Per-function matching is the active work.** First module under attack is
`game/common/aiinit` (objdiff unit): **12/17 functions byte-perfect (50%)**;
overall **0.48%**. See [METHODOLOGY.md](METHODOLOGY.md) for the live table and
the remaining (gcc register-allocation–bound) near-misses.

## Toolchain

The original was built with **SN/PsyQ 4.3**: `cc1` GNU C **2.8.0** + **ASPSX 2.77**.
We drive the real `cc1` and replace ASPSX with [maspsx](https://github.com/mkst/maspsx)
+ GNU `as` (produces ELF for objdiff). Configured in `tools/build.py`:

- `CC1PSX.EXE`   — `C:/Temp/psq43/COMPILER/` (real PsyQ compiler)
- `maspsx.py`    — `C:/Temp/maspsx-master/`  (`--aspsx-version=2.77`)
- `mipsel-none-elf-{as,ld,objcopy}` — `C:/Tools/mips-ps1/mips/bin/` (binutils 2.43)
- `splat` — `C:/Temp/splat-main/` (run under Python 3.12, which has rabbitizer/spimdisasm)

Build flags: `cc1 -O2 -G4`, `maspsx --aspsx-version=2.77 -G4` (forces `as -G0`).

## Layout

```
configs/nfs4.yaml          splat config (PS-EXE @0x80010000, t_size 0x12E000)
configs/symbol_addrs.txt    VA->name, generated from NFS4.MAP (tools/gen_symbols.py)
include/decomp/types.h      s8/u32/q19_12 ... fixed-width + Q-format aliases
include/decomp/include_asm.h INCLUDE_ASM macro (maspsx-keep variant)
include/macro.inc           glabel/jlabel/dlabel/alabel/endlabel (jlabel is global)
include/common.h            master include for every src/*.c
src/main.c                  the main .text TU (C stubs + INCLUDE_ASM per fn)
asm/nonmatchings/main/*.s    per-function disassembly
asm/data/*.s, asm/header.s   data sections + PS-EXE header
linkers/nfs4.ld             splat-generated linker script
rom/nfs4-f.exe              the target (NOT committed — sha1 b48ea3452e64...)
tools/build.py              cpp->cc1->maspsx->as->ld->objcopy + byte-diff report
tools/gen_symbols.py        NFS4.MAP -> symbol_addrs.txt (sanitizes . and case clashes)
tools/fix_gte.py            rewrite GTE compute ops (rtps/mvmva/...) to .word
tools/audit_vtable_indexing.py  reject _vf indexing that scales by a whole vtable row
```

## Build

```sh
# 1. (re)generate symbols + split  — only when configs change
py -3.12 tools/gen_symbols.py
py -3.12 C:/Temp/splat-main/split.py configs/nfs4.yaml
py -3.12 tools/fix_gte.py            # GTE compute ops GNU as can't assemble
py -3.12 tools/audit_vtable_indexing.py  # static vtable OOB regression audit

# 2. build + verify against rom/nfs4-f.exe
py -3.12 tools/build.py              # full asm build + link + diff report
py -3.12 tools/build.py --skip-asm   # C-only (objdiff / decomp.me style)
py -3.12 tools/build.py clean
```

## Key solved gotchas

- **cfront names** (`_._14X` dtors, `_vt.16Y`) aren't valid C identifiers →
  `gen_symbols.py` folds illegal chars to `_` (byte-match only cares about
  addresses, not label spelling) and disambiguates case-insensitive clashes
  (`CD_init` vs `CD_Init` collide as filenames on Windows).
- **GTE compute ops** (rtps, rtpt, mvmva, nclip, gpf, ...) are unknown to GNU
  `as`; `fix_gte.py` rewrites them to `.word` using the exact bytes splat
  prints in each line's comment — zero encoding risk.
- **Jump tables** live in the rodata object but target function-internal labels;
  `jlabel` is defined **global** in `macro.inc` so the cross-object `.word .L*`
  references resolve (labels are link-time → no byte change).

## Progress tracking (objdiff / decomp.dev)

`objdiff.json` diffs each unit's **target** (`expected/` = asm build = original
bytes) against the **base** (`build/` = `--skip-asm`, only decompiled C). Generate
the report locally:

```sh
py -3.12 tools/build.py --out expected --no-link   # target objects (once)
py -3.12 tools/build.py --skip-asm                  # base objects
C:/Temp/objdiff/objdiff-cli.exe report generate -p . -o build/report.binpb -f proto
```

This is a per-*object* diff, so it does **not** depend on the whole-image link.
Current overall: **~0.48 %** and climbing as functions are matched one at a time
(see [METHODOLOGY.md](METHODOLOGY.md) for the per-function workflow and status).

[decomp.dev](https://decomp.dev) ingests that report via CI:
`.github/workflows/report.yml` (windows runner, native cc1) builds it and uploads
the artifact `nfs4-f_report`. Then add the project on decomp.dev and install its
GitHub App. The workflow needs a one-time `TOOLCHAIN_ZIP_URL` secret = the toolchain
download link (PsyQ cc1 is copyrighted, so it's not committed). A Dropbox share
link works directly (the workflow forces `dl=1`) — see the workflow header.

## Next steps (toward 100% match)

The active strategy is **per-function matching, one function at a time**, against
the objdiff `expected/` (asm) target — see [METHODOLOGY.md](METHODOLOGY.md) for
the workflow, technique catalog, and live status. In short:

1. Finish the `aiinit` unit (5 near-misses left, all gcc register-allocation /
   induction-variable bound — the hard tail).
2. Vendor the next reconstruction module as a new objdiff unit and repeat.
3. Whole-image link/layout is a separate, later concern; matching is per-object
   and does not depend on it.
