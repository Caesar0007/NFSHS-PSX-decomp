# W64-A10 RECEIPTS — the 12A copy-preference/availability LAB + the speech/audio belt

Repo HEAD at start `fbc974f7`. Every number below re-gated by me with
`tools/verify_asm.py` / `tools/tugate.py`; production via `tools/psyqproof.py`.
**No source landed this run** — the three belt residuals are unchanged at their
baselines and are now closed with *instrument-generated* hardness certificates.

## 0. RE-GATED BASELINE (all rows matched w63's close-out; zero stale rows)

| fn | baseline (mine, re-gated) | end state |
|---|---|---|
| `Report__Q26Speech15DispatchSpeakerP8Car_tObj` | 11 (103/104) | 11 — CERTIFICATE (mechanism-exact) |
| `StatusReply__Q26Speech15DispatchSpeaker` | 5 (268/269) | 5 — CERTIFICATE (mechanism-exact) |
| `AudioCmn_CheckState__FP8Car_tObj` | 4 (415/415) | 4 — CERTIFICATE + root cause FOUND |
| `Lose__Q26Speech13MobileSpeaker` | PASS 213 | PASS (held) |
| `SubmitRequest__6Speechlll` | PASS 61 | PASS (held) |
| `AudioClc_GetClosestCars__Fiii` | PASS 267 | PASS (held) |
| `AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji` | PASS 413 | **PASS + psyqproof REAL=0 RELOP=0 — DUAL-LANE re-confirmed** |

TU gate: `recon/game/common/speech.cpp` **100/102** (unchanged, gated after all
probes). `audiotrk` 6/6, `audioclc` 18/18 hold. `audiocmn.cpp` is **peer-owned
this wave** (w64-a19 landed a link fix in it while I was probing) — see §6.

⚠ `AudioTrk_AddCustomObject` is `__FP9AudioElemiP8coorddefiP8Car_tObji`, NOT the
`__FP18Track_CustomObject…` name in the briefing (that mangling has NO oracle).

---

## 1. 🏆 THE INSTRUMENT — `scratchpad/w64a10/copypref.py` (promote-worthy)

The 06E gap's **local-alloc half**: allocsim/reqdelta model `global.c`; nothing
modelled block-local QTYs, their **suggestions**, or `find_free_reg`'s
**availability window**. `copypref.py` replicates `block_alloc` from the REAL
compiler's own `-dl` dump and answers *"P landed in H — why, and what would it
take to land in H'?"*.

**Input = `CC1PLPSX … -dl` (`.lreg`)**, which carries everything needed:
the per-pseudo header (`used R times across L insns [in block B][; dies in D
places][; crosses C call(s)]`), `;; Start of basic block N.` +
`;; Registers live:` (= `basic_block_live_at_start`, the hard-reg liveness
SEED), the whole RTL, and `;; Register N in H.` = local-alloc's **actual
handout** — so the tool validates itself against the compiler.

**VALIDATION (predicted hard reg vs the dump's own handout, every block-local
pseudo):**

| TU | agreement |
|---|---|
| speech.cpp | 1251/1287 = **97.2%** |
| audiotrk.cpp | 235/239 = **98.3%** |
| audioclc.cpp | 415/447 = **92.8%** |
| audiocmn.cpp | 1038/1151 = **90.2%** |
| **total** | **2939/3124 = 94.1%** |

and **exact on all three target pseudos** (StatusReply p199, CheckState p246,
Report p115). Residual misses are v0↔v1-class serving-order ties; the model does
not yet implement `must_match_0` constraint ties, SCRATCH qtys, or DImode sizes.

Modes: `--list`, `<fn>` (qty table), `--why P` (window + BLOCKED/FREE **at that
qty's turn**, not after), `--want reg` (the requirement), `--validate`.

### gcc-2.8.1 facts the tool is built on (read, not guessed)

* **`local-alloc.c:470-478` ELIGIBILITY** — a pseudo is local-alloc'd iff
  `REG_BASIC_BLOCK(i) >= 0 && REG_N_DEATHS(i) == 1`. The `.lreg` header prints
  BOTH (`in block N` / `dies in D places`). **A pseudo that is multi-block or
  dies twice is a GLOBAL allocno and NO copy suggestion is ever recorded for
  it** — that is the mechanism behind the 12E/13B identity launder, now stated
  as an eligibility rule instead of a folk device.
* **`combine_regs` (1876-1940)** — pseudo × hard reg never ties; it records the
  hard reg in `qty_phys_copy_sugg` when the insn is a plain move
  (`may_save_copy`, 1444) else in `qty_phys_sugg`. It **bails first** if the
  used pseudo has no qty.
* **`block_alloc` only ever offers combine_regs an operand that IS a REG** —
  MIPS load/store operand 1 is `m`, not `p`, so `(set (reg P) (mem (plus (reg B) k)))`
  does **not** tie P to B. (`lo_sum`/`high`/`plus`/`ashift` operands DO.)
* **Two-group allocation** — GROUP 1 = every qty with a suggestion, ordered by
  `qty_sugg_compare` (`ncopy ? ncopy : nsugg*76`, then `QTY_CMP_PRI` desc),
  served by `find_free_reg(just_try_suggested=1)` which restricts the candidate
  set to the copy-suggested regs (else the arith-suggested ones) and picks the
  **numerically lowest free** one. GROUP 2 = the rest, `QTY_CMP_PRI` desc (ties
  → lower qty number), plain ascending 0..75 scan (MIPS has no
  `REG_ALLOC_ORDER`). `post_mark_life` makes each winner busy over its window
  for every LATER qty.
* **`find_free_reg` window** — `used = fixed|call_used ∪ ⋃regs_live_at[ins]
  for ins in [birth,death) ∪ ~class ∪ eliminables{$0,RAP,$fp}`;
  `regs_live_at[2n]==regs_live_at[2n+1]==` hard regs live **after** insn n, so
  the window is "live-after insn birth … insn death−1".
* **`optimize_reg_copy_1` (753-800)** — for `(set (reg D) (reg S))` where S does
  NOT die there, it rewrites every later use of S to D inside the block and
  **moves S's death note back onto the copy**. `SMALL_REGISTER_CLASSES` is 0 on
  MIPS ⇒ **it fires with D a HARD register**. This is why a sched1-hoisted arg
  copy swallows a following store (`sw a3` where retail has `sw v1`).
* **`global.c:1573-1580 set_preference`** — it converts a source pseudo to its
  hard reg via `reg_renumber` first. ⇒ **a global allocno fed by a
  LOCAL-allocated pseudo inherits that pseudo's hard register as a preference**
  (`copy=0` when the src is not a bare REG — the 13A first-operand law).

## 2. 🔴🔴 NEW LAW — THE LOCAL-ALLOC BLINDNESS RULE (the wave's transferable finding)

> **`local-alloc`'s availability scan sees HARD REGISTERS ONLY.** A register
> that a *pseudo* will occupy after global-alloc/reload does **not** block it at
> local-alloc time. Therefore a residual whose fix requires register R to be
> "busy" across a block-local qty's window, where R is in fact held by a pseudo,
> is **unreachable by every ref / live-length / priority / fence dial** — the
> blocking value does not exist yet. Only a hard-reg clobber can express it.

This generalises the W63 A16 correction (priority ≠ availability) and is the
common root of all three of my residuals. **Triage rule:** on any suggestion-less
block-local qty, run `copypref --why/--want` FIRST; if the registers that must be
blocked are pseudo-held, stop dialling and file the certificate.

## 3. StatusReply — 5 @268, CERTIFICATE COMPLETE (both sides)

`copypref`: p199 (`wing`) = block 15, **block-local, 1 death**, refs 2, window
[32,42); `copy_sugg={a3}` from the single `(set (reg a3) (reg 199))`; **a3 FREE**
in the window ⇒ GROUP 1 hands it a3 and the copy self-deletes. Confirmed against
the compiler's own handout (`;; Register 199 in 7.`).

**The RTL chain that produces it (new, named):** sched1 hoists the a3 arg copy
above the `fWing` store → `optimize_reg_copy_1` rewrites the store's source to
`$a3` and moves 199's death onto the copy → `combine_regs` records `copy_sugg=a3`
→ GROUP 1. (Our `.lreg` store literally reads `(set (mem …64) (reg:SI 7 a3))`
while the post-sched1 `.sched` dump still reads `(reg 199)` — the rewrite is
`optimize_reg_copy_1`, not the scheduler.)

**Requirement, exactly:** kill the a3 suggestion **AND** make `$v0` unavailable
over [32,42) (at p199's turn both v0 and v1 are FREE, so killing the suggestion
alone yields **v0**, not retail's v1). Killing the suggestion needs p199
non-block-local or 2 deaths — impossible for a straight-line two-use value in one
block; the alternative is occupying `$a3`, which only an asm clobber can do.

**PRICED (measurement only, nothing landed):** `__asm__ __volatile__("" ::: "$7")`
— the parked pin-adjacent device — at three placements:

| placement | gate |
|---|---|
| before the `wing` computation | 18 @**269** |
| after the `wing` computation | 10 @**269** |
| before the `fWing` store | 14 @**269** |

⇒ **the model's positive prediction is CONFIRMED** (all three go count-EXACT
269/269 — retail's missing `addu a3,v1,zero` is minted) **and the device is a NET
LOSS** (best 10 vs the 5-diff baseline; it is also a scheduling barrier and it
rotates the arg block). This retires the standing hope that the parked
`$4`-clobber policy decision would seal this class.

**Also falsified this run (5 @268, i.e. inert):** the SLD-driven single-statement
forms. `tools/sldall.py` shows retail's insns 163-175 — the a0/a2 setup, the
index scale, the load, a1, `fSpikeSide.flags=4`, the stack-arg address, the
`fWing` store, the `a3` copy, the `jal` and the stack store — are **ALL SLD line
1687**, i.e. one source line. Rewriting the store as the 4th *argument
expression* (`…, (pThis->_base_Speaker).fWing = wing, …`) = **5**; as a comma
expression `((…).fWing = wing, wing)` = **5**; inlining the value into that
argument = 219. The re-read control reproduces at 6 @269. ⇒ **statement grouping
is codegen-inert here; the SLD identifies retail's statement but does not enforce
it (06A caveat) and the residual is purely allocator.**

## 4. AudioCmn_CheckState — 4 @415, ROOT CAUSE FOUND (was "12E cell, both sides bounded")

Site (`diffsrc`): `if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;`
ours `lui v1,%hi; addiu a1,v1,%lo` vs retail `lui a1; addiu a1,a1`.

`copypref` + the handout give the exact split:

* **p246 = the `(high SYM)` pseudo** — block 38, **block-local**, no suggestion
  ⇒ GROUP 2 ascending scan; `$v0` is already taken by an earlier *suggested* qty
  ⇒ **v1**.
* **p245 = the `(lo_sum …)` pseudo** — `block=None`, i.e. a **GLOBAL allocno**
  (the address is CSE'd across the `goto` into the next block, where the oracle
  also reuses it: retail insn 261 `addu v0,v0,a1`) ⇒ allocated by `global.c`
  ⇒ **a1**.
* The two therefore **cannot tie** (`combine_regs` refuses a non-block-local
  dest), and `set_preference` makes the lo_sum FOLLOW whatever hard reg the high
  received (`reg_renumber` conversion). **Retail = a1/a1 because retail's HIGH
  got a1**; ours = v1/a1 because ours got v1.

**Requirement:** `$v1` **and** `$a0` unavailable over p246's 2-insn window [4,8).
In our build `carspeed` (retail's `$a0`) is a *pseudo* at local-alloc time ⇒
blindness rule ⇒ unreachable. **PRICED:** `"" ::: "$3"` = 4 (inert),
`"" ::: "$3","$4"` = 28, `"" ::: "$2","$3","$4"` = 28.

## 5. Report — 11 @103, CERTIFICATE COMPLETE

`copypref`: p115 (the `pSVar6->_vf` pointer) = block 3, block-local, refs 3,
window [24,28), **no suggestion** ⇒ ascending scan. At its turn only `$a0`
(earlier suggested qty) + sp/fp are blocked ⇒ **v0**. Retail's **a1** requires
`$v0` **and** `$v1` unavailable across those two insns.

`$v0` can only be blocked by keeping the *previous* call's return live — i.e. by
moving the `addu s0,v0,zero` copy below the vf loads, which W63 already proved is
an **expand** position (`-fno-schedule-insns{,2}` leave it glued to the call).
`$v1` is pseudo-held (it carries `pSVar6`). ⇒ blindness rule; the residual is
**two** hard-reg availabilities, only one of which is even nameable.

This supersedes the w63 "one caller-saved pseudo holding $v0" formulation:
**$v0 alone is not enough** — the scan would then take `$v1`.

## 6. HAZARDS HIT

* 🔴 **`tools/fast.py`'s CRLF heuristic is per-FILE and my belt is LF-only** —
  `crlf = count("\r\n") > count("\n")//2`, so a probe written with `\r\n`
  anchors silently ANCHOR-MISSes on an LF TU (and vice-versa). Derive the
  ending from the file, never from habit (W60-12K, fired again).
* 🔴 **Concurrent-peer whole-file restore**: `fast.run` snapshots and restores
  the WHOLE TU. `recon/game/common/audiocmn.cpp` was being edited by w64-a19
  during my probes; had their write landed inside my probe window my restore
  would have reverted it. I stopped probing that TU after one round and
  re-verified their edit is intact. **Rule: never run a whole-file probe
  harness on a TU another belt owns this wave.**
* `--why` originally printed the FINAL `post_mark_life` marks instead of the
  marks **at that qty's turn**, which made a free register look blocked (it
  briefly mis-told me StatusReply would land v1). Fixed: the tool now records
  `find_free_reg`'s `used` at decision time. *An instrument that misreports is
  worse than none* — validated against the handout after the fix (97.2% held).
* `dump.py` deletes stale dumps before each run, so a `-dS/-dj` run wipes the
  `.lreg`; re-run with `-dl` before using `copypref`.

## 7. CATALOG-ROW CANDIDATES (orchestrator harvests)

1. **THE LOCAL-ALLOC BLINDNESS RULE** (§2) — symptom: a suggestion-less
   block-local qty sits in a lower-numbered register than retail; fix/triage:
   `copypref --want`; if the registers that must be blocked are pseudo-held,
   it is unreachable by every dial (fences included) — file the certificate.
2. **THE ELIGIBILITY RULE IS THE COPY-PREFERENCE SWITCH** — `REG_BASIC_BLOCK>=0
   && REG_N_DEATHS==1` (local-alloc.c:470). A copy-preference edge exists **only
   for a block-local, dies-once pseudo**; that is *why* the identity launder
   (dies twice ⇒ global) kills a preference, stated as a law instead of a trick.
   Corollary: `.lreg`'s header line reads BOTH facts off for free.
3. **`optimize_reg_copy_1` FIRES WITH A HARD-REG DEST ON MIPS** — a
   sched1-hoisted arg copy rewrites a following store to the arg register and
   moves the death note onto the copy, which is what *creates* the
   copy-suggestion that then deletes the copy. Symptom: `sw <argreg>` where
   retail has `sw <temp>` + a surviving `addu <argreg>,<temp>,zero`.
4. **`set_preference` makes a global allocno FOLLOW a local-allocated source**
   (`reg_renumber` conversion, global.c:1573) — an un-tieable `{high, lo_sum}`
   pair lands in one register iff the HIGH's local-alloc pick is available to
   the lo_sum. Fix the HIGH, not the pair.
5. **The hard-reg clobber fence is the ONLY availability dial — and it is
   priced** (§3): count-exact but +5..13 diffs on two independent fns. Useful
   as a *diagnostic* (it proves the mechanism), not as a cure.
6. **SLD statement grouping can be codegen-inert** (§3): retail's one-line
   statement group reproduced three ways, all 5 @268 — 06A's "the SLD identifies,
   it does not always enforce" with a clean receipt.

## 8. FILES

* new (this agent, nothing in `tools/` or `recon/` touched):
  `scratchpad/w64a10/copypref.py` (the instrument, **promote candidate**),
  `dump.py` (build.py-faithful `-d*` dump driver),
  `p_sr.py` (StatusReply statement-shape sweep),
  `p_clob.py` (clobber pricing, measurement-only),
  `work/` (dumps), this file.
* `git status` for my belt TUs is clean apart from the peer's `audiocmn.cpp`.
