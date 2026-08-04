# WAVE-48 agent a4 — syslib/libpad part B (PADPORTD/PADSEQD/PADENTRY/MCXMAIN)

Gate = `python tools/verify_asm.py <file> <fns>` from the worktree root, base a12f7b8b.

## 0. RE-GATED BASELINE (2026-08-04, all 19 in scope)
| TU | fn | worklist% | GATE baseline |
|---|---|---|---|
| PADPORTD | PadInitDirect      | 79.28 | FAIL 55 (85/88) |
| PADPORTD | _pad_reset_state   | 96.15 | FAIL 1 (25/26) |
| PADPORTD | _pad_failall       | 65.84 | FAIL 45 (58/61) |
| PADPORTD | _pad_getbyte       | 29.53 | FAIL 40 (47/47) |
| PADPORTD | _pad_filter        | 1.87  | FAIL 201 (164/159) |
| PADPORTD | _pad_port_to_slot  | 48.07 | FAIL 18 (14/14) |
| PADSEQD  | _padInitDirSeq     | 87.69 | FAIL 3 (14/13) |
| PADSEQD  | _dirSendAuto       | 76.69 | FAIL 32 (62/64) |
| PADSEQD  | _dirRecvAuto       | 68.45 | FAIL 103 (139/148) |
| PADSEQD  | _dirFailAuto       | 30.69 | FAIL 65 (56/55) |
| PADSEQD  | _dirCheck          | 35.91 | FAIL 5 (12/11) |
| PADENTRY | PadGetState        | 84.69 | FAIL 10 (50/48) |
| PADENTRY | PadInfoMode        | 64.65 | FAIL 42 (58/62) |
| PADENTRY | PadInfoAct         | 95.28 | FAIL 20 (53/53) |
| MCXMAIN  | _padIntInit        | 77.22 | FAIL 6 (18/18) |
| MCXMAIN  | _padIntQuery       | 90.19 | FAIL 8 (52/54) |
| MCXMAIN  | _padIntRecvId      | 93.23 | FAIL 13 (47/48) |
| MCXMAIN  | _padIntRecvHdr     | 96.43 | FAIL 4 (35/35) |
| MCXMAIN  | _padIntRecvData    | 54.07 | FAIL 289 (232/223) |

Worklist fuzzy% is again uncorrelated with the gate (35.91% = 5 diffs; 96.43% = 4 diffs).

## 1. HARNESSES (scratch/, all restore-in-finally, CRLF-preserving)
- `w48_a4_probe.py`  — per-FN `-fno-delayed-branch` splice probe (patches
  tools/build.py's PER_FN_NO_DELAYED_BRANCH, whole-TU gate, restores).
- `w48_a4_var.py`    — single-variant body swap + whole-TU gate (`SBS=<fn>` env
  switches the report to tools/side_by_side.py).
- `w48_a4_sweep.py`  — N candidate bodies from a directory, one gate line each,
  with the other TU fns' diffs on the same line (zero-regression check built in).

## 2. LANDED
### _dirCheck  5 (12/11)  ->  4 (11/11 count-exact)   [commit below]
The in-source "scheduling FLOOR (5 diffs)" note was WRONG: it was a STRUCTURE miss.
`if (A || B) return 1; return 0;` emits TWO `jr ra` return blocks; the oracle has ONE
shared epilogue with `addu v0,zero,zero` in the beq delay slot and `li v0,1` at the
fall-through label = the De-Morgan EARLY-OUT `if (!A && !B) return 0; return 1;`
(11/11, 6 diffs).  `int ff = 0xff;` (catalog NAMED-ONE) then moves the byte load onto
the oracle's $v1: 6 -> 4.
RESIDUAL 4 = `li a1,255 / beq v1,a1` vs `li v0,255 / beq v1,v0`.  `-dg` receipt:
`81 conflicts: 80 81 2 3 29` -- the constant's allocno carries a HARD-REG conflict with
$v0(2), so this is the w46 "hard-reg conflict beats every allocno dial" class, not a
priority razor.  NEXT ANGLE recorded in-source.
FALSIFIED at this basin (all whole-TU gated, other 4 fns unchanged at 3/32/103/65):
 yoda 6 · nested-if block scope 6 · `(int)` cast 6 · unsigned-char const 6 · byte-local
 12 · decl-after-guard 12 · shared word/const pseudo (3 spellings) 8 (merged pseudo -> $a1)
 · opacity fence on ff 5 @12 insns · fence in nested-reuse 8 · pre-loaded byte local 8 @9.
Per-fn `-fno-delayed-branch` splice on _dirCheck: 5 -> 9 (REGRESSION, not adopted).

## 3. FLAG-AXIS (report-only; build.py restored after every probe — `git status` clean)
Harness `scratch/w48_a4_flag.py` (MERGES with any pre-existing PER_TU_FLAGS entry for
the TU — the w47-04G duplicate-key hazard; PADENTRY already carries `jtbl_at_fusion`).

### 🏆 PADENTRY.c wants `-mno-split-addresses` — IDENTITY (w47 bar: FAIL->PASS)
Whole-TU, all 8 oracles, reproduced 3x (byte-identical output):
| fn | BASE | nosplit |
|---|---|---|
| PadStartCom     | PASS | PASS |
| PadStopCom      | PASS | PASS |
| PadGetState     | FAIL 10 (50/48) | FAIL 10 (50/48) |
| PadInfoMode     | FAIL 42 (58/62) | FAIL 42 (58/62) |
| **PadInfoAct**  | **FAIL 20 (53/53)** | **PASS (53 insns)** |
| PadSetActAlign  | PASS | PASS |
| PadSetMainMode  | PASS | PASS |
| PadSetAct       | PASS | PASS |
=> 5 -> 6 PASS, 72 -> 52 diffs, ZERO regressions.  Coexists with the TU's existing
`jtbl_at_fusion` (PadInfoAct is the jump-table fn and PASSes with BOTH keys set).
Independently concordant with a9's 64-TU ladder (PADENTRY nosplit 6 PASS/52) and with
a1 (libmcrd) + a2 (libgpu SYS/FONT) finding the same flag is the syslib identity.
RECOMMEND WIRING: `"recon/syslib/psx/libpad/PADENTRY.c": {"jtbl_at_fusion": True,
"no_split_addresses": True}` (ONE dict entry — do not add a second key line).

### The other three TUs: NOT nosplit objects (per-fn receipts)
- PADPORTD  360 -> 358: PadInitDirect 55->51 but _pad_failall 45->47 (56 vs 58 insns).
  Mixed nudge, no conversion => below the identity bar. NOT recommended.
- PADSEQD   208 -> 208: byte-identical on all 5 fns. Fully INERT.
- MCXMAIN   320 -> 322: _padIntRecvData 289->291, rest identical. Slightly worse.
Also inert/worse for my TUs per a9's ladder: -G0, -G8, -fno-schedule-insns{,2}, -O1.
`-fno-delayed-branch` whole-TU: PADPORTD 360->417 (2->1 PASS), PADSEQD 208->276,
MCXMAIN 320->431, PADENTRY 72->125 — uniformly catastrophic, concordant with a3's
"splice EXHAUSTED on libpad-A" (0 wins / 20 worse / 9 PASS-regressions).

## 4. ASSEMBLER-CLASS EXHIBITS FOR a10/a6 (do not grind from source)
- **_padInitDirSeq (PADSEQD, 3 diffs @14/13)** is the minimal exhibit of a6's
  macro-split-into-delay-slot class: oracle `lui $at,%hi(_padFuncRecvAuto); jr $ra;
  sw $v0,%lo(_padFuncRecvAuto)($at)` — the assembler SPLIT the `sw $v0,sym` macro
  ACROSS the `jr` and put the store in the slot.  cc1 can never do this (it sees one
  macro insn), and maspsx forces `.set noreorder` so GNU as can't either.  a6's
  real-ASPSX run (647e2e3d) already spec'd `maspsx --aspsx-reorder-fill` for exactly
  this; this fn is a 13-instruction regression test for that patch.  NOT source-reachable:
  the store-side `$at` lever (catalog w42 §E, `extern T G[]` + `G[0]=v`) moves us the
  WRONG way here — retail's form IS the `$at` macro, only the slot differs.
- **_pad_reset_state (PADPORTD, 1 diff @25/26)** is a clean 2-SLOT DISCRIMINATOR for
  the same lane: the ONLY diff is that reorg steals the fall-through block's first insn
  (`addiu v1,a0,93`) into the guard's `beqz` delay slot, where retail leaves `nop`.
  Under a per-fn `-fno-delayed-branch` splice the guard slot matches EXACTLY (nop) and
  the sole remaining diff becomes the do-while loop's own `addiu v1,v1,1` -> `bgez` slot
  (3 diffs @27/26).  So this fn needs delayed-branch OFF *and* a same-block backward
  fill — i.e. if real ASPSX fills from the immediately-preceding insn of the SAME block
  (a6 tested the macro-split case, not this one), this fn goes to PASS.  a10/a6: please
  test that specific behaviour.  Source-side falsifications at this basin (all 1 diff,
  whole-TU clean): early-out inversion, volatile guard read, `p` assigned after the
  stores (13), store-the-tested-byte-first, `while` instead of `do/while`, opacity fence
  at the block head (13).

## 5. LANDED (running ledger)
| fn | baseline | now | lever |
|---|---|---|---|
| _dirCheck        | 5 (12/11) | **4 (11/11)** | De-Morgan early-out (one shared epilogue) + NAMED-ONE const |
| _pad_port_to_slot| 18 (14/14)| **6 (14/14)** | do-while + separate `i=0` + PRE-SET-THE-DEFAULT found-arm + info-last |
| _padIntInit      | 6 (18/18) | **PASS**      | named call-result/rx temps, deref BEFORE the global store |
| _padIntQuery     | 8 (52/54) | **PASS**      | TWO cross-jump-merged calls (`!=0` arm first), not a ternary arg |
| _padIntRecvId    | 13 (47/48)| **PASS**      | direct per-path returns (no funnel copy) + `<<1` folded into lo |
| PadInfoMode      | 42 (58/62)| **PASS**      | real `switch(term)` (balance_case_nodes tree + out-of-line bodies) |
| PadGetState      | 10 (50/48)| 10            | re-gated; splice trade-off quantified -> epilogue-swap lane |
| _padIntRecvHdr   | 4 (35/35) | 4             | 9 spellings byte-identical -> reorg duplicate-placement class |
| _pad_reset_state | 1 (25/26) | 1             | reorg fall-through steal; 2-slot discriminator for a10/a6 |
| _padInitDirSeq   | 3 (14/13) | 3             | a6's macro-split-into-delay-slot class (maspsx blocker) |

PADENTRY under the recommended `-mno-split-addresses` wiring is now **7/8 PASS**
(only PadGetState left).  MCXMAIN is **3/5 PASS**.

## 6. FINAL LEDGER (re-gated on the final tree, base basin, 2026-08-04)
| TU | fn | baseline | FINAL |
|---|---|---|---|
| PADPORTD | PadInitDirect      | 55 (85/88)   | 55 |
| PADPORTD | _pad_reset_state   | 1  (25/26)   | 1 |
| PADPORTD | _pad_failall       | 45 (58/61)   | **34 (59/61)** |
| PADPORTD | _pad_getbyte       | 40 (47/47)   | **20 (51/47)** |
| PADPORTD | _pad_filter        | 201 (164/159)| 201 |
| PADPORTD | _pad_port_to_slot  | 18 (14/14)   | **6 (14/14)** |
| PADSEQD  | _padInitDirSeq     | 3  (14/13)   | 3 |
| PADSEQD  | _dirSendAuto       | 32 (62/64)   | **PASS (64)** |
| PADSEQD  | _dirRecvAuto       | 103 (139/148)| 103 |
| PADSEQD  | _dirFailAuto       | 65 (56/55)   | **3 (56/55)** |
| PADSEQD  | _dirCheck          | 5  (12/11)   | **4 (11/11)** |
| PADENTRY | PadGetState        | 10 (50/48)   | 10 |
| PADENTRY | PadInfoMode        | 42 (58/62)   | **PASS (62)** |
| PADENTRY | PadInfoAct         | 20 (53/53)   | 20 — **PASS under the recommended nosplit wiring** |
| MCXMAIN  | _padIntInit        | 6  (18/18)   | **PASS (18)** |
| MCXMAIN  | _padIntQuery       | 8  (52/54)   | **PASS (54)** |
| MCXMAIN  | _padIntRecvId      | 13 (47/48)   | **PASS (48)** |
| MCXMAIN  | _padIntRecvHdr     | 4  (35/35)   | 4 |
| MCXMAIN  | _padIntRecvData    | 289 (232/223)| 289 |

**In-scope totals: 960 -> 753 diffs (-207); +5 gate PASS (+6 = 733 once PADENTRY's
`-mno-split-addresses` is wired).  ZERO regressions** — every TU whole-gated after every
landed edit; the two already-PASSing PADPORTD fns (_pad_get_port, _pad_shift) and all five
already-PASSing PADENTRY fns held throughout.  `tools/build.py` is byte-unchanged
(`git diff HEAD -- tools/build.py` empty): every flag/splice measurement was patch-in-place
with a finally-restore.

### THE RECURRING LEVER OF THIS CLUSTER: libpad dispatches are REAL `switch`es
Three of the five PASSes and the biggest diff cuts came from the same recognition — a
byte/state dispatch reconstructed as an if/else-if cascade when the oracle shows gcc-2.8's
`balance_case_nodes` fingerprint (median-pivot `beq` + a `slti` bound test in its delay slot,
every case body OUT-OF-LINE in SOURCE order, unconditional `j default`):
PadInfoMode {1,2,3,4,100} 42->PASS · _dirSendAuto {0,1,0xfe,0xff} 32->PASS ·
_pad_getbyte {0,'M'} 40->20 (2-node linear chain, no bound test).
An if/else-if inlines the first case as the fall-through and inverts its branch — a signature
worth grepping for across the rest of libpad/libcd.

### Other transferable levers landed here
- **Load-before-store around a call's return value** (_padIntInit PASS): deref/arg loads BEFORE
  storing the call result keeps the result in $v0 and the load in $v1.
- **Value-select in a call argument = TWO cross-jump-merged calls** (_padIntQuery PASS), arm
  order load-bearing.
- **Direct per-path returns beat a result funnel** when the oracle's shared epilogue has no
  return copy (_padIntRecvId PASS).
- **PRE-SET THE DEFAULT BEFORE THE TEST** turns a found-arm into a single
  `(set v0,K)(jump)` block that reorg eager-steals into the branch slot (_pad_port_to_slot).
- **w47 opacity fence** reproducing retail's redundant param copy (_dirSendAuto PASS) and
  fixing a two-constant materialization order (_dirFailAuto 7->3).
- **NAME a loop-invariant literal** to get retail's callee-saved sentinel + frame size
  (_pad_failall: frame 0x20->0x28, 4th saved reg, 45->34).
- **Read a pointer at its USE SITE, not the top** — hoisting it made it live across a call and
  cost a saved register + 8 frame bytes (_dirFailAuto).

### Residual classes (named, with next angles)
1. **combine_regs self-temp refusal** (`lui $v0; addiu $sN,$v0` vs retail `lui $sN; addiu
   $sN,$sN`): _pad_port_to_slot (1 site) + _pad_failall (2 sites). The lo_sum's destination is a
   loop-carried GLOBAL allocno, and combine_regs will not tie the {high, lo_sum} pair then
   (w47 delete_noop_moves law). Same class, two functions — worth one shared attack.
2. **Assembler/epilogue lane (a10/a6)**: _padInitDirSeq (3) = the macro-split-into-delay-slot
   class a6 already spec'd `maspsx --aspsx-reorder-fill` for; _pad_reset_state (1) = a
   2-slot discriminator that needs delayed-branch OFF *plus* a same-block backward fill;
   PadGetState (10) = the same epilogue-swap shape, with the splice trade-off quantified.
3. **reorg duplicate-placement** (_padIntRecvHdr 4): which of two branches gets the duplicated
   return copy. Nine spellings byte-identical.
4. **jump.c return-threading on a frameless leaf** (_pad_getbyte, +4 insns): every `return`
   site gets its own threaded `jr ra; nop`; retail keeps one shared epilogue block.
5. **Not attempted this wave** (re-gated baselines only): _pad_filter 201, _dirRecvAuto 103,
   _padIntRecvData 289, PadInitDirect 55. For PadInitDirect the identified lever is the
   catalog's BASE-ANCHOR class — retail walks `$a0 = info + 0x40` and reaches the struct with
   NEGATIVE displacements (-0x34/-0x30/-0x10/-0x4/0) plus a second `$s0` walker; a first
   attempt at that rewrite measured WORSE (88 @96/88) and was reverted, so the anchor needs to
   be introduced together with the per-iteration rx/buf2 setup, not as pre-loop walkers.
6. **_pad_failall next-angle FALSIFIED**: splitting the reassigned param into its own loop
   variable (`int f = flag;`) does NOT produce retail's `addu $a1,$a0,$zero` param copy
   (34 diffs, unchanged; with an added opacity fence 36).
