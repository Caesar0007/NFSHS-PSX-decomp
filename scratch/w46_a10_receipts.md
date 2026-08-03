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
| 6. on-demand receipts (a1/a2/a3/a5) | ✅ **SERVED** — see §6; tables in `scratch/qtytables/`. Still OPEN for new requests. |

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

---

# 🏆🏆 §3 — LOCAL-ALLOC (BLOCK-LOCAL QTY) IDENTITY — **SOLVED, and VALIDATED 100 % on the real binary**

## 3.0 What was delivered
* **`tools/qtytrace.py`** (committed) — reads the block-local **QTY** decisions straight
  out of the instrumented cc1/cc1plus trace: qty formation (`combine_regs` merges),
  the **two ordering groups**, the per-qty `QTY_CMP_PRI`, the register handed out, the
  **`find_free_reg` per-window availability**, plus `--steps` (ref-step boundary math)
  and `--want q=reg` (the required-delta solver).
* **Committed qty tables** under `scratch/qtytables/`:
  `Font_qty.txt` (a1) · `hce_qty.txt` (a2) · `BuildTach_qty.txt`,
  `BuildNumbers_qty.txt`, `Wingman_qty.txt` (a5).

> ⚠️ Why a TRACE and not a python replica: `local_alloc`'s qty formation needs
> per-insn liveness, `combine_regs`' 12-clause bail chain, `alloc_qty_for_scratch`,
> and `post_mark_life`'s sequential window marking. A python re-implementation would
> be unverifiable. The instrumented cc1 **is** the replica, and it is now measurably
> faithful (§1+2), so its trace is stronger evidence than any model.

## 3.1 ✅ VALIDATION — 27/27 exact on `FontUpsideDownBlit`
`FontUpsideDownBlit` compiles **byte-identically** under our instrumented cc1plus vs
the real `CC1PLPSX` (§1+2), and its trace's local handout matches the real
`.lreg` dump's `;; Register N in R.` lines **for every one of its 27 quantities**:

| qty | head pseudo | trace | real CC1PLPSX `.lreg` |
|---|---|---|---|
| q0 | p80 | reg 4 | `Register 80 in 4.` ✅ |
| q8 | p82 | reg 6 | `Register 82 in 6.` ✅ |
| q7 | p83 | reg 7 | `Register 83 in 7.` ✅ |
| q4 | p84 | reg 16 | `Register 84 in 16.` ✅ |
| q6 | p87 | reg 9 | `Register 87 in 9.` ✅ |
| q14 | p88 | reg 10 | `Register 88 in 10.` ✅ |
| q2 | p89 | reg 11 | `Register 89 in 11.` ✅ |
| q25 | p96 | reg 5 | `Register 96 in 5.` ✅ |
| q10 | p144 | reg 12 | `Register 144 in 12.` ✅ |
| q11 | p147 | reg 8 | `Register 147 in 8.` ✅ |
| q9 | p156 | reg 14 | `Register 156 in 14.` ✅ |
| q5 | p159 | reg 15 | `Register 159 in 15.` ✅ |
| q13 | p111 | reg 13 | `Register 111 in 13.` ✅ |
| … | … | … | all 27 ✅ |

**⇒ the local-alloc layer is now as observable as global_alloc was after w45.**

## 3.2 🔴🔴 NEW LAW — **A BLOCK WITH EXACTLY 3 QUANTITIES IS NOT ORDERED BY PRIORITY**
`local-alloc.c:1588-1611` (and the identical `qty_sugg` switch at 1641-1660) does NOT
call `qsort` for small blocks — it runs a hand-rolled sort:
```c
#define EXCHANGE(I1,I2) { i = qty_order[I1]; qty_order[I1] = qty_order[I2]; qty_order[I2] = i; }
switch (next_qty)
  {
  case 3:
    if (qty_compare (0, 1) > 0) EXCHANGE (0, 1);
    if (qty_compare (1, 2) > 0) EXCHANGE (2, 1);
    /* fall through */
  case 2:
    if (qty_compare (0, 1) > 0) EXCHANGE (0, 1);
    break;
  case 1: case 0: break;
  default:
    qsort (qty_order, next_qty, sizeof (int), qty_compare_1);   /* only >= 4 */
  }
```
🔴 **`qty_compare(a,b)` takes QTY NUMBERS, not positions in `qty_order`** — it never
reads `qty_order`. So the comparisons are on the FIXED qtys 0/1/2 while `EXCHANGE`
permutes `qty_order`. For `next_qty == 2` that is still correct (`qty_order == [0,1]`
when the only comparison happens). **For `next_qty == 3` it is NOT a sort.**

Working it out with priorities `P0,P1,P2` (`qty_compare(0,1) > 0  ⟺  P1 > P0`):
```
start        [0,1,2]
if P1 > P0 :  swap positions 0,1
if P2 > P1 :  swap positions 2,1
if P1 > P0 :  swap positions 0,1
```
**MEASURED CONFIRMATION** — `MCRD_handlecardevents` block 21, straight from the trace:
```
[qty_order] q0/p138: 4 refs /6 life = 1.3333
            q1/p142: 4 refs /4 life = 2.0000     <-- HIGHER priority, allocated SECOND
            q2/p143: 2 refs /2 life = 1.0000
```
The priority-descending order would be `q1, q0, q2`; gcc emits **`q0, q1, q2`**.
Hand-running the switch on (1.3333, 2.0, 1.0) gives exactly `[0,1,2]`. ✅
### ✅ CORPUS-WIDE VALIDATION (`scratch/instr/validate_3qty.py`, committed)
Run over EVERY `[qty_order]` line in all four traced TUs (psxfront C++ / memcard C /
hud C++ / drawc C++):
```
3-qty blocks : 38   model-exact 38   NOT priority-descending 12
other blocks : 435  descending  435
```
**38 / 38 (100 %) of three-quantity blocks are predicted EXACTLY by the hand-rolled
model above**, and **12 of them (32 %) come out in an order that `QTY_CMP_PRI` does
not explain.** Every one of the 435 blocks with a different qty count is correctly
priority-descending (the `qsort` / trivial paths). The law is measured, not inferred.

(Blocks with 4+ qtys in the same trace — hce block 14 (5 qtys: 9.0/6.0/6.0/3.0/3.0),
block 16 (4 qtys: 4.5/2.0/1.0/1.0), BuildTach block 8 (7 qtys) — are all correctly
descending, i.e. the `qsort` path.)

### ⇒ CONSEQUENCES (act on these)
1. **🎯 a3 — `PrimMenu`'s "ONE 3-cycle" may be THIS.** If the fighting values are a
   block's *only three* quantities, `QTY_CMP_PRI` does **not** decide the order —
   the position of a qty in the **qty NUMBERING** (= order of first birth in the
   block) does, through the formula above. **The dial then is which value is born
   1st/2nd/3rd, not its refs.** Check `next_qty` for the block FIRST (`[qty_order]`
   prints every qty, so the count is right there).
2. **Adding or removing a 4th quantity in a 3-qty block FLIPS the entire ordering
   discipline** (hand-rolled ↔ qsort). That is a brand-new, zero-instruction dial:
   introduce one extra block-local temp (or fuse two) to cross the 3↔4 boundary.
   Same family as the w44 "empty-case-node switch split" (`balance_case_nodes`
   splits only at >2 nodes) — **gcc-2.8 is full of these small-N special cases, and
   they are all dials.**
3. Every w41-w45 receipt that reasoned "3 block-local qtys, so priority decides"
   must be **re-derived**. The `QTY_CMP_PRI == allocno_compare` law (w45 §A0) is
   still correct — it just doesn't get *applied* when `next_qty == 3`.

## 3.3 The rest of the local-alloc identity (read off the source, now traceable)
* **Two passes, two orders.** Pass 1 sorts by `qty_sugg_compare`
  (`QTY_CMP_SUGG(q) = ncopy_sugg ? ncopy_sugg : nsugg*76`, i.e. **fewest
  copy-suggestions first**, then `QTY_CMP_PRI` desc) and gives every qty that HAS a
  suggestion `find_free_reg(just_try_suggested=1)`. Pass 2 re-sorts by pure
  `QTY_CMP_PRI` and serves everyone still unassigned.
  ⇒ **a qty with a hard-reg copy suggestion jumps the queue entirely.** In Font,
  q0/p80, q7/p83, q8/p82 have `csugg=1` and take `$a0/$a3/$a2` in pass 1 despite
  sitting at priorities .0540 / .0888 / .1250 — *the bottom three of 27*.
* **`combine_regs` merges are visible** (`[qty_combine]`): a qty's `refs` and `calls`
  are the **SUM** over every pseudo merged in. BuildTach block 7 shows a qty
  accumulating `4 → 6 → 8` refs from three pseudos. ⇒ when you dial refs on a merged
  value you are dialling the SUM; `REG_N_REFS` of the head pseudo alone is wrong.
* **`find_free_reg` availability** (`[find_free_reg] ... blocked:`) is per-qty and
  per-**window** `[qty_birth, qty_death)`; each success calls `post_mark_life`, so
  earlier qtys' registers are busy for later ones. The trace labels every refusal
  `live` / `fixed` / `callused` / `callfixed` / `notsugg`.
* Caller-save retry at the qty layer uses the same `CALLER_SAVE_PROFITABLE(4*calls < refs)`.

---

# 📋 §6 — SERVED RECEIPTS (per consumer)

## 6.1 a1 — `FontUpsideDownBlit` QTY TABLE ✅ (authoritative: our cc1plus == CC1PLPSX here)
Full table + `find_free_reg` windows: **`scratch/qtytables/Font_qty.txt`**.
27 qtys, one block, all local (w45 §3's "zero global allocnos" confirmed).

```
   #  qty  head-pseudo  reg   refs life calls sugg/csugg     PRI
   0  q26   p131       v0       4    4     0   0/0        2.0000
   1  q18   p120       v0       6    8     0   0/0        1.5000
   2  q16   p113       v0       4    6     0   0/0        1.3333
   3  q15   p115       v1       6   10     0   0/0        1.2000
   4  q12   p108       v0       2    2     0   0/0        1.0000
   5  q17   p116       v0       2    2     0   0/0        1.0000
   6  q19   p121       v0       2    2     0   0/0        1.0000
   7  q20   p122       v0       2    2     0   0/0        1.0000
   8  q21   p123       v0       2    2     0   0/0        1.0000
   9  q11   p147       t0      17   88     0   0/0        0.7727
  10  q6    p87        t1      26  136     0   0/0        0.7647   <-- the workhorse ptr
  11  q22   p140       v1      10   52     0   0/0        0.5769
  12  q3    p85        v0       4   16     0   0/0        0.5000
  13  q14   p88        t2       4   26     0   0/0        0.3076
  14  q23   p137       a2       7   48     0   0/0        0.2916
  15  q25   p96        a1       6   54     0   1/0        0.2222   <-- has a SUGG
  16  q2    p89        t3       5   54     0   0/0        0.1851
  17  q10   p144       t4       7   78     0   0/0        0.1794
  18  q24   p143       v0       3   20     0   0/0        0.1500
  19  q8    p82        a2       4   64     0   0/1        0.1250   <-- COPY-sugg
  20  q13   p111       t5       3   24     0   0/0        0.1250
  21  q9    p156       t6       7  122     0   0/0        0.1147
  22  q1    p97        v1       3   30     0   0/0        0.1000
  23  q7    p83        a3       4   90     0   0/1        0.0888   <-- COPY-sugg
  24  q5    p159       t7       6  136     0   0/0        0.0882
  25  q0    p80        a0       4  148     0   0/1        0.0540   <-- COPY-sugg
  26  q4    p84        s0       2   68     0   0/0        0.0294   <-- LAST => callee-saved
```
**READ-OFFS for a1:**
* **q4/p84 is dead last (.0294) and that is exactly why it lands on `$s0`** — the w45
  §3 proof, now confirmed by the instrument rather than inferred. To move p84 OFF
  `$s0`, raise its priority: refs `2 → 4` is a full `floor_log2` step
  (`.0294 → .1176`), which lifts it above q0/q5/q7/q1/q9/q13/q8/q24 in one edit.
* **The 4 register-suggestion qtys (q0/q7/q8 csugg, q25 sugg) are allocated in PASS 1
  and are NOT reachable by the ref-step dial at all.** They hold `$a0/$a2/$a3/$a1`
  because they are copies of the incoming argument hard regs. If a1's rotation needs
  one of those registers freed, the lever is to **break the copy relationship**
  (consume the argument through a different expression so `combine_regs` does not
  record the hard-reg suggestion), not to move refs.
* The **9 qtys at priority ≥ 1.0** (q26,q18,q16,q15,q12,q17,q19,q20,q21) all take
  `$v0`/`$v1` — they are tiny 2-refs/2-life temps. They are the "free" slots.
* **Ref-step boundaries** for every qty: run
  `python tools/qtytrace.py scratch/instr/cmp/pp/trace.txt FontUpsideDownBlit --steps`.
* Once you know retail's target mapping, run
  `... --want q4=t7,q5=s0` (etc.) and it prints the minimal refs/life change on both
  sides of every crossing.
* 🔴 **Font's block has 27 qtys ⇒ the qsort path, so §3.2's 3-qty quirk does NOT
  apply here.** Priority genuinely decides.

## 6.2 a2 — `MCRD_handlecardevents` : **the w45 rank table is STALE — your rotation is ALREADY RIGHT**
Full trace table: **`scratch/qtytables/hce_qty.txt`**. `MCRD_handlecardevents`
compiles **byte-identically** under our instrumented cc1 (it is one of the 19/20), so
this is authoritative for the current base `6a43ac79`.

The two pseudos w45 §2 flagged are **global allocnos**, and at THIS base:
```
[allocno_compare]  4/92:12/22/0/1=16363   7/144:9/20/0/1=13500  ...
[find_reg]  allocno 4 pseudo 92  refs 12 live 22 calls 0 ... -> reg 4   ($a0)
[find_reg]  allocno 7 pseudo 144 refs  9 live 20 calls 0 ... -> reg 5   ($a1)
```
| pseudo | role (w45 §2) | w45 refs/live/pri | **NOW** refs/live/pri | **NOW gets** | w45 said retail wants |
|---|---|---|---|---|---|
| p92 | the `gMemCardInfo` **base** (`lo_sum`) | 4 / 22 / **.3636** | **12 / 22 / 1.6363** | **$a0** ✅ | $a0 |
| p144 | the **cmd** reload from the frame | 7 / 20 / **.7000** | **9 / 20 / 1.3500** | **$a1** ✅ | $a1 |

**⇒ There is no find_reg-preference anomaly.** The premise ("rank table says cmd wins
yet base gets $a0") was true only in the w45 basin. Your own w45 ref work took the
base from 4 → 12 refs (past TWO `floor_log2` steps), so the base now legitimately
out-ranks cmd and `find_reg`'s plain numeric handout gives it `$a0`. This is the
wave-45 **basin-relative-falsification law** firing on a receipt rather than a
spelling: *re-measure before consuming any cross-agent number.*
**⇒ spend your remaining budget entirely on the sched2 ready-list drain tie**
(briefing angles a–c); the register layer is closed at this base.
Bonus for angle (c): hce block 21 is a **3-qty block** — see §3.2; if your fence lands
in that block the ordering discipline itself changes.

## 6.3 a5 — `BuildTach` ✅, `BuildNumbers` ✅ (both byte-identical ⇒ authoritative), `Wingman` ⚠️
* **`scratch/qtytables/BuildTach_qty.txt`** — `Hud_BuildTach__Fi` is **SAME** vs
  CC1PLPSX ⇒ receipt-grade. 13 blocks. The interesting ones:
  * **block 8 (7 qtys, qsort path)** — `q2/p143 8refs/14life = 1.7142 → $v0`,
    `q5/p138 6/8 = 1.5000 → $v1`, `q1/p134 2/2 = 1.0 → $v0`, `q6/p144 2/2 = 1.0 → $v0`,
    `q0/p140 2refs/10life = 0.2000 → $v1`, plus two HI/LO qtys.
    q0/p140 is the low-priority straggler: refs `2 → 4` gives `.4000`, `2 → 8` gives
    `2.4000` (crosses everything).
  * **blocks 6 and 7 are 2-qty blocks** whose printed order is `q1` before `q0`
    although q0 was born first — the `case 2` swap. Both are `4 refs` qtys built by
    `combine_regs` merges (`p124+p125`, `p128+p127`, …) — i.e. **their refs are SUMS**,
    which is exactly the w44 "reorg-steal" receipt's missing input.
  * **block 3 (4 qtys)** — `q2/p109 8/8 = 3.0`, `q1/p105 5/6 = 1.6666`, `q0/p102 2/2 = 1.0`,
    `q3/p111 2/2 = 1.0`.
* **`scratch/qtytables/BuildNumbers_qty.txt`** — `Hud_BuildNumbers__Fi` is **SAME** ⇒
  receipt-grade, with `--steps` boundary math on every qty (967 lines; a lot of blocks).
  🔴 This ALSO settles the w45 §5 note "do the structure first": at the w46 base the
  function already matches our instrumented CC1PLPSX exactly, so the **pSprt
  `$s4`-vs-`$s5` question is now purely an allocno/qty ranking question** — post the
  pseudo numbers of the two pSprt candidates and I (or `--want`) will give the delta.
* **`scratch/qtytables/Wingman_qty.txt`** — ⚠️ `Hud_BuildWingmanInterface__Fi` measures
  **d204** vs CC1PLPSX, so treat this table as INDICATIVE, not a receipt. The
  *mechanism* rows (which qtys exist, which are merged, which have suggestions) are
  still usable; the exact priorities are not.
  Its constants being "caller-saved block qtys" (briefing) is confirmed by the table:
  they appear as `calls 0` qtys with `sugg/csugg 0/0`, i.e. pure pass-2 priority
  candidates ⇒ **the ref-step dial applies, birth order does not** (unless that block
  has exactly 3 qtys — check §3.2).

## 6.4 a3 — `PrimMenu` : the 3-qty law + a BLOCKER, with exact resume steps
* 🎯 **PRIMARY DELIVERABLE = §3.2.** `PrimMenu`'s residual is described as "ONE
  3-cycle". If those three values are the only quantities in their block, **the order
  is decided by the hand-rolled `next_qty == 3` sort, not by `QTY_CMP_PRI`** — so the
  w45 §A0 re-derivation ("compute their QTY priorities, apply the ref-step dial")
  would give the wrong answer, and the dial is instead **birth order (qty numbering)
  and/or crossing the 3↔4 qty-count boundary**.
* ⚠️ **BLOCKER — I could not produce `PrimMenu`'s table.** Our gcc-2.8.1 cc1plus takes
  an **Internal compiler error at `drawc.cpp:2102`** (and `hud.cpp:2473`), which
  aborts code generation for every function AFTER that point in the TU — `PrimMenu`,
  `Prim`, `PrimClip`, `PrimHalo`, `ShowroomPrims`, `SpotPrims`, `DividePrim`,
  `ShadowPrim*` are all in the truncated tail (`PrimStart`/`PrimStop` are before it
  and came out **SAME**). This is a 2.8.1-vs-2.8.0 C++ **front-end** regression, not a
  codegen difference — `drawc` still scored 9 identical of the 11 functions it did emit.
* **RESUME (any agent, ~15 min):** the ICE is per-TU-position, so slice around it.
  1. `python tools/rtl_dump.py recon/game/psx/drawc.cpp -dg -dl` → `scratch/rtl/drawc.i`
  2. Copy the `.i` to your own dir (cc1 names dumps after the input path!) and **cut
     the preprocessed text so only `PrimMenu` and its prerequisites remain** — or
     simpler, replace the body of the function containing `drawc.cpp:2102` with
     `{ }`. The ICE line is the closing brace of the function immediately before
     `DrawC_DividePrim` (`drawc.cpp:2103`).
  3. `GCC_TRACE_ALLOC=1 scratch/gccbuild-ecoff/cc1plus.exe -quiet -O2 -G4 -mgas
     -msplit-addresses -funsigned-char -fno-exceptions -fno-rtti sliced.i -o sliced.s
     2> trace.txt`
  4. **Verify fidelity**: `python scratch/instr/cmp_fns.py scratch/rtl/drawc.s sliced.s`
     — only trust the trace if `DrawC_PrimMenu…` shows `SAME`.
  5. `python tools/qtytrace.py trace.txt PrimMenu --steps --blocked`
  6. If it is a 3-qty block, ignore the priorities and read §3.2.

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
