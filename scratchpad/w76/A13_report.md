# W76-A13 -- night + overlays belt (NFS4-PSX matching decomp)

Repo `C:\Temp\nfs4-decomp`, shared clone. No commits/stage/push; `tools/build.py` never
opened for writing; memory dir read-only. STEP 0 done (ISA ref full, methodology, BRIEF,
W75 A13 receipt, catalog secs 20-24). Concurrent-session edits to OTHER night.cpp fns
observed mid-belt and preserved (gates run against the live file).

## RESULT (headline)

| fn | TU | baseline | final | count | note |
|---|---|---|---|---|---|
| `Night_CreateNightTableElement__FiliPUc` | game/psx/night | 26 | **26** (tree) / **PASS 113/113 under 2.8.1-splice** | 113/113 | SOLVED, ships pending splice-lane wiring |
| `RaceStatistics__Fv` | game/psx/overlays | 71 @474 | **70 @475/475 COUNT-EXACT** | first count-exact landing | col1 copy MINTED + landed |

TU gates, all run TWICE: `night.cpp 18/19 PASS` (unchanged; edits receipt-only),
`overlays.cpp 4/5 PASS` (71 -> 70). **ZERO PASS->FAIL anywhere. No pins (PIN-SEALED: none).
No post-compile mechanisms. No probe TU left behind.**

---

## 1. Night_CreateNightTableElement -- SOLVED (PASS recipe banked); W75 provenance UPGRADED; W72 splice ledger VACUOUS

### (a) TRUE PROVENANCE (supersedes W75's walk-internal reading)
The 2.8.0-vs-2.8.1 delta is NOT inside distribute_notes' walk (that code is identical in
both). It is the CALL SITE: 2.8.0's try_combine passed `NULL_RTX, NULL_RTX` for
elim_i2/elim_i1 at the **i3dest_killed** REG_DEAD distribution; the fix is ChangeLog
**Fri Feb 6 1998 (Kenner): "combine.c (try_combine): Pass elim_i2 and elim_i1 to
distribute_notes for i3dest_killed REG_DEAD note"** (inside the Jan-7-2.8.0..Mar-2-2.8.1
window; W75 cited the two Feb-12/14 body entries, which are not the operative change).
Mechanism, fully cited: try_combine(i3=insn 196 `137 &= 0xFF00FFFF`, i2=insn 190
`137 = 139|143` = the accumulator's birth) folds the self-use away; i3dest_killed=137;
elim_i2 = i2dest = 137 (combine.c:2189, full 2->1 merge). 2.8.1: distribute_notes
discards at `note==elim_i2 -> break` (:11282) -> place 0 -> `REG_N_DEATHS--` (:11535-38)
-> deaths 1 -> local-alloc eligible -> $a0 = retail. 2.8.0: no elim args -> the backward
walk runs, stops at code_label 139, emits the orphan USE (:11397-11401) -> deaths 2.
Verified in both W75 dumps (2.8.0 psyq_comb.txt insn 320; 2.8.1 i281_comb.txt clean) +
fresh flow/combine dumps (`scratchpad/w76/A13_night_{flow,comb}.txt`).

### (b) THEOREM -- the source axis is closed BY CONSTRUCTION (upgrades W75's 160+ measured cells)
On 2.8.0 the minted note has NO good outcome: a *successful* walk placement ALSO leaves
REG_N_DEATHS==2 (only the place==0 discard decrements, and 2.8.0 never reaches the elim
discard). The orphan fires whenever combine merges the accumulator birth into the first
SURVIVING self-mask -- which every >=3-field by-value byte-aggregate build produces (the
first acc-mask folds in cse by AND-chain association; every later one sits over an IOR
and survives to combine). Hence the W76-brief angles (a) label-move and (b)
same-block-death are DEAD BY CONSTRUCTION, not merely unmeasured. Confirmed empirically
with A20's newly built instrument: `GCC_TRACE_DISTRIBUTE_NOTES=2` on this TU's .i under
instrumented 2.8.1 = **ZERO trace lines** (the note never enters the walk;
`scratchpad/w76/A13_night_dn.txt`, reproducing A20's `a20/night_dn_trace.txt`).

### (c) TOOL DEFECT -- the W72-A14 cc1plus-splice harness gated VACUOUSLY (ledger impact)
`scratchpad/W72_A14/cc1pl_splice_probe.py` builds the spliced object, then execs
tools/verify_asm.py -- which re-imports build.py FRESH (module_from_spec ignores the
monkey-patch) and RECOMPILES the TU (compile_cpp has no cache), overwriting the spliced
object. **Every W72 Finding-3 "SPLICE" cell measured the UNSPLICED build** (that is why
they all equalled the no-splice numbers and read "inert"). Fixed harness:
`scratchpad/w76/A13_splicegate.py` (substitutes verify_asm's compile line with the
pre-built object + SPLICE-NOOP guard). Ledger consequence: any other belt that used the
W72 harness must re-run (grep for cc1pl_splice_probe consumers).

### (d) TRUE splice table (fixed gate, x2 stable) => PASS RECIPE
| cell (2.8.1 cc1plus whole-fn splice) | gate |
|---|---|
| shipped source | **16** (W72 said 26 "inert" -- wrong) |
| r,g,b natural order, read-back removed | **20** (W72 said 56; residual = region A exactly: b15<->newR a2/a3 + parm-spill slide) |
| ... + sourceB fence removed | 20 (the W55 fence is 2.8.1-inert) |
| ... + 1-op newR fence after the newR clamp | 3 @114 (fence barrier blocks the chg mult slot fill -> nop) |
| ... + tied launder on newR | 8 |
| ... + `__asm__("" : : "r"(newR));` at the OLD fence position (sourceB fence deleted, read-back deleted) | **PASS 113/113** (x2) |
Same PASS source on the default 2.8.0 lane = 56. Spec: `scratchpad/w76/A13_c4.spec`.
The PASS source is MORE faithful than shipped (SLD-natural r,g,b store order per SLD
206-208, no read-back device, one 1-op fence; mechanism: +1 ref lifts newR 4->5 refs,
pri .33->.42, above b15's .33 tie -> newR allocates first -> $a2 = retail).
=> the pending USER DECISION (wire a per-fn cc1PLUS ver-splice lane in compile_cpp +
rule on the FSF-built 2.8.1 stand-in) is now a decision about a **proven full seal**,
not a convenience. When wired: apply A13_c4.spec verbatim + the splice row -> seal.
Receipts written into night.cpp (W76-A13 block). Tree source unchanged (26 stays;
landing the c4 source without the splice would regress 26->56).

### For A20 / the trace owner
On pristine 2.8.1 the Night orphan CANNOT reproduce (discarded upstream of the walk at
:11282). To reproduce vendor-2.8.0 behavior the instrument needs an env-gated
`NULL elim_i2/elim_i1` at try_combine's i3dest_killed call (combine.c:2356-2359) --
a one-line 2.8.0-compat switch, cheaper than the "2.8.0-source lab" A20 marked
non-existent.

---

## 2. RaceStatistics -- 71 -> 70 @475/475 COUNT-EXACT (landed); col1 copy cracked

### (a) THE COL1 COPY IS A CROSS-CALL COMBINE REFUSAL (SLD-proven, source-cited)
Retail's one extra insn (`addiu v1,s4,10; addu s6,v1,zero`) carries TWO source lines in
the SLD: the add = **SLD:186** (before the titleX statement's two calls at SLD:188), the
copy = **SLD:198** (after HOTPURSUIT_Y at SLD:194). combine.c:936-941 refuses any merge
whose i2 sits before the last CALL_INSN (`INSN_CUID (insn) < last_call_cuid &&
! CONSTANT_P (src)`), so the pair survives combine; sched1 then sinks the add next to
its use (temp live range 1 insn -> $v1 = retail). Every w41..w75 col1-temp cell failed
because it was call-adjacent (both halves on one side of the calls -> merged).
LANDED as the `colX` two-statement straddle (value computed before titleX, `col1 = colX;`
after HOTPURSUIT_Y): **71 @474 -> 70 @475/475, first count-exact landing in any basin**,
col1 cluster byte-solved. MATCH receipt at the colX assignment; W76-A13 block appended
to the fn's receipt stack. Fresh dumps: `scratchpad/w76/A13_ov_{flow,comb}.txt`
(ours pre-landing: expand emits add+subreg-copy adjacent, combine merges to
`addiu s6,s4,10`).

### (b) W75's "carlist is downstream of the col1 copy" hypothesis REFUTED
With the copy minted and the count exact, all four `Cars_gHumanRaceCarList`
materializations are UNCHANGED (`lui/addiu $t1` = reload spill scratch vs retail's
allocated $v0/$v1). Mechanism localized: ours = ONE cse-shared pseudo (261) LICM-hoisted
to the outer preheader (combine dump insns 1403/1404), denied a reg by global_alloc
(long range, 40+ calls) -> REG_EQUIV remat per site via the reload pool cursor. Retail =
four per-region SHORT-LIVED las in block-local qtys. Swept and falsified this wave:
per-region NAMED base pointers `Car_tObj **hbN = Cars_gHumanRaceCarList;` x4 = 68 @475
but sites unchanged (**constant-equiv remat is name-blind**: cse copy-propagates the
symbol constant through the named local; reg_equiv_constant drives remat identically) --
NOT landed (non-SYM noise for -2). `rows` re-priced from the 70 basin: 72 @475, still a
net loss. **ROTATION CHECK (the brief's named angle): the oracle's outer loop ends
`j T; addiu s7,s7,1` = UN-rotated, identical to ours** -- rotation is NOT the
discriminator; 22A-2/23A-3 do not separate the builds here. How retail's source kept the
four las per-region block qtys (i.e. what defeats cse path-following + combine_movables
merging on identical symbol las) is the REMAINING NAMED QUESTION for the cluster.

### (c) -G ladder
Already honestly closed by W75 with the FIXED gprobe (baseline 71 . g8 bit-identical .
g0 215 . nosplit 598 . g8+nosplit 598) -- not re-run; the landing is orthogonal
(default lane, no flag change).

### Residual anatomy at 70 (sizes)
~18 carlist remat registers (above) . ~25 head/prologue (interleave `li a1,150 / sw s7 /
li s7,160 / sw s2 / li s2,1` + a0/a2/v1/a1 band + the `li t1,52` rows-fold) . 6 fp<->s1
(W75 (5): allocsim MATCH, not priority-reachable) . position slides.

---

## 3. Files / artifacts

* LANDED: `recon/game/psx/overlays.cpp` (colX straddle + decl + 2 receipt blocks),
  `recon/game/psx/night.cpp` (receipt blocks only).
* New tool: `scratchpad/w76/A13_splicegate.py` (non-vacuous cc1plus-splice gate; promote
  to tools/ if the splice lane is wired).
* Protected artifacts under `scratchpad/w76/`: `A13_c4.spec` (the PASS recipe),
  `A13_rgb.spec`, `A13_rs1.spec` (the landed straddle), `A13_rs2/rs3.spec` (falsified),
  `A13_night_{flow,comb}.txt`, `A13_ov_{flow,comb}.txt`, `A13_sg_*.txt` (true splice
  cells), `A13_splice_*.txt` (the vacuous-harness runs, kept as the bug receipt),
  `A13_rs_sld.txt` (the SLD map that cracked col1), `A13_night_dn.{txt,s}` (instrument
  certificate), `A13_rs1_full.txt`, `A13_rs3_full.txt`.

## 4. Catalog candidates (for the harvest)

1. **elim_i2/i3dest_killed law (24E-6 COMPLETED)**: the 2.8.0 orphan-USE class is the
   MISSING elim_i2/elim_i1 args at try_combine's i3dest_killed distribute_notes call
   (fixed Feb 6 1998); on 2.8.0, birth+first-self-mask merges ALWAYS cost the
   accumulator its local-alloc eligibility (placement or orphan, both = deaths 2);
   fires for every >=3-field by-value byte-aggregate. Cure = 2.8.1 lane only.
2. **CROSS-CALL COPY MINT (new row, 24C family)**: an oracle `<op> rT,...; addu sN,rT,zero`
   pair whose halves carry DIFFERENT SLD lines with a CALL between them = combine.c:941's
   cross-call refusal; reproduce with a two-statement split straddling the call
   (value-statement before, assignment after); sched1 sinks the def so the temp stays
   caller-saved. Check the SLD lines of the pair FIRST -- call-adjacent temp spellings
   can never mint it.
3. **Vacuous-gate class (13F/24F)**: any harness that execs verify_asm after building a
   patched object measures the UNPATCHED build (verify_asm recompiles via its own fresh
   build import). Sub-case of the gprobe bug family; audit every monkey-patch harness.
4. **Name-blind remat**: naming a link-constant-valued local does NOT stop
   reg_equiv_constant remat (cse copy-props the constant through the VAR_DECL); a named
   base pointer is NOT a device against the reload-scratch class.
