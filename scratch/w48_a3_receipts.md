# WAVE-48 agent a3 — syslib/libpad part A (PADMAIN 11 · PADCMD 19 · PAD 2 · WAITRC2 2)

Worktree `C:/Temp/nfs4-wt48-a3`, branch `w48-a3`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root (sole authority).
`tools/build.py` is **unmodified at HEAD** — every flag/mechanism probe was patch-in-place with a
`finally` restore + byte-equality assert (`scratch/w48_a3_probe.py`, `scratch/w48_a3_epiprobe.py`).

## HEADLINE
* **+4 PASS landed in-tree** (`_padSetActAlign`, `_padSetMainMode`, `_padSetMainMode_snd`,
  `_padSetVsyncParam`) — all four had a **standing in-source "FLOOR"/"NEAR-MISS" note**, all four
  refuted.
* **+2 PASS wire-ready** (`_padVbCallback1`, `_padSetMainMode_rcv`) behind ONE new build mechanism
  (§2) that the consolidator can wire in ~20 lines.
* **+2 already-PASS**, mis-filed by the worklist (`PAD_convert`, `ReadInitPadFlag` — §5).
* **2 correctness fixes** (`_padSetMainMode_rcv` returns int + inverted arms; `setRC2wait` is void).
* **The charter's first probe (per-fn `-fno-delayed-branch` splice) is EXHAUSTED and NEGATIVE (§1)**
  — but the *why* produced the mechanism in §2 that closes the class properly.

---

## 0. RE-GATED BASELINE (2026-08-04, worktree HEAD = base) — worklist wrong on ≥4 rows

`_padWaitRXready` (worklist 99.50%) is an outright **PASS**; both `PAD` rows are `NOT IN OBJECT`
(attribution, not matching); 9 of PADCMD's 19 fns were already PASS.

| TU | fn | worklist | RE-GATED baseline | FINAL (this branch) |
|---|---|---|---|---|
| PADMAIN | _padSetVsyncParam | 92.91% | FAIL 16 (11/11) | **PASS 11/11** |
| PADMAIN | _padVbCallback1 | 95.38% | FAIL 4 (26/26) | FAIL 4 — **PASS with §2** |
| PADMAIN | _padVbCallback0 | 85.37% | FAIL 28 (87/91) | FAIL 28 |
| PADMAIN | _padStartCom | 74.27% | FAIL 23 (52/51) | FAIL 23 |
| PADMAIN | _padStopCom | 84.35% | FAIL 6 (19/17) | FAIL 6 — **6 @ 17/17 count-exact with §2** |
| PADMAIN | _padInitSioMode | 62.27% | FAIL 227 (192/205) | FAIL 227 |
| PADMAIN | _padSioMain | 54.28% | FAIL 45 (53/50) | FAIL 45 |
| PADMAIN | _padSioRW | 42.25% | FAIL 137 (113/118) | FAIL 137 |
| PADMAIN | _padSioRW2 | 26.63% | FAIL 157 (135/142) | FAIL 157 |
| PADMAIN | _padClrIntSio0 | 24.86% | FAIL 24 (34/36) | FAIL 24 |
| PADMAIN | _padWaitRXready | 99.50% | **PASS (10)** | PASS |
| PADCMD | _padSendAtLoadInfo | 45.88% | FAIL 30 (31/33) | FAIL 30 |
| PADCMD | _padRecvAtLoadInfo | 21.94% | FAIL 105 (76/83) | FAIL 105 |
| PADCMD | _padLoadActInfo | 69.45% | FAIL 37 (54/53) | FAIL 37 |
| PADCMD | _padLoadActInfo_snd | 57.48% | FAIL 22 (40/42) | FAIL 22 |
| PADCMD | _padLoadActInfo_rcv | 34.29% | FAIL 175 (134/157) | FAIL 175 |
| PADCMD | _padSetActAlign | 97.69% | FAIL 2 (26/26) | **PASS 26/26** |
| PADCMD | _padSetActAlign_rcv | 82.96% | FAIL 32 (52/50) | FAIL 32 |
| PADCMD | _padSetMainMode | 58.21% | FAIL 21 (35/38) | **PASS 38/38** |
| PADCMD | _padSetMainMode_snd | 86.67% | FAIL 7 (20/21) | **PASS 21/21** |
| PADCMD | _padSetMainMode_rcv | 32.50% | FAIL 19 (23/24) | FAIL 11 — **PASS 24/24 with §2** |
| PADCMD | (9 others) | — | PASS | PASS (0 regressions) |
| WAITRC2 | setRC2wait | 67.50% | FAIL 4 (10/8) | **FAIL 3 (9/8), body byte-identical** |
| WAITRC2 | chkRC2wait | 83.12% | FAIL 25 (41/40) | FAIL 34 @ **COUNT-EXACT 40/40** (§4) |
| PAD | PAD_convert | 0.00% | NOT IN OBJECT | **already PASS elsewhere (§5)** |
| PAD | ReadInitPadFlag | 0.00% | NOT IN OBJECT | **already PASS elsewhere (§5)** |

Whole-TU gates re-run after every landed edit; **zero PASS→FAIL regressions anywhere**.

---

## 1. LEVER 1 — the CHARTER probe: per-fn `-fno-delayed-branch` splice. **EXHAUSTED, NEGATIVE.**

Mechanism = `tools/build.py` `PER_FN_NO_DELAYED_BRANCH` (w25-a1 dual-compile splice). The base
already carries 5 wave-25 entries inside my scope (`PADMAIN {_padStopCom,_padClrIntSio0}`,
`PADCMD {_padSendAtLoadInfo,_padLoadActInfo_snd,_padSetMainMode_rcv}`) — those ARE the baselines
above. Probe = splice **every** fn of the TU at once (regions are independent → one gate run gives
all per-fn deltas with zero cross-talk).

**26 probes: 0 improvements · 20 strictly worse · 1 inert · 5 already-wired-unchanged.**

| TU / fn | baseline | splice-ALL | verdict |
|---|---|---|---|
| PADMAIN _padSetVsyncParam | 16 (11/11) | 17 (12/11) | WORSE |
| PADMAIN _padVbCallback1 | 4 (26/26) | 7 (29/26) | WORSE (+3 naked nops) |
| PADMAIN _padVbCallback0 | 28 (87/91) | 45 (92/91) | WORSE |
| PADMAIN _padStartCom | 23 (52/51) | 35 (56/51) | WORSE |
| PADMAIN _padInitSioMode | 227 (192/205) | 267 (208/205) | WORSE |
| PADMAIN _padSioMain | 45 (53/50) | 49 (57/50) | WORSE |
| PADMAIN _padSioRW | 137 (113/118) | 149 (117/118) | WORSE |
| PADMAIN _padSioRW2 | 157 (135/142) | 179 (143/142) | WORSE |
| PADMAIN _padWaitRXready | **PASS 10** | FAIL 1 (9/10) | **PASS REGRESSION** |
| PADCMD ×9 already-PASSing | PASS | FAIL 3 each (oracle+1) | **9 PASS REGRESSIONS** |
| PADCMD _padRecvAtLoadInfo | 105 (76/83) | 132 (89/83) | WORSE |
| PADCMD _padLoadActInfo | 37 (54/53) | 48 (57/53) | WORSE |
| PADCMD _padLoadActInfo_rcv | 175 (134/157) | 201 (144/157) | WORSE |
| PADCMD _padSetActAlign | 2 (26/26) | 13 (31/26) | WORSE (+5 nops) |
| PADCMD _padSetActAlign_rcv | 32 (52/50) | 49 (55/50) | WORSE |
| PADCMD _padSetMainMode | 21 (35/38) | 26 (40/38) | WORSE |
| PADCMD _padSetMainMode_snd | 7 (20/21) | 9 (24/21) | WORSE |
| WAITRC2 setRC2wait | 4 (10/8) | 4 (10/8) | INERT (cc1 `.s` identical) |
| WAITRC2 chkRC2wait | 25 (41/40) | 30 (46/40) | WORSE |
| (5 already-wired entries) | — | unchanged | — |

🔴 **Root cause, measured (this is the useful part).** Splicing turns the delay-branch scheduler off
for the WHOLE function, and every one of these fns *also needs* dbr's BODY fills. Retail's oracles
carry **filled body slots AND an unfilled return slot in the SAME function** — e.g.
`_padVbCallback1` has `addu $v0,$zero,$zero` duplicated into BOTH `beqz` delay slots (an *eager*
dbr fill) and then `lw $ra; addiu $sp; jr $ra; nop` (return slot NOT filled). **No single cc1 flag
and no whole-function splice can express that split** — which is exactly why w25's Tier-1/Tier-2
taxonomy stalled here. §2 is the mechanism that does.

---

## 2. 🏆 THE EPILOGUE-SWAP CLASS, SOLVED: a per-fn **EPILOGUE-ONLY delay-slot UN-FILL**

**The class, stated precisely.** The canonical residual is
`ours: lw $ra,N($sp); nop; jr $ra; addiu $sp` vs `retail: lw $ra,N($sp); addiu $sp; jr $ra; nop`.
It appears **iff `$ra` is the LAST callee-saved register restored** (i.e. the function saves only
`$ra`, or `$ra` is restored last). Then cc1's reorg steals the `addiu $sp` into the return's delay
slot, which puts `jr $ra` one insn after `lw $ra` → cc1 covers the load-delay hazard with a `nop`
of its own. Retail's object has the two swapped. When another `lw $sN` follows the `lw $ra`
(`_padSetMainMode`, `_padStopCom` after §2) there is no hazard and **both** builds fill the return
slot — those functions match. That is the whole discriminator.

**PROOF that it is the delayed-branch axis (not the assembler).** Compile `_padVbCallback1` with
`-fno-delayed-branch` and its epilogue comes out **byte-identical to retail**:
```
       cc1 -fno-delayed-branch          |  retail oracle
       lw   $31,16($sp)                 |  lw    $ra,0x10($sp)
       #nop      <- resolved to NOTHING |  addiu $sp,$sp,0x18
       addu $sp,$sp,24                  |  jr    $ra
       j    $31                         |   nop
```
(maspsx correctly drops the `#nop` marker — `addu $sp` does not read `$31`, so no hazard.) The
*only* reason the whole-function splice loses is the body slots it also turns off.

**THE MECHANISM (implemented as a probe, spec below).** Post-process the **normal**
(delayed-branch-ON) cc1 `.s` and un-fill ONLY the named function's RETURN delay slot, i.e. rewrite
```
        .set noreorder ; .set nomacro          ->      <FILLER>
        j   $31                                        j   $31
        <FILLER>
        .set macro ; .set reorder
```
That is textually what cc1 emits for that tail with the flag off, so the result is still 100% real
cc1 output. Probe: **`scratch/w48_a3_epiprobe.py`** (patches `tools/build.py` in place — an
additive `_w48a3_unfill(s_file)` hook called right after `_apply_fn_splice` at both compile sites —
gates, and restores build.py in `finally` with a byte-equality assert).
⚠️ It MUST be per-FUNCTION: on a function that does not have this residual it costs +1 insn.

**MEASURED RESULTS (final tree state, whole-TU gates, reproduced):**

| fn | HEAD | with epilogue-unfill | note |
|---|---|---|---|
| PADMAIN `_padVbCallback1` | FAIL 4 (26/26) | **PASS 26/26** | identity-grade conversion |
| PADCMD `_padSetMainMode_rcv` | FAIL 11 (27/24) | **PASS 24/24** | *also needs its w25 splice entry DROPPED* |
| PADMAIN `_padStopCom` | FAIL 6 (19/17) | FAIL 6 (**17/17 count-exact**) | *also needs its splice entry dropped* |
| PADMAIN `_padClrIntSio0` | FAIL 24 (34/36) | FAIL 24 (34/36) | unchanged; lets the splice entry go |
| PADMAIN `_padSioMain` | FAIL 45 (53/50) | FAIL 42 (54/50) | nudge only, +1 insn — **do not wire** |
| everything else in scope | — | +1 insn each | **do not wire** |

### 🔧 WIRING RECOMMENDATION for the consolidator (report-only from me)
Add a `PER_FN_EPILOGUE_UNFILL` table next to `PER_FN_NO_DELAYED_BRANCH` with the hook body from
`scratch/w48_a3_epiprobe.py`, then:
```
PER_FN_NO_DELAYED_BRANCH["recon/syslib/psx/libpad/PADMAIN.c"] = set()          # DROP both w25 entries
PER_FN_NO_DELAYED_BRANCH["recon/syslib/psx/libpad/PADCMD.c"]  = {"_padSendAtLoadInfo",
                                                                "_padLoadActInfo_snd"}  # DROP _padSetMainMode_rcv
PER_FN_EPILOGUE_UNFILL["recon/syslib/psx/libpad/PADMAIN.c"] = {"_padVbCallback1","_padStopCom","_padClrIntSio0"}
PER_FN_EPILOGUE_UNFILL["recon/syslib/psx/libpad/PADCMD.c"]  = {"_padSetMainMode_rcv"}
```
Verified whole-TU under exactly this config: PADMAIN → `_padSetVsyncParam` PASS, `_padVbCallback1`
PASS, `_padWaitRXready` PASS, `_padStopCom` 6@17/17, every other row identical to HEAD;
PADCMD → 12 PASS incl. `_padSetMainMode_rcv`, every other row identical to HEAD. **Zero
regressions.** The same table is the obvious sweep target for a1/a2/a4-a8 (the class is
cluster-wide, not libpad-specific) — the discriminator is one grep: ours
`lw $ra,N(sp) / nop / jr $ra / addiu $sp` vs oracle `lw $ra,N(sp) / addiu $sp / jr $ra / nop`.

### 🔴 What this says about the 04C law (for a9/a10)
04C returned the epilogue swap "to the compiler side"; a3's measurements make that concrete and
**consistent with 04C**: no assembler behaviour is needed to explain it. Retail's epilogue tail is
*exactly cc1's un-scheduled output*, and retail's body slots are *exactly cc1's dbr output*. The
open question is no longer "did aspsx reorder the epilogue" (04C says no, and we don't need it) but
**"why did retail's reorg decline the return slot when the filler creates an `lw $ra` load-delay
hazard, while ours takes it"** — a `mips_epilogue_delay_slots`/`ELIGIBLE_FOR_EPILOGUE_DELAY`
question about the SN cc1 configuration, i.e. a9's SN-divergence lane rather than a10's assembler
lane. Until that is answered, the un-fill hook reproduces the retail bytes exactly and costs
nothing.

---

## 3. PER-FN WORK LANDED (all levers, with the falsifications)

### 3.1 `_padSetActAlign` (PADCMD) — 2 → **PASS 26/26**. *Refutes a w23-a8 WEAK floor.*
Residual was `ours addu $v1,$v0,$zero` vs `oracle addiu $v1,$zero,1` — retail materializes TWO
independent `li 1`s ($v0 = the return, $v1 = the `info[0x46]` store), our cse substitutes the equal
live value (§3.25-3b "old-gcc no-copy-prop"). **Lever = the w47 OPACITY/IDENTITY FENCE**
`__asm__("" : "=r"(r) : "0"(r))` — zero instructions (output tied to input by `"0"`), a pure
value-numbering barrier. 🔑 **DIRECTION IS LOAD-BEARING**: fencing the STORE's constant instead
gives both `li`s but in the WRONG ORDER (ours v1-then-v0, still 2 diffs); fencing the RETURN
constant also pins its materialization first = retail's order.
(w23-a8 had already falsified: decl-order swap, volatile byte store, `1^zero`.)

### 3.2 `_padSetMainMode` (PADCMD) — 21 → **PASS 38/38**. *Refutes a w23-a8 FLOOR.*
Four cooperating parts; the minimal set is all of them (measured lattice over the 3 fences:
`[] 21 · [r] 15 · [o] 14 · [l] 27 · [ro] 10 · [rl] 23 · [ol] 4 · [rol] 0`):
1. `int m = offs;` **before** the call — retail keeps `offs` in TWO callee-saved regs across
   `ChkEng()` ($s1 for the `info[0x51]` store, $s3 copied **in the jalr delay slot** for the
   `(offs & 0xff)` compare). Our cse copy-propagates the second home away → `delete_noop_moves`.
2. an opacity fence on `offs` **placed AFTER the call** — keeps `m` un-equatable so the copy
   survives, and (being after the call) does not block dbr from sinking that copy into the jalr
   slot. Measured: the same fence BEFORE the call keeps the copy but pins it in the prologue and
   costs two nops → 20 diffs.
3. a fence on `lock` as a **pure zero-insn REF INFLATOR** (w44/w46 ref-step family). `-dl`:
   `lock` = 2 refs / 38 insns (pri .0526) vs `m` = 2 refs / 21 (pri .0952) → `m` allocated first
   and takes $s2; the asm insn's def+use take `lock` to 4 refs → `floor_log2` steps 1→2 → pri
   .2105 → `lock` first → $s2, `m` → $s3 = retail. **FALSIFIED inflators at this site** (all left
   `REG_N_REFS` at 2 in the `-dl` dump, verified): `& 0xff` semantic-no-op re-mask, and
   `do{}while(0)` wrappers at depth 1, 2 and 3 (loop.c strips them here).
4. `int cur = info[0xe4];` as a **DECL-INITIALIZER** at the top of the block — this and only this
   makes sched1 hoist the `lbu` to retail's position. The same read as a later ASSIGNMENT
   statement was probed at 3 positions: no effect.

### 3.3 `_padSetMainMode_snd` (PADCMD) — 7 → **PASS 21/21**. *Refutes a w23-a8 FLOOR.* **NEW LEVER.**
Retail keeps ONE shared epilogue block (`jr $ra; nop` @.L80105E24) that the no-match fall-through
and case2 both `j` to; ours emitted a DUPLICATED `jr ra` at each `goto end;`. Cause: gcc-2.8
`jump.c` replaces a `j` whose target is immediately a return with a copy of the return.
🏆 **FIX = a ZERO-INSTRUCTION `__asm__ volatile ("")` AT the `end:` label** — the block no longer
starts with a return, so `jump_optimize` leaves both `j`s alone; the asm emits no bytes.
(`"r"(info)` use-fence and a `"memory"` clobber measure identically — 4/4 forms PASS.)
**This is a general lever for the whole "oracle shares one epilogue, ours tail-duplicates `jr ra`"
family** (the note in this file had cross-referenced chkRC2wait as the same class).

### 3.4 `_padSetMainMode_rcv` (PADCMD) — 19 → 11 landed, **PASS 24/24 with §2**. **2 CORRECTNESS BUGS.**
* **(a) it is NOT void.** The oracle stages `addiu $v0,$zero,1` / `addu $v0,$zero,$zero` into the
  return register on the two paths (1 = "already in the requested mode"). The recon returned void
  and lost both. Fixed here + in `recon/lib/syslib.h`. (The callback is still installed through a
  `void (*)(u_char*)` slot — retail's SIO pump just ignores the result.)
* **(b) the ARM ORDER was inverted** — the oracle's `beqz $v0,.L80105E64` makes the `_padFuncClrInfo`
  call the BRANCH TARGET and the `info[0x53] != 0` case the FALL-THROUGH.
After (a)+(b) the body is count-exact 24/24 and the only residual is the §2 epilogue swap.

### 3.5 `_padSetVsyncParam` (PADMAIN) — 16 → **PASS 11/11**.
Pure ADDRESS-ANCHOR shape: retail materializes ONE base = `&_padVbCb.handler` (symbol **+4**) and
reaches all four words with displacements `0 / +4 / -4 / +8` — including the NEGATIVE one for
`.next`. Our field-name form made cc1 keep the %hi half in one register (fused-%lo store for
`.next`) and the full address in another = 2 base materializations. Fix = an explicit
`void (**p)() = &_padVbCb.handler;` anchor (catalog w42 "unused pointer local = the base anchor" /
negative-displacement family) **plus** the opacity fence, which completes the anchor's `addiu %lo`
BEFORE the first store (cc1 otherwise sinks it past the store — the last 2 diffs).
FALSIFIED: local `_PadIntRP *b = &_padVbCb;` (16), store reordering (16), plain use-fence
`__asm__("" : : "r"(p))` (16 — the `"=r"/"0"` identity form is required).

### 3.6 `setRC2wait` (WAITRC2) — 4 → 3, **body now byte-identical to the oracle**. **CORRECTNESS.**
* **It is VOID.** The oracle has no return-value materialization — `$v0` merely still holds the
  `lhu` result. A non-void return forces cc1 to produce a full SImode VALUE from a **volatile**
  HImode read, and combine will not merge a volatile MEM into the zero_extend → the extra
  `andi $v0,$v0,0xffff` retail lacks. Every non-void spelling probed keeps it
  (`u_short`/`u_int`/`int` local, `u_short` return, `return _startTime`); `void` is the only shape
  that drops it. ⚠️ **PADMAIN's and MCXMAIN's `u = setRC2wait(...); … if (u == 0)` call sites are
  therefore a flagged reconstruction suspect** (they keep their own `extern unsigned` decl, which
  links fine under C linkage) — re-derive them from those objs' oracles.
* Also probed and REJECTED as a semantic downgrade: dropping `volatile` from the MMIO read (or
  reaching it through an opacity-fenced non-volatile pointer, 3 diffs) — it removes `volatile`
  from a hardware register for a 1-diff gain that still does not PASS.

🔴 **RESIDUAL (3) = the ASPSX STORE-MACRO SPLIT — for a10.** cc1 emits the assembler MACRO
`sw $2,_startTime` and cannot put a macro in a delay slot, so its `.s` ends
`sw $2,_startTime` + `j $31` with an EMPTY slot. Retail expanded the macro **across** the branch —
`lui $at,%hi(_startTime)` BEFORE the `jr $ra`, `sw $v0,%lo(...)($at)` **IN** the delay slot; maspsx
expands it entirely before the branch and nops the slot. The **`$at` base is the proof it is a
macro expansion** (cc1 never allocates `$at`). Probed + rejected: the unsized asm-label view
(`extern int _startTime_v[] asm("_startTime")`) DOES get the store into the jr slot, but as cc1's
own split with a normal register ($v1, not $at) — same 3-4 diffs here and 25→40 on chkRC2wait.
**a10: this is a DIFFERENT claim from the two 04C already falsified** (backward jal-slot fill /
epilogue reschedule) — it is *store-macro expansion across a branch*. One assemble of
`sw $2,sym` + `j $31` through the real ASPSX ladder settles it.

---

## 4. `chkRC2wait` (WAITRC2) — CFG rebuilt, **COUNT-EXACT 40/40**, LCS 25 → 34 (non-monotone)

The previous body was 41 insns with the WRONG tail topology. Rebuilt from the oracle's blocks:
(a) the T2_MODE arm order was inverted — the oracle's `bnez ...,.L8010C088` makes the **/8** arm the
fall-through, i.e. `(T2_MODE & 0x200) == 0` is the if-BODY; (b) the elapsed/return pair is written
ONCE after the if/else (shared `sltu; jr; xori 1` tail), not duplicated per arm (the old per-arm
duplication never cross-jumped and emitted two whole copies); (c) both T2_TARGET reads stay (the
oracle reads 0x1F801128 twice) with `0x10000` in the `beqz` delay slot.
**Every basic block now maps 1:1 to the oracle.** I flag the LCS rise explicitly: it is the
documented non-monotone metric — do NOT "restore" the 25-diff body.

🔴 **RESIDUAL = ONE 2-WAY REGISTER ROTATION, quantified.** Retail: `cur` in `$a0`, the 0x1F801128
pointer in `$v1`; ours has them swapped. `-dl`/`-dg` on this body: p80=`cur` 8 refs / 21 insns,
`preferences: 3`, pri `floor_log2(8)*8/21 = 1.14` → allocated FIRST → takes `$3`; p86=the pointer
3 refs / 5 insns, pri `0.60` → allocated after, conflicts with p80's `$3` → `$4`.
**REQUIRED DELTA (either flips it):** pointer to ≥4 refs at live 5 (`2*4/5 = 1.60 > 1.14`), or `cur`
down to ≤4 refs at live 21 (`2*4/21 = 0.38 < 0.60`).
**FALSIFIED at this basin (all zero-insn, all 34 unless noted):** naming the pointer in a
block-local; an opacity fence on the pointer; a fence on `cur` (38, +2 insns); a block-local `tgt`
temp (36); `cur = cur + x` vs `cur += x`; `T2_TARGET != 0` arm swap (33 but 41 insns);
raw/cur split (34); raw split + fence (32); per-arm return duplication (27 @ 41).
**NEXT ANGLE (named):** the pointer is an ANONYMOUS cse temp holding the 0x1F801128 constant — it
has no C name to hang refs on. A third SOURCE-LEVEL use of that same address (or spelling the two
reads through one named block-local read used twice) is the untried inflator.

---

## 5. `PAD` rows — pure MISATTRIBUTION, both already PASS

`recon/syslib/psx/libpad/PAD.c` is the libpad **DATA** module (zero functions), so both worklist
rows gate `NOT IN OBJECT` there. The oracles are owned elsewhere and **both already PASS**:
* `PAD_convert` @0x800E41FC → `recon/eaclib/psx/pad.c` — **PASS (5 insns)** (EA's eaclib PAD.OBJ).
* `ReadInitPadFlag` @0x8010C9B0 → `recon/syslib/psx/libapi/PAD.c` — **PASS (4 insns)**.
The stale side is the **expected/`src/` scaffolding**: `src/syslib/psx/libpad/PAD.c` carries both
`INCLUDE_ASM`s while the recon bodies live in the two TUs above. Left untouched deliberately — per
the w47 RENAME-LAYERS lesson an oracle re-attribution touches 4 layers (`configs/symbol_addrs.txt`,
the `.s` labels/filenames, the expected objects, and the `src/**` INCLUDE_ASM stubs) and needs a
full expected rebuild; that is a consolidator/CI-scoped change, not an agent edit.
**No matching work remains on these two.**

---

## 6. PER-FN TABLE OF THE "EPILOGUE SWAP" CLASS (the charter deliverable)

| fn | in the class? | evidence | disposition |
|---|---|---|---|
| PADMAIN `_padVbCallback1` | **YES** (canonical) | ours `lw ra;nop;jr ra;addiu sp` / oracle swapped; only `$ra` saved | **§2 un-fill → PASS** |
| PADMAIN `_padStopCom` | **YES** | splice made it 19/17; un-fill gives 17/17 count-exact | **§2 un-fill** (6 residual = other class) |
| PADMAIN `_padClrIntSio0` | **YES** | splice or un-fill both take 28 → 24 | **§2 un-fill** (24 residual = other class) |
| PADCMD `_padSetMainMode_rcv` | **YES** | after the §3.4 body fix the ONLY residual is the swap | **§2 un-fill → PASS** |
| PADCMD `_padSendAtLoadInfo` | partly | keeps its w25 splice (32→30); un-fill alone insufficient | keep splice; open |
| PADCMD `_padLoadActInfo_snd` | partly | keeps its w25 splice (24→22) | keep splice; open |
| PADMAIN `_padSioMain` | marginal | un-fill −3 but +1 insn | **do not wire** (nudge, not identity) |
| WAITRC2 `setRC2wait` | **NO** | its jr-slot residual is the **store-macro split** (`$at`) | → a10 |
| PADCMD `_padSetActAlign`, `_padSetMainMode`, `_padSetMainMode_snd`, PADMAIN `_padSetVsyncParam` | **NO** | count-exact / pure value-numbering + anchor + jump.c | **all 4 PASS, landed** |
| PADMAIN `_padVbCallback0`, `_padStartCom`, `_padInitSioMode`, `_padSioRW`, `_padSioRW2`; PADCMD `_padRecvAtLoadInfo`, `_padLoadActInfo`, `_padLoadActInfo_rcv`, `_padSetActAlign_rcv` | **NO** | far-misses; un-fill and splice both strictly worse | untouched this wave; body-level work needed |
| WAITRC2 `chkRC2wait` | **NO** | one quantified allocno rotation (§4) | count-exact; named angle |

---

## 7. NOTES FOR OTHER AGENTS
* **a9 (flag/identity):** the epilogue swap is NOT a whole-TU flag — it is per-FUNCTION *and*
  per-BRANCH inside one function (body slots ON, return slot OFF). Any `-fno-delayed-branch` TU-level
  probe on syslib will read as a loss for exactly this reason. The §2 hook is the granularity that
  works. Open cc1 question for your lane: `ELIGIBLE_FOR_EPILOGUE_DELAY` / the reorg refusal when the
  filler creates an `lw $ra` load-delay hazard.
* **a10 (real ASPSX):** ONE new named class from me — **store-macro split across a branch**
  (`sw $r,sym` + `j $31` → `lui $at` before, `sw %lo($at)` in the slot). Distinct from the two
  claims 04C already falsified. Exhibit: `setRC2wait` @0x8010BFE8, 3 diffs, everything else exact.
* **a1/a2/a4-a8:** the §2 un-fill is cluster-wide. Grep your residuals for
  `lw $ra,N(sp) / nop / jr $ra / addiu $sp` (ours) vs `lw $ra / addiu $sp / jr $ra / nop` (oracle);
  each hit is a free PASS or count-exact conversion once the hook is wired.
* **Tooling:** `scratch/w48_a3_probe.py` (splice-set override) and `scratch/w48_a3_epiprobe.py`
  (epilogue un-fill + optional splice override) both patch `tools/build.py` in place and restore it
  in `finally` with a byte-equality assert. Both are committed.
* **Hygiene:** PADCMD.c/PADMAIN.c/WAITRC2.c are CRLF; a scripted receipt insert mixed 7 LF lines
  once (caught by a CRLF/LF/NUL count after every write — that check is now part of my loop).
