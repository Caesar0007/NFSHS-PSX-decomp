# W63-A12 — the AI belt (recon/game/common)

Base HEAD at dispatch `10e1a01b`. Gate = `tools/verify_asm.py` (`-`=ours, `+`=oracle).
Every number below was re-gated by me; nothing is quoted from a board row or a briefing.

---

## 1. PER-FN LEDGER

| fn | TU | board row | RE-GATED baseline | final | delta |
|---|---|---|---|---|---|
| `CloseTargeting__13AIState_Chase` | aistate | 99.37 | **15** @301/300 | **PASS 300/300** (psyqproof REAL=0) | **SEALED** |
| `CheckForWipeOut__15AIHigh_Opponent` | aih_opp | 84.38 | **51** @121/120 | **50** @118/120 | −1 |
| `DoRearEnder__15AIHigh_Opponent` | aih_opp | 87.29 | **54** @181/181 | **50** @181/181 | −4 |
| `HighExecute__10AIHigh_Cop` | aih_cop | 99.04 | **77** @1455/1460 | **69** @1457/1460 | −8 |
| `HighExecute__18AIHigh_BTC_Wingman` | aih_btccop | 99.82 | **4** @675/675 | 4 | receipt |
| `CheckChaserPosition__16AIHigh_BasicPerpii` | aih_basicperp | 97.70 | **2** @85/87 | 2 | receipt |
| `AIPhysic_CheckDesiredDirection__FP8Car_tObj` | aiphysic | 98.61 | **8** @18/18 | 8 | receipt |
| `AIPhysic_OutOfControlPhysics__FP8Car_tObj` | aiphysic | 99.47 | **5** @413/412 | 5 | receipt |
| `AIPhysic_CalcAcceleration__FP8Car_tObji` | aiphysic | 99.97 | **PASS (184)** | — | stale row |
| `AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi` | aispeeds | 99.96 | **PASS (342)** | — | stale row |
| `CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi` | aistate | 99.95 | **PASS (109)** | — | stale row |

**3 of 11 assigned rows were already PASS** (stale board, both directions — the
standing rule held again). Belt total on the 8 real targets: **−13 diffs, +1 seal**,
and **aistate.cpp is now TU-COMPLETE 52/52**.

TU gate state at close (each gated 2×, zero PASS→FAIL anywhere):
`aistate 52/52` · `aih_basicperp 8/9` · `aih_btccop 39/40` · `aiphysic 40/42` ·
`aih_opp 4/6` · `aih_cop 9/10`. `tools/tu_order_audit.py` = **0 inversions**.

Commits: `4c549261` · `b5425b77` · `bf0e8cfc` · `196b1880` · `8386c5ab` · `5f2e929e`.

---

## 2. LAWS / CATALOG-ROW CANDIDATES

### 2.1 🏆 A NAMED CONSTANT AND A **FENCED** NAMED CONSTANT ARE DIFFERENT LEVERS
Landed **three times independently this session** (DoRearEnder, CloseTargeting, AIHigh_Cop),
each on a function where a prior wave had explicitly *falsified* "name the constant/boolean".

* A plain `int c = K;` — decl-with-init **or** assignment — is const-propagated straight
  back into its consumer. Re-measured on DoRearEnder: **exactly the 54-diff baseline, i.e.
  provably inert.** This is what W59/W60/W61 measured and correctly recorded.
* `int c; c = K; __asm__("" : "=r"(c) : "0"(c));` is **not** the same edit: the opacity
  fence stops cse folding it, so a real pseudo is born **in the block where you put it**.
  That is what lets sched1/reorg use it (load-delay slots, branch delay slots).

⇒ **A falsified "named temp" receipt does NOT close the axis.** Re-probe the fenced form.

### 2.2 🔴 FENCE PLACEMENT LAW FOR A DELAY-SLOT CONSTANT (new boundary on 06B)
When the opacity fence is used to mint a constant that retail puts **in a branch delay
slot**, the fence must sit **AFTER the consumer**, never between the def and the branch.
An `asm` is a reorg backward-scan barrier, so a fence between them walls the constant out
of its own slot. Measured on CloseTargeting, same edit, only the fence moved:

| fence position | result |
|---|---|
| between `latBias = 0x60000;` and the `if` | 15 → **3** @301/300 (slot still a nop) |
| below the `if/else` | 15 → **PASS 300/300** |

### 2.3 🏆 A loop.c HOIST YOU CANNOT AFFORD IS A *MOVABLE-EXISTENCE* QUESTION
CheckForWipeOut's 116×elapsedTime hoist was chased for two waves as a `move_movables`
budget/threshold problem. It never was: `-dL` gives those movables `savings 4 / life 4`,
and the test `threshold*savings*lifetime >= insn_count` (≈62 decaying 3/move, insn_count 49)
can never decline `4×4`. **loop.c only builds a movable for a reg with `n_times_set == 1`.**
Writing the product into ONE named local assigned in **both** arms makes the pseudo set
twice → no movable → retail's in-loop `sll` + single cross-jumped `slt` return. 76 → 64,
count-exact. Recognition: *if `savings*lifetime` is ≥4 the budget can never save you —
go make the destination be set twice instead.*

### 2.4 The allocsim → reqdelta → source-dial loop works end-to-end on a whole band
CheckForWipeOut: allocsim MATCH 17/17 → reqdelta priced retail's entire `$t0..$t7`
handout as exactly **three** deltas → all three landed as source dials → band retail-exact.
Two reusable sub-findings:

* **Fencing a GLOBAL directly does not buy a ref.** `__asm__("" : : "r"(SomeGlobal))`
  mints a *fresh load* (+2 insns, refs unchanged). Route it through a local carrier first
  (`playFines = Cars_gNumHumanRaceCars;` then fence the local) → the +1 out-of-loop ref
  arrives at **zero insns**.
* **Two pseudos that die on the same insn cannot be re-ordered by any fence.** If
  `live(B) = live(A) + gap` (same death, defs `gap` apart), then `pri(B) > pri(A)` requires
  `live(A) > 5·gap` for refs 6-vs-5 — and *every* fence/wrapper lengthens both equally
  because they span the same region. The only dial is the **gap** (move a def), which is
  why this residual is bounded by structure, not by devices. Worth a catalog row: it turns
  "try another fence" into a closed-form impossibility check.

### 2.5 09I volatile-on-the-test-read, with an honest ablation
AIHigh_Cop needed retail's **re-load** of an address-escaping local's field for the second
`||` operand (our cse shares the first read's register — that *is* the diff, so every
non-volatile spelling is CSE'd by construction). Per the volatile-dial rule I measured the
full ablation rather than keeping it on faith:

| variant | diffs | insns |
|---|---|---|
| baseline | 77 | 1455 |
| fenced boolean only | 78 | 1456 |
| volatile re-read only | 70 | 1456 |
| **both** | **69** | 1457 |

Both halves are load-bearing; dropping the volatile costs 5 diffs. Result: **zero
mismatched runs ≥6 insns anywhere in a 1460-insn function** (was one 7-insn run).

---

## 3. FALSIFICATIONS (all re-gated, with the basin they were measured in)

| fn | angle | result |
|---|---|---|
| CheckForWipeOut | single-store shared-RANDGATE (goto **and** else-continue forms) | 61 both — drops the sim-base copy's refs 5→3 as wanted, but the smaller loop then lets loop.c hoist the `0xd5554` literal retail rematerializes per iteration |
| CheckForWipeOut | swap decl order of the two per-iteration loads | inert (pseudo numbers follow first-use, not decl order) |
| DoRearEnder | plain named constants (decl-init and assignment, no fence) | exactly 54 = inert |
| DoRearEnder | constant order hi-then-lo | 51 @180 (one insn lost) — lo-then-hi is the 50 |
| DoRearEnder | same fence device at the **in-loop** site | 68 — fences there are loop-weighted (+2 refs each), whole `$s`-band rotates |
| DoRearEnder | move the `*direction` multiply below the lat-distance load | inert |
| AIPhysic_CheckDesiredDirection | unsized-array asm-label view of `GameSetup_gData`, **both** decl scopes | inert (8, byte-identical) — the volatile cast already pins the MEM so `mips_check_split` never runs ⇒ **storage-shape axis CLOSED** |
| AIPhysic_OutOfControlPhysics | arg-precompute so `uTurn = 0` is the last insn before the jal | inert ⇒ **statement-order axis CLOSED** |
| Wingman | `offset = &X; memset(offset,…)` (REG_EQUIV remat trigger), all three arms | inert (4, byte-identical) |
| AIHigh_Cop | hoist the `reverseTrack` read into its own local to fix load order | inert (69) — gcc reschedules to the same stream |
| CheckChaserPosition | operand-less **void-tail** fence above the guard | 35 @90/87 — chosen precisely because it can mint no copy; the guard's deletion is therefore **not barrier-reachable** |

---

## 4. SHARPENED RESIDUALS (what the next agent should pick up)

* **CheckForWipeOut 50** — the count-exact 52-diff sibling is kept at
  `scratchpad/w63a12/aih_opp.cpp.wipe52` and is the **structurally truer base** (120/120,
  retail's two `AI_elapsedTime` loads preserved). The landed 50 buys the exact `$t`-band by
  moving `new_var` above the pre-loop store, which costs that second load. Closing the last
  pair needs `gap ≤ 10` (§2.4) — a structural edit, not another device.
* **Wingman 4** — re-read off the oracle: retail sets the arg **in the arm**
  (`addiu $a2,$sp,0x48` @0x8005E904, `…,0x38` @0x8005EBF8, both well before the `j`), i.e.
  its `offset` pseudo is simply **allocated to `$a2`**. Not a remat question. allocsim
  MATCHes 45/45 with **no pseudo homed in `$v0`** ⇒ the loser is a local-alloc qty, outside
  allocsim/reqdelta. → qtytrace.
* **CheckDesiredDirection 8 / OutOfControlPhysics 5 / CheckChaserPosition 2 / Wingman 4** —
  four independent fns on this belt now converge on the same missing instrument
  (**§4.6 qtytrace**, local-alloc QTY handouts + sched1 ready list). Three of the four have
  had every source-level axis explicitly closed with receipts this session.

## 5. HAZARDS HIT

* **Bash heredoc string-mangling fired 4×** — `python - <<'PY'` silently failed to match
  literal source text (`\0`, `\n`, multi-line blocks) and reported `count 0`; one run would
  have been a silent no-op had I not asserted. **Used the Edit tool for every real edit
  thereafter.** (The one thing that saved it: always print/assert the match count.)
* `git commit` output interleaves with concurrent belts — `git log --oneline -1` showed
  *another agent's* commit twice; verify your own SHA with `git log --oneline -5`.
* Verified committed blobs byte-wise after the autocrlf warning on `aih_cop.cpp`
  (working file and `git show HEAD:` blob both pure-LF, 0 NULs).

## 6. FILES

Source: `recon/game/common/{aistate,aih_opp,aih_cop,aiphysic,aih_btccop,aih_basicperp}.cpp`.
Backups/basins in `scratchpad/w63a12/`: `aih_opp.cpp.{base51,wipe64,wipe52,wipe50,rear54,rear50}`,
`aistate.cpp.close15`, `aih_cop.cpp.{cop77,cop69}`, `aiphysic.cpp.ooc5`,
`aih_btccop.cpp.wing4`, `aih_basicperp.cpp.b2`.
Tool: `scratchpad/w63a12/w63a12_multidial.py` — multi-pseudo dial search on top of
allocsim/reqdelta (reqdelta searches one pseudo; a whole-band permutation needs a set).
**Promote-worthy** — it is what priced CheckForWipeOut's three deltas.

No `tools/*.py`, no build.py rows, no memory-dir writes, no user-live TUs touched.
No JSON build.py specs needed this session.
