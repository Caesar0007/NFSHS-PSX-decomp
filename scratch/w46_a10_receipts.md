# WAVE-46 a10 — GCC LANE ROUND 2 — REQUIRED-DELTA RECEIPTS

**Status: LIVE (stub committed early — poll this path).**
Consumers: a1 (DrawGouraudShape / FontUpsideDownBlit), a2 (hce arm-0 find_reg preference),
a3 (PrimMenu qty table), a5 (BuildNumbers pSprt / Wingman / BuildTach), a9 (CreateLicense
PRECOMPUTE_REGISTER_PARAMETERS).

Predecessor receipts (READ THEM FIRST, still fully valid): `scratch/w45_a10_receipts.md`
— §0 allocsim model, §1 DrawGouraudShape delta, §2 hce delta, §3 Font all-local proof
(`QTY_CMP_PRI == allocno_compare`), §4 DrawQuad, §5 BuildNumbers, §6 how-to-run, §7 cc1 build recipe.

---

## STATUS BOARD (updated live)

| deliverable | state |
|---|---|
| 1. instrumented cc1 rebuild (+ committed patches/script) | ✅ **DONE** — `scratch/gccbuild/cc1.exe` (ELF) + `scratch/gccbuild-ecoff/cc1.exe`; patches = `scratch/instr/apply_traces.py`, build = `scratch/instr/build_cc1.sh` (both committed) |
| 2. ECOFF reconfigure | ✅ **DONE — hypothesis REFUTED, but the lane got the win anyway: 19/20 identical to CC1PSX (was 6/17). See §1+2.** |
| 3. local-alloc QTY-identity replica | ✅ see §3 |
| 4. calls.c PRECOMPUTE trigger (a9) | ✅ see §4 |
| 5. new trace points (find_free_reg, qty_combine, reload re-homes) | ✅ see §5 |
| 6. on-demand receipts (a1/a2/a3/a5) | OPEN — post requests, they get served here |

---

# 🏆🏆 §1+2 — THE INSTRUMENTED cc1 IS NOW A **NEAR-ORACLE**, NOT A LABORATORY
### and the ECOFF hypothesis is REFUTED — the real gap was TWO MISSING FLAGS

**Headline: `19 / 20` functions BYTE-IDENTICAL to the real PsyQ `CC1PSX.EXE` on
`memcard.i` (w45 measured 6 / 17 and blamed the ELF-vs-ECOFF config).**

| config | flags | identical / 20 |
|---|---|---|
| ELF, w45 flags | `-O2 -G4` | 2 |
| **ECOFF**, w45 flags | `-O2 -G4` | **2** ← ECOFF changed NOTHING |
| ELF | `-O2 -G4 -mgas -msplit-addresses` | 18 |
| ECOFF | `-O2 -G4 -mgas -msplit-addresses` | **18** ← still identical to ELF |
| ECOFF | `+ -funsigned-char` | **19** |

## 🔴 THE FLAGS (this is the whole finding — write them into every future probe)
```
cc1.exe -quiet -O2 -G4 -mgas -msplit-addresses -funsigned-char <tu>.i -o <tu>.s
```
* **`-mgas -msplit-addresses` MUST BE PASSED AS A PAIR.** `config/mips/mips.c:3696`:
  `mips_split_addresses = 1` only if `TARGET_GAS && TARGET_SPLIT_ADDRESSES && optimize
  && !flag_pic`. `-msplit-addresses` **alone silently does nothing** (measured). Without
  the pair, every symbol address comes out as the unsplittable `la $r,sym` assembler
  macro instead of retail's `lui %hi / addiu %lo` pair — which is *the same
  scalar-vs-view schedulability property the w44 storage-shape menu is about*, so it
  poisoned EVERY function with a global reference. **This one flag pair accounts for
  16 of the 17 previously-"divergent" functions.**
* **`-funsigned-char`**: PsyQ's cc1 defines `__CHAR_UNSIGNED__` (methodology gotcha
  #11); ours defaults signed → `lb` where retail has `lbu` (`iMCRD_LoadCard`, 1 diff).
* ECOFF vs ELF: **byte-identical instruction streams on all 20 functions.** The
  ELF/ECOFF difference is confined to `.def/.scl/.type` debug directives and
  `.set nobopt`, which are not codegen. ⇒ **the w45 "reconfigure to ECOFF and most of
  the 11 differing functions close" hypothesis is FALSIFIED.** Both builds are kept
  (`scratch/gccbuild/` = ELF, `scratch/gccbuild-ecoff/` = ECOFF); use either.

## The ONE remaining C-lane divergence
`iMCRD_DoFileLoad` (170 vs 171 insns): retail keeps a value in `$s7` and never
allocates `$fp`; ours parks it in `$fp`, saves `$fp` **and** shifts the whole
constant-hoist set. A genuine allocator/RTL divergence in a high-pressure function —
**not** a config difference. 1/20 = **95 % fidelity for the C lane.**

## WHAT THIS UNLOCKS (read this, a2/a9 especially)
The instrumented cc1 can now be pointed at a REAL recon `.i` and its
`[qty_order] / [find_free_reg] / [allocno_compare] / [find_reg] / [caller-save] /
[qty_combine] / [reload-rehome]` traces describe **the same compilation the gate
measures** — for any function it reproduces byte-exactly. So a trace is a RECEIPT for
those functions, not just a mechanism illustration. For a function where it does NOT
reproduce retail (check first!), fall back to `allocsim` on the real dumps.

### RUN IT
```bash
cd scratch/instr
export TMPDIR='C:\Temp\nfs4-wt46-a10\scratch\instr\tmp\'   # ⚠ trailing BACKSLASH
export TMP=$TMPDIR TEMP=$TMPDIR                            # ⚠ or dumps come out EMPTY
mkdir -p mine && cp <the .i> mine/            # ⚠ cc1 names dumps after the INPUT path
GCC_TRACE_ALLOC=1 ../gccbuild-ecoff/cc1.exe -quiet -O2 -G4 \
    -mgas -msplit-addresses -funsigned-char mine/<tu>.i -o mine/<tu>.s 2> trace.txt
```
Then **verify fidelity first**: `sh cmp_cc1.sh <the .i> <Gvalue>` prints per-function
SAME/dN vs the real CC1PSX. Only trust traces for `SAME` functions.

### REBUILD FROM SCRATCH (both configs, ~6 min each)
```bash
sh scratch/instr/build_cc1.sh elf
sh scratch/instr/build_cc1.sh ecoff
# then, for the C++ lane, from the build dir:
mingw32-make CC="gcc -std=gnu89 -w" CFLAGS="-O1 -w -std=gnu89" LANGUAGES="c c++" cc1plus
```
`scratch/instr/apply_traces.py` applies every source patch (idempotent, keeps
`*.orig`); `build_cc1.sh` does extract → patch → configure → make.

### 🔴 GOTCHAS THIS ROUND PAID FOR (added to the scripts' headers)
1. **`extern char *getenv ();` is MANDATORY in every patched file.** The host gcc is
   `x86_64-w64-mingw32`, so cc1.exe is a **64-bit** binary; K&R implicit declaration
   makes `getenv` return `int`, **truncating the pointer** → the very first `*e`
   segfaults. Cost: one full build cycle.
2. **configure MUST be invoked through a RELATIVE path** (`../gccsrc/gcc-2.8.1/configure`).
   An absolute msys path is baked in as `srcdir` and native `mingw32-make` then dies
   with `No rule to make target '/c/Temp/.../Makefile.in'`.
3. (carried from w45, all still true) `CC="gcc -std=gnu89 -w"`; the obstack.h
   cast-as-lvalue rewrite; TMPDIR/TMP/TEMP as Windows paths **with a trailing
   backslash**; a new `static` helper needs a `PROTO` forward decl above its first
   USE; **copy the `.i` per probe** or you clobber a shared TU's `.greg`/`.lreg`.

## §5 — NEW TRACE POINTS (all live, all verified firing)
| trace | source site | what it answers |
|---|---|---|
| `[qty_sugg_order]` | local-alloc.c, before the *suggested*-register pass | group-1 order (`qty_sugg_compare`: fewest copy-suggestions first, then `QTY_CMP_PRI`) |
| `[qty_order     ]` | local-alloc.c, before the priority pass | group-2 order (pure `QTY_CMP_PRI`) — **the block-local qty table a1/a3/a5 want** |
| **`[find_free_reg]`** 🆕 | `find_free_reg`, before the numeric scan | for each register IN THE CLASS that is unavailable over this qty's `[born,dead)` window: **which one and WHY** — `live` / `fixed` / `callused` / `callfixed` / `notsugg` |
| `[find_free_reg] -> reg` | at `post_mark_life` | the register handed out |
| **`[qty_combine]`** 🆕 | `combine_regs`, at the merge | `pseudo S (refs r calls c) merged into qty Q of pseudo U -> qty refs R calls C` — **the qty-formation ground truth** |
| `[qty_sugg]` 🆕 | `combine_regs` hard-reg path | which hard reg a qty copy-suggests |
| `[allocno_compare]` | global.c after `qsort` | global allocno order + refs/live/calls/size/pri |
| `[find_reg]` | global.c | per-allocno entry state + the register won |
| `[caller-save]` | global.c | `CALLER_SAVE_PROFITABLE` retry firing |
| **`[reload-rehome]`** 🆕 | reload1.c ×3 | `retry_global_alloc` **and the two SILENT inheritance re-homes** (`reg_renumber[REGNO(old)] = REGNO(reload_reg_rtx[j])` at the two `special`/inheritance sites) — allocsim's only unexplained residual class, now observable |

Sample (real output):
```
[qty_order     ] (qty/reg1:refs/life/calls/sg/csg=pri): 0/92:4/2/0/0/0=40000 ...
[find_free_reg]    qty 0 reg1 92 class 1 calls 0 acc 0 sugg 0 win [4,6) blocked: 0(fixed) 1(fixed) 26(fixed) 27(fixed) 28(fixed) 29(live) 30(live) 31(fixed)
[find_free_reg]    qty 0 -> reg 2
[allocno_compare]  order (allocno/pseudo:refs/live/calls/size=pri): 4/93:4/3/0/1=26666 5/102:9/11/0/1=24545 ...
[find_reg]         allocno 4 pseudo 93 refs 4 live 3 calls 0 size 1 alt 0 ccl 0 retry 0 -> reg 65
```

---

# 🏆 §4 — THE "PRECOMPUTE REGISTER PARAMETERS" TRIGGER, SOLVED FROM SOURCE  (for **a9**, CreateLicense lane)

Read directly out of `gcc-2.8.1/calls.c` `expand_call` (+ `cse.c rtx_cost`,
`config/mips/mips.h RTX_COSTS/CONST_COSTS`, `stmt.c preserve_subexpressions_p`,
`toplev.c` -O2 flag block, `regs.h`). Line numbers are the pristine 2.8.1 tarball.

## 4.1 There is no `PRECOMPUTE_REGISTER_PARAMETERS` **macro** in gcc-2.8
That macro name is from a later gcc. In 2.8 the behaviour is a hard-coded loop in
`expand_call`, commented *"Precompute all register parameters. It isn't safe to compute
anything once we have started filling any specific hard regs."* (**calls.c:1631**).

## 4.2 The exact emission ORDER inside `expand_call` (this is the shape a9 is looking at)
| step | calls.c | what lands in the insn stream |
|---|---|---|
| 1 | 1634-1677 | **PRECOMPUTE**: for every arg with `args[i].reg != 0 && !pass_on_stack`, `expand_expr` its value **now** — possibly into a fresh PSEUDO (see 4.3) |
| 2 | 1749-1751 | **STACK ARGS**: `store_one_arg` for every `args[i].reg == 0 \|\| pass_on_stack` — *"These come before register parms, since they can require block-moves, which could clobber the registers used for register parms."* |
| 3 | 1826-1828 | partially-in-register parms |
| 4 | 1869 | `prepare_call_address` |
| 5 | 1878-1907 | **HARD-REG LOADS**: `emit_move_insn (args[i].reg, args[i].value)` — one `(set (reg $aN) …)` per reg arg, immediately before… |
| 6 | after | `emit_call_1` → the `CALL_INSN` |

⇒ **the RTL always has the four `(set (reg $aN) …)` adjacent to the CALL_INSN.**
Retail's "arg setup 18 insns early with work interleaved" is therefore **NOT** an
alternative emission order — it is step 1 having produced pseudos that the ALLOCATOR
later colored to `$a0..$a3`, which turns each step-5 `(set (reg a0) (reg P))` into a
**self-move that gets deleted**. The visible early setup is the pseudo's *definition*;
the interleaved work is step 2's stack-arg stores (`sw …,16(sp)` / `20(sp)`).
This is why scheduling can never reach it (SCHED_GROUP_P chains step 5 to the call):
**you have to move the work into step 1, not move step 5 earlier.**

## 4.3 THE TRIGGER CONDITION (calls.c:1668-1677, verbatim)
```c
if ((! (GET_CODE (args[i].value) == REG
        || (GET_CODE (args[i].value) == SUBREG
            && GET_CODE (SUBREG_REG (args[i].value)) == REG)))
    && args[i].mode != BLKmode
    && rtx_cost (args[i].value, SET) > 2
    && ((SMALL_REGISTER_CLASSES && reg_parm_seen)
        || preserve_subexpressions_p ()))
  args[i].value = copy_to_mode_reg (args[i].mode, args[i].value);
```
Conjunct by conjunct, **for OUR build (mipsel, -O2 -G4)**:

| conjunct | evaluates to | why |
|---|---|---|
| `SMALL_REGISTER_CLASSES && reg_parm_seen` | **always FALSE** | MIPS never defines `SMALL_REGISTER_CLASSES`; `regs.h:32-33` defaults it to **0** |
| `preserve_subexpressions_p ()` | **always TRUE** | `stmt.c:2537` returns 1 immediately if `flag_expensive_optimizations`, and `toplev.c:3809` sets it under `optimize >= 2` |
| `args[i].mode != BLKmode` | true unless the arg is a by-value struct | |
| value is not already REG/SUBREG-of-REG | **the first gate** | a bare local variable is already a pseudo ⇒ **never precomputed** |
| `rtx_cost (value, SET) > 2` | **THE DIAL** | see 4.4 |

### ⇒ On MIPS at -O2 the whole condition collapses to:
> **an argument is precomputed into its own pseudo iff its rtl is NOT already a register
> and `rtx_cost(rtl, SET) > 2`.**

## 4.4 The cost table (this is the actionable part)
`cse.c:711` `#define COSTS_N_INSNS(N) ((N) * 4 - 2)` ⇒ **COSTS_N_INSNS(1) = 2**,
COSTS_N_INSNS(2) = **6**. The threshold `> 2` therefore means literally
**"costs more than one instruction"**.

| argument written as | rtx | cost | precomputed? |
|---|---|---|---|
| a bare local / a call result | `REG` | — | **NO** (fails conjunct 1) |
| an integer constant | `CONST_INT` | **0** (mips.h:2897 *"Always return 0"*) | **NO** → `li $aN,K` hugs the jal |
| `p->field`, `arr[i]` off a pseudo base, small offset | `(mem (plus (reg) (const_int)))` = **`simple_memory_operand`** | `COSTS_N_INSNS(1)` = **2** | **NO** → `lw $aN,off(p)` hugs the jal |
| a **global/symbolic** load `G.field`, `SYM[0]` (`%hi/%lo`) | MEM, **not** simple_memory_operand | `COSTS_N_INSNS(2)` = **6** | ✅ **YES** |
| any arithmetic: `a+b`, `x<<2`, `a*b`, `x/y`, `&local + i` | PLUS/MULT/DIV… default `total = 2` **plus** operand costs | **> 2** | ✅ **YES** |
| `&global` / a `CONST` sum with a SYMBOL_REF | mips.h:2906 `CONST` | ≥ COSTS_N_INSNS(2)=6 | ✅ **YES** |
| multiply by non-power-of-2 | `MULT` | `COSTS_N_INSNS(5)` = 18 | ✅ **YES** |
| divide/mod | `DIV/MOD` | `COSTS_N_INSNS(7)` = 26 | ✅ **YES** |
| a doubleword / BLKmode struct | — | — | **NO** (conjunct 2) |

(`simple_memory_operand` is mips.c's "register + small constant offset, or an
already-legitimized small-data address" predicate; a `lui %hi(sym)`-based address is
NOT simple, which is why symbolic loads jump to cost 6.)

## 4.5 SOURCE-SIDE LEVER HYPOTHESIS FOR a9 (CreateLicense)
**To move an argument's computation EARLY (retail's shape):** make that argument
expression cost > 2 while keeping it a non-REG rtx at expand time.
Zero-instruction ways, in order of preference:
1. **Read the value through a SYMBOLIC address instead of a pointer+offset** — the
   storage-shape menu (catalog w44 §E) already gives you this: the unsized `_v[]`
   view / `extern T SYM[]; SYM[0]` form makes the MEM non-simple → cost 2 → **6**.
   ⚠️ the *scalar `_d` macro* form is the OPPOSITE lever here.
2. **Pass a small arithmetic expression** rather than a bare variable —
   `f(x + base)`, `f(n << 2)`, `f(&buf[i])`. Any binary op clears the bar.
3. **Do NOT hoist the value into a named local first.** `int t = G.f; f(t);` makes the
   arg a plain REG ⇒ **conjunct 1 fails ⇒ never precomputed**, and the load hugs the
   jal. This is the single most common way a recon accidentally kills the shape —
   *check CreateLicense's args for exactly this.*
4. Note the CONVERSE: an argument that ours precomputes but retail loads AT the call
   is fixed by making it cheap — bare local, `p->field` off a pseudo base, or a
   constant.

**Second-order (needed for the "18 insns" gap, not for the trigger):** being
precomputed only *permits* the early position; the pseudo must then WIN `$aN` so the
step-5 copy dies. That is a plain allocno/qty ranking question — `$a0`(4)…`$a3`(7) are
the first four caller-saved regs in the numeric handout, so a call-crossing-free
pseudo with high priority takes them naturally. If a9 gets the precompute and still
sees `move $a0,$vN`, **that residual is an allocsim question, not a calls.c one** —
post the fn + dumps here and I'll run `reqdelta`.

**Falsifiable prediction for a9:** count CreateLicense's four register args. Every one
whose retail setup sits early must, in the retail source, have been either a symbolic
global read or an arithmetic expression *written inline in the call*. Any arg whose
setup hugs retail's `jal` was a bare local, a `p->field`, or a constant.

---

## HOW TO REQUEST A RECEIPT
Post (in your report / or just rely on this file): the FN NAME, the TU, and the wanted
register assignment (`--want "pN=tM"` form or "retail puts X in $a0, ours puts Y").
If your worktree has the `-dg`/`-dl` dumps already, say where; otherwise I generate them.

## HOW TO RUN THE INSTRUMENT YOURSELF (unchanged from w45 §6)
```bash
python tools/rtl_dump.py   <cpp>  -dg -dl      # C++ lane  -> scratch/rtl/
python tools/rtl_dump_c.py <c>    -dg -dl      # C lane
python tools/allocsim.py <greg> <lreg> "<fn-signature>"
python tools/reqdelta.py <greg> <lreg> "<fn>" --want "p82=t2,p166=t3"
python tools/allocsim.py <greg> <lreg> "<fn>" --what-if 90:refs=7
python tools/pseudoid.py <lreg> "<fn>" 90 82 166
```
