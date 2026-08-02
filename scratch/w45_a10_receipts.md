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

### 🔴 SECOND MODEL BOUNDARY — **local_alloc vs global_alloc**
`allocno_compare` and the whole `floor_log2` REF-STEP family govern **GLOBAL allocnos only**.
A pseudo the `.lreg` tags `in block N` is a **local_alloc QTY**, decided earlier by
`local-alloc.c qty_compare_1` (**longer-lived first; ties → LATER-BORN wins**) and it is
**absent from the `.greg` allocate list**. Check this FIRST — three of the five survivors
below are in the local domain, where the ref-step dial measures nothing.

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

### 🔴 RECEIPT: **THE ALLOCNO INSTRUMENT DOES NOT APPLY TO THIS FUNCTION.**
`FontUpsideDownBlit`'s `.greg` section has **NO `;; N regs to allocate:` line at all** — it
jumps straight from the function header to `;; Register dispositions:`. **Zero global
allocnos. Every one of its 49 pseudos is a `local_alloc` QTY.**

⇒ `allocno_compare`, the `floor_log2` REF-STEP family, `CALLER_SAVE_PROFITABLE`, and
`regs_someone_prefers` are all **structurally incapable** of moving anything in this function.
Any receipt or angle phrased in those terms is void here.

The governing rule instead (`local-alloc.c`, `qty_compare_1`):
> quantities are ordered by **`qty_death - qty_birth` (LONGER-LIVED FIRST)**, ties broken by
> **qty number, LATER-BORN winning**; the first qty takes the lowest free reg of its class.

⇒ the only dials are **BIRTH POSITION** (= statement position of the first def) and
**LIVE SPAN** (first def → last use), exactly the w43 `ascii2sjis` / w44 REVERSE-BIRTH-ORDER
family. This is also why a1's ~14 falsified *spellings* measured nothing and why `stmtclimb`
(statement position) moved it 68→50: **statement position is the ONLY dial this function has.**
Recommendation: keep hill-climbing positions (`tools/stmtclimb.py`) with a def-use audit, and
treat any spelling family as basin-relative.

---

## 4. DrawW_DrawQuad (a6) — draww.cpp, gate 100, **count-exact 592/592**

The residual is one clean **4-cycle register rotation** plus a `j`-delay-slot/block-order item:

| value | ours | retail |
|---|---|---|
| `lui …,8064; ori …,4` = scratchpad `0x1F800004` | **$t1** | **$t2** |
| `0x00FFFFFF` mask | **$t2** | **$a3** |
| `0xFF000000` mask | **$t0** | **$t1** |
| `lui …,8064; lw …,0(…)` (scratchpad read base) | **$a3** | **$t0** |
| the loaded-value trio (`lw 68/76/72(sp)` → `sw 20/32/44(s1)`) | v0,v1,a0 | v1,a0,a1 |
| `addiu s1,s0,272` | before the branch | **in the `j` delay slot** |

### 🔴 RECEIPT: **ALSO NOT AN `allocno_compare` PROBLEM.**
Every pseudo in that rotation is a **`local_alloc` QTY**, not a global allocno:
```
$t0 <- p172(local, blk0)  p205  p207  p322(blk30)  p460(blk57)
$t1 <- p127(local, blk0)  p318(blk30)  p471(blk57)
$t2 <- p164(GLOBAL, 20refs/44live)      p329(blk30)
$a3 <- p173(local, blk0)  p194  p196  p317(blk30)  p464(blk57)
```
Only `$t2`'s p164 is global; the other three legs are block-local. A ref-step edit on p164
alone cannot rotate a 4-cycle whose other three members `local_alloc` already placed **before
`global_alloc` ever ran**.

⇒ **the dial is `qty_compare_1` LIFE + BIRTH ORDER inside block 0** (and blocks 30/57, which
carry the same rotation — one fix should land all three). Concretely: the four constants'
**first-def statement positions** decide the handout; the value retail puts in the *earlier*
register is the one whose qty is *longer-lived* (or, at equal life, *later-born*).
Measured block-0 lives: p127=68, p172=52, p173=33, p164=44(global).
Retail's order implies the `0x1F800004` qty must sort **after** p164, and the `0x00FFFFFF`
qty must fall out of the t-band into `$a3` — i.e. **shorten `0x00FFFFFF`'s life and lengthen
`0xFF000000`'s**, the same *addr24-EARLY* pair-splitting lever that worked on
DrawGouraudShape's inverted hoist set (w44), applied to LIFE rather than LICM savings.

**a6 ↔ a8 depth-2 reconciliation: CONFIRMED as a shared mechanism** — both are local-alloc
qty ties, not find_reg cost-pass boundaries. The w41 "find_reg cost pass is a model boundary"
verdict was formed on the wrong model: these pseudos never reach `find_reg`.

---

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
