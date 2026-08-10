/* frontend/common/screenmemcard.cpp  --  RECONSTRUCTED  (memcard UI screen; C++ TU)
 *   15 MEMBER fns of tScreenMemcard : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenmemcard.h"

typedef struct {
  u_int addr : 24;
  u_int len : 8;
} tMemcardPrimTag;

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
/* RESIDUAL 23 (ours 214 / oracle 215) -- 2026-08-10: direct
   `fMemIcon[filenum][i]` indexing removed the fabricated shape-data,
   byte-offset, X-scale, and file-offset locals and reduced 43 -> 23.  GCC now
   synthesizes retail's byte-offset and X-position induction variables.  The
   remainder is local allocation: retail assigns named `i` to s1 and its
   strength-reduction GIV to s0 (ours are swapped), and keeps the shared 1 in
   t0 where ours uses v0/s7.  A for-loop spelling was worse (25 @ 216/215).
   Defer this QTY/allocator angle to the last rounds. */
void tScreenMemcard::LoadIcon(int filenum)

{
  bool done;
  int i;
  shapetbl *iconShape;
  int clutx;
  int cluty;
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
      iconShape = (shapetbl *)(*fMemIcon[0] + filenum);
      this->fMemFile[filenum].icon[0] = iconShape;
      this->fMemFile[filenum].icon[1] = (shapetbl *)&*(int *)((char *)&iconShape[9] + 0xc);
      this->fMemFile[filenum].icon[2] = (shapetbl *)&iconShape[0x13].width;
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
          this->numblock[filenum] = (uchar)i;
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
          if (this->numicon[filenum] != '\0') {
            i = 0;
            do {
              if (((*fMemIcon[0])[filenum][i][0] & 0xf7U) == 0x40) {
                vramfxya((*fMemIcon[0])[filenum][i],i * 0x11 + 900,
                         filenum * 0x11,clutx,cluty);
              }
              i = i + 1;
            } while (i < (int)(uint)this->numicon[filenum]);
          }
          this->fFadeIcon[filenum] = 0x80;
          this->goticon[filenum] = '\x01';
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
          this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 1;
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
  int height;

  /* MATCH (SLD 265 = ONE source line for the whole clamp): the 0x40 arm is
     OUT OF LINE (oracle `beqz` branches FORWARD to it, past the =0 block, which
     ends with its own `j`), so it must be a goto target, not the fall-through. */
  if (0 < gridpos) {
    if (0x40 <= gridpos) goto VL_clampHi;
  }
  if (gridpos < 0) {
    gridpos = 0;
  }
  goto VL_clamped;
VL_clampHi:
  gridpos = 0x40;
VL_clamped:
  /* MATCH (SLD 267 = ONE statement): EXTRAYATTOP + (HEIGHT + GOURAUDBIT_Y*2) --
     two statements let gcc reassociate to (EXTRAYATTOP + GOURAUD*2) + HEIGHT. */
  height = (ushort)EXTRAYATTOP +
           ((ushort)GRIDMEMCARD_HEIGHT + (ushort)GRIDMEMCARDGOURAUDBIT_Y * 2);
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,(short)height,
             (uint)(dir == 0),(int)gridpos * 2,0);
  return;
}

/* ---- tScreenMemcard::DrawHorizontalLine  (screenmemcard.cpp:273) ---- */
void tScreenMemcard::DrawHorizontalLine(short x,short y,short gridpos,short dir)

{
  int width;

  /* MATCH (SLD 274 = ONE source line for the whole clamp): the 0x40 arm is OUT
     OF LINE (oracle `beqz` branches forward past the =0 block, which ends with
     its own `j`), so it is a goto target, not the fall-through. */
  /* RESIDUAL 16 (count-exact 48/48) -- PARAM-COPY-QTY-ABSORBS-SIGN-EXTEND, the
     06E named-gap class, shared with DrawVerticalLine (26 @ 47/45).  SYM:
     gridpos is REGPARM $8 ($t0) here / $7 ($a3) in DrawVerticalLine.  Retail
     sign-extends into a FRESH pair (`sll v0,a3,16; sra v1,v0,16`) and keeps
     gridpos live in its incoming HImode arg home for the clamp writes + the post-
     clamp copy; our cc1plus emits the assign_parms copy at ENTRY, which kills
     $a3 so the extend reuses it in place and the clamp targets the copy instead.
     FALSIFIED here (W55-A14): an explicit `int g = gridpos;` chain-source local
     for the three tests -- gcc coalesces `g` straight back into $a3, byte-
     identical output.  The reachable dial is the parm-copy POSITION (w46 park
     class / w47-a1 fence probe), not a source spelling of the compare operand. */
  /* MATCH: the tests read a SEPARATE sign-extended value (`sll v0,a3,16;
     sra v1,v0,16` into fresh pseudos) while `gridpos` itself stays live in its
     HImode arg home ($a3) for the post-clamp copy -- so the extend chain must
     SOURCE gridpos, not overwrite it. */
  if (0 < gridpos) {
    if (0x40 <= gridpos) goto HL_clampHi;
  }
  if (gridpos < 0) {
    gridpos = 0;
  }
  goto HL_clamped;
HL_clampHi:
  gridpos = 0x40;
HL_clamped:
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
  shapetbl *icon;
  short xx;
  int j;
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
    /* MATCH: the natural signed-short coordinate expressions and the
       sum-before-limit spelling below reproduce retail's register homes and
       branch direction. They reduce this body from 73 diffs to 4 at identical
       213-insn length. The residue is two sched2 relocations (`yy`'s s0 copy
       and the width constant); read-only fence (5), named width (6), and named
       fade (78) basins are worse, so leave that scheduler-only angle for the
       final hard round. `ticks>>4` divided by numicon[i] is a genuine RUNTIME
       div (the oracle carries the div-by-0/overflow guard), NOT a shift -- numicon[i]
       is a per-instance byte, not a compile-time constant. The remainder
       selects the icon's animation frame. */
    animFrame = (ticks >> 4) % this->numicon[i];
    if (i == this->theNFS4icon) {
      fFlags.tint[0] = 0xb55623;
      DrawShapeExtended(this->memcardanimframe,0x410,xx - 0xf2,yy - 0x70,
                 fadeval + this->fFadeIcon[i] < 0x81 ?
                 fadeval + this->fFadeIcon[i] : 0x80,1,
                 &fFlags);
    }
    else {
      icon = (shapetbl *)(*fMemIcon[0])[i][animFrame];
      this->DrawIcon(icon,xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,0x1f,0x10,
                 (short)(fadeval + this->fFadeIcon[i] < 0x81 ?
                         fadeval + this->fFadeIcon[i] : 0x80));
    }
    if (((this->theNFS4icon == i) && (fadeval == 0)) && (this->fGetNewIcons == 0)) {
      xx = xx * 0x10000 >> 0x10;
      yy = (int)(short)yy;
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
  }
  else {
    i = 0;
    this->fReadyToGetNewIcons = 1;
    if (0 < this->pCI->numfiles) {
      do {
        if (this->fFadeIcon[i] < 0x80) {
          this->fReadyToGetNewIcons = 0;
        }
        i = i + 1;
      } while (i < this->pCI->numfiles);
    }
  }
DrawMC_perFileLoopTop:
    i = 0;
    if (0 < this->pCI->numfiles) {
      do {
        if (this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons != 0) {
          this->ReleaseIcons();
          this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
          this->fGetNewIcons = 0;
          break;
        }
        if ((this->goticon[i] == '\0') && (CURRENTLYUSINGMEMCARD == 0)) {
          if (this->fGetNewIcons == 0) {
            this->LoadIcon(i);
            goto DrawMC_getNewIconsCheck;
          }
DrawMC_readyToGetNewIcons:
          if (this->fReadyToGetNewIcons != 0) {
            this->goticon[i] = '\0';
          }
        }
        else {
DrawMC_getNewIconsCheck:
          if (this->fGetNewIcons != 0) goto DrawMC_readyToGetNewIcons;
        }
        if (CURRENTLYUSINGMEMCARD == 0) {
          if (this->goticon[i] != '\0') {
            if (this->fFadeIcon[i] == 0) {
              this->theNFS4icon = MCRD_fileexists(this->card,"NFS4");
              if ((this->fMemCardMessageTextSys != 0x27f) && (this->fMemCardMessageTextSys != 0x27b)
                 ) {
                this->checkingstart = 0;
              }
              if ((this->theNFS4icon == -1) || (this->goticon[this->theNFS4icon] == '\0')) {
                this->fMemCardMessageTextSys = 0x284;
              }
              else {
                this->fMemCardMessageTextSys = -1;
                sprintf(this->fMemCardMessage,
                           (char *)((int)this->fMemTitle + this->theNFS4icon * 0x20));
              }
            }
            goto DrawMC_iconActive;
          }
        }
        else {
DrawMC_iconActive:
          if (this->goticon[i] != '\0') {
            if ((this->fGetNewIcons == 0) || (this->fReadyToGetNewIcons != 0)) {
              this->fFadeIcon[i] = this->fFadeIcon[i] - 8;
              if (this->fFadeIcon[i] < 0) {
                this->fFadeIcon[i] = 0;
              }
            }
            else {
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
            this->PlaceIcons(i,fadeval);
          }
        }
        i = i + 1;
      } while (i < this->pCI->numfiles);
    }
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
  if (FECheat_IsTheUserACryBabyCheater() != (void *)0x0) {
    (menuDefs[0]->itemSaveGame).fFlags =
         (menuDefs[0]->itemSaveGame).fFlags | 1;
  }
  return;
}

/* ---- tScreenMemcard::DrawBackground  (screenmemcard.cpp:561) ---- */
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
  short w;
  short h;
  int value;
  
  this->fMemCardMessageTextSys = -1;
  if (this->goticon[this->theNFS4icon] == '\0') {
    this->theNFS4icon = -1;
  }
  systemtask(0);
  fade = (ushort)this->fScreenFadeVal * 2;
  if ((short)(fade - 0x80) < 0x80) {
    if ((short)(fade - 0x80) <= 0) goto DrawBgFadeboxZero;
  }
  if ((short)(fade - 0x80) < 0x81) goto DrawBgFadeboxNormal;
  fadebox = 0x80;
  goto DrawBgFadeboxDone;
DrawBgFadeboxZero:
  fadebox = 0;
  goto DrawBgFadeboxDone;
DrawBgFadeboxNormal:
  fadebox = fade - 0x80;
DrawBgFadeboxDone:
  if ((fade >> 1) < 0x80) {
    if ((fade >> 1) <= 0) goto DrawBgGridposZero;
  }
  if ((fade >> 1) < 0x81) goto DrawBgGridposNormal;
  gridpos = 0x80;
  goto DrawBgGridposDone;
DrawBgGridposZero:
  gridpos = 0;
  goto DrawBgGridposDone;
DrawBgGridposNormal:
  gridpos = fade >> 1;
DrawBgGridposDone:
  value = fade * 2;
  if (value > 0x80) {
    value = 0x80;
  }
  if (value < 0) {
    value = 0;
  }
  fTextFade = value;
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
  x = (ushort)GRIDMEMCARD_STARTX - (ushort)GRIDMEMCARDGOURAUDBIT_X;
  y = (ushort)GRIDMEMCARD_STARTY - (ushort)GRIDMEMCARDGOURAUDBIT_Y -
      ((ushort)EXTRAYATTOP + 4);
  w = (ushort)GRIDMEMCARD_WIDTH + (ushort)GRIDMEMCARDGOURAUDBIT_X * 2 + 2;
  h = (short)((ushort)GRIDMEMCARD_HEIGHT +
              (ushort)GRIDMEMCARDGOURAUDBIT_Y * 2 +
              (ushort)EXTRAYATTOP + 6) / 2;
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
  this->DrawHorizontalLine(GRIDMEMCARD_STARTX - GRIDMEMCARDGOURAUDBIT_X,
                           y + kMemCardMessageH - MEMCARD_DELTAY,
                           gridpos,i % 2);
  {
    int k;
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
  int inputPlayer;
  tFEApplication *feApp;
  tGlobalMenuDefs *menus;
  uint saveFlags;
  uint loadFlags;
  int i;
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
  fMemIcon[0] = (char (*)[15][3][192])reservememadr("records",0x21c0,0);
  feApp = FEApp;
  this->checkingstart = 0;
  this->memcardanimframe = 0;
  this->count = 0;
  inputPlayer = feApp->fInputPlayer;
  msgId = 0x287;
  this->player = (ushort)inputPlayer;
  this->card = (uint)inputPlayer * 4 + 1;
  if (this->player != 0) {
    msgId = 0x289;
  }
  i = 0;
  menus = menuDefs[0];
  saveFlags = (menus->itemSaveGame).fFlags;
  loadFlags = (menus->itemLoadGame).fFlags;
  (menus->itemLoadGame).fTextDescription = msgId;
  (menus->itemSaveGame).fFlags = saveFlags | 1;
  (menus->itemLoadGame).fFlags = loadFlags | 1;
  do {
    this->goticon[i] = '\0';
    this->numicon[i] = '\0';
    this->numblock[i] = '\0';
    /* Direct indexing lets GCC share the retail this + i * 2 base. */
    this->fFadeIcon[i] = 0x80;
    this->fMemIconClutId[i] = 0;
    i = i + 1;
  } while (i < 0xf);
  this->fInitedMemCard = 0;
  this->fGetNewIcons = 0;
  this->fReadyToGetNewIcons = 0;
  this->theNFS4icon = -1;
  this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
  this->Initialize();
  return;
}

/* ---- tScreenMemcard::Cleanup  (screenmemcard.cpp:833) ---- */
void tScreenMemcard::Cleanup()

{
  tGlobalMenuDefs *menus;
  char (*iconTable) [15] [3] [192];

  this->ReleaseIcons();
  DeInit_Memcard();
  iconTable = fMemIcon[0];
  menus = menuDefs[0];
  (menus->itemSaveGame).fFlags =
       (menus->itemSaveGame).fFlags & 0xfffffffe;
  (menus->itemLoadGame).fFlags =
       (menus->itemLoadGame).fFlags & 0xfffffffe;
  purgememadr(iconTable);
  this->Cleanup();
  return;
}

/* ---- tScreenMemcard::~tScreenMemcard  (screenmemcard.cpp:99) ---- */
/* WALL (methodology 3.23): oracle = simple base-forward (8 insns: jal ~tScreen; ret).
   Composition modeling (tScreen _base_tScreen member w/ a dtor) forces gcc's DELETING
   variant (__in_chrg arg + andi&1 + __builtin_delete), 18 insns. The fix is real
   non-polymorphic inheritance (struct tScreenMemcard : public tScreen), a SHARED-HEADER
   change in nfs4_types.h (forbidden here; would also rebuild every tScreenMemcard
   accessor per gotcha #0). Left as a documented near-miss. */
tScreenMemcard::~tScreenMemcard()

{
  return;
}

/* end of screenmemcard.cpp */
