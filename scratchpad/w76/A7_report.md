# W76-A7 — drawc belt report (unit `game/psx/drawc`, TU `recon/game/psx/drawc.cpp`)

## Headline

| fn | baseline | final | note |
|---|---|---|---|
| `DrawC_PrimClip__FP10matrixtdef…` | **49** diffs (ours 1876 / oracle 1877), posmis n/a | **PASS 1877/1877** (posmis 0) | **SEALED**, zero insns added, ZERO pins |
| `DrawC_Prim__FP10matrixtdef…` | PASS 1389/1389 | PASS 1389/1389 | untouched, stayed sealed |

TU: `19/20 PASS` → **`20/20 PASS`** — the TU is COMPLETE.  Whole TU gated
TWICE post-landing (both 20/20; the runs include a concurrent session's edits
to other drawc fns — see Process).  `slotcheck` on `build/recon/game/psx/
drawc.cpp.o`: **bad = 0** (mandatory: this landing adds zero-insn asm
devices).  `brdist`: 20 fns, **0 branch-offset/count divergence**.
Ghidra-ism / bare-VA scan: CLEAN.  No `build.py` changes, no git add/commit,
no memory-dir writes.  **NO PIN-SEALED items** — the two devices are the
established zero-insn families (24E-3 read fence; 20B/22B-1 clobber-launder),
i.e. ladder step (d), reached after (a) the predecessor's named angle was
executed and re-priced, (b)/(c) catalog + receipts consulted.

## The landing, in order (every step measured on an untracked sibling TU)

### 1. The MISSING INSN (49 → 42, count 1876 → 1877 EXACT) — vt1 def position

The W75 map filed the dispatch class as "compiler-generated, no source
statement to fence (13B/16C unreachable)".  It was source-reachable from the
OTHER side (21B-5, source-position): ours had `vt1 = (int)&sd->vt3;` ABOVE the
case-0 `if (noSub == 0)` guard (a w72-a3-era placement) — its `addiu
$t9,$s1,0x3D0` became the pre-branch code, reorg backward-filled the `bnez`
slot with the spill `sw $t9,32($sp)`, and the case-8/9 subtree's `li $v0,8`
got eager-stolen into the dispatch `beqz` slot (retail: empty slot + `li` at
the thread head).  Moving the def BELOW the if (to the second-loop preamble,
where retail's stolen-from-target `addiu`-in-slot proves it lived) fixed the
`bnez` cluster AND cascaded through the whole dispatch class: **49 → 42,
count-exact**, DrawC_Prim unaffected.  posmis became usable (27).

### 2. 🏆 THE JOINT (id2, facet_flag) CELL — 42 → 16

Fresh dumps at the 42 basin: p816/p817/p818/p819 stats IDENTICAL to the W75
certificate (allocsim MATCH 107/107, order IDENTICAL) — the certificate
transferred.  What-if `818:refs=20 + 819:refs=14` (the W75-proven joint
control) = all four seats retail, zero collateral (A7_wi_joint1.txt).

**Realization was NOT the modeled cell.**  Measured (each via dump+allocsim
before gating):

* id2 half, `__asm__("" : : "r"(id2))` after the morph = **model-exact**
  (+1 loop-weighted mention, refs 18→20, pri .3600→.3980, +1 live to
  crossers) — but alone the trio just rotates (68 diffs): facet_flag still
  serves first and owns $t1.
* facet_flag `refs→14` (−2 mentions) is **structurally dead**: removing its
  launder is only **−1 mention** (tied "=r"/"0" counts once) AND collapses
  the copy web — 260/238-diff rotations (envmap t9→t8; with the tail fence,
  id2→**a2**).  Two independent measurements; do not re-run.
* facet_flag `live→≥200`: tail read fence at the loop join = live 129→**188**,
  short of the ~223 bar (4·20/L < .3600).  Loop-carried fence at the loop
  head = live **423** but the range then conflicts with the whole loop →
  callee-saved **$s3** (24E-4 conflict-generator), wrong.
* **The winning device (P6/P9): keep priorities, DENY the registers.**
  A tied launder on facet_flag carrying **"$9","$10","$11" clobbers**
  (zero-insn hard-reg denial, 20B/22B-1): facet_flag (pri .5581, served
  first) is denied t1–t3; t0 is facet's; t4–t7 are DRAWC_VTZ template regs
  ⇒ it takes retail's **$t8**; the fenced id2 (.3980) then wins **$t1**;
  id1/id0 keep t2/t3.  allocsim on the real dump: all four seats == retail,
  MATCH 107/107 (A7_allocsim_p6.txt).
  **Three position laws, each measured ±1 nop:**
  1. it must sit where id0–2 are DEAD (21A-1: a clobber denies every allocno
     live at the asm) — i.e. after `DRAWC_UVTINT_ID`, not at the old launder
     site;
  2. INSIDE the FT3B arm — at the branch-target thread head it walls the
     ePmx0-guard `beqz` slot's steal of `andi v0,a2,3` (24D-6 stop_search_p:
     16-diff basin kept a `nop`);
  3. it must READ `facetOverlay` — without an in-block dependency sched1
     places the asm FIRST in the block (24D-7 no-predecessor ⇒ priority 0 ⇒
     placed first) where it walls the `(overlayFlag&3)` beqz slot's steal of
     `addiu a0,v0,-1` (+1 insn, ours 1878).  The arm block is ≤3 qtys so the
     extra facetOverlay ref cannot reorder its handout (15A pre-gate).
  The W75 falsification "20B clobber on facet_flag's launder = +1 insn
  (267..295)" was position- and basin-relative (old site, no read anchor, no
  id2-fence half) — 23B-3/04Z at full strength.
* With the seats fixed, the id LOAD+MORPH order went back to the natural
  **id0, id1, id2** (= retail's lbu/sll order).  The w73 36-cell sweep
  verdict ("(id2,id0,id1) is the joint minimum") was basin-relative — the
  id2-first order was itself compensating for the wrong seats.  16 diffs,
  posmis 16.

### 3. UV cursor → INDEX FORM (16 → … → 2 with #2; the W75 named giv angle)

`addiu $a2,$s1,215` sat in the entry block; retail emits it AFTER the three
LICM movables.  Statement-position (luid) move: INERT — the addiu has no
in-block predecessor, sched places it by ready-list order (24D-7).  Retail's
init is a **giv-group** emission: the 12D eliminated-biv law.  Rewrote the
envmap-UV stores in index form (`envmapUV_dst[uvk*8-1] / [uvk*8]`, `uvk++`);
loop.c strength-reduces the address into a giv, ELIMINATES `uvk` (no allocno,
no fabricated-counter hazard), and emits `addiu a2,s1,215` in the giv group =
retail's slot, with the identical in-loop `addiu a2,a2,8` step.  Addresses
are byte-identical to the old cursor (base &tV[0].v = +215, `[-1]` for `.u`;
DrawC_Prim's +214 typed walker NOT ported, per the W75 warning).

### 4. `li t3,38 / li s4,36` preheader order (last 2 diffs → PASS) — 21B-3

Retail hoists `li 38` BEFORE `li 36`; ours emitted `li s4,36` from the
case-1 case-scope initialiser `u_char code = 0x24;` (entry block, earlier
luid than the LICM hoists).  Born-in-the-loop (21B-3): decl becomes bare
`u_char code;` and `code = 0x24;` is assigned INSIDE the loop, textually
AFTER the two `0x26` blocks — both constants become movables hoisted in
APPEARANCE order = `li t3,38; li s4,36`.  Semantically identical (`code` is
read-only in the tail; the inner `0x26` `code`s are block-scoped shadows).
The case-scope initialiser was itself a w73 landing (its receipt block,
"landing (6)", 76→74) — basin-relative, 04Z.

**PASS 1877/1877, posmis 0.**  Gated ×2 on the sibling (both fns), then
applied surgically to the real TU (file re-read immediately before the
write), tugate ×2 = 20/20.

## Falsified this belt (do not re-run)

* facet_flag launder REMOVAL in any combination (alone 260; with tail fence +
  id2 fence 238): −1 mention only, and the copy web collapses (envmap t9→t8,
  p817→a2 / p818→a2).  The −2-mention route of the W75 certificate has no
  source realization; the DENIAL route replaces it.
* facet_flag tail read fence at the loop join: live 188 (< 223 bar) — the
  join is the farthest zero-insn extension point; the gap to the bar is not
  fence-bridgeable (+35 foreign fences would be needed, 15A).
* facet_flag loop-carried head fence: live 423 → whole-loop conflicts →
  $s3 (24E-4).
* envmapUV_dst statement-position (luid) moves: inert (24D-7).
* clobber-launder at the branch-target thread head (+1 nop) and without the
  facetOverlay read operand (+1 nop) — position laws above.

## New/сonfirmed transferable laws (catalog candidates)

1. **A "compiler-generated dispatch" reorg residual can be source-reachable
   from a NEIGHBOURING statement's position** (21B-5 generalized): the
   candidate set of every fill decision near the dispatch is fed by ordinary
   statements above/below it; the W75 "no statement at the thread head"
   verdict priced only the fence cure.  One def-position move closed a
   6-line class AND a ±1 count gap.
2. **JOINT-CELL REALIZATION LAW: when a modeled joint delta (refs/live) has
   no source realization, re-express the SAME seat assignment as a
   priority-preserving DENIAL** — the 20B clobber-launder is allocsim-visible
   (conflicts land in the dump), so the what-if loop closes: model seats →
   deny → re-dump → confirm MATCH.  Priced dials and denial dials compose.
3. **The clobber-launder position triad** (dead-rivals × off-thread-head ×
   in-block dependency) — each leg measured at exactly ±1 insn here; the
   third leg (read-operand as a sched anchor, 24D-4/24D-7) is what makes the
   device zero-insn in slot-rich code.
4. **Tied-launder mention accounting: "=r"(x):"0"(x) = ONE mention** (+2
   loop-weighted refs), not two — measured 18→16 on removal.  Receipts that
   priced launders as 2-mention dials should be re-read.
5. 04Z, three more firings: the w73 36-cell id-order sweep, the w73 case-1
   `= 0x24` initialiser landing, and the W75 clobber falsification — all
   basin-relative, all inverted at the sealed basin.

## Edits made

* `recon/game/psx/drawc.cpp` — 9 surgical code edits + 6 receipt blocks
  (in-line at each site + a W76-A7 closure paragraph appended to the W75
  certificate comment).  All inside `DrawC_PrimClip`'s body/case blocks; no
  shared headers, no other fns, no build.py.
* Untracked probe sibling `recon/game/psx/drawc_w76a7.cpp` created from the
  live file, used for EVERY probe (fleet rule), **deleted** (build artifacts
  too).
* `scratchpad/w76/`: A7_probe.py (sibling probe harness), A7_dump.py
  (edit→rtl_dump→allocsim with restore), A7_apply.py (the final apply),
  e_P*.json edit sets, A7_p1/p2a/p2b/p3/p4/p5/p6 dumps + allocsim receipts,
  A7_wi_joint1.txt, A7_p6/p7/p8 sbs snapshots, A7_p6_diff.txt.
  `scratch/rtl/drawc_w76a7.*` dumps copied to protected `A7_<tag>.{greg,lreg}`
  names immediately after each run.

## Process notes

* A CONCURRENT session edited OTHER drawc fns (NightHeadlight, PrimHalo,
  ShadowPrim*, SpotPrims, ShowroomPrims regions) during this belt and wrote
  77 bare-LF lines into the CRLF TU.  No interference either way: all probes
  ran on the sibling; the final apply re-read the live file immediately
  before splicing (byte-mode, os.replace); both 20/20 tugate runs cover the
  combined state.  I did not touch their hunks or normalize their endings.
* reqdelta was not used (W75: unusable at this allocno count — buffers, then
  times out with zero partial output).  allocsim what-if sweeps + real-dump
  re-measurement answered every pricing question; every dial that adds an
  RTL insn was re-measured on real dumps per 24F-10 (what-ifs are only valid
  for insn-free dials) — the P2b/P3/P4/P5/P6 ladder is exactly that
  discipline paying off.
* The orchestrator's session-limit cut landed mid-apply; resume completed
  apply → gate ×2 → this report with no re-probing needed (the sealed edit
  set was fully receipted before the cut).
