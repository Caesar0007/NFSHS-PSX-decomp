# WAVE-48 agent a8 — syslib math/gte/libc/libpress/libds/libcard receipts

Worktree `C:/Temp/nfs4-wt48-a8`, branch `w48-a8`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root (sole authority).
Helpers committed here: `scratch/w48_a8_gate.py` (whole-TU gate from the MATCH_PROGRESS fn list),
`scratch/w48_a8_probe.py` (per-TU flag probe, patch-in-place + `finally` restore),
`scratch/w48_a8_dstest.c` (cc1 declaration-shape × flag matrix),
`scratch/w48_a8_aspsx_t1.s|w48_a8_t2.s|w48_a8_t3.s|w48_a8_t4.s` (real-ASPSX differential inputs).

**HEADLINE: +3 gate PASS (`_patch_gte_handler_1`, `MDEC_status`, `DsReadyCallback`*), −70 diffs on
landed source, one CATALOG FLOOR CLASS FALSIFIED against the real ASPSX, and the wave's
`-fno-delayed-branch` prior falsified for the whole math/gte/libc band.**
(*`DsReadyCallback` PASSes with the probe-measured per-TU flags below — build.py is report-only for
me, so the flag entry is handed to the consolidator; the source shape it needs is LANDED.)

---

## 0. RE-GATED BASELINES → FINAL (all 37 scope fns + every sibling in their TUs)

The worklist fuzzy% was wrong on essentially every row again (`_patch_gte_handler_1` "0.00%" was
actually **NOT IN OBJECT**; `memmove` "97.78%" is a 2-diff count-exact tie; `RotMatrix` "24.62%" is
a 261-diff far-miss). Everything below is a gate number, measured on this tree.

| unit | fn | baseline | FINAL | note |
|---|---|---|---|---|
| libgte/PATCHGTE | `_patch_gte_handler_1` | **NOT IN OBJECT** | **PASS (12/12)** | §2 |
| libpress/LIBPRESS | `MDEC_status` | 2 (31/31) | **PASS (31/31)** | §3 |
| libds/DSCB | `DsReadyCallback` | 9 (6/5) | **PASS (5/5)** w/ flags | §1 |
| libmath/FLTSIDF | `__floatsidf` | 50 (64/64) | **8 (64/64)** | §4 |
| libpress/LIBPRESS | `DecDCTinSync` | 6 (15/15) | **4 (15/15)** | §3 |
| libds/DSCB | `DsDataCallback` | 6 (9/9) | **4 (9/9)** w/ flags | §1 |
| libmath/LTDF2 | `__ltdf2` | 39 (54/55) | 39 | |
| libmath/GTDF2 | `__gtdf2` | 54 (55/53) | 54 | |
| libmath/MULSF3 | `__mulsf3` | 94 (76/80) | 94 | |
| libmath/FIXSFSI | `__fixsfsi` | 12 (43/45) | 12 | |
| libmath/EXTSFDF2 | `__extendsfdf2` | 69 (86/87) | 69 | §5 lead |
| libmath/TRUDFSF2 | `__truncdfsf2` | 109 (71/76) | 109 | §5 lead |
| libmath/ADDDF3 | `__adddf3` | 377 (230/221) | 377 | §5 lead |
| libmath/DIVDF3 | `__divdf3` | 305 (171/184) | 305 | §5 lead |
| libmath/FLTSISF | `__floatsisf` | 38 (43/45) | 38 | |
| libmath/MULDF3 | `__muldf3` | 326 (189/197) | 326 | §5 lead |
| libmath/MULDF3 | `_mul_mant_d` | 95 (66/59) | 95 | §5 lead |
| libmath/DIVSF3 | `__divsf3` | 107 (78/81) | 107 | |
| libmath/FIXDFSI | `__fixdfsi` | 80 (57/63) | 80 | |
| libmath/FERR | `_err_math` | 2 (25/25) | 2 | §6 |
| libgte/COR_01 | `csincos` | 76 (73/71) | 76 | |
| libgte/COR_02 | `ccos` | 12 (43/49) | 12 | |
| libgte/COR_03 | `csin` | 85 (59/78) | 85 | |
| libgte/FGO_01 | `RotMatrix` | 261 (146/163) | 261 | |
| libgte/FGO_06 | `RotMatrixZ` | 166 (90/102) | 166 | |
| libgte/FOG_01 | `SetFogNear` | 4 (25/25) | 4 | §6 |
| libc/SPRINTF | `sprintf` | 174 (547/545) | 174 | |
| libc/QSORT | `qsort` | 70 (84/84) | 70 | |
| libc/MEMMOVE | `memmove` | 2 (27/27) | 2 | §6 |
| libc/MEMCMP | `memcmp` | 6 (17/19) | 6 | §6 |
| libc/BSEARCH | `bsearch` | 26 (48/48) | 26 | |
| libcard/CARDINIT | `StartCARD` | 4 (14/14) | 4 | §6 |
| libpress/LIBPRESS | `DecDCTin` | 4 (31/31) | 4 | §6 |
| libpress/LIBPRESS | `DecDCToutCallback` | 6 (9/9) | 6 | §6 |
| libpress/LIBPRESS | `MDEC_rest` | 28 (62/60) | 28 | |
| libpress/LIBPRESS | `MDEC_in_sync` | 18 (37/37) | 18 | |
| libpress/LIBPRESS | `MDEC_out_sync` | 18 (37/37) | 18 | |

**ZERO REGRESSIONS**: every sibling that was PASSing still PASSes (`_comp_mant`, `_swap`,
`StopCARD`, `_patch_gte`, `DecDCTReset`, `DecDCTout`, `_MDEC_in_dma`, `_MDEC_out_dma`,
`_MDEC_get_reg1`), re-gated on the final tree.

---

## 1. 🏆🏆 THE "aspsx SHARES ONE `la` BASE" FLOOR CLASS IS **FALSIFIED** — it is a COMPILER axis

### 1a. What the catalog says (and what it is used for)
Catalog §I-addendum, *SCOPE REFINEMENT* (w30), quoted verbatim for **`MemCardCallback` /
`DsReadyCallback` / the libmcrd `funcEvSp*` ×8 class**: *"GNU-as expands each access independently
… while **aspsx-2.77 shares ONE `la` base across consecutive same-symbol accesses** → `lui v1; addiu
v1; lw v0,0(v1); sw a0,0(v1)`. So a 2-access (read+write) absolute global is an assembler-expansion
floor … RULE: a read+write pair = leave it."*

### 1b. Real-ASPSX differential run (04C law), my own instrument
`C:/Temp/psq43/PSSN/ASPSX.EXE` (v2.77). **Input must be CRLF** — an LF file dies with
`Error : Illegal character '\n' (10) in input` (worth putting in the wave brief).
Input = exactly what cc1 emits for the plain scalar; object decoded by hand
(`scratch/w48_a8_t2.s`, symbol in an explicit `.bss` so it is not small-data):

```
        lw   $2,ds_ready_cb        ->   3c020000  lui  $2,%hi
        sw   $4,ds_ready_cb             8c420000  lw   $2,%lo($2)      <- dest-as-scratch
        j    $31                        3c010000  lui  $at,%hi        <- SEPARATE expansion
                                        ac240000  sw   $4,%lo($at)    <- $at, not a shared base
                                        03e00008  jr   $ra
                                        00000000  nop
```

⇒ **real ASPSX 2.77 expands each same-symbol access INDEPENDENTLY, byte-for-byte the same shape as
GNU-as/maspsx. It does NOT share an `la` base.** The catalog row's premise is dead; the whole
"read+write absolute global = assembler floor" class must be RE-OPENED.

### 1c. Where the oracle's shape actually comes from (cc1 matrix)
`scratch/w48_a8_dstest.c` — 7 declaration shapes × 4 flag settings through the real CC1PSX:

| source shape | `-G4` | `-G0` | `-G4 -mno-split-addresses` | `-G0 -mno-split-addresses` |
|---|---|---|---|---|
| plain scalar `G` (`G;G=…`) | macro `lw $2,G` | `lui;lw %lo` | macro | macro |
| **pointer local `T *p=&G`** | macro | `lui;lw %lo` | macro | **`la $3,G; lw 0($3); sw 0($3)`** |
| unsized view `G_v[]` + `[0]` | `lui;lw %lo` | `lui;lw %lo` | **`la $3,G; …0($3)`** | **`la …`** |
| sized `[1]` view | macro | `lui;lw %lo` | macro | **`la …`** |
| volatile scalar | macro | `lui;lw %lo` | macro | macro |

The oracle wants the **`la` form** = `(set reg (lo_sum (high sym) sym))` surviving as a REGISTER
VALUE. TWO conditions, both required:
1. the address must be written as a real **pointer local** (or an array-decay view) — otherwise the
   MEM eats the symbol directly; and
2. **`TARGET_SPLIT_ADDRESSES` must be OFF** (`-mno-split-addresses`) — with it ON, gcc lowers the
   pointer to `(high)` and folds the `lo_sum` back into BOTH mems (`lui;lw %lo(sym)(r);sw
   %lo(sym)(r)` = 4 insns, exactly 1 SHORT of the oracle, which is the residual we had).

### 1d. RESULT — `DsReadyCallback` **PASS (5/5), pin-free, natural C**
`recon/syslib/psx/libds/DSCB.c` rewritten to the pointer-local form (**LANDED**, neutral at default
flags), plus these probe-measured TU flags — **for the consolidator to wire** (build.py is
report-only for me):

```python
"recon/syslib/psx/libds/DSCB.c": {"g_value": "0", "no_split_addresses": True,
                                  "no_schedule_insns2": True},
```
Whole-TU gate under that entry, reproduced twice: `DsReadyCallback` **PASS (5/5)**,
`DsDataCallback` 6 → **4** (count-exact 9/9). TU 15 → 4 diffs, 0 → 1 PASS, no regressions.
(`-fno-schedule-insns2` is what fixes `DsDataCallback`'s prologue order — `sw ra` before the
`a1=func` param copy. `-G0` alone gets `DsReadyCallback` to 1 diff; the pair is needed for the
`la`.)

### 1e. HAND-OFF (a1 / a10 / catalog maintainer)
Every fn filed as *"oracle shares an `la` base"* / *"read+write absolute global = assembler floor"*
is re-openable as **`-mno-split-addresses` + pointer-local**. Named candidates straight out of the
catalog row: libmcrd `BIOS.cpp funcEvSp*` ×8, `MemCardCallback`, `USERFUNC::UserFuncInit`, and the
`SetVideoMode` INVERSE case. Catalog §I-addendum's closing RULE should be retracted.

---

## 2. libgte/PATCHGTE — `_patch_gte_handler_1` NOT IN OBJECT → **PASS (12/12)**

Not a near-miss at all: the GTE exception-handler PATCH TEMPLATE (methodology §3.9b **class 2**,
code-as-data whose address is taken and whose bytes are copied) was reconstructed as a C
`const unsigned _gte_patch_text[13]`, which CC1PSX puts in **`.rodata`** — so `objdump -d` never
saw it and the gate could not resolve the oracle's symbol name.

FIX (landed): emit the 12 template words as `.word` data INSIDE the existing file-scope `__asm__`,
immediately after `_patch_gte` (its real VA 0x80106500 == `_patch_gte` + 172 bytes), carrying BOTH
names — `_patch_gte_handler_1` (the oracle's) as a real `.globl` label and `_gte_patch_text` (the
recon's) via a **GNU-as symbol assignment** `"_gte_patch_text = _patch_gte_handler_1\n"` (gcc-2.8
SILENTLY IGNORES `__attribute__((alias))` — catalog §G). The host `#else` branch keeps the C array.
`objdump -t` receipt: `000000ac g F .text 00000030 _gte_patch_text` and the same for
`_patch_gte_handler_1`; `_patch_gte` still PASS 43/43.

🔑 **Reusable gotcha:** do NOT emit splat's interior `alabel` (here `D_80106518`, at &word[6]) as a
real label — objdump ENDS the symbol's disassembly block at the next label, so the gate would only
ever see the first half (measured: `FAIL 6 diffs (ours 6 / oracle 12)`). Only the label that
terminates the symbol at the oracle's declared size (`D_80106530`) may be emitted.

---

## 3. libpress/LIBPRESS — +1 PASS, `DecDCTinSync` 6 → 4

- **R3 (args vs the RAW oracle) — `MDEC_in_sync` / `MDEC_out_sync` take NO ARGUMENT.** Their own
  oracles never read `$a0` (it is only a scratch for the `-1` sentinel), and `DecDCTinSync`'s
  `jal MDEC_in_sync` has an **EMPTY delay slot** — no `$a0` setup at all. The recon declared
  `(int mode)` (unused) and called `MDEC_in_sync(0)`, costing a spurious `addu $a0,$zero,$zero` in
  that slot. The two `_MDEC_*_dma` call sites had been matching only BY ACCIDENT (their `buf`
  already sat in `$a0`). Changed to `(void)` at the decls, defs and all three call sites →
  `DecDCTinSync` 6 → 4, both `_MDEC_*_dma` still PASS.
- **`MDEC_status` → PASS (31/31).** The oracle materializes the `0` return value MID-BLOCK, into
  the `$v0` that the `D1_CHCR = 0` store had just freed; ours lets sched2 float it to the epilogue.
  A named result local assigned at that position is NOT enough (measured: still 2). The **w45
  zero-insn USE FENCE** (`__asm__("" : "=r"(r) : "0"(r))`, the documented sched-issue-position
  fixpoint) pins it → byte PASS. Commented loudly in-source WITH the honest fallback: drop the
  `__asm__` and the fn is a 2-diff count-exact near-miss. Flag for REVIEW if the project tightens
  its scaffolding rule.

---

## 4. libmath/FLTSIDF — `__floatsidf` 50 → 8 diffs (count-exact 64/64)

**R3 again, and it is the single biggest lever found in libmath this wave.** The oracle does NOT
pass the live `0` / `a1` registers to `_dbl_shift_us`; it **re-LOADS both value args out of the
stack array** (`lw $a2,0x18($sp)` / `lw $a3,0x1C($sp)`) and afterwards stores the masked hi word
**back into `sh[1]`**. Writing exactly that (`_dbl_shift_us(sh, 1, sh[0], sh[1], 10);` +
`sh[1] = sh[1] & 0xFFEFFFFF;`) collapses 42 of the 50 diffs.

Residual 8 = two register-identity ties, both measured and both WORSE when "fixed":
(a) the `a1==0` early return — cse hands gcc `sign`'s already-materialized 0 (`$s3`) where the
oracle re-uses `$zero`; moving `sign = 0` below the zero test → **12** (worse).
(b) the final `sh[1]|sign|(exp<<20)` or-chain stages through `$a0` where the oracle accumulates in
place in `$s1`; a named in-place `hi` local → **16** (worse).
Both falsifications are basin-relative; re-test after any other change.

---

## 5. NAMED ANGLE for the libmath far-misses (ADDDF3 / MULDF3 / DIVDF3 / EXTSFDF2 / TRUDFSF2 / _mul_mant_d)

Census over the oracles (`l[wh]u? $aN, 0xNN($sp)` = a call argument loaded straight out of the
frame): **`__adddf3` 26 sites, `__muldf3` 26, `__divdf3` 24, `_mul_mant_d` 6, `__extendsfdf2` 5,
`__truncdfsf2` 3 — and `__divsf3` / `__mulsf3` / `__gtdf2` / `__ltdf2` / `__fixsfsi` ZERO.** The
"lots of stack-loaded args" set is EXACTLY the far-miss set, and `__floatsidf` (§4) proves the
lever: **PsyQ's soft-float keeps its double operands in STACK ARRAYS and re-reads them at every
use and every call, instead of caching them in registers.** Our IDA-derived recons cache them in
C locals, which is why they are 20-40% short/long and re-color wholesale.

Second half of the same model, visible in `__extendsfdf2` / `__floatsidf`: the return is a
**two-variable funnel** (`$s0` = lo word, `$s1` = hi word, assigned on EVERY path incl. the zero
early-out, then `addu $v0,$s0,$zero; addu $v1,$s1,$zero` at ONE shared exit). Concrete next step
for whoever takes these: rewrite around `unsigned lo, hi;` + `goto out;` and re-read `sh[0]/sh[1]`
from the array at every use instead of caching (`__extendsfdf2` is the cheapest entry point at
69 diffs / 86-vs-87 insns).

---

## 6. 🔴 THE DOMINANT RESIDUAL CLASS IN THIS BAND IS **cc1 `reorg` (dbr), NOT the assembler**

Nine of my remaining near-misses reduce to two `dbr_schedule` behaviours:

**(A) EPILOGUE SWAP** — ours `lw ra; nop; jr ra; addiu sp` vs oracle `lw ra; addiu sp; jr ra; nop`
(always count-exact). Fns: `SetFogNear` 4, `StartCARD` 4, `DecDCTin` 4, `DecDCTinSync` 4,
`DecDCToutCallback` 6, `DsDataCallback` 4.
**(B) JUMP-TO-RETURN CONVERSION** — ours `jr ra` where the oracle keeps `j <shared tail>`
(reorg's `make_return_insns`). Fns: `memmove` 2, `memcmp` 6 (+ the same shape inside
`__floatsisf`, `csin`, …).

Evidence assembled:
- **Mechanism (A), from the gcc-2.8.1 sources** (`C:/Temp/gcc-2.8.1-src/extracted`): the MIPS
  epilogue is real RTL — `mips_expand_epilogue()` emits `save_restore_insns; blockage;
  addsi3 sp,sp,tsize; return_internal` — so `fill_simple_delay_slots`' backward scan finds the
  sp-adjust as its FIRST candidate and always takes it. `function_epilogue()` in 2.8.1 is
  statistics only. Confirmed with `-mstats`: `SetFogNear … delay= 2/0L 3/2J` (ours fills 2 of 3
  jump slots) vs the oracle's 3/**1**J.
- **Not a compiler VERSION thing**: psq44 (2.8.1) and psq45 (2.8.1) cc1 emit our epilogue
  byte-identically. Not an `-O` thing: `-O1`/`-O2`/`-O3` identical. `-mno-gas` is rejected by
  CC1PSX; `-mno-gpOPT` inert.
- **Not the assembler** — reconfirming 04C with a 3rd independent instrument
  (`scratch/w48_a8_t3.s` / `w48_a8_t4.s`, with and without an explicit `.set reorder`): real ASPSX
  2.77 given `li $4,3 / jal DMACallback / lw $31 / addu $sp / j $31` emits
  `addiu a0,zero,3 / jal / **nop** / lw ra / addiu sp / jr ra / nop` — it **does NOT backward-fill
  the jal delay slot**, and it leaves exactly the oracle's epilogue.
- **⇒ every one of my six (A) fns is MIXED**: the oracle FILLS some interior jal/branch slot(s)
  (so cc1's delayed-branch was ON) but leaves the `return_internal` slot empty. That combination is
  **not expressible by `-fno-delayed-branch`**, per-TU or per-fn — measured on all of them
  (`SetFogNear` 4→3 but 26-vs-25 insns; `StartCARD` 4→3 at 15-vs-14; LIBPRESS splice: `DecDCTin`
  4→12, `DecDCTinSync` 4→**+2 insns**, `MDEC_in_sync/out_sync` 18→23, `MDEC_rest` 28→34).
  The per-fn splice only works for **PURE** Tier-1 fns where the oracle leaves EVERY slot empty —
  which is exactly why `DecDCTout` and `MDEC_status` are already in `PER_FN_NO_DELAYED_BRANCH` and
  PASS, and why nothing else in LIBPRESS may be added.
- **Tree-wide census** (my `MATCH_PROGRESS`-driven scan of every syslib oracle): **137 fns have the
  sp-adjust in the `jr $ra` delay slot, 135 have a `nop` there** — and the split is MIXED WITHIN
  single objects (libcd/cdcont 6-vs-7, libmcrd/LIBMCRD 12-vs-11, libgpu/SYS 27-vs-8). So it is
  **per-FUNCTION, not a per-object flag** — no `-G`/scheduler/split flag can express it.
  The `nop`-in-slot fns are exactly those where nothing else was available to fill the `lw $ra`
  load-delay; our cc1 always resolves that tie one way (fill the return slot, pay a `#nop`),
  retail's the other (use the sp-adjust as the load-delay filler, pay a nop in the slot).
- **NEW SPEC ITEM for a10 (do not implement):** this is the sharpest statement of the epilogue-swap
  class I can produce — a **per-INSN** delayed-branch distinction (dbr ON for `jal`/`beq`, OFF for
  `return_internal`). It is NOT an assembler question. Route: either a cc1-side patch, or extend the
  w25 splice mechanism from per-FUNCTION to per-BRANCH (splice only the epilogue region of the
  `-fno-delayed-branch` compile — the two regions are textually separable at the `lw $31` line).

---

## 7. FLAG-AXIS RECEIPTS FOR a9 (report-only; `tools/build.py` restored after every probe)

`scratch/w48_a8_probe.py`, 8 settings × whole-TU gate.
🔴 **The briefing's prior that libmath is the `-fno-delayed-branch` class is FALSIFIED:** the flag
is strictly WORSE on every math/gte/libc TU probed and ADDS instructions — the opposite of the
"Sony built the libs with it off" signature.

| TU | baseline | -fno-delayed-branch | -fno-sched-insns | -fno-sched-insns2 | -G0 | -G8 | -mno-split | -fno-strength-red |
|---|---|---|---|---|---|---|---|---|
| libmath/MULSF3 | 94 (76) | **129 (87)** | 100 | 98 | 94 | 94 | 94 | 94 |
| libmath/FIXSFSI | 12 (43) | **28 (53)** | 28 (53) | 12 | 12 | 12 | 12 | 12 |
| libgte/COR_02 | 12 (43) | **26 (55)** | 26 (55) | 12 | 12 | 12 | 12 | 12 |
| libgte/FOG_01 | 4 (25) | 3 (**26**) | 3 (**26**) | 8 | 4 | 4 | 4 | 4 |
| libc/MEMCMP | 6 (17) | **10 (21)** | 10 (21) | 6 | 6 | 6 | 6 | 6 |
| libcard/CARDINIT | 4 (14) | 3 (**15**) | 4 | 4 | 4 | 4 | 4 | 4 |
| libds/DSCB | 15 | 14 | 14 | 13 | **7** | 15 | 15 | 15 |
| libpress/LIBPRESS | 82 | — | — | 91 | 133 | — | 79 (2 regr) | — |

Reading: for the whole math/gte/libc band the stock `-O2` + delayed-branch-ON + scheduler-ON
identity is already correct. The ONLY live per-TU axes found are `-G0` + `-mno-split-addresses`
(address materialization) and `-fno-schedule-insns2` (prologue order), and only on **libds/DSCB**
(§1d). `-mno-split-addresses` on LIBPRESS looks like −3 diffs but converts `MDEC_in_sync` /
`MDEC_out_sync` from 18 to 15 while breaking `_MDEC_in_dma` / `_MDEC_out_dma`'s exact count
(36→38 / 35→37) → **rejected** (identity bar: count must stay exact, no PASS regressions).

🔴 **The `PER_TU_FLAGS`/`PER_FN_NO_DELAYED_BRANCH` DUPLICATE-KEY HAZARD FIRED ON ME** (04G, exactly
as briefed): `recon/syslib/psx/libpress/LIBPRESS.c` ALREADY has a `PER_FN_NO_DELAYED_BRANCH` entry
(line ~499), so my probe's inserted entry at the top of the dict was silently DISCARDED and the
probe read as a clean NO-OP for two runs. Tell: the `.nodb.s` file IS produced but the final `.s`
is unchanged. **Any probe harness must edit the EXISTING key, and counter-audit for duplicates.**

---

## 8. OLD-FLOOR AUDIT (required deliverable)

| floor note (where) | re-gated? | re-tested with which fence/lever | verdict |
|---|---|---|---|
| catalog §I-addendum: *"aspsx shares ONE `la` base … a read+write absolute global is an assembler-expansion floor"* (`MemCardCallback`/`DsReadyCallback`/`funcEvSp*`) | yes, 9 diffs | **real-ASPSX differential** (2.77, hand-decoded object) + cc1 declaration×flag matrix | 🏆 **FALSIFIED — floor DEAD.** aspsx expands each access independently; the shape is `-mno-split-addresses` + a pointer local. Class re-opened tree-wide. |
| DSCB.c in-source: *"NEAR-MISS (5, WEAK floor) … tried+reverted: explicit `DslCB *p=&ds_ready_cb;` local — no effect"* | yes, 9 | the SAME pointer local, re-tested in the `-G0 -mno-split-addresses` basin (lever-order law: the falsification was basin-relative) | 🏆 **FALSIFIED → PASS (5/5).** The lever was right; the basin was wrong. |
| DSCB.c in-source: *"FLOOR (6 diffs) … same family as the PadStartCom/PadStopCom epilogue-order floor … proven unreproducible regardless of C shape/flags"* (`DsDataCallback`) | yes, 6 | full 8-flag probe + combos + per-fn `-fno-delayed-branch` splice | **HALF-FALSIFIED**: `-fno-schedule-insns2` fixes the prologue half (6→4, count-exact). Residual = the epilogue-swap class §6 with a NAMED mechanism (per-INSN dbr), not "unreproducible". |
| MEMMOVE.c in-source: *"A pure code-layout tie-break … not reachable from C structure (early-return form regresses to 5)"* | yes, 2 (27/27) | goto-shared-tail rewrite (a form the note had NOT tried) | **STANDS**, but upgraded from an assertion to a named mechanism: reorg's `make_return_insns` converts the shared-tail `j` into a `jr ra` in our build. Not a coloring tie. |
| build.py `PER_FN_NO_DELAYED_BRANCH` comment: *"Do NOT re-add these under the CURRENT raw-flag mechanism"* (Tier-2, interior-slot fns) | yes | spliced `DecDCTin`, `DecDCTinSync`, `DecDCToutCallback`, `MDEC_in_sync`, `MDEC_out_sync`, `MDEC_rest` | **CONFIRMED** (all worse, +insns). Extended with the discriminator: PURE-Tier-1 = the oracle leaves EVERY slot empty (`DecDCTout`, `MDEC_status`); MIXED = at least one slot filled ⇒ never splice-able. |
| briefing: *"libmath soft-float is a prime `-O`/`-fno-delayed-branch` suspect — Sony shipped these"* | yes | 8-flag whole-TU probe on MULSF3 + FIXSFSI (+COR_02/MEMCMP/CARDINIT/FOG_01 as controls) | 🔴 **FALSIFIED** — strictly worse, and it ADDS instructions on every one. |
| worklist row `_patch_gte_handler_1` "0.00%" | yes | — (it was **NOT IN OBJECT**, an attribution defect, not a match defect) | **PASS (12/12)**, §2. |
| LIBPRESS.c in-source `MDEC_rest` lead (delay-slot-materialized `li v0,0x80000000`) | yes, 28 (62/60) | not attacked this wave (flag axis + splice both negative) | open, note still accurate |

---

## 9. BUGS / CORRECTNESS

No runtime bugs found this wave. Two *reconstruction* defects fixed that were invisible to the
compile gate: (a) `MDEC_in_sync`/`MDEC_out_sync` carried a phantom unused parameter that made two
call sites emit dead argument setup (§3); (b) the GTE patch template was landing in `.rodata`
instead of `.text` — the bytes existed but at the wrong section, so a real link would have placed
the self-modifying-code source outside the range `_patch_gte` copies from (§2).

## 10. PROCESS NOTES
- Real ASPSX needs **CRLF** input. `aspsx -q -o out.obj in.s`; the SN-LNK object is trivially
  decodable by locating `0800e003` (`jr $ra`) and walking back in 4-byte steps.
- `Path.read_text(newline='')` + `\n` anchors silently match 0 times on the CRLF TUs in this tree
  (`LIBPRESS.c`, `FLTSIDF.c`, `PATCHGTE.c`, `DSCB.c` are all CRLF) — detect `\r\n` first, or use
  the Edit tool. Fired twice.
- Commit-per-lever kept `git checkout -- <file>` safe throughout; `tools/build.py` was restored in
  a `finally` after every probe and `git status` verified clean after each batch.
