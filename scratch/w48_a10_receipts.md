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
| **4** | *(new, found this wave)* **whole-of-syslib has ZERO `%gp_rel`** | 🟢 **-G0 CLASS CANDIDATE, same shape as a7's frontend rule** | 0 of 410 syslib nonmatching oracles contain `%gp_rel`, vs 493/1655 game and 27/508 eaclib; plus **263 positive `lui $at` absolute-4-byte-scalar sites** in syslib (CD_cbsync, _qin, _qout, Hcount, CD_debug, StCdIntrFlag …). §3.4 |

**NOTHING in my three assigned classes is IRRECONCILABLE. No maspsx patch is specced,
because none is needed** — on every shape tested, maspsx+GNU-as and real ASPSX agree
once the *compiler* flags match. The floors were mis-attributed to the assembler.

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
⇒ **a1/a2/a5/a6/a9: `g_value: 0` is a one-gate-run probe on EVERY syslib TU**, and the
census signature is the same one that yielded a7's +46 frontend flips. (Census discipline:
this is a *positive* signature — symbols that WOULD be gp-rel in our build and are absolute
in retail — not merely an absence.)

---
