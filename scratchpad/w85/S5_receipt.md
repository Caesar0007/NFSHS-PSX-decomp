# W85-S5 receipt — device purity sweep, frontend/common (21 TUs)

Agent: W85-S5. Gate: `python tools/tugate.py <cpp>` (whole-TU, every oracle-known
symbol). Iron rule: no previously-PASS fn may end FAIL.

## BASELINE (2026-09-02, before any edit) — ALL 21 TUs 100% PASS

| TU | gate |
|---|---|
| screenusername.cpp | 6/6 PASS |
| statchk.cpp | 5/5 PASS |
| stattool.cpp | 11/11 PASS |
| screencongrats.cpp | 28/28 PASS |
| screenmemcard.cpp | 15/15 PASS |
| screencarselect.cpp | 59/59 PASS |
| screencontroller.cpp | 22/22 PASS |
| screenmain.cpp | 13/13 PASS |
| screentracks.cpp | 10/10 PASS |
| screentrophyroom.cpp | 9/9 PASS |
| screentrackrecords.cpp | 7/7 PASS |
| screenaudio.cpp | 8/8 PASS |
| fecheats.cpp | 10/10 PASS |
| fecredits.cpp | 7/7 PASS |
| fedialog.cpp | 33/33 PASS |
| feinput.cpp | 4/4 PASS |
| fecars.cpp | 46/46 PASS |
| fetourn.cpp | 35/35 PASS |
| fetv.cpp | 5/5 PASS |
| fetextrender.cpp | 17/17 PASS |
| feapp.cpp | 15/15 PASS |

Total 355/355 PASS. Every TU is already sealed, so this assignment is PURELY
device removal under the iron rule.

## DEVICE CENSUS (classified per GUIDE.md)

NOT devices (symbol-alias `__asm__("name")` on an `extern` declaration — these
rename a link symbol, they emit no instruction and are not pins/fences):
statchk 11/17/18, screenmemcard 10-44, screencarselect 7/52/2150,
screentracks 427/428, screentrackrecords 91, fecheats 20/23/25/26,
fecredits 12/14/21, fedialog 11, fetextrender 26, feapp 9/20/102.
Left alone (they are declarations, not codegen devices).

CLEAR targets (identity/liveness fences, plain-state `volatile`, clobber pins):
see per-file sections below.

## CLEARED (applied, whole-TU re-gated PASS)

| TU | device | evidence |
|---|---|---|
| screentrophyroom.cpp | `__asm__("" : : "r"(fModNumber), "r"(fModNumber))` @316 | INERT — deleting it leaves 9/9 PASS. Dead scaffolding. |
| screencongrats.cpp | `__asm__("" : : "i"(0))` @804 (`prizes_done:`) | INERT — 28/28 PASS without it. |
| screencongrats.cpp | `__asm__("" : : "r"(scale))` @211 | REDUNDANT with the `"i"(0)` boundary 2 lines above (either alone holds PASS; both gone = FAIL 3). Deleted the register-liveness one. |

Net so far: **-3 devices, 0 regressions** (all 21 TUs still at their baseline gate).

## KEEP-with-reason (removal measured, regresses, source re-crack falsified)

### stattool.cpp @47 — `int one = 1; __asm__("" : "=r"(one) : "0"(one));`
Removing it: `Stattool_nCreateIndex` FAIL 2, count-exact 77/77. The single
instruction: ours `addu $s0,$v0,$zero`, retail `li $s0,1` (the loop init
re-materialised in the `beq` delay slot).

**ROOT CAUSE IDENTIFIED (upgrade of the W57-A7 note, which said "cse").
It is NOT cse — it is `reload_cse_regs`, a gcc-2.8 pass.** RTL-dump trace of
the fence-free build (`scratchpad/w85/rtl/`, CC1PLPSX with -dr/-dj/-ds/-dL/-dt
/-dc/-dg/-dl/-dS/-dR/-dd): insn 101 `(set (reg/v:SI 83) (const_int 1))`
survives *unchanged* through rtl, jump, cse, loop, cse2, combine, lreg AND
greg; it becomes `(set (reg 16 s0) (reg 2 v0))` only between the `greg` and
`sched2` dumps. The only pass in that window is `reload_cse_regs`
(toplev.c:3501, between global_alloc:3477 and sched2:3522).
`reload_cse_simplify_set` (reload1.c) replaces any `(set hardreg CONST)` with
a copy from the first hard register its `reg_values[]` table records as
holding that constant — here `$v0`, set by the guard's `li $v0,1` two insns
earlier. cse itself would NOT do this: cse's tie-break order is
"src_folded, src, src_eqv, src_related, hash-table entry", and MIPS
`CONST_COSTS` gives CONST_INT cost 0 == REG cost 0, so the constant wins there.

`reload_cse_regs` clears `reg_values[]` **only at a CODE_LABEL** or a CALL_INSN.
Falsified attempts to put a surviving CODE_LABEL between the `beq` and the
`i = 1` (all whole-TU re-gated; jump1 deletes every one of them long before
reload): `switch (nNumber) { case 1: break; default: ... }` 2;
`goto SortDone` / `goto SortEntry` label pair 2; `while (nNumber != 1) {...break;}`
26; `do { if (nNumber==1) break; ... } while (0)` 26.
Other falsified source forms: plain `if (nNumber != 1)` 2; `1 != nNumber` 2;
`(nNumber ^ 1) != 0` 4; `i = 1` hoisted above the guard 3; guard spelled
against `i` 3; `i += 1` step 2; `nNumber > i` Yoda loop test 2; a block-scope
second counter `k` 28.
**VERDICT: a compiler-version identity, not a source shape.** `reload_cse_regs`
is a gcc-2.8 addition; the retail object shows pre-2.8 behaviour at this site.
Reaching it would need a per-fn cc1 version selection (a `tools/build.py`
change), which this wave prohibits. Fence RESTORED verbatim.

### screencongrats.cpp `tScreenCongrats::CalculatePrizes` — 2 fences + 2 volatile lvalues
Devices: `__asm__("" : : "r"(carCXBits))` after the `carCXBits` decl and again
at the tail; `*(volatile short *)&fCarY` / `*(volatile unsigned long *)&fCarCY`.
Retail (29 insns) materialises `lui $a1,0x4080` (the `fCarCX` float bits) at
**instruction 0** and keeps it live to the `bne` delay slot, where it stores it.
Measured, whole-TU re-gated:
- both fences dropped (volatiles kept): FAIL 6, count-exact 29/29 — the only
  delta is `lui $a1` position + which store wins the `bne` delay slot;
- leading fence only: FAIL 37; **trailing fence only: FAIL 2, 29/29 — the sole
  diff is `lui $a1,16512` at insn 0 (oracle) vs insn 7 (ours)**, i.e. a pure
  sched2 ready-list decision;
- natural `this->fCarCX = 4.0; this->fCarCY = -7.4;` float assignments 35;
  float + CX last 31; retail store order 31; raw bits without fences 12;
  CX store moved after the `if` 7 (then reorg puts it in the `jr ra` slot, 28/29);
  CX store last-before-`if` 6; declaration order swapped 2; CY spelled as an
  inline literal 2; CY as `*(volatile float*)&fCarCY = -7.4f` 6; redundant
  second CX store after the `if` (no fences) 4; both bits laundered at the tail 16.
- de-volatilising either `fCarY` or `fCarCY` alone: FAIL 6 each.
Mechanism: sched2 prioritises by dependency-chain length, so the two-insn
`lui;ori` CY constant outranks the one-insn CX `lui` and wins cycle 0; the
leading fence is the only thing that pins the CX materialisation to insn 0.
No source form reaches it. KEPT, all four.

### screencongrats.cpp `DrawBackground` — one `__asm__("" : : "i"(0))` @209 survives
See the in-source comment: without any boundary, sched2 hoists `li $v0,20`
(`framenum = 0x14`) to the head of the block and reorg steals it into the
`bnez` delay slot where retail leaves a `nop` (ours 540 / oracle 541).
Falsified: 6 statement-order/typing rewrites (3,20,18,8,3,3). Device count in
this function halved 2 -> 1.

## CLEARED — round 2 (each applied + whole-TU re-gated PASS)

| TU | device removed | pure-C replacement that reproduces it |
|---|---|---|
| screenmain.cpp | `__asm__("" : : "i"(0))` before `test_credits_menu:` | read the menu pointer into a named block local (`tMenu *curMenu = FEApp->fCurrentMenu[0];`) before the compare — gives the fall-through edge its own address pseudo so the `%hi(FEApp)` is re-materialised (retail's 1-insn landing pad `.L80037B44`). |
| fecredits.cpp | `tag = *(volatile byte *)p;` (tag==10 arm) | plain `tag = *p;` moved to the JOIN after the skip loop — the loop invalidates gcc's value for `*p`, so the join load is emitted fresh. |
| fecredits.cpp | `tag = *(volatile byte *)p;` (tag==0x2a arm) | same join re-read. |
| feinput.cpp | `__asm__("" : : "i"(0))` in the `return_bool` arm | catalog goto-to-shared-tail: `if (result) goto return_one;` (the label the sibling arm already uses) instead of `return 1;` + boundary. |
| fetourn.cpp | `__asm__("" : "=r"(next) : "0"(i + 1), "r"(rankVal))` | store `(uchar)(i + 1)` and increment AFTER the store, instead of laundering `i+1` into a `next` local. |
| screenusername.cpp | `*(volatile int *)&this->callingMenu->fScreenFade` | an honest named `int fadeWord = this->callingMenu->fScreenFade;` truncated into `short fade` — the int's live range IS retail's `addu $a1,$v0,$zero` copy, and it keeps the load a full `lw` instead of a narrowed `lhu`. |
| screencontroller.cpp | `__asm__("" : : "r"(config))` + `__asm__("" : "=r"(one) : "0"(one))` + the `int one` carrier (Controller_SetRamp) | a CHAINED assignment `rampSteer[i] = rampBrake[i] = rampGas[i] = 1;` — one constant definition feeding three stores stops LICM hoisting it into an extra callee-saved register. |
| screencontroller.cpp | `__asm__("" : : "i"(0))` before `HorzVertLine(ArrowLoc,false)` + the `short clampVal` carrier | write `this->mult` INSIDE BOTH arms; gcc cross-jump-merges the two identical stores and lands the merged store ahead of the argument setup, exactly where retail has it. |

`recon/frontend/common/screencontroller.cpp` now carries **zero** codegen devices.

## KEEP-with-reason — round 2

- **fecredits `SetupCurrCredit`** `int startTicksSnapshot = *(volatile int *)&ticks;`
  — `ticks` is VSync-ISR state and the ORACLE PROVES the re-read (two
  `lw $vN,%lo(ticks)($a0)` off one `%hi`), so this is the GUIDE's sanctioned
  MMIO/IRQ class. Measured anyway: natural `fStartTicks = ticks` last 6 (count
  exact 199/199, only the load's position/register differ); plain snapshot
  first 10 (gcc CSEs it with the guard read, 197 insns); ticks-store first 12;
  ticks-store middle 3; block-scoped snapshot after the stores 6; one shared
  read feeding both the guard and the store 20.
- **screenaudio `DrawForeground`** `__asm__("" : "+r"(fadeCalc))` — residual is
  ONE instruction, count-exact 68/68: ours `sll $v0,$a0,16`, retail
  `sll $v0,$s2,16`, i.e. retail reads the COPY `addu $s2,$a0,$zero` (present in
  both) where gcc copy-propagates the original. That is the catalog's
  "old-gcc no-copy-prop" compiler-version identity (§3.25-3b), not a source
  shape. FALSIFIED: dropping it 2; an intermediate `int fadeSrc = fadeCalc` 2;
  moving `fade = (short)fadeCalc` into the loop 2; casting inline at the call
  site 2; both 2.
- **fecars `CalcUsedPrice`** `__asm__ __volatile__("" : : : "$4")` — the tree's
  single hard-register clobber, user-gated under W56-A2. Re-measured: FAIL 2,
  count-exact 67/67; retail rematerialises `addu $a0,$s2,$zero` in the
  `GetCarFromID` delay slot, gcc deletes it because `$a0` still holds `this`.
  NEW EVIDENCE this wave: it is NOT `reload_cse_regs` — the cc1 `.s` for the
  fence-free build has no `move $4,$18` at all, so the copy dies at/ before cse,
  in the compiler front half, and no post-alloc pass can restore it. Kept.
- **fetourn `UpdateTrackFinishPoints`** `__asm__("" : : "m"(this->fCompetitors[i]))`
  — dropping it is a uniform `$a1`<->`$a2` swap, count-exact: retail colours the
  competitor address `$a1` and `finalPosition` `$a2`, ours the reverse. The
  `"m"` operand raises the address allocno's ref count. FALSIFIED: dropping 20;
  a `tCompetitor *comp` walker used for all four member accesses 59; the same
  with an explicit `comp++` 59.
- **fedialog `Draw__11tDialogHelp`** both fences — `__asm__("" : "+r"(loadedTicks))`
  and `__asm__("" : : "r"(ticks))`. The second one's residual is a uniform
  `$a0`<->`$a1` swap, count-exact 187/187 (retail `firstTick`->`$a1`,
  `ticks`->`$a0`). FALSIFIED: fence-free 10; `ticks = ::ticks[0]` direct 3;
  a second copy local 5; `(ticks - (firstTick + 0x32))` grouping 4 (best);
  Yoda guard 10; guard on the subtraction 9; an `elapsed` temp 10;
  numLetters-first 10; grouping + Yoda 4; grouping + numLetters-first 4.
- **feinput `FEInput_GetNoDebounceKey`** the SECOND `__asm__("" : : "i"(0))`
  (the `return_mask` arm). The two fences are not independent: converting BOTH
  arms to `goto return_one` is FAIL 6 even though each conversion alone PASSes.
  FALSIFIED with the first arm already converted: goto-shared 6; inverted
  early-return 6; inverted `return 1` 4; a private `return_zero` label 6;
  masking `result` in place 6.
- **screenusername `DrawBackground`** `__asm__("" : : "r"(this))` @296 — the
  W72-A7 device that reproduces retail's DEAD `lw $t2,0x70($sp)` `this` reload
  (which advances gcc's function-global `last_spill_reg` round-robin and so
  sets the scratch register for every later reload). Re-measured: dropping it
  is FAIL 59. The W72-A7 receipt already falsified `(void)this`,
  `(void)(volatile int)(int)this`, a self-assignment, a volatile pointer local
  and a null check; nothing was re-opened this wave.
- **screencarselect / screencontroller file-scope `__asm__` blocks** — these are
  the hand-transcribed STANDALONE out-of-line destructor SYMBOLS
  (`___25tScreenPinkSlipsCarSelect`, `___25tScreenCarSelectTwoPlayer`,
  `___23tScreenControllerConfig`). They are not codegen devices: CC1PLPSX has no
  way to emit BOTH an inlined-everywhere dtor and a separately addressable
  out-of-line symbol from one declaration, and the manually materialised vtables
  need a real function at those VAs. Same KEEP class as the SLD-proven .ASM
  transcriptions. Converting them back to C++ definitions would require editing
  the SHARED `screencontroller_types.h` / `screencarselect_types.h` headers,
  which other agents own this wave. Untouched.
- **screencarselect `ticks` volatile reads** (`fSpeechTicks`/`fShowroomTicks` @475/476,
  `fShowroomTicks`/`fFadeTicks` @720/722) — VSync-ISR state; the oracle proves
  the re-read on 476 and 722 (removing either regresses 16 / 11). 475 and 720
  measure INERT individually and as a pair, but they are the FIRST half of the
  same two-read pair; dropping volatile from only one read of an ISR global
  would let gcc CSE it with an unrelated earlier read while its partner keeps
  reloading. Kept as the GUIDE's sanctioned MMIO/IRQ class, measurement recorded.
- **screenmain `Initialize`** `this->fStartTicks = *(volatile int *)&ticks;`
  — same sanctioned class; retail issues two separate `ticks` loads for
  `fStartTicks` and `fAnimTicks`.

## KEEP-with-reason — round 3 (measured, all whole-TU re-gated)

- **screenmemcard `LoadIcon`** — TWO devices.
  (a) `__asm__("" : : "r"(i*0xc0) x3)` in the icon loop: dropping it is a uniform
  `$s0`<->`$s1` swap, count-exact 215/215 (retail colours the `*0xc0` GIV `$s0`
  and the counter `i` `$s1`; the three `"r"` operands are what raise the GIV
  allocno's ref count). FALSIFIED: dropping 12; an explicit `char *iconRow`
  pointer walk with `+= 0xc0` after the counter 35, before it 36; a per-iteration
  `char *iconRow = (*fMemIcon)[filenum][i];` row local 28.
  (b) `bool pulled = done; __asm__("" : "=r"(pulled) : "0"(pulled));` — retail
  has a real `addu $t0,$s7,$zero` copy of `done`; gcc copy-propagates it away
  (the same no-copy-prop identity as fecars/screenaudio). FALSIFIED: plain
  `bool pulled = done;` 3; `= done` straight into the field 3; `= true` 3.
  (c) the two clamp identity fences in `DrawVerticalLine`/`DrawHorizontalLine`
  (17 diffs each) were left untouched — their W60/W65/W68 receipts already
  enumerate the falsified basins.
- **screencarselect `DrawForeground`** `__asm__("" : "=r"(currentItemValue) : "0"(...))`
  — dropping it is ONE instruction, count-exact 557/557: `bne $s0,$v0` (ours)
  vs `bne $s2,$v0` (retail). `currentItem` and `currentItemValue` hold the same
  pointer; retail keeps them in two registers, gcc coalesces. Same no-copy-prop
  identity class. Left in place; `DrawOverlay`'s two `yOffset` fences (74 diffs
  each), `"r"(currentItem)` (18) and the `shapeFade` fence (8) were not
  re-opened.
- **feapp `MainLoop`** four fences. Measured: `"i"(0)` after the tick stores 3
  (ours 1124 / oracle 1123 — retail hoists the `lw $t0,352($sp)` AUTO reload one
  slot so `addu $s0,$v0,$zero` fills its load-delay; ours emits a `nop`);
  `"r"(needToSetChildMenu)` 6; `"r"(&command[0])` 42; `"r"(currentTicks)` 6.
  FALSIFIED this wave: dropping the tick-store fence 3; the two stores moved
  ahead of the `GetTopMostDialog()` call 31; the two stores swapped 3;
  `demoLoopLastInputTick = ticks_array[0]` direct 6; a plain `currentTicks`
  local 6; assigning from the existing `tick` local 7.
  The `*(u_char *volatile *)0x1f800004` store in the same TU is the SANCTIONED
  scratchpad-MMIO class (methodology 3.6b) — not touched.
- **screencongrats `DrawBackground`** the else-arm `__asm__("" : : "i"(0))`
  — dropping it lets jump2 cross-jump-merge this arm's `framenum = 0x14` store
  with the sibling arm's, losing retail's `j <join>` + `sw $v0,132($s3)`
  delay-slot pair (540 vs 541). FALSIFIED: dropping 3; a ternary clamp 15;
  clamping through a block-local `int fnum` 3; the two `CalcFadeVal` tint
  stores swapped 15.
- **fetv `DrawTV`** the two `__asm__("" : : "r"(rgbMask), "r"(rgbMask))` fences
  (72 / 24 diffs when dropped) were NOT re-opened this wave — the in-source
  receipt already records the pure-C attempts, and the residuals are far
  outside the 1-3-instruction band the other removals lived in.
- **statchk.cpp** — NO device present. The "fence @403" in the assignment brief
  is a HISTORICAL note inside a comment: W71-A18 already deleted all three
  statchk fences (416/416 PASS with one `uRecSz = sizeof(tRecordBuffer)`
  variable whose REG_EQUIV constant reload gives retail's three `li 20`s).
  Verified: 5/5 PASS and zero `__asm__("")` / `volatile` in the whole TU.

## FINAL STATE

Whole-TU gate, all 21 assigned TUs, after every edit:

screenusername 6/6 - statchk 5/5 - stattool 11/11 - screencongrats 28/28 -
screenmemcard 15/15 - screencarselect 59/59 - screencontroller 22/22 -
screenmain 13/13 - screentracks 10/10 - screentrophyroom 9/9 -
screentrackrecords 7/7 - screenaudio 8/8 - fecheats 10/10 - fecredits 7/7 -
fedialog 33/33 - feinput 4/4 - fecars 46/46 - fetourn 35/35 - fetv 5/5 -
fetextrender 17/17 - feapp 15/15   =  **355/355 PASS, ZERO regressions.**

Codegen-device census (comments stripped; symbol-alias `extern X[] asm("name")`
declarations and the two hand-transcribed out-of-line dtor symbols excluded):

**51 -> 39 devices (-12: 8 `__asm__` fences + 4 `volatile` lvalues).**
`screencontroller.cpp` went device-free. No device of any kind was ADDED, no
post-compile move was introduced, no `tools/*.py` / MANIFEST / memory file was
touched, and no git operation was run.

Per-TU remaining: screenusername 1 - stattool 1 - screencongrats 6+2 -
screenmemcard 5 - screencarselect 6+4 - screenmain 0+1 - screenaudio 1 -
fecredits 0+1 - fedialog 2 - feinput 1 - fecars 1 - fetourn 1 - fetv 2 -
feapp 4.

## CROSS-CUTTING FINDINGS (candidate catalog rows)

1. **`reload_cse_regs` is a distinct, nameable device-cause** (new row).
   SYMPTOM: ours `addu rD,rS,zero` (or a DELETED reg-reg copy) where retail has
   `li rD,K` / keeps the copy, with that constant or value already live in
   another hard register a few insns earlier; every source respelling is
   neutral.
   CAUSE: gcc-2.8's `reload_cse_regs` (toplev.c, between global_alloc and
   sched2) — `reload_cse_simplify_set` rewrites `(set hardreg CONST)` into a
   copy from the first hard reg its `reg_values[]` table says holds that value,
   and `reload_cse_noop_set_p` deletes copies it can prove redundant. It clears
   `reg_values[]` ONLY at a CODE_LABEL or a CALL_INSN, and jump1 deletes every
   label a source `goto` / `switch` / `while` can create long before reload.
   DIAGNOSIS RECIPE (used here): compile the device-free `.i` with CC1PLPSX
   `-dr -dj -ds -dL -dt -dc -dg -dl -dS -dR -dd` and find the first dump where
   the insn changes shape. Survives `greg`, differs in `sched2` => reload_cse.
   Already absent from the cc1 `.s` => cse/combine (a different family).
   CONSEQUENCE: it is a compiler-VERSION identity (the pass is a 2.8 addition),
   reachable only via per-fn cc1 selection, never from C.
2. **Two pure-C levers that retire liveness fences** (both landed here):
   (a) a **named `int` local holding a field read** replaces a
   `*(volatile int *)&field` whose only job is to keep the load a full `lw`
   (retail then has a real copy of the raw word) — screenusername, screencarselect;
   (b) a **CHAINED assignment** `a = b = c = K;` replaces a store-constant
   identity fence: ONE definition feeding N stores is what stops LICM hoisting
   the constant into an extra callee-saved register, where N independent literal
   stores do not — screencontroller `Controller_SetRamp`.
3. **Store-in-both-arms retires a scheduling barrier**: writing a member store
   inside BOTH arms of an if/else lets gcc cross-jump-merge it back to one store
   AND land it ahead of a following call's argument setup, which is exactly what
   an `__asm__("" : : "i"(0))` in front of the call was buying (screencontroller
   `DrawArrow`). The INVERSE is also true and explains barriers that CANNOT be
   retired: where the two arms already store the same value, the barrier is what
   PREVENTS the merge (screencongrats `DrawBackground`).
4. **A join re-read retires a `volatile` re-read**: `x = *(volatile T*)p` inside
   a skip loop's block becomes a plain `x = *p;` moved to the JOIN — the loop
   invalidates gcc's value for `*p`, so the join load is emitted fresh with no
   volatile (fecredits, 2 sites).
5. **A named block local retires a `%hi`-sharing barrier**: reading a global
   pointer chain into a local at a multi-predecessor label gives the
   fall-through edge its own address pseudo, re-materialising the `%hi` retail
   reloads there (screenmain `DrawBackground`).
6. **Redundant device PAIRS exist**: screencongrats `DrawBackground` carried two
   boundaries two lines apart where EITHER ALONE holds PASS. Worth a tree-wide
   sweep — for every function with more than one device, test each device's
   removal individually before assuming all are load-bearing.
7. **Inert devices exist**: 2 of the 51 devices here (screentrophyroom @316,
   screencongrats @804) were pure dead scaffolding — removing them left the
   object byte-identical. A cheap tree-wide delete-one-and-gate sweep would find
   more. Harness used: `scratchpad/w85/S5_sweep.py <relpath>` (finds single-line
   fences + `*(volatile` lvalues, tries each removal and the all-at-once
   removal, gates the whole TU each time, always restores) and
   `scratchpad/w85/S5_probe.py <relpath> <variants.py>` (arbitrary
   old->new source variants, whole-TU gate each, always restores).
