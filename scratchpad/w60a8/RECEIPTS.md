# W60-A8 receipts — game/common AI belt

## Re-gated baselines (2026-08-14, gate = tools/tugate.py; brief numbers were stale)

| TU | tugate baseline | FAILs (diffs) | inversions |
|---|---|---|---|
| aispeeds.cpp | 29/29 PASS | — (brief's CalcOpponentTopSpeed already sealed) | 1 |
| aidatarecord.cpp | 26/26 PASS | — | 11 |
| aihigh.cpp | 13/14 | AIHigh_StartUp__Fv 8 | 1 |
| aistate.cpp | 51/54 | ___17AIState_Purgatory 2 · __13AIState_Chase… 11 · CloseTargeting__13AIState_Chase 78 | 4 |
| aiphysic.cpp | 40/42 | AIPhysic_OutOfControlPhysics 5 · AIPhysic_CheckDesiredDirection 8 | 38 |
| aih_opp.cpp | 4/6 | CheckForWipeOut__15AIHigh_Opponent 51 · DoRearEnder__15AIHigh_Opponent 54 | 0 |
| aih_basicperp.cpp | 8/9 | CheckChaserPosition__16AIHigh_BasicPerpii 2 | 0 |

Brief-vs-reality deltas: aispeeds + aidatarecord fully sealed already;
aistate CheckIfCarIsNearbyAndStop already PASS; aiphysic CalcAcceleration already PASS
(W59 TEXT_MOVES COPY splice landed); aih_opp/aih_basicperp counts far lower than the
briefed percentages implied.

Dirty-tree: aih_btccop / aih_btcperp / aih_cop / aih_play SKIPPED-USER-LIVE (confirmed
`git status --short` modified). All seven belt TUs above confirmed CLEAN before touching.

## Work log

### INVERSIONS

**aispeeds.cpp — 1 → 0. LANDED (32197baa).** `AISpeeds_CalcHumanTopSpeed` (@0x8006f3fc)
was emitted after `AISpeeds_CalcHumanCurveSpeed` (@0x8006f41c). One definition-block move.
Two stale VA breadcrumbs corrected on the way (both headers carried the other fn's VA).
tugate 29/29 → 29/29.

**aihigh.cpp — 1 → 0. LANDED (bba9658c).** `___15AIHigh_BTC_Perp` (@0x8005b438, a cross-TU
vague-linkage duplicate) sat at the file tail; retail places it between `___11AIHigh_Base`
and `HighExecute__11AIHigh_None`. One block move. tugate 13/14 → 13/14 (StartUp 8 unchanged).

**aistate.cpp — 4 → 0. LANDED (74aaee9b).** Two moves. (1) The *canonical* NonActive pair
`Execute__17AIState_NonActive`/`___17AIState_NonActive` (@0x8005f624/0x8005f62c) to the head
of the TU — their VAs are the lowest in this object's symbol set. (2) The *VA-suffixed*
duplicate pair @0x80072750/0x80072758 up between `___21AIState_RovingTraffic` and
`___12AIState_Idle`. tugate 51/54 → 51/54.
FINDING for the orchestrator: the canonical NonActive pair's real owner is `aih_btccop.cpp`
(objdump confirms aih_btccop.cpp.o, aih_btcperp.cpp.o AND aistate.cpp.o all define it). The
file's own tail comment records that the analogous canonical `TestForRelease__12AIState_Base`
pair was MOVED OUT of aistate to aihigh for exactly this reason; the NonActive pair looks like
the same over-emission left behind. Deleting it from aistate is the cleaner fix but was out of
scope here (aih_btccop is USER-LIVE) — reordering was sufficient to clear the audit.

**aidatarecord.cpp — 11 → 0. LANDED.** LAW (new, transferable): *retail emits the per-class
dtors of a record-class family as a TAIL GROUP in REVERSE class order*, after every ctor and
accessor of every class — CarTracking, CurveSpeedTable, TrackCurve, BestLine, AccTable. The
recon had interleaved each dtor directly after its own class's methods, which is what a human
writes and what produced all 11 inversions. Four block moves, no text edits.
tugate 26/26 → 26/26.

**aiphysic.cpp — 38 → 0 PROVEN, NOT LANDED (blocked on a tools/build.py line I may not edit).**
The reorder itself is correct and complete (`scratchpad/w60a8/reorder_aiphysic.py`, a
deterministic byte-exact 40-block permutation into retail VA order; also splits the
`StartUp/Reset/CleanUp` one-line stub trio into retail's StartUp/CleanUp/Reset order and lifts
the "PORTED from run-tree" divider comment out of the function sequence since the ported set is
no longer contiguous).

🔴 **NEW LAW — a TU reorder INVALIDATES every `$L<n>`-numbered build.py splice regex in that TU.**
gcc's `$L` label counter is TU-global and assigned in emission order, so permuting function
definitions renumbers every label. `PER_FN_TEXT_MOVES["recon/game/common/aiphysic.cpp"]
["AIPhysic_CalcAcceleration__FP8Car_tObji"]` is anchored on the literal `$L694`; after the
reorder the same branch is `$L577`, the splice silently no-ops, and CalcAcceleration regresses
PASS → 2. This is a gate-visible PASS→FAIL, so under the zero-regression rule the reorder was
REVERTED (`scratchpad/w60a8/unreorder_aiphysic.py`; the working file is now byte-identical to
HEAD — `git diff` empty).

**Probe-verified paired change (ready to apply, one line + one script):**
1. In `tools/build.py` ~line 1113, make the regex LABEL-AGNOSTIC:
```python
{"take": r"\tmove\t\$2,\$16\n(?=\$L\d+:\n\$L\d+:\n\tlw\t\$31,)",
 "after": r"\tbeq\t\$5,\$2,\$L\d+\n",
 "copy": True, "slot": True},
```
   (`move $2,$16` occurs twice in the fn, so the disambiguator moves from a `$L694` lookbehind
   to a lookahead on the epilogue label pair — no label NUMBER anywhere.)
2. Run `python scratchpad/w60a8/reorder_aiphysic.py`.

**Evidence (whole-TU, measured this session):** with the two changes applied together, a probe
copy of build.py+verify_asm (written to `<root>/scratchpad/*.py` so build.py's
`ROOT=Path(__file__).resolve().parent.parent` still resolves — tools/ was never written) gated
aiphysic at **40/42 PASS, PASS set IDENTICAL to baseline** (residual: OutOfControlPhysics 5,
CheckDesiredDirection 8), and `AIPhysic_CalcAcceleration__FP8Car_tObji: PASS (184 insns)`.
Recommended follow-up: sweep `PER_FN_TEXT_MOVES` / the other splice tables for any other
`$L<digits>` literal — each one is a latent break for the next TU that gets reordered.

### FAIL GRIND — all angles below were re-gated individually; every probe restored via
### `scratchpad/w60a8/probe.py` (finally-restore), all seven belt TUs verified byte-identical
### to HEAD afterwards (`git status` clean).

**aiphysic.cpp `AIPhysic_OutOfControlPhysics` — 5, HELD (no regression, no seal).**
Residual = a sched1 ready-list tie: retail fills the `AIWorld_CalcFutureLateralVel` jal slot
with `uTurn=0` (`addu s4,zero,zero`) and defers the `addiu s0,s0,%lo` that completes
`&AIPhysicConfig` to a later load-delay slot; ours does the reverse and pays a `nop`.
NEW FALSIFICATIONS (all measured this session, baseline 5):
- `cfg = &AIPhysicConfig;` moved EARLIER (above `uTurn = 0`, i.e. before the call) → **9**
  (breaks the `%hi` share: `lui v1` + `addiu s0,v1,0`). This closes the last untried direction
  of the w59-A3 (a)/(b) statement-position sweep, which had only moved it LATER.
- Same, plus routing the call's own arg through `cfg->latvelcalc_lookahead` → **9** (identical).
- READ-ONLY use fence `__asm__("" : : "r"(currentLatVel))` between the call and the cfg
  assign → **16** (414 insns). Distinct device from w59-A3's falsified void-tail `"i"(0)`
  fence, same outcome: the fence's barrier property kills the slot fill outright.
- Read-only fence on `cfg` immediately AFTER the assign → **16** (identical).
- `uTurn = 0;` moved BELOW the call/cfg assign → **5, byte-identical to baseline** (gcc sinks
  it to the same place; the statement position of the zero-init is NOT the dial here).
LAW confirmed: on this site the w45 use-fence's *fixpoint* property and its *barrier* property
are in direct conflict — any fence that would pin the lo_sum below the call also forbids reorg
from filling the jal slot at all. Next lens stays qtytrace/sched1, as w59-A3 concluded.

**aiphysic.cpp `AIPhysic_CheckDesiredDirection` — 8 (count-exact 18/18), HELD.**
W59-A3's RTL root cause re-confirmed (p85 %hi-addr pseudo dies at the `lw`, p86 dest is born
there → local-alloc legally shares `$2`, leaving `$3` free for turnAroundSpeed; retail's pair
CONFLICTED so turnAroundSpeed was pushed to `$5` = the SYM's `REG $5`).
NEW FALSIFICATIONS: (a) DUAL-INPUT read-only fence `__asm__("" : : "r"(rt), "r"(turnAroundSpeed))`
on a named block-local for the dead load → **8, byte-identical** — so the de-coalescing
dual-input fence (the aiphysic 32→12 device) does NOT reach a *birth/death-adjacency*
non-conflict; it can only separate values that are simultaneously live, and p85/p86 never are.
(b) OPACITY/IDENTITY fence `__asm__("" : "=r"(rt) : "0"(rt))` on the loaded value → **8,
byte-identical**. Both retire the "fence toolkit" branch of this angle: the required device must
create a *use of the address pseudo after the load*, which costs a real `addiu` (w59-A3's
measured 19/18) — i.e. the angle is structurally, not tactically, blocked.

**aistate.cpp `___17AIState_Purgatory` — 2 (count-exact 72/72), HELD.**
Residual = `sll v1,a0,2` (scaled index) emitted BEFORE the `&Cars_gSortedList` la in ours,
AFTER it in retail. NEW FALSIFICATIONS (baseline 2):
- SPLIT-INIT `ppCVar3 = Cars_gSortedList; ppCVar3 = ppCVar3 + iVar2;` → **15 diffs / 71 insns**.
  🔑 Informative negative: the split DOES flip the sll-vs-la order to retail's exact shape —
  but it also floats the whole address block ABOVE the line-1031 direction/desiredDirection
  stores (violating the SLD's line-1034 grouping) and fills a load-delay `nop` retail keeps
  (71 vs 72). So the order is source-reachable; the POSITION is what is not.
- Split-init + read-only fence on `ppCVar3` between the two halves → **23 / 71**.
- Split-init + the existing `iVar2` fence relocated ABOVE it → **19 / 71**.
All three lose the same instruction, which is the tell that the block moved rather than
re-ordered in place. A device that flips the ready-list order WITHOUT relocating the block is
what this needs (statement-local, non-barrier) — none exists in the current toolkit.

**aih_opp.cpp `CheckForWipeOut__15AIHigh_Opponent` — 51 (ours 121 / oracle 120), HELD.**
Understood the dominant residual for the first time: retail computes
`AI_elapsedTime * 29` ONCE, loop-invariantly (`sll v0,v1,3; subu v0,v0,v1; sll v0,v0,2;
addu t2,v0,v1`), then re-derives `<<2` (→ ×116) at EACH of the two branch delay slots
(`sll a0,t2,2` twice). That whole chain IS gcc's strength-reduction of a CONSTANT `* 116`
(116 = 29<<2), with LICM hoisting the ×29 part and declining the final shift. Ours emits a real
`li t3,116` + `mult` + `mflo` because the multiplier is carried in the `new_var` LOCAL and the
operand is a `volatile` read.
NEW FALSIFICATIONS (baseline 51): plain (non-volatile) read + literal `116` → **83** (121/120→123/120);
plain read + `new_var` → **87**; volatile read + literal `116` → **68**; pre-loop
`new_var = AI_elapsedTime * 29` with per-site `new_var * 4` → **74**; same with `new_var << 2`
→ **74** (identical). The last two produce a whole-function saved-band rotation from insn 1
(`t1`↔`t0`, `t6`↔`t7`) — i.e. they land in a DIFFERENT BASIN, count 122 vs 120. Per the
basin law that is the honest next lead: the ×29/×4 split is almost certainly retail's shape,
but it must be landed together with whatever fixes the head-of-function band, not alone.
The `volatile` + `new_var` pair remains the best measured form and was left untouched.

**aih_basicperp.cpp `CheckChaserPosition` — 2, HELD (examined, not probed).**
Re-gated 2 (85/87). Ours is 2 insns SHORT: retail keeps a redundant `blez s0` + `nop`
(the 2nd of three `pos<=0` guards, SLD line 378, SYM block S6) that our cse/jump.c deletes
because it can range-prove `pos > 0` from the outer `if(0<pos)` and the `while(0<pos)`
back-edge. Prior waves falsified the identity fence on `pos` (cross-block pseudo → real copy,
2→34), a per-fn `-fno-thread-jumps` splice (inert), the positive-nested-block form (26), and
the un-rotated `while` form (26). Left as-is; the untried direction is an opacity device on a
BLOCK-LOCAL copy of `pos` (fence the copy, test the copy) — the cross-block objection that
killed the previous fence does not apply to a fresh in-loop local. Flagged, not measured.

**aistate.cpp `CloseTargeting__13AIState_Chase` (78) and `__13AIState_Chase…` ctor (11), and
`aih_opp DoRearEnder` (54) — NOT REACHED this session** (budget went to the 5 inversion TUs
plus the aiphysic blocker analysis). Ctor's first diffs are a clean `v0`↔`v1` rotation around
`lw v1,0(fp)` / `nor` / `xori` with ours 67 vs oracle 66 — a one-insn-longer coloring case,
i.e. the "ours-1-LONGER" discriminator, not the ctor-vptr class the brief warned about.
The briefed ctor-vptr PROBED-BLOCKED angle was therefore NOT spent.

## Files touched (all committed)
- `recon/game/common/aispeeds.cpp` (32197baa)
- `recon/game/common/aihigh.cpp` (bba9658c)
- `recon/game/common/aistate.cpp` (74aaee9b)
- `recon/game/common/aidatarecord.cpp`
- `scratchpad/w60a8/*` (tools + this receipt)
`recon/game/common/aiphysic.cpp`, `aih_opp.cpp`, `aih_basicperp.cpp` are byte-identical to HEAD
(probed and restored). No `tools/*.py` file was written at any point — the build.py probe used
copies under `<root>/scratchpad/` (deleted afterwards) so that build.py's
`ROOT = Path(__file__).resolve().parent.parent` still resolved to the repo root.

## Final certification
tugate, all seven belt TUs, after all work:
aispeeds 29/29 · aidatarecord 26/26 · aihigh 13/14 · aistate 51/54 · aiphysic 40/42 ·
aih_opp 4/6 · aih_basicperp 8/9 — **IDENTICAL to the session baselines, 0 PASS→FAIL.**
tu_order_audit: my belt's only remaining inversions are aiphysic's 38 (blocked as above);
aispeeds/aihigh/aistate/aidatarecord are silent.

---

# W60-A8 ROUND 2 (resumed) — the four unreached fns

Re-baselined first (tree had moved to `19c40394`): aistate 51/54 · aih_opp 4/6 ·
aih_basicperp 8/9 · aiphysic 40/42 — all unchanged, and the orchestrator's landing of my
aiphysic reorder + label-agnostic anchor (`06590f5f`) is confirmed holding (38 inv -> 0,
CalcAcceleration PASS). Every probe below ran through `scratchpad/w60a8/probe.py`
(finally-restore); `git status` confirmed all four TUs byte-identical to HEAD afterwards.
NOTHING LANDED this round — 0 PASS->FAIL, but also 0 new seals. Full angle ledger:

## (2) aih_basicperp `CheckChaserPosition` — 2. PRIOR VERDICT REFUTED (mechanism found)

The in-source receipt said this "needs a value-range-opaque cse-invalidation the fence toolkit
lacks". **That is now false.** The opacity fence on a BLOCK-LOCAL copy of `pos` DOES restore
the deleted `blez` guard — the cross-block objection that killed the earlier fence-on-`pos`
does not apply to a fresh in-loop local, exactly as flagged:

| variant | result |
|---|---|
| baseline | 2 diffs, ours 85 / oracle 87 (guard deleted) |
| `{int p=pos; __asm__("":"=r"(p):"0"(p)); if(p<1)break;}` | **15 diffs, 86 insns — GUARD PRESENT** |
| ...same + `pos = p;` after the guard | **11 diffs, 86 insns — GUARD PRESENT** |
| opacity fence on `pos` at the loop BOTTOM (after `pos = pos + -1`) | 21 diffs, 84 insns, guard still deleted |
| read-only fence `("" : : "r"(pos))` at the guard | 35 diffs, 90 insns, guard still deleted |

So the device is settled: **only an opacity/identity fence whose OUTPUT is the tested value
invalidates cse's range proof**; a read-only use of the same value does not (cse's range
knowledge survives a mere use), and fencing the value on the back-edge does not reach the
loop-top guard (the entry `if(0<pos)` still proves it on the other predecessor).
REMAINING BLOCKER, now precisely named: the fence is not free because `pos` is a GLOBAL
allocno, so `combine_regs` refuses to tie the copy (w47 law) -> a real `addu v1,s0,zero`, and
that displaced def also costs the `-1`-sentinel reuse (`addu v0,s0,s3` degrades to
`addiu v0,s0,-1`) plus the loop-tail `blez`/`j` polarity. Net 11 vs 2, so not landed.
NEXT (untried, cheap): carry the OPAQUE copy through the whole loop body — use it for the two
`positionVSCopList_[p-1]` loads and the guard, and write `pos = p - 1` at the bottom — so the
fence's copy IS the loop's live value and no separate move is needed.

## (1) aistate Chase ctor — 11 (ours 67 / oracle 66). SHAPE CRACKED, one ready-list tie left

Classification (the coordinator's discriminator): ours is **1 LONGER**, and the extra insn is a
`nop`, not a redundant `addu`/`li`/saved-trio — so this is NOT the permuter multi-basin class,
NOT void->int, NOT hold-global-addr. Retail avoids the nop by filling the `lw v0,%lo(D_8011321C)`
load-delay slot with the `carObj_->direction` load; ours cannot because our two loads are issued
in the opposite order.

**NEW FINDING — the residual's real root cause was a STORAGE SHAPE, not coloring.**
`extern int D_8011321C;` makes cc1 emit the scalar assembler MACRO, which maspsx expands to
`lui;lw` AFTER cc1 — position-pinned, so sched1 can never hoist the `lui`. Retail's `lui` sits
seven insns higher (in the `lw v1,0(fp)` load-delay slot, above the four field stores), which is
only possible from cc1's OWN split lowering. Switching to the unsized asm-label view
(`extern int D_8011321C_v[] asm("D_8011321C");` + `D_8011321C_v[0]`) **reproduces retail's `lui`
placement exactly** — the emitted block becomes byte-for-byte the oracle's except for one
swapped load pair and the register names:

```
OURS(view)                       ORACLE
lw v0,0(fp)                      lw v1,0(fp)
lui v1,0                         lui v0,0          <- now matches
sw s5/s6/s7/zero,128..140(fp)    (identical)
lw a0,1364(v0)   direction       lw v0,0(v0)       gate
lw v0,0(v1)      gate            lw v1,1364(v1)    direction
nop                              (none)
bnez v0 / nor / xori             bnez v0 / nor / xori
```

The two loads are independent and ready at the same cycle -> a pure sched1 ready-list tie.
FALSIFIED against it (each re-gated; baseline 11, view alone 13):
- view + gate read hoisted to its own statement before `direction` -> **13** (unchanged; sched1
  reorders regardless of statement order/luid — refutes the "own statement = issues first" rule
  for two zero-dependency loads);
- view + gate statement + read-only use fence between the two reads -> **13**, and the fence
  drags the gate load ABOVE the `carObj_` load instead (over-pins);
- view + in-place term shape (`reverseDirCheck = ~(this->carObj_)->direction;` re-read form,
  the A7 term-shape axis) -> **13**;
- plain re-read WITHOUT the view -> **11** (cse shares the load either way — the pre-w30-a2
  "extra dead load" note is stale, there is no extra load);
- if/else with the global tested first (`if (D_8011321C != 0) ... else ...`) -> **20** (72 insns).
Not landed (13 > 11). **HANDOFF: the view is the right storage shape and should land the moment
the load-pair tie is solved** — the whole rest of the block is already byte-exact under it.
Also note the in-source WALL comment's claim that "insn count is EXACT 66/66" is STALE: it is
67/66.

## (3) aih_opp `DoRearEnder` — 54 (count-exact 181/181). Lever found, costs a count.

Read the residual properly for the first time: at BOTH of its two sites the oracle materializes
the range test's two 32-bit constants (`0xFFFEFFFF` = -0x10001 and `0x26FFFE`) **speculatively,
above the `bgez` of the branchy abs**, using the two `roadPosition` load-delay slots as filler,
and defers the `mflo` of `longDistance*direction` past that branch. Ours emits both constants
after the branch, because RTL generation follows source order and the constants belong to the
`if` that sits after the abs. (Confirms the w22 "speculative compute before the guard" row and
explains the in-source note's "constant hoist across the abs BB split".)

| variant | result |
|---|---|
| baseline | 54 diffs, **181/181** |
| `int c1 = -0x10001;` before the abs, `(u_int)(longDistance + c1) < 0x26ffffU` | 54, 181/181 — but the `lui` HOISTS above the bgez (the `ori` stays below: cc1 splits a big constant like a `high`/`lo_sum` pair and sinks the low half to the use) |
| + named `c2` as well | 54, 181/181 |
| + read-only fence on `c1` (or on `c1`+`c2`, or two separate fences) | **51 diffs, 180/181** — the fence pins BOTH halves early; retail's constant placement is reached at all four spellings |

So the lever is real and reproducible (three fence spellings all land on exactly 51/180) — the
fence is what stops the `lo_sum` half sinking to the use. NOT LANDED: it beats the gate (51<54)
but loses count-exactness (180 vs 181 — we now fill a slot retail leaves), and this project's
own bar rejects a lower LCS bought with a wrong count (w47-a1 precedent). Ready to land as a
PAIR the moment the missing insn is identified; the constant-hoist half is settled.

## (4) aistate `CloseTargeting` — 78. NOT REACHED (honest).

Budget went to the three above. No probe was run, so no claim is made about it. Untouched.

## Round-2 certification
aistate 51/54 · aih_opp 4/6 · aih_basicperp 8/9 · aiphysic 40/42 — identical to the round-2
baselines. Zero PASS->FAIL. No `tools/*.py` written. aih_btccop/btcperp/cop/play untouched.
