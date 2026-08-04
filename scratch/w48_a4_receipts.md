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
