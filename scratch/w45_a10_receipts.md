# WAVE-45 a10 — REQUIRED-DELTA RECEIPTS (GCC INSTRUMENT LANE)

**Status: LIVE. Updated as the lane progresses. Consumers: a1 (Draw/Font), a2 (hce),
a6 (DrawQuad), a8 (BuildNumbers/BuildTach).**

---

## 0. THE INSTRUMENT — `tools/allocsim.py` (VALIDATED, in `w45-a10`)

A line-by-line python replica of **gcc-2.8 `global.c`**, driven by the compiler's own
`-dg` (`.greg`) + `-dl` (`.lreg`) dumps.  Read, not guessed, from
`C:\Temp\gcc-2.8.1-src\extracted\`:

| gcc source | modelled |
|---|---|
| `global.c:594` `allocno_compare` | `pri = (int)((double)(floor_log2(refs)*refs) / live * 10000 * size)`, ties → **lower pseudo number** |
| `global.c:899` `find_reg` | `used1` = `fixed_reg_set` (calls==0) / `call_used_reg_set` (calls!=0) / `call_fixed_reg_set` (retry); pass-0 additionally excludes `~regs_used_so_far` and `regs_someone_prefers`, pass-1 drops both; scan is **NUMERIC 0..75** (MIPS defines **no** `REG_ALLOC_ORDER`) |
| `global.c:986` copy-pref → `goto no_prefs`, then plain prefs | copy prefs recovered from the `.lreg` RTL (`(set (reg P) (reg H))`), since `dump_conflicts` prints only the union |
| `global.c:1075` caller-save retry | fires iff `flag_caller_saves && calls!=0 && CALLER_SAVE_PROFITABLE(refs,calls)` |
| `regs.h:202` | `CALLER_SAVE_PROFITABLE(REFS,CALLS) == (4*CALLS < REFS)` |
| `global.c:1097` | the "local-alloc used this reg poorly" eviction (numeric **descending** scan) |
| `global.c:828` `prune_preferences` | `regs_someone_prefers` |
| `config/mips.h:1378/1395/1624` | FIXED / CALL_USED / REG_CLASS_CONTENTS |

### VALIDATION PROOF

```
TU                       allocnos  functions
psxfront.cpp             145/145      14/14      100%
memcard.c   (C lane)      96/96       17/17      100%
draww.cpp                353/353      28/28      100%
hud.cpp                  558/558      39/39      100%
drawc.cpp                404/404      15/15      100%
flare.cpp                212/212      15/15      100%
overlays.cpp             143/143       4/4       100%
font.cpp                  51/51        7/7       100%
-------------------------------------------------
TOTAL                   1962/1962    139/139     100%
```
The sorted allocation ORDER also reproduces the dump's `;; N regs to allocate:` list
**byte-for-byte** on every function.

**DrawGouraudShape gate case (the briefed validation target) — 30/30 exact:**
```
19: p272   fp   (fp  )  refs=9    live=150   .1800
20: p110   t1   (t1  )  refs=6    live=69    .1739
21: p90    t2   (t2  )  refs=9    live=159   .1698   <-- v
22: p92    a1   (a1  )  refs=2    live=12    .1666
23: p82    t3   (t3  )  refs=11   live=340   .0970   <-- x
24: p166   t4   (t4  )  refs=7    live=153   .0915   <-- 0xFF0000 mask
25: p84    t5   (t5  )  refs=9    live=336   .0803
26: p81    t6   (t6  )  refs=8    live=340   .0705
27: p237   --   (--  )  refs=3    live=151   .0198   <-- 4*1<3 false, no retry
28: p87    --   (--  )  refs=3    live=166   .0180   <-- vh
29: p85    --   (--  )  refs=3    live=334   .0089
```

### KNOWN MODEL BOUNDARY (documented, not a bug)
`allocsim` models **`global_alloc` only**. The `.greg` `;; Register dispositions:` block is
printed by `dump_global_regs` **after `reload()`**, so a pseudo can be RE-HOMED afterwards
(`reload1.c:3722` `retry_global_alloc`, printed as `Register N now in M`; plus the SILENT
inheritance re-homes at `reload1.c:6277` / `7362`). 10 such cases across the corpus; the
validator classifies them separately. **If a residual is a reload re-home, the allocno dials
below cannot reach it.**

### 🔴 SECOND MODEL BOUNDARY — **local_alloc vs global_alloc** (read §3 before using it)
A pseudo the `.lreg` tags *"in block N"*, or that is absent from `;; N regs to allocate:`, is a
**`local_alloc` QTY**: it was placed BEFORE `global_alloc` ran, so `find_reg`,
`regs_someone_prefers` and `CALLER_SAVE_PROFITABLE` cannot reach it. Check this FIRST — **three
of the five survivors below are entirely in the local domain.**
**BUT** (§3) `local-alloc.c`'s `QTY_CMP_PRI` is the **SAME `floor_log2(refs)*refs*size/life`
formula** as `allocno_compare` in gcc-2.8, so the REF-STEP dial *does* apply there — only
`find_reg`'s pool/preference machinery does not. The project's standing
*"local_alloc = longest-life-first"* rule is the gcc-**2.7** behaviour and is **falsified** for
this compiler (two independent proofs in §3).

---

## 1. DrawGouraudShape (a1) — psxfront.cpp, gate 113, count-exact 240/245

**Retail target read off the oracle** (`asm/nonmatchings/front/DrawGouraudShape…s`):
`addu t2,a2,zero` ⇒ **x → $t2**; ours `addu t3,a2,zero` ⇒ x → $t3. The whole
`v→t2 / x→t3 / mask→t4` 3-cycle is one rank inversion.

Pseudo identification (`tools/pseudoid.py`):

| pseudo | RTL def | source | ours | retail |
|---|---|---|---|---|
| p82 | `(set (reg 82) (reg:SI 6 a2))` | the `x` param copy | **$t3** | **$t2** |
| p166 | `(set (reg 166) (const_int 16711680))` | the `0xFF0000` mask | **$t4** | **$t3** |
| p90 | `(set (reg:HI 90) (zero_extend (mem:QI (shp+26))))` | `v = (byte)shp->shapey` | **$t2** | ranks BELOW x |
| p110 | `(set (reg 110) (plus (reg 112) (reg 118)))` | | $t1 | $t1 |
| p86 | `(set (reg 86) (mem (reg 159)))` | `prim` = `*Render_gPacketPtr` | $s0 | $s0 |

### ✅ REQUIRED DELTA — the minimum that flips `p82→$t2, p166→$t3`

| dial | pseudo | from → to | Δ | mechanism |
|---|---|---|---|---|
| **refs** | **p90 (`v`)** | **9 → 7** | **−2** | **THE `floor_log2` STEP AT 8**: `3*9/159=.1698` → `2*7/159=.0881`, which lands v *between* mask (.0915) and p84 (.0803). Everything above shifts up one: **x→$t2, mask→$t3, v→$t4, p84→$t5, p81→$t6** — retail's exact t-band. |
| refs | p110 | 6 → 4 | −2 | same flip via the rival side (`.1739 → .0503`) |
| calls | p104 / p106 / p111 / p112 / p119 | 0 → 1 | +1 | make ONE currently non-call-crossing value LIVE ACROSS the single `jal GetClut`. This is literally a1's own *"ours has only 9 call-crossing candidates, retail had 10"* observation, now quantified: **any one of these five suffices.** p106 = `sign_extend(mem:HI shp+16)` (`width`), p112 = `zero_extend(mem:HI shp+24)`, p104 = `sign_extend` of `p93`, p111 = `p144 - p142`, p119 = `p104 * p115`. |
| refs | p272 | 9 → 6 | −3 | |
| refs | p94 / p112 | 6 → 3 | −3 | |
| live | p112 | 8 → 26 | +18 | last-USE position |

**⚠️ `calls` dial for v itself is UNREACHABLE here.** `p90 calls 1→3` also works in the model,
but **DrawGouraudShape has exactly ONE `jal` (`GetClut`)** — `REG_N_CALLS_CROSSED` can only be
0 or 1. Same for `p90 refs 9→4` (which would remove v's register entirely): reachable, but −5
refs is a bigger cut than the −2 the rank flip actually needs, and the oracle shows retail's v
*does* transiently hold `$t4` (`addu t4,v0,zero`; `addiu t4,v0,-1`) before being spilled to
`32(sp)` — i.e. **retail's v got a register from `global_alloc` and lost it in `reload`.** So
the −2 ref-step (v keeps $t4) is the FAITHFUL target, not the −5.

### CANDIDATE SOURCE DIALS (briefing §2b + w44 catalog)
* **refs −2 on `v`** — inverse of the w44 inflator family. `v` is loop-weighted, so removing
  **one in-loop reference** costs 2 weighted refs exactly. Concretely: `v` is read twice per
  vertex row; fusing the two reads into one temp (or hoisting one read out of the loop) is a
  −2 weighted-ref edit. This is the *inverse* of §2b.1's "bitfield-READ supplies refs" dial.
* **calls +1 on `width`/p112/p104** — a1's cheapest lever and ZERO instructions: move the
  *definition* of one of these above the `jal GetClut`, or its *last use* below it, so its live
  range spans the call. `p106` (`width`, `sign_extend(mem:HI shp+16)`) is the natural one —
  `width` is already read pre-loop and used post-call.
* ⚠️ Do NOT use the `do{}while(0)` depth wrapper on the v side: it *doubles* in-loop refs
  (wrong direction) and a1 already measured the LOOP_BEG/END barrier as costly here (147/152).

### SECOND-ORDER (not required for the flip, but for the last insns)
Ours 240 vs oracle 245: retail carries **five more instructions** — the `lhu 18(s4)/sh 24(sp)`
vh pair and the `v` `sb/lbu 32(sp)` spill pair. Retail's higher pressure comes from that extra
call-crossing value (see the `calls 0→1` row) — the SAME edit is expected to buy both.

---

## 2. MCRD_handlecardevents (a2) — memcard.c (C lane), gate 56, **count-exact 211/211**

| pseudo | RTL def | source | ours | retail |
|---|---|---|---|---|
| p92 | `(set (reg 92) (lo_sum (reg 93) (symbol_ref "gMemCardInfo")))` | the **base** address | **$a1** | **$a0** |
| p144 | `(set (reg 144) (mem (fp+16)))` | the **cmd** reload from the frame | **$a0** | **$a1** |

Base priorities: **cmd p144 = `2*7/20 = .7000`**, **base p92 = `2*4/22 = .3636`** — exactly the
`.700` vs `.364` the briefing quotes. Both are `calls=0`, so they take the numeric caller-saved
pool in rank order.

### ✅ REQUIRED DELTA — the minimum that flips `p92→$a0, p144→$a1`

| dial | pseudo | from → to | Δ | boundary math |
|---|---|---|---|---|
| **refs** | **p92 (base)** | **4 → 8** | **+4** | `floor_log2` **2→3** at the power-of-two step: `.3636 → 3*8/22 = 1.0909` > `.7000` |
| **refs** | **p144 (cmd)** | **7 → 3** | **−4** | `floor_log2` **2→1**: `.7000 → 1*3/20 = .1500` < `.3636` |
| live | p92 (base) | 22 → ≤11 | −11 | `8/11 = .7272 > .7000` (razor: 11 works, 12 = `.6667` does not) |
| live | p144 (cmd) | 20 → ≥39 | +19 | `14/39 = .3589 < .3636` (razor: 39 works, 38 = `.3684` does not) |

### CANDIDATE SOURCE DIALS
* 🏆 **`refs 4 → 8` on the base is EXACTLY one `do{}while(0)` depth level** (§2b/w44 inflator
  #3: each level ×2 on weighted in-body refs). All four `gMemCardInfo`-base references would
  need to sit inside the wrapper. **Cost:** `NOTE_INSN_LOOP_BEG/END` is a scheduling barrier —
  a2 must re-gate the whole TU (`HandleError/DoFileLoad/FormatCard/ascii2sjis/sjis2ascii`).
* **Deliberate arm duplication** (inflator #2, `Hud_Render` 90→30): write a base-touching block
  twice so cross-jump merges it back while `flow.c` counts both arms. Zero insns, no barrier —
  **try this before the depth wrapper.**
* **Zero-insn re-mask** (inflator #1) does not apply directly to an *address* pseudo, but the
  `lo_sum` is reachable via a second, cse-folded `&gMemCardInfo`-derived expression.
* **`live 22 → ≤11` on the base** is a2's angle (b) made precise: the base's live range must
  END 11 insns earlier. A **SYM-legal existing-value re-read** that shortens the base's span
  (rather than displacing cmd) hits the same razor from the cheap side.
* **`refs 7 → 3` on cmd**: cmd is the *spilled* value reloaded from `16(sp)`; its refs are
  reload-driven, so this side is the harder one.

---

## 3. FontUpsideDownBlit (a1) — psxfront.cpp, gate 50, **count-exact 82/82**

### 🔴 THE `.greg` SECTION HAS **NO `;; N regs to allocate:` LINE AT ALL.**
`FontUpsideDownBlit` has **ZERO global allocnos** — it jumps straight from the function header
to `;; Register dispositions:`. All 49 of its pseudos are `local_alloc` **QTYs**.
⇒ `find_reg`, `regs_someone_prefers`, `CALLER_SAVE_PROFITABLE` and the *global* allocno table
are all structurally incapable of moving anything here.

### 🏆 BUT THE REF-STEP FAMILY **DOES** APPLY — the standing project lore is WRONG
`local-alloc.c:1727`:
```c
#define QTY_CMP_PRI(q)            ((int) (((double) (floor_log2 (qty_n_refs[q]) * qty_n_refs[q] * qty_size[q])           / (qty_death[q] - qty_birth[q])) * 10000))
```
**This is the SAME formula as `allocno_compare`.** The comment immediately above it says so:
> *"We used to give preference to registers with **longer** lives, but using the same algorithm
> in both local- and global-alloc can speed up execution of some programs by as much as a
> factor of three!"*

⇒ the catalog's repeated claim **"local_alloc = allocate LONGER-LIVED first"** (w41 PrimStop, w42,
the w44 REVERSE-BIRTH-ORDER law, and every "local qty tie ⇒ birth/life only" floor) is the
**gcc-2.7 rule** and is **FALSE for this compiler**. `qty_compare_1` sorts by `QTY_CMP_PRI`
descending, ties by qty number (later-born wins only *within* equal priority).

**TWO INDEPENDENT CONFIRMATIONS (this lane):**
1. *Empirical, on the real PsyQ binary* — Font is all-local. Under longest-life-first, `p84`
   (**live 70, the longest**) would be allocated FIRST and take the lowest free register. It gets
   **`$s0` (reg 16), the HIGHEST register in the function**. Under `QTY_CMP_PRI` p84 has the
   **LOWEST** priority (`2 refs / 70 live` → **.0285**) and is allocated LAST, which is exactly
   why it lands on a callee-saved reg. Same for `p90` (live 65, pri .0461 → `$t7`), `p91`
   (live 58, .1379 → `$t6`), `p93` (live 38, .0789 → `$t4`). **The life-ordered model predicts
   the exact opposite of the observed handout.**
2. *Direct, from an instrumented cc1* (§7) — the `[qty_compare]` trace prints the sorted qty list
   with its priorities: `1/83:8/24=10000  2/85:3/4=7500  3/91:3/4=7500  0/80:2/20=1000`, i.e.
   `floor_log2(8)*8/24 = 1.0`. **Sorted by priority, not by life.**

### ⇒ NEW NAMED ANGLE FOR a1 (the wave's law: no floors)
Font's residual is a **local-qty priority tie**, and the **`floor_log2` REF-STEP dial applies to
it**. Every w44 inflator is back on the table for this function:
* zero-insn semantic no-op re-mask (`x | (y & MASK)` where y is already masked),
* deliberate arm duplication that cross-jumps back (`flow.c` counts both arms),
* `do{}while(0)` depth wrapper (×2 on weighted in-body refs).
Statement position (`stmtclimb`) remains valid *as well* — it moves `qty_birth`/`qty_death` —
but it is **no longer the only dial**, which is why 14 spelling families measured nothing:
they moved neither refs nor life.

⚠️ Caveat: `qty_n_refs` / `qty_death-qty_birth` are **not printed** in the `-dl` dump. For a qty
that is 1:1 with a pseudo (the common case) `REG_N_REFS` / `REG_LIVE_LENGTH` from the `.lreg`
line are good proxies; `local-alloc.c combine_regs` merges copy-related pseudos into one qty, so
a merged qty's refs are the SUM. Use the instrumented cc1 (§7) when the exact number matters.

## 4. DrawW_DrawQuad (a6) — draww.cpp, gate 100, **count-exact 592/592**

The residual is one clean **4-cycle rotation** of four block-30 quantities (repeated in block 57):

| pseudo | RTL def | value | ours | **retail** | refs / live | `QTY_CMP_PRI` |
|---|---|---|---|---|---|---|
| p317 | `(set (reg 317) (mem (const_int 528482304)))` | read of `*(0x1F800004)` = packet cursor | **$a3** (7) | **$t0** | 3 / 14 | **.2142** |
| p318 | `(set (reg 318) (const_int 528482304))` | the literal `0x1F800004` | **$t1** (9) | **$t2** | 3 / 24 | **.1250** |
| p329 | `(set (reg 329) (const_int 16711680))` | `0x00FF0000`, `ori …,65535` → **`0x00FFFFFF` mask** | **$t2** (10) | **$a3** | 3 / 28 | **.1071** |
| p322 | `(set (reg 322) (const_int -16777216))` | **`0xFF000000` mask** | **$t0** (8) | **$t1** | 3 / 38 | **.0789** |

All four are **`local_alloc` QTYs** (`.lreg` says *"in block 30"*, absent from the allocate list),
so `allocno_compare` never sees them — but per §3 they obey the **identical** `QTY_CMP_PRI`
formula, so **the REF-STEP dial applies.**

Our allocation order is exactly PRI-descending: `p317 .2142 > p318 .1250 > p329 .1071 > p322 .0789`
→ `a3, t1, t2, t0` (the register each gets is the lowest free one *over that qty's own
birth..death window*, which is why it is not a flat 7,8,9,10).

Retail's registers imply the allocation order **`p329, p317, p322, p318`** (→ a3, t0, t1, t2).

### ✅ REQUIRED DELTA — **two single-reference inflations**

| pseudo | dial | from → to | Δ | boundary math |
|---|---|---|---|---|
| **p329** (`0x00FFFFFF` mask) | **refs** | **3 → 4** | **+1** | `floor_log2` **1→2** at the power-of-two edge: `.1071 → 2*4/28 = .2857`, which clears p317's **.2142** → p329 allocates FIRST → takes `$a3` |
| **p322** (`0xFF000000` mask) | **refs** | **3 → 4** | **+1** | `.0789 → 2*4/38 = .2105`, which sits **between** p317 (.2142) and p318 (.1250) → p322 lands THIRD → `$t1` |

Alternatives on the life dial: `p329 live 28 → ≤13`, `p322 live 38 → ≤23`.

**⇒ TWO extra references, zero instructions.** This is precisely §2b.1's *"whether the VALUE side
is a plain word or a bitfield READ sets the mask's refs 5-vs-7"* dial and the w44 zero-insn
re-mask — applied to the two OT-link masks. **Try both `PTag` bitfield settings on this
function's OT-link pair; the gate should pick the one that adds exactly one ref to each mask.**

**a6 ↔ a8 DEPTH-2 RECONCILIATION — RESOLVED:** the w41 *"find_reg's COST PASS is a model
boundary, not source-steerable"* verdict for this class was formed on the **wrong model**.
These pseudos never reach `find_reg` at all — they are decided by `local_alloc`, whose priority
function is the same `floor_log2` ref-step. **Re-open the class.**

## 5. Hud_BuildNumbers / Hud_BuildNumbers0 (a8) — hud.cpp

Re-gated **from the worktree root, this base** (worklist numbers are wrong again):

| fn | gate | ours / oracle |
|---|---|---|
| `Hud_BuildNumbers__Fi` | **620** | 760 / 758 |
| `Hud_BuildNumbers0__Fi` | **223** | 532 / 531 |

These are **NOT ±1 allocator ties** at this base — they are far-misses with structural residual
(BuildNumbers' head shows `fp`-vs-`s2` receiver role plus a whole `sw a0,80(sp)` spill the
oracle lacks; BuildNumbers0 opens with a `bnez`↔`beqz` polarity flip + a `j`/`lw` reorder).
**Do the structure first**; the allocno instrument is premature until the count is exact.

Both functions DO have large global-allocno tables (47 and 52 allocnos, plus 446/238 local
qtys), so once the count is exact the instrument applies. Top of each table:
```
BuildNumbers :  p878 a0 (11/16 .2.0625)  p883 a0  p888 a0  p873 a0 (11/17)  p893 a0 (11/18)
                p104 a2 (20/61 1.3114)   p237 a2 (20/65 1.2307)  p236 a1 (14/42 1.0000)
                p103 a1 (14/54 .7777)    p656 s1 (24/125/3calls .7680)
BuildNumbers0:  p86  a0 (26/48 2.1666)   p627/647/651/655 a0 (11/16)  p637 s0 (11/17)
                p112 a2 (20/63 1.2698)   p251 s0 (16/62/2c 1.0322)    p492 s0 (16/62/2c)
                p382 s1 (16/63/3c 1.0158) p113 a1 (8/24 1.0000)
```
Note the **five identical `11 refs / 16 live` allocnos all in `$a0`** in each function — these
are the per-digit sprite builders; they tie on priority and are broken by **pseudo number
(ascending)**, i.e. by **first-use order**. If retail's digit order differs, that tie-break is
the dial and it is reachable by statement order alone.

---

## 6. HOW TO RUN THE INSTRUMENT YOURSELF

```bash
# 1. dump  (C++ lane / C lane)
python tools/rtl_dump.py   recon/frontend/psx/psxfront.cpp -dg -dl   # -> scratch/rtl/
python tools/rtl_dump_c.py recon/frontend/psx/memcard.c    -dg -dl   # -> scratch/rtl_a5/

# 2. reproduce + inspect the allocation
python tools/allocsim.py scratch/rtl/psxfront.i.greg scratch/rtl/psxfront.i.lreg \
       "void DrawGouraudShape(struct tTexture_ShapeInfo *, int, int, int, int *, int)"

# 3. ask for a required delta  (reg names or numbers; 'none' = no hard reg)
python tools/reqdelta.py scratch/rtl/psxfront.i.greg scratch/rtl/psxfront.i.lreg \
       "void DrawGouraudShape(...)" --want "p82=t2,p166=t3"

# 4. what-if a single dial
python tools/allocsim.py <greg> <lreg> "<fn>" --what-if 90:refs=7

# 5. tie a pseudo number back to source
python tools/pseudoid.py scratch/rtl/psxfront.i.lreg "<fn>" 90 82 166

# 6. sanity-check the model on a whole TU before trusting a receipt
python tools/allocsim_validate.py <greg> <lreg>
```

**RULE OF USE:** if the pseudo you care about is tagged `in block N` in the `.lreg` line, or is
absent from `;; N regs to allocate:`, it is a **local_alloc QTY** — stop, and use birth/life
position, not refs.


---

## 7. THE INSTRUMENTED cc1 — **BUILT AND WORKING**

A gcc-2.8.1 cross-cc1 (`--target=mipsel-unknown-elf`) now builds and runs on this machine, with
`fprintf(stderr)` decision traces patched into `global.c` (`find_reg`, `allocno_compare`, the
caller-save retry) and `local-alloc.c` (`qty_compare` ordering).

**Binary:** `scratch/gccbuild/cc1.exe`  ·  **Sources:** `scratch/gccsrc/gcc-2.8.1/`
(`.orig` copies kept for `global.c`, `local-alloc.c`, `obstack.h`)

### Run it
```bash
cd scratch/instr && mkdir -p tmp
TMPDIR='C:\Temp
fs4-wt45-a10\scratch\instr	mp' TMP='C:\Temp
fs4-wt45-a10\scratch\instr	mp'   GCC_TRACE_ALLOC=1 ../gccbuild/cc1.exe -quiet -O2 -G4 <tu>.i -o out.s 2> trace.txt
```
Sample trace (real output):
```
[qty_compare]      order (qty/firstreg:refs/life=pri): 1/83:8/24=10000 2/85:3/4=7500 3/91:3/4=7500 0/80:2/20=1000
[allocno_compare]  order (pseudo:refs/live=pri): 90:4/6=13333 80:11/88=3750 82:4/26=3076
[find_reg]         allocno 2 pseudo 90 refs 4 live 6 calls 0 size 1 alt 0 ccl 0 retry 0 -> reg 3
[caller-save]      pseudo 82 PROFITABLE (4*1 < 9) -> retry
```

### 🔴 IT IS A LABORATORY, **NOT AN ORACLE**
Diffed function-by-function against the real PsyQ CC1PSX on `memcard.i`: **6 functions identical,
11 differ** — and the *pseudo numbers themselves* differ (`116` vs `123`, `134` vs `144`), i.e.
the RTL diverges **before** allocation. Causes: our config uses `mips/elfl.h` where PsyQ used
ECOFF (`mips/ecoffl.h` + `t-ecoff`), and PsyQ's cc1 is an SN-Systems-patched build (ours emits
`.set nobopt`, theirs does not; theirs emits `.def/.scl` ECOFF debug records).
**⇒ Use it to read MECHANISM (what the passes decide, and why). Use `allocsim` — which consumes
the REAL binary's own dumps and validates 1962/1962 — for any actual required-delta receipt.**

### 🏆 2.8.0-vs-2.8.1 DIVERGENCE: **THERE IS NONE IN THE ALLOCATOR**
The tarball ships the full `ChangeLog`. `Version 2.8.1 released` is line 3;
`Version 2.8.0 released` is line 659 — so lines 1..659 are the complete 2.8.0 → 2.8.1 delta.
Grepping that window for `local-alloc.c|global.c|caller-save.c|regclass.c|regs.h|reload1.c`
returns **ZERO hits**. The only allocator-adjacent changes in the entire release are three
`reload.c` fixes:
* `find_reloads`: always convert address reload for a non-reloaded operand to `RELOAD_FOR_OPERAND_ADDRESS`
* `debug_reload`: properly output insn codes
* `find_reloads`: check for the const_to_mem case before checking for an invalid reload; use `force_const_mem` if `no_input_reloads`

**⇒ the 2.8.1 sources ARE the 2.8.0 allocator, verbatim.** No 2.8.0 source fetch is needed, and
every `global.c` / `local-alloc.c` / `regs.h` line quoted in this file is exactly what the repo's
gcc-2.8.0-psyq binary executes.

### Reproduce the build from scratch (≈6 min)
```bash
cd scratch/gccsrc && tar xzf C:/Temp/gcc-2.8.1-src/gcc281.tar.gz
cd gcc-2.8.1 && chmod u+w obstack.h global.c local-alloc.c
# 1) obstack.h: gcc>=5 rejects cast-as-lvalue. Rewrite the 6 macros that do
#    `*((TYPE *)p)++ = v`  ->  `(*(TYPE *)p = v, p += sizeof (TYPE))`
#    (lines ~421, ~429, ~432, ~433, ~540, ~541).  The un-cast `*((h)->next_free)++` forms are fine.
# 2) configure MUST override CC: gcc 15 defaults to C23 and rejects K&R implicit int.
cd ../../gccbuild && CC="gcc -std=gnu89 -w"   ../gccsrc/gcc-2.8.1/configure --target=mipsel-unknown-elf      --host=i686-pc-mingw32 --build=i686-pc-mingw32 --prefix=<anything>
mingw32-make CC="gcc -std=gnu89 -w" CFLAGS="-O1 -w -std=gnu89" LANGUAGES="c" cc1
```
Gotchas already paid for:
* **WSL is NOT installed** on this machine (`wsl.exe -l -v` lists nothing). The host compiler is
  MinGW-W64 **gcc 15.2.0** at `…/WinGet/Packages/BrechtSanders.WinLibs…/mingw64/bin`.
  `mingw32-make` from the same package works; msys64 has no `usr/bin/gcc`.
* cc1 needs `TMPDIR`/`TMP`/`TEMP` set to a **Windows-style path with a trailing backslash**, or it
  dies with `\/ctaNNNNN: No such file or directory` and writes EMPTY dump files.
* a new `static` helper in `global.c` needs a `PROTO` forward declaration above its first use
  (K&R implicit decl → "static follows non-static").
* 🔴 **cc1 names its dump files after the INPUT path.** Pointing a probe compiler at a shared
  `.i` **overwrites/empties that TU's `.greg`/`.lreg`** — it silently clobbered
  `scratch/rtl_a5/memcard.i.*` here. Always copy the `.i` into your own scratch dir first.

### Next steps if the lane is resumed
1. `LANGUAGES="c c++"` + `make cc1plus` for the C++ lane (same overrides).
2. Reconfigure with `--target=mipsel-unknown-ecoff` to match PsyQ's ECOFF target macros and
   re-diff against CC1PSX — that closes most of the 11 differing functions and would upgrade the
   build from laboratory to near-oracle.
3. Trace points worth adding next: `local-alloc.c find_free_reg` (which window blocked which
   register), `loop.c` movable verdicts (the `-dL` budget state), `reload1.c:6277/7362` (the
   silent re-homes that are this model's only unexplained residual).
