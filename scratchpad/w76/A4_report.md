# W76-A4 — hud-misc belt (recon/game/psx/hud.cpp, unit game/psx/hud)

## Result

| function | baseline (W75 close) | final | verdict |
|---|---|---|---|
| `Hud_BuildCdPlayer__Fii` | FAIL 15 (476/475) | **FAIL 1** (476/475) | item (b) CLOSED clean; residual 1 = the 24D-8 label floor, receipted |
| `Hud_RenderTacView__Fv`  | FAIL 11 (72/71)   | FAIL 11 (72/71)   | **DOCUMENTED FLOOR** — mechanism complete, 17 new falsified cells |
| `Hud_Init__Fv`           | PASS 624 (board 99.99%) | PASS 624 | 24F-9 wordcmp run: **REAL=1**, coupled-device artifact, documented in-TU |

TU gate 59/62 both at baseline and at close, gated TWICE at each point (identical runs,
`a4_base_gate{1,2}.txt`, `a4_close_gate{1,2}.txt`).  **ZERO PASS→FAIL.**  CdPlayer's LCS
count on the board drops 15 → 1.  slotcheck on the final hud.cpp.o: `bad = 0` (my landing
*removes* one asm device, adds none).  No commits, no staging.  `tools/build.py`: a
temporary probe-TU flags row was added for the wave and **removed again at close**
(ast.parse clean, all foreign hunks preserved).  A concurrent session's edits to other
hud.cpp fns landed mid-wave and are intact (my edits were surgical; every gate above was
run against the shared working copy).

Probing obeyed the W75/W76 fleet rule throughout: private snapshot
(`scratchpad/w76/a4_base_hud.cpp`) → temp sibling TU `recon/game/psx/hud_a4probe.cpp`
(deleted in a `finally` after every compile; runner `scratchpad/w76/a4_probe.py`) → only
proven winners applied to the real file after a fresh read.  g_value=8 for the sibling was
injected via `W60_TU_FLAGS`/the temp row; the Hud_Init TEXT_MOVES rows were injected for
the sibling via `W60_TEXT_MOVES_FILE` (control probe: PASS 624 — harness fidelity proven
before the measurement cell).

---

## 1. Hud_BuildCdPlayer — 15 → 1 (one landing, a JOINT cell)

**Landing: per-arm width-lookup duplication + REMOVAL of the w75 'm'-operand fence.**
The w75 item-(b) named angle ("make the glyph index a BLOCK-LOCAL qty") executed not as a
branchless select but as **arm duplication**: each glyph arm computes the whole
`w = HudPmx_gShapes[title[i] + 0x6e/0x43].width + 1;` (volatile per-arm re-reads kept).
Glyph index and address chain are then both block-local *in one block each*, local_alloc
orders them together by birth (glyph $v0, chain $v1 = retail), and **post-RA cross_jump
re-merges the two identical chain suffixes** into retail's single
`sll v1,v0,2 / addu / sll / addu / lh v0,16(v1)` tail — the arms keep their differing
`lbu` + `addiu` (one in the `j` delay slot).  Zero new instructions, no device.

Measured grid (temp-sibling probes):
* duplication alone (fence kept in place): 23 @476 — the fence now re-ranks the shapes
  %hi pseudo (it has in-arm refs in this basin) and costs the `li t1,32` hoist plus a
  t1→t8→t2 rename cascade in the sprintf/divide tail;
* dup + fence at loop top: 23 · dup + fence after the bound test: 21;
* **dup + fence REMOVED: 1 @476** — the 23B-3 device-removal law firing again (third
  seal-adjacent instance: HrzSetPsxMatrix, TimeSprites, now here);
* block-scoped `int g` per arm instead of the inline subscript: identical 23 pre-fence-removal
  (the two spellings are the same cell).

**Residual 1 = exactly the w75 item (a):** `nop` in the `beqz s1` slot before the shared
`Hud_BuildString` call where retail carries `addu a0,s1,zero`.  **Documented floor** under
the 2026-08-23 policy, catalog **24D-8** (own_thread_p CODE_LABEL rule, reorg.c:2196 +
the own_fallthrough gate reorg.c:3936): our join carries the 2-predecessor label; retail's
reorg stole the addu into the other arm's bnez slot and **retargeted the label past it** —
a post-compile label move (the PER_FN_TEXT_MOVES label-move family, e.g. the wired
w65-a1 LoadGame row) that policy forbids adding.  New falsifications banked in the TU
receipt: an asm insertion cannot supply the slot (asm insns are delay-slot ineligible and
the label blocks the fill regardless of the filler's origin); a pinned
`register char *t asm("$4")` copy above the branch lands `[addu][beqz]` = 2 diffs instead
of 1; the branch-taken thread starts with a store (`keepup = 0`) which MIPS-I reorg can
never speculate into a non-annulled slot.

## 2. Hud_RenderTacView — 11 STAYS, floor receipt now mechanism-complete

The W75 named angle (cross-block reference to the `(high sym)` RTX / tied multi-output
launder) is **falsified across every measurable cell**, and the retail shape is now fully
characterised:

**What retail needs (read off the oracle + our RTL dumps):** ONE high pseudo
`H = high(DashHUD_gInfo)` with TWO defs (entry lui, loop-bottom lui) and a cross-block use
(the loop-head `addiu v0,v1,%lo` in the beqz delay slot).  H is then multi-block/2-death →
`reg_qty[H] < 0` → combine_regs refuses the dest tie at BOTH loads (local-alloc.c:1868 /
:1877) = the separate-temp `lui v1; lw v0` pairs — while staying CALLER-saved because the
bottom lui re-defines it each iteration (never live across the body's jals).

**Why no compiler input reaches it** (each leg cited or dump-receipted):
1. expand creates a fresh high pseudo per site; only cse could merge them and cse's
   extended basic block ends at the loop-head CODE_LABEL (24C-2).
2. LICM refuses the body/tail highs: loop.c:1640
   `threshold * savings * m->lifetime >= insn_count` with savings=1, lifetime=1/4 vs
   insn_count 52×2 — dump receipt `Insn 59: regno 99 (life 1) … not desirable`,
   `Insn 168: regno 134 (life 4) … not desirable` (`scratchpad/w76/tac_base.loop`).
   A *forced* merge (hoist / loop-carry / same-node) puts the merged value live across the
   body's calls → callee-saved park = the known 14/18/43 cells.
3. Reload inheritance cannot carry the high across the label:
   **reload1.c:4208-4213 "A reload reg's contents are unknown after a label"** (new cite).
4. The while/for route is dead structurally: **jump.c:2354-2381** —
   duplicate_loop_exit_test renames every exit-code-local pseudo in the copy
   (`reg_map[REGNO(reg)] = gen_reg_rtx(...)`), so the duplicated entry test can never
   share its high with the bottom test.

**Measured this wave (all on the sibling TU, all restored):**
* loop-shape family: plain `for` 51 @74 · `while` 51 @74 · for-with-comma-test 34 @75
  (LICM hoists the base and parks it callee-saved; the do-while + explicit guard + guard
  fence of the current basin are load-bearing);
* m-fence death-move family (move the high's death off the load so combine_regs never
  ties): entry 14 @73 · entry+tail 16 @75 · tail-only 13 @74 — the tie DOES break
  (`lui v0; lw v1,0(v0)` appeared) but with no full-address register in scope the fence
  **materialises** `addiu v0,v0,0` (+1/site).  Confirms 21A-5's boundary from the failure
  side: the 'm'-fence is zero-insn ONLY where a full-address reg already exists;
* dest-side escape (named entry value `e` + once-executed cross-block `"r"(e)` guard-fence
  ref; the local-alloc.c:1877 sreg-ineligible leg): bit-identical 11 — the tie is refused
  but local_alloc still hands the (block-local) high $v0 first, so no byte moves;
* tied launder in the `&&` reading `e` (the literal w75 angle): 27 @74 — any body
  reference of `e` parks it callee-saved across the calls;
* per-fn flag axis (vprobe_flag `W75_FN_FLAG`, 8 cells): `-fno-rerun-cse-after-loop`,
  `-fforce-addr`, `-fforce-mem`, `-fno-expensive-optimizations`, `-fno-peephole` all
  bit-identical 11; `-fno-schedule-insns` 51, `-fno-schedule-insns2` 21,
  `-fno-strength-reduce` 65 @80.  (No FSF cc1plus exists for a ver-splice on this C++
  lane — 06E; the 24E-6 distribute_notes 2.8.1 route is therefore unreachable here.)

**Verdict:** the 2-def caller-saved high is a pseudo-IDENTITY property, not an
allocation/scheduling property.  Under the no-post-compile-edit policy the 11-line
residual (+1 body lui, self-temp entry/tail pairs) is this fn's floor; full receipt is in
the TU above the function.

## 3. Hud_Init — 24F-9 wordcmp audit (the 99.99% board row)

`wordcmp` on the gate-PASSing fn: **624/624 words, 142 reloc-explained, REAL=1** —
word 265 `bnez v0,+0xa` (ours) vs `+0xb` (retail, oracle C3C50).  Retail splits the
w2-chain join: its `bnez Hud_BeTheCop` enters at `.L800D3480` (the nop before the
x-select beqz), PAST the `.L800D347C` volatile-blocked reload, because retail's cse
proved the reload redundant on that edge and retargeted the jump.  Our w40-a1 volatile
cast blocks that retarget by design — and it is still load-bearing: removing it,
re-measured in the CURRENT basin with the TEXT_MOVES rows injected on the sibling,
gives FAIL 72 @620 (the w40 receipt holds; 21E-1 re-pricing done).  Semantically
identical (the skipped insn re-loads the same global on a path where its value is
unchanged).  Documented as a **coupled-device artifact** in the TU next to the volatile
MATCH block; not chased with label devices (policy) or by dropping the volatile
(measured).  Board's 99.99% on this row is explained and stands.

---

## 4. New laws / catalog candidates

1. **ARM-DUPLICATION IS THE BLOCK-LOCALISER for a two-arm select feeding a shared address
   chain** (BuildCdPlayer 15→1): duplicating the whole lookup into both arms makes index
   AND chain block-local (birth-order allocation = retail) and post-RA cross_jump merges
   the identical suffixes back — zero net instructions.  The join-block spelling can
   never reach it (the index is a global allocno there; 16B).  Pairs with the 23B-3
   removal law: any fence tuned in the join-spelling basin must be re-priced (here:
   REMOVED) after the duplication.
2. **m-fence failure boundary named**: the 'm'-operand fence materialises an address
   (+1) at any site where cse holds no full-address register — it is only a zero-insn
   ref/death dial where a materialized `&sym` already exists (BuildCdPlayer loop = yes,
   TacView entry/tail = no).  Measured from both sides this wave.
3. **combine_regs has a second (dest-side) refusal leg** — local-alloc.c:1877
   `reg_qty[sreg] == -1` — reachable from C by making the load's destination a
   cross-block variable at zero insns; but breaking the tie alone does NOT move bytes
   when local_alloc still hands the high the same register (TacView d1 cell).  A
   tie-refusal is necessary, not sufficient.
4. **duplicate_loop_exit_test can never share pseudos between the two tests**
   (jump.c:2354-2381 reg_map rename) — closes the "natural while-loop" hypothesis for
   any two-load %hi-sharing shape, this fn and future ones.
5. **Reload inheritance dies at every CODE_LABEL** (reload1.c:4208-4213) — kills the
   "retail derives the addiu via reload inheritance across the loop head" hypothesis
   class in one cite.

## 5. Process notes

* The 1996 cc1plus TMPDIR rule (W75) held: harness sets Windows TMPDIR/TMP/TEMP on every
  probe subprocess.
* All grids were written to files and `cat`'d (no truncating pipes; W61-13F).
* The temp sibling TU needed the TU's per-TU flags to be meaningful: solved with a
  temporary `PER_TU_FLAGS` row + `W60_TU_FLAGS` injection; row removed at close,
  `ast.parse` clean both times.  A probe TU in recon/** never survived a probe
  (deleted in `finally`; stale `build/…/hud_a4probe.*` objects removed at close).
* wordcmp needs the CURRENT object: run it immediately after a tugate of the shared TU
  (the build dir object is the gate's own artifact, TEXT_MOVES applied).

## 6. Files

* `recon/game/psx/hud.cpp` — the only tracked recon file changed (BuildCdPlayer landing +
  three receipt blocks: CdPlayer w76 header, TacView w76 floor, Hud_Init word-note).
* `tools/build.py` — probe row added and removed (net zero; user hunks preserved).
* `scratchpad/w76/` (untracked): `a4_probe.py` (sibling-TU runner), `a4_base_hud.cpp`
  (private HEAD-time snapshot), `e_*.json` (every probed cell), `p_*.txt` (sbs
  snapshots), `tac_base.{loop,greg,lreg,s}` (protected RTL dumps — the LICM
  "not desirable" receipts), `a4_init_rows.json`, `a4_init_wordcmp.txt`,
  `a4_{base,final,close}_gate*.txt` (the four double-gates).
