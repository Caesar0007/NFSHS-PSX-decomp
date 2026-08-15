# W63-A10 RECEIPTS — the speech/audio belt

Repo HEAD at start `10e1a01b`. Every number below re-gated by me with
`tools/verify_asm.py` / `tools/tugate.py`; production numbers from
`tools/psyqproof.py`; branch-distance screen `tools/brdist.py`.

## 0. RE-GATED BASELINE (stale-row audit: 2 of 7 rows were stale)

| fn | board % | my re-gated baseline | final |
|---|---|---|---|
| `Lose__Q26Speech13MobileSpeaker` | 99.43 | **3** (214/213) | **PASS 213/213 + REAL=0** |
| `Report__Q26Speech15DispatchSpeakerP8Car_tObj` | 96.73 | **11** (103/104) | 11 (classified) |
| `StatusReply__Q26Speech15DispatchSpeaker` | 99.59 | **5** (268/269) | 5 (classified) |
| `SubmitRequest__6Speechlll` | 99.92 | **PASS (stale row)** but **psyqproof REAL=1** | **PASS + REAL=0** |
| `AudioClc_GetClosestCars__Fiii` | 99.59 | **3** (268/267) | **PASS 267/267 + REAL=0** |
| `AudioCmn_CheckState__FP8Car_tObj` | 99.51 | **4** (415/415) | 4 (certificate bounded) |
| `AudioTrk_AddCustomObject__…` | 99.99 | **PASS (stale row)**, REAL=0 | DUAL-LANE confirmed |

TU state at close (gated 2x each): `audioclc.cpp` **18/18 COMPLETE**,
`audiotrk.cpp` 6/6, `speech.cpp` 100/102 (was 99/102), `audiocmn.cpp` 47/48.
`tu_order_audit.py` 0 throughout.

Commits: `68276047`, `e394afe0`, `6a9c51c4`, `ef3c512e`.

---

## 1. 🏆 NEW LAW — THE cross_jump LABEL-BONUS UN-MERGER (SubmitRequest)

**A gate-PASSing function carried a production-visible wrong branch word.**
`psyqproof` REAL=1 on word 43, `brdist.py` branch 6 at distance **-2** where
retail has **+8**: our `offset != 0` guard jumped BACKWARD onto the *other*
arm's copy of an identical return tail. `verify_asm` normalises every branch
TARGET, so it can never see this class.

**Mechanism (gcc-2.8.1 `jump.c`, read off this fn's own `-dj`/`-dJ` dumps):**
the final cross-jumping `jump_optimize(insns, cross_jump=1, …)` (`toplev.c:3548`,
unconditional at `-O2`) pairs the two `j <epilogue>` insns through the
`jump_chain` loop (`jump.c:2148`) and calls
`find_cross_jump(e1, e2, minimum=2)`. The backward walk from `e1` matches **one**
insn (the shared `addu v0,s0,s2`, minimum 2→1) and then hits the CODE_LABEL that
ends the inner `if (offset != 0)`. **`jump.c:2568-2573` spends a FREE `--minimum`
on any CODE_LABEL in stream 1**, so minimum reaches 0 and `do_cross_jump` fires
**on a one-insn tail**: it plants a label before the *other* arm's `addu`,
redirects our `j` there and deletes our `addu`; jump tensioning then folds the
`beq` onto the same label, and reorg re-steals the surviving `addu` back into the
delay slot — which is exactly why the instruction STREAM still matches retail and
only the branch WORD differs.

**CURE (zero insns, pin-free):** a void fence between that label and the
duplicated tail. `jump.c:2632-2635` sets `lose = 1` for an `ASM_OPERANDS` with
`MEM_VOLATILE_P`, so the match dies *before* the label bonus is reached.

```c
    if (offset != 0) { CopSpeak_DirectRequest(…); }
    __asm__("" : : "i"(0));          /* cross_jump un-merger */
    return offset + localoffset;
```

FALSIFIED first (both left word 43 at `1200fffd`): the same fence placed in the
THEN arm after `CopSpeak_GenericBankRequest` (it sits OUTSIDE the compared range
— the walk from the second `j` never reaches it); and dropping the `else` so both
returns are at statement level.

**REUSABLE SCREEN:** any fn with N duplicated `return <expr>;` tails where one is
preceded by an end-of-inner-if label is exposed. `brdist.py` finds them;
`psyqproof` confirms; the fence cures. **Catalog-row candidate.**

---

## 2. 🏆 Lose__Q26Speech13MobileSpeaker — 3 → PASS 213/213, REAL=0

Two independent one-liners, both in the `Leader`/PERP_LOST else block.

### (a) THE ARM-LOCAL LAUNDERED RECEIVER CARRIER (kills the extra `addu a0,s0,zero`)

```c
else {
  SPCHNFSType_VOICE *voiceArg = pSVar7;
  __asm__("" : "=r"(voiceArg) : "0"(voiceArg));   /* 13B identity launder */
  pCVar5 = &fColour;
  if (Leader != 0) IDLE_WINGMAN(pSVar7);          /* NOT voiceArg */
  else             PERP_LOST(voiceArg, …);
}
```

The launder makes the carrier a GLOBAL allocno (dies twice ⇒ `combine_regs`
refuses, 12E); it wins `$a0` outright, and its single defining copy IS the one
retail carries in the `bne` delay slot — so the PERP_LOST block opens on
`addu a3,s1,zero` exactly like retail.

MEASURED LADDER (all real gate runs, `ours/oracle`):

| variant | diffs |
|---|---|
| plain carrier over all four blockade-chain calls | 3 @214 (inert) |
| plain carrier over the inner IDLE/PERP pair | 3 @214 (inert) |
| **laundered** over all four calls | 11 @212 |
| laundered inner pair, IDLE **also** on the carrier | 4 @213 |
| **laundered inner pair, IDLE left on `pSVar7`** | **2 @213** ✅ |
| launder moved BELOW `pCVar5 = &fColour` | 25 @214 |
| laundered carrier declared INSIDE the PERP_LOST arm | 3 @214 |

⇒ **placement is a dial separate from choice** (13B), and the carrier must NOT be
shared with the sibling arm or its live range spans both threads.

### (b) THE ARG-EVALUATION-ORDER CARRIER (fixes the `lw a2,48` / `lw v1,52` order)

Carry the location in the fn-scope **`iVar3`** instead of the Ghidra-invented
`reg_a1`. The two field loads are **not** at their statement positions — combine
folds each single-use `(set pseudo (mem))` into the call-sequence arg move —
which is why every statement-order and barrier lever is inert:

INERT at 2: swapping the two reads · `REVINTRO` first · location read last · a
void barrier between the reads / after `REVINTRO` / with a3 first · a read-only
fence on `iVar4` · an identity launder on `iVar4`.

MOVES IT (the carrier's identity is the dial): `iVar3` **PASS** · `reg_a1` 2 ·
`uVar8` 4 · a fresh block-local `perpLoc` 14 · the field inlined at the call 14 ·
car↔loc carriers swapped 6.

---

## 3. 🏆 AudioClc_GetClosestCars — 3 → PASS 267/267, REAL=0 (TU 18/18 COMPLETE)

**W59-A4's falsification of "a local base pointer" was a PLACEMENT miss, not a
spelling miss.** Declared OUTSIDE the loop it seals:

```c
const int *viewpos = (const int *)&AudioClc_gRenderView.translation;
i = 0; car = Cars_gList;
while (i < Cars_gNumCars) { …
    x = (*car)->N.position.x - viewpos[0];
    y = (*car)->N.position.y - viewpos[1];
    z = (*car)->N.position.z - viewpos[2];
```

Pre-loop it is exactly ONE `(high sym)` pseudo — the one `loop.c` hoists
(REG_EQUIV) and reload rematerialises as retail's `la t1` — so all three
components load off it and our second `lui` disappears.

| variant | diffs |
|---|---|
| **pre-loop plain `const int *viewpos`, all three components** | **PASS 267** ✅ |
| pre-loop pointer + 13B identity launder | 31 @270 |
| pre-loop pointer for y,z only (x left as `.x`) — plain / laundered | 3 @268 / 32 @271 |
| in-body `const int *vp` (the W59-A4 form, re-measured) | 3 @268 inert |
| `(&…translation.y)[-1]` for x, x first | 3 @268 |
| x spelled through a byte offset off `&y` or `&z`, x first | 3 @268 |

🔴 **The launder is the WRONG device here** — its opacity blocks `loop.c`'s
hoist. Inverse of Lose's receiver carrier: read what the pass you need must be
allowed to do.

🔑 **POSITION LAW (new):** base-reuse appears **iff the `.x` access is the LAST**
of the three — x-last 118 @267 **COUNT-EXACT**, x-middle 102 @269, x-first 3
@268. **The first-expanded component owns the `lo_sum` fold**; every later one
must take the full address. That is why every re-spelling of `.x` in place is
inert and why the fix has to move the BASE, not the access.

---

## 4. Report__Q26Speech15DispatchSpeaker — 11 @103 CLASSIFIED (2 device families retired)

🔴 **INDEPENDENT WITNESS FOR THE A16 CORRECTION.** The W63 **foreign-operand
fence**, broadcast mid-wave as *this function's* named unblock, is **INERT at
exactly 11 @103 in all NINE placements**: operand `iVar3` / `pSVar6` / `pThis`,
each with and without a named `__vtbl_ptr_type (*subVf)[31]` receiver local, plus
×2, ×3 and a two-operand form. Reason, in the shape A16 predicts: this is **not a
serving-order loss** — our receiver is served while `$v0` is simply FREE, so
`find_free_reg`'s ascending scan takes it. Retail's `$a1` requires `$v0`, `$v1`
**and** `$a0` all UNAVAILABLE across the receiver's window.

🔑 **PROVEN NOT A SCHEDULER QUESTION** (new, cheap, reusable diagnostic):
compiling the TU with `-fno-schedule-insns` and with `-fno-schedule-insns2`
leaves `move $16,$2` glued to the call in **both** — sched1 never moved the
call-result copy, so there is nothing to stop. The copy's position is expand's.

Also falsified this wave: the **carrier-identity dial that sealed Lose** —
carrying the first result / the CallSign result in `reg_a2`, `reg_a3`, `iVar4` or
any pairing is 11 @103 (only `iVar4`↔`iVar3` swapped moves, to 93 @105); and
**splitting the copy** so it is emitted after the receiver load
(`int bankRes = call(); … iVar3 = bankRes;`, with/without a launder,
with/without the named `subVf`) is 16–18 **@102** — one SHORTER, i.e. the two
pseudos coalesce and an insn is lost, whereas the structural change we need must
ADD retail's extra nop.

**NEXT (named angle):** the only structure that can work is one where a
caller-saved pseudo genuinely holds a live value in `$v0` across the receiver
load ⇒ 13A UNREACHABILITY TRIAGE — qty STRUCTURE / the 12A preference-availability
instrument, not a fence and not a spelling.

---

## 5. StatusReply — 5 @268 CLASSIFIED (pseudo-shape axis CLOSED)

12D scope-limit residual (staging loses to a copy-preference onto an ARG register
that is the value's sole consumer) re-gated and confirmed. Three more families,
**all inert at exactly 5 @268**:

* decl-with-init split `int wing; wing = …` (12D's demote dial);
* a named `wingIdx` for the CallSign result + the array read; both together;
* a **FUNCTION-SCOPE `int wing;` swept through ALL SIX positions** of the local
  declaration list (before `Blocker` / after `Blocker` / after `invalid` / after
  `context` / after `from` / after `reverse`).

⇒ the 13A decl-order dial reaches allocno **NUMBER**, and the number is not the
decider: local-alloc's copy suggestion hands the pseudo `$a3` whatever its
number, scope, or value spelling. Sole residual = the 12A hard-reg PREFERENCE.

---

## 6. AudioCmn_CheckState — 4 @415, certificate now BOUNDED ON BOTH SIDES

The 12E *register XOR count* cell reproduced exactly (3 @416 register-right vs
4 @415 count-right). TEN new falsifications, none better than 4:

| variant | diffs |
|---|---|
| arm-local `int *bl` **laundered**, used by BOTH arm sites | 3 @416 |
| …+ block-local `int ci = car->carIndex` | 3 @416 |
| …+ Yoda guard `!(carspeed < bl[..])` | 3 @416 |
| arm-local `int *bl` **plain**, both sites | 4 @415 (FE folds it back) |
| guard through `bl`, store through `bestLapTime` | 30 @417 |
| foreign-operand fence `asm("" : : "r"(carspeed))` at arm head | 4 @415 (inert) |
| **placement ladder** — decl hoisted to the `{ CopSpeak_tRequest r; … }` block: plain / laundered / plain+all-3-sites / laundered+all-3-sites | 20 @413 / 53 @416 / 24 @411 / 20 @411 |

🔑 The placement ladder that sealed GetClosestCars and Lose **FAILS here, and
that is informative**: retail rematerialises this address PER SITE, so hoisting
the declaration deletes real instructions. Every arm-local form that buys
retail's REGISTER costs the load-delay `nop`; every form that keeps the COUNT
leaves the split scratch. **The wanted device must stop the `{high, lo_sum}`
split WITHOUT being an RTL insn** (i.e. not an asm at all) — a local-alloc/06E
instrument, as already routed.

---

## 7. CATALOG-ROW CANDIDATES (for the orchestrator)

1. **cross_jump LABEL-BONUS un-merger** (§1) — symptom: gate PASS + `psyqproof`
   REAL=1 + `brdist` shows a guard branching to the *wrong one* of N identical
   return tails → fix: void fence between the end-of-inner-if label and the tail.
   `jump.c:2568-2573` (free `--minimum` on a CODE_LABEL) is the enabler,
   `jump.c:2632-2635` (volatile ASM_OPERANDS ⇒ `lose`) is the cure.
2. **PLACEMENT IS THE DIAL FOR A BASE/CARRIER POINTER** (§2a, §3, §6) — the same
   one-line pointer is inert, sealing, or a 30-diff regression depending only on
   WHICH SCOPE it is declared in; and the required scope is dictated by what
   retail does with the address (hoisted-once ⇒ pre-loop; per-site remat ⇒
   arm-local). Always sweep the scope ladder before filing a pointer lever.
3. **THE LAUNDER IS DIRECTIONAL** (§3) — an identity launder BLOCKS `loop.c`'s
   invariant hoist. Use it to buy a register (Lose), never where you need a pass
   to move the value (GetClosestCars: 31 @270 laundered vs PASS plain).
4. **FIRST-EXPANDED-COMPONENT-OWNS-THE-lo_sum LAW** (§3) — for a multi-field
   read of one global struct, only the first component folds to
   `(mem (lo_sum (high SYM) SYM))`; the rest force the full address. Explains
   the whole "extra lui on `.x`" class and predicts that re-spelling the access
   can never help.
5. **`-fno-schedule-insns{,2}` AS A ONE-SHOT DIAGNOSTIC** (§4) — before blaming a
   scheduler for an insn's position, compile the TU with both off and look: if
   the insn does not move, the position is expand's and every barrier device is
   inert by construction.
6. **A16 CONFIRMED FROM THE FIELD** (§4) — the foreign-operand fence is inert
   when the target is served while its reg is free; check `find_free_reg`
   availability, not `QTY_CMP_PRI`, before spending it.

## 8. HAZARDS HIT

* `git log -1` after my commit showed a PEER's commit (known W60-12K hazard) —
  verify with `git log --format=… -- <path>`.
* An `Edit` that adds a receipt comment is NOT the same edit as the probe: my
  first `audioclc` application added the declaration but not the three uses and
  gated FAIL. Always re-gate immediately after transcribing a probe win.
* `tools/fast.py` needs `sys.path` to include `tools/` (build.py imports
  `fix_symsizes` unqualified); same for any script importing `verify_asm.py`.
* `recon/` is dirty with several PEER-owned files at all times — never
  `git add -A`; stage explicit paths only.

## 9. FILES / BACKUPS

* touched: `recon/game/common/speech.cpp`, `recon/game/common/audioclc.cpp`,
  `recon/game/common/audiocmn.cpp` (receipts only).
* backups: `scratchpad/w63a10/speech.cpp.baseline_20260815.bak`,
  `speech.cpp.submitrequest_dual_20260815.bak`,
  `speech.cpp.lose_seal_20260815.bak`, `speech.cpp.final_20260815.bak`,
  `audioclc.cpp.seal_20260815.bak`, `audiocmn.cpp`.
* probe kit: `ctx.py` (context diff on top of verify_asm), `p_lose*.py`,
  `p_report*.py`, `p_statusreply.py`, `p_sr2.py`, `p_ccs*.py`, `p_gcc*.py`.
* no `build.py` / `tools/` edits, no wiring specs pending.

---

## 10. CLOSE-OUT (post-resume re-verification)

Re-gated 2x after the session gap, on a freshly rebuilt tree:

| TU | run 1 | run 2 |
|---|---|---|
| `recon/game/common/speech.cpp` | 100/102 | 100/102 |
| `recon/game/common/audioclc.cpp` | **18/18** | **18/18** |
| `recon/game/common/audiocmn.cpp` | 47/48 | 47/48 |
| `recon/game/common/audiotrk.cpp` | 6/6 | 6/6 |

`tu_order_audit.py` = **0 inversions**. All four psyqproof seals re-confirmed
REAL=0 (SubmitRequest 61w, Lose 213w, GetClosestCars 267w, AddCustomObject 413w).

🔴 **NEW PROCESS FINDING — `brdist.py` CAN REPORT A FALSE DIVERGENCE (verify it
against psyqproof before treating a row as a bug).** The close-out screen flagged
`AudioTrk_AddCustomObject` branch 48 at ours 14 / retail 13, on a fn that gates
PASS 413/413 **and** is psyqproof REAL=0 over all 413 words. Inspection: the `j`
at stream index 283 targets index 297 in the oracle and 298 in our GATE object,
and index 297 is a **`nop`** — i.e. maspsx+GNU-as places the merge LABEL *after*
the load-delay nop where ASPSX places it *before*. Production is byte-true, so
this is a pure gate-lane label/nop placement artifact, not a branch bug.
⇒ the correct screen order is **brdist flags → psyqproof arbitrates**; a brdist
row whose target is a `nop` (or whose fn is already REAL=0) is an artifact.
(Contrast SubmitRequest §1, where brdist flagged -2 vs +8 and psyqproof
CONFIRMED REAL=1 — that one was a genuine, gate-invisible production bug.)

Commits: `68276047` (SubmitRequest dual-lane), `e394afe0` (Lose dual-lane),
`6a9c51c4` (GetClosestCars dual-lane, audioclc COMPLETE), `ef3c512e`
(Report/StatusReply/CheckState classifications), `55c02ca5` (receipts + kit).
No `tools/` or `build.py` edits; no wiring specs pending.
