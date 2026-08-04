# w48-a10 — REAL-ASPSX DIFFERENTIAL LANE (receipts)

Agent a10, wave 48. Worktree `C:/Temp/nfs4-wt48-a10`, branch `w48-a10`, base `a12f7b8b`.
**Everything below was MEASURED by running the real SN ASPSX.EXE. No emulation was used,
built, or trusted (04C law: retail-fit != tool-fidelity).**

a1/a3/a4/a8/a9: read §0 and the verdict table; the per-class receipts are §2-§5.

---

## 0. THE ASPSX LADDER ON DISK (version-probed, this wave)

| path | md5 | banner |
|---|---|---|
| `C:/Temp/psq43/PSSN/ASPSX.EXE` | d37d061f6550db9828a8ccc63b10c6d3 | **SDevTC ASPSX version 2.77** |
| `C:/Temp/psq43/PSSN43/pssn/aspsx.exe` | d37d061f6550db9828a8ccc63b10c6d3 | 2.77 (**byte-identical** to the above) |
| `C:/Temp/psq44/pssn/bin/ASPSX.EXE` | 7088352b97dc85e7691cd0821848670e | 2.79 |
| `C:/Temp/psq45/BIN/ASPSX.EXE` | 7088352b97dc85e7691cd0821848670e | 2.79 (**byte-identical** to psq44) |
| `C:/Temp/psq45/BIN/WIN/ASPSX.EXE` | accaf62ae23ca201deba0068350337b9 | 2.81 |

All three run natively on Win10, exit 0, produce objects. (The catalog's "2.81 Win build
broken" note is **retracted** — psq45/BIN/WIN/ASPSX.EXE assembles fine; see §3.)
⚠️ **Input MUST be CRLF** — a LF-only `.s` dies with `Illegal character '\n' (10) in input`.
⚠️ aspsx returns a **non-zero exit code on WARNINGS** while still writing a valid object.

---

## 1. VERDICT TABLE (the deliverable)

| # | floor class | VERDICT | one-line proof |
|---|---|---|---|
| **1** | **BRANCH-SLOT `lui`/`lw` SPLIT** (catalog cont.51 "maspsx-reorder-branch-slot FLOOR") | 🟢 **COMPILER-SIDE — and the catalog row's premise is FALSIFIED twice over** | real ASPSX 2.77 **never** fills or splits anything in `.set reorder` (§2.1); and **CC1PSX itself emits `lui $r,%hi(sym)` into the `beq` delay slot** inside its own `.set noreorder/nomacro` block (§2.3) — retail's shape is gcc's, not the assembler's. Lever = the **declaration shape** that forces the HIGH/LO_SUM split. |
| **2** | **`.lcomm` <=4B gp-rel vs absolute `lui $at;sw`** (catalog libmcrd `funcEvSp*`) | 🟢 **BUILD-SIDE, expressible today as `g_value: 0`** | ASPSX's **own `-G`** drives `.comm`/`.lcomm` promotion: `-G0` -> `lui $at; sw` (retail), `-G4/8/default` -> `sw $r,0($gp)`. At `-G0` **real ASPSX and maspsx+GNU-as are byte-identical** (§3.3). Hypotheses (a) "aspsx never gp-relativises" and (c) "different .comm handling" are FALSIFIED. |
| **3** | **EPILOGUE SWAP** (`addiu sp; jr ra; nop` vs `jr ra; addiu sp`) | 🟢 **COMPILER-SIDE — confirmed, `-fno-delayed-branch`, exact recipe in §4** | ASPSX 2.77/2.79/2.81 emit `jr ra` + whatever the `.s` says and **never** move an `$sp` writer or reschedule an `lw $ra`; `CC1PSX -fno-delayed-branch` emits retail's `addiu $sp / j $31 / nop` verbatim (§4.2), and maspsx reproduces it byte-for-byte. |
| **4** | *(new)* **whole-of-syslib has ZERO `%gp_rel`** | 🟡 **NOT a class rule — gate per TU** | 0 of 410 syslib nonmatching oracles contain `%gp_rel` (vs 493/1655 game, 27/508 eaclib) + 263 absolute-4-byte-scalar `lui $at` sites (§3.4) — but the `-G0` gate probes SPLIT: cdcont +1 PASS / 0 regressions, **INTR.c REGRESSES (SetIntrMask PASS→FAIL)**. Root cause + the new census rule in §6.1. |
| **5** | *(new, the wave's biggest find)* **macro-expansion BACKWARD-FILLED into a `jr` slot** (`CdSetDebug`/`CdSyncCallback`/`CdReadyCallback`, ours 6 / oracle 5) | 🔴 **IRRECONCILABLE UNDER ASPSX — but SOLVED by GNU as; exact maspsx spec in §5.4** | **No on-disk ASPSX can produce it** (5 falsifications, 18-option sweep, 2 versions — §5.2). `CC1PSX -O2 -G0 -mno-split-addresses` + plain `mipsel-none-elf-as -G0` reproduces retail's 5 words **byte-exact** (§5.3). ⇒ the retail syslib assembler was a REORDERING MIPS `as`, **not aspsx**. |

**Classes 1-3 (my assigned set) are ALL compiler/build-side — the floors were mis-attributed
to the assembler, and no maspsx patch is needed for any of them.** The one genuine assembler
wall is the NEW class 5, and it is specced (not implemented) in §5.4 — with the twist that
the fix is to let GNU as do MORE, not to make maspsx emulate aspsx harder.

---

## 2. CLASS 1 — the branch-slot `lui`/`lw` split

### 2.1 real ASPSX does NO delay-slot filling whatsoever in `.set reorder`

Probe `scratch/a10/t2.s` (a legal, trivially-sinkable backward-fill candidate):

```asm
	.set	reorder
	addu	$3,$4,$5
	beq	$4,$0,L1
	addu	$2,$2,$3
L1:	j	$31
```
ASPSX 2.77 ->
```
00851821  addu v1,a0,a1
10800002  beqz a0,0x10
00000000  nop        <-- slot NOT filled with the addu above it
00431021  addu v0,v0,v1
03e00008  jr   ra
00000000  nop
```
Same result for a `jal` (`t4.s`) and for a following load macro (`t1.s`, `t3.s`):
**the slot is always `nop`.** ASPSX *does* insert hazard nops (branch slots, load-delay
slots) — it does **not** schedule. This independently re-confirms the 04C falsification of
the w47-a6 emulator's rules 1/2/4/5, now on the *conditional-branch* case the 04C run had
not covered.

Control: `.set bogusopt` -> `Error : Unrecognised .set option`, so `.set reorder` /
`.set noreorder` **are** recognised (they are simply not scheduling directives for ASPSX).
`.set noreorder` (`t6.s`): the following insn *is* the slot and **no** load-delay nop is
inserted — programmer's responsibility, exactly as documented.

### 2.2 ASPSX *will* split a multi-word macro placed in a `noreorder` slot — but only if the
input already put it there

`t7.s`, macro `lw $2,gvar` written by hand into an explicit `noreorder` delay slot:
```
Warning : Multi-word instruction cannot fit into delay slot
```
and the object contains `beqz; lui v0; lw v0,0(v0)` — i.e. it *does* split, with a warning.
So the mechanism exists, but it is never *initiated* by the assembler.

### 2.3 🏆 CC1PSX puts the `lui` in the delay slot ITSELF — the retail shape reproduced

The syslib instance of the class (`CD_Read`, `syslib/psx/libcd/iso9660`, @800FA7DC):
```
    /* 800FA7DC */  beqz       $v0, .L800FA8E0
    /* 800FA7E0 */   lui       $v0, %hi(g_currentthread)     <- delay slot
    /* 800FA7E4 */  lw         $v1, %lo(g_currentthread)($v0)
```
🔑 **The `lui` writes `$v0` and the `lw` writes `$v1` — DIFFERENT registers. A `lw $r,sym`
macro expansion always uses ONE register (`lui $r; lw $r,%lo($r)`).** So this was never a
split macro; it is gcc's `-msplit-addresses` HIGH/LO_SUM pair, two independent insns, and
reorg.c is free to sink the `lui` into the slot. The catalog row's mechanism is wrong.

Reproduced on the real compiler, `scratch/a10/p3.c`:
```c
extern int Cdinfo[];            /* UNSIZED -> not -G eligible -> HIGH/LO_SUM split */
extern int g_currentthread[];
int f(int a){ if (Cdinfo[0] & 0x10) { if (g_currentthread[0] == 2) return 1; } return 0; }
```
`CC1PSX -quiet -O2 -G4 -g1` emits **verbatim**:
```asm
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L2
	lui	$3,%hi(g_currentthread) # high      <-- gcc's OWN slot fill
	.set	macro
	.set	reorder
	lw	$4,%lo(g_currentthread)($3)
```
and the ASPSX-vs-maspsx differential on that `.s` is **13/13 insns byte-identical**
(`scratch/w48_a10_diff.py scratch/a10/p3.s`).

🔴 **The reachability condition** (this is the lever a5/a6 need for CD_Read):
* `extern int sym;` (sized, <= -G) -> gcc emits the **gp/macro form** `lw $2,sym` -> ONE insn
  after the assembler -> the split can never appear (`p1.c`);
* `extern int sym[];` (**unsized array**, methodology §3.12 #5) or any object > `-G`
  -> gcc emits `lui $r,%hi(sym) # high` + `lw $d,%lo(sym)($r)` as two RTL insns -> reorg
  can and does put the `lui` in a branch slot (`p2.c`, `p3.c`).
* At `-G0` (see class 2 / §3.4) **every** symbol takes the split form, so the whole syslib
  cluster is in the reachable regime by default once `g_value: 0` is wired.

⇒ **catalog cont.51 row must be rewritten**: not a maspsx floor, not an aspsx behaviour —
a declaration-shape + `-G` reachability question, gate-testable today.

---

## 3. CLASS 2 — `.lcomm` <= 4B: gp-relative vs absolute `lui $at; sw`

### 3.1 the three competing explanations, discriminated on the real tool
* (a) *"real ASPSX never does the gp-rel macro expansion"* — **FALSIFIED.** It does.
* (b) *"Sony built with -G0"* — **CONFIRMED as the mechanism** (and it is ASPSX's `-G`, not
  only cc1's, that matters — see 3.2).
* (c) *"different .comm/.lcomm handling"* — **FALSIFIED.** Byte-identical at every `-G`.

### 3.2 the measurement (`scratch/a10/p4.c` -> `p4.s`, real CC1PSX output)
```c
int gsmall; int gbig[64]; static int ssmall; extern int esmall;
int f(int a){ gsmall = a; ssmall = a; return gsmall + gbig[0] + ssmall + esmall; }
```
cc1 emits `.comm gsmall,4` / `.lcomm ssmall,4` / `.extern esmall,4` and plain
`sw $4,gsmall` / `sw $4,ssmall` — i.e. **the compiler defers the decision to the assembler**
(classic MIPS toolchain model). Feeding that one `.s` to ASPSX 2.77:

| aspsx flag | `sw $4,gsmall` / `sw $4,ssmall` become |
|---|---|
| *(none)* | `sw a0,0(gp)` `sw a0,0(gp)` |
| `-G4` | `sw a0,0(gp)` `sw a0,0(gp)` |
| `-G8` | `sw a0,0(gp)` `sw a0,0(gp)` |
| **`-G0`** | **`lui at,%hi; sw a0,%lo(at)` x2  <- retail funcEvSp\* shape** |

Retail `funcEvSpIOE` @0x80109550 for comparison:
```
addiu $v0,$zero,1 / lui $at,%hi(D_80148A0C) / sw $v0,%lo(D_80148A0C)($at) / jr $ra / addu $v0,$zero,$zero
```

### 3.3 maspsx vs real ASPSX at -G0 — BYTE-IDENTICAL (12/12)
`python scratch/w48_a10_diff.py scratch/a10/p4.s -G 0` -> every word equal, including the
`$at` choice. ⇒ **`g_value: 0` in `PER_TU_FLAGS` reproduces the retail form exactly; the
`__attribute__((section(".data"))) = 0` workaround currently carried in
`recon/syslib/psx/libmcrd/BIOS.c` (lines 31-38) is no longer needed** and its in-source
comment ("aspsx 2.77 always materialized these single 4-byte statics with an absolute
`lui $at`") is **factually wrong** — aspsx does so only at `-G0`. a1: the honest fix is
`g_value: 0` on the TU + plain `static volatile int x;` tentative defs (which also restores
the correct `.bss` placement instead of forcing `.data`).

⚠️ **Probe hygiene learned the hard way:** a hand-written `.s` that puts its `.comm`
directives *after* the code makes ASPSX emit the absolute form regardless of `-G`
(it sizes the symbol at first reference). Always keep the real cc1 directive order —
otherwise you "prove" (a) by accident. Two of my early probes did exactly that.

### 3.4 🆕 SYSLIB IS A `-G0` CLASS CANDIDATE (whole-cluster census)
`%gp_rel` occurrences across the oracle `.s` of every *non-matching* function:

| cluster | nonmatching fns | with `%gp_rel` |
|---|---|---|
| game | 1655 | **493** |
| eaclib | 508 | 27 |
| **frontend** | 923 | **0**  (= a7's confirmed -G0 class rule) |
| **syslib** | **410** | **0** |

Plus **263 positive absolute-scalar sites** in syslib (`scratch/w48_a10_scan.py at`):
`CD_cbsync`, `CD_cbready`, `CD_debug`, `_qin`, `_qout`, `Hcount`, `StCdIntrFlag`,
`D_801237D4/D8/DC`, … all 4-byte statics reached as `lui $at,%hi(x); sw $r,%lo(x)($at)`.
Under our `-G4` those are exactly the symbols maspsx promotes to sbss.
⇒ **a1/a2/a5/a6/a9: `g_value: 0` is a one-gate-run probe on EVERY syslib TU.**
🔴 **BUT NOT A CLASS RULE — see §6.1, where I gate-tested it and it split**: cdcont +1 PASS /
0 regressions, INTR.c a clear regression. Unlike a7's frontend case, these TUs emit **0
GPREL16 relocs at -G4 already**, so `-G0` here is an *address-form* lever (macro form ->
compiler-split `lui %hi`/`lw %lo`), not a section lever, and its sign flips per TU.
Read §6.1 before wiring anything.

---

## 4. CLASS 3 — the EPILOGUE SWAP (`addiu sp; jr ra; nop` vs `jr ra; addiu sp`)

### 4.1 the assembler is not involved (three independent measurements)
* ASPSX never backward-fills *any* slot in `.set reorder` (§2.1) — so it can never
  produce `addiu $sp; jr $ra; nop` out of gcc's `jr $ra; addiu $sp`, nor the reverse.
* ASPSX never sinks an `$sp` writer (there is nothing to sink — it sinks nothing at all).
* ASPSX never reschedules an epilogue `lw $ra` (04C, re-confirmed here on `e3.s`).
⇒ **the epilogue shape is 100% decided in the `.s` cc1 hands over.**

### 4.2 CC1PSX `-fno-delayed-branch` emits retail's epilogue verbatim
`scratch/a10/e3.c` = `extern void other(void); void CdFlush2(void){ other(); }`

`CC1PSX -quiet -O2 -G4 -g1 -fno-delayed-branch` ->
```asm
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	other
	lw	$31,16($sp)
	#nop
	addu	$sp,$sp,24     <- sp-adjust BEFORE the return
	j	$31
```
assembled (`scratch/w48_a10_diff.py scratch/a10/e3.s`) — **real ASPSX 2.77 and
maspsx+GNU-as agree 8/8 words** and the result is:
```
addiu sp,sp,-24 / sw ra,16(sp) / jal .. / nop / lw ra,16(sp) / addiu sp,sp,24 / jr ra / nop
```
which is **retail `CdFlush` @0x800F7818 instruction-for-instruction** (same frame size 24,
same 0x10 save offset, same unfilled `jal` slot).
Without the flag the same source gives `... lw ra / #nop / .set noreorder / j $31 /
addu $sp,$sp,24` = the swapped epilogue. One flag, both shapes, no assembler involvement.

### 4.3 THE PER-FN RECIPE (for a3/a4/a9 — the landing mechanism already exists)
The w25 dual-compile splice is **already wired** in `tools/build.py`
(`PER_FN_NO_DELAYED_BRANCH`, keyed ROOT-relative-posix-src -> set of `.ent` label names).
It compiles the TU twice from the SAME `.i` and splices the flagged build's `.s` REGION for
the named functions only. To express class 3 for a function:

```python
# tools/build.py
PER_FN_NO_DELAYED_BRANCH = {
    "recon/syslib/psx/libcd/event.c": {"_cd_event_init", "_cd_event_read"},
}
```
🔴 **TIER RULE (unchanged, and now explained by the tool measurements):** splice only
**TIER-1** functions = *epilogue-only / no interior branches*. Reason, stated correctly for
the first time: `-fno-delayed-branch` leaves **every** slot empty, and **no assembler in the
project fills them** (§2.1) — so a function with interior branches gains naked `nop`s where
retail has real instructions. Retail's interior slots in those functions were filled by
**cc1's own reorg** (delayed-branch ON) — i.e. such a function is simply NOT in the
`-fno-delayed-branch` class and the splice must not be applied to it.
🔑 **The cheap TIER-1 test is now mechanical**: `scratch/w48_a10_dbcensus.py` prints, per
function, `slots` and `filled` read straight off the retail oracle.
**A retail function with `filled == 0` is a `-fno-delayed-branch` function**; one with
`filled > 0` is not, whatever its epilogue looks like.

### 4.4 the syslib `-fno-delayed-branch` roster (ALL-SLOTS-NOP in retail)
`python scratch/w48_a10_dbcensus.py syslib` — 46 functions, incl. every name the
methodology §3.25-3b lists, plus new ones the epilogue-only heuristic misses:

`StopCARD · _card_open · _card_close · _clr_card_event · CdSync · CdReady · CdFlush ·
CdDataSync · CdStatus · CdMode · _cdread2_ready · DMACallback · VSyncCallbacks ·
InterruptCallback · ResetCallback · CheckCallback · MemCardEnd · PadStartCom · PadStopCom ·
_pad_get_port · _padWaitRXready · DecDCTout · MDEC_status · _MDEC_get_reg1 ·
startIntrVSync_helper_2 · _get_status · _get_gp1 · GetVideoMode · SetGeomScreen ·
VectorNormal · VectorNormalS · VectorNormalSS · InitGeom · SetFarColor · SetDQA · SetDQB ·
EnterCriticalSection · ExitCriticalSection · PCinit · PCclose · ReadInitPadFlag ·
__main · __SN_ENTRY_POINT · stup0 · func_8010C9FC · func_8010CA40`

Per-TU rollup in the same tool. **MIXED TUs are the norm** (libcd/cdcont 6 ALLnop vs 13
with filled slots) ⇒ per-FUNCTION splice, never a TU flag. Confirms w24-a9.

---

## 5. 🆕 CLASS 5 (NEW, the wave's biggest find) — **THE RETAIL SYSLIB ASSEMBLER WAS NOT ASPSX**

### 5.1 the symptom (a5's `CdSetDebug` / `CdSyncCallback` / `CdReadyCallback`, gated ours 6 / oracle 5)
```
retail CdSetDebug @800F7838      lui $v0,%hi(CD_debug)
                                 lw  $v0,%lo(CD_debug)($v0)
                                 lui $at,%hi(CD_debug)      <- macro FIRST word, hoisted ABOVE the branch
                                 jr  $ra
                                  sw $a0,%lo(CD_debug)($at) <- macro SECOND word, in the slot
```
Both accesses are **assembler macro expansions** (`lw` reuses its own dest as base; the store
uses `$at`) — CC1PSX never emits `$at` for a normal store (verified: the only `lui\t$1`
format string in CC1PSX.EXE is the `-mabicalls` `%neg(%gp_rel())` prologue; `.set noat`
appears only in the `_mcount` profiling emitter). So the split-and-hoist is the assembler's.

### 5.2 real ASPSX CANNOT produce it — five falsifications, all measured
| probe | what it tests | ASPSX 2.77 / 2.79 result |
|---|---|---|
| `s3.s`, `s5.s` | macro-expanded store immediately before `j $31`, `.set reorder`, with/without `.ent`/`.frame` | **6 insns, `jr ra; nop`** — no backward fill |
| `s2.s` | macro store written into an explicit `.set noreorder` slot | `jr ra; lui at; sw` — first word IN the slot (and the `sw` after a return = dead) + a warning |
| `s6.s` | same + `.set nomacro` | `Warning: Macro expansion is disabled` then identical to `s2.s` |
| 18-option sweep (`-a -f -g -q -u -v -x` + numeric variants; `-o`/`-s` take arguments, all others are `Unknown option`) | any ASPSX switch that enables filling | **all SAME** except `-x`, which only makes `.extern name,size` symbols gp-eligible (a *new* documented ASPSX flag, see §6.3) |
| ladder 2.77 vs 2.79 | version dependence | byte-identical on every probe |

### 5.3 🏆 GNU `as` in `.set reorder` DOES do it — and the whole function then matches retail
```sh
CC1PSX -quiet -O2 -G0 -mno-split-addresses s1.c -o s9.s     # s1.c = the CdSetDebug body
mipsel-none-elf-as -EL -march=r3000 -mtune=r3000 -G0 -o s9.o s9.s
```
```
00000000 <CdSetDebug>:
   0: 3c020000  lui v0,0x0
   4: 8c420000  lw  v0,0(v0)
   8: 3c010000  lui at,0x0
   c: 03e00008  jr  ra
  10: ac240000  sw  a0,0(at)
```
= **retail's five words, opcode-for-opcode, register-for-register, order-for-order.**
(cc1 emits `lw $2,CD_debug / sw $4,CD_debug / j $31` — three macro lines, empty slot;
GNU as expands the macros THEN backward-fills the return slot with the expansion's last
word, hoisting `lui $at` above the branch. ASPSX on the identical `.s` gives 6.)

### 5.4 why our pipeline can't see it — the exact maspsx mechanism (SPEC ONLY, not implemented)
`C:/Temp/maspsx-master/maspsx/__init__.py`:
* **line ~1018-1021** — on every `.ent` maspsx appends `.set\tnoreorder` ("enforce noreorder
  for each function"), so GNU as is in **noreorder mode for the entire function** and its
  reorder scheduler never runs;
* **line ~1064** — it then materialises `nop  # DEBUG: branch/jump` after every branch/jump.
Verified on the live TU: maspsx's output for `CdSetDebug` is
`lw $2,CD_debug / #nop / sw $4,CD_debug / j $31 / nop  # DEBUG: branch/jump`.

🔴 **SPEC for a maspsx `--as-reorder` mode (deliberately NOT implemented — a10 charter):**
> Add an opt-in flag that, for the TUs that request it, (1) suppresses the per-`.ent`
> `.set noreorder` injection, (2) suppresses the unconditional post-branch `nop`
> materialisation, and (3) leaves load-delay nop insertion to GNU as as well (its
> `.set reorder` already does it) — i.e. emit the cc1 macro lines verbatim and let GNU as
> do macro expansion + delay-slot filling. Scope must be **per-TU (or per-function)**: on a
> delayed-branch-ON object gcc has already filled the slots, so the mode is inert there, but
> on any object where cc1 left slots empty it changes every one of them.
> **Validation bar:** whole-TU gate, zero PASS regressions, and the three `CdSetDebug`-family
> functions flip FAIL-3 -> PASS.

### 5.5 what this means for the syslib cluster (for the wave lead / a9)
Three independent syslib signatures now point the same way, and **none of them is ASPSX**:
1. reorder-mode **backward fill** of macro-expanded instructions (§5.3) — GNU/MIPS-`as`
   behaviour, absent from every on-disk ASPSX;
2. **`-fno-delayed-branch`** compiler output in 46 functions (§4.4);
3. **zero `%gp_rel`** in 410/410 syslib oracles (§3.4).
⇒ **Hypothesis (named, testable, not yet proven cluster-wide): Sony built the PsyQ 4.3
libraries on their own MIPS host toolchain — `gcc -G0 -fno-delayed-branch` + the real
MIPS `as` (whose reorder behaviour GNU `as` reproduces) — not with ccpsx/ASPSX.** This is a
per-OBJECT toolchain identity in the §3.25 sense, one axis further out than the flag axis:
the *assembler* itself. It would explain the syslib floors that survived every flag sweep.

---

## 6. FALSIFICATIONS & GATE PROBES (numbers + basins, per the NO-FLOORS law)

### 6.1 `g_value: 0` whole-TU probes (build.py patched in place, MEASURED, REVERTED)
Basin = base `a12f7b8b`, unmodified recon sources.

**`recon/syslib/psx/libcd/cdcont.c`** — baseline 10 PASS / 9 FAIL -> **-G0: 11 PASS / 8 FAIL**

| fn | -G4 | -G0 |
|---|---|---|
| **CdLastPos** | FAIL 3 (4/3) | **PASS (3)** |
| CdSetDebug / CdSyncCallback / CdReadyCallback | FAIL 3 (6/5) | FAIL 7 (4/5) |
| CdControl | FAIL 62 (77/79) | FAIL 76 |
| CdControlF | FAIL 67 (74/77) | FAIL 77 |
| CdControlB | FAIL 69 (80/83) | FAIL 74 (81/83) |
| CdDataCallback | FAIL 6 (9/9) | FAIL 6 |
| CdIntToPos | FAIL 65 (64/65) | FAIL 65 |
| the 10 PASSing fns | PASS | **PASS (0 regressions)** |

⇒ +1 PASS, 0 regressions, but **net diff count WORSE** — below the a8 wiring bar. a5's call.
The CdSetDebug family gets *shorter* at -G0 (cc1 switches to the HIGH/LO_SUM split, 4 insns)
which moves AWAY from the oracle's 5 — that family wants **-G0 + `-mno-split-addresses`**
(§5.3), not -G0 alone.

**`recon/syslib/psx/libetc/INTR.c`** — 🔴 **FALSIFIED, a regression.**

| fn | -G4 | -G0 |
|---|---|---|
| **SetIntrMask** | **PASS (6)** | **FAIL 4** |
| RestartCallback | FAIL 31 | FAIL 39 |
| _intrhand | FAIL 80 (112/116) | FAIL 117 (109/116) |
| _set_intr_callback | FAIL 34 | FAIL 35 |
| _initIntr | FAIL 41 (55/54) | FAIL 66 (54/54) |
| StopCallback | FAIL 47 | FAIL 52 |

⇒ **`-G0` is NOT a syslib class rule.** 🔴 **Correction to my own §3.4:** the zero-`%gp_rel`
census is NECESSARY but NOT SUFFICIENT. Both TUs already emit **0 GPREL16 relocs at -G4**
(`objdump -r` on the built objects), so -G0 cannot be removing gp-rel — what it actually does
is flip cc1 from the **assembler-macro** address form (`lw $2,sym`) to the **compiler-split**
`lui %hi / lw %lo` form, which re-allocates registers across the whole TU. That is a large,
two-sided codegen change, not a section tweak.
🔑 **RULE for a1/a2/a5/a6/a7/a9 (new): before crediting `-G0`, check the built object's
GPREL16 reloc count. If it is already 0, `-G0` is an ADDRESS-FORM lever, not a section
lever — and its sign is unpredictable. Gate it per TU; never wire it as a cluster rule.**

### 6.2 other falsifications
* **"real ASPSX splits a load macro across a conditional-branch delay slot"** (catalog
  cont.51) — FALSIFIED, §2.1/§2.3.
* **"aspsx 2.77 always materialised single 4-byte statics with an absolute `lui $at`"**
  (in-source comment, `recon/syslib/psx/libmcrd/BIOS.c:31-38`) — FALSIFIED, §3.2: it does so
  only at `-G0`; at its default it emits `sw $r,off($gp)`.
* **"2.81/2.86 Win aspsx builds are broken"** (catalog TOOLS row) — partly retracted: 2.81
  (`psq45/BIN/WIN/ASPSX.EXE`) assembles cc1 output fine and agrees with 2.77/2.79; it does
  choke on some hand-written probes (`t2.s`, `t4.s`), so treat it as usable-but-quirky.
* **maspsx-vs-real-ASPSX divergences found (2, both explained):** (i) the `.set noreorder`
  macro-in-slot case (§5.2 `s2.s`) — aspsx puts the macro's first word in the slot, maspsx
  nops the slot and emits the macro after; irrelevant in practice because cc1 never produces
  that input. (ii) a hand-written `.s` without `.end` gets a spurious extra trailing nop from
  maspsx. **On every REAL cc1 output tested (p1..p5, e1..e3, s9, the live cdcont TU) maspsx
  and real ASPSX are BYTE-IDENTICAL.** maspsx is a faithful ASPSX emulator; that is exactly
  why it cannot reach class 5.

### 6.3 🆕 previously undocumented ASPSX facts (for the catalog)
* accepted single-letter options: `-a -f -g -o(arg) -q -s(arg) -u -v -x -G<n>`; everything
  else is `Unknown option`.
* **`-x` = make `.extern name,size` symbols gp-eligible.** Default OFF — but raw GNU
  `as -G4` DOES honour `.extern name,4` (`s8.s` -> `lw v0,0(gp)`), so a hand-`as` probe can
  silently diverge from the real gate. Always differential-check with `w48_a10_diff.py`.
* ASPSX `-G` governs `.comm`/`.lcomm` promotion only; symbols the compiler placed in
  `.sdata` explicitly are gp-relative at every `-G` (`p5.s`).
* `.sbss` is **not** an ASPSX directive (`Op-code not recognised`) although `.sbss` is one of
  its 8 section names (`.rdata .text .data .sdata .sbss .bss .ctors .dtors`).
* ASPSX has **no `reorder` string in its binary at all**; `.set reorder`/`noreorder` are
  recognised (a bogus `.set` errors out) but they only toggle *hazard-nop insertion*, never
  scheduling.
* `ASMPSX.EXE 2.45` (SDevTC syntax) also ships in `psq43/PSSN` — a different, non-gcc
  assembler; not a candidate for cc1 output.

---

## 7. TOOLS DELIVERED (all probe-only, nothing in the build path)

| file | what |
|---|---|
| `scratch/w48_a10_snasm.py` | assemble with any real ASPSX (2.77/2.79/2.81) + full SN-LNK v2 parser + disassembly. Fixes over `w48_snlnk_cmp.py`: CRLF conversion, **warnings-are-not-failures**, section-NAME table (tag 16), xref table (tag 14), reloc TYPE kept (not just offsets). |
| `scratch/w48_a10_diff.py` | the differential: one cc1 `.s` -> real ASPSX **vs** maspsx+GNU-as, side-by-side word diff with reloc masking. `python scratch/w48_a10_diff.py <f.s> [--asm 2.79] [-G 0]` |
| `scratch/w48_a10_scan.py` | oracle scanner for the class signatures over the w48 worklist (`c1` / `c3` / `at`). |
| `scratch/w48_a10_dbcensus.py` | per-function delayed-branch census off the retail oracle (`slots` vs `filled`) + per-TU rollup. **The TIER-1 test for the §4.3 splice.** |
| `scratch/a10/*.s`, `*.c` | every probe cited here, committed so each claim is re-runnable. |

⚠️ Harness gotchas worth inheriting: ASPSX needs **CRLF** input and returns a **non-zero exit
code on warnings**; a hand-written `.s` whose `.comm`/`.lcomm` directives come *after* the
code makes ASPSX size the symbol too late and emit the absolute form regardless of `-G`
(this cost me two false "aspsx never gp-relativises" readings before I switched to real cc1
output for every probe).

## 8. WHAT a1/a3/a4/a5/a6/a8/a9 SHOULD TAKE FROM THIS
* **a1 (libmcrd):** the `funcEvSp*` `.data`-attribute workaround is honest-but-wrong-mechanism;
  the real setting is `g_value: 0` (§3.2/3.3), which also restores correct `.bss` placement.
  Gate `-G0` on BIOS.c / LIBMCRD.c / USERFUNC.c — but read §6.1 first: check the GPREL16
  count on the built object before crediting it.
* **a3/a4 (libpad):** class 3 is compiler-side and the splice already exists; use
  `w48_a10_dbcensus.py` to pick TIER-1 targets (`filled == 0`), not the epilogue eyeball.
  `_pad_get_port`, `_padWaitRXready`, `PadStartCom`, `PadStopCom` are ALL-SLOTS-NOP.
* **a5/a6 (libcd):** `CdLastPos` -> PASS at `-G0` (§6.1). `CdSetDebug` / `CdSyncCallback` /
  `CdReadyCallback` are class 5 — do **not** burn spellings on them; they need the
  assembler-reorder mode (§5.4). `-G0 -mno-split-addresses` alone gets the *addressing* form
  right but still leaves the unfilled slot.
* **a8 (libmath/libgte):** the 60 `lui`-in-conditional-branch-slot sites the scanner finds in
  libmath are gcc's own `li`-upper-half fills — same compiler-side mechanism as §2.3. Check
  `filled` counts before assuming an assembler wall.
* **a9 (flag axis):** two flags earned their place in the syslib sweep —
  `-mno-split-addresses` (needed *together with* `-G0` for the macro address form) and
  per-function `-fno-delayed-branch` via the existing splice. One warning: **`-G0` is an
  address-form lever on syslib, not a section lever** (§6.1) — its sign flips per TU, so it
  must be gated per TU and never wired as a cluster rule.
