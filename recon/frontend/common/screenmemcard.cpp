/* frontend/common/screenmemcard.cpp  --  RECONSTRUCTED  (memcard UI screen; C++ TU)
 *   15 MEMBER fns of tScreenMemcard : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenmemcard.h"

/* MATCH (w35-a10): unsized-array asm-label views -- these globals are reached
   ABSOLUTELY by every oracle (%hi/%lo as an RTL pseudo, CSE-able and
   delay-slot schedulable); a plain extern leaves cc1plus emitting the lw/sw
   assembler macro, which GNU-as expands per-access (self-temp / $at). */
extern tFEApplication *A_FEApp[] __asm__("FEApp");
#define FEApp A_FEApp[0]
extern int A_ticks[] __asm__("ticks");
#define ticks A_ticks[0]
extern int A_CURRENTLYUSINGMEMCARD[] __asm__("CURRENTLYUSINGMEMCARD");
#define CURRENTLYUSINGMEMCARD A_CURRENTLYUSINGMEMCARD[0]

/* MATCH (w35-a10): UNSIZED-ARRAY ASM-LABEL VIEW of the 17 layout ints.
   They are STRONG DATA symbols in asm/data/front_data.data.s (0x800528D8..)
   and every oracle reaches them with an absolute %hi/%lo pair whose `lui` is
   SCHEDULED away from its load/store (two luis hoisted above two lhus in
   DrawHorizontalLine) -- impossible for an atomic assembler macro, so retail's
   cc1 materialised %hi as its own RTL pseudo.  A bare `int X;` here is a
   tentative def (<=G4 small-common -> .sbss -> %gp_rel, which 0 oracles use
   AND which would mis-relocate against the real .data symbol); a plain
   `extern int X;` leaves cc1plus emitting the `sw $2,X` assembler macro
   (GNU-as $at form).  The unsized-array-with-asm-label view is the catalog
   wave-13 lever (fememcard DeInit) that turns %hi back into a pseudo. */
extern int A_GRIDMEMCARD_STARTX[] __asm__("GRIDMEMCARD_STARTX");
extern int A_GRIDMEMCARD_STARTY[] __asm__("GRIDMEMCARD_STARTY");
extern int A_MEMCARD_DELTAX[] __asm__("MEMCARD_DELTAX");
extern int A_MEMCARD_DELTAY[] __asm__("MEMCARD_DELTAY");
extern int A_EXTRAYATTOP[] __asm__("EXTRAYATTOP");
extern int A_GRIDMEMCARDGOURAUDBIT_X[] __asm__("GRIDMEMCARDGOURAUDBIT_X");
extern int A_GRIDMEMCARDGOURAUDBIT_Y[] __asm__("GRIDMEMCARDGOURAUDBIT_Y");
extern int A_GRIDMEMCARD_WIDTH[] __asm__("GRIDMEMCARD_WIDTH");
extern int A_GRIDMEMCARD_HEIGHT[] __asm__("GRIDMEMCARD_HEIGHT");
extern int A_MEMCARDICONOFFX[] __asm__("MEMCARDICONOFFX");
extern int A_MEMCARDICONOFFY[] __asm__("MEMCARDICONOFFY");
extern int A_kMemCardMessageX[] __asm__("kMemCardMessageX");
extern int A_kMemCardMessageY[] __asm__("kMemCardMessageY");
extern int A_kMemCardMessage1X[] __asm__("kMemCardMessage1X");
extern int A_kMemCardMessage1Y[] __asm__("kMemCardMessage1Y");
extern int A_kMemCardMessageH[] __asm__("kMemCardMessageH");
extern int A_kMemCardMessageH1[] __asm__("kMemCardMessageH1");

#define GRIDMEMCARD_STARTX A_GRIDMEMCARD_STARTX[0]
#define GRIDMEMCARD_STARTY A_GRIDMEMCARD_STARTY[0]
#define MEMCARD_DELTAX A_MEMCARD_DELTAX[0]
#define MEMCARD_DELTAY A_MEMCARD_DELTAY[0]
#define EXTRAYATTOP A_EXTRAYATTOP[0]
#define GRIDMEMCARDGOURAUDBIT_X A_GRIDMEMCARDGOURAUDBIT_X[0]
#define GRIDMEMCARDGOURAUDBIT_Y A_GRIDMEMCARDGOURAUDBIT_Y[0]
#define GRIDMEMCARD_WIDTH A_GRIDMEMCARD_WIDTH[0]
#define GRIDMEMCARD_HEIGHT A_GRIDMEMCARD_HEIGHT[0]
#define MEMCARDICONOFFX A_MEMCARDICONOFFX[0]
#define MEMCARDICONOFFY A_MEMCARDICONOFFY[0]
#define kMemCardMessageX A_kMemCardMessageX[0]
#define kMemCardMessageY A_kMemCardMessageY[0]
#define kMemCardMessage1X A_kMemCardMessage1X[0]
#define kMemCardMessage1Y A_kMemCardMessage1Y[0]
#define kMemCardMessageH A_kMemCardMessageH[0]
#define kMemCardMessageH1 A_kMemCardMessageH1[0]

/* fMemIcon: strong DATA symbol @0x80052938 (front_data.data.s) -> absolute addressing.
   Declared extern (NOT a TU-owned tentative def, which would be small-common -> gp-rel). */

/* ---- tScreenMemcard::GetShapeInfo  (screenmemcard.cpp:65) ---- */
void tScreenMemcard::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x3c;
  *permFileName = "zmemcrd";
  return;
}

/* ---- tScreenMemcard::DrawIcon  (screenmemcard.cpp:90) ---- */
void tScreenMemcard::DrawIcon(shapetbl *icon,int x,int y,int destwidth,int destheight,
               short fFade)

{
  POLY_FT4 *prim;
  int stype = icon->type;
  long sposx = icon->shapex;
  long sposy = icon->shapey;
  long width = icon->width;
  long height = icon->height;
  int bpp = 4;
  /* SYM-CODEGEN-CARRIER: u -- naming the shared texture coordinate preserves
   * retail's early divide and whole-function allocation; repeated source
   * expressions move it to first use (FAIL 87 / 125 versus PASS 126). */
  int u = ((sposx & 0x3f) << bpp) / bpp;
  int v = sposy % 0x100;

  prim = (POLY_FT4 *)Render_gPacketPtr;
  ((tMemcardPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr;
  Render_gPacketPtr = (u_char *)prim + sizeof(POLY_FT4);
  ((tMemcardPrimTag *)Render_gPalettePtr)->addr = (u_int)prim;
  prim->code = 0x2e;
  ((u_char *)prim)[3] = 9;
  prim->r0 = -0x80 - fFade;
  prim->g0 = -0x80 - fFade;
  prim->b0 = -0x80 - fFade;
  prim->clut = shapetoclutid((u_char *)icon);
  prim->tpage = (stype & 3) << 7 |
                (sposy & 0x100) >> 4 |
                (sposx & 0x3ff) >> 6 |
                (sposy & 0x200) << 2;

  prim->u0 = u;
  prim->v0 = v;
  prim->u1 = u + width;
  prim->v1 = v;
  prim->u2 = u;
  prim->v2 = v + height;
  prim->u3 = u + width;
  prim->v3 = v + height;
  prim->x0 = x;
  prim->y0 = y;
  prim->x1 = x + destwidth;
  prim->y1 = y;
  prim->x2 = x;
  prim->y2 = y + destheight;
  prim->x3 = x + destwidth;
  prim->y3 = y + destheight;
}

/* ---- tScreenMemcard::LoadIcon  (screenmemcard.cpp:145) ---- */
/* MATCH (2026-08-10, 43 -> 23 -> PASS, 215/215). Direct
   `fMemIcon[filenum][i]` indexing first removed the fabricated shape-data,
   byte-offset, X-scale, and file-offset locals.  allocsim then proved the
   remaining counter/GIV swap: i was p83 (23 refs/28 live, s0), while the
   generated i*192 GIV was p293 (11 refs/24 live, s1); reqdelta priced retail's
   s0/s1 order at exactly +9 GIV refs.  Three loop-depth read-only operands on
   i*192 buy that threshold without emitting instructions (PASS dump: GIV p305
   20 refs/25 live -> s0, i p83 23 refs/30 live -> s1).  Placing the existing
   i=0 immediately before the nonzero guard makes reorg select its move for the
   branch delay slot instead of stealing li 900.  The block-local `one` makes
   the two literal stores use retail's t0 lifetime, and the identity-laundered
   bool-to-int `pulled` preserves retail's addu t0,s7 before the final word
   store.  Falsified basins: for-loop 25 @216/215; direct icon/cardInfo removal
   40 @219/215; one pointer-read fence 24 @215/215; early i=0 26 @213/215;
   post-loop i fence 44 @217/215; split induction fences 68 @215/215. */
void tScreenMemcard::LoadIcon(int filenum)

{
  bool done;
  int i;
  int clutx;
  int cluty;
  /* SYM-CODEGEN-CARRIER: cardInfo -- direct this->pCI access keeps the same
     215 instructions but moves the pCI load below the title store (2 diffs). */
  CARDINFO_def *cardInfo;
  
  if (AudioMus_Buffered() < AudioMus_Threshold()) {
    return;
  }
  CURRENTLYUSINGMEMCARD = 1;
    this->numicon[filenum] = '\0';
    this->numblock[filenum] = '\0';
    if (filenum < this->pCI->numfiles) {
      blockclear(this->fMemFile + filenum,0x2c);
      cardInfo = this->pCI;
      this->fMemFile[filenum].title = (char *)((int)this->fMemTitle + filenum * 0x20);
      this->fMemFile[filenum].name = (char *)(cardInfo->dir + filenum);
      this->fMemFile[filenum].icon[0] = (shapetbl *)(*fMemIcon)[filenum][0];
      this->fMemFile[filenum].icon[1] = (shapetbl *)(*fMemIcon)[filenum][1];
      this->fMemFile[filenum].icon[2] = (shapetbl *)(*fMemIcon)[filenum][2];
      do {
        i = MCRD_handlecardevents(this->card);
      } while (i != 0x16);
      MCRD_loadfile(this->card,this->fMemFile + filenum,1);
      done = false;
      while (1) {
        if (done) {
          break;
        }
        if (MCRD_getcard(this->card)->status == -1) {
          this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 1;
        }
        i = MCRD_handlecardevents(this->card);
        switch(i) {
        case 0xf:
          done = true;
          if (this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons != 0) {
            this->ReleaseIcons();
            goto LoadIcon_clearCardFlag;
          }
          this->numicon[filenum] = *this->fMemFile[filenum].numicons - 0x10;
          i = garyMemCardGrabBlocks(this->card,filenum);
          this->numblock[filenum] = (u_char)i;
          if (3 < this->numicon[filenum]) {
            this->numicon[filenum] = '\x03';
          }
          if (this->numicon[filenum] == '\0') {
            this->numicon[filenum] = '\x01';
          }
          if (this->fMemIconClutId[filenum] != 0) {
            Texture_MenuReleaseClutId(this->fMemIconClutId[filenum]);
          }
          Texture_GetClutId(0,&clutx,&cluty);
          this->fMemIconClutId[filenum] = (short)cluty << 6 | (ushort)(clutx >> 4) & 0x3f;
          i = 0;
          if (this->numicon[filenum] != '\0') {
            do {
              __asm__("" : :
                      "r"(i * 0xc0), "r"(i * 0xc0), "r"(i * 0xc0));
              if (((*fMemIcon)[filenum][i][0] & 0xf7U) == 0x40) {
                vramfxya((*fMemIcon)[filenum][i],i * 0x11 + 900,
                         filenum * 0x11,clutx,cluty);
              }
              i = i + 1;
            } while (i < (int)(uint)this->numicon[filenum]);
          }
          {
            /* SYM-CODEGEN-CARRIER: one -- direct literal stores allocate $v0;
               this shared block-local value restores retail's two $t0 stores
               and measures 8 fewer instruction diffs. */
            int one = 1;
            this->fFadeIcon[filenum] = 0x80;
            this->goticon[filenum] = one;
          }
          break;
        case 2:
        case 3:
        case 7:
        case 10:
        case 0xb:
        case 0x10:
        case 0x13:
        case 0x17:
          done = true;
          {
            /* SYM-CODEGEN-CARRIER: pulled -- assigning done directly removes
               retail's `addu $t0,$s7,$zero` and measures 3 diffs (214/215). */
            bool pulled = done;
            __asm__("" : "=r"(pulled) : "0"(pulled));
            this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = pulled;
          }
          this->goticon[filenum] = '\0';
          break;
        }
      }
    }
LoadIcon_clearCardFlag:
  CURRENTLYUSINGMEMCARD = 0;
  return;
}

/* ---- tScreenMemcard::DrawVerticalLine  (screenmemcard.cpp:264) ---- */
void tScreenMemcard::DrawVerticalLine(short x,short y,short gridpos,short dir)

{
  /* SYM-CODEGEN-CARRIER: innerHeight -- collapsing HEIGHT/GOURAUD/EXTRA into
     one expression is measured FAIL13 (46/45); the two-stage sum preserves
     retail's arithmetic webs while final `height` itself folds exactly. */
  int innerHeight;
  /* SYM-CODEGEN-CARRIER: pos -- the short clamp carrier preserves retail's
     incoming-$a3 stores and delayed gridpos handoff (measured 26 -> 17). */
  short pos;
  /* SYM-CODEGEN-CARRIER: test -- the explicit signed-test web separates the
     comparisons from the clamped short result (measured 17 -> 13). */
  int test;
  /* SYM-CODEGEN-CARRIER: shifted -- the positive-arm identity fence keeps
     retail's independent $v0/$v1 sign-extension webs (measured 17 -> 13). */
  unsigned int shifted;
  /* MATCH (SLD 265 = ONE source line for the whole clamp): the 0x40 arm is
     OUT OF LINE (oracle `beqz` branches FORWARD to it, past the =0 block, which
     ends with its own `j`), so it must be a goto target, not the fall-through. */
  /* MATCH: PASS 45/45 (W60/W65/W68; 26->17->13->4->2->0).  The horizontal sibling's
     promoted `pos` plus explicit signed-test pair transfers here: it removes
     the premature gridpos result copy and makes the clamp stores use incoming
     $a3 like retail.  Making `pos` short preserves that retail carrier through
     the clamp and its final doubled short value.  The approved empty identity
     fence keeps the signed-test shift pair in retail's separate $v0/$v1 webs
     (17->13).  Separating `innerHeight = HEIGHT + GOURAUD*2` from the final
     `EXTRA + innerHeight` gives retail's $v1/$v0 arithmetic webs, shortens the
     EXTRA address lifetime, and leaves y in its SYM $a2 home (13->4).  Moving
     the identity fence into the positive arm lets reorg fill the initial `blez`
     delay slot with the $ra store (4->2); making `x` a second identity output
     moves its SYM $t0 parameter handoff before the gridpos shift (2->0).
     FALSIFIED in this basin: volatile shifted carrier 36; short test neutral;
     register y neutral; read-only y fence at entry 17 and before call 56;
     inner height-term swap 17; literal IDA if/else clamp 31. */
  shifted = (unsigned int)gridpos << 16;
  pos = gridpos;
  test = (int)shifted >> 16;
  if (0 < test) {
    __asm__("" : "+r"(shifted), "+r"(x));
    if (0x40 <= test) goto VL_clampHi;
  }
  if (test < 0) {
    pos = 0;
  }
  goto VL_clamped;
VL_clampHi:
  pos = 0x40;
VL_clamped:
  gridpos = pos;
  /* MATCH: keep the inner height sum in its own RTL web before adding EXTRA;
     gcc emits the retail GOURAUD/HEIGHT/EXTRA load homes and final $v1->$v0 add. */
  innerHeight = (ushort)GRIDMEMCARD_HEIGHT +
                (ushort)GRIDMEMCARDGOURAUDBIT_Y * 2;
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,
             (short)((ushort)EXTRAYATTOP + innerHeight),
             (uint)(dir == 0),(int)gridpos * 2,0);
  return;
}

/* ---- tScreenMemcard::DrawHorizontalLine  (screenmemcard.cpp:273) ---- */
void tScreenMemcard::DrawHorizontalLine(short x,short y,short gridpos,short dir)

{
  /* SYM-CODEGEN-CARRIER: width -- folding SLD line 276 into the call is
     measured FAIL21 (47/48), losing retail's independent width value web. */
  int width;
  /* SYM-CODEGEN-CARRIER: pos -- the short join carrier delays retail's
     gridpos copy into $t0; direct parameter clamping was measured FAIL16. */
  short pos;
  /* SYM-CODEGEN-CARRIER: test -- the explicit signed test separates the
     clamp comparison web from the clamped value (measured 10 -> 5 diffs). */
  int test;
  /* SYM-CODEGEN-CARRIER: shifted -- the shift-pair value and positive-arm
     identity fence preserve retail's independent $a3 sign-extension web. */
  unsigned int shifted;

  /* MATCH (SLD 274 = ONE source line for the whole clamp): the 0x40 arm is OUT
     OF LINE (oracle `beqz` branches forward past the =0 block, which ends with
     its own `j`), so it is a goto target, not the fall-through. */
  /* MATCH: PASS 48/48 (W59/W68; 16->10->5->2->0).  SYM makes gridpos
     REGPARM $t0, while the oracle clamps a promoted working value in incoming
     $a3 and copies it to $t0 only at the join.  The separate `pos` reproduces
     that delayed copy (16->10).  Spelling the signed test as an explicit
     shift pair separates the test from the clamped value (10->5).  The
     positive-arm identity fence preserves retail's independent
     `sll v0,a3,16; sra v1,v0,16` web (5->2), and making `pos` short removes
     the otherwise duplicated entry sign-extension (2->0).
     FALSIFIED in this basin: register on the parameter (neutral); a plain
     promoted test local (neutral); read-only/identity fences at the init or
     join (neutral or 27 diffs); a signed 16-bit bitfield carrier (27 diffs,
     48-byte frame). */
  shifted = (unsigned int)gridpos << 16;
  test = (int)shifted >> 16;
  pos = gridpos;
  if (0 < test) {
    __asm__("" : "+r"(shifted));
    if (0x40 <= test) goto HL_clampHi;
  }
  if (test < 0) {
    pos = 0;
  }
  goto HL_clamped;
HL_clampHi:
  pos = 0x40;
HL_clamped:
  gridpos = pos;
  /* MATCH (SLD 276 = ONE statement) */
  width = (ushort)GRIDMEMCARD_WIDTH + 2 + (ushort)GRIDMEMCARDGOURAUDBIT_X * 2;
  /* MATCH (SLD 277): the side select is INSIDE the call expression, and the
     oracle's `beqz` puts the 2-arm at the BRANCH TARGET (3 = fall-through). */
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,(short)width,
             1,dir != 0 ? 3 : 2,(int)gridpos * 2,GRIDMEMCARDGOURAUDBIT_X);
  return;
}

/* ---- tScreenMemcard::PlaceIcons  (screenmemcard.cpp:282) ---- */
void tScreenMemcard::PlaceIcons(register int i,int fadeval)

{
  short yy;
  short xx;
  int j;
  /* SYM-CODEGEN-CARRIER: animFrame -- recomputing the remainder only in the
     icon-table arm is FAIL 93 at 214/213 and moves the div across the branch. */
  int animFrame;
  tDrawShapeExtended fFlags;

  j = 0;
  while (1) {
    if (j >= (int)(uint)this->numblock[i]) {
      break;
    }
    if ((((int)this->cursorPosition / 3) & 1U) == 0) {
      xx = (MEMCARDICONOFFX & 0xffffU) + (uint)(ushort)GRIDMEMCARD_STARTX +
           MEMCARD_DELTAX * (short)((int)this->cursorPosition % 3);
    }
    else {
      xx = (MEMCARDICONOFFX & 0xffffU) + (uint)(ushort)GRIDMEMCARD_STARTX +
           MEMCARD_DELTAX * (2 - (short)((int)this->cursorPosition % 3));
    }
    yy = (short)((uint)(ushort)GRIDMEMCARD_STARTY + (MEMCARDICONOFFY & 0xffffU) +
            (4 - (short)((int)this->cursorPosition / 3)) * MEMCARD_DELTAY);
    /* SYM-CODEGEN-CARRIER: nfs4Icon -- direct member comparison is FAIL 3 at
       214/213, loading the member beside the div instead of before savedY. */
    int nfs4Icon = this->theNFS4icon;
    /* SYM-CODEGEN-CARRIER: tickFrame -- folding the shifted tick load into
       the remainder expression is count-exact FAIL 18 and rotates its web. */
    int tickFrame;
    /* SYM-CODEGEN-CARRIER: numIcons -- direct member use even through the
       same read-only fence is FAIL 64 at 217/213 and rotates saved homes. */
    int numIcons;
    /* SYM-CODEGEN-CARRIER: tickPtr -- direct `ticks` is count-exact FAIL 2,
       placing its address high half one instruction after retail. */
    int *tickPtr = A_ticks;
    /* SYM-CODEGEN-CARRIER: savedY -- direct reuse of `yy` is count-exact
       FAIL 2, moving the tick-address high half after retail's $a3->$s0 copy. */
    short savedY = yy;
    /* MATCH (73 -> 4 -> 2 -> PASS, 213/213): the natural signed-short
       coordinate expressions and sum-before-limit spelling establish the
       retail homes.  Naming the NFS4 icon and modulo divisor, then pricing the
       divisor with the empty read-only fence, restores the $a0 comparison and
       remainder webs.  `savedY` plus its zero-insn identity boundary preserves
       retail's real $a3->$s0 copy for the coordinate that survives the calls.
       Crucially, the honest `ticks` base pointer is born before that boundary:
       split-address scheduling emits `%hi(ticks)`, the saved-Y copy, and then
       folds `%lo(ticks)` into the load, exactly matching retail.  Direct
       `ticks` left the hi half one slot late (2); forcing the pointer through a
       fence materialized an extra address copy/add (4); laundering tickValue
       rotated the division and icon webs (21).  This is a genuine runtime div
       with the oracle's divide guards, because numicon[i] is instance data. */
    numIcons = this->numicon[i];
    tickFrame = *tickPtr >> 4;
    __asm__("" : : "r"(numIcons));
    animFrame = tickFrame % numIcons;
    if (i == nfs4Icon) {
      fFlags.tint[0] = 0xb55623;
      DrawShapeExtended(this->memcardanimframe,0x410,xx - 0xf2,yy - 0x70,
                 fadeval + this->fFadeIcon[i] < 0x81 ?
                 fadeval + this->fFadeIcon[i] : 0x80,1,
                 &fFlags);
    }
    else {
      this->DrawIcon((shapetbl *)(*fMemIcon)[i][animFrame],
                 xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,0x1f,0x10,
                 (short)(fadeval + this->fFadeIcon[i] < 0x81 ?
                         fadeval + this->fFadeIcon[i] : 0x80));
    }
    if (((this->theNFS4icon == i) && (fadeval == 0)) && (this->fGetNewIcons == 0)) {
      xx = xx * 0x10000 >> 0x10;
      yy = (int)(short)savedY;
      PSXDrawSquare(0,(xx - MEMCARDICONOFFX) + 2,(yy - MEMCARDICONOFFY) + 1,MEMCARD_DELTAX + -2,
                 MEMCARD_DELTAY + -1);
      PSXDrawSquare
                (0xbebe,xx - MEMCARDICONOFFX,yy - MEMCARDICONOFFY,MEMCARD_DELTAX + 2,
                 MEMCARD_DELTAY + 1);
    }
    this->cursorPosition = this->cursorPosition + 1;
    j = j + 1;
  }
  return;
}

/* ---- tScreenMemcard::DrawMemCardStuff  (screenmemcard.cpp:319) ---- */
void tScreenMemcard::DrawMemCardStuff(short fadeval)

{
  /* MATCH (w37-a9): SYM 8c Function start for this fn (VA 0x80046D60) lists
     ONLY ONE real local across the WHOLE function (all nested blocks) --
     `i` REG SHORT. The prior recon's cardInfo/idx/fileIdx/fadeInc/fade were
     ALL Ghidra-fabricated: `this->pCI` is written straight from
     MCRD_getcard() (no temp), `idx`/`fileIdx` were the compiler's own
     short-to-int WIDEN of `i` (sll 16/sra 16, gotcha #14 shift-chain
     transcription -- `idx=idx>>0x10` / `idx=i*0x10000` / `idx>>0xf` are the
     widen sequence Ghidra mis-read as a second counter, not real math), and
     `fade`/`fadeInc` were a temp for a plain `this->fFadeIcon[i] +/- 8`
     read-modify-write. `i` is SHORT throughout (status code AND every loop
     counter share the one register). */
  /* MATCH (W64, 64->PASS): retail parks the pulled-card cleanup out of line
     between the zero/nonzero fGetNewIcons paths; the normal loop jumps back
     to it only on the error flag.  Positive valid-icon and fade-out arms give
     the retail block order, the LoadIcon arm falls through to the shared
     fGetNewIcons test, and the ready scan is a natural `for` loop.  That final
     spelling lets GCC retain pCI as its unnamed loop-invariant temporary. */
  short i;

  this->pCI = MCRD_getcard(this->card);
  this->cursorPosition = 0;
  /* MATCH (w37-a9): DE MORGAN branch-body swap (W36 lever #1) -- the oracle's
     beq(theNFS4icon==-1) branches OUT to the reset block and falls through
     inline to count++; write the != arm first so gcc lays it out the same. */
  if (this->theNFS4icon != -1) {
    this->count = this->count + 1;
  }
  else {
    this->memcardanimframe = 0;
    this->count = 0;
  }
  if (this->count == 4) {
    this->count = 0;
    this->memcardanimframe = this->memcardanimframe + 1;
    if (0x1d < this->memcardanimframe) {
      this->memcardanimframe = 0;
    }
  }
  if (this->pCI->status == -1) {
    this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 1;
    if (this->checkingstart == 0) {
      this->checkingstart = ticks;
    }
    this->fMemCardMessageTextSys = (800 < ticks - this->checkingstart) ? 0x27f : 0x27b;
    i = 0;
    if (0 < this->pCI->numfiles) {
      do {
        if (this->goticon[i] != '\0') {
          this->fFadeIcon[i] = this->fFadeIcon[i] + 8;
          /* MATCH (w37-a9): DE MORGAN branch-body swap -- oracle branches OUT
             to PlaceIcons (label EE4) when fFadeIcon<0x81 and falls through
             inline to the reset block otherwise; write the negated/swapped
             form so gcc lays it out the same way. */
          if (0x80 < this->fFadeIcon[i]) {
            this->fFadeIcon[i] = 0x80;
            this->goticon[i] = '\0';
            this->numicon[i] = '\0';
            this->numblock[i] = '\0';
            if (this->fMemIconClutId[i] != 0) {
              Texture_MenuReleaseClutId(this->fMemIconClutId[i]);
              this->fMemIconClutId[i] = 0;
            }
          }
          else {
            this->PlaceIcons(i,fadeval);
          }
        }
        i = i + 1;
      } while (i < this->pCI->numfiles);
    }
    goto DrawMC_statusCheckFinal;
  }
  if (this->pCI->status == -2) {
    this->checkingstart = 0;
    this->fMemCardMessageTextSys = 0x288;
    goto DrawMC_statusCheckFinal;
  }
  this->checkingstart = 0;
  if (this->pCI->numfiles != 0) {
    this->fMemCardMessageTextSys = 0x27d;
  }
  else {
    this->fMemCardMessageTextSys = 0x284;
  }
  /* MATCH (w37-a9): the oracle's fGetNewIcons==0 branch jumps STRAIGHT to
     the per-file loop (label FD8); the !=0 (else) case falls THROUGH the
     ready-check loop straight into the same loop with no separate jump --
     i.e. the label/big-loop is COMMON code physically laid out right AFTER
     the if/else, reached by fallthrough from the else-arm and by a direct
     branch from the if-arm.  Writing it that way (label outside, no
     explicit goto in the else-arm) reproduces the layout; the previous
     goto-into-if-arm form put the else-arm's content at the wrong
     (physically later) address. */
  if (this->fGetNewIcons == 0) {
    this->fReadyToGetNewIcons = 0;
    goto DrawMC_perFileLoopTop;
  }
  goto DrawMC_checkIconFades;
DrawMC_cardPulled:
  this->ReleaseIcons();
  this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
  this->fGetNewIcons = 0;
  goto DrawMC_afterPerFileLoop;
DrawMC_checkIconFades:
  /* MATCH/CFG (w65-a1, 04Q class): retail's zero-trip guard for this scan jumps
     STRAIGHT to DrawMC_afterPerFileLoop (branch word 139: ours +19 vs retail
     +166) -- with no files the per-file loop below re-loads the identical
     pCI->numfiles and its own guard skips to the same join, so the two routings
     are equivalent and the instruction stream is identical (PASS 343 both ways).
     The explicit guard must be spelled `i = 0; if (i < ...)` over a `for` that
     keeps its own test: that way cse deletes the duplicate test AND loop.c still
     hoists pCI into the unnamed invariant temp ($a0).  Falsified (all re-gated):
     guard + do-while 14 diffs @343 (pCI reloaded per iteration, the hoist is
     lost); `if (0 < ...)` around the same for +2 insns (guard not merged);
     `if (numfiles <= 0) goto` before the for +2; a trailing `if (i == 0) goto` +3. */
  this->fReadyToGetNewIcons = 1;
  i = 0;
  if (i < this->pCI->numfiles) {
    for (; i < this->pCI->numfiles; i = i + 1) {
      if (this->fFadeIcon[i] < 0x80) {
        this->fReadyToGetNewIcons = 0;
      }
    }
  }
  else goto DrawMC_afterPerFileLoop;
DrawMC_perFileLoopTop:
    i = 0;
    if (0 < this->pCI->numfiles) {
      do {
        if (this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons != 0) {
          goto DrawMC_cardPulled;
        }
        if ((this->goticon[i] == '\0') && (CURRENTLYUSINGMEMCARD == 0)) {
          if (this->fGetNewIcons == 0) {
            this->LoadIcon(i);
          }
          else {
            goto DrawMC_readyToGetNewIcons;
          }
        }
        if (this->fGetNewIcons != 0) {
DrawMC_readyToGetNewIcons:
          if (this->fReadyToGetNewIcons != 0) {
            this->goticon[i] = '\0';
          }
        }
        if (CURRENTLYUSINGMEMCARD == 0) {
          if (this->goticon[i] != '\0') {
            if (this->fFadeIcon[i] == 0) {
              this->theNFS4icon = MCRD_fileexists(this->card,"NFS4");
              if ((this->fMemCardMessageTextSys != 0x27f) && (this->fMemCardMessageTextSys != 0x27b)
                 ) {
                this->checkingstart = 0;
              }
              if ((this->theNFS4icon != -1) && (this->goticon[this->theNFS4icon] != '\0')) {
                this->fMemCardMessageTextSys = -1;
                sprintf(this->fMemCardMessage,
                           (char *)((int)this->fMemTitle + this->theNFS4icon * 0x20));
              }
              else {
                this->fMemCardMessageTextSys = 0x284;
              }
            }
            goto DrawMC_iconActive;
          }
        }
        else {
DrawMC_iconActive:
          if (this->goticon[i] != '\0') {
            if ((this->fGetNewIcons != 0) && (this->fReadyToGetNewIcons == 0)) {
              this->fFadeIcon[i] = this->fFadeIcon[i] + 8;
              if (0x80 < this->fFadeIcon[i]) {
                this->fFadeIcon[i] = 0x80;
                if (this->fMemIconClutId[i] != 0) {
                  Texture_MenuReleaseClutId(this->fMemIconClutId[i]);
                  this->fMemIconClutId[i] = 0;
                }
                this->goticon[i] = '\0';
                this->numicon[i] = '\0';
                this->numblock[i] = '\0';
              }
            }
            else {
              this->fFadeIcon[i] = this->fFadeIcon[i] - 8;
              if (this->fFadeIcon[i] < 0) {
                this->fFadeIcon[i] = 0;
              }
            }
            this->PlaceIcons(i,fadeval);
          }
        }
        i = i + 1;
      } while (i < this->pCI->numfiles);
    }
DrawMC_afterPerFileLoop:
  if ((this->fGetNewIcons != 0) && (this->fReadyToGetNewIcons != 0)) {
    this->fGetNewIcons = 0;
  }
DrawMC_statusCheckFinal:
  if ((this->pCI->status == -3) && (this->theNFS4icon == -1)) {
    this->fMemCardMessageTextSys = 0x2bf;
  }
  if (CURRENTLYUSINGMEMCARD == 0) {
    MCRD_handlecardevents(this->card);
  }
  return;
}

/* ---- tScreenMemcard::SetEnablings  (screenmemcard.cpp:517) ---- */
void tScreenMemcard::SetEnablings()

{
  /* MATCH (06A SYM-first): the SYM 8c block lists exactly TWO locals --
     `DontChangeEnablings` (class REG $5 = $a1) in the outer block and `i`
     (class REG $3 = $v1) in a NESTED block that closes with the loop, i.e. a
     C++ `for (int i = ...)` scope.  numfiles/walk/status/cheater were Ghidra
     inventions; each cost a pseudo and rotated $a1<->$a2.  The loop bound and
     the walking `fFadeIcon` pointer are compiler artifacts (LICM + giv). */
  bool DontChangeEnablings;

  this->pCI = MCRD_getcard(this->card);
  DontChangeEnablings = false;
  for (int i = 0; i < this->pCI->numfiles; i++) {
    if ((this->goticon[i] == '\0') || (0 < this->fFadeIcon[i])) {
      /* MATCH: NESTED ifs, not `&&` -- the `&&` form lets gcc range-fold the two
         adjacent constants into `(u)(s+2) < 2`; nested tests keep the oracle's two
         separate `beq` against hoisted `li -1` / `li -2`. */
      if (this->pCI->status != -1) {
        if (this->pCI->status != -2) {
          DontChangeEnablings = true;
        }
      }
    }
  }
  if (CURRENTLYUSINGMEMCARD != 0) {
    DontChangeEnablings = true;
  }
  if (!DontChangeEnablings) {
    /* MATCH (SLD 538/539/540): the oracle's `beq` puts the CLEAR arm inline and
       the SET arm out of line -- i.e. the test is `!= -1`, not `== -1`. */
    if (this->theNFS4icon != -1) {
      (menuDefs[0]->itemLoadGame).fFlags =
           (menuDefs[0]->itemLoadGame).fFlags & 0xfffffffe;
    }
    else {
      (menuDefs[0]->itemLoadGame).fFlags =
           (menuDefs[0]->itemLoadGame).fFlags | 1;
    }
    if ((((this->pCI->status == 0) || (this->pCI->status == -2)) ||
        ((this->pCI->status == -3 && (this->theNFS4icon != -1)))) &&
       (this->player == 0)) {
      (menuDefs[0]->itemSaveGame).fFlags =
           (menuDefs[0]->itemSaveGame).fFlags & 0xfffffffe;
    }
    else {
      (menuDefs[0]->itemSaveGame).fFlags =
           (menuDefs[0]->itemSaveGame).fFlags | 1;
    }
  }
  if (FECheat_IsTheUserACryBabyCheater() != 0) {
    (menuDefs[0]->itemSaveGame).fFlags =
         (menuDefs[0]->itemSaveGame).fFlags | 1;
  }
  return;
}

/* ---- tScreenMemcard::DrawBackground  (screenmemcard.cpp:561) ---- */
/* W59-A9 2026-08-14 -- THIS FUNCTION IS BYTE-IDENTICAL TO RETAIL.  The former 2-diff
 * gate result was a VERIFY-TOOL RENDERING ARTIFACT of the same family as the
 * methodology's base+offset "fusion wall" correction, on the ORACLE side this
 * time.  Re-gate: 2 diffs, count-exact 410/410, and the sole diff pair is
 *     ours   `lui v0,0`        (objdump of our UNLINKED .o: imm 0 + R_MIPS_HI16)
 *     oracle `lui v0,32773`    (0x8005)
 * at index 161 (VA 0x800476F4).  Ours carries `R_MIPS_HI16 GRIDMEMCARD_STARTY`
 * there; the oracle .s renders it as the bare constant `lui $v0, (0x80050000 >> 16)`
 * because this particular `lui` is DEAD (its `%lo` partner was optimized away --
 * $v0 is immediately overwritten by TextSys_Word's return), so spimdisasm had no
 * paired %lo from which to recover the symbol and fell back to a literal.
 * PROOF OF BYTE EQUALITY: the same oracle file materializes the same symbol as
 * `lui $t2, %hi(GRIDMEMCARD_STARTY)` encoded `05800A3C` = 0x3c0a8005, i.e.
 * %hi(GRIDMEMCARD_STARTY) == 0x8005 exactly.  Our reloc therefore links to
 * `lui $v0,0x8005` = 0x3c028005, which is the oracle's literal word verbatim.
 * verify_asm normalizes `%hi(SYM)`->0 on both sides but cannot normalize an
 * oracle-side BARE CONSTANT, so the pair false-diffs.
 * ORCHESTRATOR ACTION (tools are off-limits to a worker): in verify_asm.norm_ins,
 * treat an oracle-side `lui rD,(0xNNNN0000 >> 16)` / bare-constant `lui` as 0 ONLY
 * when the paired OURS instruction at the same index carries an R_MIPS_HI16 reloc
 * -- symmetric with the existing LO16-addend zeroing, and narrow enough not to mask
 * a genuine constant `lui` (a real constant `lui` in ours has no HI16 reloc).
 * The verifier now resolves this relocation and reports PASS 410/410. */
void tScreenMemcard::DrawBackground()

{
  short x;
  short y;
  int gray;
  short fade;
  short fadebox;
  short gridpos;
  short fTextFade;
  int ColText;
  RECT rr;
  short i;
  /* SYM-CODEGEN-CARRIER: w -- recomputing the shared box width/height at both
     calls together is FAIL 169 at 419/410 and rotates the whole saved-register
     web; retail retains this independent width result. */
  short w;
  /* SYM-CODEGEN-CARRIER: h -- see `w`; both calls share this half-height value
     in retail rather than rematerializing the geometry expression. */
  short h;
  /* Source-only SYM cleanup (2026-08-26): the earlier all-at-once geometry
     experiment hid one valid simplification.  `width` now folds directly into
     `w` at exact PASS; every surviving SYM-omitted result below was retested in
     isolation and carries its own counterfactual receipt. */
  /* SYM-CODEGEN-CARRIER: gouraudX -- direct constant use is FAIL 28 at
     412/410 and rotates the geometry/global-load allocation web. */
  ushort gouraudX;
  /* SYM-CODEGEN-CARRIER: gouraudY -- direct constant use is FAIL 16 at
     412/410 and rematerializes/reorders the vertical geometry loads. */
  ushort gouraudY;
  /* SYM-CODEGEN-CARRIER: extraY -- direct constant use is count-exact FAIL 20
     and changes both vertical arithmetic and the global-load order. */
  ushort extraY;
  /* SYM-CODEGEN-CARRIER: startX -- direct `GRIDMEMCARD_STARTX` use is
     count-exact FAIL 4 and changes the retail HI16 materialization order. */
  ushort startX;
  /* SYM-CODEGEN-CARRIER: startY -- direct `GRIDMEMCARD_STARTY` use is
     count-exact FAIL 2 and moves retail's `$s2` geometry load past its peer. */
  ushort startY;
  
  this->fMemCardMessageTextSys = -1;
  if (this->goticon[this->theNFS4icon] == '\0') {
    this->theNFS4icon = -1;
  }
  systemtask(0);
  /* SYM/SLD receipt: lines 575-581 are the fade calculation followed by
     three one-line EA MIN/MAX clamps.  Retail's existing short x carries the
     pre-clamp fade value before being reused for geometry; no fadeCalc local
     or compiler fence belongs to the source. */
  fade = (ushort)this->fScreenFadeVal * 2;
  x = (ushort)this->fScreenFadeVal * 2 - 0x80;
  fadebox = (x = MAX(MIN(0x80,x),0));
  gridpos = MAX(MIN(0x80,fade >> 1),0);
  fTextFade = MAX(MIN(0x80,fade * 2),0);
  if (this->fInitedMemCard == 0) {
    this->fMemCardMessageTextSys = 0x27c;
    if ((this->fScreenFadeVal == 0) &&
        (ticks - this->fScreenFadeReadyTick > 0x80)) {
      Init_Memcard(true,false);
      {
        int i;
        for (i = 0; i < 0xf; i++) {
          this->goticon[i] = '\0';
          this->numicon[i] = '\0';
          this->numblock[i] = '\0';
          this->fFadeIcon[i] = 0x80;
        }
      }
      this->fInitedMemCard = 1;
    }
    else if (this->fScreenFadeReadyTick == 0) {
      this->fScreenFadeReadyTick = ticks;
    }
  }
  if ((this->fInitedMemCard != 0) && (fadebox != 0x80)) {
    this->DrawMemCardStuff(fTextFade);
  }
  ColText = CalcFadeVal(kRGBVals[(byte)textDefinitions[6][5]],fTextFade);
  if (this->message != -1) {
    this->fMemCardMessageTextSys = this->message;
  }
  if (this->fMemCardMessageTextSys != -1) {
    sprintf(this->fMemCardMessage,TextSys_Word(this->fMemCardMessageTextSys));
  }
  rr.x = kMemCardMessageX;
  rr.y = kMemCardMessageY;
  rr.w = 0xbe;
  rr.h = 0;
  FETextRender_WordWrapTextRGBJustify(this->fMemCardMessage,rr,ColText,2,0,false);
  FETextRender_FullTextRGB
            (TextSys_Word(this->player + 0x293),kMemCardMessage1X,
             kMemCardMessage1Y,ColText,'\0',2);

  gray = 0x505050;
  startX = GRIDMEMCARD_STARTX;
  gouraudX = GRIDMEMCARDGOURAUDBIT_X;
  startY = GRIDMEMCARD_STARTY;
  gouraudY = GRIDMEMCARDGOURAUDBIT_Y;
  extraY = EXTRAYATTOP;
  x = startX - gouraudX;
  y = startY - gouraudY - (extraY + 4);
  w = GRIDMEMCARD_WIDTH + gouraudX * 2 + 2;
  h = (short)((ushort)GRIDMEMCARD_HEIGHT +
              gouraudY * 2 + (extraY + 6)) / 2;
  SubtractiveBox(x,y,w,h,(i = 0,gray),gray,0,0);
  SubtractiveBox(x,y + h,w,h,0,0,gray,gray);
  PSXDrawSquare
            (0,GRIDMEMCARD_STARTX + 2,kMemCardMessage1Y + -2,GRIDMEMCARD_WIDTH + -4,
             kMemCardMessageH1 + -1);
  PSXDrawSquare
            (0,GRIDMEMCARD_STARTX + 2,GRIDMEMCARD_STARTY + MEMCARD_DELTAY * 5 + 1,
             GRIDMEMCARD_WIDTH + -4,kMemCardMessageH + -1);
  x = GRIDMEMCARD_STARTX;
  for (; i < 4; i++) {
    this->DrawVerticalLine(x,
                     GRIDMEMCARD_STARTY - GRIDMEMCARDGOURAUDBIT_Y - EXTRAYATTOP,
                     gridpos,i % 2);
    x += MEMCARD_DELTAX;
  }
  y = GRIDMEMCARD_STARTY;
  if (EXTRAYATTOP != 0) {
    this->DrawHorizontalLine(GRIDMEMCARD_STARTX - GRIDMEMCARDGOURAUDBIT_X,
                             y - EXTRAYATTOP,gridpos,1);
  }
  for (i = 0; i < 6; i++) {
    this->DrawHorizontalLine(GRIDMEMCARD_STARTX - GRIDMEMCARDGOURAUDBIT_X,
                             y,gridpos,i % 2);
    y += MEMCARD_DELTAY;
  }
  {
    int k;
    y += kMemCardMessageH - MEMCARD_DELTAY;
    this->DrawHorizontalLine(GRIDMEMCARD_STARTX - GRIDMEMCARDGOURAUDBIT_X,
                             y,gridpos,i % 2);
    for (k = 0; k < 0x10; k++) {
      DrawShapeExtended(0x1e + k,0,0,0,fadebox,0,
                        (tDrawShapeExtended *)0x0);
    }
  }
  if (this->fInitedMemCard != 0) {
    this->SetEnablings();
  }
  return;
}

/* ---- tScreenMemcard::DrawForeground  (screenmemcard.cpp:690) ---- */
void tScreenMemcard::DrawForeground()

{
  /* SYM-CODEGEN-CARRIER: fade -- raw retail allocation (IDA $s1; m2c var_a0)
     keeps this clamped value live across the four DrawShapeExtended calls. */
  int fade;
  int k;

  fade = (int)(ushort)this->fScreenFadeVal * 2 + -0x80;
  if ((short)fade < 0x80) {
    if ((short)fade < 1) goto DrawFg_setZero;
  }
  if ((short)fade < 0x81) goto DrawFg_join;
  fade = 0x80;
  goto DrawFg_join;
DrawFg_setZero:
  fade = 0;
DrawFg_join:
  k = 0;
  do {
    DrawShapeExtended(0x38 + k,0,0,0,(short)fade,0,
               (tDrawShapeExtended *)0x0);
    k = k + 1;
  } while (k < 4);
  return;
}

/* ---- tScreenMemcard::tScreenMemcard  (screenmemcard.cpp:704) ---- */
tScreenMemcard::tScreenMemcard()

{
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenMemcard_vtable;
  this->message = -1;
  this->card = 1;
  return;
}

/* ---- tScreenMemcard::ReleaseIcons  (screenmemcard.cpp:710) ---- */
void tScreenMemcard::ReleaseIcons()

{
  int i;

  i = 0;
  do {
    this->goticon[i] = '\0';
    this->numicon[i] = '\0';
    this->numblock[i] = '\0';
    if (this->fMemIconClutId[i] != 0) {
      Texture_MenuReleaseClutId(this->fMemIconClutId[i]);
      this->fMemIconClutId[i] = 0;
    }
    i = i + 1;
  } while (i < 0xf);
  return;
}

/* ---- tScreenMemcard::Initialize  (screenmemcard.cpp:734) ---- */
void tScreenMemcard::Initialize()

{
  /* SYM-CODEGEN-CARRIER: feApp -- direct FEApp member access is count-exact
     FAIL 6 because retail loads the application pointer before publishing the
     reservememadr result; this alias preserves that observable load order. */
  tFEApplication *feApp;
  /* SYM-CODEGEN-CARRIER: msgId -- folding this conditional into the later
     menu-field store is FAIL 43 at 107/106 instructions; the staged value is
     retail's live $a3 across the menuDefs load and has no recoverable name. */
  uint msgId;
  
  GRIDMEMCARD_STARTX = 0xf6;
  GRIDMEMCARD_STARTY = 0x3c;
  MEMCARD_DELTAX = 0x3b;
  MEMCARD_DELTAY = 0x1b;
  kMemCardMessageH1 = 0xc;
  kMemCardMessageH = 0xc;
  EXTRAYATTOP = 0xc;
  GRIDMEMCARD_WIDTH = 0xb1;
  GRIDMEMCARD_HEIGHT = 0x93;
  GRIDMEMCARDGOURAUDBIT_X = 0xc;
  GRIDMEMCARDGOURAUDBIT_Y = 6;
  MEMCARDICONOFFX = 0xf;
  MEMCARDICONOFFY = 6;
  kMemCardMessage1Y = 0x33;
  kMemCardMessageX = 0x150;
  kMemCardMessage1X = 0x150;
  this->fScreenFadeReadyTick = 0;
  kMemCardMessageY = 0xc6;
  fMemIcon = (char (*)[15][3][192])reservememadr("records",0x21c0,0);
  feApp = FEApp;
  this->checkingstart = 0;
  this->memcardanimframe = 0;
  this->count = 0;
  msgId = 0x287;
  this->player = feApp->fInputPlayer;
  this->card = this->player * 4 + 1;
  if (this->player != 0) {
    msgId = 0x289;
  }
  {
    int i = 0;
    /* SYM-CODEGEN-CARRIER: menus -- repeated direct menuDefs[0] addressing is
       FAIL 38 at 110/106 instructions; the shared pointer preserves retail's
       single load and the paired flags-update web. */
    tGlobalMenuDefs *menus = menuDefs[0];
    (menus->itemLoadGame).fTextDescription = msgId;
    (menus->itemSaveGame).fFlags |= 1;
    (menus->itemLoadGame).fFlags |= 1;
    do {
      this->goticon[i] = '\0';
      this->numicon[i] = '\0';
      this->numblock[i] = '\0';
      /* Direct indexing lets GCC share the retail this + i * 2 base. */
      this->fFadeIcon[i] = 0x80;
      this->fMemIconClutId[i] = 0;
      i = i + 1;
    } while (i < 0xf);
  }
  this->fInitedMemCard = 0;
  this->fGetNewIcons = 0;
  this->fReadyToGetNewIcons = 0;
  this->theNFS4icon = -1;
  this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
  this->tScreen::Initialize();
  return;
}

/* ---- tScreenMemcard::Cleanup  (screenmemcard.cpp:833) ---- */
void tScreenMemcard::Cleanup()

{
  /* SYM-CODEGEN-CARRIER: menus -- direct global/member spelling is measured
     FAIL 20 (27/25) and loses retail's shared menuDefs base. */
  tGlobalMenuDefs *menus;
  /* SYM-CODEGEN-CARRIER: iconTable -- paired address carrier in that receipt. */
  char (*iconTable) [15] [3] [192];

  this->ReleaseIcons();
  DeInit_Memcard();
  iconTable = fMemIcon;
  menus = menuDefs[0];
  (menus->itemSaveGame).fFlags =
       (menus->itemSaveGame).fFlags & 0xfffffffe;
  (menus->itemLoadGame).fFlags =
       (menus->itemLoadGame).fFlags & 0xfffffffe;
  purgememadr(iconTable);
  this->tScreen::Cleanup();
  return;
}

/* ---- tScreenMemcard::~tScreenMemcard  (screenmemcard.cpp:99) ---- */
/* WALL (methodology 3.23): oracle = simple base-forward (8 insns: jal ~tScreen; ret).
   Composition modeling (tScreen _base_tScreen member w/ a dtor) forces gcc's DELETING
   variant (__in_chrg arg + andi&1 + __builtin_delete), 18 insns. The fix is real
   non-polymorphic inheritance (struct tScreenMemcard : public tScreen), a SHARED-HEADER
   change in nfs4_types.h (forbidden here; would also rebuild every tScreenMemcard
   accessor per gotcha #0). Left as a documented near-miss. */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___14tScreenMemcard(void *thisp) { ___7tScreen(thisp); }

/* end of screenmemcard.cpp */

#undef GRIDMEMCARD_STARTX
#undef GRIDMEMCARD_STARTY
#undef MEMCARD_DELTAX
#undef MEMCARD_DELTAY
#undef EXTRAYATTOP
#undef GRIDMEMCARDGOURAUDBIT_X
#undef GRIDMEMCARDGOURAUDBIT_Y
#undef GRIDMEMCARD_WIDTH
#undef GRIDMEMCARD_HEIGHT
#undef MEMCARDICONOFFX
#undef MEMCARDICONOFFY
#undef kMemCardMessageX
#undef kMemCardMessageY
#undef kMemCardMessage1X
#undef kMemCardMessage1Y
#undef kMemCardMessageH
#undef kMemCardMessageH1

tScreenMemcard *screenMemcard;              /* @0x800528f0 */
int GRIDMEMCARD_STARTX;                      /* @0x800528f4 */
int GRIDMEMCARD_STARTY;                      /* @0x800528f8 */
int MEMCARD_DELTAX;                          /* @0x800528fc */
int MEMCARD_DELTAY;                          /* @0x80052900 */
int kMemCardMessageH;                        /* @0x80052904 */
int kMemCardMessageH1;                       /* @0x80052908 */
int EXTRAYATTOP;                              /* @0x8005290c */
int GRIDMEMCARD_WIDTH;                       /* @0x80052910 */
int GRIDMEMCARD_HEIGHT;                      /* @0x80052914 */
int GRIDMEMCARDGOURAUDBIT_X;                 /* @0x80052918 */
int GRIDMEMCARDGOURAUDBIT_Y;                 /* @0x8005291c */
int MEMCARDICONOFFX;                         /* @0x80052920 */
int MEMCARDICONOFFY;                         /* @0x80052924 */
int kMemCardMessage1X;                       /* @0x80052928 */
int kMemCardMessage1Y;                       /* @0x8005292c */
int kMemCardMessageX;                        /* @0x80052930 */
int kMemCardMessageY;                        /* @0x80052934 */
char (*fMemIcon)[15][3][192];                /* @0x80052938 */
