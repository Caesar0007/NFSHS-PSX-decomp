# W64-A12 — the AI belt (recon/game/common)

Base HEAD at dispatch `fbc974f7`. Gate = `tools/verify_asm.py` (`-` = OURS, `+` = ORACLE).
Every number below was re-gated by me on this tree; nothing is quoted from a board row,
a briefing, or a prior wave's receipt.

---

## 1. PER-FN LEDGER

| fn | TU | briefed | RE-GATED baseline | final | delta |
|---|---|---|---|---|---|
| `DoRearEnder__15AIHigh_Opponent` | aih_opp | 92.07 / 50 | **50** @181/181 | **PASS 181/181** · psyqproof **REAL=0** | **DUAL-LANE SEAL** |
| `AIPhysic_CheckDesiredDirection__FP8Car_tObj` | aiphysic | 98.61 / 8 | **8** @18/18 | **PASS 18/18** · psyqproof **REAL=0** | **DUAL-LANE SEAL** |
| `CheckForWipeOut__15AIHigh_Opponent` | aih_opp | 85.79 / 50 | **50** @118/120 | 50 (truer basin banked, gates 55) | receipt |
| `HighExecute__10AIHigh_Cop` | aih_cop | 99.35 / 69 | **69** @1457/1460 | 69 (one residual isolated + falsified) | receipt |
| `AIPhysic_OutOfControlPhysics__FP8Car_tObj` | aiphysic | 99.47 / 5 | **5** @413/412 | 5 (three more axes closed) | receipt |
| `HighExecute__18AIHigh_BTC_Wingman` | aih_btccop | 99.82 / 4 | **4** @675/675 | 4 (instrument pointed, wrong starts eliminated) | receipt |
| `CheckChaserPosition__16AIHigh_BasicPerpii` | aih_basicperp | 97.70 / 2 | **2** @85/87 | 2 (device class excluded on mechanism) | receipt |
| `AIPhysic_CalcAcceleration__FP8Car_tObji` | aiphysic | 99.97 verify | **PASS (184)** | — | stale row |
| `CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi` | aistate | 99.95 verify | **PASS (109)** | — | stale row |

**TU gate state at close** (each gated 2×, **zero PASS→FAIL anywhere**):
`aih_opp 5/6` (was 4/6) · `aiphysic 41/42` (was 40/42) · `aih_btccop 39/40` ·
`aih_basicperp 8/9` · `aih_cop 9/10` · `aistate 52/52`.
`tools/tu_order_audit.py` = **0 inversions** (508 objects).

Commits: `a4d80b46` · `a77530f4` · `0438d383` · `dd728d64` · `8f609ae2`.

---

## 2. LAWS / CATALOG-ROW CANDIDATES

### 2.1 🏆🏆 THE `"m"`-CONSTRAINT FENCE — a NEW zero-insn instrument
`__asm__("" : : "m"(GLOBAL.field));`

Every fence in the toolkit so far takes **`"r"`** (or `"i"`), i.e. a **register** operand.
To reference a global that way you need a pointer *value*, so gcc pulls the `%lo` out of
the load and pays an `addiu`. An **`"m"` operand is a MEMORY reference**: gcc legitimizes
the address, cse folds it onto the `%hi` pseudo that is already there, and **nothing is
emitted**. So it is the only device that can add a **second memory reference off an
existing `%hi`** at zero cost.

* Sealed `AIPhysic_CheckDesiredDirection` **8 → PASS 18/18** after **five waves** of
  certificates. The w59 RTL certificate had the mechanism exactly right — p85 (the `%hi`
  addr pseudo) **dies at** the dead `lw` and p86 (its dest) is **born at** it, so
  `block_alloc` legally gives both `$2`, leaving `$3` free for `turnAroundSpeed` instead
  of retail's SYM `REG $5` — and even named the cure ("only a 2nd memory ref off the same
  `%hi` keeps that pseudo live for free"). Nobody had a device for it.
* **POSITION IS LOAD-BEARING**: after the read = PASS; before it = inert 8;
  `"m"` on the volatile-cast lvalue = 1 @19; `"m"` alone (dropping the dead read) = 7 @17.
* **Directional law**: a fence's *operand class* selects **which pseudo's live range** it
  extends. `"r"` extends the VALUE's; `"m"` extends the ADDRESS's. The whole
  output-bearing family on the value (identity/opacity, identity+read-only, identity ×2,
  read-only alone) is **inert here, byte-identical** — because the conflict retail needs
  is on the BASE, not the dest.
* Applicability test (mechanical): *ours self-temps a load (`lui rD; lw rD,(rD)`) where
  the oracle uses a separate scratch, and the loaded value has no use.*

### 2.2 🏆 `__builtin_abs` IS A BASIC-BLOCK LEVER, NOT JUST AN IDIOM LEVER
Sealed `DoRearEnder` **50 → PASS 181/181**.

Retail defers the `mflo` of `longDistance * direction` **past** the `latDistance` sign
test at both sites. **No scheduler can do that while the abs is a real branch**: a
hand-rolled `if (x < 0) x = -x;` splits the region into three basic blocks and pins the
`mult`/`mflo` pair in the first one. `__builtin_abs` is **ONE RTL insn** (its
`bgez/nop/negu` is an asm template, invisible to the CFG), so the region stays **one**
basic block, sched2 places the `mflo` after it exactly like retail — and the two 32-bit
range constants then fall into the `roadPosition` load-delay slots for free.

*Recognition row*: **an oracle `mflo` (or any long-latency result read) that sits on the
far side of an abs/min/max branch is telling you the source used the BUILTIN, not the
branchy spelling.*

### 2.3 🔴 ORDER OF LANDING IS LOAD-BEARING FOR A MULTI-SITE LEVER
Same lever, three landings, three different scores — all re-gated:

| what | result |
|---|---|
| in-loop site only | 50 → **24** |
| site 1 only | 50 → 60 |
| **both at once, from the 50-basin** | 50 → 34 |
| site 1 **after** the in-loop site had landed | 24 → **PASS** |

⇒ When a lever applies at N sites, **land them one at a time and re-measure**; a
"both-at-once = worse" reading is not a falsification of the lever.
(04Z again: W59's *"`__builtin_abs` makes it WORSE (58)"* receipt was measured in a basin
where the **other** site still had the branchy abs.)

### 2.4 🔴 A DEVICE THAT BOUGHT DIFFS IN AN OLD BASIN IS SCAFFOLDING IN A NEW ONE
W63 landed DoRearEnder 54→50 with **named + opacity-fenced** `lo1`/`hi1` constants — a
correct, well-receipted dial *for the branchy-abs basin*. Post-`__builtin_abs` ablation:

| form | result |
|---|---|
| **plain literal constants, zero asm, zero named temps** | **PASS** |
| named, unfenced | PASS |
| named + opacity fence (the w63 landing) | 34 |
| fence order reversed | 30 |
| one fence only | 34 |

⇒ After every structural landing, **re-measure the devices you are carrying and delete
the ones the structure retired.** The seal here has *fewer* instruments than the
near-miss it replaced. (Companion to 15B/13F, from the deletion side.)

### 2.5 THE FALSIFICATION-BY-DEVICE-CLASS RULE (a cheap triage)
Before spending a device, ask **which pseudo's liveness the residual needs**:
* register-value liveness → `"r"` / identity fence;
* **address/`%hi` liveness → `"m"` fence** (2.1);
* a cse **value-range record on a register qty** (`cse.c qty_comparison_code/_const`) →
  **no memory device can reach it** — only giving the guard a different qty can, which is
  why every barrier-only attempt on `CheckChaserPosition` (void-tail, operand-less) is
  inert and every value-fence restores the branch *at the price of the copy*.

---

## 3. FALSIFICATIONS (all re-gated; basin stated)

| fn | angle | result |
|---|---|---|
| CheckDesiredDirection | identity/opacity fence on the loaded value | **inert** 8 @18/18, byte-identical |
| CheckDesiredDirection | identity + read-only; identity ×2; read-only alone | inert 8 (all byte-identical) |
| CheckDesiredDirection | identity fence on an out-of-block copy | 3 @19 (one insn over) |
| CheckDesiredDirection | `"m"` fence **before** the read / on the volatile lvalue / alone | 8 · 1 @19 · 7 @17 |
| OutOfControlPhysics | whole fence family between the call and `cfg = &AIPhysicConfig` (void-tail `"i"(0)`, read-only on currentLatVel / carObj / cfg, identity on cfg) | **one basin: 16 @414, all byte-identical**; the +1 is a BROKEN simGlobal-`%hi` CSE and the lo_sum still wins the jal slot |
| OutOfControlPhysics | move the `cfg` assignment into retail's own block (after the if-block / after the wipeOutEndTick store / as `&…latvelcalc_lookahead`) | 9 @413 in all three — the lo_sum **still** lands in the jal slot, now with a split `lui v1` ⇒ it is **not** statement-position-pinned |
| OutOfControlPhysics | 5-way permutation of {drag=0, uTurn=0, call, cfg=&…} | every order with cfg after the call = **inert 5**; cfg-first 9; drag-after-call 13 |
| CheckForWipeOut | name the LICM-hoisted product back into a loop-body local (`int inv=…` in the loop, or the fn-scope var assigned there) | 88 @122 |
| CheckForWipeOut | drop the now-unused `new_var` declaration (x1 basin) | inert 55 — decl order is not the dial here |
| CheckForWipeOut | drop the w63 playFines REF-STEP fence (x1 basin) | 64 @120 |
| CheckForWipeOut | read `Cars_gNumHumanRaceCars` directly in the for-condition | 67 @121 |
| CheckForWipeOut | `AI_elapsedTime*29*4` vs `*116` | identical |
| CheckForWipeOut | `new_var` inside the `pInfo` guard (3 positions) | 61 / 61 / 55 @121 |
| aih_cop HighExecute | inner `(mode==1)||(mode==4)` through a fresh named `int m4 = 4` | 81 @1457 |
| aih_cop HighExecute | ... + an opacity fence on it | 82 @1458 |
| aih_cop HighExecute | inner test through a freshly re-read `mode1b` | 81 @1457 |
| Wingman | `&trafficOffset` at BOTH remaining arms | 489 @698 (frame −104→−112) — **basin-independent**, re-measured 2 waves later |
| DoRearEnder | site-1 `__builtin_abs` **before** the in-loop site | 60 |
| DoRearEnder | both sites at once from the 50-basin | 34 |

---

## 4. SHARPENED RESIDUALS (what the next agent should pick up)

* **CheckForWipeOut 50** — a **structurally truer basin is banked**:
  `scratchpad/w64a12/aih_opp.cpp.x1_55` (also fully described in-source). Delete the
  pre-loop `new_var` and write `perTickProb = AI_elapsedTime * 116;` in **both** arms; the
  w63 movable-existence law then does the whole job by itself — `perTickProb` is set twice
  so loop.c builds no movable for it, but the `29*ae` **subchain** is a once-set cse temp,
  so loop.c hoists exactly that. Result: retail's preheader **byte-for-byte** (fresh
  `lui/lw` reload of `AI_elapsedTime` + `sll3/subu/sll2/addu`, oracle 74–81) **and**
  `sll a0,t2,2` kept in the loop, duplicated into both branch delay slots (oracle 103/107).
  Residual there = one stray beq-slot nop + a clean **3-way `$t` rotation** (ours
  this=t1 randVal=t2 29ae=t0 vs retail this=t0 randVal=t1 29ae=t2) — an
  allocsim/reqdelta/**multidial** job on a *correct* structure, which is strictly better
  posed than the 50-basin's closed-form "two pseudos dying on one insn" impossibility.

* **Wingman 4** — the named lens now **exists**. `scratchpad/w64a10/{dump.py,copypref.py}`
  (w64-a10's 12A local-alloc instrument) runs on `aih_btccop.cpp`; my qty table is at
  `scratchpad/w64a12/wing_qty.txt`. It prints per block-local qty: refs / birth / death /
  `QTY_CMP_PRI` / `copy_sugg` / arith sugg / predicted-vs-**actual** hard reg, plus
  `--why <pseudo>` (find_free_reg window + BLOCKED/FREE sets) and `--want <pseudo>=<reg>`.
  **Wrong starting points already eliminated**: the pseudos whose `copy_sugg` merely
  *contains* `a2` (p198 block 23, p212 block 27) **cross a call**, so the whole
  caller-saved bank is excluded from their window by construction. Chase the 2-ref pseudo
  **born at the memset return and dying at `addu a2,v0,zero`**.

* **CheckChaserPosition 2** — device class narrowed on mechanism (§2.5). The instrument
  prints local-alloc **eligibility** (`local-alloc.c:470-477`:
  `REG_BASIC_BLOCK >= 0 && REG_N_DEATHS == 1`) directly — that is the exact bit `pos`
  fails, which is why `combine_regs` (`:1866`) refuses to tie the opaque copy and it stays
  a real `addu`. Read `pos`'s line before another spelling wave.

* **OutOfControlPhysics 5** — source shape is now **exhausted** (fence family, cfg-placement,
  statement order, cfg purge, storage shape all closed with receipts). Both candidate
  insns write **callee-saved** regs, so sched2 may move either across the `CALL_INSN`; the
  pick is a ready-list tie at equal (zero) in-block priority. `-dR`/qtytrace only.

* **aih_cop HighExecute 69** — one residual isolated and its cheap angle killed (§3). What
  retail has at the inner `(mode==1)||(mode==4)` is **two separate constant pseudos with
  cse declining to share across the intervening branch** — a cse constant-table question,
  so the lens is `-dl`/`-dg` (or copypref) on that block pair. The remaining ~64 are the
  scattered caller-saved naming bands the w63 multidial program was working through.

---

## 5. TOOLS / FILES

* `scratchpad/w64a12/w64a12_probe.py` — JSON-driven variant prober: byte-mode, `count==1`
  asserts per substitution, gates one fn, **restores in `finally`**, appends `probe.log`.
  Sibling of `tools/fencesweep.py` / w64-a6's `vprobe6.py`; promote-worthy.
* Variant sets (reproducible): `ooc_v{1,2,3}.py`, `rear_v{1,2}.py`, `wipe_v{1,2,3,4}.py`,
  `cdd_v{1,2}.py`, `cop_v1.py` (+ their `.json`).
* Basins/backups: `aih_opp.cpp.{base50,wipe52,x1_55}`, `aih_btccop.cpp.base4`,
  `aih_cop.cpp.base69`, `aiphysic.cpp.base`, `wing_qty.txt`, `work/*.lreg`.

## 6. HAZARDS HIT

* `python - <<'PYEOF'` heredocs: **bytes literals cannot contain non-ASCII** — one emoji in
  a receipt string aborted the whole script *after* the gate had already run (the file was
  untouched, but the run was wasted). ASCII-only in scripted edits, always.
* `aih_cop.cpp` is **LF-only** while its five TU siblings are **CRLF** — anchors must be
  derived per file. Verified the committed blob is still pure LF (git's
  "LF will be replaced by CRLF" warning is about future checkouts, not this commit).
* Byte-scanned every touched TU after every scripted edit: **0 NULs, 0 control bytes,
  line-ending regime unchanged** (`aih_opp` 601 CRLF/601 LF, `aiphysic` 1927/1927,
  `aih_cop` 0/2268).
* `git log --oneline -1` shows a **peer's** commit under concurrent belts — verify your own
  SHA with `-5`. (Fired twice.)
* Only my own TUs were staged, by explicit path; one `git checkout -- <my own file>` was
  used to drop a probe leftover **after** the seal was already committed.

No `tools/*.py` edits, no build.py rows, no memory-dir writes, no user-live TUs touched.
