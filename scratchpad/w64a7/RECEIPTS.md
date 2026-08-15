# W64-A7 — the libpad belt (vendor gate-parity)

Repo `C:\Temp\nfs4-decomp`, base HEAD `fbc974f7`. Gate = `tools/verify_asm.py`
(`-` = OURS, `+` = ORACLE). Every number below is my own re-gate; every landing gated twice
and committed per-TU. `tools/build.py` NEVER edited (all mechanism probing via the w63-a8
harness, copied to `scratchpad/w64a7/verflag.py`). Memory dir untouched. User-live TUs untouched.

## 0. PER-FN LEDGER

| fn | TU | briefed | re-gated baseline | final | commit |
|---|---|---|---|---|---|
| `_pad_filter` | PADPORTD.c | 98.99 / 3 | **FAIL 3** @158/159 | **PASS 159/159** | `cce926bb` |
| `_padInitSioMode` | PADMAIN.c | 98.67 / 24 | **FAIL 24** @203/205 | **FAIL 20** @207/205 + brdist branch-COUNT divergence CLOSED | `4d8c3404` |
| `_pad_failall` | PADPORTD.c | 93.57 / 17 | **FAIL 17** @60/61 | 17 — certificate re-verified, +6 falsifications, residual fully attributed | `6701e377` |
| `_pad_getbyte` | PADPORTD.c | 92.13 / 5 | **FAIL 5** @44/47 | 5 — +6 falsifications, class sharpened (depth, not only direction) | `6701e377` |
| `_padLoadActInfo_rcv` | PADCMD.c | 95.61 / 14 | **FAIL 14** @155/157 | 14 — the 2.8+nosplit basin re-derivation EXECUTED (see §5) | `3cfdbb85` |
| `_padIntRecvData` | MCXMAIN.c | verify | **PASS** (223) | PASS | — |
| `_padIntRecvHdr` | MCXMAIN.c | verify | **PASS** (35) | PASS | — |
| `_dirCheck` | PADSEQD.c | verify | **PASS** (11) | PASS (the w63 TEXT_MOVES row is wired and holding) | — |
| `_dirFailAuto` | PADSEQD.c | verify | **PASS** (55) | PASS | — |
| `_dirSendAuto` | PADSEQD.c | 99.92 cert | **PASS** (64) | PASS — certificate = already sealed | — |
| `_padInitDirSeq` | PADSEQD.c | 87.69 cert | **FAIL 3** @14/13 | 3 — vendor at-macro-split certificate re-verified | — |

Whole-TU, start -> end: **PADPORTD 5/8 -> 6/8**, PADMAIN 10/11 (24 -> 20), PADCMD 18/19,
PADSEQD 4/5, MCXMAIN 5/5. **Zero PASS -> FAIL anywhere.** `tu_order_audit.py`: 508 objects,
**0 inversions**.

## 1. SEAL — `_pad_filter` 3 -> PASS 159/159 (class (a) CLOSED)

The w63 note named the angle exactly right — *"the discriminating difference between loop 1 and
loop 2 is the `break`"* — and the answer turned out to be one token, not a loop shape.

```c
i = 0;
if (nmask != 0) {
    do {
        if (*map == mode && (mask & *dat) != 0) { matched = 1; goto found; }
        map++; dat++;
        i++;
    } while (i < nmask);
}
found:
```

**MECHANISM.** A `break` compiles to a jump to the LOOP'S OWN exit label — the same label the
do-while's failed bound test falls to. Two edges into that one label is precisely the input
`jump.c`'s `duplicate_loop_exit_test` looks for, and it copies the bound test ahead of the loop:
that is the +4 insns and the `$a2/$a3` rotation that EVERY guarded-do-while probe measured
across w53/w61/w62/w63 (43–61 @162, and all byte-identical to each other). A `goto` to a label
the loop machinery does not own leaves the loop with a single exit edge, the duplication never
fires, and retail's `beqz $t1` entry guard + `addiu $v1,1; slt $v0,$v1,$t1; bnez` back-edge come
out verbatim. It is the SAME shape loop 2 already uses and matches — which is why the w63
receipt was right that the shapes are identical and wrong only about what rejected it.

MEASURED (same basin, all mine): control 3 @158 · guard+do-while+**goto** **PASS 159/159** ·
guard+`while (1)` with `if (++i >= nmask) break;` as the bottom test **PASS 159/159** ·
guard+do-while+**break** 43 @162 · guard+`for(;;)` + separate bottom `if (i >= nmask) break;`
43 @162 · same with `!(i < nmask)` 43 @162 · void-tail fence after the old `!=` loop 3 @158.
The two PASSing forms differ ONLY in which exit is the loop's own — that is the whole law.

**CATALOG ROW CANDIDATE (§B).** *Symptom:* a guarded do-while whose oracle shape you have read
off exactly still costs +4 insns and rotates a register band, and the only structural difference
from a sibling loop that DOES match is an early `break`. *Fix:* spell the early exit as a `goto`
to a label after the loop (or move the bound test into an ordinary `if` at the bottom of a
`while (1)`), so the loop keeps a single exit edge and `jump.c duplicate_loop_exit_test` does not
copy the bound test into the preheader.

## 2. `_padInitSioMode` 24 @203 -> 20 @207 — and the honest brdist hit is CLOSED

`python tools/brdist.py recon/syslib/psx/libpad/PADMAIN.c` reported **BRANCH COUNT 20 vs 21**.
It now reports only 2 branch-OFFSET rows (both a consequence of the +2 insn count); the COUNT
divergence is gone. Three cooperating devices, each with the mechanism read off the dumps:

### (a) The phantom `vars= 8` frame — SOLVED and source-reachable
Bisected on the preprocessed TU with the real rung binaries down to a **13-line repro**:
`if (g[ch] > 0) { do { fp(0); } while (g[ch] > 0); }` — a loop whose exit test reads a global
ARRAY INDEXED BY A GLOBAL, with a call in the body. A scalar global, a constant index, or the
same loop without a call all give vars=0.

MECHANISM (RTL-dump evidence, not inference): expanding `_padFixResult[_padSioChan]` creates two
pseudos — 91 = `(set (reg) (symbol_ref))` (the `la`, which SURVIVES and becomes the loop's `$s1`
base) and 94 = `(plus (reg 93) (reg 91))` (the address). **cse2 (`rerun-cse-after-loop`) folds
the address into the MEM** as `(plus (reg) (symbol_ref))` and 94's insns disappear — but
**gcc-2.7.2 runs `flow_analysis` only ONCE, before combine/cse2**, so `REG_N_REFS(94)` stays 2.
`regclass` never sees 94 in an insn, all its class costs are 0, and the all-zero tie-break lands
on the SMALLEST class: the `.lreg` literally prints
`Register 94 used 2 times across 1 insns in block 4; ST_REGS or none; pointer`. ST_REGS is
unallocatable, `global.c` lists 94 in "regs to allocate" and leaves it homeless, and reload's
`alter_reg` gives it a 4-byte slot that `MIPS_STACK_ALIGN` rounds to 8.

Cross-checks: 2.6.0/2.6.3/2.7.2 print vars=8, **2.7.2-970404/2.8.0/2.8.1 print vars=0** (2.8
added a reg-usage recomputation after combine); **PsyQ 4.0's own CC1PSX.EXE reproduces vars=8
byte-for-byte**, so it is not a windows-gcc-psx artifact. `-fno-caller-saves`, `-fcaller-saves`,
`-fno-strength-reduce`, `-fno-schedule-insns{,2}`, `-fno-expensive-optimizations`,
`-fno-force-mem`, `-fomit-frame-pointer`, `-fno-function-cse`, `-fno-cse-follow-jumps`,
`-fno-cse-skip-blocks`, `-fno-thread-jumps`, `-fno-peephole`, `-fno-defer-pop`, `-fno-inline`,
`-fno-float-store`, `-fno-volatile`, `-fno-unroll-loops`, `-fno-delayed-branch` all leave vars=8;
**`-fno-rerun-cse-after-loop` gives vars=0** and produces an object BYTE-IDENTICAL to the source
device below — the independent confirmation of the mechanism, and the reason no build.py wiring
is needed.

CURE (zero cost): spell the FIRST read as `*(int *)((_padSioChan << 2) + (int)_padFixResult)`
(09I cast-int subscript — expand builds the MEM address directly, no intermediate pseudo). Gives
retail's frame EXACTLY (`$sp,32 / vars= 0 / regs= 3/0`). `*(volatile int *)&arr[idx]` also works.
NEUTRAL (still vars=8): `*(_padFixResult + _padSioChan)`, `_padSioChan * 4 + (int)base` (the `*4`
form routes through `pointer_int_sum`), `((int *)base)[idx]`, `(unsigned)` index,
`(char *)base + idx*4`, `&arr[idx]` into a pointer local, a `q` pointer in its own block, a split
decl, a chan-local, a base-ptr local, dropping the `fix` local, identity/read-only fences on
`fix`. A pointer local WITH a use fence on it does kill the slot but turns the `$at` macro into a
real 4-insn address chain (39 @204).

### (b) The tail launder = the brdist branch
`if (info[0x36] != 0) return 0; { int one = 1; __asm__("" : "=r"(one) : "0"(one)); return one; }`
— w62-a5's device, now LANDED. Without it `jump.c`'s store-flag transform folds both constant
exits into `sltiu $v0,$v0,1` and DELETES a branch: that is exactly the 20-vs-21 brdist row.

### (c) 🏆 The `do { ... } while (0)` DEPTH WRAPPER as a TIE-BREAKER (the new lever)
`qty272` on the rung priced the cast basin's biggest cluster exactly: p86 = the HImode JOY_CTRL
constant (refs 3 / live 6) and p85 = the `_padSioRegs` value (refs 2 / live 4) come out at
**pri .5000 each — an exact tie**, broken by allocno NUMBER, so 85 allocates first and takes
retail's `$v1`. (In the CONTROL basin the orphan pseudo's extra insn made it 86 = .4285 vs
85 = .4000, i.e. correct.) Wrapping just the JOY_CTRL select in a phony loop flips it:

```c
do {
    JOY_CTRL = (_padSioChan != 0) ? 0x3003 : 0x1003;
} while (0);
```

**WHY IT BREAKS A TIE NO OTHER DIAL CAN:** `flow.c` weights refs by loop depth, so a wrapper
scales every pseudo inside **multiplicatively**, while the LOOP_BEG/END notes lengthen every live
range **additively**. p86 -> `2*6/8 = 1.500`, p85 -> `2*4/6 = 1.333`. Any dial that scales both
sides equally (and a tie is exactly that situation) cannot separate them; the wrapper can.
Worth 11 diff lines here. Depth 2 and depth 3 measure IDENTICAL to depth 1 — one level is the
whole dial.

MEASURED ladder: control 24 @203 · cast 27 @204 · launder 26 @205 · cast+launder 25 @206 ·
**cast+launder+wrapper 20 @207 (landed)** · cast+wrapper without launder 22 @205 (count-exact but
the tail fold and the brdist hit return — rejected on structure) · wrapper alone 31 @204 ·
wrapper stretched over `setRC2wait` 25 @206 · volatile first-read instead of cast 24 @207 ·
+ an `fb` base local plain 25 @206 / laundered 51 @206 / loop-only 39 @206 / unlaundered 28 @203.
Also falsified for the same tie: base-pointer-first spelling of the store, a `sio` base local, a
read-only fence on `_padSioRegs` after the store (26 @207), named `int`/`unsigned short` ctrl
carriers with a read-only fence (25 @208 — the fence DOES flip p86 onto `$v1`, but the named
local costs 2 insns and rotates chan/base instead), if/else instead of the ternary (33 @214).

**RESIDUAL 20 @207, three named clusters, NO frame lines left:**
* **[4]** two extra `nop`s — the wrapper's LOOP_BEG/END notes are a scheduling barrier and the
  `lw _padSioChan` load-delay slot can no longer be filled across it. This is the entire +2
  count. A NON-BARRIER +1-ref device on the HImode ctrl constant erases it.
* **[6]** the `&_padFixResult` materialization: retail `lui $v1; addiu $v1; addu $s1,$v1,$zero`
  vs ours `lui $s1; addiu $s1` direct. Retail's copy survives because its `la` pseudo spans two
  blocks (born with the first read in block 0, used in the loop preheader) so `combine_regs`
  refuses to tie it; killing pseudo 94 also removes pseudo 91, so `loop.c` mints its own
  single-block one. Named angle: a two-block `la` that cse cannot const-propagate.
* **[6]** the tail `lbu $v0,54($s0)` vs retail `lbu $v1` (w63's item (ii), unchanged).

## 3. `_pad_failall` 17 — certificate RE-VERIFIED, residual fully attributed

Re-gated 17 @60/61, shape unchanged. **Full attribution (new):** 13 of the 17 lines are the ONE
decision `flag` = `$a0` (ours) vs `$a1` (retail) — 3 for the missing entry copy, 2+2 for the two
tests, 4 for the two `li 65535` — and the other 4 are the (b) two-load LUID tie. Both closed
routes in the w62 certificate hold as written.

SIX NEW FALSIFICATIONS of the w63 "manufacture a higher-priority rival that takes `$a0` first"
family (all 17 and byte-identical unless noted): an IDENTITY FENCE on `flag` as the literal FIRST
statement of the function (the 12A preference killer, placed where the parm copy IS the fenced
insn — 17, so killing the preference is NOT sufficient: `find_reg`'s plain ascending scan hands
`$a0` anyway once `$v0`/`$v1` are taken); the same fence DOUBLED; a named `off` temp for the
`_padSioChan * 0xf0` product; a named `c0` channel temp; `c0` + an identity launder (22 @61 — it
does manufacture a rival, but a CALLEE-saved one); fence + `c0` together.

`qty272` on the current source: p72 = `flag`, refs 7 / live 13 / pri 10769, rank 4, `preferences: 4`,
hard conflicts {2, 29}. `$v0` is barred by p73, `$v1` by p77, so `$a0` is both the preference AND
the first free register — two independent reasons. **SHARPENED ANGLE:** the rival must be a
GLOBAL allocno, born in the entry block, NOT call-crossing, ranked above 4, and conflicting with
`flag`. Every value live in insns 1..20 today that could take a caller-saved home is block-local,
and `local_alloc` (which runs first) parks those in `$v0`/`$v1` and never reaches `$a0`.

## 4. `_pad_getbyte` 5 — the class is now 18 spellings deep, and sharper

SIX NEW FALSIFICATIONS, all 5 @44/47 and byte-identical: case 0 exiting with `goto deref;` while
'M' keeps `break` (the very lever that sealed `_pad_filter` this wave — it reaches
`duplicate_loop_exit_test`, it does NOT reach `do_cross_jump`); the mirror; BOTH arms
`goto deref`; a void-tail fence in the 'M' arm's tail; a read-only fence on `buf` in the 'M' arm;
a void-tail fence immediately before the shared `return buf[idx]` (8 @45 — the only non-neutral
one, and worse).

**NEW OBSERVATION that sharpens the angle:** ours does not merge in the wrong DIRECTION only —
it merges **one insn DEEPER**. Retail's surviving copy starts at the `lbu` (`.L800FE058`) and the
'M' arm keeps its OWN `addu $v0,$v0,$v1` in the `j`'s delay slot; ours merges `addu` + `lbu`
together, which is why we are 3 short rather than 1. Both arms' `addu`s are textually identical
post-reload, so retail's `find_cross_jump` STOPPED one insn early. That, not the direction, is
the cheapest thing left to explain, and it is a `jump.c` input question.

## 5. `_padLoadActInfo_rcv` 14 — the named 2.8.0+nosplit re-derivation EXECUTED

Probed through the w63-a8 `PER_FN_VERFLAG_SPLICE_272` harness (copied to
`scratchpad/w64a7/verflag.py`; `build.py` untouched), key `"2.8.0|-mno-split-addresses"`:

| variant | 2.8+nosplit basin |
|---|---|
| shipped 3 devices | 28 @157/157 (w63's number, reproduced) |
| − the `cnt` opacity fence | **26** — the fence is HARMFUL there |
| − the `hi` opacity fence | 28 (inert there; the wired rung still wants it) |
| − the `hi` local entirely | 30 |
| − the anchor assigned OUTSIDE the guard | 32 (load-bearing in BOTH basins) |
| − the anchor local altogether | 28 |
| − `cnt` fence AND `hi` fence | **26** (basin best) |
| − all three | 30 |

**AND the `cnt` fence's in-source premise is WRONG in both basins.** Its rationale reads "retail
rematerializes, `sllv` is the tell" — but the ORACLE HAS NO `sllv`: both `woff` shifts are
`sll $v0,$v0,3` (0x80105AC0, 0x80105B04). In the 2.8 basin OURS emits `sllv $v0,$v0,$a0` with or
without the fence (cse substitutes `cnt`'s live 3 for the literal), so the device is aimed at a
real defect but does not cure it there. Four statement POSITIONS of `cnt = 3;` measured against
that fold: top of block 26, end of block 28, after the `woff` if/else 28, end + fence 27 @158 —
position is not the dial.

**VERDICT: 26 @157 count-exact is that basin's floor as of this wave — still 12 worse than the
wired 14 @155 — so NOTHING is wired and the shipped source is unchanged.** The named next step
is unchanged in KIND but sharper in CONTENT: the 2.8+nosplit basin needs its OWN cure for the
`cnt`-into-`sll` cse substitution (a non-fence one), not a transplant of the 970404 device.

Also falsified on the WIRED rung against residual item (iv) (`la $a3,_actcur` separate-scratch vs
retail's self-temp — the catalog-E sized-vs-scalar `%hi`-scratch family): a sized `*_actcur[1]`
with array-decay anchor, the same with `&_actcur[0]`, and a `(unsigned char **)&_actcur` cast
anchor on the scalar — all three 14 and byte-identical. The `section(".bss")` attribute already
fixes the storage shape, so the declaration-shape family is CLOSED for this symbol.

## 6. CERTIFICATES VERIFIED (no change requested, none made)

* `_dirSendAuto` — **already PASS 64/64**; the "99.92" row is stale in the board's direction.
* `_padInitDirSeq` — FAIL 3 @14/13, shape unchanged (oracle
  `lui $at,%hi(SYM); jr $ra; sw $v0,%lo(SYM)($at)`). The w63 TEXT_MOVES falsification (the
  spliced row gates 2 @13/13 but `objdump` shows BOTH macro halves land past the `jr`, so
  `_padFuncRecvAuto` is never written = a semantically dead function) stands; do not wire it.
* `_dirCheck` / `_dirFailAuto` — both PASS; the w63 `PER_FN_TEXT_MOVES` row for `_dirCheck` is
  wired and holding (11/11).
* `_padIntRecvData` / `_padIntRecvHdr` — both PASS (223 / 35). The briefed 99.98 / 99.71 rows are
  stale; they were already corrected in w63-a8 and are still PASS.

## 6b. NEW FINDING — two MCXMAIN gate-PASS fns carry WRONG BRANCH WORDS (04Q), one now FIXED

`tools/brdist.py` on MCXMAIN.c reports offset divergences on **both** fns the assignment asked me
to verify, and both gate PASS:

* `_padIntRecvHdr` PASS 35/35, rows `(1, 6, 7)` and `(2, 4, 5)`
* `_padIntRecvData` PASS 223/223, row `(13, 34, 35)`

**ROOT-CAUSED for `_padIntRecvHdr`: it is LABEL PLACEMENT, not code.** cc1 emits `$L19:` BEFORE
the merge-point `addu $2,$3,$0`, so our `beq`/`beqz` land ON the copy; retail's label sits AFTER
it (`.L8010C304` is the `lw $ra`), so retail's branches SKIP it — legal there because the first
branch's delay slot already performed the copy. Semantically identical, two different branch
words. This is the 04Q gate blind spot in pure form, on a function the board calls done.

**FIX PROVEN (orchestrator action, spec at `scratchpad/w64a7/SPEC_text_moves_padIntRecvHdr_label.json`):**
one extra `PER_FN_TEXT_MOVES` row appended after the already-wired w62 `copy`+`slot` row, moving
the LABEL LINE past the copy (the 15-series "labels ARE movable lines" generalisation). Measured
with `scratchpad/w64a7/tmprobe.py` / `tmbrdist.py` (in-memory table patch; `build.py` never
edited), each run twice and identical: WITHOUT = PASS + 2 offset rows, WITH = **PASS + 0 offset
rows**, whole TU **5/5 PASS, zero regressions**. Anchors are `$L`-number agnostic and
lookahead-pinned on both sides, each occurring exactly once in the function.

`_padIntRecvData`'s single row is the same family (its `beqz $v0` targets the merge-point
`addu $4,$17,$0` at obj 0x4a4 where retail targets the following `lui` at 0x4a8) — a different
label, not probed; named follow-up.

**LAW CANDIDATE (§F / 04Q):** *a `copy`+`slot` TEXT_MOVES row reproduces the vendor assembler's
duplicated insn but NOT its label placement — the merge label stays where cc1 put it, so every
branch to that label keeps the wrong offset. Gate-PASS + a brdist offset row on a fn carrying a
`copy` row means the LABEL needs its own move.*

## 7. CORPUS SWEEP (coordinator request, capped; verdict CONFIRMED INDEPENDENTLY)

Ran a SEMANTIC (not name-grep) sweep over **all 21 repos** in `C:\Temp\ps1-decomp-refs` for the
SIO0 pad driver: the register-block literals `0x1F80104x`, the ctrl words `0x1003`/`0x3003`, and
libpad-internal symbol names. **Exactly two hits tree-wide**, one irrelevant
(`parasite-eve-decomp/.../dtail_gp.c`) and one = `rood-reverse/src/SLUS_010.40/libpad/` — which
has the SAME SEVEN TU NAMES as ours (PADMAIN/PADCMD/PADPORTD/PADSEQD/PADENTRY/PADIF/WAITRC2) and
is **100% `INCLUDE_ASM`, zero matched C** (64 entries). The four new repos:
`mgs_reversing`'s `lib*` dirs are Konami's OWN libraries (libgv/libdg/libhzd/libgcl/libfs/libsio)
and `libsio` is a serial-DEBUG stub, not SIO0/pad — mgs only CALLS `PadInitDirect`/`PadStartCom`/
`PadStopCom`; `KAIN2`, `TOMB5` and `VandalHearts-PcPort` contain no SIO0 register access and no
PsyQ library sources. No `$Id:` revision strings exist in any of the four, so the 15F revision
check is moot. **The libpad corpus-miss verdict stands, now on semantic grounds.**

## 8. ORCHESTRATOR ACTIONS

**ONE, PROVEN:** append the `_padIntRecvHdr` LABEL-MOVE row from
`scratchpad/w64a7/SPEC_text_moves_padIntRecvHdr_label.json` to the EXISTING
`PER_FN_TEXT_MOVES["recon/syslib/psx/libpad/MCXMAIN.c"]["_padIntRecvHdr"]` list (append, do NOT
add a second dict key — 12F). It costs nothing on the gate (PASS either way) and removes the
function's two wrong branch words; whole-TU 5/5, zero regressions, measured twice.

Nothing else is recommended:
* `_padInitSioMode`'s frame cure is a SOURCE device, and `-fno-rerun-cse-after-loop` (which
  produces the identical object) is therefore redundant — do not add a flag key for it.
* `_padLoadActInfo_rcv`'s `PER_FN_VERFLAG_SPLICE_272` mechanism (w63-a8's spec) remains
  IMPLEMENT-BUT-WIRE-NOTHING: measured 26 @157 at best vs the wired 14 @155.
* `_padInitDirSeq`'s TEXT_MOVES row stays UNWIRED (semantically dead splice, w63-a7).

## 9. CATALOG-ROW CANDIDATES

1. **§B — GOTO-vs-BREAK / `duplicate_loop_exit_test`.** *Symptom:* the guarded do-while you read
   off the oracle costs +4 insns and rotates a register band, and the only difference from a
   sibling loop that matches is an early `break`. *Fix:* spell the early exit as a `goto` to a
   label after the loop (or move the bound test into an ordinary `if` at the bottom of a
   `while (1)`) so the loop keeps ONE exit edge. `_pad_filter` 3 -> PASS; retires four waves of
   guarded-do-while falsifications.
2. **§A — THE DEPTH WRAPPER IS THE TIE-BREAKER OF LAST RESORT.** `flow.c` weights refs by loop
   depth MULTIPLICATIVELY while the LOOP_BEG/END notes lengthen live ranges ADDITIVELY, so a
   `do{}while(0)` around a block SEPARATES two allocnos that are at an EXACT priority tie — a
   situation in which every dial that scales both sides equally is provably inert. Depths 2 and 3
   measure identical to depth 1 (one level is the whole dial). Cost = the notes' scheduling
   barrier (here 2 unfilled load-delay slots). `_padInitSioMode` −11 diff lines.
3. **§A/§G — gcc-2.7.2 ORPHANED-PSEUDO PHANTOM FRAME.** *Symptom:* `.frame` shows `vars= N` that
   no instruction references, on a 2.6/2.7 rung only, and the fn contains a loop with a call whose
   exit test reads `global_array[global_index]`. *Cause:* cse2 folds the subscript's address
   pseudo into the MEM; gcc-2.7.2 never recomputes reg usage after combine, so the orphan keeps
   `REG_N_REFS > 0`, `regclass`'s all-zero-cost tie-break gives it the SMALLEST class (`ST_REGS`
   on MIPS), it never gets a hard reg and reload slots it. *Fix:* spell the read as
   `*(T *)((idx << log2(sizeof T)) + (int)arr)` (the `* sizeof` form does NOT work — it routes
   through `pointer_int_sum` and recreates the pseudo). *Confirm:* `-fno-rerun-cse-after-loop`
   produces a byte-identical object.
4. **§G — a "retail rematerializes / the tell is `X`" receipt is falsifiable against the oracle.**
   `_padLoadActInfo_rcv`'s `cnt` fence has been carried for three waves on the premise that the
   oracle uses `sllv`; the oracle uses `sll ,3` at both sites. Re-read the oracle before
   transplanting a device into a new basin.

## 10. FILES / HAZARDS

* Touched + committed: `recon/syslib/psx/libpad/PADPORTD.c` (`cce926bb`, `6701e377`),
  `recon/syslib/psx/libpad/PADMAIN.c` (`b295b431`, `4d8c3404`),
  `recon/syslib/psx/libpad/PADCMD.c` (`3cfdbb85`).
* Scratchpad (all re-runnable): `probe.py` / `probe2.py` (multi-anchor) / `probe3.py`
  (multi-anchor + VERFLAG rung/flag key) · `verflag.py` (the w63-a8 harness, renamed env
  `W64A7_VERFLAG`) · `v_*.py` (every variant set behind every falsification above) ·
  `lab/` (`fr.py` = one-shot rung-cc1 `.frame` reader, `bisect*.py`, `sweep_*.py`,
  `mini.i`/`hdr.txt`/`fnbody.txt` = the phantom-frame bisection corpus and the 13-line repro) ·
  `PADMAIN.c.base.bak`, `PADMAIN.c.prew1.bak`.
* **HAZARD THAT FIRED (again, 4th+ recorded firing): a receipt paragraph ending in `*/` closed
  its host comment** — PADPORTD.c compiled as garbage with errors pointing 60 lines away. Caught
  by the mandatory post-edit gate. Fix: never end an appended paragraph with `*/`.
* Byte hygiene checked after every scripted edit (0 NULs, 0 control bytes, line-ending regime
  preserved per file: PADPORTD/PADMAIN pure CRLF, PADCMD pure LF as it already was).
* No `git stash` / `checkout` outside my own files; `tools/*.py` never edited; memory dir
  READ-ONLY; user-live TUs untouched.
