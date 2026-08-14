# W60-A7 receipts — game/psx draw/IO belt (FAIL grind)

Repo: C:\Temp\nfs4-decomp · gate: `python tools/verify_asm.py <tu> <MangledName>` · diff polarity `-`=ours `+`=oracle.
HEAD at start: 43150145.

## RE-GATED BASELINES (mine, 2026-08-14, after full `build.py --skip-asm`)

| TU | fn | briefed % | my baseline diffs |
|---|---|---|---|
| psxcontroller.cpp | InGame_ResetPSXController__Fii | 99.46% | 3 |
| psxcontroller.cpp | InGame_SetRamp__Fv | 91.56% | 13 |
| psxcontroller.cpp | InGame_GetPSXPadValue__Fii | 66.14% | 264 |
| cario.cpp | CarIO_CopyToShape__FPsT0i | 99.64% | 2 |
| cario.cpp | CarIO_CreateLicense__FPcii | 95.48% | 78 |
| cario.cpp | CarIO_ReadInCarTextureData__FPcP8Car_tObjii | 99.09% | 184 |
| flare.cpp | Flare_2DHalo__Fiiiii | 99.08% | 6 |
| flare.cpp | Flare_LensFlare__FP7DVECTORP15Draw_FlareCache | 97.33% | 18 |
| sfx.cpp | Sfx_AdditivePrim__... | 97.82% | 26 |
| sfx.cpp | Sfx_BuildSouffleFacet__... | 98.09% | 116 |
| overlays.cpp | Hud_BTCStats__Fsb | 99.03% | 24 |
| overlays.cpp | RaceStatistics__Fv | 93.65% | 94 |
| draww.cpp | DrawW_BuildObjectFacets__... | 98.86% | 6 |
| draww.cpp | DrawW_DrawQuad__... | 99.31% | 7 |
| draww.cpp | DrawW_DoObjects__... | 92.79% | 30 |
| draww.cpp | DrawW_SubdividFacet__... | 98.94% | 35 |
| draww.cpp | DrawW_BuildChunkObjectFacets__... | 96.12% | 42 |
| draww.cpp | DrawW_BuildSpikeBelt__... | 95.13% | 66 |
| draww.cpp | DrawW_DoTrough__... | 92.14% | 86 |
| draww.cpp | DrawW_OnyxLinePrim__... | 98.36% | 101 |
| draww.cpp | DrawW_BuildCustomObjectFacets__... | 89.44% | 110 |
| draww.cpp | Draw_kCtrlSkidmark__... | 91.07% | 303 |
| drawc.cpp | DrawC_PrimMenu__... | 99.93% | 2 |
| drawc.cpp | DrawC_NightHeadlight__... | 97.36% | 4 |
| drawc.cpp | DrawC_PrimStart__... | 97.42% | 54 |
| drawc.cpp | DrawC_Prim__... | 96.82% | 338 |
| drawc.cpp | DrawC_PrimClip__... | 95.50% | 552 |

Whole-TU baselines: psxcontroller 1/4, cario 8/11, flare 25/27, sfx 5/7, overlays 3/5, draww 25/35, drawc 15/20.

## FINAL (all re-gated twice, whole-TU, after every landing)

| TU | before | after |
|---|---|---|
| psxcontroller.cpp | 1/4 | 1/4 |
| cario.cpp | 8/11 | **9/11** |
| drawc.cpp | 15/20 | **16/20** |
| draww.cpp | 25/35 | 25/35 |
| flare.cpp | 25/27 | 25/27 |
| sfx.cpp | 5/7 | 5/7 |
| overlays.cpp | 3/5 | 3/5 |

SEALS: CarIO_CopyToShape (2 -> PASS 42/42) · DrawC_PrimMenu (2 -> PASS 480/480).
REDUCED: Flare_LensFlare 18 -> 6 (count-exact 409/409) · DrawC_Prim 338 -> 336.
Commits: 7817e1c7, 6d4c42dc, f3630c63, 9d6962d6, 93a58bf4.

## NEW LAWS (catalog candidates)

1. **BIV-vs-ELIMINATED-BIV PREHEADER GROUP** (DrawC_PrimMenu seal, transferred to
   DrawC_Prim). A raw `char *` cursor walked with an explicit `p = p + K` is a **BIV**:
   its initialisation is an ordinary source statement emitted in the preheader BEFORE
   loop.c runs, i.e. ahead of every hoisted invariant. Declaring the REAL typed struct
   walker (`Draw_CarVertex *`, stride 8) and writing `p->field` lets loop.c fold the
   stores onto ONE address giv, **eliminate the biv**, and emit that giv's init in the
   **giv group** (after the hoisted invariants). *Symptom row:* an `addiu rN,base,OFF`
   cursor init that is count-exact but sits in the WRONG preheader slot; source position
   of the init statement is a no-op against it (measured 3 positions + a `(char*)sd+OFF`
   spelling, all identical). *Where to look:* any recon byte-cursor with a literal
   `+ <struct size>` walk.
2. **IN-PLACE MUTATION + NAMED COPY shortens a qty and un-rotates the low band**
   (CarIO_CopyToShape seal). `n3 = pixel3 >> 12;` as a fresh temp keeps `pixel3`'s qty
   alive to the last consumer -> long live range -> low QTY_CMP_PRI -> allocated late
   ($a1). `pixel3 = pixel3 >> 12; n3 = pixel3;` ends pixel3's own range at the shift and
   gives n3 a short-lived qty of its own -> retail's handout ($v1). The named COPY is
   load-bearing: dropping `n3` and using `pixel3` directly (either `= pixel3 >> 12` or
   `>>=`) measures 16.
3. **SWEEP DIAL PAIRS JOINTLY, INCLUDING THE TERM'S *SHAPE*** (CopyToShape again). A
   576-cell joint sweep of {assignment order} x {`|` operand order} had certified a
   STRONG floor; the winning cell varies neither order but the SHAPE of one term. A
   joint sweep over the wrong two axes is not a joint sweep.
4. **SINK THE SECOND STORE OF A PAIR AS A RE-READ, KEEP THE DEF FIRST** (LensFlare
   18 -> 10). `pt[2].vx = pt[0].vx = v;` -> `pt[0].vx = v; ... pt[2].vx = pt[0].vx;`
   reproduces retail holding the value in a callee-saved reg across an intervening
   chain. A named temp for the same job flips which of two sibling values is defined
   first and costs 40; the re-read does not.
5. **LEVER-ORDER, 2 fresh instances.** LensFlare: the w50/w59 "col at its use site"
   receipt measured inert at all 7 positions in the 18-basin and became a -4 lever the
   moment the two x stores were sunk. ResetPSXController: 4 devices that were dead in
   earlier basins stayed dead, but the mechanism reading changed completely.

## PART 2 (coordinator resume) — THE INSTRUMENT LANE

Baseline re-confirmed after the tree moved: psxcontroller 1/4, cario 9/11,
drawc 16/20, draww 25/35, flare 25/27, sfx 5/7, overlays 3/5 (all unchanged).

**Lane built without touching `tools/build.py`:** `scratchpad/w60a7/lab.sh`
(cpp via `tools/rtl_dump.py`'s exact build.py recipe -> real CC1PLPSX AND the
instrumented `cc1plus-ecoff` with `-mgas -msplit-addresses -funsigned-char
-fno-exceptions -fno-rtti`, `GCC_TRACE_ALLOC=1`, Windows TMPDIR/TMP/TEMP with a
trailing backslash, per-config `.i` copies) + `scratchpad/w60a7/cmpfn.py` (the
per-function IDENTICAL/DIFFERS fidelity gate).

### SEAL: `Sfx_AdditivePrim` 26 -> PASS 126/126 (`e8c5ffd5`)
A multi-wave "STRONG floor" (5 waves, ~30 falsified spellings). Lab fidelity
IDENTICAL 120/120, so the trace is a receipt.
`[qty_combine] pseudo 145 merged into qty 4 of pseudo 130` named the whole
thing: insn 287 was `(set 145 (plus (palette) (otz*4)))` with both inputs dead
and local-alloc ties the dest to the FIRST operand, so the site-2 address
inherited the palette's qty (6 refs/38 life = 3157, ranked first -> `$a0`).
Retail's `addu $a0,$a0,$a2` has the INDEX first, the address inherits the otz
chain, and the palette survives as its own 3-ref qty (3/17 = 1764 off retail's
own insn spacing) -> `$a2`. **Fix = a JOINT dial pair**: an INT-typed index-first
sum (a pointer sum is canonicalised ptr-first — the W50 law) **plus** `l0` and
the packet-cursor bump moved below the OT read via a `w` temp (retail's own
statement order, which keeps `$v0`/`$v1` busy so the short site-2 address takes
`$a0`). Control 26 · (1) alone 42 · (2) alone 26 · together PASS.

### `DrawW_DrawQuad` 7 — a standing claim REFUTED (`b7491143`)
Fresh dump of the LANDED basin: sd p80 62refs/844live = 1.4692, prim p141
24/358 = 1.0726 — **sd already out-ranks prim with zero extra references**; the
w53 "+66 refs" was priced in the if/else basin only. And w53's *"the
live-length route and the register it needs are MUTUALLY EXCLUSIVE — holding
prim live to the end denies `$s1` to zeroTransFlag"* is **false**: prim is live
358 in the landed form and zeroTransFlag is not in the residual. The 7 diffs
are the ARM SHAPE alone. Re-priced for the if/else form (prim live -> 114 =
3.368): sd alone +57 refs, prim alone −11, but the **joint** cell is prim
24->15 with sd 62->64 = **−9 and +2** — never tried.

### `Flare_2DHalo` 6 — the named untried instrument, run (`b7491143`)
Lab fidelity IDENTICAL 247/247. All seven global allocnos match retail's
register (pt->$s3, otz->$s4, x->$s5, y->$s6, scalex->$s0, scaley->$s1,
sd->$t0), so residual (A) is not an allocation question at any layer — sched2
places an already-correct `sw $s3` three slots late. The PER_FN
prologue-save-order splice named in w51 is the right and only route; no further
source dial should be spent here.

### `Flare_LensFlare` 6 — the lane does NOT apply (fidelity negative)
Under the lab this fn is 396/396 but **NOT identical** (diverges at insn 243).
It is in the ~6% Mode-A-divergent set, so its trace must not be quoted — while
its TU-mate `Flare_2DHalo` IS identical, i.e. **divergence is per-function, not
per-TU**. Recorded in-source so nobody re-derives a false receipt.

### BIV-preheader sweep (coordinator item 4)
`DrawC_Prim`'s world->cache vertex copy converted to `DrawC_PrimMenu`'s sealed
loop-2 shape (`0f83a309`): six Ghidra-invented locals (an INT cursor walked +8,
a short* cursor walked +4, a third walked +3, three temps) replaced by the two
the SYM names. Gate-NEUTRAL 336 at unchanged count — landed for faithfulness.
`DrawC_PrimClip`'s envmap twin measures 552 -> 566 and was NOT landed (re-probe
after its block-order work).

### CORPUS CHECK (user directive, read-only; cited in-source)
- **rage-racer**: its terrain/prim submission is **hand-written asm in their own
  tree** (`src/main/PAL/main/render/terrain_submission.c` = three `INCLUDE_ASM`
  blocks with a HANDWRITTEN_ASM rationale), so the corpus offers **no C shape**
  for the DrawW/DrawC prim-builder class. Its matched C packet code
  (`render/draw_packet_queue.c` `QueueDrawModePrim`) only re-confirms the
  already-recorded `pkt = prim; prim += N; AddPrim(ot, pkt);` order.
- **silent-hill**: `src/maps/unk_draw_m1s05.c` writes packet colour/UV words
  exactly as we do (`*(u32*)&(*poly)->u0 = ...`), confirming the word-store
  shape; but it reaches the packet through a **pointer-to-pointer**, which would
  make our `prim` a memory object with no allocno at all — removes it from the
  DrawQuad tie *and* from `$s1`, so not the shape here.
- Net: a genuine NEGATIVE for this belt, recorded so it is not re-searched.

## PER-FN LOG

- **CarIO_CopyToShape 2 -> PASS 42/42** (7817e1c7). Law 2+3 above. Falsified from the
  2-basin: plain `n0|n1|n2|n3` 16 · every parenthesisation of the 4-term `|` 14-22 ·
  accumulator statement forms 43-51 (drop an insn) · `+` for `|` 20 · `(int)pixel3` 16 ·
  `(pixel3 & 0xf000) >> 0xc` 16 · n3 assigned first 12 · n3 inline in the chain 16 ·
  no-n3 pixel3-direct 16 (both `= pixel3 >> 0xc` and `>>=`) · read-only fences on pixel3
  x1/x2/x3 after n3 15/15/31 (+3 insns) and after the load 22 · opacity fence on n3 20 ·
  3-operand fence on n0/n1/n2 22.
- **DrawC_PrimMenu 2 -> PASS 480/480** (6d4c42dc). Law 1. Falsified: cursor init moved
  before `i =`, before the two gte_Set macros, and spelled `(char *)sd + 215` (all 2);
  storing `.v` before `.u` 6.
- **Flare_LensFlare 18 -> 6, count-exact 409/409** (f3630c63). Law 4 + the col-store
  hoist. Falsified from the 18-basin: sinking the DEF as well (one expression) 40, the
  expression written twice 40, a named `xm2` temp with late stores 40, col-store-first
  alone 40, x+3 before y-2 18, sinking the y-2 pair too 22, reread position variants 16
  x3. From the 10-basin: col store at every other position 10, col literal inline 10.
  From the 6-basin: `int otSize = Draw_gViewOtSize - 2;` 10, the same as its own
  statement 8, explicit `i = 0;` at the block head + `for (; i < 0x19; ...)` 6 (inert).
  RESIDUAL 6 = three POSITION-only lines in the entry block.
- **DrawC_Prim 338 -> 336** (93a58bf4). Law 1 transferred; kept for STRUCTURE, the -2 is
  LCS noise on a far-miss. The same edit on DrawC_PrimClip's twin loop = 566 (not
  landed; re-probe after PrimClip's block-order work).
- **InGame_ResetPSXController 3** (receipted 9d6962d6). Mechanism complete: retail's
  delay slot is a SIMPLE FILL of the `sll s5,s2,2` that is its LAST pre-branch insn;
  ours has it FIRST so reorg's backward scan is blocked by the compare's own operand
  load and it eager-steals a `lui` from the target instead (+1 insn). Need: def
  pre-branch AND last. 14 falsifications listed in-source.
- **InGame_SetRamp 13** (receipted). Falsified the loop.c movable-ORDER hypothesis
  (4 spellings that move `&hoff`'s first appearance past the three movables retail
  keeps: all 17, all keep the hoist).
- **DrawC_NightHeadlight 4** (receipted). First SLD read: the two insns whose order we
  fight are in ONE statement (line 255; 251-254 empty) -> SLD cannot discriminate, the
  11D re-lay angle is retired here. Inlining `wc` = 48 @109 in 3 fence variants.
- **Hud_BTCStats 24** (receipted). The fold now named in BOTH directions; 13 spellings
  measured 24-81, every one that reaches retail's shape is +-1 insn. New named angle:
  the shared `yoff` cse temp also feeds the LATER showtimeleft call site.
- **DrawW_DrawQuad 7** — not probed this wave; the in-source w53 receipt already prices
  the exact delta (sd REG_N_REFS 62 -> 128, or prim 24 -> 13 refs, or prim live > 273)
  and shows the live-length route is mutually exclusive with zeroTransFlag's $s1.
- **Flare_2DHalo 6 / Sfx_AdditivePrim 26** — not probed; both carry multi-wave receipts
  whose sole untried instrument is the -dl/-dg qty dump for the block in question.
