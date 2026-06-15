# Running decomp-permuter on this project

decomp-permuter grinds a near-matching function (objdiff fuzzy 90–99 %) toward a
byte-perfect match by randomly mutating its C and recompiling thousands of times.

EA's `nfs4-f` reconstruction is **cfront C++**, which fought the permuter on three
fronts; all are now handled by the `tools/` glue:

| Problem | Fix |
|---|---|
| permuter's vendored pycparser rejects cfront `(...)`-only prototypes (vtable dispatch casts, PsyQ lib decls) | `tools/patch_permuter.py` adds a `parameter_type_list : ELLIPSIS` grammar production and rebuilds the yacc tables (one-time, idempotent) |
| C++ class bodies / `bool` / `::` / `extern "C"` are unparseable, and sibling function bodies drag them in | `tools/permuter_sanitize.py` strips layout-neutral methods/ctors/dtors, unwraps `extern "C"`, rewrites `::`→`__`, and **reduces the TU to the single target function** + its real (layout-exact) type context |
| `compile.sh` can't be `CreateProcess`'d on Windows | `tools/run_permuter.py` shims `*.sh` invocations to `python tools/permute.py compile …` |

## One-time setup

```sh
python tools/patch_permuter.py        # patch + rebuild the permuter's parser
```

## Per-function workflow

```sh
# 1. create the job: recon module, mangled symbol, its nonmatching .s
python tools/permute.py setup game/common/aiinit.cpp \
    AIInit_DeInitAICar__FP8Car_tObj \
    asm/nonmatchings/main/AIInit_DeInitAICar__FP8Car_tObj.s

# 2. grind (use -j N for N parallel workers; -J is permuter@home, not local cores; lower score = closer, 0 = byte-perfect)
python tools/run_permuter.py permuter_work/AIInit_DeInitAICar__FP8Car_tObj -j 8
```

When it prints `found a match!` (score 0), copy the winning function body from the
printed source back into the recon module, then re-run the objdiff report. Good
targets are the 90–99 % functions in the report (e.g. `AIInit_CleanUp2` 93 %,
`AIInit_InitAICar` 95 %, `AIInit_RestartAICar` 93 %).

`permuter_work/` is gitignored scratch.
