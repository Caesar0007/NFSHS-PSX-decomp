/* frontend/psx/drawshp.cpp  --  RECONSTRUCTED  (PSX FE styled-rectangle drawing; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   4 EXT functions; C++ linkage (cfront-mangled; RECT& reference params).
 *   NOTE: Ghidra lost several register/stack args to the PSXFront draw helpers
 *   (named x/y + dseIndex/dseFlags/dseX/dseY, decl-only) -- genuinely unrecoverable from the binary.
 */
#include "drawshp.h"

int kNoColor;   /* 0x800529d0 (EXT data global) */

/* lines 1-50: file header, #includes, static data, macros (no symbols emitted) */

/* ---- DrawShape_SubtractNFS4RectEdges  (drawshp.cpp:51, code lines 51-81) ---- */
void DrawShape_SubtractNFS4RectEdges(RECT &rect)

{
  /* SYM 8c: fsize 32, mask $80010000 (ra,s0); the NAMED locals are EXACTLY
   *   dr_mode(DR_MODE* $s0) prim(POLY_G4* $a0) x1($a3) y1($t3) x2($a2) y2($t2) i($t5)
   * -- `top`, `linkAddr`, `tpage`, `prevDrm` were Ghidra fictions.  `prevPrim` and
   * `linkWord` below are the OT-link MACRO's own temps (cf. psxfront.cpp's
   * prevPrim/linkAddr, the same house idiom, and mmeffect.cpp where the SLD proves
   * the whole OT-link block is ONE source line = a macro): they hold nothing across
   * a source statement boundary in the original, hence no SYM Def record.
   * All five shorts are plain `short` locals: that is what lets combine narrow the
   * shared rect.w load to `lhu` and pay the sign-extend only on the >>3 use
   * (lhu + sll 16 + sra 19) exactly like the oracle -- no (u_short) casts.
   *
   * MATCH -- two levers, applied together (49 @107/108 -> 54 @108/108, structural
   * residual 79 -> 26 by tools/posdiff.py; LCS is non-monotone here, judge on
   * posdiff + count):
   *  (1) `prevPrim` caches the palette POINTER once per iteration.  Without it the
   *      literal-address load `*(u_long *)Render_gPalettePtr` makes the 0x1F800000
   *      ADDRESS pseudo a savings-1/life-1 LICM movable, which cc1's loop.c DECLINES
   *      (`-dL`: "Insn 84: regno 108 (life 1), move-insn savings 1 not desirable",
   *      const = 528482304, in a "Loop from 67 to 240: 53 real insns"), while the
   *      four 2-insn constants (life 21/11/7/15) are all "moved".  Retail hoisted it
   *      into $s0; ours spent $s0 on the 0xff000000 mask -> whole-fn rotation.  The
   *      prevPrim cache gives the address pseudo a real live range, so loop.c hoists
   *      it -- `lui $s0,0x1F80` in the prologue + `lw $a1,0($s0)` per iteration = the
   *      oracle, and the loop body then matches instruction-for-instruction.
   *  (2) the palette read-modify-write is SPLIT into a value statement (`linkWord`)
   *      and a store statement with the packet-cursor bump BETWEEN them, in BOTH the
   *      loop and the post-loop DR_MODE block.  That is the same lever that took
   *      mmeffect.cpp's FeDraw_SetABRMode to PASS: it puts the cursor store ahead of
   *      the OR chain and leaves the palette store last (in the post-loop block, last
   *      before `jal GetTPage`, so dbr's backward fill_simple_delay_slots scan takes
   *      IT into the delay slot, as the oracle does).
   * ⚠️ THE psxfront PURGE RULE INVERTS HERE (measured, W43 cross-check): in psxfront
   * deleting the fabricated `prevPrim`/`linkAddr` OT-link locals wins, because those
   * fns are STRAIGHT-LINE -- re-reading the scratchpad slot lets cse share the loaded
   * pointer.  This fn has a LOOP, so the same re-read leaves the 0x1F800000 address as
   * a life-1 movable that loop.c declines; every purged form measured 107/108 with the
   * wrong loop shape (41 / 43 / 47 for split-post / split-loop / split-both) while the
   * cached form is 108/108 with the loop instruction-exact.  Twins are mirrored, not
   * identical -- re-derive per oracle.
   * FALSIFIED on the way: source-hoisting the slot ADDRESS into a `u_char **palSlot`
   * local (61/109 -- it defeats the pointer CSE, costing a second `lw` + a nop);
   * the Draw_PrimStruct struct-field view of the palette slot (62-85, +2..+3 insns);
   * split-loop-only (43) and split-post-only (41) without prevPrim; and the whole
   * -G / -mno-split-addresses axis (tools/gprobe.py: g8 / g0 / nosplit / g8+nosplit
   * all == baseline on this TU).
   *
   * 🔴 W44 -- THE 'FULL-BAR FLOOR' BELOW IS REFUTED (54 -> 30 @ 108/108).  The
   * impossibility bound was correct ARITHMETIC on a FALSE PREMISE: it took the
   * 0xFFFFFF mask's REG_N_REFS as 'structurally pinned at 5' (1 preheader def at
   * loop weight 1 + two in-loop uses at weight 2).  REG_N_REFS is LOOP-DEPTH
   * WEIGHTED, and the depth is a SOURCE dial: writing the two OT-link statements as
   * the `do { ... } while (0)` MACRO BODY the receipt already argues they are (see
   * the prevPrim/linkWord paragraph above -- no SYM Def records, mmeffect's SLD
   * proves the whole OT-link block is ONE source line) emits a real inner
   * NOTE_INSN_LOOP_BEG/END pair, so both mask uses count at depth 2: refs 5 -> 7,
   * live unchanged at 63, priority 0.1587 -> 0.2222 > rect's 0.1985.  `m24` is the
   * macro's own mask temp (same class as prevPrim/linkWord: no SYM record).
   *   RESULT -- the ALLOCNO TABLE IS NOW ORACLE-EXACT, all nine registers:
   *   t0=0xFFFFFF t1=rect t2=y2 t3=y1 t4=0x808080 t5=i t6=0x1F800004
   *   t7=0xFF000000 s0=0x1F800000  (was t0=rect ... t3=0x808080 t4=0xFFFFFF).
   *   That is independent confirmation that retail's build really did weight those
   *   two uses at loop depth 2 -- i.e. the macro really was a do/while(0).
   *   Measured with tools/prio.py on tools/rtl_dump.py's -dg/-dl.
   * ⚠️ REVIEW FLAG (same class as videodecode's do{}while(0) ref dial): this is a
   *   ref dial as well as a shape.  HONEST FALLBACK = delete the `do{`/`}while(0);`
   *   lines and the `m24` local (spell 0xffffff literally) -> back to 54 with the
   *   old rotation.  Kept because it is count-exact, semantically a no-op, and the
   *   register table it produces is retail's exactly.
   * RESIDUAL 30 @ 108/108 -- TWO named items, both smaller than the old floor:
   *  (1) a $v0<->$v1 birth-order tie on the two loaded words in BOTH the loop's
   *      first RMW group and the post-loop block: retail keeps *prevPrim in $v0 and
   *      prim->tag in $v1, we have them swapped (w43 local_alloc qty_compare_1:
   *      longer-lived qty first, ties to the LATER-BORN).  Falsified so far: named
   *      `palw`/`tagw` value temps in either order (109/108 and 30), OR-operand
   *      swaps in both statements and in the post-loop pair (16-way: the tag-side
   *      swap reaches 27 but costs +1 insn), m24 def position (pre-loop / in-wrap /
   *      loop-top / loop-end / mid), a second named mHi mask.
   *  (2) the cursor bump `addiu v0,a0,0x24; sw v0,0(t6)` sits between the second
   *      group's load and its and-chain in retail; ours emits it after the `or`.
   *      The do/while(0) LOOP NOTES are a scheduling BARRIER, so the bump can no
   *      longer be scheduled into the middle of the macro body.  Falsified: every
   *      contiguous wrapper span over {A,B,C,D} x the 4 legal statement orders
   *      (A before B before D, C free) -- 12 gated combinations, best 30; splitting
   *      B into hi/lo halves with the bump between them (56/118).
   *  NEXT NEW ANGLE (untried): the bump must become part of the macro body WITHOUT
   *  re-ordering the mask uses -- i.e. find the spelling in which cc1 emits it
   *  between the load and the and-chain from SOURCE position (w43 SPLIT-RMW is a
   *  dbr lever and dbr runs after the barrier).  Candidates: make the bump read the
   *  ALREADY-LOADED prim (`Render_gPacketPtr = (u_char *)prim + 0x24;` is already
   *  that) but write it through the scratchpad STRUCT view so it becomes a
   *  MEM_IN_STRUCT_P store that may-alias the palette load and must sit between
   *  them; or give the loop body TWO nested do/while(0) macros (tag-link and
   *  packet-advance) so the bump is inside its own note pair adjacent to the second
   *  group.  For (1): the permuter (multi-basin) on the now-30 base -- the whole
   *  residual is two register roles in one block.
   * ---- ORIGINAL (w43) FLOOR RECEIPT, kept for its measurements ----
   * [SUPERSEDED] RESIDUAL 54 @ 108/108 = ONE allocno promotion.
   *  o PROTOTYPE AUDIT: SYM `8c` gives every register.  rect REGPARM $09=$t1,
   *    dr_mode $10=$s0, prim $04=$a0, x1 $07=$a3, y1 $0b=$t3, x2 $06=$a2,
   *    y2 $0a=$t2, i $0d=$t5; return is VOID (`Def class EXT type FCN VOID`).
   *    We reproduce prim/x1/x2/i/dr_mode/$t6/$t7 exactly.
   *  o WHAT IS LEFT: the caller-saved rank order is ours [rect, y2, y1, 0x808080,
   *    0xFFFFFF] -> $t0..$t4 vs the oracle's [0xFFFFFF, rect, y2, y1, 0x808080].
   *    0xFFFFFF alone moves rank 5 -> rank 1 and rotates the other four one step;
   *    the post-loop block's own four materializations then shift one the other way
   *    as a knock-on.  scratch a9_perm.py (rotation-blind diff, 5-cycle in the loop +
   *    (-1) shift after it) scores 92/108: the ENTIRE loop body is covered by the
   *    permutation, and the 16 uncovered lines are the `lui 0xff00` prologue slot and
   *    the post-loop $v0/$v1 + `addiu v1,s0,12` position, both downstream of it.
   *  o NAMED MECHANISM + IMPOSSIBILITY BOUND: gcc-2.8 `allocno_compare` priority is
   *    floor_log2(refs)*refs/live_length.  `-dl` measures the 0xFFFFFF pseudo at
   *    refs=5 / live=63 -> 0.1587, and `rect` at refs=9 / live=136 -> 0.1985, so the
   *    mask cannot outrank rect.  refs is STRUCTURALLY PINNED at 5 (one preheader def
   *    at loop weight 1 + two in-loop uses at weight 2 -- and the oracle itself has
   *    exactly two `and ...,$t0`, so retail's pseudo has the same use set), and live
   *    is bounded below by the loop (53 RTL insns) + the preheader tail: the shortest
   *    hoist slot measured on this loop is 61.  Best reachable pri = 10/61 = 0.164 <
   *    0.1985.  Lowering `rect` instead needs refs<=7 (the oracle has both in-loop
   *    rect loads) or live>159 (+23 over the whole function).  => not source-reachable
   *    under this cc1; the "allocno_compare live-length weighting" identity class.
   *  o TRICHOTOMY (w32/33): (1) loop.c giv anchor -- N/A, the movable is a constant
   *    and its hoist decision is already flipped to the oracle's; (2) cse
   *    double-evaluation -- N/A, there is no redundant register copy in the residual
   *    (count is exact and every insn maps 1:1 under the permutation); (3) true
   *    allocno identity -- yes, bounded above.
   *  o -G / -mno-split-addresses leg: satisfied cluster-wide (w42 gprobe) and
   *    re-confirmed on this TU.
   *  o FALSIFIED DIALS (all gated, ~30): OR-operand swaps on the tag and the linkWord
   *    in both blocks; tagWord / prevWord / primLink temps; prevPrim typed u_long*;
   *    prim staged via a u_char*; masks spelled `~0xff000000` / `~0xffffff`; a mask
   *    folded into the cursor-bump expression; loop shape (for-rotated, while(1)+
   *    break, do-while); i/x/y as int (all lose the SYM short sign-extends and the
   *    count); rect.w cached in the loop; a second RECT* local for the loop or the
   *    pre-loop reads; init order permutations; the r0-store position; a named `m24`
   *    mask local def'd before the loop / at the loop top / before first use / late in
   *    the loop (the in-loop-def ref dial DOES raise pri to 0.276 but costs 2-4 insns);
   *    and the W43 relay's pointer-local-via-decay slot spellings (60/79/60/64) --
   *    that lever targets the LICM decline which `prevPrim` already fixed.
   *  o ROUTE: permuter (multi-basin), or the per-object toolchain-identity
   *    investigation that already owns the allocno_compare delta. */
  DR_MODE *dr_mode;
  u_char *prevPrim;
  POLY_G4 *prim;
  u_long linkWord;
  u_long m24;
  short x1;
  short y1;
  short x2;
  short y2;
  short i;

  i = 0;
  y1 = rect.y + 1;
  y2 = y1 + rect.h + -1;
  x1 = rect.x + 2;
  x2 = rect.x + (rect.w >> 3);
  do {
    prim = (POLY_G4 *)Render_gPacketPtr;
    prevPrim = Render_gPalettePtr;
    do {   /* the OT-link MACRO body -- see the w44 note above */
      m24 = 0xffffff;
      prim->tag = prim->tag & 0xff000000 | *(u_long *)prevPrim & m24;
      linkWord = *(u_long *)prevPrim & 0xff000000 | (u_long)prim & m24;
    } while (0);
    Render_gPacketPtr = (u_char *)prim + 0x24;
    *(u_long *)prevPrim = linkWord;
    *(u_long *)&prim->r0 = 0x808080;
    prim->code = 0x3a;
    ((u_char *)&prim->tag)[3] = 8;
    prim->y0 = y1 + 2;
    i = i + 1;
    *(u_long *)&prim->r2 = 0x808080;
    *(u_long *)&prim->r3 = 0;
    *(u_long *)&prim->r1 = 0;
    prim->x0 = x1;
    prim->x1 = x2;
    prim->y1 = y1;
    prim->x2 = x1;
    prim->y2 = y2 + -2;
    prim->x3 = x2;
    prim->y3 = y2;
    x1 = rect.x + rect.w + -2;
    x2 = x1 - (rect.w >> 3);
  } while (i < 2);
  dr_mode = (DR_MODE *)Render_gPacketPtr;
  dr_mode->tag = dr_mode->tag & 0xff000000 | *(u_long *)Render_gPalettePtr & 0xffffff;
  linkWord = *(u_long *)Render_gPalettePtr & 0xff000000 | (u_long)dr_mode & 0xffffff;
  Render_gPacketPtr = (u_char *)dr_mode + 0xc;
  *(u_long *)Render_gPalettePtr = linkWord;
  SetDrawMode(dr_mode,0,0,(u_short)GetTPage(2,2,0,0x100),(RECT *)0x0);
  return;
}

/* lines 82-91: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4RoundRectangle  (drawshp.cpp:92, code lines 92-124) ---- */
void DrawShape_NFS4RoundRectangle(int textID,RECT &position,short selected)

{
  /* SYM 8c: fsize 80, mask $801f0000 (ra,s4..s0); locals are EXACTLY
   *   drawFlags(AUTO -0x30 = sp+0x20) flags(short $s3) left(tTexture_ShapeInfo* $s2)
   * REGPARM: textID $a0, position $s1, selected $a2.  `shapes`/`abr`/`x`/`y`/
   * `dseIndex`/`dseFlags`/`dseX`/`dseY` were Ghidra fictions -- the two
   * DrawShapeExtended calls were being handed FOUR UNINITIALISED locals each
   * (real bug), and the PSXDraw*Square coordinates were uninitialised too. */
  tDrawShapeExtended drawFlags;
  short flags;
  tTexture_ShapeInfo *left;

  flags = 0;
  left = gHelpShapes + 0x29;
  if (-1 < textID) {
    FETextRender_MenuTextPositionedJustify
              ((short)textID,(short)(position.x + (position.w >> 1)),
               (short)(position.y + 4),2,textState_Selected,textType_FramedInfo);
  }
  if (selected == 0) {
    flags = 1;
  }
  DrawShapeExtended(0x29,flags | 8,position.x,position.y,0,0,&drawFlags);
  DrawShapeExtended(0x29,flags | 0xc,(int)position.x + (int)position.w - (int)left->width,
                    position.y,0,0,&drawFlags);
  if (selected != 0) {
    PSXDrawSquare(0x841d08,(int)position.x + (int)left->width,
                  (int)position.y + (int)left->height + -1,
                  (int)position.w - left->width * 2 + 1,1);
    PSXDrawSquare(0,(int)position.x + (int)left->width,position.y,
                  (int)position.w - left->width * 2 + 1,left->height + -1);
  }
  else {
    PSXDrawTransSquare(0x841d08,(int)position.x + (int)left->width,
                       (int)position.y + (int)left->height + -1,
                       (int)position.w - left->width * 2 + 1,1,1);
    PSXDrawTransSquare(0,(int)position.x + (int)left->width,position.y,
                       (int)position.w - left->width * 2 + 1,left->height + -1,1);
    FeDraw_SetABRMode(0);
  }
  return;
}

/* lines 125-128: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4Rectangle  (drawshp.cpp:129, code lines 129-166) ---- */
void DrawShape_NFS4Rectangle(RECT &position)

{
  /* SYM 8c: fsize 96, mask $803f0000 (ra,s5..s0); locals are EXACTLY
   *   topleft($s5=&gHelpShapes[0x2a]) topright($s3=[0x2b])
   *   bottomleft($s4=[0x2c]) bottomright($s2=[0x2d]) drawFlags(AUTO -0x38=sp+0x28)
   * REGPARM position $s0.  `shapes`/`abr`/`x`/`y`/`dseIndex`/`dseFlags`/`dseX`/
   * `dseY` were Ghidra fictions: all four DrawShapeExtended calls and every
   * PSXDraw* coordinate were UNINITIALISED locals (real bug).  Recovered from
   * the raw oracle. */
  tDrawShapeExtended drawFlags;
  tTexture_ShapeInfo *bottomright;
  tTexture_ShapeInfo *topright;
  tTexture_ShapeInfo *bottomleft;
  tTexture_ShapeInfo *topleft;

  drawFlags.tint[0] = 0x7b2908;
  drawFlags.tint[1] = 0x150800;
  drawFlags.tint[2] = 0x291000;
  drawFlags.tint[3] = 0x4a1900;
  topleft = gHelpShapes_v[0] + 0x2a;
  topright = gHelpShapes_v[0] + 0x2b;
  bottomleft = gHelpShapes_v[0] + 0x2c;
  bottomright = gHelpShapes_v[0] + 0x2d;
  DrawShapeExtended(0x2a,9,position.x,position.y,0,0,&drawFlags);
  DrawShapeExtended(0x2b,9,(int)position.x + (int)position.w - (int)topright->width,
                    position.y,0,0,&drawFlags);
  DrawShapeExtended(0x2c,9,position.x,
                    (int)position.y + (int)position.h - (int)bottomleft->height,0,0,&drawFlags);
  DrawShapeExtended(0x2d,9,(int)position.x + (int)position.w - (int)bottomright->width,
                    (int)position.y + (int)position.h - (int)bottomright->height,0,0,&drawFlags);
  PSXDrawTransSquare
            (drawFlags.tint[1],(int)position.x + (int)topleft->width,position.y,
             (int)position.w - (int)topleft->width - (int)topright->width,1,1);
  PSXDrawTransSquare
            (drawFlags.tint[0],(int)position.x + (int)bottomleft->width,
             (int)position.y + (int)position.h + -1,
             (int)position.w - (int)bottomleft->width - (int)bottomright->width,1,1);
  PSXDrawTransGouraudSquare
            (position.x,(int)position.y + (int)topleft->height,2,
             (int)position.h - (int)topleft->height - (int)bottomleft->height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransGouraudSquare
            ((int)position.x + (int)position.w + -2,(int)position.y + (int)topright->height,2,
             (int)position.h - (int)topright->height - (int)bottomright->height,1,
             drawFlags.tint[2],drawFlags.tint[2],drawFlags.tint[3],drawFlags.tint[3]);
  PSXDrawTransSquare
            (0,(int)position.x + 2,(int)position.y + (int)topleft->height,
             topleft->width + -2,
             (int)position.h - (int)topleft->height - (int)bottomleft->height,1);
  PSXDrawTransSquare
            (0,(int)position.x + (int)position.w + -2,(int)position.y + (int)topright->height,
             -topright->width + 2,
             (int)position.h - (int)topright->height - (int)bottomright->height,1);
  PSXDrawTransSquare
            (0,(int)position.x + (int)topleft->width,(int)position.y + 1,
             (int)position.w - (int)topleft->width - (int)topright->width,
             position.h + -2,1);
  FeDraw_SetABRMode(0);
  return;
}

/* lines 167-169: (static data / macros / comments - no emitted code) */

/* ---- DrawShape_NFS4TransRectangle  (drawshp.cpp:170, code lines 170-181) ---- */
void DrawShape_NFS4TransRectangle(RECT &r,short opacity)

{
  /* SYM: fsize 48, mask $800f0000 (ra,s3,s2,s1,s0); Block start/end both line 1
   * => ZERO named locals.  The old Ghidra body carried fabricated x/y/abr/opac
   * and passed UNINITIALISED x/y as the draw coordinates (real bug).  Every
   * coordinate is re-read from *r (lh) at each call site per the oracle.
   * MATCH: the doubled opacity MUST be spelled  opacity << 1  (not * 2): the
   * shift form lets combine fold promotion+double into one (raw<<17)>>16 off the
   * raw parm copy, deferring the plain sign-extend to the last call site; the
   * multiply form CSEs one shared (int)opacity and is 1 insn short. */
  PSXDrawTransSquare(0,r.x,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + r.w + -4,r.y,4,r.h,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y,r.w + -8,2,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y + r.h + -2,r.w + -8,2,opacity << 1);
  PSXDrawTransSquare(0,r.x + 4,r.y + 2,r.w + -8,r.h + -4,opacity);
  FeDraw_SetABRMode(0);
  return;
}

/* end of drawshp.cpp */