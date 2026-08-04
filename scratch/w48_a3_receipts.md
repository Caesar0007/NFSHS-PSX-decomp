# WAVE-48 agent a3 — syslib/libpad part A (PADMAIN 11 · PADCMD 19 · PAD 2 · WAITRC2 2)

Worktree `C:/Temp/nfs4-wt48-a3`, branch `w48-a3`, base `a12f7b8b`.
Gate = `python tools/verify_asm.py <file> <names>` from the worktree root (sole authority).

---

## 0. RE-GATED BASELINE (2026-08-04, worktree HEAD = base)

Worklist fuzzy% was wrong on at least 2 rows again (`_padWaitRXready` 99.50% is an
outright **PASS**; the PAD rows are `NOT IN OBJECT`, not 0%-matches).

### PADMAIN.c (whole TU, 11 fns)
| fn | worklist | RE-GATED baseline |
|---|---|---|
| _padSetVsyncParam | 92.91% | FAIL 16 (11/11 count-exact) |
| _padVbCallback1 | 95.38% | FAIL 4 (26/26 count-exact) |
| _padVbCallback0 | 85.37% | FAIL 28 (87/91) |
| _padStartCom | 74.27% | FAIL 23 (52/51) |
| _padStopCom | 84.35% | FAIL 6 (19/17) |
| _padInitSioMode | 62.27% | FAIL 227 (192/205) |
| _padSioMain | 54.28% | FAIL 45 (53/50) |
| _padSioRW | 42.25% | FAIL 137 (113/118) |
| _padSioRW2 | 26.63% | FAIL 157 (135/142) |
| _padClrIntSio0 | 24.86% | FAIL 24 (34/36) |
| _padWaitRXready | 99.50% | **PASS (10 insns)** — worklist row wrong |

### PADCMD.c (whole TU, 19 fns; 9 already PASS)
| fn | worklist | RE-GATED baseline |
|---|---|---|
| _padSetAct / _padCmdParaMode / _padCmdGetStatus / _padCmdSetMap / _padCmdGetDescR0 / _padCmdGetDescR1 / _padCmd4B / _padGetActSize / _padSetActAlign_snd | — | PASS (3/8/5/8/8/8/5/14/7 insns) |
| _padSendAtLoadInfo | 45.88% | FAIL 30 (31/33) |
| _padRecvAtLoadInfo | 21.94% | FAIL 105 (76/83) |
| _padLoadActInfo | 69.45% | FAIL 37 (54/53) |
| _padLoadActInfo_snd | 57.48% | FAIL 22 (40/42) |
| _padLoadActInfo_rcv | 34.29% | FAIL 175 (134/157) |
| _padSetActAlign | 97.69% | FAIL 2 (26/26 count-exact) |
| _padSetActAlign_rcv | 82.96% | FAIL 32 (52/50) |
| _padSetMainMode | 58.21% | FAIL 21 (35/38) |
| _padSetMainMode_snd | 86.67% | FAIL 7 (20/21) |
| _padSetMainMode_rcv | 32.50% | FAIL 19 (23/24) |

### WAITRC2.c
| fn | worklist | RE-GATED baseline |
|---|---|---|
| setRC2wait | 67.50% | FAIL 4 (10/8) |
| chkRC2wait | 83.12% | FAIL 25 (41/40) |

### PAD.c
`PAD_convert` (@0x800E41FC) and `ReadInitPadFlag` (@0x8010C9B0) both gate
**NOT IN OBJECT** against `recon/syslib/psx/libpad/PAD.c` — that TU is the libpad
DATA module (zero functions). Attribution question, not a match question (§ below).

**Scope totals at baseline: 22 FAIL + 10 PASS across the 4 TUs.**

---

## 1. LEVER 1 — the CHARTER probe: per-fn `-fno-delayed-branch` splice.  **EXHAUSTED, NEGATIVE.**

Mechanism = `tools/build.py` `PER_FN_NO_DELAYED_BRANCH` (w25-a1 dual-compile splice:
compile the TU twice from the SAME `.i`, splice the named `.ent/.end` regions out of
the `-fno-delayed-branch` build into the normal build's `.s`). Probed patch-in-place
via `scratch/w48_a3_probe.py` (additive dict override after the literal, `finally`
restore + byte-equality assert). **`tools/build.py` is unmodified at HEAD.**

Base state already carries 5 wave-25 splice entries inside my scope:
`PADMAIN.c {_padStopCom, _padClrIntSio0}`, `PADCMD.c {_padSendAtLoadInfo,
_padLoadActInfo_snd, _padSetMainMode_rcv}` — those ARE the baselines above.

Probe = splice **every** fn of the TU at once (regions are independent, so one gate
run yields all per-fn deltas with zero cross-talk).

| TU / fn | baseline | splice-ALL | verdict |
|---|---|---|---|
| PADMAIN _padSetVsyncParam | 16 (11/11) | 17 (12/11) | WORSE (naked nop) |
| PADMAIN _padVbCallback1 | 4 (26/26) | 7 (29/26) | WORSE (+3 nops) |
| PADMAIN _padVbCallback0 | 28 (87/91) | 45 (92/91) | WORSE |
| PADMAIN _padStartCom | 23 (52/51) | 35 (56/51) | WORSE |
| PADMAIN _padStopCom | 6 | 6 | already spliced (no change) |
| PADMAIN _padInitSioMode | 227 (192/205) | 267 (208/205) | WORSE |
| PADMAIN _padSioMain | 45 (53/50) | 49 (57/50) | WORSE |
| PADMAIN _padSioRW | 137 (113/118) | 149 (117/118) | WORSE |
| PADMAIN _padSioRW2 | 157 (135/142) | 179 (143/142) | WORSE |
| PADMAIN _padClrIntSio0 | 24 | 24 | already spliced |
| PADMAIN _padWaitRXready | **PASS 10** | FAIL 1 (9/10) | **REGRESSION** — splice would break a PASS |
| PADCMD _padSetAct | PASS 3 | 3 (4/3) | REGRESSION |
| PADCMD _padCmdParaMode | PASS 8 | 3 (9/8) | REGRESSION |
| PADCMD _padCmdGetStatus | PASS 5 | 3 (6/5) | REGRESSION |
| PADCMD _padCmdSetMap | PASS 8 | 3 (9/8) | REGRESSION |
| PADCMD _padCmdGetDescR0/R1 | PASS 8 | 3 (9/8) | REGRESSION |
| PADCMD _padCmd4B | PASS 5 | 3 (6/5) | REGRESSION |
| PADCMD _padGetActSize | PASS 14 | 3 (15/14) | REGRESSION |
| PADCMD _padSetActAlign_snd | PASS 7 | 3 (8/7) | REGRESSION |
| PADCMD _padSendAtLoadInfo | 30 | 30 | already spliced |
| PADCMD _padRecvAtLoadInfo | 105 (76/83) | 132 (89/83) | WORSE |
| PADCMD _padLoadActInfo | 37 (54/53) | 48 (57/53) | WORSE |
| PADCMD _padLoadActInfo_snd | 22 | 22 | already spliced |
| PADCMD _padLoadActInfo_rcv | 175 (134/157) | 201 (144/157) | WORSE |
| PADCMD _padSetActAlign | 2 (26/26) | 13 (31/26) | WORSE (+5 nops) |
| PADCMD _padSetActAlign_rcv | 32 (52/50) | 49 (55/50) | WORSE |
| PADCMD _padSetMainMode | 21 (35/38) | 26 (40/38) | WORSE |
| PADCMD _padSetMainMode_snd | 7 (20/21) | 9 (24/21) | WORSE |
| PADCMD _padSetMainMode_rcv | 19 | 19 | already spliced |
| WAITRC2 setRC2wait | 4 (10/8) | 4 (10/8) | INERT (cc1 `.s` identical either way) |
| WAITRC2 chkRC2wait | 25 (41/40) | 30 (46/40) | WORSE |

🔴 **VERDICT (the charter's headline result): the per-fn `-fno-delayed-branch` splice
is EXHAUSTED on libpad-A.** 0 improvements / 20 regressions-or-worse / 1 inert /
5 already-wired-unchanged out of 26 probes. The nine PASSing PADCMD fns would all be
BROKEN by it (each gains exactly one naked `nop` — ours becomes oracle+1).

**What this means for the 04C law.** The 04C falsification returned the epilogue-swap
class "to the compiler side"; a3's measurement narrows that further: it is **not on the
`-fno-delayed-branch` axis at all** for this cluster. cc1 with delayed-branch OFF emits
a *naked nop* everywhere the oracle has a *real filled slot* — i.e. retail's slots here
were filled by SOMETHING, and it was not cc1-with-the-flag-off. Since 04C proved the
real ASPSX ladder (2.56/2.67/2.77/2.79, 17-option sweep) does not fill either, the
remaining candidates are (a) cc1 with delayed-branch **ON** but a different
allocation/schedule (i.e. an ordinary allocno/sched residual wearing an "epilogue"
costume), or (b) a still-unnamed build-step. **(a) is the working hypothesis** and is
what the rest of this wave's work tests, per-fn.

Also note the *shape* of my residuals: **`_padSetVsyncParam`, `_padVbCallback1`,
`_padSetActAlign` are already COUNT-EXACT**, so they carry no missing/extra slot at
all — they are pure register/schedule residuals, not epilogue-swap members. The
"epilogue swap" label on this cluster needs the per-fn audit in §2 below rather than a
blanket class treatment.
