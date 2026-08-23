# W75-A9 report — AI belt (game/common: aih_basicperp, aih_btccop, aih_opp, aih_cop, aiphysic)

## Headline

**0 seals, 0 regressions, 5/5 targets re-gated twice at baseline.** Every target on this belt
is a 5–7-wave near-miss at 2–20 diffs; the belt's product this wave is **three
compiler-source/RTL-dump mechanism results that convert two "next lens" asks into named,
executable next steps, plus one refutation of a receipt claim, one refutation of the
orchestrator's hand-down, and one VOID-ing of a stale W63 measurement.**

## Baselines and finals (whole-TU, gated twice, identical both passes)

| TU | gate | target fn | baseline | final |
|---|---|---|---|---|
| `recon/game/common/aih_basicperp.cpp` | 8/9 PASS | `CheckChaserPosition__16AIHigh_BasicPerpii` | 2 diffs (85/87) | 2 diffs (85/87) |
| `recon/game/common/aih_btccop.cpp` | 39/40 PASS | `HighExecute__18AIHigh_BTC_Wingman` | 4 (675/675) | 4 (675/675) |
| `recon/game/common/aih_opp.cpp` | 5/6 PASS | `CheckForWipeOut__15AIHigh_Opponent` | 9 (121/120) | 9 (121/120) |
| `recon/game/common/aih_cop.cpp` | 9/10 PASS | `HighExecute__10AIHigh_Cop` | 20 (1460/1460), **posmis 9** | 20, posmis 9 |
| `recon/game/common/aiphysic.cpp` | 41/42 PASS | `AIPhysic_OutOfControlPhysics__FP8Car_tObj` | 5 (413/412) | 5 (413/412) |

**ZERO PASS→FAIL anywhere.** The only in-tree edits are receipt comments (one per TU); each
was verified to have landed (`count == 1` post-write) and each fn re-gated immediately after.
No build.py rows added. No `git add`/commit. No memory-dir writes.

---

## 1. `CheckChaserPosition` — THE OWNING PASS AND ITS ESCAPE ARE NOW PROVEN (new law)

Seven waves called the missing `blez s0` + `nop` "a cse value-range record". True but
incomplete. Full mechanism, all cited, all dump-confirmed:

1. **The missing branch is not a source statement.** `jump.c:625` calls
   `duplicate_loop_exit_test` (`jump.c:2286`) for every `NOTE_INSN_LOOP_BEG` whose
   `next_nonnote_insn` is a **simplejump** — our `do { loads; if (pos<1) break; … } while (0<pos)`
   emits exactly that. It **copies the loop-entry block** (the two `positionVSCopList_` loads +
   the guard test) to just before `LOOP_BEG` and rotates the loop. In our `.jump` dump the copy
   is insns 247–256 + `jump_insn 257 (le reg83 0)`. **257 is the oracle's idx-33 `blez`**;
   `cross_jump` later merges the copied loads with the loop-top ones, which is why the surviving
   branch reads as in-loop in the retail listing.
2. **Why it dies:** `cse.c:7681` `record_jump_equiv(insn,0)` on the outer `if (0 < pos)`
   (`jump_insn 47`) records GT/const0 against `pos`'s **quantity** (`record_jump_cond`,
   `cse.c:6105`); `fold_rtx` `cse.c:5520-5539` folds 257 to false via
   `comparison_dominates_p(GT, reverse(LE))`. **Proved by dump diff:** `.jump` has three `le`
   jump_insns (47, 257, 224); `.cse` has two (257 deleted; 78's condition also dropped to a plain
   `j` — retail deletes *that* one too, so the fold itself is not the anomaly, only its scope is).
3. 🏆 **THE ESCAPE IS A cse BASIC-BLOCK BOUNDARY, NOT A VALUE DEVICE.**
   `cse_end_of_basic_block` (`cse.c:8189`) ends a cse block **only at a `CODE_LABEL`**, and —
   when `!after_loop` — at `NOTE_INSN_LOOP_END` / `NOTE_INSN_SETJMP`. **Conditional jumps do not
   end it**, so 47 and 257 sit in ONE block and the record applies. This single fact explains
   every falsification in six waves (block notes, comparison codes, loop shape, barriers all
   leave the boundary alone) and is transferable to any "redundant guard the oracle keeps".
4. **The cse1 half is SOLVED, measured:** `do { __asm__("" : : ); } while (0);` as the first
   statement inside the `if` plants a `NOTE_INSN_LOOP_END` between 47 and the copy → the `.cse`
   dump **shows the duplicated test surviving cse and loop**.
   ⚠️ A **bare `do{}while(0)` does NOT work, and that is not a null result**: with no insn inside,
   `next_nonnote_insn(LOOP_BEG)` skips its notes straight to the real loop's simplejump,
   `duplicate_loop_exit_test` fires on the **wrong** `loop_start` and emits the copy *before* the
   breaker's notes (35 @90). The asm-bearing breaker gates 25 @86.
5. **The remaining blocker is named:** **cse2** (`-frerun-cse-after-loop`) runs with
   `after_loop=1` and `cse.c:8225-8231` **explicitly ignores `NOTE_INSN_LOOP_END`**, so it
   re-folds the copy. Pass attribution by dump: the guard survives jump/cse/loop and **dies in
   cse2**. PROOF: breaker + `-fno-rerun-cse-after-loop` puts **three** `blez` in the `.s`.
   (That flag is a *probe*, not a landing: whole-TU it is 49 @94.)
   ⇒ only a **`CODE_LABEL`** between 47 and the copy survives both cse passes, and jump.c pass 1
   deletes unreferenced labels before `duplicate_loop_exit_test` runs, so it must be *referenced*.

**Falsified this wave** (each re-gated from 2): a **26-flag cc1 sweep** — `-O1 -O3 -G0 -G8
-fno-cse-follow-jumps -fno-cse-skip-blocks -fno-rerun-cse-after-loop -fno-thread-jumps
-fno-expensive-optimizations -fno-schedule-insns{,2} -fno-delayed-branch -mno-split-addresses
-fno-strength-reduce -funroll-loops -fomit-frame-pointer -fno-function-cse -fno-peephole
-fno-defer-pop -fno-inline` — **all leave blez=2** (the flag axis is closed on its own);
`while(0){}` / `for(;0;){}` breakers 35 @90; the breaker *outside* the `if` inert (2 @85 — its
`LOOP_END` lands before insn 47); **four early-return spellings** of the outer guard
(`pos<1`, `pos<=0`, `!(0<pos)`, `0>=pos`) all byte-identical 2 @85 (gcc jumps straight to the
shared epilogue; no label is planted); the 22B(3) **tied identity launder on `pos` in the
PREHEADER** — a position no prior wave tried, every earlier fence was *at* the guard — 35 @92.

**Next named angle:** a zero-insn source construct that plants a **referenced** `CODE_LABEL` in
the loop preheader. Untried candidate: an `||` outer condition (`if (X || 0 < pos)`), whose
true-arm label is emitted immediately before the body — needs a zero-cost `X`.

---

## 2. `CheckForWipeOut` — W74's closing verdict REFUTED; residual priced off cc1's scheduler dump

* 🔴 **It is NOT a cross-block placement question.** W74 wrote "retail's 596 chain is in the
  pre-branch block, ours in the post-branch one". There is no branch between them: `(abs:SI …)`
  is **one RTL insn** (`abssi2`) — exactly one `(abs:SI` appears in
  `.jump/.cse/.loop/.cse2/.combine` — so the whole loop head `lw a0,0(a2)` … `beqz` is **one
  basic block** (bb 12, insns 205–249). The residual is a **within-block sched2 ready-list order**.
* **The instrument:** `cc1 -dS` / `-dR` print the per-block priority table *and* the ready-list
  trace. bb 12 (sched2): `209 lw carObj_h` pri 1 · `222 lw ->1380` pri 2 **ref_count 9** ·
  `394 lui` 2 · `226 lw ->596` pri 3 · `395 ori` 2 · `229 sll` 4 · `231 addu` 4 · `244 abs` 3 ·
  `248 slt` 3 · `233 lw *(tableEntry)` 4 · `237 lw ->932` 3 · `241 lw ->148` 5.
  Reversing the backward picks gives `209,222,394,395,244,226,248,229,231,233,237,241,249` —
  **our asm exactly**. Retail wants `209,395,226,222,229,231,244,248,…` i.e. the carIndex load
  **ahead of** the currentSpeed load.
* **The one blocker, quantified:** insn **226 carries a LOG_LINKS edge to 222**, which is what
  gives it pri 3 = pri(222)+1; and **222 has ref_count 9** — every other insn in the block is
  chained behind the 1380 load. Without that edge 226 ties 222 at pri 2 and
  `rank_for_schedule`'s final tie-break (**priority → last-scheduled class → `INSN_LUID`
  = original order**) makes the *source order* decisive, which is what would give the
  already-measured "carIndex read first" spelling meaning. **Killing that edge is the next lens.**
* **Falsified** (each re-gated from 9, all byte-identical 9 @121): the **22C(3)
  `MEM_IN_STRUCT_P` alias dial**, never tried on this fn — spelling the three cast field reads as
  real COMPONENT_REFs (`carObj_h->currentSpeed` +1380, `hlai[carObj_h->carIndex]` +596,
  `carObj_h->stats.numFines` +932) **singly and in all four combinations**; `__builtin_abs(field1380)`
  (the ternary already folds to `abssi2`, so 22A(3) has nothing left to buy here) and the
  `(…) ? 1 : 0` wrapper. Inlining the abs load at the compare site is 19 @121 (re-confirms W71).

---

## 3. `HighExecute__18AIHigh_BTC_Wingman` — the orchestrator's A20 hand-down is the known 489 basin

The A20 sweep's "ctor-return-vs-address remat — re-take `&obj` after the call / hold the address
in a named local (§3.12 #16)" is **the shape W61/W74 already banked as the 489 basin**. Measured
this wave on the LIVE definition (compound 4-line anchor, `count == 2` asserted), each re-gated
from 4:

| spelling | gate |
|---|---|
| Y1 both arms → `&trafficOffset` (the A20 shape, control) | 489 @698 |
| Y3 `offset = &trafficOffset;` re-assigned right **before** the call | 489 @698 |
| Y5 `memset(…); offset = &trafficOffset;` (§3.12 #16 proper) | 489 @698 |
| Y8 `offset = &X; memset((u_char*)offset,…);` pass `offset` | 489 @698 |
| Y9 arg spelled `(coorddef *)((char *)&trafficOffset)` | 489 @698 |
| Y2 store via `offset->y` **and** pass `&trafficOffset` | 503 @684 |
| Y7 `offset=&X; memset(offset); offset->y;` pass `offset` | 497 @684 |
| **Y6 keep the capture, store via `offset->y`, still pass `offset`** | **19 @662** |

Y6 is the **first basin this function has ever had that is SHORTER than the oracle** (−13): the
`trafficOffset.y = …` vs `offset->y = …` spelling at those two arms is worth 13 insns. Not a
landing, but the only under-count base on record and a different direction from every
489/497/503 measurement.

🔴 **CORRECTION — a stale receipt line is VOID.** W63's "(i) reordering all three arms to
`offset = &X; memset((u_char *)offset,0,0xc);` is INERT — 4 diffs, byte-identical" **predates the
W72 dead-copy (`#if 0`, lines 1847–2448) discovery**. Re-measured on the live definition only it
is **489 @698**, not inert. Treat any pre-W72 "inert" on this function as a missed-anchor alarm.

Standing verdict, now six spellings strong: **passing the call's return VALUE is what keeps the
two arms textually identical so they cross-jump-merge**; any address-valued arg de-merges them,
costs one callee-saved register (s3 appears, frame −104 → −112, `this` s1 → s2) and +9…23 insns.
W74's next lens is still the right one: `-dg` the 489 variant and read which allocno `s3` carries
(the 4-diff and 489 builds differ by one source token per arm = a clean control pair).

---

## 4. `AIPhysic_OutOfControlPhysics` — the per-fn flag-splice menu is now fully priced (all negative)

W74-A10 states the requirement as *"the ARG access must not leave a full-address pseudo alive."*
The mechanism that decides whether an address is pre-split into `(high)`+`(lo_sum)` pseudos is
`mips_check_split` / `mips_split_addresses` (§22A-5), whose switch is `-mno-split-addresses`, and
build.py already carries a per-fn vehicle for it (`PER_FN_NO_SPLIT_ADDRESSES`, spliced by
`_apply_fn_splice` in the C++ lane). Measured per-fn via the `W61_TABLE` hook on `tools/vprobe.py`:

* `-mno-split-addresses` → **18 diffs @414 (worse, +1 insn)**. Retail *still* splits
  (`lui s0,%hi` + `lw a1,%lo(s0)`); what it lacks is a separate `lo_sum` **pseudo**, which is a
  cse question, not a split-addresses question.
* `PER_FN_FORCE_ADDR` (`-fforce-addr`), `PER_FN_NO_THREAD_JUMPS`, `PER_FN_G8` → **byte-identical
  to the 5-baseline**.

⇒ the whole per-fn flag-splice menu available in the C++ lane is priced on this function and none
of it reaches the fold. W74's named angle (re-price the SYM-faithful no-pointer form *together
with* fold-denial) remains the untaken step.

---

## 5. `HighExecute__10AIHigh_Cop` — honest metric + the census W72/W74 kept naming

* **posmis = 9**, not 20 (`tools/posmis.py`; the LCS count is inflated per 21E-3). The nine:
  A′ `lw a0,0(v0)`/`bnez a0` vs `lw v0,0(v0)`/`bnez v0` (2) · B `lw v0,32(s1)`, `beq v0,a1`,
  **ours NOP / retail `li v0,4`**, `beq v0,s2` vs `beq v1,v0` (4) · D `slt v0,v0,v1`/`beqz v0`
  vs `slt v1,…`/`beqz v1` (2) · E one `bne` operand order (1).
  **B is four of the nine** and the only cluster with a structural component.
* **The qty census is available without the instrumented cc1** (which ICEs on this TU): the real
  CC1PLPSX prints `-dl` and `tools/copypref.py` reads it directly —
  `python tools/rtl_dump.py recon/game/common/aih_cop.cpp -dl` then
  `python tools/copypref.py scratch/rtl/aih_cop.i.lreg "AIHigh_Cop::HighExecute"`
  (saved: `scratchpad/w75/A9_cop_qty.txt`, `A9_cop.lreg`).
  **Headline fact that decides whether 14C applies at all: HighExecute has 104 local-alloc blocks
  and 61 of them carry ≤ 3 qtys** — most of this function sits in `local-alloc.c` `case 3:`/`case 2:`
  territory, so *count the block's qtys before quoting either arm*. copypref's `!!` rows flag where
  its model and the compiler disagree; several are exactly the v0/v1 two-qty handouts of A′/C/D, so
  `--why <pseudo>` on them is the concrete next command. Nothing landed here (budget went to the
  belt's other four).

---

## New/refined laws for the catalog

1. **cse block-boundary law (new).** `cse_end_of_basic_block` (`cse.c:8189`) ends a cse basic
   block only at a `CODE_LABEL`; additionally at `NOTE_INSN_LOOP_END`/`NOTE_INSN_SETJMP` **only
   when `!after_loop`**. Conditional jumps never end it. ⇒ a redundant compare the oracle keeps
   is reachable by planting a block boundary between the *recording* branch and the *folded* one —
   and a `LOOP_END` breaker works for **cse1 only**, because cse2 (`after_loop=1`) ignores it
   (`cse.c:8225-8231`). Only a **referenced** `CODE_LABEL` beats both.
2. **`duplicate_loop_exit_test` is a real source of "extra" oracle branches** (`jump.c:2286`,
   called at `jump.c:625` only when `next_nonnote_insn(LOOP_BEG)` is a simplejump). It copies the
   whole loop-entry block, remaps exit-code-local temps to fresh pseudos, and rotates the loop.
   A near-miss whose missing insns are a *duplicate* of the loop top is this, not a source shape.
3. **A zero-insn breaker loop must CONTAIN an insn.** `do{}while(0)` with an empty body leaves no
   non-note insn, so `next_nonnote_insn(LOOP_BEG)` walks straight into the *next* loop's
   simplejump and `duplicate_loop_exit_test` mis-attaches (copy emitted on the wrong side of the
   breaker's notes). `do { __asm__("" : : ); } while (0);` is the working form.
4. **`rank_for_schedule` tie-break chain (sched.c), for the record:** `INSN_PRIORITY` →
   dependence class w.r.t. the last scheduled insn (3 = independent/latency-1 wins) →
   `INSN_LUID` (original order). A within-block order residual is only source-reachable through
   priority (= the dependence graph) or, at exact ties, statement order.
5. **`-dS`/`-dR` are a first-class instrument, not just `-dl`/`-dg`.** They print, per block, the
   priority + ref_count table and the full ready-list evolution — enough to reconstruct the
   emitted order exactly and to name the single edge that has to die.

## Process notes

* `tools/rtl_dump.py` accepts arbitrary dump flags (`-da`, `-dS`, `-dR`, `-dl`, `-dj -ds`); its
  fixed output path is `scratch/rtl/<tu>.i.*` — protected copies for this belt are under
  `scratchpad/w75/A9_rtl/`.
* Probe harness `scratchpad/w75/A9_probe.py` (byte-level, CRLF-preserving, restores from a
  `.a9bak` in a `finally:`; anchors assert an exact occurrence count, incl. multi-count, so the
  `#if 0` dead-copy trap cannot absorb an edit silently). All `.a9bak` files were verified
  byte-identical to the restored source and removed.
* An emoji in a Python `b'…'` literal is a hard `SyntaxError` — the ASCII-only rule (19E) applies
  to receipt text as well as to file writes.
* `tools/vprobe.py`'s `W61_TABLE` env hook patches any per-fn build table in memory; note that
  `PER_FN_FLAG_SPLICE_272` is wired **only in the 272/alt-cc1 lane** (`_compile_c_272`), so it is
  inert on a `.cpp` — the C++ lane's equivalent is `_apply_fn_splice`'s fixed table set
  (`PER_FN_NO_DELAYED_BRANCH`, `PER_FN_NO_THREAD_JUMPS`, `PER_FN_FORCE_ADDR`, `PER_FN_G8`,
  `PER_FN_NO_SPLIT_ADDRESSES`).
* No build.py rows were added (and per the user policy in `75be7d4c` no post-recompile rewrite
  rows were even considered).
