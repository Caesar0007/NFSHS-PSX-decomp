# nfs4-decomp — Need for Speed: High Stakes (PSX) matching decompilation

A byte-matching decompilation of the PSX build of *Need for Speed: High Stakes*
(`nfs4-f`, EA 1999), in the [Silent Hill decomp](https://github.com/Vatuu/silent-hill-decomp)
mould: splat-split asm, `INCLUDE_ASM`-based mixed translation units, and objdiff
per-function matching against the original binary.

> **Goal**: recompile to a byte-identical `nfs4-f.exe`. This is the *matching*
> track — distinct from the sibling "compile + link + run" reconstruction
> (`reconstructed_headers/tree`).

## Status

The full pipeline is wired and proven end-to-end:

| Stage | Status |
|-------|--------|
| splat split of `nfs4-f.exe` | ✅ 2573 function `.s` + data sections, `src/main.c` |
| asm → ELF round-trip fidelity | ✅ byte-exact on all non-relocated words; `.rodata` reassembles **96.49%** |
| C compile via real PsyQ `cc1` (gcc 2.8.0) → maspsx (aspsx 2.77) → GNU `as` | ✅ |
| link (`ld`) → flat `nfs4.exe` | ✅ builds a full 1.24 MB image |
| whole-image byte match | 🚧 ~43% (see *Next steps*) |

The disassembly is faithful; remaining mismatch is **section layout**, not bad asm.

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
```

## Build

```sh
# 1. (re)generate symbols + split  — only when configs change
py -3.12 tools/gen_symbols.py
py -3.12 C:/Temp/splat-main/split.py configs/nfs4.yaml
py -3.12 tools/fix_gte.py            # GTE compute ops GNU as can't assemble

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

Current baseline: **0.08 %** matched (74 / 2567 functions — the trivial stubs).
This is a per-*object* diff, so it does **not** depend on the whole-image link.

[decomp.dev](https://decomp.dev) ingests that report via CI:
`.github/workflows/report.yml` (windows runner, native cc1) builds it and uploads
the artifact `nfs4-f_report`. Then add the project on decomp.dev and install its
GitHub App. The workflow needs a one-time `TOOLCHAIN_ZIP_URL` secret (PsyQ cc1 is
copyrighted, so it's not committed) — see the workflow header.

## Next steps (toward 100% match)

1. **Section layout** — `linkers/nfs4.ld` `ALIGN(.,16)`/`SUBALIGN(16)` pads
   `.text` past its true 4-aligned start `0x8005797C`, cascading mismatches.
   Pin sections to exact VAs (no over-alignment). This is the dominant gap.
2. **rodata/front-overlay zone** — `0x80010000–0x80054547` is shared by main
   `.rodata` and the `front` overlay; split a second config (`front.yaml`)
   like SH's `bodyprog.yaml`.
3. **objdiff** — `objdiff.json` is stubbed; build an `expected/` set (pure-asm
   objects) once layout matches, then decompile functions in `src/main.c`
   one at a time, diffing against expected.
4. Migrate functions out of the monolithic `src/main.c` into per-source-file
   TUs (use the SLD source-file map from the sibling reconstruction project).
```
