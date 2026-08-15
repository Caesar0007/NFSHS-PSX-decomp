# W64-A11 receipts — camera / physics / newton belt

Gate = `tools/verify_asm.py`; every number below re-gated by me, **baseline first**.
All three TUs gated 2x, **zero PASS→FAIL**. `tu_order_audit.py` = 0 inversions.
No `tools/` file, no `build.py`, no memory-dir write, no git stash/checkout.

## Belt scoreboard

| fn | re-gated baseline | final | delta |
|---|---|---|---|
| `Camera_UpdateSplineCam__Fi` | 55 (350/351) | **13** (348/351) | **−42** |
| `Camera_UpdateHeliCam__Fii` | PASS (443) | PASS | w63's TEXT_MOVES rows are wired and holding |
| `Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct` | 21 (347/346) | **PASS 346/346** | **SEALED — DUAL-LANE (psyqproof REAL=0 RELOP=0)** |
| `Physics_Real__FP8Car_tObj` | 6 (1272/1272) | 6 | **TEXT_MOVES spec derived + probed 2x = 4** |
| `Physics_CalculateCarAcceleration__FP8Car_tObj` | **PASS** (710) | PASS | briefed row 99.98 confirmed stale (2nd wave running) |
| `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` | 73 (105/106) | **71** | −2, residual fully mapped |
| `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj` | 70 (468/470) | 70 | 48th-branch angle SHARPENED (4-way falsification) |

TU totals: **camera 37/38** · **physics 21/22** (was 20/22) · newton 30/32.
Net **−48 diffs + 1 seal**.

---

## 1 — `Camera_UpdateSplineCam` 55 → 13 (commits `4719d6b5`, `27ecf670`)

W62 closed this as a *quantified hardness certificate*: "numSlice is global allocno
p98 (refs 9, live 29, calls 0, pri 0.9310, rank 3), takes `$v1` as the 2nd free
register of find_reg's ascending scan; retail's `$s2` is the 9th free register;
`reqdelta --want p98=s2` finds no 1- or 2-dial solution. The named remaining axis
is `calls`." **The certificate was correct and the axis was correct — but the cure
was not a dial: our recon had two SYM variables' ROLES SWAPPED.**

Read straight off the oracle + SYM:

* the SYM's **`direction` (`$16` = `$s0`) is the DOT PRODUCT** — the oracle
  accumulates the three `fixedmult` results in `$s0`
  (`addu s0,v0,zero` / `addu s1,v0,zero` / `addu s0,s0,s1` / `addu s0,s0,v0`)
  and tests it `bgez $s0`;
* the SYM's **`numSlice` (`$18` = `$s2`) is the CLAMPED STEP** — `negu $s2,$s2`
  twice, then `bltz $s2`, then `anchorSlice + $s2`.

Ours used `direction` for the step and an anonymous temp for the dot. As the step,
`numSlice` is live across all three `fixedmult` calls, so `calls_crossed` becomes 3
and it lands in a callee-saved register **for free** — the axis W62 named, reached
structurally rather than by a dial.

Three more role corrections from the same reading:

2. **`gNumSlices / 2` is an ANONYMOUS temp** (`sra $a0,$v0,1`, caller-saved), not
   `numSlice`. The Ghidra variable-merge cost an extra callee-saved register and
   8 frame bytes.
3. the abs-guard is a **COND_EXPR OF COMPARISONS** — `do_jump` distributes into
   both arms, each owning its `slt` + branch to the shared BIG/SMALL blocks — with
   the `/2` hoisted to a shared temp so it is evaluated once.
4. the slice read goes through the **global**, not the just-assigned cursor, and
   `slice + 1` is its **own short-lived local**; reusing `numSlice` there merged two
   disjoint live ranges into one callee-saved allocno *and* let fold reassociate
   `(slice+1)*32` into `slice*32 + 32`.
5. `sliceDist` (`$5` = `$a1`) is only ever assigned its **final** value — retail
   computes the raw difference into its own `$v1`.

**Basin ladder (each re-gated):** 55 → 117 (role swap alone, 352 insns) → 93
(+ anonymous half) → 87 (+ cond-expr guard) → 32 (+ global read / anonymous step)
→ 19 (+ named step temp) → **13**.
The intermediate 117 is the hard-floor-basin rule in action: the *authoritative*
count more than doubled at the step that made the function structurally right.

**Falsified (this basin, do not retry):** duplicated if/else for the abs-guard
157 @330 (cross-jump eats 21 insns) · the cond-expr guard with `gNumSlices/2`
spelled inside both arms 160 @361 (the divide is emitted twice) · reading the
first slice through the named cursor, and a second block-local pointer from the
same global, both neutral at 13 (copy-propagated).

**RESIDUAL 13 (3 short), two named clusters:**
* **(a)** retail materialises a SECOND base at `Camera_gInfo+0x48`
  (`rotation.m[6]`) and derives `&Camera_gInfo[player]` from it with
  `addiu $v1,$v1,-72`, loading the rotation row at `0/4/8($s1)`; ours keeps one
  base and uses `72/76/80` displacements. `int *rot = &..rotation.m[6]` reaches
  **count-exact 351/351** but gcc anchors the pseudo at `&rotation` (`+0x30`) and
  folds the `[6]` into a `+24` displacement, rotating the `a1/a2/v1` clamp band
  (52); a `coorddef*` view of the same address is identical (52); + an identity
  launder on the pointer 71 @352. **The lever wanted anchors the pseudo at
  `sym+0x48` without minting a pseudo that re-colors the clamp block.**
* **(b)** retail emits a cse copy `addu $v1,$a1,$zero` of the `BWorldSm_slices`
  cursor and loads the index AFTER the global; both re-spellings measured neutral.

---

## 2 — `Physics_CalculateTireForces` 21 → **PASS 346/346** (commit `4a873db7`)

Four clamp-shape corrections, all 09A/13D family. W63 landed the result-funnel and
the if/else arms; what remained was **which shape each individual clamp takes**.

1. **The `fixedmult` MIN wants the CONSTANT ARM LAST.** Written constant-arm-first,
   cse shares the single `0x20000` across the compare and the arm and pays a copy
   (`addu $v0,$a0,$zero`, 15 @348); moved to the `else` arm, both of retail's
   `lui`s come back (`lui $v0,2` for the compare, `lui $a0,2` in the `bnez` delay
   slot) and the function goes **count-exact**. The inner MAX is a
   default-then-override that **recomputes** `__builtin_abs(slipAngle)` — retail
   expands the abs twice, exactly as W63's clamp receipt said.
2. + 3. **Both `velCap.x < 0` arms are 09A default-then-override**: retail negates
   the abs straight into the funnel register (`negu $v1,$v0`) where the if/else
   spelling negates in place and pays `addu $v1,$v0,$zero`; and **site A's per-arm
   store — the w59-a2 "the ASYMMETRY is the lever" receipt — was the miss.**
   Hoisting it out of both arms is retail's `addu $v1,$a2,$zero` + shared `sw`.
4. **THE SEALING EDIT — default-then-override ONTO THE VALUE THE GUARD ALREADY
   LEFT LIVE.** Retail's tail is
   `.L800ABB20: bnez $v0,.L800ABB2C; nop; addu $v1,$a0,$zero; .L800ABB2C: sw $v1,0($s1)`
   and `$v1` already holds `velCap.z` from the `0 < velCap.z` guard, so the default
   costs **zero instructions** and only the override emits a move. Written:
   ```c
   int a = wheel->velCap.z;
   if (wheel->acc <= wheel->velCap.z) a = wheel->acc;
   wheel->acc = a;
   ```
   `acc <= velCap` is the only phrasing that yields retail's velCap-first
   `slt $v0,$v1,$a0` + `bnez` (gcc negates the `<=` into a velCap-first `slt` and
   inverts the branch).

**Measured on the sealing site (all worse):** original ternary
`(acc < velCap) ? acc : velCap` 6 @346 · `(velCap < acc) ? velCap : acc` **25 @349
— it reverses the GUARD's own load roles** (ours then reloads acc into `$v1` and
velCap into `$a0` where retail keeps acc in `$a0` from the `0 < acc` test) · the
same as a `<=` ternary 14 @348 · the arm-1-style explicit if/else funnel
`if (velCap < acc) a = velCap; else a = acc;` 20 @346 count-exact.
**The dial is which value the funnel DEFAULTS to, not the ternary's operand order.**

Ladder: 21 → 20 → 17 → 15 → 6 → **PASS**. `psyqproof` **REAL=0 RELOP=0** ⇒ DUAL-LANE.

---

## 3 — `Physics_Real` 6 → **4 via a probed `PER_FN_TEXT_MOVES` row**

Count-exact 1272/1272; one statement (SLD 2341). Retail:
`lw $6,52(sp); lw $4,100(sp); lw $3,leftMult; lw $5,rightMult; addu $4,$6,$4`.
Ours emits `lw $3,leftMult` FIRST and seats the stack sum in `$2` — two independent
halves, **load ORDER** and the **`$6`-vs-`$2` seat**.

**Spec** (`scratchpad/w64a11/tm_physicsreal_spec.json`), probed 2x through
`tools/vprobe.py W60_TEXT_MOVES_FILE` with the control re-gated at 6 → **4**:

```
take  "\tlw\t\$3,leftMult\n(?=\tlw\t\$2,52\(\$sp\)\n)"
after "\tlw\t\$4,100\(\$sp\)\n(?=\tlw\t\$5,rightMult\n)"
```
Both anchors verified **unique** in the fn region and **lookahead-pinned on both
sides** (15D); numeric registers only; no labels involved, so no `$L`-renumbering
exposure from a future TU reorder.

**Source-side alternative measured (rejected, but it CHARACTERISES the residual):**
inlining `leftMult - rightMult` into the `fixedmult` argument list (dropping the
`wheelMult` local) reproduces retail's LOAD ORDER **exactly** — all four loads and
both operand insns line up — but gates 10 because the pair rotates one register
DOWN (ours `52(sp)`→`$v1` / `leftMult`→`$v0` vs retail `$a2` / `$v1`). So the order
half **is** source-reachable; its price is the seat, and the seat is the same
2-pseudo rotation the TEXT_MOVES row leaves behind. A dial that pushes both
pseudos one slot UP find_free_reg's ascending scan closes the function.

---

## 4 — `Newton_DoPostBarrierCollisionHandling` 73 → 71

**Landed:** reorg was EAGER-STEALING the unary minus of the next statement into the
abs-guard's `bgez` delay slot, so ours emitted THREE `negu`s (`negu $v0,$a1` in the
slot + the in-place pair) where retail has an empty slot and two in-place ones. A
**void-tail fence AFTER the abs block** is the barrier. Position sweep: after the
abs **71** | before the `if (distRetreat < 0)` **73 (inert)** — the steal is from
the fall-through THREAD, so the fence must sit BETWEEN the two statements, not
ahead of the guard.

**The residual is now fully mapped** — retail's per-component parameter usage, read
straight off the oracle `.s`:

* `normal.x` (`$a1` in): **copied once** (`addu $a3,$a1,$zero`) BEFORE its divide,
  and that ONE copy also feeds `islandMatrix.m[0]` (`sw $a3,56($sp)`);
* `normal.y` (`$a2` in): parm reg for the divide, **re-read** from the spill slot
  (`lw $v0,120($sp)`) for `m[1]`;
* `normal.z` (`$a3` in): parm reg for the FIRST divide, then **re-read**
  (`lw $t2,124($sp)`) and copied (`addu $v1,$t2,$zero`) for BOTH the dot term AND
  `m[2]` — one re-read serving two uses.

Both source models were built and measured, **both worse**: the `nz2` volatile
re-read serving the dot AND `m[2]` **81 @105**; + `int nx = normal.x` serving
`barrierVec.z`, the dot x-term and `m[0]` **89 @101** (gcc coalesces the copy and
CSEs 4 insns of real work away — the same direction w59-a2's `int normalX` failed).
⇒ **named locals reproduce retail's DATAFLOW but not its codegen; every spelling
that makes the copy explicit gets it copy-propagated. The copy has to be bought by
the DESTINATION (14D split-the-divide-onto-the-same-variable), not by naming the
source.**

---

## 5 — `Newton_TestForUndrivableSurfaces` 70 — the 48th branch, sharpened

W63 localised it: `beqz $s6,.L800A3594` / `[ds] addu $t3,$zero,$zero` /
`bnez $t3,.L800A35AC` (SLD 2321 / 2327; the two targets differ, so it is a nested
`if (<x>) return;`, not an `&&`), and proved the shape reachable count-exact
(470/470) with a **laundered zero** — rejected as scaffolding.

**W64 result: the whole PLAIN-LOCAL family is falsified, which narrows the question
from "name the lvalue" to one PROPERTY.** Four natural spellings, each gated:

| variant | gate |
|---|---|
| V1 `int hit = 0;` as the first stmt of the block, `if (hit != 0) return;` after | 70 @468 |
| V2 same, decl and assignment split | 70 @468 |
| V3 fn-scope `int hit;` assigned 0 inside the block | 70 @468 |
| V4 fn-scope `int hit;` assigned 0 **BEFORE** the `collision_type` test (so the guard's own conditional branch separates def from use) | 70 @468 |

All four fold: cse records the constant and jump.c deletes the compare **even
across an intervening conditional branch** (my cse-basic-block hypothesis is
falsified). Combined with W63's `newHeight` measurement (a memory local costs
`lw`+`nop`, 74 @472 — and a global costs the same `lw`), the tested lvalue must be
**opaque to cse at the guard AND register-resident**. That is precisely the
identity launder's profile, which is why only the laundered zero reaches 470/470.
**The open question is now: what 1998 source produces a register-resident value
that gcc-2.8 cannot prove constant at that point?**

**Coordinator's mid-wave A3 fence-CFG law, checked as asked:** the 4-operand
read-only fence is **not** what suppresses the pair — removing it leaves the count
at **468** (and costs 10 diffs, 70 → 80), so this is not the
fence-at-a-branch-target-thread-head class. Fence-operand sweep re-priced on this
basin (04Z): n=3 **74** | n=4 **70** | n=5 **70** | n=6 **70** | n=7 **70** |
n=8 **90** — the 4..7 plateau holds and no operand count reaches the
`$s3`↔`$s6` seat.

---

## Catalog-row candidates

1. 🏆 **A "no-dial" allocator CERTIFICATE CAN BE A ROLE SWAP (§A / sharpens 13A's
   unreachability triage).** W62 proved with allocsim+reqdelta that no 1- or 2-dial
   solution moved `numSlice` from `$v1` to retail's `$s2` (the 9th free register in
   find_reg's ascending scan) and named `calls` as the only remaining axis. Both
   were right — and the cure was **variable identity, not a dial**: the SYM's two
   locals had their ROLES SWAPPED in the recon, and giving the step variable its
   real job put it across three calls and into a callee-saved home for free.
   **PROCEDURE: when a certificate says "the only axis left is `calls`", read the
   ORACLE for which SYM name actually holds the call-crossing value before pricing
   anything.** Camera_UpdateSplineCam 55 → 13.
2. 🏆 **DEFAULT-THEN-OVERRIDE ONTO THE VALUE THE GUARD ALREADY LEFT LIVE (§A/§C,
   sharpens 09A).** When a clamp is guarded by a test that already loaded one of
   the two operands, the funnel's DEFAULT must be that operand: `int a = velCap;
   if (acc <= velCap) a = acc; x = a;` costs zero instructions for the default and
   emits only the override move, reproducing retail's `bnez; nop; addu; sw` tail.
   Choosing the *other* default costs 2 insns AND can reverse the guard's own load
   roles (measured 6 → 25 @349). **The dial is which value the funnel defaults to,
   not the ternary's operand order.** Also: `acc <= velCap` is the phrasing that
   yields a velCap-first `slt` + `bnez`; the `<` and the reversed ternary do not.
   Physics_CalculateTireForces → PASS.
3. 🏆 **CONSTANT-ARM-LAST IS A cse-SHARING DIAL (§C, sharpens 13D).** In
   `if (X) r = K; else r = <expr>;` where the guard also compares against `K`, cse
   shares the one `K` across the compare and the arm and pays a reg-reg copy; with
   the constant arm written as the ELSE, gcc re-materialises `K` twice — retail's
   shape — and the function goes count-exact. (15 @348 → 6 @346.)
4. **THE FENCE MUST SIT BETWEEN THE TWO STATEMENTS, NOT AHEAD OF THE GUARD (§F,
   bounds 13B).** For a reorg EAGER steal out of the fall-through THREAD, a
   void-tail fence placed before the guard is structurally inert (it only walls the
   backward scan); placed after the stolen-from statement it blocks the steal.
   DoPostBarrier 73 → 71, with the before-position measured dead-flat at 73.
5. **A `do_jump` COND_EXPR OF COMPARISONS is the reachable form of a
   "distributed" abs-guard (§B/§C).** When the oracle gives each arm of a `>0`
   test its OWN `slt` + branch into shared blocks, the source is
   `(d > 0) ? (h < d) : (h < -d)` — NOT a duplicated if/else (cross-jump eats 21
   insns, 157 @330) and NOT `h < (d>0?d:-d)` (one merged compare). Hoist the
   shared subexpression or it is emitted in both arms (160 @361).
6. **PLAIN-LOCAL ZERO FLAGS CANNOT REPRODUCE A NEVER-TAKEN GUARD (§C, negative
   result with 4 receipts).** cse + jump.c fold `x = 0; … if (x) …` **even across
   an intervening conditional branch** — decl-with-init, split decl/assign,
   fn-scope, and def-before-the-outer-guard all measured identical. A retail guard
   on a provably-zero REGISTER value therefore implies a source construct opaque to
   cse at that point; a memory local or a global is NOT the answer either (each
   costs `lw`+`nop`). Newton_TestForUndrivableSurfaces.
7. **A TEXT_MOVES row can be DERIVED FROM, AND CROSS-CHECKED BY, a source
   experiment.** The inline-`leftMult - rightMult` spelling reproduced retail's
   load ORDER exactly while rotating the registers — which proves the TEXT_MOVES
   row is doing the same thing the source lever would, and isolates the seat as the
   independent second half. Cheap way to validate a splice's semantics before
   wiring it. Physics_Real 6 → 4.

## Orchestrator actions requested

* **WIRE `scratchpad/w64a11/tm_physicsreal_spec.json`** — one `PER_FN_TEXT_MOVES`
  row for `recon/game/common/physics.cpp` / `Physics_Real__FP8Car_tObj`; **6 → 4**,
  probed 2x with the control re-gated. Anchors unique + lookahead-pinned both
  sides, numeric registers, no label dependency. ⚠️ 14A: this joins the
  shim-masked class, so its production-lane status is separate.
* **Board rows to refresh:** `Physics_CalculateTireForces` (now PASS, DUAL-LANE),
  `Camera_UpdateSplineCam` (55 → 13), `Newton_DoPostBarrier` (73 → 71).
  `Physics_CalculateCarAcceleration__FP8Car_tObj` was **already PASS** at wave
  start for the second wave running — the 99.98 row is a gate-PASS-but-board-low
  row, not a near-miss.
* `brdist.py` / `sbs.py` are in `tools/` and were used throughout (no promotion
  pending from this belt).

## Files touched / backups

* `recon/game/common/{camera,physics,newton}.cpp` — 3 commits
  (`4719d6b5`, `27ecf670`, `4a873db7`, `53488a8d`), receipts in-source.
* `scratchpad/w64a11/` — `{camera,physics,newton}.base*.bak` (wave start),
  `camera.spline{93,19,13}.bak`, `physics.{base6,tire21,tire15,tire6}.bak`,
  `newton.{base73,dpb71}.bak`, `tm_physicsreal_spec.json`,
  `w64a11_fencesweep.py`, `w64a11_tfus_probe.py`, and the side-by-side dumps
  (`spline_sbs_v*.txt`, `tire_sbs.txt`, `real_sbs.txt`, `dpb_sbs.txt`,
  `tfus_diffsrc.txt`, `tire_diffsrc.txt`).

## Process notes / hazards

* Every scripted edit went through the Write tool or a byte-mode python script with
  an asserted match count; CRLF preserved (`git diff --stat` checked, 0 NULs, 0
  control bytes, 0 bare LF in newton.cpp after the receipt inserts).
* A python heredoc with `b"""..."""` containing a non-ASCII arrow raised
  `SyntaxError: bytes can only contain ASCII literal characters` — receipts with
  any non-ASCII must be built as `str` and `.encode('ascii')` after replacement, or
  written through the Write tool. (Caught before it could half-apply.)
* The `[auto-checkpoint reminder]` hook fired repeatedly; as a subagent I did not
  write the memory dir.
