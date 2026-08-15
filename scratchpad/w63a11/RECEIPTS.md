# W63-A11 receipts — camera / physics / newton belt

Gate = `tools/verify_asm.py` / `tools/tugate.py`, every number below re-gated by me
(baseline first, per fn). `tu_order_audit.py` = **0 inversions** at close. All three
TUs gated 2×, zero PASS→FAIL. No `tools/` file, no `build.py`, no memory-dir write.

## Belt scoreboard

| fn | re-gated baseline | final | delta |
|---|---|---|---|
| `Camera_UpdateHeliCam__Fii` | 12 (445/443) | **9** (444/443) source-only — **PASS 443/443** with the 4 TEXT_MOVES rows | −3, **seal pending wiring** |
| `Camera_UpdateSplineCam__Fi` | 55 (350/351) | 55 | 0 — certificate re-affirmed |
| `Physics_CalculateCarAcceleration__FP8Car_tObj` | **PASS** (710) | PASS | briefed row 99.98 was STALE |
| `Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct` | 49 (349/346) | **21** (347/346) | **−28** |
| `Physics_Real__FP8Car_tObj` | 6 (1272/1272) | 6 | 0 — briefed row 99.97 was STALE (already 6, count-exact) |
| `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` | 73 (105/106) | 73 | 0 — 2 families falsified |
| `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj` | 73 (467/470) | **70** (468/470) | −3 + the 48th branch **localised** |

TU totals: camera 36/38, physics 20/22, newton 30/32 — all unchanged in PASS count.
Net **−34 diffs** + one function reaching PASS as soon as its mechanism rows land.

---

## 1 — WAVE OPENER: THE LABEL-RELOCATION PROBE ✅ **ANSWERED YES**

**QUESTION (W62-A11):** `PER_FN_TEXT_MOVES` "relocates LINES but cannot change a branch
TARGET", so HeliCam's three reorg TARGET-STEALS looked to need a new mechanism.

**DERIVATION.** A label is just a line, and `_apply_text_moves` (build.py:1699) is a pure
line-regex engine — so **moving a label across an instruction is the same edit as moving
that instruction across the label, expressed from the other side.** The in-tree
positive control already exists: the `InGame_ResetPSXController__Fii` row (build.py:1208)
takes a `lui` whose lookahead is `(?=\$L\d+:\n…)` and re-inserts it *after* that same
`$L\d+:` — a label relocation nobody had named as such.

**PROBE 1 (label move only), run 2×:** 12 → **10** diffs. Control through the same
harness = 12. The move:

```
$L615:                                    $L615:
  lui $3,%hi(Input_gLookBehind)   ==>     $L641:
$L641:                                      lw  $2,20($sp)
  lw  $2,20($sp)                            lui $3,%hi(Input_gLookBehind)
```
`j $L641` now lands on the `lw` and re-executes the (idempotent) `lui`; the `$L615`
path is unchanged. Retail's `lw`-before-`lui` order is restored.

**PROBE 2 (+ the 2nd target-steal), run 2×:** 12 → **7** (444/443).
**PROBE 3 (+ both remaining steals), run 2×:** 12 → **3**, then **PASS 443/443** once the
coupled source edit landed.

**THE SECOND GENERALISATION (also new): a stolen delay-slot copy can be DELETED by
un-wrapping the branch's `.set noreorder` block.** `drop_after` accepts a MULTI-LINE
regex, so one move can (a) take the `beq`/`bgez` line out of its
`.set noreorder/.set nomacro … .set macro/.set reorder` wrapper and (b) delete the whole
wrapper — leaving the branch in reorder mode, where **maspsx appends the `nop` itself**
(`maspsx/__init__.py:1064`). That is exactly retail's empty slot, at zero risk of an
un-slotted branch.

**Spec:** `scratchpad/w63a11/tm_helicam_spec.json` (4 rows, all anchors label-agnostic
`$L\d+`, all disambiguated by lookahead). **Probe harness:** `tools/vprobe.py` with
`W60_TEXT_MOVES_FILE=` — no `build.py` edit at any point.

🔴 **ANCHOR HAZARD PAID FOR (12F extension):** `re.search` takes the FIRST match in the
whole fn region, so a bare `\tbeq\t\$20,\$2,\$L\d+\n` anchor silently bound to an
unrelated `beq` 300 lines earlier — the move applied, the `drop_after` did not, and the
score sat at 10 looking like a plateau. **Every anchor in a >100-insn fn needs a
lookahead on the line it is supposed to precede**, not just the `take`.

## 2 — `Camera_UpdateHeliCam` 12 → 9, PASS 443/443 coupled  (commit `d61ee253`)

The residual after the three steals was a **jump-threading** difference: ours
`bnez → $L579 → j $L640` (a trampoline), retail `bnez → $L580` direct with `li $17,-3`
in the surviving `j`'s slot. The blocker was the in-source void fence sitting at
`$L579`'s head — `thread_jumps` will not thread through a block whose first item is an
asm.

But the fence was load-bearing for a *different* job: both `lookahead` arms end in the
identical `lookahead = -3;` tail and **cross_jump merges them without it** (dropping it:
8 diffs @441, 2 insns SHORT). **The fix is to move the un-merge device to the OTHER arm's
tail** — it un-merges exactly the same (the arms still differ by one asm) while leaving
the wrongway arm's exit label asm-free, so the thread fires.

Priced (all gated, `+moves` column probed 2×):

| variant | alone | + the 4 moves |
|---|---|---|
| fence at wrongway-arm tail (shipped) | 12 | 3 |
| **fence at ELSE-arm tail (landed)** | **9** | **PASS 443/443** |
| fence dropped | 8 @441 | 8 @441 |
| fence before the inner if | 8 @441 | 8 @441 |
| fence inside the inner if | 12 | 3 |
| fence in BOTH arms | 12 | 3 |
| arms swapped | 7 @444 | 7 @444 |
| `__volatile__` flavour / goto-out-of-arm1 | 9 | PASS |

## 3 — `Physics_CalculateTireForces` 49 → 21  (commit `d6aad74c`)

**RESULT-FUNNEL + EXPLICIT if/else ARMS.** Retail computes both `finalAcc.x` clamp arms
into ONE register and stores once after the join (oracle `0x800ABEF8` / `0x800ABF14`
`addu $v1,…` then a shared `sw`); ours stored per-arm.

🔑 **The ARM SHAPE dominates the funnel** — funnel + ternary arms **53@351**, funnel +
if/else arms **21@347**. This is 09C at full strength: a `COND_EXPR` whose target is a
MEM stores in *both* arms, so a ternary can never reach a shared-store shape no matter
where the funnel variable goes. W62 had funnelled this site *as a ternary* and measured
it non-additive at 49 — the ternary was the reason.

Falsified on this basin: site-A's full funnel too **22@348** (the w59-a2 asymmetry
receipt there still stands); a `cap` local for `velCap.x` **57@351**; `xAcc` declared
first vs last **neutral (21 both)**.

**Clamp axis CLOSED (new falsification family).** The `:2002` hotspot (5 diffs) is the
`max(minSlipAngle,|slipAngle|)` / `min(0x20000,…)` pair, written as a doubly-repeated
nested ternary. Every clamp-in-place spelling **loses insns** because it collapses the
duplicated `__builtin_abs` that retail keeps: new local `a` **33@341**, reuse `xAcc`
**63@345**, clamp through `minSlipAngle` itself **39@341**, hoisted-abs local with the
ternary kept **30@344**, assignment-split form **33@341** — vs control 21@347 (oracle
346). ⇒ retail duplicates the abs; the 09A clamp-shape dial is the WRONG direction here.
Residual = seat + `bnez`/`beqz` polarity at SLD 1949.

## 4 — `Newton_TestForUndrivableSurfaces` 73 → 70, and the 48th branch LOCALISED  (commit `55847237`)

**Landed (09J, faithful):** retail writes `normal.y = 0;` at the END OF EACH undrivable-
centre arm as well as at the join — the SLD puts an extra `sw zero,20(sp)` on 2290 (arm 1)
and 2313 (arm 2) on top of the joined 2317. Both arms **73→70 @468**; arm1 alone 72@468,
arm2 alone 71@467, `y`-between-`x`-and-`z` **88**.

**W62's branch-census contradiction is RESOLVED.** The missing 48th branch is at
`0x800A34F4/F8`:

```
beqz $s6, .L800A3594     collision_type == 0  -> the NEXT-i loop head
 addu $t3,$zero,$zero    [delay slot]  SLD 2321
bnez $t3, .L800A35AC     SLD 2327     -> the EPILOGUE
```
The two targets **DIFFER** (loop-continue vs return), so it is *not* an `&&` on the
`collision_type` test — retail has a second, nested `if (<x>) return;` as the first
statement of the block. SYM corroborates: two `Block start`s at that very VA
(rel 162 and 167 off base 2161).

* **It is NOT `newHeight`** — SYM classes it `AUTO -48 sp+128` (memory; our recon takes
  its address for `BWorldSm_FindEdgeOff`, and so did retail), so a test on it emits
  `lw`+`nop`+`bnez`: measured **74 @472**. The tested lvalue is SYM-invisible.
* **The shape IS reachable and IS the whole count gap** — a laundered zero
  (`int p = 0; __asm__("" : "=r"(p) : "0"(p)); if (p != 0) return;`) emits exactly
  `addu $tN,$zero,$zero` + `bnez` and gates **COUNT-EXACT 470/470** (72 diffs; LCS is
  non-monotone, 09K). **NOT LANDED** — scaffolding nobody would write.
* After it the residual is the pure `$s3`↔`$s6` + `$t3/$t4/$t5/$t1` seat rotation.

Naming the real lvalue is the one open question; the full derivation is in-source.

## 5 — `Newton_DoPostBarrierCollisionHandling` 73 — two NEW falsified families

The head's dominant residual is the signed `/0x100` shape. Retail emits the
**non-mutating** `expand_sdiv_pow2` (`addu $v0,$a3,$zero` in the `bgez` slot, then
`addiu $v0,$a3,255`, `sra $v0,$v0,8`); ours mutates the parm pseudo in place
(`addiu $a3,$a3,255`) and reorg then steals the positive path's `sra` into the slot.
⇒ the discriminator is whether the DIVIDEND pseudo is live after the divide — the
mirror of W62's quotient-back-to-dividend row.

**(a) QUOTIENT-NAMING IS CODEGEN-NEUTRAL HERE** (new negative): naming the quotient
`int qz = normal.z / 0x100;` at `barrierVec.x` = **73**, at `barrierVec.z` = **73**, both
= **73** — gcc folds the named quotient straight back. Making the quotients SHARED across
the barrierVec stores and the dot product CSEs away real work: **97@93** (volatile
dropped) and **92@102** (volatile kept) — 13 and 4 insns SHORT.

**(b) A2's FOREIGN-OPERAND FENCE — validated zero-insn, INERT on this residual**
(coordinator's mid-wave broadcast, applied as asked). `__asm__("" : : "r"(newtonObj))`
with a register-resident operand:

| placement | diffs | ours insns |
|---|---|---|
| control | 73 | 105 |
| ×1 before `barrierVec.x` | 73 | **105** |
| ×1 after `barrierVec.z` | 73 | **105** |
| ×2 | 73 | **105** |
| ×3 | 73 | **105** |
| ×1 with operand `&islandMatrix` (stack address) | 82 | **106** |

🟢 **Independent cross-TU confirmation of A2's cost claim**: the device is genuinely
**0 bytes at 1, 2 AND 3 fences** in the C++ lane on a by-value-parm function — I did not
even pay the one-time barrier insn A2 saw. 🔴 And the exact boundary A2 states is
reproduced: a **non-register-resident operand costs a real insn** (`&islandMatrix` → 106).

🏆 **MECHANISED against A16's correction (real CC1PLPSX `-dl`, `scratchpad/w63a11/nt.i.lreg`).**
A16: the fence is a **PRIORITY-ONLY** dial (live-length only feeds `QTY_CMP_PRI` serving
order, not the `find_free_reg` window) — "check the `-dl` serving order before spending
it". Doing so gives the exact reason the device was inert here, and a **cheaper
pre-check than reading the serving order**:

```
DoPostBarrier block-local qtys per block:  {0:1, 2:3, 8:1, 12:2, 16:2, 20:1, 22:10}
```

The `/0x100` sdiv head lives in **blocks 0 and 2 — 1 and 3 qtys**. Per the 14C
**3-QTY LADDER LAW** (`local-alloc.c:1588`/`1638-52`) a block with `next_qty <= 3`
**skips the qsort entirely** and is served by RAW QTY NUMBER, so there is **no priority
order to dial**. The foreign-operand fence is therefore *structurally* inert in blocks
0/2, not merely empirically inert — and it would have been predictable for free before
spending six probes. (Block 22, with 10 qtys, IS on the sorted path and would be a live
target for the device — but DoPostBarrier's residual is not there.)

Independently, the residual is anyway not a live-length question: it is **whether gcc
emits the sdiv dividend copy at all** (dividend liveness past the divide), so both the
priority axis and the live axis are the wrong instruments for this fn.

## 6 — `Physics_Real` 6 (count-exact) and `Camera_UpdateSplineCam` 55 — re-priced, held

**Physics_Real.** Residual is one statement (SLD 2341). Retail:
`lw $6,52($sp); lw $4,100($sp); lw $3,leftMult; lw $5,rightMult; addu $4,$6,$4` — ours puts
`lw $3,leftMult` FIRST and seats the stack value in `$2`. Two independent halves (load
ORDER + the `$6`-vs-`$2` seat). **The ORDER half is source-reachable**: the
split-`accSum`-decl + inlined-wheelMult form (`P7`) produces retail's exact order in the
cc1 `.s` — but rotates the seats and scores **10**. Everything measured: split decls
accSum-assigned-first **10**, accSum-declared-first **10**, wheelMult decl split only
**6**, no local **10**, accSum local + wheelMult inline **10**, P7 **10**. Control 6.
⇒ statement axis re-confirmed exhausted (W62's finding stands on this basin); the seat is
an allocator question and the W62 `PER_FN_TEXT_MOVES` order-half candidate would reach
6→4 at best.

**SplineCam.** W62's certificate re-checked against A2's device and **still holds**:
`numSlice` is global allocno p98 (refs 9, live 29, pri 0.9310, rank 3) taking `$v1` as the
2nd free register of find_reg's ascending scan; retail's `$s2` is the **9th** free
register. `reqdelta --want p98=s2` finds no 1- or 2-dial solution within ±40 on refs×live.
A2's fence is a **linear +1-live razor (1–5 units)** by its own bounding law, so it cannot
close a 9-rank gap either. Held as a **quantified hardness certificate**, not a floor: the
named remaining axis is still `calls` (a SOURCE use of `numSlice` after the calls).

---

## Catalog-row candidates

1. 🏆 **A LABEL IS A MOVABLE LINE — `PER_FN_TEXT_MOVES` ALREADY DOES LABEL RELOCATION
   (§G/mechanism).** Express it from the other side: move the INSTRUCTION across the
   label (`take` the insn with a `(?=\$L\d+:\n<next>)` lookahead, `after` the same
   `\$L\d+:\n`). Retires the "TEXT_MOVES cannot change a branch TARGET" blocker for the
   whole reorg TARGET-STEAL class — a steal that redirected a branch past the stolen insn
   is undone by putting the label back in front of it, with no branch edit at all.
   In-tree precedent that nobody had named: `InGame_ResetPSXController__Fii`.
   HeliCam 12→10 on the label move alone; 12→PASS with the family.
2. 🏆 **UN-WRAP `.set noreorder` TO DELETE A STOLEN DELAY-SLOT COPY (§G).** `drop_after`
   takes a MULTI-LINE regex, so one move can lift the branch out of its
   `.set noreorder/nomacro … macro/reorder` block and delete the block — the branch then
   sits in reorder mode and **maspsx supplies the `nop` itself**. This is how you reach an
   oracle's EMPTY slot without inventing a `nop` line to move. (2 of HeliCam's 4 rows.)
3. 🔴 **TEXT_MOVES ANCHOR HAZARD, `after`-side (extends 12F).** `re.search` binds the
   FIRST match in the whole fn region — a bare `beq $20,$2,$L\d+` anchor grabbed an
   unrelated branch 300 lines earlier; the move applied, the `drop_after` silently did
   not, and the plateau read as a real result. **Lookahead-pin `after` anchors too**, not
   just `take`.
4. 🏆 **THE FUNNEL NEEDS if/else ARMS — a ternary funnel is a DIFFERENT (weaker) lever
   (§A/§C, sharpens 09C and the w62 "funnel is non-additive" row).** Retail's shared-store
   clamp needs BOTH the result variable and explicit `if/else` arms: funnel+ternary
   **53@351** vs funnel+if/else **21@347** on the same site. A `COND_EXPR` whose target is
   a MEM stores in both arms, so the ternary form can never produce a shared store — a
   "funnel measured neutral/negative" receipt is worth re-pricing with if/else arms.
5. **CLAMP-IN-PLACE IS THE WRONG DIRECTION WHERE RETAIL DUPLICATES THE `abs` (§C, bounds
   09A).** 5 clamp-in-place spellings all landed 341–345 insns against an oracle of 346:
   the override form collapses a duplicated `__builtin_abs` that retail keeps. Check the
   oracle's abs COUNT before running the 09A clamp pass.
6. **THE UN-MERGE FENCE HAS TWO JOBS THAT CAN CONFLICT — MOVE IT TO THE OTHER ARM
   (§B/§F).** An asm at an arm's tail un-merges cross_jump'd twin arms, but if that tail
   is also the arm's EXIT LABEL it blocks `thread_jumps` from threading
   `bcond → $Lexit → j $Lmerge`. Fencing the SIBLING arm's tail buys the un-merge and
   frees the thread. HeliCam 12→9 alone, →PASS with its moves.
7. 🏆 **THE 3-QTY PRE-CHECK FOR A16's PRIORITY-ONLY LAW (§A, composes A16 + 14C).**
   A16 says the foreign-operand fence is a priority-only dial — "check the `-dl` serving
   order before spending it". There is a **strictly cheaper first gate**: count the
   TARGET BLOCK's block-local qtys in `-dl`. A block with `next_qty <= 3` skips the qsort
   (`local-alloc.c:1588`/`1638-52`, the 14C ladder law) and is served by RAW QTY NUMBER —
   so **no priority dial of any kind can fire there**, serving order or not. Receipt:
   DoPostBarrier's sdiv head is in blocks of 1 and 3 qtys; 6 fence probes measured
   dead-flat 73 @105. One `-dl` line predicts that for free.
   Also banked: cross-TU confirmation that the device is **0 bytes at 1/2/3 fences** in
   the C++ lane on a by-value-parm fn (no one-time barrier cost paid), and A2's stated
   boundary reproduced (`&stackObj` operand → +1 insn, 82 @106).
8. **BRANCH-CENSUS FOLLOW-THROUGH (extends W62 row 4).** `brdist.py` found the missing
   conditional; the SLD + the oracle's raw **branch TARGETS** then decoded it. The two
   targets differing (loop-head vs epilogue) is what proved it a nested `if`, not an `&&`
   — read targets from the oracle `.s`, never from `verify_asm` (it normalises them).

## Orchestrator actions requested

* **WIRE `scratchpad/w63a11/tm_helicam_spec.json`** — 4 `PER_FN_TEXT_MOVES` rows for
  `recon/game/common/camera.cpp` / `Camera_UpdateHeliCam__Fii`. With the landed source
  they give **PASS 443/443** (probed 2× via `tools/vprobe.py`); without them the fn is 9.
  All anchors are label-agnostic. ⚠️ Per 14A these are gate-lane shims: HeliCam then joins
  the **shim-masked** class, so its production-lane status is separate from the seal.
* `Physics_Real` residual 6 stays a `PER_FN_TEXT_MOVES` candidate (move `lw $3,leftMult`
  down past the two stack loads) — worth **6→4**, leaves the `$6`-vs-`$2` seat.
* Board rows STALE at wave start: `Physics_CalculateCarAcceleration__FP8Car_tObj`
  (99.98 → already PASS) and `Physics_Real__FP8Car_tObj` (99.97 → already 6, count-exact).
* `brdist.py` / `sbs.py` promotion to `tools/` still pending from W62 (used again here).
* The `[auto-checkpoint reminder]` hook fired repeatedly; as a subagent I did not write
  the memory dir.

## Files touched / backups

* `recon/game/common/camera.cpp`, `physics.cpp`, `newton.cpp` (3 commits, receipts
  in-source).
* `scratchpad/w63a11/` — `{camera,physics,newton}.base.bak` (wave start),
  `camera.helicam9.bak`, `physics.tire21.bak`, `newton.tfus70.bak`,
  `tm_helicam_probe{1,2,3}.json` + `tm_helicam_spec.json`, all variant JSONs
  (`hv*`, `pr1`, `tf*`, `tw*`, `dp*`), `helicam_sbs.txt`, `tfus_sbs.txt`,
  `tire_sbs.txt`, `real_sbs.txt`, `dpb_sbs.txt`, harnesses
  (`variant.py`, `variantv.py`, `sbs.py`, `brdist.py`, `dump.py`, `dbg1.py`).

## Process notes / hazards

* `tools/vprobe.py`'s `W60_TEXT_MOVES_FILE` hook made the whole opener possible with
  **zero `build.py` edits** — this is the correct probe route for any TEXT_MOVES spec.
* 🔴 **A stale `build/**.s` faked a "regex MISS"**: the on-disk `.s` is whatever the LAST
  compile produced (a restored variant sweep leaves the LAST VARIANT's `.s`). Re-run the
  control gate before reading `build/…/x.cpp.s` to derive an anchor. Cost one wrong
  diagnosis.
* All escape-bearing content went through the Write/Edit tools (no heredocs); every
  variant file is JSON built with Write, and `variant.py` asserts a unique anchor match
  and restores in a `finally`.
* No git stash/checkout, nothing outside my three TUs and my scratchpad.
