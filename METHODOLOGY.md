# Matching Methodology — read this FIRST

> If you are an agent resuming after a `/compact` (or a fresh session), **read
> this file before doing anything else.** It is the playbook for taking a
> function to a byte-perfect (100%) match. Then check `Status` below for where
> we are and what's next.

## The two hard rules

1. **Target = 100% byte-match only.** A function is "done" only at 100%. Don't
   stop at 99%; don't optimize the fuzzy %. Either it matches or it doesn't.
2. **The asm oracle is `C:\Temp\symdump-disasm\disasm-v4.txt`** (~348k lines).
   It is the authority for instructions, symbol names, data references, XRefs and
   jump tables. It resolves data symbols (e.g. `Paths_Paths`, `AIPhysicConfig`,
   shared-rodata format strings) that the per-function `.s` files leave bare.
   When in doubt about what a function *does*, read it here.

## Per-function workflow

1. **Pick a target** — a function below 100% in the objdiff report (see *Build &
   report*). Prefer the highest-% near-misses first; very low % usually means
   several structural issues.
2. **Diff it** — disassemble the function from both objects and compare,
   normalizing objdump's address artifacts:
   ```sh
   OD=/c/Tools/mips-ps1/versions/v14.2.0/bin/mipsel-none-elf-objdump.exe
   norm() { "$OD" -dr "$1" | sed -n "/<$2>:/,/^\$/p" \
     | sed -E 's/^ *[0-9a-f]+:\s+[0-9a-f]+ \t/ /;s/[0-9a-f]{8} </X </;s/[0-9a-f]+:\sR_/R_/;s/jal\s+0.*/jal/;s/,[0-9a-f]+ </,X </;s/\bj\s+[0-9a-f]+ </j </;s/X <[^>]*>/X/' | awk 'NF'; }
   diff <(norm expected/src/aiinit.c.o   SYMBOL) \
        <(norm build/recon/.../module.cpp.o SYMBOL)
   ```
   **Ignore these — they are objdump display artifacts, not real diffs:**
   `jal 0 <SomeOtherFn>` (relocated call placeholder), and `j`/branch targets
   that differ only in absolute address but share the same `+0xNN` offset
   (the function sits at a different address in each object).
3. **Identify the residual** and apply the matching technique (catalog below).
4. **Rebuild & re-diff** until the function diffs to **zero** real lines, then
   confirm `100.00%` in the report.
5. **Commit** that one function. Message: what the residual was + the fix.
6. **Data-mat pass** (see below) if the now-100% function owns absolute-VA data.

Always work against `build/.../*.cpp.o` rebuilt with `tools/build.py --skip-asm`
and `expected/src/*.c.o` (the asm target). Regenerate the report after each fix.

## Technique catalog (symptom → fix)

These are ordered roughly easiest→hardest. Most near-misses are one of these.

| # | Symptom in the diff | Fix |
|---|---|---|
| 1 | original takes a global's **address** (`addiu rX,r,..` / `lui;addiu`) but recon **loads** it (`lw`) | the `extern` is mis-declared as a pointer; make it an **array**: `extern T **g;` → `extern T *g[];`. One fix often lifts every function that iterates it. |
| 2 | reloc symbol differs: original `D_xxxxxxxx`, recon `SomeStruct` + offset | the field is a **standalone symbol** in the binary. Declare `extern T D_xxxxxxxx;` and reference it directly (offset 0). objdiff compares reloc *names* — match the name `objdump -r expected/…o` shows. |
| 3 | original loads via a **separate base register** computed early (`lui v0,hi; lw a2,lo(v0)`); recon folds into the dest (`lui a2,hi; lw a2,lo(a2)`) | the global is a **table element**, not a scalar: `extern T g[]; … g[0]` (array access makes gcc compute a separate base). |
| 4 | a `sprintf`/call has **fewer args** than the original, or an inline string where the original references shared rodata | reconstruct the real call from the oracle: `extern char D_xxxx[]` for the format string, `extern T D_yyyy[]` for table-element args, e.g. `sprintf(buf, D_8005522C, D_80116470[0], obj.field)`. Drop spurious Ghidra extra buffers. |
| 5 | an unrolled `lw/sw` block copy with swapped registers, or a manual copy loop | it's a gcc **struct assignment**: `*(T*)dst = *(T*)src;` (define `struct T{int e[N];}`). gcc emits its canonical 16-byte-unrolled + tail block copy that matches. |
| 6 | `beqz`↔`bnez` / `beq`↔`bne` (branch inverted) | invert the `if/else` so the *jumped-to* case is the `else`. To match `beq`-on-`==X`, put the `==X` body in the `else`. |
| 7 | two calls collapsed into one with a conditional arg | write it as the explicit branch: `if (c) f(x); else f(y);` — gcc cross-jumps the two calls into one. (Ghidra's `if(x==0)x=0;` no-op gets folded away and loses the branch.) |
| 8 | commutative op operands swapped (`addu v0,a,b` vs `b,a`); a constant in the "wrong" callee-saved reg; loop counter/pointer in a shifted/swapped s-register | **regalloc/scheduling** — reorder source statements, give a loop its own counter variable, or materialize a value into a temp at a different point. Fiddly; try the permuter. |
| 9 | gcc strength-reduced a loop pointer to a `base+const` induction variable (orig keeps `base` + large offsets; recon walks `base+const`) | hardest class — gcc IV selection. No reliable source lever found yet; permuter often can't reach it either. |

### Notes that bite
- **Statement order ≠ instruction order**, but it nudges the scheduler. Moving an
  assignment a line up/down can place a `li`/`lui` in the matching slot
  (e.g. StartUp1 needed `iVar2=1` *between* two statements).
- **A `static const` that's really shared rodata** (address far outside this
  module, e.g. `0x8005xxxx` when the module is `0x80066xxx`) adds phantom rodata
  the original object doesn't have. Make it `extern`.
- **`bool`, `new`, `::`** in a kept function block the permuter (its pycparser
  can't parse them). Remove unused `bool` decls; `::` statics are fine if the
  function itself doesn't use them.

## The permuter

decomp-permuter grinds regalloc/scheduling residuals. Setup + run (see
`tools/PERMUTER.md`):
```sh
python tools/patch_permuter.py    # once: teaches it cfront (...) + enables -j N
python tools/permute.py setup <module.cpp> <MANGLED_SYM> <nonmatching.s>
python tools/run_permuter.py permuter_work/<MANGLED_SYM> -j 8 --stop-on-zero
```
- **It IS good at** pure instruction reordering / scheduling.
- **It CANNOT** flip within-statement register-allocation choices (which reg holds
  a reused constant, base-reg for a load). Those need a deterministic source-shape
  fix from the catalog. If it plateaus at a small non-zero score, stop and think.
- `-j N` = N local workers (fast); `-J` = permuter@home (distributed, NOT local).
- It can't run on functions containing C++ `new`.

## Data materialization pass

When a function reaches 100%, materialize the absolute-VA data **it owns** into
`recon/game/common/func_va_data.cpp` as real bytes (BSS globals = zero-init,
sized by type/next symbol; initialized data = bytes from the oracle / cross-check
the run-tree `C:\Temp\claud\reconstructed_headers\tree`). Data that lives in
**other** units (shared rodata, another module's globals) stays `extern` — it gets
materialized when its owning unit is reconstructed. This is additive (extern decl
stays in the header, the *definition* goes in func_va_data.cpp) and does not
change the objdiff %; it advances the self-contained-source goal.

## Build & report

```sh
python tools/build.py --out expected --no-link    # target objects (after asm changes)
python tools/build.py --skip-asm                   # base objects (after every C edit)
C:/Temp/objdiff/objdiff-cli.exe report generate -p . -o C:/Temp/rep.binpb -f json
```
Per-function percentages:
```sh
python -c "import json;d=json.load(open(r'C:/Temp/rep.binpb'))
[print(f'{f[\"fuzzy_match_percent\"]:6.2f}%  {f[\"name\"]}') for u in d['units'] if 'aiinit' in u['name'] for f in sorted(u['functions'],key=lambda x:x['fuzzy_match_percent'])]"
```
Use **Python 3.12** for splat/objdiff tooling. objdiff-cli is a Windows exe — no
`/tmp` paths (use `C:/Temp/...`).

## Status (update this when it moves)

- **aiinit unit: 50.00% — 12/17 functions @100%; overall decomp.dev 0.48%.**
- Matched: AI_TrafficCleanUp, AIInit_CleanUp1, AIInit_CleanUp2, AIInit_DeInitAICar,
  AIInit_DeInitAICar2, AIInit_InitAICar2, AIInit_LoadConfigs,
  AIInit_LoadPhysicsConfig, AIInit_Reset1, AIInit_StartUp1, AI_TrafficStartUp,
  AIInit_IsNonStandardCarFile.
- Near (committed partial): **InitAICar 98.95%** (gcc IV strength-reduction;
  blocked from permuter by C++ `new`), RestartAICar 93.8% (0x10000 const v0/v1),
  StartUp2 86% (live-range-split reg swap), Reset2 ~75% (loop reg-swap +
  leaderBoard must init from `Cars_gHumanRaceCarList[0]`/`Cars_gAIRaceCarList[0]`,
  not zeros), ClearAICar 58%.
- **The remaining tail is the hard class:** gcc register-allocation / IV-selection.
  Each needs a per-function deterministic insight; the permuter only narrows them.
