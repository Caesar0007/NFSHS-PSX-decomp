# W76-A3 REPORT — Hud_BuildNumbers belt (unit `game/psx/hud`, `recon/game/psx/hud.cpp`)

## HEADLINE

| fn | baseline | final | state |
|---|---|---|---|
| `Hud_BuildNumbers__Fi` | FAIL 188 diffs, count-exact 758/758, posmis 147 | **PASS 758/758, posmis 0** | 🏆 **SEALED — CLEAN** (zero devices: no asm, no fences, no pins, no build.py rows) |

TU `recon/game/psx/hud.cpp`: **59/62 → 60/62 PASS**, gated twice post-landing, PASS-set
diff vs the pre-landing worktree = exactly {BuildNumbers FAIL→PASS}, **zero PASS→FAIL**.
Remaining: `Hud_BuildCdPlayer__Fii` 1 (A4's), `Hud_RenderTacView__Fv` 11.
`tools/slotcheck.py` on the TU object: bad = 0 (the seal is asm-free anyway).

An eight-wave wall (w40/w45/w46/w53/w71/w72/w74/w75) fell **without landing the W75
K-recipe statement moves** — the "pure scheduling problem in an allocation-exact basin"
framing was half right: the right basin makes BOTH sides fall out of six source levers.

## THE LANDED RECIPE (variant HT8, `scratchpad/w76/A3_h8.json`; receipt block in-source)

1. **X-HOIST** (posmis 147→110, the wave's biggest single lever): retail computes
   `x = x - 1 - width` **above** `if (hun != 0)` — the `subu` sits in the `beqz` delay
   slot and runs on both paths; `x` is block-scoped and dead when hun==0, so semantics
   are preserved. Spelled `{ int xm1 = x - 1; x = xm1 - (int)HudPmx_gShapes[hun+0x2c].width; }`
   because fold rebuilds `x-1-w` into `x-(w+1)` (catalog 22A-1); the block temp keeps
   retail's `(x-1)-w`. Read off the oracle: the 40-insn tail run 671-710 (whole hun-block
   emission incl. the OT-link order and the reorg slot steal) became byte-exact.
   **Side effect that dissolved the six-wave hun problem: hun's shape became r8 l73
   pri .3288 — top of the s-band with NO ref inflation needed.**
2. **HudPosition m2 fold-escape** (110→84): mutable `int m2 = -2;` (22A-1 escape) +
   the operand order `(g1Player[0xe].x + g1Player[10].x + (HudPmx_gShapes[0x2c].width
   + m2)) - P`. The -2 stays on the width (retail `addiu a1,a1,-2`); fixing this ONE
   statement also snapped the block's entire a1/a2 caller-saved rotation (~26 posmis).
   Measured: trailing `+ m2` 92 · width-leading 109 · **A+B+(W+m2) 84**.
3. **hun/ten moved up** to just after `speed = ...` (84→79): retail materializes the
   divide magics first and starts both mults early. The w71 "hun+ten up = 236" verdict
   was basin-relative (21E-1 re-price). Free side effect: **ten live 51→55 =
   pri .2545 < pSprt .2608 — ten's required dial, no device.**
4. **switch-default index-first int-cast** `DashHUD_gInfo.gear * 20 + (int)pSprt + 780`
   (both sites; §5.0c commutative-addu lever): retail associates (base+scaled)+780 with
   the scaled index first. (The `(char*)(pSprt+gear)+780` half-form fixed the addiu/addu
   ORDER but left the addu operand order — the int-cast form fixes both.)
5. **w2 wrapper dropped** (`do { x = x - w2; } while (0);` → plain): w2 refs 4→3,
   live 10 (shortened by lever 3) = pri .3000. Retires the w53 pSprt dial — its job is
   done by seating order now.
6. **w1 depth-3 phony loop** on the else arm:
   `do { do { x = x - w1; } while (0); } while (0);` = **+2 refs, zero insns**
   (r8 l60 pri .4000). ⚠️ Depth-3 DOES stack at this site — w71's "nesting does not
   stack" was measured on the x-w2 site (basin-relative, 04Z again). Depth-2 here is
   only +1 ref and the whole handout collapses.

## MECHANISM (allocsim-certified; sim MATCH 50/50 in this basin)

The retail s-band is a forced seating chain, not a 4-cycle to be dialed pseudo-by-pseudo:
* the local-allocated /100-magic constant on s0 excludes prim → s1 and x → s2;
* hun (born after the magic dies) is the only s-band pseudo that can share s0;
* priority order hun > w1 > w2 > pSprt > ten then forces w1 s3 (magic conflict keeps it
  off s0), w2 s4 (blocked by hun/prim/x/w1, disjoint from speed-raw), pSprt s5, ten s6,
  w7 s7 — and **speed-raw → s4 and splitY → s6 snap as riders** (sweep: every hit moved
  exactly those two, to retail seats).
* 🔑 **The w1 window is wide, not razor-thin: p626 refs=8 hits for ANY live 47..80**
  (also r6 l24-40, r7 l27-46, r9 l52-90 — full grid in `A3_sweep2_out.txt`). The W75
  live targets (39/10/56) were one cell of a big family; at refs 8 the CURRENT live 60
  is already inside — which is why the statement moves were unnecessary.

## CERTIFICATES / FALSIFIED (this basin unless noted)

* **PS2-basin sweep** (`A3_sweep_out.txt`): 2-dial 82 396 combos **0 hits**; 3-dial
  188 072 combos 3 825 hits, all requiring w1 live=36 — i.e. in the OLD basin the wall
  was real; the basin change (levers 1-3) is what made it 1-dial.
* **HT2-basin sweep** (`A3_sweep2_out.txt` + window scan): 1-dial family on p626 only.
* Read-only fences on w1/w2/ten at 6+ positions: **+1 insn each** (w74-C confirmed —
  the carriers cross the BuildGT4 calls). Fence lane dead for this fn.
* Tied launder on w1 (`"=r"/"0"`): frame explosion, count 756 (HT6a).
* Bare volatile fences inside the speed block (3 positions): block-wide RTL
  restructure, counts 756/757/759 (HT6b-d).
* x-block do{}while wrapper (decl inside): RTL restructure, count 756 (HT5b).
* w7-def wrapper: allocsim says w7 pri .3 steals s5 (pSprt→s6 cascade) — not probed.
* Every statement-move cell that relocates the w-group or x block in the new basin:
  KXP 120 · KXP_keepdo 113 · KXP_xonly 118 · KXP_wonly 158 · HT3 114 · HT4 128 —
  each breaks the magic-const/prim/x seating that anchors s0/s1/s2 (the K_4x2 recipe
  only worked because its hun fences made hun pri .85, replacing the magic as the
  s0-blocker). posmis ladder of the kept path:
  BASE 147 → XH2 110 (XH1 113, XH0 count+1) → +PS2 84 (PS1 92, PS3 109) → +SW1 83 →
  +HT 79 → +KB (HT2) 58 → +d3-wrapper (HT7a) 1 → +index-first switch (HT8) **0**.

## PROCESS / TOOLS

* **Temp-sibling protocol held throughout**: all probing via
  `scratchpad/w76/A3_probe.py` — applies edits to the private snapshot
  `A3_base.cpp`, writes `recon/game/psx/hud_a3w76.cpp`, injects hud's `g_value 8` via
  vprobe_flag's `W60_TU_FLAGS` env hook, gates + computes posmis + optional
  roles/side-by-side, deletes the sibling AND its build/ objects in a finally.
  `recon/game/psx/hud.cpp` was written exactly once (the landing), re-read immediately
  before the write, byte-mode CRLF-preserving; the concurrent session's uncommitted
  edits in other fns/TUs untouched.
* The tree moved mid-belt (commit 44bd4251 + uncommitted A4/user work): re-baselined
  the TU before landing (59/62 with CdPlayer 1 / RenderTacView 11) and diffed the
  PASS set post-landing — only BuildNumbers changed.
* Sweep outputs redirected to files (`A3_sweep_out.txt` ran 10+ min backgrounded);
  no truncating pipes.
* New scratch tools: `A3_probe.py` (sibling prober), `A3_sweep.py`/`A3_sweep2` (goal-
  seating dial sweeps with a moved-others audit), variant sets `A3_{xh,ps,f,m,k,h,h4,
  h5,h6,h7,h8}.json`, dumps `A3_<variant>.{greg,lreg}`, sbs files `A3_sbs_*.txt`.
* **Law candidates for the catalog** (all cited to measurements above):
  (a) X-HOIST class: a guarded block whose first real statement mutates a dead-on-skip
  local can be retail-hoisted above the guard — look for the mutation in the guard's
  delay slot + a fully byte-exact block body below it;
  (b) the 22A-1 mutable-K escape also fixes CALLER-SAVED ROTATIONS downstream of the
  fold (PS2: one statement, ~26 posmis);
  (c) phony-loop depth-3 = +2 refs where depth-2 = +1 (site-dependent; stacks here);
  (d) seating-chain reading: before dialing an N-cycle, identify the hard-reg blockers
  (local-allocated constants, call-crossing anchors) — the cycle may be 1 dial in
  disguise; allocsim `--what-if` + a moved-others audit is the cheap certifier;
  (e) posmis is monotone across a basin change only when the basin's seating survives —
  judge statement moves by roles + posmis together, never LCS.

**Not done (policy):** no git commit/stage/push, no memory-dir writes, no build.py
edits, no PIN-SEALED items (the seal is device-free). No slot rows, no post-compile
mechanisms.
