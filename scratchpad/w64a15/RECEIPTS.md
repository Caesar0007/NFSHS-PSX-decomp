# W64-A15 RECEIPTS — game/common misc + eaclib belt (EA dual-lane)

Base HEAD at start: `fbc974f7`. Every number below is MY OWN re-gated run
(`python tools/verify_asm.py`, `python tools/psyqproof.py`), never a board row.

---

## 0. RE-GATED BASELINES (all 12 assigned rows, before any edit)

| fn | TU | GATE baseline | psyqproof |
|---|---|---|---|
| SetupChunkBuildList__FP13DRender_tView | game/common/bworld.cpp | FAIL 7 (202/203) | — |
| Collide_DoActualObjectCollisionCheck__… | game/common/collide.cpp | FAIL 14 (763/765) | — |
| Collide_TestObjectVertices__… | game/common/collide.cpp | FAIL 8 (1164/1164) | — |
| NFS3_CheckForFileOperations__Fv | game/common/nfs3.cpp | FAIL 8 (21/21) | — |
| Draw__25tPMenuItemLeftRightSliderb | game/common/pausemenu.cpp | FAIL 8 (171/169) | — |
| Sim_MainGameLoop__Fv | game/common/sim.cpp | FAIL 6 (319/321) | — |
| SimQueue_SetCurrentInput__Fi | game/common/simqueue.cpp | FAIL 4 (48/48) | — |
| Stats_TrackEndGame__Fv | game/common/stats.cpp | FAIL 44 (232/232) | — |
| intarcsin | eaclib/psx/eacpsxz/asinfunc.**c** | FAIL 2 (48/48) | — |
| STREAM_cancelrequest | eaclib/psx/eacpsxz/stream.**c** | **PASS (173)** | **REAL=1 w88** |
| Cars_ResetCollidedCars__FP8Car_tObjii | game/common/cars.cpp | **PASS (280)** | **REAL=1 w15** |
| Cars_DoExtraCarCollisionProcessing__… | game/common/cars.cpp | **PASS (597)** | **REAL=1 w14** |

Every baseline reproduced the w63a15 map exactly — no stale rows in this belt.

---

## 1. ✅ THREE DUAL-LANE SEALS (gate PASS + psyqproof REAL=0)

All three were **gate-PASS already**; all three carried a WRONG BRANCH WORD that
`verify_asm` cannot see (04Q: branch targets normalise to `T`). None changed the
instruction count — every fix is a pure `jump.c` edge repair.

### 1.1 `STREAM_cancelrequest` (eacpsxz/stream.c) — commit `35f49bbb`
`REAL=1 word 88` → `REAL=0`. TU **32/32 PASS** (gated 2×).

The w63a15 §3.2 diagnosis was right and its cure is the **EXPLICIT-GOTO ZERO-TRIP
GUARD**. Retail's guard is `beq $s4,$s6,.L800FD7BC` — straight to the ci++ JOIN
(the same label the `ccount <= 0` blez skips to), not to this arm's loop-exit
block. A plain `while (p != s6)` generates the guard against the loop's own exit
label, and jump.c then forces a choice:

| form | gate | production |
|---|---|---|
| `while` + w48 void-tail fence (w63 control) | PASS 173/173 | REAL=1 **w88** |
| `while`, no fence | FAIL 2 | REAL=1 **w128** |
| **`if (p == s6) goto nextconsumer;` + do-while + fence** | **PASS 173/173** | **REAL=0** |
| goto-guard, NO fence | FAIL 2 | REAL=1 w128 |

i.e. without the fence `follow_jumps` forwards BOTH the guard and the loop-bottom
`beq` past `Lexit: j <join>`, killing the "conditional jump around an
unconditional jump" precondition so the back edge never inverts; with the fence
the back edge inverts but the GUARD is stranded on `Lexit`. Generating the guard
against the join label directly leaves nothing to forward, so both halves land.
**The fence stays load-bearing — the pairing is the seal.**

### 1.2 `Cars_ResetCollidedCars` (game/common/cars.cpp) — commit `a4887913`
`REAL=1 word 15` → `REAL=0`. 280/280 unchanged.

The blowout early-return must **REPEAT `(carObj->collision).smoking = 0;`** even
though the unconditional store two lines above already did it. The duplicate makes
`cross_jump` merge this arm's `sw $zero,0x78C($s2); j <epilogue>` tail with the
identical tail of the big early-return arm, and the merged block's LABEL lands
BEFORE the store, so the guard branches to `.L800867D0` (dist 75) like retail.
Without it our arm is a bare `j <epilogue>` and `follow_jumps` forwards the guard
all the way to the epilogue (dist 256). Count unchanged — the two tails merge back
to one copy.

### 1.3 `Cars_DoExtraCarCollisionProcessing` (same commit)
`REAL=1 word 14` → `REAL=0`. 597/597 unchanged.

The blowout RE-TEST belongs **INSIDE the `y != 0` arm as an inverted `goto`** over
the pull-over block, not as a following `if (carObj->blowout == 0) { … }` wrapper.
Retail's entry guard is `beqz $v1,.L80086BF0` (dist 31) = straight to the pullOver
`lw 0x278`, skipping the re-read of blowout; the wrapper form makes that guard
target the re-read block instead (dist 27). Both spellings emit the same 597 words.

Brace-free and bare-block spellings measured identical (both PASS / REAL=0); the
brace-free one was landed.

**TU cars.cpp 33/33 PASS (gated 2×); `brdist2` census 33 fns, 0 divergences.**

---

## 2. NEW NAMED ANGLES + BASINS (no floors claimed, nothing landed)

### 2.1 `SetupChunkBuildList` (bworld.cpp) — 7 @202/203 — **PASS NAMED** — commit `0f8d707e`
The sink is now **pinned to sched2** by a raw CC1PLPSX A/B
(`scratchpad/w64a15/cc1probe.py`, `-O2 -G4 -fno-exceptions -fno-rtti`):

```
default                sll ; addu $2,$2,$5 ; lbu ; addu $19,$3,$4 ; sw
-fno-schedule-insns2   sll ; addu $19,$3,$4 ; addu $2,$2,$5 ; lbu ; #nop ; sw
```

The **pre-sched2 order is ALREADY retail's** and cc1 itself marks the un-fillable
load-delay slot (`#nop`). sched2 swaps them because `addu $19` (viewList's biv
init, live-out into the loop, NO dependent inside the block ⇒ INSN_PRIORITY 0) is
the only insn ready at the lbu's stall while the count chain has priority 3.

🔴 **WHY NO FENCE CAN EVER REACH IT** (gcc-cited): `sched.c:2499 birthing_insn_p`
returns 0 outright once `reload_completed`, so sched2 has **no LAUNCH_PRIORITY
boost at all** — and a barrier does not change a priority. That is exactly why
every fence flavour/position re-colors (13/15/33) without ever moving the count
off 202.

+10 new falsifications receipted in-source (named `cc` local; statement swap;
u_char[] subscript; `(cc<<6)+(int)base`; count-address pointer local ± opacity
fence; identity/read-only fence on viewList in two positions; 2-operand
read-only fence; whole-TU `no_schedule_insns2` via vprobe = 44 @205).
The `volatile u_char` read remains the only count-exact form (18 @203) and it wins
by ADDING the VOLATILE-QImode `andi`, not by stopping the sink ⇒ not the basin.

**NEXT (named):** give `addu $19` a real dependent chain of length ≥3 inside the
block at zero bytes, or read the `-dR` sched2 ready list.

### 2.2 `Collide_DoActualObjectCollisionCheck` — 14 @763/765 — **COUNT-EXACT BASIN FOUND** — commit `e49ad60d`
Hoisting **both** `abs(dotx)`/`abs(doty)` blocks ABOVE the `dotz` assignment (at
both symmetric sites) gates **44 at 765/765 — COUNT-EXACT**, the first form ever
to reach retail's length. It restores both missing `nop`s, so the "ours 2 short"
half is a pure **statement-order** fact, not a delay-slot/fence question.
Reverted under the honest-count rule (44 > 14).

MECHANISM (mips.md `mulsi3_internal` dest constraint `"=l"`): the product pseudo
**lives in LO** across the abs blocks and the `mflo` is reload's move emitted at
the USE — so retail's shape needs the product's single use after the abs blocks
while the multiply itself sits before them.

New falsifications: z-product-only + x/y tail (526 @755); x/y partial + z tail
(86 @767); block-scoped `zprod`/`zpart` pair (108 @753); same without the fence
(106 @751) — the block scopes cost 10-14 insns of frame.

### 2.3 `Stats_TrackEndGame` — 44 @232/232 — **W62 CERTIFICATE CORRECTED** — commit `e8b1d273`
The W62 hardness certificate is *correct* but was aimed at the wrong pseudo — it
proved only that **DesiredSpeed's** cell is empty and never enumerated the rest of
the band. A complete two-pseudo sweep (`scratchpad/w64a15/statscells.py`, driving
allocsim/reqdelta directly — `multidial --search` is greedy AND refs-only, so it
structurally cannot see a live-only pair) finds **180 solution cells**:

* **NO solo cell exists** (exhaustive single-pseudo sweep, refs ±4 × live −6..+8).
* Every cell under cost 8 needs **`p101 (PlayerPosition) live +1`** paired with
  **`p103 (DesiredSlice) refs −1` or `live +2`**. `p101 live +1` is a razor —
  live 30 already breaks the band.
* The only pair not touching p101 is `p103 refs −1` AND `p104 live −4` (cost 8).

MEASURED: a zero-insn **foreign-operand fence** `__asm__("" : : "r"(trackSlices));`
right after PlayerPosition's def gates **52 at COUNT-EXACT 232/232** and lands
**2 of the 4 band members retail-correct** (p104=s4, p130=s6 — was 0 of 4).

🔴 **AND IT REFUTES THE 15A "+1 live for everything live across it" MODEL HERE:**
the measured deltas are p101 **+3**, p103 **−1**, p104 **−1**, p285 **+1** — the
fence RE-TIMES several ranges rather than uniformly lengthening them. Any future
live dial on this fn must be read off the dump, never predicted from the +1 rule.

Also measured: second-min through a fenced `sliceTot` temp = 153 @233 (the identity
fence MATERIALIZES at this site, so it is not a zero-cost ref dial); paired with the
fence = 157 @233. Nothing landed (52/153/157 all > 44).

---

## 3. NOT ADVANCED THIS RUN (re-gated, receipts read in full, no new spellings)

`Collide_TestObjectVertices` (8 @1164/1164), `NFS3_CheckForFileOperations`
(8 @21/21), `Draw__25tPMenuItemLeftRightSliderb` (8 @171/169), `Sim_MainGameLoop`
(6 @319/321), `SimQueue_SetCurrentInput` (4 @48/48), `intarcsin` (2 @48/48).

All six carry multi-wave falsification maps whose named next step is an INSTRUMENT
(`-dl` local-alloc handout / qtytrace / an RTL layout dump), not a spelling —
`intarcsin` alone has ~30 receipted spellings across 6 waves and a gcc-cited bound
(`local-alloc.c:1866 combine_regs`). Per AGENT_GUIDE §4.6 I added no spellings
there. **No floor is claimed on any of them.**

---

## 4. ORCHESTRATOR ACTIONS

1. **`tools/brdist.py` STILL CARRIES THE w63a15 ONE-CHARACTER DEFECT.** Its
   `ours_branches()` regex `\b([0-9a-f]{4,8})\b\s*<` cannot match an objdump target
   printed with 1-3 hex digits, so every branch in the first 4 KiB of an object is
   recorded `None` and silently skipped. w63a15 supplied the fix (`{4,8}` → `+`,
   copy at `scratchpad/w63a15/brdist2.py`) and it is still not in `tools/`. All
   three of this wave's dual-lane defects were found with brdist2 + psyqproof and
   are invisible to the shipped tool. **Recommend landing the one-character fix and
   re-running the census tree-wide** — every gate-PASS fn ever cleared by brdist is
   unaudited. (5th instance of "validate any census tool against a known-positive".)
2. **Catalog-row candidates** — see §5.
3. No `build.py` wiring is requested by this belt.

---

## 5. CATALOG-ROW CANDIDATES

1. **EXPLICIT-GOTO ZERO-TRIP GUARD (production class).** *Symptom:* gate PASS but
   psyqproof `REAL=1` on a loop's zero-trip guard word; the guard branches to the
   loop's own exit block where retail branches to the enclosing JOIN. *Cause:* a
   plain `while (c)` generates the guard against the loop-exit label, so
   `follow_jumps` must either forward BOTH the guard and the loop-bottom `beq`
   (killing the back-edge inversion) or, with a void-tail fence blocking it,
   invert the back edge and strand the guard. *Fix:* spell the guard as
   `if (!c) goto <join>;` + a do-while, and KEEP the fence. Both halves land at
   zero insns. [STREAM_cancelrequest]
2. **DUPLICATE THE SHARED STORE INTO THE EARLY-RETURN ARM to move a cross_jump
   merge label.** *Symptom:* gate PASS, `REAL=1`, our guard branch is forwarded
   past a store that retail's branch lands ON. *Fix:* repeat the (already
   idempotent) store inside the early-return arm — cross_jump merges the two
   identical tails back to ONE copy (count unchanged) but the merged block's label
   now sits BEFORE the store. [Cars_ResetCollidedCars]
3. **A REDUNDANT RE-TEST BELONGS INSIDE THE ARM THAT NEEDS IT, as an inverted
   `goto`.** *Symptom:* gate PASS, `REAL=1`; retail's entry guard skips a re-read
   of the same field that our `if (x == 0) { … }` wrapper makes it enter.
   [Cars_DoExtraCarCollisionProcessing]
4. **sched2 HAS NO LAUNCH BOOST — a delay-slot filler that outranks nothing is
   unreachable by any fence.** `sched.c:2499 birthing_insn_p` returns 0 once
   `reload_completed`, so post-reload priority is pure dependency-chain length;
   a barrier cannot change a priority. Tell: `-fno-schedule-insns2` already emits
   retail's local order + cc1's own `#nop`, while every fence is count-neutral.
   [SetupChunkBuildList]
5. **A MULTIPLY'S PRODUCT CAN LIVE IN LO ACROSS BASIC BLOCKS** (mips.md
   `mulsi3_internal` dest constraint `"=l"`; the `mflo` is reload's move at the
   USE). So an oracle whose `mult` and `mflo` straddle two conditional branches is
   telling you the product's single USE is after those branches — a
   statement-order fact, not a scheduling one. [Collide_DoActualObjectCollisionCheck]
6. **`multidial --search` CANNOT SOLVE A LIVE-ONLY BAND** (greedy + refs-only).
   For a saved-reg rotation, enumerate the full two-pseudo (refs, live) product
   over the band with allocsim/reqdelta directly before certifying any cell closed
   — and a hardness certificate is only valid for the pseudo it was computed on.
   [Stats_TrackEndGame; `scratchpad/w64a15/statscells.py` is the reusable driver]
7. **THE 15A FOREIGN-OPERAND FENCE IS NOT A UNIFORM +1 LIVE DIAL.** Measured on a
   real dump it moved four pseudos by +3/−1/−1/+1. Read the delta off `-dl`, never
   predict it. [Stats_TrackEndGame]

---

## 6. FILES / ARTEFACTS

* Committed source: `recon/eaclib/psx/eacpsxz/stream.c` (`35f49bbb`),
  `recon/game/common/cars.cpp` (`a4887913`),
  `recon/game/common/bworld.cpp` (`0f8d707e`, receipt only),
  `recon/game/common/collide.cpp` (`e49ad60d`, receipt only),
  `recon/game/common/stats.cpp` (`e8b1d273`, receipt only).
* Backups: `scratchpad/w64a15/{stream.c,cars.cpp,bworld.cpp,collide.cpp,stats.cpp}.base`.
* Tools: `cc1probe.py` (raw CC1PLPSX flag/asm-window probe), `statscells.py`
  (exhaustive allocno cell enumerator — promote-worthy), `probe_{stream,cars,bworld,bworld2,collide,stats}.py`.
* All probes restore in `finally`; tree left with only my committed edits.

---

## 7. HAZARDS HIT

* **Heredoc backslash-collapse fired again** (firing #15+): a `python - <<'PY'`
  block writing `b'...\r\n'` literals into a probe script collapsed every `\r\n`
  to a raw newline and produced an unterminated-string SyntaxError. Rebuilt the
  file with the Write tool. The Write-tool-or-numeric-bytes rule is absolute —
  quoted heredocs are NOT safe.
* `reqdelta.parse_want` returns register NUMBERS, not names — a hand-written
  `{'p104': 's4'}` want dict scores every candidate as a mismatch and the search
  reports **0 solutions vacuously**. Always build the want through
  `R.parse_want()`. (Cost one full enumeration run.)
* `tools/multidial.py` needs the FULL greg function label
  (`void Stats_TrackEndGame()`), not the mangled symbol, or it prints
  `function not found`.
* Concurrent belts are editing this tree (`nfs3.cpp`, ~20 other recon files were
  dirty and not mine) — every commit staged EXPLICIT paths only.
