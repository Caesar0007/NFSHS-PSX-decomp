# W85-S3 receipt — device purity sweep (nfs3 / front / femenudefs / femenu / femenuextended / femenuoptions)

Gate command used for every number below (whole-TU, authoritative):

```
python tools/tugate.py <file>
```

(and `python tools/verify_asm.py <file> <fn>` for a focused single-function read.)

## BASELINE (measured first, before touching anything)

| file | gate |
|---|---|
| `recon/game/common/nfs3.cpp` | **11/11 PASS** |
| `recon/frontend/common/front.cpp` | **43/43 PASS** |
| `recon/frontend/common/femenudefs.cpp` | **66/66 PASS** |
| `recon/frontend/common/femenu.cpp` | **73/73 PASS** |
| `recon/frontend/common/femenuextended.cpp` | **57/57 PASS** |
| `recon/frontend/common/femenuoptions.cpp` | **92/92 PASS** |

Every one of the six assigned TUs is fully sealed at baseline, so the IRON RULE
("don't leave breaked PASS in FAIL states") is the binding constraint: any device
removal that cannot be re-cracked source-only is RESTORED verbatim.

(in progress — sections appended per device)

---

## FILE 1 — `recon/game/common/nfs3.cpp`  (11/11 PASS -> 11/11 PASS, devices 4 -> 2)

Only one function in this TU carries devices: `NFS3_CheckForFileOperations__Fv`
(oracle `asm/nonmatchings/main/NFS3_CheckForFileOperations__Fv.s`, 21 insns).

### Device census at entry (4)

| # | site | device |
|---|---|---|
| 1 | body, guard bound | `register int *g __asm__("$4") = ...` — **register PIN** |
| 2 | trap arm | `register int z0 __asm__("$6");` — **register PIN** |
| 3 | trap arm | `register int z1 __asm__("$4");` — **register PIN** |
| 4 | trap arm | `__asm__("" : "=r"(z0) : "0"(z0));` — **identity launder** |

(The `__asm__ __volatile__("break 0x666\n\tnop" : : "r"(z0), "r"(z1))` is NOT
counted as a device: it is the transcription of retail's inlined `trap(0x666)`
— it EMITS retail's own `break 1,614` + `nop` bytes, which no C construct can
produce. It is the same class as the sanctioned hand-asm/BIOS-thunk rows.)

### RESULT — devices 1 and 4 REMOVED, both re-gated PASS

Landed body (trap arm):

```c
register int z0 __asm__("$6") = 0;
register int z1 __asm__("$4") = 0;
__asm__ __volatile__("break 0x666\n\tnop" : : "r"(z0), "r"(z1));
```

`g` is now a plain `int *g = (int *)gFileMgr.handlearray;` (no `#if __mips__`
split needed any more). Whole-TU gate after the change: **11/11 PASS**.

Why W76 could not see this: its removal matrix only ever removed ONE piece from
the full four-device form, and each single removal regressed. Removing the `g`
pin FIRST changes the basin — with `$4` no longer also being `g`'s home, cse no
longer const-props `z1 = z0` back into `(set $4 0)`, so the launder that existed
to defeat that const-prop becomes unnecessary too.

### FULL MEASUREMENT MATRIX (every row a real `verify_asm` run this wave)

| body form | gate |
|---|---|
| **2 pins, decl-inits `= 0` (LANDED)** | **PASS 21/21** |
| 2 pins, separate `z0=0; z1=0;` statements | PASS 21/21 |
| 2 pins, decl order z1-then-z0 | PASS 21/21 |
| 2 pins + launder + `z1 = z0` (W76 form minus the g pin) | PASS 21/21 |
| z1 pin only, plain zeros | 4 @21/21 |
| z1 pin only + launder + `z1 = z0` | 3 @20/21 |
| z0 pin only, plain zeros | 5 @20/21 |
| z0 pin only + launder + `z1 = z0` | 5 @20/21 |
| 2 pins, statement order `z1=0; z0=0;` | 4 @21/21 |
| NO pins, `int z0=0; int z1=0;` | 4 @21/21 |
| NO device, natural `for` + `"r"(0),"r"(0)` | 8 @21/21 |
| NO device, hand-rotated guard + do/while | 8 @21/21 |
| W74 read-only fence `__asm__("" : : "r"(g))` after the loop | 2 @21/21 |

Notable: **`z1` pin only** already produces retail's exact REGISTERS (`addu
a2,zero,zero` then `$a0`); the single residual instruction is `addu a0,zero,zero`
where retail copies `addu a0,a2,zero`. Getting that copy without a second pin
needs opacity between the two zeros, and cse folds every non-asm spelling of a
runtime zero — which is why the last pin cannot be paid off.

### KEEP-with-reason for the two surviving `$N` pins

The pin-free floor is **2 diffs**, and only with the W74 read-only fence, which
is itself on this wave's CLEAR list; fully device-free is **8 diffs**. The reason
is a compiler law I re-derived this wave directly from `C:/Temp/gcc-2.8.1-src/
extracted` rather than trusting the inherited receipt:

* Retail's shape needs the guard bound in `$a0` (dead after the preheader copy
  `addu a1,a0,zero`) and the trap's second operand to REUSE that dead `$a0`.
* For the trap operands to be reload spills landing on `$a0`, `order_regs_for_reload`
  (reload1.c) needs `hard_reg_n_uses[$a0] == 0`, i.e. NO pseudo allocated to `$a0`
  anywhere in the function.
* A pseudo can only be left unallocated when `REG_LIVE_LENGTH` is `-1`
  (global.c:389; set only by flow.c:1179/1200 for setjmp-live pseudos) or `-2`
  (parameters, global.c:558), or via local-alloc.c:1170's `reg_equiv_replace`
  arm, which requires `REG_N_REFS == 2 && REG_BASIC_BLOCK < 0` — our guard bound
  has three refs and its set/use share a block.
* Conversely the only zero-instruction device that frees `$a0` of pseudos is a
  hard-register clobber, and reload1.c's `order_regs_for_reload` puts every
  `regs_explicitly_used` register into `bad_spill_regs` — so the same dial that
  frees `$a0` also forbids retail's spill onto it. That mutual exclusion is why
  the pin lane exists here.
* And in global.c the per-insn order (mark_reg_clobber -> REG_DEAD -> mark_reg_store)
  means a plain copy NEVER makes its two pseudos conflict, so the guard bound and
  the loop bound coalesce into one register unless something keeps the guard
  bound live past the copy. `z1`'s scope-live `$4` is exactly that something.

So: 2 pins KEPT, 2 devices CLEARED, no volatile added or retained beyond the
`break` transcription, gate unchanged at 11/11 PASS.

---

## FILE 2 — `recon/frontend/common/front.cpp`  (43/43 PASS -> 43/43 PASS, devices 6 -> 0)

**Every `__asm__` device and the one non-MMIO `volatile` in this TU are GONE.**
The file now contains no `__asm__` statement at all and no `register ... asm()`
pin (the "pin @554" in the assignment was a stale reference inside a W83-A10
comment — those six pins had already been retired; verified by
`grep -n 'register .*asm(' recon/**` = 0 hits outside nfs3.cpp).

### Device census at entry (6) and disposition

| # | line | device | disposition |
|---|---|---|---|
| 1 | 625 | `__asm__("");` in `GetPSXPadValue` | **CLEARED** — address-carrier `type` |
| 2 | 643 | `__asm__("" : : "i"(0) : "$2","$3");` 0x53/0x800000 arm | **CLEARED** — `acc2` stepwise `|=` |
| 3 | 690 | `__asm__("" : : "i"(0) : "$2","$3");` 0x23/0x800000 arm | **CLEARED** — same, as a pair |
| 4 | 2101 | `__asm__ __volatile__("" : : "i"(0));` `Front_AppendPlayerCarData` prologue | **CLEARED** — hoist `i = 0;` out of the guard |
| 5 | 2245 | `__asm__("" : : "i"(0));` `Front_AppendOpponentData` prologue | **CLEARED** — same hoist |
| 6 | 2698 | `(short)*(volatile int *)ticks` in `Front_BuildStream` | **CLEARED** — `int` temp |
| — | 10 | `extern int MEMCARDFRONTENDISINITTED_words[] asm("MEMCARDFRONTENDISINITTED");` | **KEEP (not a device)** |

Row "—" is an **asm SYMBOL LABEL, not a codegen device**: it spells which link
symbol this array-shaped view refers to. Dropping it gates 43/43 PASS *because
verify_asm is reloc-name lenient* — but the object would then reference a
symbol `MEMCARDFRONTENDISINITTED_words` that does not exist, i.e. exactly the
HIDDEN-PHANTOM class the seal bar forbids. Measured and deliberately NOT landed.

### 1. `GetPSXPadValue` — `__asm__("")` -> address-carrier `type`  (24+ shapes measured)

Plain removal = **14 diffs @220/222**. Mechanism, read off the vdiff rather than
guessed: with `type` colored `$a0`, the taken arm's `addu a0,zero,zero` is
harmless on the fall-through, so reorg steals it into the `bnez` delay slot and
the `j`+`nop` vanish (2 insns short). Retail cannot do that — its `type` lives
in **`$v1`, the same register as the gPadinfo cursor**, still live on the
fall-through (`lbu v1,5(v1)`), so the steal would destroy the base.

So the fix is not a barrier at all: make `type` BE the cursor (methodology
§3.8b(c) in-place mutation), and materialize the SYMBOL before the shift so the
`lui/addiu` pair precedes the `sll` as retail schedules it.

```c
  {
    int padBase = (int)&gPadinfo;
    type = padBase + (player << 5);
  }
  if (((tPadModuleState *)type)->buf[0].nopad != '\0') goto ...noPad;
  type = ((tPadModuleState *)type)->buf[0].ID;
```

| shape | gate |
|---|---|
| plain removal (goto arms) | 14 @220 |
| if/else (both polarities), ternary, default+override, switch-on-nopad, arm-swap, per-arm temps, do{}while(0), block-local decl, 2nd-read trick | all 14 @220 |
| decl axis: `register int type`, type-declared-first, register on both — crossed with 4 body shapes (16 cells) | axis fully INERT |
| `u_char` / `short` / `signed char` intermediate | 8 @222 (count-exact, pays an `andi`) |
| address morph in the id arm only | 7 @223 |
| address morph across the guard (`type` carries the address) | 12 @222 |
| morph + `(int)&gPadinfo + (player << 5)` (and 3 sibling spellings) | 8 @222 — only the `lui`-vs-`sll` order left |
| `type = base; type += shift` | 6 |
| `type = shift; type += base` / `type = shift; type = type + b` | 4 |
| **base into its own local FIRST, then `type = b + (player<<5)`** | **PASS 222/222** |
| same with `(player<<5) + b`, or with a separate `sh` local (both orders) | PASS |
| final spelling: raw `u_char` offsets / `PAD_COMMON*` view / `tPadModuleState*` view | all PASS (landed the struct-typed one) |

### 2+3. The two `"$2","$3"` clobber fences -> `acc2` stepwise `|=`

Both 0x800000 arms cross-jump into one tail, so they must be converted together.

| both arms rewritten as | gate |
|---|---|
| block-local `acc`, single return expression | 46 |
| single expression, no accumulator | 46 |
| `acc |=` chained on a block-local | 46 |
| `newControl` carrier | 22 |
| fn-scope `acc1` (one expression) | 29 |
| stepwise `|=` on `acc1` | 29 |
| fn-scope `acc2` (one expression) | 8 |
| **stepwise `|=` on `acc2`** | **PASS** |
| drop the fence in arm A only / arm B only | 23 / 41 |

The pair-coupling (23 / 41 for a single removal) is why five earlier waves read
this as irreducible: the fences were only ever priced one at a time against a
block-local carrier.

### 4+5. The two prologue parm-spill fences -> hoist the loop counter

Both `Front_Append*Data` fences existed to keep the `a0 -> a3` cursor parm copy
at prologue insn #1. Retail's `blez` carries `addu s1,zero,zero` (the counter
init) in its delay slot; when `i = 0;` sits INSIDE the guard, that insn is not
available to reorg, so it steals the parm copy instead. Hoisting `i = 0;` above
the `if` is the pure-C equivalent.

| | PlayerCarData | OpponentData |
|---|---|---|
| plain removal | 2 | 4 |
| `register int *stream` parameter | 2 (inert) | — |
| **`i = 0;` hoisted out of the guard** | **PASS** | **PASS** |
| `while` rewrite of the guard | — | 13 |

### 6. `*(volatile int *)ticks` -> `int` temp

`ticks[]` is an IRQ-updated counter, but the read here needs no volatile: the
`volatile` was blocking combine's halfword narrowing (`lhu` ours vs retail's
`lw` + `sll/sra`). An `int` temp does the same in pure C.

| spelling | gate |
|---|---|
| plain `ticks[0]` / `*ticks` / `& 0xFFFF` | 2 each |
| explicit `(x << 16) >> 16` | 10 |
| **`int t = ticks[0]; ... (short)t`** | **PASS** |
| int temp with two uses / fn-scope temp / store-then-reload | PASS |

Final state: `recon/frontend/common/front.cpp` **43/43 PASS, zero devices**.

---

## FILE 3 — `recon/frontend/common/femenudefs.cpp`  (66/66 PASS -> 66/66 PASS, devices 12 -> 12, all re-measured)

The base `__15tGlobalMenuDefs` seal (3207/3207) is intact and was never at risk:
none of this TU's devices sit in that function. The "pin @614" named in the
assignment is a COMMENT (`NOT pin ('register T x asm("$N")' forbidden)`), not a
pin — this TU contains no register pin.

### Per-device removal census (each removal gated on the WHOLE TU)

| site | device | plain removal |
|---|---|---|
| 286 | `__asm__("" : "+r"(screenState))` — `MenuExtended_GoToTwoPlayerSingleRace` | **4** @69/69 |
| 653/657/659 | 3 laundering fences — `MenuExtended_GoToDealer` | **10** |
| 705/709/711 | the twin 3 — `MenuExtended_GoToSeller` | **10** |
| 1122 | 6-operand `"r"(manager)` fence — `GoToTournTrackInfo` | **18** |
| 1132 | `"+r"(selectedTourney)` — same fn | (paired, see below) |
| 1192 | 7-operand fence — `GoToSpecialEventTrackInfo` | **18** |
| 1201 | `"+r"(selectedTourney)` — same fn | (paired) |
| 1258 | `*(volatile u_char *)&FEApp->fInputPlayer` — `EnterUserName` | **3** @24/25 |
| 1552 | `"+r"(this_00)` — `MenuExtended_BuyCar` | **12** |
| 1827 | `__asm__("" : : "m"(FEApp))` — `GenericMenuLoadGame` | **10** |
| 2194 | `"+r"(mgr)` in the inline manager-arg helper — `AwardPinkSlipsCar` | **2** @138/138 |
| 2280 | statement-expr `"+r"(playerNum) : "r"(fWinner)` — same fn | **67** |
| 2186/2188/2190 | `__asm__("SYMBOL")` on three `extern "C"` declarations | **not devices** (symbol labels) |

**Result: every one is load-bearing; nothing could be cleared without breaking a
PASS, so all 12 are KEPT.** 45 replacement shapes were measured this wave:

**`AwardPinkSlipsCar` (2194 + 2280).** The 2-diff residual after dropping the
inline helper is purely WHERE sched2 issues `addu a0,s2,zero` (retail: first in
the argument group; ours: last). Falsified: caller-local `mgr`, fn-scope `mgr`
carrier, `mgr` set before `GetPinkSlipsCar`, all three call args hoisted to
locals, plain `&carManager` — **all exactly 2**. Dropping BOTH devices is 67 and
stays 67 under every `playerNum`/`fWinner` spelling tried (assign at the call
site, assign late, `+ 0`, `(int)(short)` round trip 45, and four variants that
give `fWinner` an extra use AFTER the call — in the upgrades index, the upgrades
4th arg, the Save arg, both — to try to force the conflict the asm creates).
cse/copy-prop unifies the two quantities in every pure-C spelling.

**`EnterUserName` (1258).** Retail issues TWO `lbu` of `FEApp->fInputPlayer`
(`a3` and `v1`); without `volatile` gcc cse's them into one and the function is
one instruction short (24/25). Falsified: plain read, second read through a
re-loaded `*(tFEApplication **)&FEApp`, first read through it, both reads as raw
`*(u_char *)((char *)FEApp + 557)`, second read indexed by `player`, second read
with an explicit `(u_int)(u_char)` cast — **all exactly 3**. No pure-C form keeps
two reads of the same byte at the same address.

**`GoToTwoPlayerSingleRace` (286).** 4 diffs; residual is retail's `li a1,2`
issued BEFORE the nextMenu address group with the `sw v0,4(s1)` store in the jal
delay slot. 11 shapes measured (statement order for `screenState = 2` at four
positions, `do{}while(0)` dials on the assignment / the store / the SetState
call / doubled, plain store, literal `SetState(2)`, inlined nextMenu, block
reorder) — best 4, worst 30. **The file's W83-A20 comment claiming the launder
was "EXACTLY substituted" by the do{}while(0) dial was WRONG and is corrected
in-file**: the dial was added but the launder was never removed, and removing it
now costs 4.

**`GoToDealer` / `GoToSeller` (653-659 / 705-711).** Twins; converted as a pair.
7 shapes: plain 10/10, `do{}while(0)` dial on every fenced statement 20/20, dial
on the type store only 12/12, `cmdType` as a literal 10/10, defs-first order
12/12, nextMenu-store-before-type 10/10, direct `command` without `commandPtr`
10/10.

**`GoToTournTrackInfo` / `GoToSpecialEventTrackInfo` (1122/1192).** 18 each with
the multi-operand manager fences removed.

**`MenuExtended_BuyCar` (1552).** plain removal 12; `do{}while(0)` dial on the
`this_00` assignment 35; assignment moved after `GetStockCar` 10.

**`GenericMenuLoadGame` (1827).** plain removal 10; the `"m"(FEApp)` fence
replaced by a `do{}while(0)` dial on the `app` reload gets to **2** (the residual
is a `lui s1` / `lw a0` issue-order tie), and 8 dial placements were priced:
app-only 2, doubled 2, app+store 2, `mc = screenMemcard` 2, app with mc read
first 4, mc-only 10, both 10, mc-dial with plain app read 8. Kept the fence
since the dial cannot close the last 2.

---

## FILE 4 — `recon/frontend/common/femenu.cpp`  (73/73 PASS -> 73/73 PASS, devices 2 -> 2)

Only device site: the two identity launders on `sound` / `volume` at the tail of
`tMenuItemLeftRightSlider::ProcessInput` (42/42).

| shape | gate |
|---|---|
| both fences out | 6 |
| volume fence out only / sound fence out only | 4 / 4 |
| both out + literals at the call | 6 |
| both out + `do{}while(0)` dials on the decls | 6 |
| both out + decl order swapped | 6 |
| both out + keyval store between the decls / hoisted above both | 6 / 6 |
| both out + `do{}while(0)` on the keyval store | 6 |
| both out + an `int kv` carrier for the keyval value | 6 |
| both out + a dial around the whole tail | 6 |

Retail issues `li a0,21; li a1,64` BEFORE the `li v0,1` keyval value and puts
`sw v0,0(s0)` in the jal delay slot; ours emits the store first and sinks
`li a1,64` into the slot. Pure sched2 issue-order tie — **both fences KEPT**,
re-certified in-file.

---

## FILE 5 — `recon/frontend/common/femenuextended.cpp`  (57/57 PASS -> 57/57 PASS, devices 4 -> 3)

| site | device | disposition |
|---|---|---|
| 103 | `__asm__("" : : "r"(helpText) x8)` after the 2nd `FullTextRGB` | **CLEARED — completely INERT** (57/57 with and without) |
| 87/88/90 | three identity launders on `textType` / `selFade` / `fade` | **KEEP** |
| 12 | `asm("CalcTextFadeSelToHi__F13tMenuTextTypess")` | not a device (symbol label) |

The three launders cost 4 diffs @293/293 when removed; the residual is retail's
`addiu s5,v1,25` (the `+ 0x19`) sitting in the `CalcTextFadeSelToHiWide` jal
delay slot where ours emits it ahead of the argument group. Falsified: dials on
the `textType`/`fade` sets 4; the statement expression unrolled to plain
statements 4; the plain single-expression form 4; and — the direct attack, since
the add is genuinely independent of the call — moving the `+ 0x19` to AFTER the
call in four placements: **136 / 136 / 136 / 136**, with an in-place `dist +=`
at **210**. Kept.

---

## FILE 6 — `recon/frontend/common/femenuoptions.cpp`  (92/92 PASS -> 92/92 PASS, devices 8 -> 4)

| site | device | plain removal | disposition |
|---|---|---|---|
| 3131 | `__asm__("" : : "r"(sv))` "05C read-only fence" | **0** | **CLEARED — INERT** |
| 2865 | `__asm__("" : : "r"(row))` — `tUserNameMenuItem::Draw` | 3 | **CLEARED as a pair** |
| 2867 | `__asm__("" : "=r"(columnx) : "0"(columnx))` — same fn | 10 | **CLEARED as a pair** |
| 2545 | `__asm__("" : "+r"(selectedChar))` — `tUserNameMenuItem::ProcessInput` | 4 | **CLEARED via `u_char` -> `u_int`** |
| 141 | `__asm__("" : : "r"(packetCell))` — `SubtractiveBox` | 30 | KEEP |
| 142/143 | two `"=r"(x) : "0"(x)` identity uses — same fn | 40 | KEEP |
| 1008 | `__asm__("" : : "r"(lim) x4)` — `UpdatefOpenHeight` | 14 | KEEP |
| 3083 | `*(volatile short *)&this->fEnableVal = sVar2;` | 29 | KEEP |
| 2942 / 2978 | `__asm__("menu_kUserNameRows")` / `__asm__("FEApp")` array views | — | not devices (symbol labels) |

**`tUserNameMenuItem::Draw` (2865 + 2867) — the pair effect again.** Removing
either fence alone regresses (3 / 10); removing BOTH is exact 254/254. The
3-diff single-removal residual is an extra load-delay `nop` because sched2 puts
`addiu s1,a2,258` before the `lh v1,36(s2)` instead of into its delay slot.
Falsified around it: xx computed last 18, xx last with the columnx fence kept 17,
`do{}while(0)` dial on the row load 10, in-place `xx += columnx` 3, row loaded
before columnx 3.

**`tUserNameMenuItem::ProcessInput` (2545) — a pure TYPE fix.** `u_char
selectedChar` is re-masked on every use, so gcc hoisted `andi a0,a1,255` in
FRONT of the `(selectedChar - 0x23) < 2` test; retail compares the raw byte and
issues the `andi` only in the else arm. Declaring the local `u_int` (methodology
§3.12 #9) puts the mask exactly where retail has it, and the fence goes away.
With the fence removed but the type left `u_char`, everything measured 4: plain
`& 0xff`, `(u_int)(u_char)` cast, `(int)` cast inside the compare; a fresh
re-read for `character` 14, a dial on it 11.

**`SubtractiveBox` (141 + 142/143) — KEEP.** All three out = 40; only the
packetCell fence kept = 40; only the two x identity uses kept = 30. Also
falsified: the eight `prim->x?/y?` stores unrolled from the comma expression 40,
`w + x` / `h + y` operand order 42, and shared `xr`/`yb` corner carriers 40. The
devices exist to lift `x` across a local-alloc refs boundary into `$s1` and hold
`packetCell` in `$s2` past the `SetDrawMode` call; no zero-instruction pure-C
construct adds refs or extends a live range past a call.

**`UpdatefOpenHeight` (1008) — KEEP.** Removal 14; a `min`-shaped rewrite that
keeps `cur` instead of `lim` 12; a dial on the store 14; extra `lim` uses folded
into the store expression (`lim | (lim & 0)`) 14.

**`tMemoryCardMenuItem::Draw` (3083) — KEEP, and it is semantic.** The oracle
re-reads `fEnableVal` from memory after storing it (`lh a0` signed for the
compare, then `lhu v1`); the volatile store barrier is what stops cse
store-forwarding. Removal 29 (it was 5 while the now-deleted 3131 fence was
still present — the two interact). Falsified: reads sourced from `sVar2` 29, a
dial on the store 29, and moving the `volatile` from the store onto the two
READS 7 — the best alternative, and exactly the `lhu + sll/sra` degradation the
in-file note predicts. This is the methodology §3.12 #13 store->reload class,
not a coloring crutch.

---

## SUMMARY

| file | gate before | gate after | devices before | devices after |
|---|---|---|---|---|
| `recon/game/common/nfs3.cpp` | 11/11 PASS | **11/11 PASS** | 4 | **2** |
| `recon/frontend/common/front.cpp` | 43/43 PASS | **43/43 PASS** | 6 | **0** |
| `recon/frontend/common/femenudefs.cpp` | 66/66 PASS | **66/66 PASS** | 12 | 12 |
| `recon/frontend/common/femenu.cpp` | 73/73 PASS | **73/73 PASS** | 2 | 2 |
| `recon/frontend/common/femenuextended.cpp` | 57/57 PASS | **57/57 PASS** | 4 | **3** |
| `recon/frontend/common/femenuoptions.cpp` | 92/92 PASS | **92/92 PASS** | 8 | **4** |
| **total** | **342/342** | **342/342** | **36** | **23** |

**13 devices cleared, 0 PASS broken.** Every removal was re-gated on the WHOLE
TU; every non-removal is receipted above with the numbers that justify it.

Comment-stripped final census (`perl -0777 -pe 's{/\*.*?\*/}{}gs; s{//.*}{}g'`):

```
nfs3.cpp          register int z0 __asm__("$6") = 0;      [KEEP - certificate]
                  register int z1 __asm__("$4") = 0;      [KEEP - certificate]
                  __asm__ __volatile__("break 0x666...")  [transcription, not a device]
front.cpp         extern int ...[] asm("MEMCARDFRONT...") [symbol label, not a device]
femenudefs.cpp    12 devices (all measured, all KEEP) + 3 symbol labels
femenu.cpp        2 identity launders (KEEP)
femenuextended.cpp 3 identity launders (KEEP) + 1 symbol label
femenuoptions.cpp 4 devices (KEEP) + 2 symbol labels
```

### CROSS-CUTTING FINDING (the reusable one)

**Devices must be priced in COMBINATION, not one at a time.** Three of the four
clears this wave were invisible to every earlier wave because those waves only
ever removed ONE device from a multi-device site:

* `nfs3.cpp` — dropping the `g` pin FIRST changes the basin, and the opacity
  launder that existed to defeat a const-prop becomes unnecessary (4 -> 2 devices,
  where each single removal regressed).
* `front.cpp` — the two `"$2","$3"` clobber fences are 23 / 41 diffs when removed
  singly but PASS when both arms are converted to the sibling `acc2` idiom.
* `femenuoptions.cpp` — `tUserNameMenuItem::Draw`'s two fences are 3 / 10 singly
  and exact 254/254 when removed together.

The corollary for the rest of the project: any function carrying N>1 devices
should get a 2^N subset sweep (they are ~1-4 s per whole-TU gate) before its
devices are filed as load-bearing.

### RULES COMPLIANCE

* No git operations. No edits to `tools/*.py`, `regiondiff/**`, `MANIFEST`/
  `*_PROGRESS.txt`, `.github/**`, `toolchain.zip`, or any memory file.
* No NEW device of any kind was introduced: every landed change is plain C
  (statement/declaration shape, a type change, an address-carrier local, a
  hoisted loop counter, an `int` temp).
* No post-compile moves, no `NFS4_SOURCE_ONLY` opt-outs, no build-system
  intervention; every number came from `tools/tugate.py` / `tools/verify_asm.py`
  as shipped.
* Harnesses and snapshots live under `scratchpad/w85/` (`S3_try.py`,
  `S3_multi.py`, `S3_sweep.py`, `S3_look.py`, `S3_pad2d.py`, `spec_*.py`,
  `best/`, `S3_*_orig.cpp`). The six target files were left in their
  best-gated state and are byte-identical to `scratchpad/w85/best/`.
