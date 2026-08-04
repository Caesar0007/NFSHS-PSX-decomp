# WAVE-48 a5 receipts — syslib/libcd part A (cdcont 9 / drv 9 / event 5 / TYPE 2 / toc 2 = 27 fns)

Worktree `C:/Temp/nfs4-wt48-a5`, branch `w48-a5`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>`; whole-TU helper `scratch/w48_a5_tugate.py`.

## 0. RE-GATED BASELINE (2026-08-04) — worklist fuzzy% ignored per standing rule

| TU | PASS | FAIL | DIFFSUM |
|---|---|---|---|
| TYPE.c   | 0  | 2 | 59  |
| cdcont.c | 10 | 9 | 281 |
| drv.c    | 3  | 9 | 673 |
| event.c  | 0  | 5 | 64  |
| toc.c    | 0  | 2 | 93  |
| **total**| 13 | 27| 1170|

Per-fn baseline (my 27): CdDiskReady 5 · CdGetDiskType 54 · CdLastPos 3 · CdSetDebug 3 ·
CdSyncCallback 3 · CdReadyCallback 3 · CdControl 62 · CdControlF 67 · CdControlB 69 ·
CdDataCallback 6 · CdIntToPos 65 · CD_sync 106 · CD_ready 131 · CD_cw 261 · CD_flush 17 ·
CD_initintr 15 · CD_datasync 61 · **CD_getsector = ALREADY PASS** (worklist said 99.92%) ·
CD_set_test_parmnum 3 · _cd_intr_dispatch 25 · CdInit 42 · _cd_event_init 4 ·
_cd_event_sync/_ready/_read 6 each · CdGetToc 6 · CdGetToc2 87.

Worklist-fuzzy% wrong again: CD_getsector listed 99.92% is a PASS; CdInit listed 0.00% is 42 diffs
at 40-vs-36 insns (not "no match"); CdLastPos listed 46.67% is a 3-diff single-instruction shift.

---

## 1. 🔴🔴 THE HEADLINE: REAL-ASSEMBLER DIFFERENTIAL — the libcd "delay-slot" floor class is
## NOT aspsx, NOT GNU as, and NOT reachable from our cc1 (extends the 04C law)

12 of my 27 functions have residuals that consist ONLY of delay-slot placement. I ran the
differential myself (three assemblers, five inputs) instead of quoting the catalog's premise.

### 1a. The retail shape that has to be explained
```
CdSetDebug (oracle)              CD_initintr (oracle)             CdLastPos (oracle)
  lui  $v0,%hi(CD_debug)           lui $at,%hi(CD_status)           lui   $v0,%hi(CD_pos)
  lw   $v0,%lo(CD_debug)($v0)      jal ResetCallback                jr    $ra
  lui  $at,%hi(CD_debug)   <====    sw $zero,%lo(CD_status)($at)     addiu $v0,$v0,%lo(CD_pos)
  jr   $ra                                  ^^^^ macro 2nd half in the slot,
   sw  $a0,%lo(CD_debug)($at)               ^^^^ macro 1st half HOISTED ABOVE the branch
```
`$at`/`$1` is FIXED in gcc (never allocated) => those `lui $at` words are an ASSEMBLER macro
expansion. So retail's assembler moved a macro's second word into a branch delay slot and left
its `lui $at` in front of the branch.

### 1b. What each on-disk assembler actually does (my runs, `%LOCALAPPDATA%\Temp\w48a5\t*.s`)
| input (`.set reorder`, default) | ASPSX 2.77 (`C:/Temp/psq43/PSSN/ASPSX.EXE`) | GNU as (our maspsx backend) |
|---|---|---|
| `la $2,SYM` ; `j $31`                | `lui;addiu;jr;nop` (4) — NO split | `lui;addiu;jr;nop` (4) — NO split |
| `lw $2,S`;`sw $4,S`;`j $31`          | `lui;lw;lui;sw;jr;nop` (6) — NO fill | same (6) — NO fill |
| `sw $0,S` ; `jal F` ; `lui $5,4`     | `lui;sw;jal;nop;lui` — NO backward fill | (same class) |
| `addiu $5,$0,4`;`jal F`;`addiu $6,$0,7`;`jr $31` | `addiu;jal;NOP;addiu;jr;NOP` (6) — **NO fill** | `jal;addiu(slot);jr;addiu(slot)` (4) — **FILLS** |
| macro forced INTO a `.set noreorder` slot | warns *"Multi-word instruction cannot fit into delay slot"*, expands BOTH words AFTER the branch | warns, expands BOTH words AFTER the branch |

**Three verdicts, all new:**
1. **ASPSX 2.77 does no delay-slot filling AT ALL** — not backward, not for `jal`, not for
   `jr $31`, in `.set reorder` or with no `.set` at all. (Independent 3rd confirmation of 04C,
   now extended to the RETURN branch and to macro operands.)
2. **GNU as DOES backward-fill in `.set reorder` mode for single-word instructions** (proven:
   4-insn fully-filled output above) — but **never splits a macro**. maspsx forces
   `.set noreorder` on every function, so this capability is dead in our pipeline (the w25-a9
   note in build.py said this; it is now measured, both directions).
3. **NO assembler on disk hoists a macro's `lui` above the branch.** Retail's form is therefore
   produced by neither `aspsx 2.5x-2.79` nor GNU as, and cannot come from our cc1 either
   (`$at` is fixed, and `-mgas`/`-msplit-addresses`/`-mno-split-addresses` do NOT change
   `la $2,CD_pos` / `sw $4,CD_debug` into split form — probed, all three byte-identical).

### 1c. Consequence — a NAMED class, and the correction it forces
**Class name: `AT-MACRO-SPLIT-ACROSS-BRANCH` (Sony PsyQ library objects).**
Catalog row §F "maspsx-reorder-branch-slot FLOOR" says *"aspsx-2.77 instead fills the slot by
SPLITTING the load macro"* — **that premise is now FALSIFIED by direct measurement** (row 1 and
row 4 of the table). The 04C law's conclusion for this class must therefore be re-read: it is NOT
"compiler-side after all", it is **a third toolchain** (a pre-PsyQ-4.x SN assembler, or Sony's own
MIPS `as`, neither on disk). This is an ASSEMBLER-IDENTITY finding for a10, not a cc1 flag.
Spec (do NOT implement): maspsx would need a `--fill-branch-slots` pass that (a) moves the
preceding single-word instruction into an empty branch/jal slot and (b) when that instruction is
an `$at` address macro, emits the `lui $at` BEFORE the branch and the `%lo` half in the slot.
Members in my scope: CdLastPos, CdSetDebug, CdSyncCallback, CdReadyCallback, CD_set_test_parmnum
(3 diffs each, no jal), CD_initintr (the `jal ResetCallback` slot).

### 1d. The SECOND, separable sub-class: the EPILOGUE (this one IS compiler-side and dial-able)
ours `lw ra; nop; jr ra; addiu sp` vs oracle `lw ra; addiu sp; jr ra; nop` — count-exact, 2 diffs.
Root cause read off gcc-2.8.1 `config/mips/mips.c:mips_expand_epilogue` (lines 5614-5661): the
stack-restore is **real RTL** (`gen_blockage(); gen_addsi3(sp,sp,tsize); gen_return_internal()`),
so `dbr_schedule` fills the return's slot with it. `-fno-delayed-branch` suppresses exactly that
(measured: cc1 then emits `lw $31; addu $sp; j $31` in reorder mode = the oracle epilogue).
Retail wants dbr ON for the `jal` slots and OFF for the return slot — a per-branch split no gcc
flag expresses. **Hypothesis for a9/a10 (new): the PsyQ lib objects were built by an OLDER gcc
whose MIPS prologue/epilogue were emitted as TEXT by `function_prologue`/`function_epilogue`
(gcc <= 2.7.x) rather than as RTL** — that single fact explains BOTH the unfilled return slot AND
the oracle's prologue order (`subu sp; sw ra` always adjacent at the top, before any body insn;
ours lets sched2 float a body `move` between them — `-fno-schedule-insns2` reproduces exactly that
order, probed).

---

## 2. LANDED LEVERS (source-side, all whole-TU gated, ZERO regressions)

| # | lever | fn(s) | before -> after |
|---|---|---|---|
| L1 | **NAMED UP-FRONT `-1` SENTINEL** in the inlined `cd_cw` retry loop (`int sentinel = -1; for (count = 3; count != sentinel; count--)` instead of `int count = 4; while (count--)`). Retail materializes the loop sentinel ONCE in a callee-saved reg (`li fp,-1` ... `bne s0,fp`) AND still emits a FRESH `li s7,-1` for the exhaustion return; a bare literal lets gcc CSE both into one caller-saved `li v0,-1` + `addu s7,v0,zero`. | CdControl / CdControlF / CdControlB | 62 -> **60 (count-EXACT 79/79)**, 67 -> 63, 69 -> 65 |
| L2 | **`__attribute__((section(".bss")))`** on event.c's two OWNED 4-byte globals `CD_cbread` / `CD_read_dma_mode` (catalog §I-addendum section lever; single-access precondition holds — each is written exactly once in CdInit). An initialised `= 0` definition puts them in `.sdata` under -G4 and maspsx emits the 1-insn gp-relative store; retail uses `lui $at,%hi; sw ...%lo($at)`. | CdInit | 42 -> 36 |
| L3 | **LABEL-GOTO LOOP** in CdInit. Every natural loop form hoists the comparison constants `1`/`-1` and the printf string address into s1/s2/s3 (frame 0x28, 5 saved regs); retail rematerializes them per-iteration (frame 0x18, only s0+ra). Measured basin: do-while **36** / while-top **53** / for **53** / continue-arm **53** / **goto 19**. | CdInit | 36 -> **19** (ours 35 / oracle 36) |
| L4 | **DROP the spurious `return 0;`** from CD_initintr — the oracle sets up no `$v0` at all (§3.2 read-$v0-at-the-epilogue). Diff-NEUTRAL (the `addu v0,zero,zero` was filling the `lw ra` load-delay slot, replaced by a nop) but it is the faithful reconstruction and it is what makes the -fno-delayed-branch splice below reach 6. | CD_initintr | 15 -> 15 (semantic fix) |

**Whole-TU gate, landed tree (vs re-gated baseline):**
| TU | PASS | DIFFSUM before -> after |
|---|---|---|
| TYPE.c   | 0  | 59 -> 59 |
| cdcont.c | 10 | 281 -> **271** |
| drv.c    | 3  | 673 -> 673 |
| event.c  | 0  | 64 -> **41** |
| toc.c    | 0  | 93 -> 93 |
| **total**| 13 | 1170 -> **1137** (-33), 0 PASS regressions |

---

## 3. MEASURED FLAG RECOMMENDATIONS FOR THE CONSOLIDATOR (build.py is report-only for me)

All four re-measured **in the final landed basin**, each probed in isolation with a whole-TU gate
and `git checkout -- tools/build.py` in a `finally`. **Zero regressions in every case.**
Add to `PER_FN_NO_DELAYED_BRANCH`:

| TU | function(s) to add | fn delta | TU DIFFSUM delta |
|---|---|---|---|
| `recon/syslib/psx/libcd/drv.c` (NEW key) | `CD_initintr` | **15 -> 6** | 673 -> 664 |
| `recon/syslib/psx/libcd/event.c` (NEW key) | `_cd_event_init`, `_cd_event_sync`, `_cd_event_ready`, `_cd_event_read` | 4->3, 6->5, 6->5, 6->5 | 41 -> 37 |
| `recon/syslib/psx/libcd/toc.c` (NEW key) | `CdGetToc` | 6 -> 5 | 93 -> 92 |
| `recon/syslib/psx/libcd/cdcont.c` (**APPEND to the EXISTING key** — do NOT add a second dict entry, 04G duplicate-key hazard) | `CdDataCallback` | 6 -> 5 | 271 -> 270 |

Net if all four are wired: **-20 further diffs, 0 regressions** (tree 1137 -> 1117).
⚠️ `CD_initintr` gains 9 only WITH lever L4 landed (they are coupled).
⚠️ Do NOT splice the rest of drv.c: measured together they REGRESS badly — CD_sync 106->148,
CD_ready 131->161, CD_datasync 61->102, `_cd_intr_dispatch` 25->33, CD_flush 17->18.
⚠️ Do NOT splice `CdInit` (event.c): 19 -> 46.
⚠️ w25-a3's note in build.py that CdLastPos/CdSetDebug/CdSyncCallback/CdReadyCallback are
splice-no-ops is **re-confirmed** (§1 explains why: no jal, nothing for dbr to move).

**`-fno-schedule-insns2` is NOT a TU flag for libcd** (probed TU-wide on all 5):
TYPE 59->69, cdcont 281->323 and **PASS 10 -> 6**, toc 93->98, event 64->58, drv unchanged.
It *is* the right per-FUNCTION dial for the prologue `sw ra` position (it reproduces retail's
`subu sp; sw ra; move a1,a0` order exactly on CdDataCallback) — but the splice mechanism only
supports `-fno-delayed-branch`. **SPEC for a9/the consolidator: generalize `_apply_fn_splice`
from a fixed flag to a per-function FLAG LIST** (`PER_FN_FLAGS = {tu: {fn: [flags]}}`); the
machinery (dual compile, `.ent/.end` region extract, local-label uniquify) is already there and
flag-agnostic. That would make the prologue-order dial reachable for the whole syslib class.
