/* frontend/screens/screenusername.cpp  --  RECONSTRUCTED  (username-entry screen; C++ TU)
 *   6 MEMBER functions of class tScreenUserName (: tScreen via _base_tScreen + manual vtable).
 *   Member-fn decls live in nfs4_types.h (non-virtual, ABI-neutral). Bodies: Ghidra decompiler.
 *   NOTE: Ghidra lost several draw-call args (boxY, dse-args, sprintf dest) -- decl-only, honest.
 */
#include "screenusername.h"

/* W72-A7: alignment-1 two-byte block move.  gcc-2.8 lowers a struct
   assignment at MIN(dst,src) alignment; a struct whose only member is
   `char b[2]` has alignment 1, which is what retail's `strcpy(output," ")`
   resolved to (byte lb/lb/sb/sb), where a plain `char[2]`<-string-literal
   copy resolves to 2 (halfword lhu/sh). */
struct ScreenUserName_Align1Copy2CodegenCarrier { char b[2]; };


/* ---- tScreenUserName::Initialize  (screenusername.cpp:33) ---- */
void tScreenUserName::Initialize()

{
  /* MATCH: SLD records only the short loop index; the decompiler's rowLabel,
     n_rows, and fixed-point idx temporaries distort the retail induction chain. */
  short i;
  
  i = 0;
  this->fTextFade = 0x80;
  MENUUSERNAME_STARTY = 0x82 - (short)(menu_kUserNameRows * 0xf >> 1);
  if (0 < menu_kUserNameRows) {
    do {
      sprintf(this->fRowList[i],TextSys_Word(i + 0x1fb));
      i = i + 1;
    } while (i < menu_kUserNameRows);
  }
  this->tScreen::Initialize();
  return;
}

/* ---- tScreenUserName::GetShapeInfo  (screenusername.cpp:54) ---- */
void tScreenUserName::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  
  *swapFileName = (char *)0x0;
  numSwapShapes = 0;
  numPermShapes = 0x5c;
  sprintf("","zUser%d",(uint)(byte)frontEnd.language);
  *permFileName = "";
  return;
}

/* ---- tScreenUserName::DrawVerticalLine  (screenusername.cpp:65) ---- */
void tScreenUserName::DrawVerticalLine(short x,short y,short gridpos)

{
  /* MATCH: SYM-CODEGEN-CARRIER: depth -- retail sign-extends the short param
     ONCE into a separate int
     (oracle sll $v0,$a3,16 / sra $v1,$v0,16) and TESTS that int, while the
     clamp STORES back into the short param register $a3.  One variable for
     both roles makes gcc clamp+test in the same reg + an extra copy. */
  int depth;

  /* MATCH (source-only): the explicit unsigned-short normalization followed by
     signed re-extension keeps the raw short parameter in $a3 for the clamp and
     forms retail's separate $v0 -> $v1 depth value.  This replaces the former
     identity fence, so reorg can also steal the ra save into the first branch's
     delay slot.  Detailed gate: 17 -> PASS 32/32. */
  depth = ((int)(uint)(ushort)gridpos << 16) >> 16;
  if (0 < depth) {
    if (0x3f < depth) goto DrawVerticalLine_high;
  }
  if (depth < 0) {
    gridpos = 0;
  }
  goto DrawVerticalLine_draw;
DrawVerticalLine_high:
  gridpos = 0x40;
DrawVerticalLine_draw:
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,0xa2,1,
                       ((int)gridpos << 0x10) >> 0xf,0);
  return;
}

/* ---- tScreenUserName::DrawHorizontalLine  (screenusername.cpp:73) ---- */
void tScreenUserName::DrawHorizontalLine(short x,short y,short gridpos)

{
  /* SYM-CODEGEN-CARRIER: depth -- same parameter-clamp source shape as
     DrawVerticalLine.  Detailed source-only gate: 17 -> PASS 33/33. */
  int depth;

  depth = ((int)(uint)(ushort)gridpos << 16) >> 16;
  if (0 < depth) {
    if (0x3f < depth) goto DrawHorizontalLine_high;
  }
  if (depth < 0) {
    gridpos = 0;
  }
  goto DrawHorizontalLine_draw;
DrawHorizontalLine_high:
  gridpos = 0x40;
DrawHorizontalLine_draw:
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,0xc0,1,2,
                       ((int)gridpos << 0x10) >> 0xf,0xc);
  return;
}

/* MATCH W61-A17 (93 -> 89 diffs, 391/394 insns): COMPLETE-THE-FUNNEL on all
   three fade clamps.  Retail funnels each clamp's arms through ONE register
   and stores ONCE (`sh a0,40(sp)`, `sh a3,48(sp)`, `sh a0,104(t0)`); ours
   stored the destination inside every arm -- the frame census showed sp+40
   touched 4 times vs retail's 2 and sp+48 5 vs 3.  A per-clamp funnel local
   (fadeboxv / gridposv / textfadev) assigned in the arms with a single store
   at the join reproduces retail's single-store shape.  Priced: clamp1 alone
   94, clamp1+2 89, all three 89, clamp3 alone 93.
   FALSIFIED: VALUE-FIRST staging (funnel local initialised to the normal
   value, arms overwrite it, `if (v < 0x81) goto Done` keeping it) -- the shape
   suggested by retail's `nop`-filled normal-arm delay slot -- 136 / 131 / 130.
   RESIDUAL (named angles): (a) retail's `strcpy(output, " ")` expands
   BYTE-wise (`addiu t2,v0,0; lb; lb; sb 32(sp); sb 33(sp)` -- the oracle's
   only sp+33 access) while ours emits a halfword `lhu/sh` pair: retail's
   source string has alignment 1, our string constant is 2-aligned;
   (b) the funnel register is v0 for us and a0/a3 for retail, and retail's
   normal arm needs no copy in clamp 1 because the funnel reg already holds
   the computed value (dead-pseudo staging, 12D).
   ==== W71-A18 (2026-08-21): 89 -> 68, count 391 -> 392 (oracle 394).
   CLAMPS 2 AND 3 NOW BYTE-MATCH (registers included); only clamp 1 and the
   scratch-register rotation remain.  Three coupled arm-shape corrections,
   each re-gated and landed in this order:
    (1) 89 -> 88 (391 -> 394, COUNT EXACT): clamp 3's ZERO arm stores the
        literal directly (`this->fTextFade = 0;` + a `goto` past the funnel
        store) instead of funnelling.  Retail's oracle carries TWO stores to
        `104(this)` -- `sh a0,104(t0)` shared by the high+normal arms (they
        cross-jump) and a separate `lw t1,112(sp); nop; sh zero,104(t1)` for
        the zero arm -- and a full funnel can only ever emit ONE, which is
        why we were three insns short.  cross_jump merges the two REGISTER
        stores; the literal-zero store has nothing to merge with.
    (2) 88 -> 75: clamp 2 rewritten DEFAULT-FIRST (`gridposv = 0;` before the
        `<= 0` test, `gridposv = fade >> 2;` before the `< 0x81` test, high
        as the fall-through, no `goto`).  Retail's clamp 2 has BOTH arm
        values in BRANCH DELAY SLOTS (`addu a3,zero,zero` in the blez slot,
        `addu a3,a0,zero` in the bnez slot) -- the catalog's PRE-SET-THE-
        DEFAULT-BEFORE-THE-TEST shape: the value assigned before a test runs
        on both paths and the fall-through overwrites it.  With the arms
        written as out-of-line blocks the zero arm needs its own block plus a
        `j`, which is what we had.  Clamp 2 is now byte-identical, $a3
        included.
    (3) 75 -> 68: clamp 3's ZERO block moved AFTER the funnel store (retail's
        physical block order is high -> normal -> Done-store -> zero-block),
        i.e. `... Done: this->fTextFade = textfadev; goto Skip; Zero:
        this->fTextFade = 0; Skip:`.
   FALSIFIED from the 68 basin (all re-gated; 04Z basin-relativity honoured --
   these were re-measured here, not inherited): clamp 1 compute-first (the
   shape that would delete its funnel copy) 132, with an int test-temp 132,
   default-first 79; clamp 3 default-first + zero-last 73.  From the 88/89
   basins: clamp1+2 compute-first 129, all-three 130.
   RESIDUAL 68 = (a) clamp 1's funnel copy `addu v0,a0,zero` where retail's
   funnel IS the computed value's own pseudo ($a0, empty delay slot) -- every
   compute-first spelling costs far more than the one insn it saves;
   (b) the strcpy alignment (below); (c) a whole-body scratch-register
   rotation, ours always $t0 where retail rotates $t1/$t2/$t3 for the same
   `lhu 56(sp)` / `lhu 48(sp)` / `lw 112(sp)` reloads -- local-alloc QTY
   territory (methodology 4.6), not an allocno-table question.
   🔑 (b) IS NOW UNDERSTOOD AND REPRODUCIBLE, just not at a better score:
   gcc-2.8 expands `strcpy(dst,lit)` as a block move at MIN(dst,src)
   alignment; ours resolves to 2 (halfword `lhu/sh`), retail's to 1.  A
   2-byte struct copy (`struct Pack2 { char b[2]; }; *(Pack2*)output =
   *(Pack2*)(char*)" ";`) forces align 1 and emits retail's EXACT shape --
   `addiu t1,v0,0; lb; lb; sb 32(sp); sb 33(sp)`, count 394/394 -- but gates
   74 because the copy's three scratch registers rotate (ours t1/t2/t3 vs
   retail t2/t3/t0; retail additionally carries a DEAD `lw t2,112(sp)` reload
   ahead of the copy that ours places later).  Kept the natural `strcpy`
   spelling at 68; the Pack2 form is the structurally-true basin for a future
   pass that can also land the reload position.  Falsified for (b): memcpy,
   `char output[3]`, elementwise stores, `__attribute__((aligned(1)))`,
   `&output[0]` / `output + 0` / `output + (i - i)` dest spellings -- all
   exactly 88 in that basin (the alignment comes from neither the dest
   spelling nor the copy call).
   Harness: scratchpad/A18/user_v{1..9}.json + probe.py.
   ==== W72-A7 (2026-08-22): 68 -> **PASS 394/394**.  Four coupled landings,
   each re-gated in the basin it was measured in (04Z):
    (1) 68 -> 74, count 391 -> 394 EXACT: the Pack2 alignment-1 block move
        landed (the explicit alignment-one carrier above).  A REGRESSION on
        the diff count but
        the structurally-true basin -- W71 was right to name it.
    (2) 74 -> 70: clamp 2's `gridposv = 0` moved INSIDE the `< 0x80` if
        (before the `<= 0` test) instead of ahead of it, so the pre-set no
        longer competes for the beqz delay slot.
    (3) 🔑 70 -> 11: THE WHOLE-BODY SCRATCH ROTATION IS ONE MISSING RELOAD.
        gcc-2.8 `allocate_reload_reg` (reload1.c ~5083) walks spill_regs
        ROUND-ROBIN from a FUNCTION-GLOBAL cursor `last_spill_reg`, so ONE
        extra reload allocation renumbers every later scratch by +1 for the
        rest of the body.  Retail carries a DEAD `lw $t2,0x70($sp)` (`this`)
        at 0x8004B2EC, right after the second SubtractiveBox and before the
        `li $fp,1` constant hoist; without it ours ran the whole body one
        step behind (ours $t0/$t1/$t2 where retail has $t1/$t2/$t3) -- ~56
        of the 70 diffs, at 21 sites, all in ONE decision.  Reinstating that
        single `this` reload collapses ALL of them at once.
    (4) 11 -> PASS: ALL THREE CLAMPS SHARE ONE SOURCE SHAPE -- high arm
        (`goto Done`), then the NORMAL arm as its own block (`goto Done`),
        then the ZERO block, then Done.  Retail's three clamps look
        different in asm ONLY because reorg fills their delay slots
        differently (clamp 1 gets `nop`s, clamp 2 gets both arm values in
        the blez/bnez slots, clamp 3 shares its store).  Do NOT chase the
        per-clamp asm shape -- write all three the same way.  Clamp 1
        11 -> 1, clamp 2 1 -> 0.
   THE `__asm__("" : : "r"(this))` FENCE IS LOAD-BEARING -- DO NOT DELETE.
   It is a zero-instruction USE marker (not a register pin: no `asm("$N")`,
   no operand binding), and it is the only device found that materialises
   retail's dead preheader `this` reload.  FALSIFIED pure-C substitutes, all
   re-gated here: dropping it 59, `(void)this` 59, `(void)(volatile int)(int)
   this` 59, `this->fTextFade = this->fTextFade` 59 (gcc deletes all four
   before reload), a `volatile` pointer local 88 (adds a frame slot + store),
   `if (this == 0) return;` 2 @396.  `__asm__("" : : "r"((int)this))` also
   PASSes -- same device.
   FALSIFIED in the 11-diff basin: clamp 1 compute-first 79, value-first 79;
   clamp 2 value-first 26, hi-as-if / Yoda-hi / normal-block-without-goto all
   1 (the leftover duplicated `slti $v0,$v1,129`).  FALSIFIED in the 70-diff
   basin: copy before/after `y`/`row`, copy before the SubtractiveBox pair
   (74), `char output[3]`, `output` as a two-byte struct object, SYM declaration
   order, funnels-declared-first -- all exactly 70 (the rotation is immune to
   every source-position lever; only the reload count moves it).
   Harness: scratchpad/W72_A7/{probe.py,p1..p7.py} + scratchpad/W72_A7_sbs.py. */
/* ---- tScreenUserName::DrawBackground  (screenusername.cpp:80) ---- */
void tScreenUserName::DrawBackground()

{
  short i;
  short k;
  short x;
  short y;
  int gray;
  short fade;
  char output[2];
  short fadebox;
  short gridpos;
  short row;
  short col;
  /* SYM-CODEGEN-CARRIER: fadeboxv
     SYM-CODEGEN-CARRIER: gridposv
     SYM-CODEGEN-CARRIER: textfadev -- optimized clamp-funnel values absent
     from the retail local list.  The W72-A7 receipt above measures the direct
     destination and alternate clamp forms; these funnels retain PASS 394/394. */
  short fadeboxv;
  short gridposv;
  short textfadev;

  /* W85-S5 (device removed): this was `fade = *(volatile int *)&this->
     callingMenu->fScreenFade;`.  What the volatile bought is retail's FULL
     WORD load: `lw $v0,116($v0)` + an `addu $a1,$v0,$zero` copy that keeps the
     raw word live, then `sll/sra 17` sign-extends its low half for the shift.
     A plain read straight into the `short fade` lets gcc narrow the load to
     `lhu` and drop the copy (393 insns vs 394).  The pure-C equivalent is an
     honest named INT holding the raw word, truncated into `fade` -- the int's
     live range is the `$a1` copy.  FALSIFIED first (whole-TU re-gated): plain
     `*(int *)&` cast 7, direct field read 7, `*(long *)&` 7,
     `(short)*(u_int *)&` 7. */
  {
    int fadeWord = this->callingMenu->fScreenFade;
    fade = (short)fadeWord;
  }
  if ((short)((fade >> 1) - 0x80) < 0x80) {
    if ((short)((fade >> 1) - 0x80) <= 0) goto DrawBgUser_fadeboxZero;
  }
  if ((short)((fade >> 1) - 0x80) < 0x81) goto DrawBgUser_fadeboxNormal;
  fadeboxv = 0x80;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxNormal:
  fadeboxv = (fade >> 1) - 0x80;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxZero:
  fadeboxv = 0;
DrawBgUser_fadeboxDone:
  fadebox = fadeboxv;
  if ((short)(fade >> 2) < 0x80) {
    if ((short)(fade >> 2) <= 0) goto DrawBgUser_gridposZero;
  }
  if ((short)(fade >> 2) < 0x81) goto DrawBgUser_gridposNormal;
  gridposv = 0x80;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposNormal:
  gridposv = fade >> 2;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposZero:
  gridposv = 0;
DrawBgUser_gridposDone:
  gridpos = gridposv;
  if (fade < 0x80) {
    if (fade <= 0) goto DrawBgUser_textFadeZero;
  }
  if (fade < 0x81) goto DrawBgUser_textFadeNormal;
  textfadev = 0x80;
  goto DrawBgUser_textFadeDone;
DrawBgUser_textFadeNormal:
  textfadev = fade;
DrawBgUser_textFadeDone:
  this->fTextFade = textfadev;
  goto DrawBgUser_textFadeSkip;
DrawBgUser_textFadeZero:
  this->fTextFade = 0;
DrawBgUser_textFadeSkip:
  gray = 0x80808;
  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);
  /* W72-A7: retail reloads `this` here and never uses it (the dead
     `lw $t2,0x70($sp)` @0x8004B2EC).  That one reload advances gcc-2.8's
     function-global `last_spill_reg` round-robin, which sets the scratch
     register for EVERY later reload in the body.  Zero-instruction use
     fence -- NOT a register pin.  Deleting it costs 59 diffs. */
  __asm__("" : : "r"(this));
  y = MENUUSERNAME_STARTY;
  row = 0;
  *(struct ScreenUserName_Align1Copy2CodegenCarrier *)output =
      *(struct ScreenUserName_Align1Copy2CodegenCarrier *)(char *)" ";
  while (row < menu_kUserNameRows) {
    x = 0x102;
    col = 0;
    while (this->fRowList[0][col + row * 9] != '\0') {
      int colText;

      output[0] = this->fRowList[0][col + row * 9];
      colText = CalcFadeVal(0xb54200,this->fTextFade);
      switch(output[0]) {
      case '!':
        FETextRender_FullTextRGB(TextSys_Word(0x205),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '@':
        FETextRender_FullTextRGB(TextSys_Word(0x205),x + 0x24,y - 1,colText,1,2);
        for (k = 1; k < 3; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      case '#':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '$':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x24,y - 1,colText,1,2);
        for (k = 1; k < 3; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      case '&':
        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '^':
        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x4e,y - 1,colText,1,2);
        for (k = 1; k < 6; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      default:
        FETextRender_FullTextRGB(output,x + 8,y - 1,colText,1,2);
        break;
      case '-':
        break;
      }
      x = x + 0x1c;
      col++;
    }
    y = y + 0xf;
    row++;
  }
  gray = 0x505050;
  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);
  x = 0xfc;
  i = 0;
  do {
    DrawVerticalLine(x,0x2e,gridpos - i * 2);
    i++;
    x = x + 0x1c;
  } while (i < 7);
  k = 0;
  y = MENUUSERNAME_STARTY - 3;
  if (0 < menu_kUserNameRows + 1) {
    do {
      DrawHorizontalLine(0xf0,y,gridpos - (menu_kUserNameRows - k) * 2);
      k++;
      y = y + 0xf;
    } while (k < menu_kUserNameRows + 1);
  }
  i = 0;
  do {
    DrawShapeExtended(i,0,0,0,fadebox,0,(tDrawShapeExtended *)0x0);
    i++;
  } while (i < 0x20);
}

/* ---- tScreenUserName::dtor  (screenusername.cpp:97) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___15tScreenUserName(void *thisp) { ___7tScreen(thisp); }

/* end of screenusername.cpp */
