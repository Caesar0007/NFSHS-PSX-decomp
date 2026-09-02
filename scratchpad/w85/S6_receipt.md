# W85-S6 receipt — device purity, syslib/psx (libcd / libetc / libgpu SYS / libpad / libpress)

Gate command used for every number below (whole-TU, authoritative):

```
python tools/tugate.py <file>
```

plus `python tools/verify_asm.py <file> <fn>` / `python tools/vdiff.py <file> <fn>`
for the per-instruction read, `python scratchpad/w85/s6_frame.py <file> <fn>` for
the `.frame`/`vars=` read, and `python tools/reqdelta272.py <file> <fn>` for the
allocno table.

Harnesses written for this wave (scratchpad only — **no `tools/*.py` was touched,
no git command was run**):

| script | what it does |
|---|---|
| `scratchpad/w85/s6_sweep.py` | delete ONE `__asm__("" …)` statement → re-gate the whole TU → restore; `--apply` commits a set after a confirming gate |
| `scratchpad/w85/s6_volsweep.py` | remove ONE `volatile` qualifier (code lines only, skipping comments and `0x1F80xxxx` MMIO lines) → re-gate → restore |
| `scratchpad/w85/s6_try.py` | apply a JSON list of substring edits per named cell → gate → restore (the workhorse for shape cells) |
| `scratchpad/w85/s6_frame.py` | print a function's `.frame` line from the compiled `.s` |
| `scratchpad/w85/s6_iso_*.py` | the CdSearchFile variant generators |

---

## 0. BASELINE (measured first, before touching anything) and FINAL

| file | baseline | **final** |
|---|---|---|
| `recon/syslib/psx/libcd/toc.c` | 2/2 PASS | **2/2 PASS** |
| `recon/syslib/psx/libcd/cdread.c` | 6/6 PASS | **6/6 PASS** |
| `recon/syslib/psx/libcd/drv.c` | 14/14 PASS | **14/14 PASS** |
| `recon/syslib/psx/libcd/cdcont.c` | 19/19 PASS | **19/19 PASS** |
| `recon/syslib/psx/libcd/iso9660.c` | 6/6 PASS | **6/6 PASS** |
| `recon/syslib/psx/libcd/event.c` | 5/5 PASS | **5/5 PASS** |
| `recon/syslib/psx/libetc/INTR.c` | 13/13 PASS | **13/13 PASS** |
| `recon/syslib/psx/libetc/INTR_DMA.c` | 4/4 PASS | **4/4 PASS** |
| `recon/syslib/psx/libetc/INTR_VB.c` | 4/4 PASS | **4/4 PASS** |
| `recon/syslib/psx/libetc/VSYNC.c` | 2/2 PASS | **2/2 PASS** |
| `recon/syslib/psx/libetc/VMODE.c` | 2/2 PASS | **2/2 PASS** |
| `recon/syslib/psx/libgpu/SYS.c` | 44/44 PASS | **44/44 PASS** |
| `recon/syslib/psx/libpad/PADCMD.c` | 19/19 PASS | **19/19 PASS** |
| `recon/syslib/psx/libpad/PADMAIN.c` | 11/11 PASS | **11/11 PASS** |
| `recon/syslib/psx/libpad/PADPORTD.c` | 8/8 PASS | **8/8 PASS** |
| `recon/syslib/psx/libpad/PADSEQD.c` | 5/5 PASS | **5/5 PASS** |
| `recon/syslib/psx/libpress/VLC.c` | 2/2 PASS | **2/2 PASS** |

**167/167 functions PASS at baseline and 167/167 PASS at the end — ZERO broken
PASS.** Every file left in its best-gated state.

### PIN CENSUS (assigned set)

My first pass used `register[^;]*asm\("\$` and reported 0; that pattern **misses
the `__asm__` spelling**, so it was redone with
`register[^;/]*(__)?asm(__)?\s*\(\s*"\$`. Real total: **3 pins, all in
`recon/syslib/psx/libetc/INTR.c`**:

| site | pin | function |
|---|---|---|
| `INTR.c:620` | `register unsigned short en __asm__("$3")` | `_intrhand` |
| `INTR.c:622` | `register volatile unsigned short *mp __asm__("$2")` | `_intrhand` |
| `INTR.c:940` | `register intrEnv_t *c2 __asm__("$6")` | `_set_intr_callback` |

(`toc.c:56`, `stcdint.c:474/726/730`, `drv.c:18/592/1442/1676/1828` etc. are pin
strings inside COMMENTS — records of Rage Racer pins this project deliberately
does NOT carry. `stcdint.c` is another agent's file.)

All three were attacked (§4 below); all three currently REMAIN, restored verbatim,
with the pin-free floors measured and the new mechanism numbers banked.

---

## 1. EXHAUSTIVE ONE-AT-A-TIME `__asm__("")` REMOVAL SWEEP (all 17 TUs)

Every standalone empty-template asm statement in the assigned set was deleted in
isolation and the whole TU re-gated (95 sites, plus one `__asm__ volatile ("")`
found by the volatile sweep). Result: **6 sites were inert and are now DELETED**;
every other one costs exactly one PASS function.

### REMOVED (6 devices, each re-gated to full PASS)

| file | line | device | gate after |
|---|---|---|---|
| `libcd/iso9660.c` | 317 | `__asm__("" : : "r"(sep2));` — "keep it a distinct pseudo" | 6/6 PASS |
| `libcd/cdread.c` | 770 | `__asm__("" : : "i"(0));` | 6/6 PASS |
| `libcd/cdread.c` | 786 | `__asm__("" : : "i"(0));` | 6/6 PASS |
| `libcd/cdread.c` | 797 | `__asm__("" : : "i"(0));` | 6/6 PASS |
| `libcd/cdread.c` | 1054 | `__asm__("" : : "r"(sel));` — W61-A7 "+1 ref dial" | 6/6 PASS |
| `libpad/PADCMD.c` | 842 | `__asm__ volatile ("");` — "keeps the shared epilogue" | 19/19 PASS |

All six were **stale**: later structural work in the same TU moved the basin out
from under them (methodology 21E-1 "re-price a documented-exhausted cluster after
ANY sibling cluster in the same fn changes basin"). Counts:
`cdread.c` 24 → 20 devices, `iso9660.c` 3 → 2, `PADCMD.c` 11 → 10.

### LOAD-BEARING (each removal costs a PASS; restored verbatim)

`toc.c` 221,232 · `cdcont.c` 191,194,249,258,307,319 · `cdread.c`
138,311,332,364,366,370,372,427,477,762,791,800,824,826,828,1033,1070,1086,1117,1178 ·
`drv.c` 454,493,519,545,836,837,1042,1132,1138,1186,1189,1294,1296,1422,1427,1430 ·
`event.c` 92 · `iso9660.c` 234,471 · `INTR.c` 215,625,941,974,1005 ·
`SYS.c` 641,868,950,1049,1058,1394,1398,1639,1754,1770,1799,1849,1863,1876,1890 ·
`PADCMD.c` 237,247,535,575,623,749,793,794,795,802 · `PADMAIN.c`
128,214,542,606,614,646,770 · `PADPORTD.c` 127,417,426,450,597,848,862 ·
`PADSEQD.c` 402,520.

`INTR_DMA.c`, `INTR_VB.c`, `VSYNC.c`, `VMODE.c`, `VLC.c` carry **no** empty-asm
devices at all.

---

## 2. VOLATILE AUDIT

Every non-comment, non-`0x1F80xxxx` `volatile` in the assigned set was removed one
at a time and the TU re-gated (≈100 sites). Classification below.

### 2a. REMOVED — 9 plain-state volatile qualifiers (all re-gated full PASS)

| file | site | was | now |
|---|---|---|---|
| `libpad/PADCMD.c` 117 | `(*(unsigned char * volatile *)(info+0x3c))[3]` | volatile ptr read | plain |
| `libpad/PADCMD.c` 118 | `…[4]` | volatile ptr read | plain |
| `libpad/PADCMD.c` 121 | `…[6]` | volatile ptr read | plain |
| `libpad/PADCMD.c` 141 | `int acc = *(volatile int *)(info+0xec);` | was documented worth 2 diffs | plain (re-measured inert; the stale claim in the case-4 comment was corrected in place) |
| `libgpu/SYS.c` 389 | `int st0 = (int)*(volatile char *)graphState << 2;` | | plain |
| `libgpu/SYS.c` 393 | `*(volatile u_char *)(graphState+1) = 1;` | | plain |
| `libgpu/SYS.c` 395 | `st1 = (int)*(volatile char *)graphState << 2;` | | plain |
| `libgpu/SYS.c` 402 | `return *(volatile u_char *)graphState;` | | plain |
| `libgpu/SYS.c` 1999 | `volatile u_long *pbase = (volatile u_long *)(…)` (both qualifiers) | | plain |

`graphState` is a plain RAM alias of `&GEnv` — not MMIO — so these five were
genuine crutches. Subset search on the five `graphState` sites: every PAIR is free
except **{380, 389}**; the 4-subsets `A+C+D+E` and `B+C+D+E` are both free, so
exactly ONE of the store at 380 / the read at 389 must stay. Kept the STORE
(`*(volatile u_char *)graphState = graphType;`) so all the READS are plain.

`PADCMD.c` volatile lines 14 → 10; `SYS.c` 53 → 48.

### 2b. KEEP — sanctioned MMIO / IRQ-shared state (per GUIDE, and the user's "volatile is allowed in MMIO functions")

* **`libcd` `_cdr`** (`cdread.c`, 20 views + the extern decl). Stripping volatile
  from the whole TU: **6/6 → 1/6** (`_read_sync` 4, `_read_issue` 8,
  `_read_data_int` 24, `_read_int` 25, `CdRead` 32). Oracle proof of the §3.12 #13
  store→reload idiom in `asm/nonmatchings/main/_read_int.s`:
  ```
  /* F9264 80108A64 */  sw   $v0, 0x14($s0)
  /* F9268 80108A68 */  lw   $v0, 0x14($s0)     <- reload of the field just stored
  ```
  (again at `80108AF0 sw $v0,0x24($s0)` / `80108AF4 lw $v0,0x14($s0)`). SEMANTIC.
* **`libcd/drv.c` — the whole file.** `reg0..reg3/com_delay/spu/dv5_delay/d_pcr/
  d3_*` are literal `0x1F80xxxx` device pointers; `Intr` (`D_8013C224`) is the CD
  IRQ state block and is load-bearing at 7 derived sites (`CD_sync` 25,
  `CD_ready` 23/6, `CD_flush` 3, `CD_init` 7, `CD_datasync` 20, `CD_get_intr` 5/5);
  `Alarm` is load-bearing at 4 (`CD_cw` 40, `CD_ready` 44, `CD_sync` 48,
  `CD_datasync` 55). The stack response buffer `volatile u_char result[8]` /
  `volatile u_char nReg` are **the vendor's own spelling** — the byte-exact Rage
  Racer twin of this same PsyQ TU
  (`C:\Temp\rage-racer-decomp\src\main\PAL\lib\libcd\interrupt_status.c ::
  CdReadInterruptStatus`) declares `volatile u_char mode; volatile u_char buf[8];
  volatile u_char *p, *q;` — and the oracle re-reads `buf[0]` at `80107214` after
  `801071E8` with no intervening write. `nReg` costs 56 diffs, `result` 1 (the
  `andi $v0,$v0,0xFF` u_char re-mask at `8010721C`). **KEEP, whole file untouched
  — verified byte-identical to its baseline at the end of the wave.**
  (Falsified for the `result` diff: `(unsigned char)` cast on the assignment, an
  explicit `& 0xff`, a `u_char st` temp, and `(CD_status & 0xff) & 0x1d` — gcc
  range-folds every one of them because `lbu` already proves 0..255; only a QImode
  volatile pseudo mints the mask. The `volatile u_char *q` per-iteration pointer
  measured INERT, but was RESTORED: writing to a volatile object through a plain
  lvalue is a semantic regression for zero device-count gain.)
* **`libetc/INTR.c`** `i_stat` / `g_InterruptMask` / `d_pcr` (`D_80135B84/88/8C`
  hold `0x1F801070/1074/10F0`), and the `sp` / `mp` I_STAT/I_MASK anchors.
* **`libetc/INTR_DMA.c`** `g_dicr_ptr`/`g_madr_ptr` (`0x1F8010F4`/`0x1F801080`),
  **`INTR_VB.c`** `g_rcnt_ptr` (`0x1F801114`), **`VSYNC.c`** `g_vsync_gp1_ptr`
  (`0x1F801814`) / `g_vsync_t1_ptr` (`0x1F801110`) / `Vcount` / `Hcount` (the
  latter documented + measured store→reload, 6 diffs) / the `hcount`/`timer`/
  `timeout[2]` VSync poll locals (28/17/12 diffs).
* **`libpad/PADMAIN.c`** every `_padSioRegs` / `_padIntRegs` / `0x1F8011xx` timer
  access; **`PADPORTD.c`** `JOY_CTRL` and the `sio + 0x0a` store.
* **`libgpu/SYS.c`** `GPU_GP0/GP1`, `D2_*`/`D6_*`/`DMA_DPCR`, the DMA-IRQ-shared
  ring `volatile GpuQue shared[64]` (20/24 diffs) and `_qin`/`_qout` (39/27/10
  diffs) — the matched Rage Racer producer writes the same ring through volatile.

### 2c. KEEP with reason — the two genuinely non-MMIO volatiles

**(i) `libpad/PADCMD.c:120` — `info[0xe9] = (*(unsigned char * volatile *)(info+0x3c))[5];`**
The ONLY load-bearing one of the four sibling reads. The oracle RELOADS the rx
pointer (`lw $v1,60($s0)`) across the intervening `sh $zero,230($s0)` store;
without volatile provenance cse folds the reload away (ours 82 vs oracle 83).
`info+0x3c` is the libpad SIO receive-buffer pointer, i.e. real IRQ-shared pad
state, so the qualifier is defensible on semantics too. Restored with an in-code
note recording that the other three are now plain.

**(ii) `libcd/iso9660.c:313,322` — `ch = *(volatile unsigned char *)s;` in `CdSearchFile`.**
This one reads the CALLER'S PATH STRING, so it is not MMIO and was attacked hard.
Result: irreducible in this lane, and the mechanism is now measured exactly.

Removing the `volatile` leaves the **instruction stream byte-identical, 182/182** —
the only diff is the FRAME SIZE:

```
ours   .frame $sp,96,$31   # vars= 48, regs= 8/0, args= 16
oracle .frame $sp,80,$31   # vars= 32, regs= 8/0, args= 16
```

i.e. a *dead* 16-byte stack slot (nothing in the emitted code touches `$sp` 48..63);
it shifts 6 prologue `sw` + 8 epilogue `lw` + both `addiu $sp` = 36 diffs.

Bisect (each row a measured `vars=`):

| variant | vars |
|---|---|
| baseline (volatile read) | **32** |
| plain `*(unsigned char *)s` / `(unsigned char)*s` / `((unsigned char *)s)[0]` | 48 |
| drop the inner `do{}while` entirely | 32 |
| drop the in-loop read only / drop the pre-loop read only | 40 / 40 |
| drop `if (!ch) goto out;` | 32 |
| `ch` declared `int` / `unsigned int` / `unsigned short` | **32**, but the two loads then CSE to one (`lbu`+`andi`+`sll`/`sra`) = 14 diffs |
| `ch` declared `char` / `signed char` / `register unsigned char` / block-scope | 48 |

⇒ **exactly 8 bytes of dead frame per QImode (`char`-typed) local assignment that is
live across the `goto out` out of the loop** — and a QImode `ch` is precisely what
forces the oracle's two distinct loads `lb $v0,0($s0)` + `lbu $v1,0($s0)`
(`800F9120`/`800F9144`; the `lb` serves `!= sep`/`!= sep2`/`!*s`, the `lbu` serves
`!ch` and the `sb`). A wide `ch` kills the slot AND the second load together.

Falsified in this basin (all measured, all `vars=48` unless noted): `unsigned char *`
cursor with the pun moved to the signed side (36 diffs) · that + `unsigned char *q` ·
that + `unsigned char comp[0x20]` · `ch` declared before `comp` · `*q = (signed char)ch` ·
`while(1)`+`break` rotation · `char *q` · a private `brk:` label for the goto ·
braced goto · `ch == '\0'` spelling · hoisting the zero-test into the `while`
condition (vars=40) · `int ch` + `*q = (signed char)(unsigned char)ch` (vars=32 /
14 diffs) · dropping `*fp = file[i]` · dropping `_cmp` · dropping each of the four
`printf`s · `static char comp[]` (vars=16 — the phantom 16 survives `comp` leaving
the frame).

Re-entry door for a future wave: a per-TU cc1 version that does not allocate the
QImode-across-goto slot. That is a `tools/build.py` change, which this wave may not
make.

---

## 3. THE PIN ATTACKS

### 3a. `INTR.c:940` — `register intrEnv_t *c2 __asm__("$6")` in `_set_intr_callback`

Pin-free floors measured this wave (all gated, all reverted; oracle 82 insns):

| cell | diffs |
|---|---|
| **no device at all** (plain `intrEnv.enabledInterruptsMask \|= …`) | 12 @82 |
| arm-2 spelled through a `Callback *h = intrEnv.handlers;` local | 12 |
| `h` hoisted before the `if`, used in both arms | 12 |
| unpinned tied launder `asm("":"=r"(c2):"0"(ctl))` | 7 @83 (reload tie copy `move $4,$6`) |
| **unpinned UNTIED launder `asm("":"=r"(c2):"r"(ctl))`** | **6 @82 (count EXACT)** |
| untied launder moved after the handlers store | 6 |
| untied + a `slot` pointer as a 2nd input | 6 |
| `"=&r"` earlyclobber × {1,2,3,4} extra inputs | 6 |
| clobber-grid gaps not covered by W76 — `"$5"`, `"$2$3"`, `"$2$5"`, `"$3$5"`, `"$2$3$5"`, `"$2$3$5$7"` | 7 each |
| `ctl` made block-local (± in-place launder) | 28 / 28 |
| block-local `ctl` + `"$4","$5"` clobbers | 23 |
| two-output launder (slot+c2, either order) / three-output / mask+c2 | 8 / 63 / 49 |
| plain local base `intrEnv_t *c2 = &intrEnv;` (no asm) | 31 |

The residual 6 at count-exact 82 is exactly two facts: `c2` seats in `$a0`
(`lhu $v0,48($a0)`) where retail has `$a2` (`lhu $v0,48($a2)`), and the
`sw $s2,0($a0)` schedules before `li $v1,1`/`sllv` instead of after. Since $4/$5
are free at `c2`'s birth (idx→$s1, handler→$s2), the seat needs occupancy that no
zero-insn C vehicle can supply — the W76 finding stands, now with 15 more
falsified cells. **PIN RESTORED verbatim.**

### 3b. `INTR.c:620,622` — `en`/`mp` in `_intrhand`

Pin-free = **34 diffs at count-exact 116/116** (matches W76's ablation row).
NEW quantification this wave — `tools/reqdelta272.py recon/syslib/psx/libetc/INTR.c
trapIntr` on the pin-free build prints the global-allocno table:

```
 rank  pseudo  refs  live       pri  home
    0     105     9     3    9.0000  $v0
    1      74     9     6    4.5000  $v1
    2      73    17    25    2.7200  $s0
    ...
    6      82     6    10    1.2000  $a0     <- mp
    7      81     6    12    1.0000  $a1     <- en
```

Under the measured 2.7.2 rule `pri = floor_log2(refs)*refs/live`, seating `en` in
`$v1` needs it to beat rank 1 (4.5): **refs 6 → 16 (+10)**; seating `mp` in `$v0`
needs to beat rank 0 (9.0): **refs 6 → 24 (+18)** (live-length dials are
infeasible: `en` would need live 12 → 2). Ten and eighteen extra *real* references
to a two-use anchor do not exist in this function. That is the arithmetic behind
W74-A17's prose claim ("a fn-scope pseudo is a global allocno, invisible to
local-alloc's `find_free_reg` scan") and it is why the ~250 clean cells over
W60..W76 all failed. **PINS RESTORED verbatim; `INTR.c` verified byte-identical to
its baseline.**

---

## 4. OTHER FALSIFIED CELLS THIS WAVE

* **`libcd/event.c:92`** (`CdInit`, void-tail fence that denies reorg's eager-steal
  of the fail thread): fence-free 6 @36; `if (--retry != -1) goto loop;` 6;
  `if (retry-- != 0) goto loop;` 6; restructured fail block
  (`if (retry == 0) { printf; return 0; } retry--; goto loop;`) **19 @35**.
  The choice is made in reorg, after every value-level lever — W52-A2 confirmed.
  KEEP.
* **`libpad/PADSEQD.c:520`** (`_dirCheck`, identity launder that funnels the two
  arms into retail's single `jr $ra`): launder-free 5 @12 (oracle 11 — gcc splits
  the arms and duplicates `jr $ra`); `&&`-early-return 6; nested-if 6;
  goto-funnel 11; two-returns 12; ternary 10; `r=1` default 11; `r=0` default 10;
  bare boolean expression 10; goto-out-only 6; named `0xff` constant 14. Nothing
  beats the launder. KEEP.
* **`libcd/toc.c:221,232`** (`CdGetToc2`, the W64-A5 magic-reciprocal hoist + the
  `track_first` +2-ref dial): each removal costs the function. The two fences are
  ref-count dials priced by `reqdelta272` in W61/W64; no source construct adds an
  RTL reference without also adding an instruction, so they stand. KEEP.

---

## 5. NET RESULT

* **6** empty-asm devices deleted, **9** plain-state `volatile` qualifiers deleted.
* **0** functions regressed: 167/167 PASS before, 167/167 PASS after.
* **0** new devices of any kind introduced; no post-compile moves added or removed;
  no `tools/`, `regiondiff/tools/`, MANIFEST/PROGRESS, `.github/`, toolchain or
  memory files touched; no git operation run.
* Two files were probed and then verified **byte-identical to their baseline**
  (`libcd/drv.c`, `libetc/INTR.c`), as were `libcd/event.c` and
  `libpad/PADSEQD.c`.
* Remaining device census in the assigned set: 89 empty-asm sites, 3 register
  pins (all `INTR.c`), 2 non-MMIO volatiles (`iso9660.c` ×2 sites of one idiom,
  `PADCMD.c` ×1) — every one of them re-measured this wave and receipted above
  with its pin-free/volatile-free floor.
