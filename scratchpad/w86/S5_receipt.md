# W86-S5 receipt — SYM/SLD-exact C for `recon/frontend/psx/`

Task: methodology §0 rule 8 + §3.8b applied to the whole `recon/frontend/psx/` tree
at an UNCHANGED gate. SYM = `C:\Temp\nfs4-psx\nfs4-psx-sym.txt`.
Private scratchpad tools (no repo `tools/*.py` touched): `s5_symfn.py` (8c-block
dumper), `s5_class.py` (per-file fn list + EXT/STAT class), `s5_audit2.py`
(SYM-name-present audit), `s5_params.py` (REGPARM/ARG-vs-signature audit).
No git, no tools/*.py or regiondiff edits, no memory edits, no new devices.

## RESULT — 85/85 PASS before, 85/85 PASS after. Nothing regressed.

| TU | fns | SYM file | baseline gate | final gate | changed |
|---|---|---|---|---|---|
| psxfront.cpp | 25 | PSXFRONT.CPP | 25/25 PASS | **25/25 PASS** | 10 fns |
| memcard.c | 21 | MEMCARD.C | 21/21 PASS | **21/21 PASS** | 8 fns |
| movie.cpp | 17 | MOVIE.CPP | 17/17 PASS | **17/17 PASS** | 4 fns |
| video.cpp | 9 | VIDEO.CPP | 9/9 PASS | **9/9 PASS** | 2 fns |
| mdec.cpp | 6 | MDEC.CPP | 6/6 PASS | **6/6 PASS** | 1 fn |
| drawshp.cpp | 4 | DRAWSHP.CPP | 4/4 PASS | **4/4 PASS** | 2 fns |
| fetexture.cpp | 2 | FETEXTURE.CPP | 2/2 PASS | **2/2 PASS** | 1 fn |
| mmeffect.cpp | 1 | MMEFFECT.CPP | 1/1 PASS | **1/1 PASS** | 0 (already exact) |
| cache/endcode/mdecstat/memdsp/readpix/vsprintf .cpp | 0 | (no SLD file) | 0/0 | 0/0 | — |

Every TU was whole-TU re-gated with `tools/tugate.py` after EACH edit (28 gate runs
total); every edit that could have regressed was gated in isolation. Zero reverts
were needed — every SYM-directed reshape held at 100%.

SYM fn-count per SLD'd file matches the gated fn count exactly in all 8 cases.

## 🔑 CONVENTION ESTABLISHED FIRST (the enabling step — do not re-derive)

The SYM `8c Function start` block's Def-record order **IS the source declaration
order**, not its reverse. Derived from the user's own CLOSED game/psx series (the
SYM ground truth the wave guide says to preserve):
* `Device_Analog__FUl` (`recon/game/psx/device.cpp`) — SYM `min, max, v`; the
  landed C declares `int min; int max; int v;` in that order.
* `CarIO_CopyFromShape__FPsT0iiii` (`recon/game/psx/cario.cpp`) — SYM `columns,
  mask, firstMask, lastMask, lastLastMask`; landed C identical order.
Nested `90 Block start`/`92 Block end` depth = C block scope; a local recorded
inside a nested block belongs in that `{}` in the source.

Before this wave the frontend/psx tree was **name- and type-clean but
order-and-scope-blind**: a prior pass had already purged every fabricated Ghidra
local and applied SYM names/types (psxfront.cpp's own note claims "85/85
declaration-clean"), but 28 of the 85 functions declared their SYM locals in the
wrong ORDER (several exactly reversed) and 5 held a nested-block local at
function scope. That is what this wave fixed.

## Per-TU work

### mmeffect.cpp — ALREADY SYM-EXACT, no change
1 fn (`FeDraw_SetABRMode__Fi`, EXT). SYM: REGPARM `abr`($5) + `dr_mode`(REG $16,
`DR_MODE*`) — both real C variables of the right type/scope. `linkWord` is a
documented non-SYM OT-link-macro carrier (the SLD proves the whole link block is
ONE source line 236 ⇒ a macro; every direct form measured 8–40 diffs).

### fetexture.cpp — DECL ORDER (1 fn)
`FETexture_LoadPmxAtOffset`: SYM d1 order `shpptr, old_shape, bpp, xclut, yclut,
unpacked`; the file had them in exactly the REVERSE order. Re-ordered.
Block-scoped `is_compressed`/`oldptr`/`newptr` were already in their SYM `90 Block
start` scopes. `FETexture_LoadPmx` has params only.

### drawshp.cpp — DECL ORDER (2 fns)
* `DrawShape_NFS4Rectangle`: SYM `topleft, topright, bottomleft, bottomright,
  drawFlags`; file had `drawFlags, bottomright, topright, bottomleft, topleft`.
* `DrawShape_SubtractNFS4RectEdges`: the 7 SYM locals (`dr_mode, prim, x1, y1, x2,
  y2, i`) were in SYM order but INTERLEAVED with the two non-SYM OT-link carriers
  (`prevPrim`, `linkWord`); carriers moved after the SYM set.
* `DrawShape_NFS4RoundRectangle` (`drawFlags, flags, left`) and
  `DrawShape_NFS4TransRectangle` (zero locals) were already exact.

### mdec.cpp — DECL ORDER + one carrier type (1 fn)
* `initmdec`: the SYM records exactly ONE local, `mdec` (REG $18). It was declared
  LAST behind four non-SYM carriers; moved to the front so the single SYM local leads.
* `initmdec`: carrier `bufsize` was typed `void *` with an `(int)` cast at all three
  uses — a Ghidra artefact (it is a byte count). Retyped `int`, casts dropped.
* TU header comment corrected: it still listed folded-away temps
  (`buf/hs/mode/drawsync/nextx`) as if live, and understated the SYM coverage.
* `mdec`/`restoremdec`/`MDECCompleteHandler`/`mdecreset`/`mdecdone` already exact.
* NOT touched: the `mdecdone` per-site `volatile` (documented MMIO-class polling
  read of an IRQ-cleared field) and its receipt.

### video.cpp — DECL ORDER (2 fns)
* `VIDEO_create`: SYM `vid, playopts, handle, fname`; file had `vid, handle,
  playopts, fname`.
* `VIDEO_updateframexy`: SYM `vid, chunk, audiostatus, currenttime, dropped`; file
  had `result, chunk, vid, dropped, currenttime, audiostatus`. Re-ordered to SYM
  order with the non-SYM carrier `result` moved to the end.
* The three unused-but-REAL AUTO stack locals (`playopts`, `audiostatus`, `srs`)
  are KEPT — they are SYM AUTO records that hold frame space.
* The `hzp` and `result` carriers stay, both with their measured receipts.

### movie.cpp — DECL ORDER + 1 SCOPE (4 fns)
* `Movie_Play`: SYM `disp, draw, joyval`; file had `dispRect, joyval, disp, draw,
  deadfrm`. Re-ordered, carriers (`dispRect`, `deadfrm[4]`) after the SYM set.
* `strNextVlc`: SYM `cnt, next`; file had them reversed.
* `strSync`: SYM's only local is `cnt` (AUTO -8, ULONG); the `viewOff` carrier had
  been declared ahead of it. Re-ordered.
* `strNext`: SYM fn-scope `addr, sector, cnt` + a NESTED-block `rect` (SYM
  `90 Block start line = 50`). The file had all nine declarations flat at function
  scope in a different order. Fixed in two gated steps — (a) SYM order first, the
  five carriers after; (b) `RECT rect;` moved into the `if (*wp != … )` block that
  is the SYM's nested block. Both steps 17/17 PASS.
* ⚠️ CAUTION HONOURED: movie.cpp's 41 sanctioned `asm("…")` declaration labels
  (the `_d`/`_v[]` absolute-addressing views + `strInit`'s mangled-name label) and
  the one `volatile u_long cnt` spin-counter were NOT touched — verified by count
  after the edits (41 asm labels, 1 volatile, both unchanged).

### memcard.c — DECL ORDER (8 fns)
Batch A (6, gated together, 21/21 PASS): `MCRD_savefile` (SYM `pMFI, nIcons, i` —
file exactly reversed), `iMCRD_DoFileWrite` (`cmd, res, error, pMFI`),
`iMCRD_DoFileDelete` (`retval, pMFI`), `MCRD_handlecardevents` (`status, pCI, cmd,
res, ret`), `garyMemCardGrabBlocks` (`i, pCI, pDir`), `iMCRD_FormatCard`
(`result, pCI`).
Batch B (2, gated together, 21/21 PASS): `iMCRD_LoadCard` (SYM `error, slot, pCI,
pDir`; carrier `size` moved to the end) and `iMCRD_HandleError` (SYM fn scope is
just `code, pCI`; the three carriers `scratch_i`/`tmp_int`/`gmi` moved after them —
its nested-block `numberoftries`/`result` were already correctly scoped).
Already exact: `MCRD_init`, `iMCRD_InitCard`, `MCRD_loadfile`, `iMCRD_DoFileLoad`,
`MCRD_fileexists`, `iMCRD_timersub`, `ascii2sjis`, `sjis2ascii`, plus the
no-local fns.

### psxfront.cpp — DECL ORDER (6 fns) + SCOPE (4 fns)
Order batch (gated together, 25/25 PASS):
* `ScaleGouraudShape` — SYM `prim, width, height, u, v, uw, vh, bpp`; `bpp` had
  been hoisted above the char group.
* `ScaleShapeExtended` — SYM `scalex, scaley, tShp, color`; `tShp` had led.
* `LoadAllHelpShapes` — SYM `fullName, permFile, i`; file exactly reversed.
* `PSXDrawGouraudSquare` — SYM's only local is `prim`; the `otWord` carrier had led.
* `PSXDrawTransGouraudSquare`, `PSXDrawTransSquare` — SYM `prim, i`; both reversed.
Scope work (each gated separately, 25/25 PASS each):
* `DoTitleScreen` — `artfilename[20]` is a nested-block local (SYM `90 Block start
  line = 9`); moved into the `if (creditShapeFile[0] == 0)` body.
* `CleanupSpinningCarsMenu` — `i` is a nested-block local (SYM line 8); moved into
  the `rendering3DEnvironmentInitialized` guard.
* `InitializeSpinningCars` — `i` is a nested-block local (SYM line 10); moved into
  the guard together with its `carObj` carrier.
* `CleanupSpinningCars` — the SYM says there are **NO function-scope locals**: two
  SIBLING nested blocks live inside the guard, `line 8 .. 18` holding `i` (the
  de-instantiate loop) and `line 21 .. 47` holding `handle` + `fname[60]`. Both
  blocks written out explicitly and the body re-indented. This was the largest
  structural change in the wave and it held at 25/25 PASS.
Already exact: `AdjustShapeDrawing` (fn-scope `fadetop, fadebottom`; `i` in the
0x80 arm's block, `fbot`/`ftop` in the 0x40 arm's block), `DrawGouraudShape` (all
ten SYM locals in SYM order, `addw` in the loop block), `DrawShapeExtended`,
`FontUpsideDownBlit` (`prim, width, height, dv`), `Quick_DD`, `DrawFlatShape`,
`ScaleFlatShape`, `PSXDrawSquare` and the six no-local fns.

## Whole-tree audits run at the end (all clean)

1. **SYM-name presence** (`s5_audit2.py`): 85 fns, **314 non-ARG SYM Def records,
   0 MISSING from the C.** Every SYM-named param/local/fn-static exists as a real
   C variable.
2. **Param names vs REGPARM/ARG** (`s5_params.py`): every SYM REGPARM and ARG name
   is present in the corresponding C signature — **0 mismatches over all 85 fns.**
3. **EXT/STAT linkage** (`s5_class.py`): 15 SYM `Def class STAT` functions
   (movie.cpp 7 `str*`, memcard.c 3, psxfront.cpp 5) are all `static` in the recon
   (declaration AND definition); every other fn is EXT and non-static.
   **0 mismatches.**
4. **Non-SYM temps**: 54 remaining `SYM-CODEGEN-CARRIER`-tagged locals across the
   tree. Each already carries a measured diff cost for its removal in the source
   comment; none was added by this wave, and all are now declared AFTER the SYM set
   in their function so the SYM structure reads contiguously.

## Mismatches that could NOT be applied

None. Every SYM-directed order/scope change gated at 100%, so nothing had to be
reverted and nothing is left outstanding on the SYM axis for this tree.

The only remaining known deviations from "as EA wrote it" in this tree are the 54
non-SYM codegen carriers (and mdec.cpp's per-site `volatile` + movie.cpp's
asm-label storage views), all of which are pre-existing, individually measured, and
outside this wave's remit — removing any of them is a FAIL by measurement, not an
un-applied SYM finding.
