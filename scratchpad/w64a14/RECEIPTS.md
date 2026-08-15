# W64-A14 RECEIPTS — drawc / psxcontroller / cario / r3dcar belt

Repo HEAD at start `fbc974f7`.  Every number below was re-gated by me with
`tools/verify_asm.py` on this tree (baseline first, per 04Z / the stale-row rule).
Commits: `6bbc6ede`, `0683746a`, `4beca293`, `aa5cdea1` (+ 4 hunks swept into a
peer's `24f4b993`, see §5).

## 0. RE-GATED BASELINES vs FINAL

| fn | briefed | MY baseline | FINAL | delta |
|---|---|---|---|---|
| DrawC_Prim | 336 | 336 (1395/1389) | **166** (1395/1389) | −170 |
| DrawC_PrimClip | 552 | 552 (1883/1877) | **420** (1887/1877) | −132 |
| DrawC_PrimStart | 52 | 52 (976/976) | 52 (untouched) | — |
| DrawC_PrimMenu | PASS | PASS (480) | PASS | held |
| InGame_GetPSXPadValue | 168 | 168 (243/233) | 168 (route found+priced) | — |
| InGame_SetRamp | 13 | 13 (99/98) | **PASS 98/98** | −13 |
| InGame_ResetPSXController | PASS | PASS (305) | PASS | held |
| CarIO_CreateLicense | 30 | 30 (229/229) | 30 (axis closed) | — |
| CarIO_ReadInCarTextureData | 19 | 19 (492/491) | 19 (not re-attacked) | — |
| R3DCar_InsertCarFacetMenu | 12 | 12 (1054/1054) | 12 (axis closed) | — |
| R3DCar_CalcCarDimensions | verify | **PASS** (330) | PASS | stale row |
| R3DCar_InsertCarFacet | verify | **PASS** (1144) | PASS | w63 wiring landed |

Whole-TU after every landing, gated 2×: drawc 17/20 · psxcontroller 3/4 ·
cario 9/11 · r3dcar 26/27.  **Zero PASS→FAIL anywhere.**

## 1. LANDINGS

### 1.1 DrawC_Prim 336 → 174 (`6bbc6ede`), then → 166

🔴 **THE UNBLOCKER: the Ghidra byte-offset biv.**  Three waves of receipts
(w55-a9, w62-a14, w63-a14) had recorded "Prim's id block is at its own optimum,
do NOT port the PrimClip/PrimMenu morph lever" — every one of those measurements
was taken with `iVar7 = facetIdx * 0xc; … iVar7 += -0xc; facet = (int)obj->facet
+ iVar7;` still driving all five facet loops.  The SYM lists exactly ONE fn-scope
counter (`i`, REG `$t2` INT) and a typed per-block `facet` (PTR
Transformer_zFacet) — **no byte offset**.  Writing `facet = (int)(obj->facet +
facetIdx)` lets loop.c strength-reduce the ×12 into its own giv and reproduces
retail's counter shape (the `addiu t2,t2,-1` dec that reorg steals into the
guard's delay slot + the `addiu t2,t2,1` undo on the `continue` path — exactly
what DrawC_PrimMenu's sealed twin loop emits).  **336 → 276 at an unchanged
count**, all 5 sites; the now-dead `int iVar7;` declaration removed
(bit-identical).

From the 276 basin the morph lever bites **per site** (the earlier sweeps applied
it to all five at once and the losers hid the winners):

| SYM block | retail ids | edit | gate |
|---|---|---|---|
| 261 | t1/t0/a3 (already retail-exact) | plain split `idN = idN*8; idN = idN + (int)sd;` | 276 → **264** |
| 87 | a2/a1/a0 | split + PrimMenu ref-step dial | 264 → **234** |
| 178 | a2/a1/a0 | same | 234 → **204** |
| 413 | a2/a1/a0 | same | 204 → **174** |
| 554 | t9/t8/t3 | split 448 · PrimMenu dial 436 | left FUSED |

The dial is PrimMenu's verbatim `do{}while(0)` floor_log2 REF-STEP form (id0
plain, id1's `+= sd` wrapped, both of id2's statements wrapped) which reverses the
allocno order id0,id1,id2 → id2,id1,id0.  Strictly additive at −30/site.

Falsified from the 276 basin (all count 1395/1389 unless noted): the three index
`lbu`s moved BELOW the `MPrimPtr <= PrimPtr` guard = 331 **@1390** (it buys 5 of
the +6 excess insns — retail interleaves `lw v1,8(s1)` / facet / lbu id0,id1 /
`lw v0,4(s1)` / lbu id2 / sltu — but costs 55 LCS here; re-probe after the
remaining rotations) · `int facetIdx` + `== -1` (the SYM type) bit-identical ·
`facet = (int)(obj->facet) + facetIdx*12` bit-identical.

### 1.2 DrawC_PrimClip 552 → 428 (`0683746a`), then → 420

(c) the same biv drop (`iVar11`), all 5 loops: 552 → **524**, count unchanged.

(d) 🔑 **VOID-TAIL FENCE after the three `(sd->vtN).z = zN;` stores**, all 4
sites: 524 → **432** (count 1883 → 1887).  Without it sched2 SINKS the three
`sh`s into the clip-compare block's branch delay slots — ours was 3 insns SHORT
there and the ORACLE carries a `nop` — so the barrier makes the whole block
count- and offset-EXACT vs retail.  Position matters: the same fence BETWEEN the
loads and the stores is inert (524).

(e) the PrimMenu ref-step dial at morph sites 1 and 3: 432 → **428**.  Sites 2/4
regress at every depth measured (d1/d2, with and without the id1 leg: 434…450).

(f) the `(u_short)` cast (below): 428 → **420**.

### 1.3 the `DrawC_gOverlay` `(u_short)` cast — Prim −8, PrimClip −8

`diffsrc` named `overlayRaw = (int)((u_int)DrawC_gOverlay[…] << 0x10)` the #1
source-statement hotspot in DrawC_Prim.  `DrawC_gOverlay` is `extern short[51]`,
so **without** the cast cc1plus emits a SIGNED `lh` + a load-delay `nop` and then
re-sign-extends (`sll 16; sra 16`); retail's stream is `lhu; sll 16; sra 16`.
The SEALED DrawC_PrimMenu already carries `(u_int)(u_short)DrawC_gOverlay[…]` on
the identical expression (drawc.cpp:3896/3906, PrimHalo:4360/4373) — a pure
PrimMenu transfer, applied at all 4 Prim/PrimClip sites.

### 1.4 InGame_SetRamp 13 → **PASS 98/98** (`4beca293`)

The w63 named angle was "push k, the number of movables loop.c accepts before the
`&hoff` pair, so the threshold decays past it".  **Not needed** — the hoist dies
at the MOVABLE-EXISTENCE layer.  Four ordered devices:

1. **15C movable-existence kill** — loop.c builds a movable only for
   `n_times_set == 1`, so `hp = hoff; hp = hp + i;` removes the invariant-address
   movable outright.  13 → 10 (99 → 96 insns).
2. **identity launder** on the base (zero insns) kills the surviving `%hi` hoist.
   10 → 9.
3. **use-adjacency** — retail computes `&hoff[i]` AFTER the three `= 1` stores;
   ours was filling their two load-delay nops with the lui/addiu.  9 → 8.
4. **BLOCK-scoped base local + INT-TYPED index-FIRST sum**: a block-local `hb`
   gives the §3.15 SEPARATE-scratch `%hi` form where the fn-scope pseudo
   self-temped into `$s0`; and the sum must be int-typed with the index first
   (`(int *)(i * 4 + (int)hb)`) — a pointer sum canonicalises ptr-first and leaves
   the final `addu s0,v0,v1` vs retail `addu s0,v1,v0`.  8 → 2 → **PASS**.
   `i * 4`, `i << 2` and `(int)(i * 4)` all seal; `i + hb` does NOT (2).

SYM receipt: the 8c block lists only `h`($s4) and `i`($s3), and `mask $803f0000`
(s0–s5 + ra, **no s6**) is direct evidence retail carried no hoisted `&hoff`
pseudo.  Falsified on the way: drop `hp` entirely and inline `hoff[i]` ×3 = 17 ·
`hp` late with one set = 17 · `&hoff[i]` late = 17 · identity fence on the
single-set form = 20 @100 · goto-loop = 26 @94 · 3 sets = 10 · cast-split = 10 ·
fence AFTER the add = 14 · fence on both sides = 14.

## 2. NAMED ANGLES / FALSIFICATIONS (no gate change, receipted in-source)

### 2.1 InGame_GetPSXPadValue 168 — THE +10 COUNT GAP IS SOLVED AND PRICED

The gap is ONE fact at ~10 arm sites: retail MUTATES the per-arm scaled index in
place (`addu aN,aN,v0; lw v1,136(aN)`) — each arm `return`s so the index pseudo is
dead after its own use — while ours preserves the index and mutates the base
(`sll a0,s1,2; addu a0,a0,v0`), one insn more per site.  The in-place rewrite
(`po = po + (int)&GameSetup_gData;` off a pre-switch `po = player * 4;`, arms
reading `((GameSetup_tData *)po)->controllerData.F[0]`) reaches retail's **EXACT
count 233/233** with a count- and offset-exact per-arm stream, and gates 210.
It is WORSE on the authoritative metric because a fn-scope `po` is ONE global
allocno holding ONE register ($a2) at every site, whereas retail's nine
`sll <reg>,$s1,2` (census
`grep -cE 'sll +\$[av][0-9], \$s1, 2$' asm/nonmatchings/main/InGame_GetPSXPadValue__Fii.s`
= 9) land in FOUR different registers ⇒ retail REMATERIALIZES the index per arm
into a fresh BLOCK-LOCAL qty.  **Next angle: per-arm block-local index pseudos
gcc is allowed to clobber** (§3.12 #14 applied to an INDEX, not a base) — not a
hoist.  Also falsified: `po` hoisted before the switch 225 @230 · `po` at the top
225 @230 · OR-tree `player << 0x1e` moved LAST 306 @259 / SECOND 198 @243 (the
front.cpp twin's tag-second rule does NOT extend to the player term).

### 2.2 R3DCar_InsertCarFacetMenu 12 — the w63 named angle is CLOSED

The w63 angle was *"keep the gFlip read as its own earlier statement WITHOUT
letting it absorb the base"*.  The 13B identity launder is the device that
expresses exactly that, and it is falsified in all three placements from the 12
basin (which IS the current basin — the jtbl_at_fusion wiring that sealed the
InsertCarFacet twin is already in): launder the flip OFFSET 39 @1055 · launder
the ROW pointer 39 @1055 · launder the BASE 34 @1054 · plain `flipOff` temp +
index-first byte sum (control) 22 @1054.  ⇒ the base absorption is expand's own
`pointer_int_sum` canonicalisation, not a value-numbering fact a barrier can
break.  Instrument-level next step written in-source (`-dl`: are the gFlip load
and the row address ONE combined {high,lo_sum} qty whose refs local-alloc.c:1973
SUMS?).

### 2.3 CarIO_CreateLicense 30 — residual located, position axis closed

The residual is a 4-slot-early address materialization at the `0x11800` RMW
(oracle `sll t0,s6,2; lui t1; addiu t1; addu t1,t0,t1` … bare `lw t3,0(t1)`; ours
emits the whole lui/addiu/addu at the RMW), plus the $t3/$t4 + $v0/$v1 shift that
follows it.  Count already EXACT 229/229.  Statement-position axis falsified from
the 30 basin: the q1/q2 pair above the clut loop 51 @236 · above the header loop
38 @229 · pair order swapped 36 @229.

### 2.4 DrawC_PrimClip 420 — the dominant residual is now NAMED

The prologue shows a whole-band REGPARM rotation: SYM says
`m=$s0 t=$s4 overlay=$s6 sd=$s1` with block locals `i=$s2 Nvertice=$s3`; ours
puts `t=$s2` and `overlay=$s5`.  That is the 06A "the 8c local list is the
allocation budget" class — PrimClip still carries ~60 flat fn-scope Ghidra locals
(`iVar11`, `Nvertex_p`, `u2`, `vt2_00`, …).  A rule-8 rewrite from the SYM 8c
block is the route; it is a whole-function job, not a dial.
Second class: the z-block ×4 is now count- and offset-EXACT and differs ONLY in
register CLASS (ours `$v0/$v1/$a0`, retail `$t4/$t5/$t6`).  Census
`grep -cE 'lhu +\$t[4-7], 0xD4' asm/nonmatchings/main/DrawC_PrimClip*.s` = 12
(4 sites × 3) and **0 in Prim/PrimMenu** — the §3.25-2 EA expander-template
signature (same reserved $t4-$t7 window as the DRAWC_OTLINK / DRAWC_UVTINT
templates), but a single-function census is weaker than those, so it is FLAGGED,
not assumed; check the id rotation at those sites first.

## 3. CATALOG-ROW CANDIDATES (for the orchestrator)

1. 🔴 **04Z, the hardest case yet: a THREE-WAVE "site-scoped, do not port"
   verdict was basin-relative to a Ghidra INVENTED BIV.**  Before trusting any
   "this lever regresses here" receipt, check whether the fn still carries a
   Ghidra byte-offset induction variable the SYM does not list — the loop shape
   gates every allocator lever downstream of it.
2. **Per-site, never all-at-once**: the same edit applied to all 5 morph sites of
   DrawC_Prim measured 448 (a loss); applied per site it measured −12 / −30 /
   −30 / −30 / +184.  Sweep sites INDIVIDUALLY before concluding a lever is dead.
3. **A void-tail fence AFTER a short store-run is the cure for "ours is N insns
   SHORT and the oracle carries nops"**: sched2 was using the stores as
   branch-delay-slot filler.  Costs exactly the oracle's own nops back and makes
   the block count/offset-exact (PrimClip z-block, −92).
4. **`(u_short)` on a `short[]` global read that is then `<<16 >>16`**: without
   it cc1plus emits `lh` + a load-delay nop and re-sign-extends; retail's `lhu`
   form needs the cast.  Grep class: any `(int)((u_int)<short array>[…] << 0x10)`.
5. **The 15C movable-existence kill + identity launder + use-adjacency +
   index-first int sum is a 4-step LADDER for "ours hoists an address the oracle
   rematerializes"** (SetRamp 13 → PASS).  The SYM `mask` word is the free
   detector: an extra saved register in ours = an extra hoisted pseudo.
6. **A count-EXACT result can gate WORSE than a count-inexact one** when the
   count fix is bought with a global allocno where retail used per-arm block-local
   qtys (GetPSXPadValue 233/233 @210 vs 243/233 @168).  Count-exactness is a
   structural milestone, not a gate predictor.

## 4. FILES TOUCHED / BACKUPS

`recon/game/psx/drawc.cpp` · `recon/game/psx/psxcontroller.cpp` ·
`recon/game/psx/cario.cpp` · `recon/game/common/r3dcar.cpp` (source + in-source
`MATCH:`/receipt blocks).  No `tools/*.py`, no `build.py`, no memory dir, no
user-live TU.  Backups: `scratchpad/w64a14/drawc.cpp.{base,prim174,clip428,ub}`,
`psxcontroller.cpp.base`, `*.iprobebak` (written before every probe run).
Harnesses (all restore-on-`finally`): `iprobe.py` (callable patches),
`probe.py` (string-pair patches), `inspect.py` (apply one variant → chunkdiff →
restore), `apply_test.py` (dry-run byte/line audit of a patch).
Variant files: `vprim1-9`, `vclip1-7`, `vpad1-3`, `vramp-vramp6`, `vlic`, `vmenu`.

## 5. HAZARDS HIT

* 🔴 **A CONCURRENT BELT (w64-a20) EDITS `recon/game/psx/drawc.cpp`** (the ASPSX
  numeric-register dialect sweep).  My whole-file `cp` restore was safe only by
  luck (my snapshot post-dated their edits).  From that point I switched to
  own-hunk staging (`git diff` → filter hunks containing my anchor →
  `git apply --cached`).  **Recommendation: iprobe-style whole-file
  write/restore harnesses are unsafe on a shared TU — snapshot immediately
  before each probe, as `iprobe.py` does, and never restore an older snapshot.**
* 🔴 **A peer's `git add -A` swept my 4 staged `(u_short)` hunks into
  `24f4b993` (w64a19).**  The content is in HEAD and gates correctly; only the
  attribution is wrong.  (Standing rule confirmed again: stage EXPLICIT paths.)
* **Gotcha #1 fired**: a receipt line containing `DRAWC_OTLINK_*/DRAWC_UVTINT_*`
  closed its host block comment — the `*/` inside a comment.  Symptom was a
  cascade of parse errors ~3000 lines away (`TrsProj_SetTransPrecision cannot be
  used as a function`).
* **Heredoc collapse (#N)**: a `<<'PY'` heredoc writing a python variant file
  turned every `\r\n` in a regex literal into a real newline, producing a file
  that "compiled" as python and silently matched nothing.  All variant files
  after that were written with the Write tool.
* **Gate flakiness under concurrent belts**: one probe round reported a bogus
  `parse error before 'if'` at drawc.cpp:488 on a patch that `apply_test.py`
  proved was a 2-line, 18-byte change; a plain retry gated fine.  Retry before
  believing a compile failure while other belts are building.
