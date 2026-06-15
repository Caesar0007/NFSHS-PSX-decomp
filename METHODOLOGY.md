# Matching Methodology — read this FIRST

> If you are an agent resuming after a `/compact` (or a fresh session), **read
> this file before doing anything else.** It is the playbook for taking a
> function to a byte-perfect (100%) match. Then check `Status` below for where
> we are and what's next.

## The two hard rules

1. **Target = 100% byte-match only.** A function is "done" only at 100%. Don't
   stop at 99%; don't optimize the fuzzy %. Either it matches or it doesn't.
2. **The asm oracle is `C:\Temp\symdump-disasm\disasm-v4.txt`** (~348k lines).

### Backport rule (byte-perfect → run-tree)
When a function reaches **byte-perfect 100%** here, the match is *proof* of the original
behavior — backport the proven **correctness** to the NFS4-F run-tree
(`C:\Temp\claud\reconstructed_headers\tree`, `github.com/Caesar0007/NFSHSX.git`) and push.
- Backport **real value/logic bugs** the match exposed (e.g. Reset2 leaderBoard null→
  `Cars_gHumanRaceCarList[0]`; IsNonStandardCarFile `[48]=0`→`=src[48]`).
- Do NOT backport **behavior-identical** differences: matching aids (`new_var` alias),
  symbol-form swaps (`D_xxxx` vs `Struct.field`), `fixeddiv`/`rdiv` (alias in the tree),
  array-index vs pointer-walk, struct-assignment. Keep the tree's clean conventions.
- Always re-compile the touched TU under ccpsx 4.3 before pushing
  (`SN_PATH=PSYQ_PATH=C:/Temp/psq43/PSSN ccpsx -O2 -G4 -I C:/Temp/psq43/PSX43/psx/include -c`).

### Provenance rule (sourcing + matching aids)
- **Source each function BODY from the NFS4-F reconstruction tree**
  (`C:\Temp\claud\reconstructed_headers\tree\game\common\*.cpp`) — the authoritative
  reconstruction (correct field names, values, logic). Do NOT ship m2c raw-offset
  output or invented bodies; m2c is for cross-check only.
- **Matching-required adaptations are faithful** (same semantics, expressed for the
  reloc/branch): e.g. a standalone symbol `D_xxxx` for `Struct.field` at that address,
  or inverting an `if/else` to match branch direction.
- **Matching AIDS (permuter tricks) are NOT faithful source — MARK THEM.** An aliasing
  temp (`T *x = p;` used for one store), a no-op reorder, etc. produce byte-identical
  output but aren't how EA wrote it. Acceptable (standard matching-decomp practice) but
  must carry a `/* matching aid (permuter) */` comment so the source stays honest.
  (Example: AIInit_RestartAICar's `new_var` alias + copTopSpeed reorder.)
   It is the authority for instructions, symbol names, data references, XRefs and
   jump tables. It resolves data symbols (e.g. `Paths_Paths`, `AIPhysicConfig`,
   shared-rodata format strings) that the per-function `.s` files leave bare.
   When in doubt about what a function *does*, read it here.

## Reference project: silent-hill-decomp (same toolchain — techniques transfer)

[Vatuu/silent-hill-decomp](https://github.com/Vatuu/silent-hill-decomp) is the
canonical PSX matching decomp and uses a **near-identical toolchain** to ours, which
validates this playbook:
- Compiler **GCC 2.8.1** (we use 2.8.0) `cc1`, assembler **ASPSX 2.77** via **maspsx**
  + GNU `as` — same as ours.
- Their full cc1 invocation (for reference; we verified the extra flags are **no-ops**
  for our objects — PsyQ cc1 already defaults to them, so our `-O2 -G4` matches):
  `-O2 -G8 -mips1 -mcpu=3000 -funsigned-char -fpeephole -ffunction-cse
  -fpcc-struct-return -fcommon -msoft-float -mgas -fgnu-linker -quiet`. Keep
  `-msoft-float`/`-funsigned-char` in mind if a future module does floats or signed-char
  comparisons.
- They lean **heavily on decomp-permuter** (we have it working — `tools/PERMUTER.md`).
  Useful randomization passes their config enables and that we should exploit:
  `perm_temp_for_expr`, `perm_reorder_stmts`, `perm_refer_to_var`,
  `perm_duplicate_assignment`, `perm_chain_assignment`, `perm_split_assignment`,
  `perm_commutative`. These are the "register/scheduling nudge" passes.
- Their flow is **decomp.me + m2c context** (`tools/m2ctx.py`) then permuter; func
  quality via `func_rater.py`. Our equivalent: objdiff per-function diff + the oracle.

**Takeaway:** when stuck on a residual that's pure register-allocation/coalescing
(not structure), it IS the compiler — match a known idiom or grind the permuter; don't
invent non-original source. SH confirms there's no magic flag; it's source shape + permuter.

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

- **aiinit unit: 17/17 functions @100% — UNIT COMPLETE; overall decomp.dev 0.664%.**
- **AIInit_RestartAICar — DONE (100%)** via the permuter (see "permuter win" below).
- Prior remaining-1 notes (kept for the technique record):
  - **RestartAICar 97.30%** — register coalescing CRACKED (was 94.32%); lone residual
    is a single gcc scheduler tie-break. Two fixes got here:
    1. **VALUE BUG**: `damageMult`(+1912) is `0x10000` (default 1.0), not `iVar1`.
    2. **Coalescing idiom**: the early-cluster `0x10000` must coalesce into `v1`
       (reusing the dead iVar1). The winning idiom is **reuse `iVar1` for the EARLY
       cluster ONLY** (`iVar1 = 0x10000;` then use iVar1 for the 4 early fields),
       keeping the late fields (gripFactor/damageMult) as **literal** `0x10000` so
       they re-materialize separately into `v0`. Reusing iVar1 for ALL fields makes
       its range too long → `a1`; a fresh var gets CSE'd into one `v0`. Early-only
       reuse = the sweet spot (matches the original's live-range split exactly).
    - Lone residual: `li a1,1` (const 1, shared by driveDirection + forceNoSimOptz)
      is scheduled AFTER the direction stores; the original emits it BEFORE.
      **Mechanism (fully traced):** the iVar1-reuse creates a WAR anti-dependence
      (the `lui` reuses iVar1's pseudo → the direction stores feed lui → feed the
      0x10000 cluster), giving the direction stores a long critical path and higher
      scheduler priority than the const-1, so `li a1,1` sinks. The literal-0x10000
      version had `a1=1` placed CORRECTLY (separate pseudo → no anti-dep) but 0x10000
      in v0. **Catch-22:** reuse → 0x10000 in v1 ✓ but a1=1 reordered; separate pseudo
      → a1=1 ✓ but 0x10000 in v0. The original has BOTH (a separate-pseudo-coalesced-
      to-v1 with no anti-dep) — needs a coalescing affinity I haven't expressed in C.
    - **NOT a compiler-version issue (definitively):** psq43=gcc 2.8.0, psq44=gcc
      2.8.1, psq45 — ALL SN PsyQ builds produce the identical a1=1-after-lui output
      for this source (tested on the same preprocessed .i). EA used SN PsyQ, so the
      version is excluded; the difference is a subtle source structure. Also ruled
      out: flags (-mcpu/-fpeephole/-g1/-mgpOPT no-ops), source reorder (breaks store
      order), permuter (5300+ iters stuck), scheduler-pass toggles (both required).
      Functionally 100%, byte-identical bar one instruction's position.
    - **Compiler-bank note:** SN PsyQ cc1/cc1plus by version live at
      `C:/Temp/psq43` (2.8.0 — **EA's confirmed compiler**), `C:/Temp/psq44` (2.8.1),
      `C:/Temp/psq45`; the decompals old-gcc 2.8.1 (Linux) is at
      `C:/Temp/silent-hill-decomp/tools/gcc-2.8.1-psx` (needs WSL distro to run).
    - **ASPSX also ruled out:** ran the REAL `C:/Temp/psq43/PSSN/ASPSX.EXE` (v2.77)
      on cc1's raw `.s` — it emits the identical `li $5,1`-after-lui order (extracted
      the merge-block byte offsets from the SN `.obj` since DUMPOBJ is 16-bit DOS).
      maspsx is byte-faithful to ASPSX here. C-vs-C++ (cc1 vs cc1plus): identical too.
    - **Full register picture (traced from oracle):** original = early-cluster
      `0x10000` in **v1**, late-cluster (gripFactor/damageMult) in **v0** — TWO
      separate materializations; the early pseudo is coalesced into the dead iVar1's
      v1 with NO anti-dep. My literal CSEs both clusters into one v0 pseudo; my reuse
      puts the early in v1 but via iVar1's pseudo (→ the anti-dep). The original needs
      a *separate* early pseudo that the allocator colors v1 (not the preferred v0) —
      a graph-coloring outcome not expressible from C source. THE irreducible case.

### ⭐⭐ The permuter win (RestartAICar — the "irreducible" case, cracked)
After exhaustively proving the residual wasn't toolchain (psq43 cc1plus 2.8.0 +
ASPSX 2.77 = EA's exact tools), the **permuter cracked it in 15 iterations** — but
ONLY when seeded from the RIGHT base. Lesson: **seed the permuter from the base whose
residual is SMALLEST/closest, not the one that's "more correct."**
- The iVar1-reuse base (0x10000→v1 but li-a1,1 reordered by the anti-dep) plateaus at
  score 60 forever — the permuter can't undo the anti-dep.
- The **literal-0x10000 base** (li a1,1 already first; only 0x10000 in v0) → permuter
  found score 0 almost instantly. Winning mutation: introduce `T *new_var = carObj;`
  and route ONE store through it (`new_var->originalDesiredSpeed = 0;`) + reorder
  copTopSpeed before copAccMult. The alias pointer shifts gcc's aliasing/allocation so
  the early 0x10000 colors into v1 (no anti-dep) AND li a1,1 stays first — a structure
  hand-written source can't reach. **TECHNIQUE: when stuck on a regalloc/coloring
  residual, try the permuter from MULTIPLE seed bases; an aliasing temp (`T* x=p;` used
  for one field) is a coloring lever the catalog didn't have.**

### ⭐ Levers that cracked the loop/IV functions this round
- **InitAICar (IV-anchor) — array-index the per-iteration accesses, separate-offset
  the delta.** `carObj->topSpeeds[i]` / `invTopSpeeds[i]` lets gcc factor `carObj+4i`
  into one giv anchored at 0 (accessed +1432/+1460). Compute the `i-1` delta via a
  SEPARATE byte-offset var (`carObj+iVar6`, not `[i-1]`) so the counter stays low-use
  and lands in s1 (base giv s0). Last nit: emit `gearLoop=0` before `iVar6=-4` by
  putting both in the for-init: `for (gearLoop=0, iVar6=-4; ...)`.
- **VALUE BUGS hide as "register coloring."** A field assigned the wrong source
  value (`damageMult=iVar1` vs `0x10000`) shows up in objdiff as a reg mismatch AND
  silently extends a variable's live range, corrupting downstream allocation. When a
  store's source register is "wrong," check the VALUE against the oracle first.

### ⭐ THE big lever this round — array-indexing for loops (cracked Reset2 + StartUp2)
A loop that array-indexes a global table is NOT the same to gcc as one that walks an
explicit pointer:
```c
for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++)
    AIScript_Startup(&Cars_gList[carLoop]->script);   // gcc strength-reduces the address
```
- gcc creates its OWN pointer induction variable (→ gets the higher s-register, e.g. s1)
  and keeps the int counter as a biv (→ s0), and schedules `carLoop=0` into the guard's
  `blez` delay slot. An explicit `ppCVar = Cars_gList; *ppCVar++` pointer-walk is
  allocated by use-order and matches neither the registers nor the delay-slot fill.
- This fixed BOTH loops in Reset2 and StartUp2 in one shot (registers, loop-2 top-test
  rotation, delay slot) — after a separate fix: declaring the touched globals as
  **arrays** and indexing `[0]` (technique #3) to get the original's separate-base-reg
  loads/coloring (this also cracked Reset2's leaderBoard temp coloring).
- **Caveat (InitAICar):** when the loop body also needs the *base* in a low register
  (s0) AND a 0-anchor, array-indexing vs explicit-pointer pull in opposite directions
  and you can be stuck — that's the gcc IV-anchor wall.

- **Other key lever (loops):** if you DO keep an explicit counter+pointer, init the
  *pointer* before the counter to get counter=s0/pointer=s1; inner-scope `int carLoop;`
  matches the oracle's named-local. But array-indexing is usually the cleaner win.
- **Low-% functions are usually STRUCTURAL (fully fixable) — prefer them** (ClearAICar
  58→100 via one struct-assignment #5; the array-index insight is the loop analog).
