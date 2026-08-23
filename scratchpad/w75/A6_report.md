# W75-A6 draww-B belt report (2026-08-23)

TU: `recon/game/psx/draww.cpp` (unit `game/psx/draww`). Shared working copy with belt A5
(kCtrlSkidmark / BuildSpikeBelt / SubdividFacet) -- all A6 edits are scoped to A6 functions.

## HEADLINE

| fn | baseline | final | note |
|---|---|---|---|
| `DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo` | 6 @189/189 | **PASS 189** | SEALED, gated 3x + production lane REAL=0 RELOP=0 |
| `DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi` | 16 @200/200 | **6 @200/200** (posmis 7) | class (A) half-closed: registers now retail-exact, only 2 load slots left |
| `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` | 9 @358/359 | 9 (unchanged) | 3 new falsifications, the ask sharpened |
| `DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache` | 66 @507/507 | 66 (unchanged) | 1 new falsification bounding the "second biv" ask |

TU gate: **28/35 -> 29/35 PASS**, gated twice after each landing and twice at the end.
**ZERO PASS->FAIL** anywhere (A5's three fns re-gated at every step: 8 / 20 / 30 throughout,
their own in-flight numbers, never regressed by an A6 edit).
No build.py rows added (orchestrator policy acknowledged: no post-recompile rewrites).
No `register ... asm("$N")` pins. Devices used are the established zero-insn source-side classes only.

## LANDED 1 -- DrawW_BuildObjectFacets 6 -> PASS  (a THREE-PART JOINT CELL, 23B(1))

```c
{ int zo = objInstance->zoffset;
  signed char *g;
  __asm__("" : : "i"(0));              /* volatile = sched + reorg barrier */
  g = goffsets;
  __asm__("" : "=r"(g) : "0"(g));      /* non-volatile tied launder = 2nd SET */
  objectOffset = *(signed char *)(zo + (int)g); }
```

### THE MECHANISM THE PRIOR SIX WAVES MISSED (w50/w51/w61/w62/w74 all chased the wrong pass)

The banked verdict was "find_free_reg WINDOW" (w50-w62) and then "post-sched1 BIRTH ORDER"
(w74). Both are wrong for this residual: **the goffsets address qty never reaches local-alloc
at all -- loop.c HOISTS it out of the object loop and reload rematerializes it at the use.**
Proof, read off the real compiler (`CC1PLPSX -O2 -G4 -dL`, dump kept at
`scratchpad/w75/A6_draww.loop`):

```
Loop from 105 to 500: 141 real insns.
Insn 161: regno 115 (life 3), move-insn savings 2  moved to 521
Insn 162: regno 114 (life 2), move-insn forces 161 savings 1  moved to 523
```

and the corresponding post-sched1 chain (`scratchpad/w75/A6_draww.sched`) shows insns 523/524
(`high`/`lo_sum` of `goffsets`) sitting in the **preheader block**, not in the arm. In the
preheader the pseudo competes for a callee-saved reg, all nine are taken, so it gets none and
reload rematerializes `lui $t0 / addiu $t0` at the use -- that is the whole `$t0`-vs-`$v1` diff.
Gate: `move_movables` at `loop.c:1640`, `threshold*savings*lifetime >= insn_count` with
insn_count 141; the movable exists at all only because `n_times_set == 1` (`loop.c:779`).

**The launder kills the movable** (a second SET), the address becomes block-local, and
local-alloc hands it retail's `$v1` for free.

### device-removal re-test (23B(3)), every part priced alone
| shape | gate |
|---|---|
| void fence only (no pointer local, no launder) | 10 @189 (still hoisted) |
| void fence + pointer local, no launder | 6 @189 (still hoisted) |
| void fence + launder, subscript `g[zo]` | 2 @189 (addu operand order only) |
| void fence + launder + index-term-first cast | **PASS** |

The 12D index-term-first cast (`(int)zo + (int)g`) is what flips `addu v0,v1,v0` to retail's
`addu v0,v0,v1`; w61-a2 falsified that exact spelling **in the hoisted basin** -- 21E(1)
re-pricing after a basin change was the whole difference.

Production lane: `python tools/psyqproof.py recon/game/psx/draww.cpp DrawW_BuildObjectFacets__...`
-> `189 words (-G4), REAL=0 RELOP=0` (17 reloc sites).

## LANDED 2 -- DrawW_BuildCustomObjectFacets 16 -> 6, count-EXACT 200/200

```c
{ int zo = objInstance->zoffset;
  __asm__("" : "=r"(zo) : "0"(zo));    /* +2 refs on the INDEX qty, zero insns */
  tc5 = objInstance->type;
  objectOffset = *(offsets + zo); }
```

Here the address is **not** hoisted (the loop-top void fence suppresses it), so both the address
and the index are block-local qtys and the question is which is allocated first. The banked
verdict (w72/w74) was again "birth order"; the real dial is **QTY_CMP_PRI**
(`local-alloc.c:1665`, `floor_log2(refs)*refs*size/live`): +2 refs on the index qty lifts it
above the address qty, so the index is allocated first and takes `$v0` by find_free_reg's
ascending scan -- exactly retail (`addr=$v1`, `index=$v0`, and `li $v1,5` reusing the address's
register afterwards). All 7 register diffs of class (A) are gone; the 6 that remain are
4 emission-slot diffs of the two byte loads + the 2 known class-(B) `lh s2,32(s4)` trade diffs.

**Position is load-bearing**: the launder must sit BEFORE the `tc5` load (after it: 17 @201).

### NEW LAW (gcc-source-cited) -- why a VOLATILE fence is the wrong tool here
`sched.c:1985` (`ASM_OPERANDS` with `MEM_VOLATILE_P`): a volatile asm takes a dependence on
**every** prior set and calls `flush_pending_lists`, and sets `reg_pending_sets_all`. The
consequence for every later insn in the block is asymmetric: a pure **register-setter** gets a
`REG_DEP_OUTPUT` link on the fence, a **memory reader** gets a plain data (kind 0) link. Then
`rank_for_schedule`'s class test (class 2 beats class 1) puts the `lui` AHEAD of the `lbu`
**unconditionally**. That is precisely what this fn's loop-top void fence does, and it explains
every failed read-only-fence / barrier-position probe on record for this site. A **non-volatile
tied launder buys the refs without the dependence storm** -- that is the whole trick.
=> catalog row: *volatile fence = a sched ORDER dial (class test); non-volatile tied launder =
a +2-ref PRIORITY dial. They are different instruments; pick by which pass owns the residual.*

### falsified this wave at this site (all re-gated, all reverted)
| shape | gate |
|---|---|
| plain `int zo` split / index-term-first cast / both | 16 (no move) |
| pointer local `signed char *g = offsets` (no launder) | 70 @200 (loop.c hoists it, reload remats into `$t2`) |
| pointer local + opacity launder | 20 @202 |
| loop-top void fence DELETED | 17 @199 |
| loop-top fence -> non-volatile launder on `objInstance` | 16 |
| loop-top fence moved after `tc5` / after the lookup | 17 @201 / 20 @200 |
| `zo` + opacity launder AFTER the `tc5` load | 17 @201 |
| launder on `tc5` (either position) | 11 @201 / 11 @203 |
| volatile fence before the lookup (after `tc5`) | 13 @201 |
| class (B) re-price on BOTH new bases (21E(1)) | 44 / 45 -- the `lh s2,32(s4)` trade STANDS |

### NEXT ANGLE (crisper than before, recorded as `scratchpad/w75/d10.json`)
Adding a laundered pointer local for the address on top of the above gives **5 @201** with
retail's exact emission order (`lui/addiu/lbu(zoffset)`) and retail's registers; the only defect
is that retail fills the `lbu $v0,4($s4)` load-delay slot with the `lbu $a0,2($s4)` type load
while ours emits it after `li $v0,5` and pays a `nop`. **One sched2 slot from count-exact and
from PASS-modulo-class-(B).** I landed the count-exact 6-diff form instead (count invariant
first); the 5-diff basin is one `python scratchpad/w75/A6_probe.py scratchpad/w75/d10.json ...`
away for the next belt.

## DrawW_DoTrough -- 9, unchanged; the ask is now bounded from both sides

Residual is the two documented axes: (a) the prologue parm-copy position (4 diffs), (b) the
`sd->doublelayer = 1` cse-shared constant (5 diffs; ours is ONE INSN SHORT because retail mints
a fresh `li $v0,1` where we reuse `$s7`).

New measurements (the "REF-LOWERING COMPENSATION" idea: pay for the +2-ref opacity fence by
removing in-loop refs so gteFlag keeps its rank):

| shape | gate |
|---|---|
| opacity fence on `gteFlag` only | 52 @359 |
| fence + 1 in-loop use rewritten to the literal `1` | 41 @360 |
| fence + 2 in-loop uses rewritten | 30 @361 |

Monotone trade: every 2 refs bought costs exactly ONE INSN (each literal materializes its own
`li` before loop.c can merge them), and the 4-literal end of the ladder is the already-banked
26 @359 shape whose hoisted movable is QImode (pri .0513, unreachable vs buildInd's .2090).
**The ask therefore stands verbatim: a cse constant-sharing breaker that is zero-REF, not merely
zero-insn.** The two devices this wave characterised are explicitly NOT it (launder = +2 refs;
volatile fence = no cse effect at all, `cse.c:1999` only sets `do_not_record`).
The brief's "init-position as a live dial" is answered: with the fence, moving `gteFlag = 1`
among the init statements buys at most ~2 luids (measured 48/50/54 at positions 1/2/3 in prior
waves) where the rank needs ~+5 -- the live axis cannot pay for the ref axis here.

## DrawW_OnyxLinePrim -- 66, unchanged; one falsification that bounds the named angle

The standing angle is "a SECOND REAL BIV so combine_givs has two iv classes". I tested the
**opposite** bound -- killing biv-ness entirely with one opacity launder on `geomVertices` (a set
that is not `reg = reg + invariant`, so loop.c cannot classify it as a biv):
**190 diffs @501/507, SIX INSNS SHORT.** That is the giv machinery's own cost measured directly:
retail definitely strength-reduces here, so the launder is not a shortcut to the second-biv shape
and must not be re-tried. The second-biv construct (companion pointer with its own `+= 2` at both
advance sites) remains the only named route; unattempted this belt for budget reasons.

## PROCESS NOTES / HAZARDS

1. **The shared working copy cost one landing.** My first BuildObjectFacets edit was written into
   `recon/game/psx/draww.cpp` and then **silently clobbered** by the concurrent A5 session's
   whole-file write ~90 s later (the file was also transiently brace-unbalanced / non-compiling
   during their write). Recovered by re-applying. **Mitigation adopted, recommend it as a fleet
   rule:** probe against a PRIVATE snapshot (`git show HEAD:<tu> > scratchpad/w75/A6_base.cpp`)
   via a runner that copies snapshot -> a temp sibling TU -> gates -> **deletes the temp TU in a
   `finally`** (`scratchpad/w75/A6_probe.py`, `A6_SRC=<snapshot>`), and touch the shared file only
   for the final landing edit, immediately re-reading it first. A probe TU left in `recon/**` is a
   duplicate-symbol hazard for anyone running `build.py` (it rglobs `recon/**/*.cpp`).
2. rtl dumps are at the fixed `scratch/rtl/` path; copies preserved as
   `scratchpad/w75/A6_draww.{sched,loop,i}` before any further dump.
3. Receipts for all of the above are written into the TU's own comment blocks at the four
   functions (that is where the next belt will look).

## ARTIFACTS

- `scratchpad/w75/A6_probe.py` -- snapshot-based probe runner (`A6_SRC` env, `sbs` 3rd arg)
- `scratchpad/w75/A6_base.cpp` -- private HEAD snapshot used for probing
- `scratchpad/w75/A6_draww.{loop,sched}` -- the `-dL` / `-dS` dumps quoted above
- `scratchpad/w75/{e1..e7,b1..b8,c1..c6,d1..d21,t1..t3,o1}.json` -- every probe, replayable
- `scratchpad/w75/A6_bof_{sbs,p1,p2}.txt`, `A6_bcof_{b3,d3,d10}.txt` -- side-by-side listings
