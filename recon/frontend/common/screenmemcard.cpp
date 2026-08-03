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
  int n;
  byte iconType;
  short srcW;
  short srcH;
  int destBright;
  int pkt_addr24;
  int tc1;
  int destBrightLow;
  int v0;
  int v1;
  short loop_or_color;
  uint pktAddr;
  byte *iconData;
  u_char *cur_pkt;
  u_char *prev_pkt;
  byte u0;
  short ts4;
  short ts8;

  /* MATCH: the div-by-4 (and the shift-by-4 feeding it) reach the oracle as a
     runtime `div`+overflow/zero guard and a variable-shift `sllv`, not a
     folded `<<2` -- both operands trace to ONE non-literal local materialised
     in the prologue (before any icon field is even read). */
  iconData = (byte *)icon;
  n = 4;
  iconType = *iconData;
  srcW = *(short *)(iconData + 4);
  srcH = *(short *)(iconData + 6);
  destBright = (*(int *)(iconData + 0xc) << 4) >> 0x14;
  pkt_addr24 = (*(int *)(iconData + 0xc) << 0x14) >> 0x14;
  tc1 = ((pkt_addr24 & 0x3f) << n) / n;
  destBrightLow = destBright % 256;

  prev_pkt = Render_gPacketPtr;
  cur_pkt = Render_gPalettePtr;
  *(uint *)prev_pkt =
       *(uint *)prev_pkt & 0xff000000 | *(uint *)cur_pkt & 0xffffff;
  pktAddr = (uint)prev_pkt & 0xffffff;
  Render_gPacketPtr = prev_pkt + 0x28;
  *(uint *)cur_pkt = *(uint *)cur_pkt & 0xff000000 | pktAddr;
  prev_pkt[7] = 0x2e;
  prev_pkt[3] = 9;
  u0 = -0x80 - fFade;
  prev_pkt[4] = u0;
  prev_pkt[5] = u0;
  loop_or_color = shapetoclutid(iconData);
  prev_pkt[6] = u0;
  *(short *)(prev_pkt + 0xe) = loop_or_color;
  *(ushort *)(prev_pkt + 0x16) =
       (iconType & 3) << 7 | (ushort)((int)(destBright & 0x100U) >> 4) |
       (ushort)((int)(pkt_addr24 & 0x3ffU) >> 6) | (ushort)((destBright & 0x200U) << 2);
  v1 = tc1 + srcW;
  prev_pkt[0xc] = tc1;
  prev_pkt[0xd] = destBrightLow;
  prev_pkt[0x14] = v1;
  prev_pkt[0x15] = destBrightLow;
  prev_pkt[0x1c] = tc1;
  v0 = destBrightLow + srcH;
  prev_pkt[0x1d] = v0;
  prev_pkt[0x24] = v1;
  prev_pkt[0x25] = v0;
  *(short *)(prev_pkt + 8) = (short)x;
  *(short *)(prev_pkt + 10) = (short)y;
  *(short *)(prev_pkt + 0x12) = (short)y;
  *(short *)(prev_pkt + 0x18) = (short)x;
  ts8 = (short)(x + destwidth);
  *(short *)(prev_pkt + 0x10) = ts8;
  *(short *)(prev_pkt + 0x20) = ts8;
  ts4 = (short)(y + destheight);
  *(short *)(prev_pkt + 0x1a) = ts4;
  *(short *)(prev_pkt + 0x22) = ts4;
  return;
}

/* ---- tScreenMemcard::LoadIcon  (screenmemcard.cpp:145) ---- */
void tScreenMemcard::LoadIcon(int filenum)

{
  bool done;
  int i;
  int idx;
  shapetbl *iconShape;
  CARDINFO_def *cardInfo;
  char *shape_data;
  int byteOff;
  short x_scale;
  int clutx;
  int cluty;
  int fileOff8;
  
  i = AudioMus_Buffered();
  idx = AudioMus_Threshold();
  if (idx <= i) {
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
      done = false;
      MCRD_loadfile(this->card,this->fMemFile + filenum,1);
      fileOff8 = filenum << 3;
      while (!done) {
        cardInfo = MCRD_getcard(this->card);
        if (cardInfo->status == -1) {
          this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 1;
        }
        i = MCRD_handlecardevents(this->card);
        switch(i) {
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
          i = 0;
          if (this->numicon[filenum] != '\0') {
            x_scale = 900;
            byteOff = 0;
            idx = fileOff8 + filenum;
            do {
              shape_data = (*fMemIcon[0])[0][0] + byteOff + idx * 0x40;
              if ((*shape_data & 0xf7U) == 0x40) {
                vramfxya(shape_data,x_scale,(short)filenum * 0x11,(short)clutx,cluty);
              }
              x_scale = x_scale + 0x11;
              i = i + 1;
              byteOff = byteOff + 0xc0;
            } while (i < (int)(uint)this->numicon[filenum]);
          }
          this->fFadeIcon[filenum] = 0x80;
          this->goticon[filenum] = '\x01';
        }
      }
    }
LoadIcon_clearCardFlag:
    CURRENTLYUSINGMEMCARD = 0;
  }
  return;
}

/* ---- tScreenMemcard::DrawVerticalLine  (screenmemcard.cpp:264) ---- */
void tScreenMemcard::DrawVerticalLine(short x,short y,short gridpos,short dir)

{
  int height;
  int g = gridpos;

  /* MATCH: same two-guard clamp as DrawHorizontalLine -- see there. */
  if (0 < g) {
    if (0x40 <= g) {
      gridpos = 0x40;
    }
  }
  if (g < 0) {
    gridpos = 0;
  }
  height = (ushort)GRIDMEMCARD_HEIGHT + (ushort)GRIDMEMCARDGOURAUDBIT_Y * 2;
  height = (ushort)EXTRAYATTOP + height;
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,(short)height,
             (uint)(dir == 0),(int)gridpos * 2,0);
  return;
}

/* ---- tScreenMemcard::DrawHorizontalLine  (screenmemcard.cpp:273) ---- */
void tScreenMemcard::DrawHorizontalLine(short x,short y,short gridpos,short dir)

{
  int side;
  int width;
  int g = gridpos;

  /* MATCH: the oracle keeps BOTH guards (blez + slti 0x40) -- an
     `x<1 || x<0x40` spelling folds to one slti.  Clamp-high first,
     clamp-low as the else-if. */
  if (0 < g) {
    if (0x40 <= g) {
      gridpos = 0x40;
    }
  }
  if (g < 0) {
    gridpos = 0;
  }
  width = (ushort)GRIDMEMCARDGOURAUDBIT_X * 2 + 2;
  width = (ushort)GRIDMEMCARD_WIDTH + width;
  if (dir == 0) {
    side = 2;
  }
  else {
    side = 3;
  }
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,(short)width,
             1,side,(int)gridpos * 2,GRIDMEMCARDGOURAUDBIT_X);
  return;
}

/* ---- tScreenMemcard::PlaceIcons  (screenmemcard.cpp:282) ---- */
void tScreenMemcard::PlaceIcons(int i,int fadeval)

{
  int fade;
  int yy;
  shapetbl *icon;
  short xx;
  int j;
  int animFrame;
  tDrawShapeExtended fFlags;

  for (j = 0; j < (int)(uint)this->numblock[i]; j = j + 1) {
    yy = (int)this->cursorPosition;
    if ((yy / 3 & 1U) == 0) {
      yy = (yy % 3) * 0x10000 >> 0x10;
    }
    else {
      yy = 2 - ((yy % 3) * 0x10000 >> 0x10);
    }
    xx = (MEMCARDICONOFFX & 0xffffU) + (uint)(ushort)GRIDMEMCARD_STARTX + MEMCARD_DELTAX * yy;
    yy = (uint)(ushort)GRIDMEMCARD_STARTY + (MEMCARDICONOFFY & 0xffffU) +
            (4 - (((int)this->cursorPosition / 3) * 0x10000 >> 0x10)) * MEMCARD_DELTAY;
    /* MATCH: `ticks>>4` divided by numicon[i] is a genuine RUNTIME div (the
       oracle carries the div-by-0/overflow guard), NOT a shift -- numicon[i]
       is a per-instance byte, not a compile-time constant. The remainder
       selects the icon's animation frame. */
    animFrame = (ticks >> 4) % this->numicon[i];
    if (i == this->theNFS4icon) {
      fFlags.tint[0] = 0xb55623;
      fade = fadeval + this->fFadeIcon[i];
      if (0x80 < fade) {
        fade = 0x80;
      }
      DrawShapeExtended(this->memcardanimframe,0x410,xx - 0xf2,yy - 0x70,fade,1,
                 &fFlags);
    }
    else {
      icon = (shapetbl *)(*fMemIcon[0])[i][animFrame];
      fade = fadeval + this->fFadeIcon[i];
      if (0x80 < fade) {
        fade = 0x80;
      }
      this->DrawIcon(icon,xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,0x1f,0x10,(short)fade);
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
  bool DontChangeEnablings;
  int status;
  void *cheater;
  int i;
  tScreenMemcard *walk;
  int numfiles;

  this->pCI = MCRD_getcard(this->card);
  i = 0;
  numfiles = this->pCI->numfiles;
  DontChangeEnablings = false;
  walk = this;
  if (0 < numfiles) {
    do {
      if ((this->goticon[i] == '\0') || (0 < walk->fFadeIcon[0])) {
        status = this->pCI->status;
        if (status != -1) {
          if (status != -2) {
            DontChangeEnablings = true;
          }
        }
      }
      i = i + 1;
      walk = (tScreenMemcard *)((int)&(walk)->fPermShapes.fShapes + 2);
    } while (i < numfiles);
  }
  if (CURRENTLYUSINGMEMCARD != 0) {
    DontChangeEnablings = true;
  }
  if (!DontChangeEnablings) {
    if (this->theNFS4icon == -1) {
      (menuDefs[0]->itemLoadGame).fFlags =
           (menuDefs[0]->itemLoadGame).fFlags | 1;
    }
    else {
      (menuDefs[0]->itemLoadGame).fFlags =
           (menuDefs[0]->itemLoadGame).fFlags & 0xfffffffe;
    }
    i = this->pCI->status;
    if ((((i == 0) || (i == -2)) || ((i == -3 && (this->theNFS4icon != -1)))) &&
       (this->player == 0)) {
      (menuDefs[0]->itemSaveGame).fFlags =
           (menuDefs[0]->itemSaveGame).fFlags & 0xfffffffe;
    }
    else {
      (menuDefs[0]->itemSaveGame).fFlags =
           (menuDefs[0]->itemSaveGame).fFlags | 1;
    }
  }
  cheater = FECheat_IsTheUserACryBabyCheater();
  if (cheater != (void *)0x0) {
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
