# W66-A1 — THE BRANCH-RETARGET ENDGAME

Repo `C:\Temp\nfs4-decomp`, base `c7904577`. **`tools/build.py` was never opened
for write**: the mechanism is delivered as `branch_retarget.patch`, developed and
measured through an in-memory patch of build.py's own source
(`mech.py::patched_source()` → `br.py` / `pq.py`), so *what I measured* and *what
the orchestrator applies* are the same bytes by construction (12H anti-drift).

---

## 0. HEADLINE

| item | before | after |
|---|---|---|
| open **class-d** rows (w65-a4 §4.1) | 6 | **0** |
| `Sim_MainGameLoop__Fv` gate | FAIL 6 (ours 319 / oracle 321) | **PASS 321/321** |
| `Sim_MainGameLoop__Fv` production (`psyqproof`) | REAL=50 RELOP=15 | **REAL=0 RELOP=0** (DUAL-LANE SEAL) |
| `calltarget_audit` tree-wide | 2 | **0** |
| `MCRD_handlecardevents` (the one open w65-a1 row, 9 falsifications) | brdist (13,148,94) | **0**, one row, no source change |
| `FntPrint` — w65-a2's "needs a 3-line maspsx option" | asserted unreachable | **REFUTED**, closed by the mechanism |
| gate PASS→FAIL anywhere | — | **0** (7 TUs, 2× each) |
| production REAL, all 6 applicable fns | 52 | **0** (2× each) |
| board rows this converts to 100.00 | — | 6 class-d + 1 class-a → 100 |

**Zero source files changed.** Everything lands as one build.py patch + 8 table rows.

---

## 1. THE MECHANISM

`PER_FN_BRANCH_RETARGET = {rel: {fn: [{"branch": rx, "after": rx}, ...]}}`

Plants a **fresh label** (`$L966NNN`, collision-checked) immediately after the
line `after` matches, and rewrites the single `$L<n>` operand of the line
`branch` matches to it. **It removes nothing** — the word stream is untouched
apart from that one branch's own 16-bit offset. That is the whole point:
`drop_after`, the only previous way to move a branch's *effective* target, works
by deleting an instruction, and doing so without re-pointing the branch is
exactly the live correctness defect w65-a2 found in `Camera_UpdateHeliCam`
(w63-a11 deleted the stolen `slt` out of a delay slot; the `bgez` still aimed at
the label reorg had planted *past* it, so the `|z| < |x|` test never ran).

Discipline baked in (the w62/w64 anchor law): both regexes must match **exactly
once** inside the `.ent`/`.end` region, the two matches must not overlap, the
branch line must contain exactly one `$L` operand, and the minted label must not
already occur in the file. Any violation **skips the row loudly on stderr** —
never a partial application, never a silent no-op. *This fired for real*: my
first `_dirSendAuto` anchor keyed on the `.def reenter_cfgmode` COFF debug line,
which psq43 CC1PSX does **not** emit, so the row was skipped on the production
lane and `psyqproof` stayed REAL=1 while the gate lane read 0. **New anchor law:
write anchors against text BOTH lanes produce.** Fixed anchor is `.def`-free and
both lanes now read 0.

Runs **after** `_apply_text_moves` in all three lanes (2.8 C++, 2.8 C, 272), so
anchors are written against the post-move text — which is what makes the sim
flagship expressible at all.

**Files:** `branch_retarget.patch` (git apply --check CLEAN; round-trip verified
**byte-identical** to `patched_source()`, CRLF preserved: 2426 CRLF / 161 bare
LF, and the patched module `ast.parse`s) · `WIRING_fragment.py` (paste-ready,
machine-rendered from the JSON and asserted equal to it — no re-typed regex) ·
`SPEC_w66a1_ALL.json` (the FINAL row list, per-row `_note` = full rationale).

**CONTROL LEG:** `br.py` with an EMPTY table reproduced all seven TU baselines
exactly (`ACCEPT_base.txt`), i.e. the patch is provably inert until rows exist.

---

## 2. THE ROWS — 8 rows, 7 functions

| # | fn | TU | before | after | class |
|---|---|---|---|---|---|
| 1 | `_dirSendAuto` | libpad/PADSEQD | brdist (1,32,33) · word `1040001f` | **0** · `10400020` == retail | two labels 1 word apart |
| 2 | `MemCardWriteData_cb` | libmcrd/LIBMCRD | (6,53,52) | **0** | inverse: OUR cc1 threaded |
| 3 | `DrawBackground__11tScreenMain` | frontend/common | (9,11,12) · prod REAL=1 | **0** · **REAL=0** | two labels 1 word apart |
| 4 | `Hud_BuildString__FPciiiib` | game/psx/hud | (2,154,155) | **0** | two labels; `$L764` has 4 users |
| 5 | `MCRD_handlecardevents` | frontend/psx | (13,148,94) · prod REAL=1 | **0** · **REAL=0** | cross-jump partner choice |
| 6 | `FntPrint` | libgpu/FONT | (10,8,9) | **0** | maspsx label-hoist |
| 7 | `Sim_MainGameLoop__Fv` | game/common/sim | gate FAIL 6 · prod REAL=50 · calltarget 2 | **PASS 321/321** · **REAL=0** · **0** | block placement (4 moves + 1 retarget) |

Rows 1/3/4 are the pure **two-label** class w65-a2 §4.2 specified this mechanism
for: retail carries two labels one word apart and sends different branches to
each, while cc1 emitted ONE label they share. A label MOVE repairs one user and
breaks the others (each of those others matches retail *today*) — only a second
label plus a single re-point can express it.

### 2.1 The flagship — `Sim_MainGameLoop__Fv`

Retail lays the three arms **[B][C][A]**, cc1 lays them **[B][A][C]**:

```
retail                                     ours (before)
  bne  speed,3,C                             bne  speed,3,C
  jal  Sim_ProcessSimSchedules   (B)         jal  Sim_ProcessSimSchedules  (B)
  j    A                                   A: jal  Sim_ProcessSimSchedules      <- B falls THROUGH
C: sw   InBetween ; jal Camera_Update        j    join
  j    join                               C: sw   InBetween ; jal Camera_Update
A: jal  Sim_ProcessSimSchedules            join:
join:
```

B falls straight into A, so the `j`+`nop` pair never exists → ours is exactly 2
instructions short, and every one of the 8 branches around the region carries a
different offset. Six source forms were falsified across W61/W62 (goto-shared-
tail 38@317, both-calls-in-B 32@319, negated guard 32@319, inner if/else
inverted 8@319, explicit goto out of C 6@319, 12C exit-block device 38@317) —
every goto form lets `jump.c`'s jump-around-jump inversion fire and gcc folds B's
own call away. **The unexplored axis was the LAYOUT pass, and this is the
mechanism that reaches it**: 4 `PER_FN_TEXT_MOVES` rows re-lay the blocks
(copy C's `j` to the end of B; move the original `j` past C; move A's label; move
A's `jal`) and **1 `PER_FN_BRANCH_RETARGET` row** aims B's new `j` at A.

🔴 **CONTROL PROOF that the retarget row is load-bearing, not cosmetic.**
With the 4 moves ALONE the gate reads **PASS 321/321** — and the object is
**semantically wrong**: brdist (44,9,7), the copied `j` lands at index 266
instead of retail's 264, i.e. the `speed == 3` arm calls
`Sim_ProcessSimSchedules` **once instead of twice**. That is the HeliCam class
reproduced exactly: a gate-PASSing object carrying a live defect, because
`verify_asm` normalises every branch target to `T` (04Q). The retarget row is
what makes the block move *correct*, and `brdist`/`wp.py` are the only witnesses.

### 2.2 `MCRD_handlecardevents` — the open w65-a1 row, closed in one row

Two byte-identical `return status` tails exist in **both** objects: the FUNNEL
(`move $2,$16` then fall into the epilogue) and the 2-insn TRAMPOLINE
(`j <epilogue>; move $2,$16` — our `$L152` block at index 150). Retail's
`bne pCI->status,-1` joins the trampoline, ours the funnel. w65-a1 measured 9
spellings (5 regressed by 12–140 diffs, 4 inert) and classified the whole
cross-jump-partner class **source-unreachable**; a label move cannot express it
either, because `$L152` already has a user that matches. This mechanism is
literally the *"rewrite a branch OPERAND rather than move a label"* extension
that receipt asked for. One row, no source change, TU 20/20 PASS 2×,
production REAL 1 → 0.

### 2.3 `FntPrint` — a REFUTED "maspsx law"

w65-a2 §4.1 filed this as needing a 3-line maspsx change. **Wrong.** maspsx's
`_handle_nop_before_next_instruction` hoists **exactly ONE** label line above the
load-delay nop it inserts (`skip_instructions = 1`), so our `$L115` lands ON the
nop (88) while retail's `.L800F7198` is on the `addiu` (89). Planting a **second**
label behind `$L115` puts it **after** the nop — the single hoist has already
been consumed — and the retarget reaches retail's target with **no maspsx change
and no `--nop-before-label`** (that opt-in flag exists in the vendored maspsx and
is *not* needed). Verified in the shipped object: the `j` at `0x45c` targets
`0x480` = `addiu v0,a0,-48`. FntPrint PASS 240/240, psyqproof REAL=0 2×.

---

## 3. GATES (every number measured by me, twice)

`ACCEPT_base.txt` (patched build.py, EMPTY table = control) vs
`ACCEPT_spec.txt` (FINAL row list). Both files contain two full passes.

| TU | tugate before | tugate after (2×) | brdist after (2×) |
|---|---|---|---|
| libpad/PADSEQD.c | 4/5 | 4/5 | **0** |
| libmcrd/LIBMCRD.c | 23/26 | 23/26 | 3 (all class-a FAIL fns) |
| frontend/common/screenmain.cpp | 13/13 | 13/13 | **0** |
| game/psx/hud.cpp | 55/62 | 55/62 | 6 (all class-a FAIL fns) |
| frontend/psx/memcard.c | 20/20 | 20/20 | **0** |
| syslib/psx/libgpu/FONT.c | 1/2 | 1/2 | **0** |
| game/common/sim.cpp | **7/8** | **8/8** | **0** |

**ZERO PASS→FAIL; +1 PASS.** The residual brdist rows in LIBMCRD/hud belong to
functions whose gate already FAILs (class a, pre-existing, out of scope).

`tools/tu_order_audit.py`: **508 objects, 0 inversions.**

**15D objdump word proof** (`wp.py`, `WORDPROOF*.txt`) — our encoded 32-bit word
next to retail's, decoded from the oracle `.s` comment column, for **every**
branch of each function; `j`/`jal` are absolute (`R_MIPS_26`, pre-link) so they
are compared by resolved target index:

| fn | baseline | with the rows |
|---|---|---|
| `_dirSendAuto` | 1 DIFF (`1040001f` vs `10400020`) | **0** |
| `MemCardWriteData_cb` | 1 DIFF (target 74 vs 73) | **0** |
| `DrawBackground__11tScreenMain` | 1 DIFF (`1462000a` vs `1462000b`) | **0** |
| `Hud_BuildString` | 1 DIFF (target 194 vs 195) | **0** |
| `MCRD_handlecardevents` | 1 DIFF (`14620093` vs `1462005d`) | **0** |
| `FntPrint` | 1 DIFF (target 88 vs 89) | **0** |
| `Sim_MainGameLoop__Fv` | **17 DIFF** | **0** |

**Production lane** (`pq.py` = `tools/psyqproof.py` with a BRANCH_RETARGET hook),
2× each, cache-warm:

`DrawBackground__11tScreenMain` REAL 1→**0** · `MCRD_handlecardevents` 1→**0** ·
`Hud_BuildString` 0→**0** (its divergent branch is a `j`, reloc-masked, so the
prover never saw it — the gate lane is the only witness there) ·
`Sim_MainGameLoop__Fv` **50→0** · `_dirSendAuto` 1→**0** · `FntPrint` 0→**0** ·
`MemCardWriteData_cb` INAPPLICABLE-LANE (LIBMCRD.c is `cc1_272`).

`calltarget_audit.py`: tree-wide baseline **2** sites, both
`Sim_MainGameLoop__Fv`, both **gone** with the rows (re-measured on the shipped
object; the clean-source object reproduces the 2).

---

## 4. FALSIFICATIONS / CORRECTIONS (basin: HEAD `c7904577`)

1. **`.def`-line anchors are lane-divergent** — the `.def reenter_cfgmode` anchor
   worked on the gate lane and matched **zero** times under psq43 CC1PSX.
   Caught by the mechanism's own count guard, not by a number looking wrong.
2. **w65-a2 §4.1 "FntPrint is a maspsx LAW"** — refuted (§2.3).
3. **w65-a4 §5's reading of the sim rows as "a real per-frame ORDERING
   divergence (camera update vs sim scheduling)"** — that is an over-statement.
   w65-a3 §2 had it right: the two arms are semantically identical and the
   defect is basic-block PLACEMENT. Nothing ran in the wrong order at runtime;
   what was wrong is that our word *N* held `jal PSS` where retail's held
   `jal Camera_Update`. (The real *behavioural* risk in this area was the
   moves-only intermediate — §2.1 — which never shipped.)
4. **`-fno-thread-jumps` is not the dial for `MemCardWriteData_cb`** (w65-a2
   measured it regressing to gate FAIL 3 and brdist 1→4) — re-confirmed by
   *not* needing any flag: the mechanism is a 1-row fix.
5. **A gate PASS does not certify a block reorder.** Any `PER_FN_TEXT_MOVES`
   landing that moves a label, copies a jump, or empties a delay slot must be
   paired with `brdist` **and** a word/target proof. Third independent instance
   of this rule (HeliCam, the moves-only sim control, and w65-a2's standing
   lesson).

---

## 5. FOR THE ORCHESTRATOR

1. **Land `branch_retarget.patch`** (mechanism + empty table + 3 lane call
   sites). `git apply --check` clean at `c7904577`; inert until rows exist.
2. **Wire the 8 rows** from `WIRING_fragment.py` — `PER_FN_BRANCH_RETARGET`
   verbatim, and MERGE the sim `PER_FN_TEXT_MOVES` entry into the existing dict
   (sim.cpp has no prior key today; **a duplicate dict key is silently shadowed**
   — the w47/w48/w60 hazard, grep the table span first).
   The 4 sim moves and the sim retarget row **must land together**: the moves
   alone ship a semantically wrong object (§2.1).
3. **Named tooling gap — `tools/psyqproof.py` has no BRANCH_RETARGET hook.**
   It carries `W64_PQ_TEXT_MOVES_FILE` but nothing for the new table, so two
   production REAL=1 rows were unprovable there until I patched it in-memory
   (`pq.py`, 6 lines: substitute `build_module()` and add
   `bp._apply_branch_retarget(rel_posix, s_file)` beside the existing
   `bp._apply_text_moves(...)`). Worth landing so the wave-close production
   sweep sees the rows.
4. **`tools/wp.py` promotion candidate** — the per-branch word/target proof
   (`scratchpad/w66a1/wp.py`). `brdist` reports *distances*; this reports the
   encoded WORD next to retail's own bytes and states explicitly which sites are
   `R_MIPS_26` and therefore target-index-only. It is the instrument the class-d
   belt should have had from the start.
5. **Catalog candidates** (memory dir is read-only to me) — §6.

---

## 6. CATALOG CANDIDATES

- **§F/§D — THE TWO-LABEL CLASS AND ITS MECHANISM.** Symptom: gate PASS, board
  < 100, `brdist` ±1 on ONE branch, and the shared `$L<n>` has other users that
  already match. Cause: retail carries two labels one word apart (usually
  reorg's steal-from-target + `emit_label_before` redirect) where cc1 emitted
  one. Fix: `PER_FN_BRANCH_RETARGET` — plant a second label, re-point the one
  branch. A label MOVE is the wrong instrument whenever the label has ≥2 users.
- **maspsx label-hoist law**: `_handle_nop_before_next_instruction` relocates
  **exactly one** label line above the nop it inserts (`skip_instructions = 1`),
  so a SECOND label planted behind it lands *after* the nop. This is what makes
  the whole "our label is on maspsx's inserted nop" class source-reachable
  without touching maspsx (retires w65-a2 §4.1's named maspsx option).
- **BLOCK PLACEMENT IS TEXT-REACHABLE.** A [B][A][C]-vs-[B][C][A] layout
  residual (2 insns short, every surrounding branch offset wrong, every source
  form falsified) decomposes into 4 line moves + 1 retarget. Recipe: copy the
  arm-terminating `j` to the end of the fall-through arm, move the original `j`
  down past the middle arm, move the shared block's LABEL, then its body, then
  retarget the copied `j`. Gate + brdist + word-proof each step.
- **THE MOVES-ONLY TRAP (3rd firing).** `verify_asm` normalises branch targets,
  so a block reorder can gate PASS while calling a function once instead of
  twice. Pair every move/label/delay-slot row with `brdist` + a word proof.
- **ANCHOR LAW EXTENSION**: anchors must match text BOTH the gate lane and the
  production lane emit — `.def`/`.val` COFF debug lines exist on one lane only.
- **Cross-jump PARTNER CHOICE is source-unreachable but MECHANISM-reachable.**
  w65-a1's 18 falsifications across two functions stand; the resolution is not a
  spelling, it is a branch-operand rewrite.

---

## 7. FILES (all under `scratchpad/w66a1/`)

`branch_retarget.patch` — the deliverable · `mech.py` — the mechanism as a text
transform of build.py + `patched_source()` · `mkpatch.py` — renders the patch
from `mech.py` (ast-parses it first) · `mkwiring.py` / `WIRING_fragment.py` —
paste-ready rows, asserted equal to the JSON · `SPEC_w66a1_ALL.json` — the FINAL
row list · `br.py` — the probe lane (`gate|tu|brd|dump`, `$W66_SPEC`) ·
`pq.py` — psyqproof with the retarget hook · `wp.py` — the 15D word/target proof
· `accept.sh` + `ACCEPT_base.txt` / `ACCEPT_spec.txt` — the 2× acceptance runs ·
`WORDPROOF.txt` / `WORDPROOF_base.txt` · `sp_*.json` — the per-row probe specs
kept as evidence · `pq_sim_moves.json` — the production-lane moves file ·
`_mcwd.txt` / `_dbsm.txt` / `_hbs.txt` / `_mh.txt` / `_fp.txt` — `.s` dumps.

**Hazards fired:** the bash-heredoc backslash collapse (a `<<'EOF'`-written JSON
came out with `\t` instead of `\\t` — Write tool only, as the standing rule
says), and a non-raw Python string in a scripted JSON edit doing the same thing
one step later. Both caught by a `json.load` + a re-probe, never by a number.
