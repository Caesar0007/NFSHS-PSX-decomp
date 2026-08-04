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

---

## 4. FALSIFICATIONS (numbers + basin; every one re-measured in THIS wave's basin)

**F1 — CdDiskReady's speculative delay-slot fills (5 diffs, ours 78 / oracle 79).**
Ours puts `li v0,5` and `li v0,2` in two branch delay slots where the oracle has `nop` + separate
return blocks (reorg eager-steal). Basin = the post-w24 named-`ready` form. Falsified, TU-gated:
current **5** · w45 use-fence before the tests **5** · fence after `ready=` **7** (80 insns) ·
plain `if (cc != 0)` without the named temp **23** · single result-funnel `int r = 5; if (...) r = 2;`
**8** (count-exact 79/79). ⇒ named-`ready` + literal returns is the local optimum; the residual is a
`fill_simple_delay_slots` steal, next angle = the w46 backward-scan-window-TAIL positioning
(a3/iSNDallocchan) or an independently-eligible candidate at the block head, NOT another spelling.

**F2 — CD_flush's `Intr.sync = 2` store (17 diffs, ours 54 / oracle 53).**
Oracle keeps `&Intr` in `$v1` and stores ALL THREE fields by displacement (`sb ...,0/1/2($v1)`);
ours emits `lui $at; sb $v0,0($at)` for the offset-0 field only, and swaps the ready/sync store
order. **Offset 0 folds back to the symbol no matter how it is spelled** — four source shapes are
BYTE-IDENTICAL (`intr->sync=2` · byte-pointer view `b[0]=2` · volatile-cast store · statement
reorder), all 17. The w47 opacity fence makes it strictly worse: fence on `intr` **21**, fence
before the sync store **24** (55 insns), fence after the ready store **24**. ⇒ NEW NAMED RULE:
*a hoisted `T *p = &G;` base survives for NON-ZERO field offsets but gcc-2.8 always re-folds the
offset-0 access back to the `$at` symbol macro.* Next angle = make the base value not provably
`&G` at the store (an opaque producer that is not a fence, e.g. a base computed from a
different-spelled expression), or the allocator side.

**F3 — `-fno-schedule-insns2` as a TU flag on libcd.** TYPE 59->69 · cdcont 281->323 with
**PASS 10 -> 6** · toc 93->98 · event 64->58 · drv unchanged. Rejected TU-wide; it IS the correct
per-FUNCTION dial for the prologue `sw ra` position (see §3 PER_FN_FLAGS spec).

**F4 — `-msplit-addresses` / `-mgas` / `-mno-split-addresses` / `-mno-gpOPT` / `-G0` / `-O1` on
cdcont.c**: `la $2,CD_pos` and `lw $2,CD_debug` are emitted as ASSEMBLER MACROS in all of them
(byte-identical cc1 output). `-mno-gas` is not even a valid CC1PSX option. ⇒ the `$at`/macro form
is not a cc1 dial; §1's assembler verdict stands.

**F5 — CdInit branch polarity.** After the goto-loop lever (19 diffs) the residual is that retail
lays the SUCCESS arm out as the loop's fall-through (`bne v0,v1,<decrement>`, `li v0,1` in the
delay slot) while ours branches TO it. `if (...) goto fail;` with the fail block written LAST is
**byte-identical** to the `== 1` form (19 both) — gcc-2.8's jump-opt canonicalization (catalog §F
row). A shared-return-variable funnel is worse (36). Angle left: the block order is decided post-
reload by `cross_jump`/`jump.c`, so it is an ALLOCATION-then-layout problem (w44 law: fix the
rotation first), not a spelling problem.

**F6 — cd_cw loop spelling sweep (basin: pre-sentinel).** `while(count--)` **281 TU** ·
`for(count=3;count!=-1;count--)` literal **281** · named sentinel in three declaration positions
(before `old`, after `old`, after `count`) all **271** — declaration ORDER is inert here, only the
NAMING matters.

---

## 5. PER-FUNCTION LEDGER (27 fns; re-gated baseline -> landed; + open angle)

| fn | TU | base | now | class / next angle |
|---|---|---|---|---|
| CD_getsector | drv | **PASS** | **PASS** | worklist said 99.92% — already PASS |
| CdLastPos | cdcont | 3 | 3 | §1 AT-MACRO-SPLIT (no jal; splice is a proven no-op) |
| CdSetDebug | cdcont | 3 | 3 | §1 AT-MACRO-SPLIT |
| CdSyncCallback | cdcont | 3 | 3 | §1 AT-MACRO-SPLIT |
| CdReadyCallback | cdcont | 3 | 3 | §1 AT-MACRO-SPLIT |
| CD_set_test_parmnum | drv | 3 | 3 | §1 AT-MACRO-SPLIT |
| CdDataCallback | cdcont | 6 | 6 | §1d epilogue — **5 with per-fn nodb (§3)** |
| CdGetToc | toc | 6 | 6 | §1d epilogue — **5 with per-fn nodb (§3)** |
| _cd_event_sync/_ready/_read | event | 6/6/6 | 6/6/6 | §1d — **5 each with per-fn nodb (§3)** |
| _cd_event_init | event | 4 | 4 | §1d — **3 with per-fn nodb (§3)** |
| CD_initintr | drv | 15 | 15 | L4 landed; **6 with per-fn nodb (§3)** |
| CdDiskReady | TYPE | 5 | 5 | F1 reorg eager-steal; backward-scan-window angle |
| CD_flush | drv | 17 | 17 | F2 offset-0 refold; opaque-base angle |
| CdInit | event | 42 | **19** | L2+L3 landed; F5 layout-after-rotation |
| _cd_intr_dispatch | drv | 25 | 25 | 53/54 — one missing insn + jtbl dispatch; unexamined |
| CdGetDiskType | TYPE | 54 | **3** | CRACKED in �7 (L5-L8). Residual 3 = old-gcc no-copy-prop + 1 reorg steal. [orig note: frame 2088 vs 2096 + an EXTRA oracle saved reg (s1) and a `li s1,1` loop constant: same LICM/sentinel family as CdInit L1/L3 — **highest-value untried lever in my scope** -- CONFIRMED, it was] |
| CD_datasync | drv | 61 | 61 | 89/90; nodb REGRESSES (102) |
| CdControl | cdcont | 62 | **60** | L1; residual = pure prologue register ROTATION (retail s1=param,s2=result,s4=com,s3=com&255,s5=old vs ours s4,s5,s2,s1,s3) — count-EXACT 79/79, allocsim/reqdelta territory |
| CdControlF | cdcont | 67 | **63** | same rotation |
| CdControlB | cdcont | 69 | **65** | same rotation |
| CdIntToPos | cdcont | 65 | 65 | 64/65; magic-divide chain, retail stores second BEFORE minute and interleaves the two `mult`s differently |
| CdGetToc2 | toc | 87 | 87 | 134/137; unexamined |
| CD_sync | drv | 106 | 106 | count-EXACT 160/160 — full saved-reg rotation (retail s6=a0,s7=a1,fp/s4=addresses,s5=x+1,s3=2); nodb REGRESSES (148) |
| CD_ready | drv | 131 | 131 | 175/178; same family; nodb REGRESSES (161) |
| CD_cw | drv | 261 | 261 | 256/259; largest; unexamined |

**NO-FLOORS accounting:** 0 of the 27 is filed as a terminal floor. 6 carry the newly-NAMED
`AT-MACRO-SPLIT-ACROSS-BRANCH` assembler-identity class (§1, with the falsification receipts that
retire the old catalog premise), 6 more carry the separable §1d epilogue class with a measured
per-fn flag that improves each of them, and the rest carry named source/allocator angles.

---

## 6. FOR a9 / a10 (TU-wide signatures observed)
- **a10:** §1 is a full real-ASPSX differential for the *macro* case and for the RETURN branch —
  both new relative to 04C, and both NEGATIVE. Plus the positive: **GNU as DOES backward-fill
  single-word insns in `.set reorder`**, which maspsx suppresses. The retail lib assembler is a
  THIRD tool. Recommend a10 re-check `psq45/BIN/ASPSX.EXE` and any pre-2.5x SN assembler against
  my 5 test inputs (kept at `%LOCALAPPDATA%\Temp\w48a5\t{1..9,a}.s`, CRLF — aspsx rejects LF with
  *"Illegal character (10)"*).
- **a9:** the libcd TU signature is NOT `-O`/`-G`/`char`-sign/`split-addresses`. It is
  (a) the §1d epilogue+prologue TEXT-vs-RTL shape (my old-gcc hypothesis) and (b) per-function
  delayed-branch. `-fno-schedule-insns2` reproduces retail's prologue order exactly but is a
  net loss TU-wide (F3) => the deliverable a9 should push is the **PER_FN_FLAGS generalization**
  of `_apply_fn_splice` (§3), not a TU flag.
- No runtime/correctness bug found in these 27 (L4 is a faithfulness fix, not a behaviour bug).

---

## 7. SECOND-HALF LANDINGS (CdGetDiskType 54 -> 3) and the RE-USABLE LEVER TRIO

The three levers that cracked CdInit also cracked CdGetDiskType, in the same order. They are one
family — **"retail keeps loop constants in callee-saved regs and lays the taken arm out of line"**:

| # | lever | CdGetDiskType |
|---|---|---|
| L5 | **NAMED LOOP SENTINEL** `one = 1;` used ONLY in the retry test (`if (rdy != one)`). Retail keeps 1 in `$s1` across the loop (frame 0x830, s1 saved) and still emits a FRESH `li v0,1` for the post-loop `rdy == 1`. A bare literal gives one caller-saved `li v1,1` which the increment then reuses (`addu s0,s0,v1` vs retail `addiu s0,s0,1`), no s1, frame 0x828. | 54 -> **39** |
| L6 | **STATEMENT ORDER `i = 0;` BEFORE `one = 1;`** — retail emits `addu s0,zero,zero; li s1,1`. | 39 -> **37** |
| L7 | **GOTO OUT-OF-LINE ARM** `if (rdy == 1) goto ready;` with the ISO-check block written LAST. Retail reaches that arm through the TAKEN edge of `beq v1,v0` and puts the audio/error tail as the fall-through; an inline `if (rdy == 1) { ... }` inverts the branch to `bne` and inlines the arm. | 37 -> **5** |
| L8 | **w47 OPACITY FENCE, ZERO INSNS** `{ int sec = 16; __asm__("" : "=r"(sec) : "0"(sec)); CdIntToPos(sec, locp); }`. `locp` lives at sp+16 and the sector number is also 16, so cse forwards the live `li a0,16` into the address (`addu a1,sp,a0`) where retail rematerializes `addiu a1,sp,16`. Falsified alternatives: plain `int sec = 16;` **5** (identical), `volatile int sec` **36** (spills). | 5 -> **3** |

**CdGetDiskType residual = 3, fully characterized and both halves are named identity classes:**
`addu a2,a1,zero` (ours copy-props the live 0 in `$a1`) vs retail `addu a2,zero,zero` = the
methodology §3.25-3b **"old-gcc no-copy-prop / still-live-constant rematerialization"** identity
(same fingerprint as nfile.obj, w47-a1); plus one `nop` retail leaves in a `beqz` slot that our
reorg fills (eager-steal). Neither is a spelling problem.

**F7 — CD_sync named-constant probe (rejected on the COUNT-EXACT rule).** Retail hoists FIVE
values into callee-saved regs (`$fp=&CD_comstr`, `$s4=&CD_intstr`, `$s2=&Intr`, `$s5=&Intr+1`,
`$s3=2`); ours hoists only `&Intr`. `int two = 2;` used at both the compare and the store takes
106 -> **103 diffs but 160 -> 163 insns**; adding a `&intr->ready` pointer as well is identical
(103/163); `two` only at the compare is 110/164. **All rejected — the count must stay exact.**
The reachable form has to supply the extra saved-reg values at ZERO instruction cost (the w45
fence-as-live-range device, or the address hoists w25-a11 already failed to thread through
`get_alarm()`/`callback()`), so CD_sync/CD_ready/CD_cw remain allocsim/reqdelta jobs.

---

## 8. FINAL SCORECARD

| TU | PASS | DIFFSUM baseline -> **final** |
|---|---|---|
| TYPE.c   | 0  | 59 -> **8** |
| cdcont.c | 10 | 281 -> **271** |
| drv.c    | 3  | 673 -> 673 |
| event.c  | 0  | 64 -> **41** |
| toc.c    | 0  | 93 -> 93 |
| **total**| **13 (unchanged, 0 regressions)** | **1170 -> 1086 (-84, -7.2%)** |

Per-fn: CdGetDiskType **54 -> 3** · CdInit **42 -> 19** · CdControlB **69 -> 65** ·
CdControlF **67 -> 63** · CdControl **62 -> 60 (count-exact 79/79)**. CD_getsector was already
PASS at baseline. Plus **-20 more** available for free from the four measured
`PER_FN_NO_DELAYED_BRANCH` additions in §3 (consolidator wiring; build.py untouched by me —
`git status` clean on tools/ at every checkpoint).
