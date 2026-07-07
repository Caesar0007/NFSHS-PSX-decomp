/* frontend/common/screenmemcard.cpp  --  RECONSTRUCTED  (memcard UI screen; C++ TU)
 *   15 MEMBER fns of tScreenMemcard : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenmemcard.h"

/* layout int globals owned by this TU (SYM EXT @0x800528xx; set in Initialize) */
int GRIDMEMCARD_STARTX, GRIDMEMCARD_STARTY, MEMCARD_DELTAX, MEMCARD_DELTAY;
int EXTRAYATTOP, GRIDMEMCARDGOURAUDBIT_X, GRIDMEMCARDGOURAUDBIT_Y;
int GRIDMEMCARD_WIDTH, GRIDMEMCARD_HEIGHT, MEMCARDICONOFFX, MEMCARDICONOFFY;
int kMemCardMessageX, kMemCardMessageY, kMemCardMessage1X, kMemCardMessage1Y;
int kMemCardMessageH, kMemCardMessageH1;
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
  u_short srcW;
  u_short srcH;
  byte u0;
  byte v0;
  short ts4;
  int pkt_addr24;
  int loop_or_color;
  byte v1;
  short ts8;
  uint pktAddr;
  byte *iconData;
  int destBright;
  byte u1;
  short ts5;
  short ts6;
  byte tc1;
  u_char *cur_pkt;
  u_char *prev_pkt;
  byte iconType;
  
  prev_pkt = Render_gPacketPtr;
  cur_pkt = Render_gPalettePtr;
  iconType = *iconData;
  srcW = *(u_short *)(iconData + 4);
  srcH = *(u_short *)(iconData + 6);
  destBright = (*(int *)(iconData + 0xc) << 4) >> 0x14;
  pkt_addr24 = (*(int *)(iconData + 0xc) << 0x14) >> 0x14;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  pktAddr = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x28;
  *(uint *)cur_pkt = *(uint *)cur_pkt & 0xff000000 | pktAddr;
  prev_pkt[7] = 0x2e;
  prev_pkt[3] = 9;
  u0 = 0x80 - (char)fFade;
  prev_pkt[4] = u0;
  prev_pkt[5] = u0;
  prev_pkt[6] = u0;
  loop_or_color = shapetoclutid(iconData);
  *(short *)(prev_pkt + 0xe) = (short)loop_or_color;
  *(ushort *)(prev_pkt + 0x16) =
       (iconType & 3) << 7 | (ushort)((int)(destBright & 0x100U) >> 4) |
       (ushort)((int)(pkt_addr24 & 0x3ffU) >> 6) | (ushort)((destBright & 0x200U) << 2);
  tc1 = (byte)(((pkt_addr24 & 0x3fU) << 4) / 4);
  v1 = tc1 + (char)srcW;
  prev_pkt[0xc] = tc1;
  u1 = (byte)destBright;
  prev_pkt[0xd] = u1;
  prev_pkt[0x14] = v1;
  prev_pkt[0x15] = u1;
  prev_pkt[0x1c] = tc1;
  v0 = u1 + (char)srcH;
  prev_pkt[0x1d] = v0;
  prev_pkt[0x24] = v1;
  prev_pkt[0x25] = v0;
  ts5 = (short)x;
  *(short *)(prev_pkt + 8) = ts5;
  ts6 = (short)y;
  *(short *)(prev_pkt + 10) = ts6;
  *(short *)(prev_pkt + 0x12) = ts6;
  *(short *)(prev_pkt + 0x18) = ts5;
  ts8 = ts5 + (short)destwidth;
  *(short *)(prev_pkt + 0x10) = ts8;
  *(short *)(prev_pkt + 0x20) = ts8;
  ts4 = ts6 + (short)destheight;
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
  int fileOff2;
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
        fileOff2 = filenum * 2;
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
          this->numicon[filenum] =
               *(char *)this->fMemFile[0].icon[filenum * 3 + fileOff2 * 4 + 3] + 0xf0;
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
  uint depth;
  
  depth = (uint)(ushort)gridpos;
  if ((gridpos < 1) || (gridpos < 0x40)) {
    if (gridpos < 0) {
      depth = 0;
    }
  }
  else {
    depth = 0x40;
  }
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,
             (int)(((uint)(ushort)EXTRAYATTOP +
                   (uint)(ushort)GRIDMEMCARD_HEIGHT + (uint)(ushort)GRIDMEMCARDGOURAUDBIT_Y * 2) *
                  0x10000) >> 0x10,(uint)(dir == 0),(int)(depth << 0x10) >> 0xf,0);
  return;
}

/* ---- tScreenMemcard::DrawHorizontalLine  (screenmemcard.cpp:273) ---- */
void tScreenMemcard::DrawHorizontalLine(short x,short y,short gridpos,short dir)

{
  int side;
  
  if (((short)gridpos < 1) || ((short)gridpos < 0x40)) {
    if ((short)gridpos < 0) {
      gridpos = 0;
    }
  }
  else {
    gridpos = 0x40;
  }
  if (dir == 0) {
    side = 2;
  }
  else {
    side = 3;
  }
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,
             (int)(((uint)(ushort)GRIDMEMCARD_WIDTH + (GRIDMEMCARDGOURAUDBIT_X & 0xffffU) * 2 + 2) *
                  0x10000) >> 0x10,1,side,(int)((uint)gridpos << 0x10) >> 0xf,GRIDMEMCARDGOURAUDBIT_X)
  ;
  return;
}

/* ---- tScreenMemcard::PlaceIcons  (screenmemcard.cpp:282) ---- */
void tScreenMemcard::PlaceIcons(int i,int fadeval)

{
  short fFade;
  u_char *fade;
  int yy;
  shapetbl *icon;
  short xx;
  int j;
  int shapeFlags;
  int shapeX;
  int shapeY;
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
    if (i == this->theNFS4icon) {
      fFlags.tint[0] = 0xb55623;
      fade = (u_char *)(&*(int *)((char *)icon + 0x0) + this->fFadeIcon[i]);
      if (0x80 < (int)fade) {
        fade = (u_char *)0x80;
      }
      DrawShapeExtended((int)icon,shapeFlags,shapeX,shapeY,(int)fade,1,
                 &fFlags);
    }
    else {
      fFade = (short)((uint)((int)(&*(int *)((char *)icon + 0x0) + this->fFadeIcon[i]) * 0x10000) >> 0x10);
      if (0x80 < (int)(&*(int *)((char *)icon + 0x0) + this->fFadeIcon[i])) {
        fFade = 0x80;
      }
      this->DrawIcon(icon,xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,0x1f,0x10,fFade);
    }
    if (((this->theNFS4icon == i) && (icon == (shapetbl *)0x0)) && (this->fGetNewIcons == 0)) {
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
  short fileIdx;
  short fadeInc;
  ushort fade;
  CARDINFO_def *cardInfo;
  int idx;
  int i;
  
  cardInfo = MCRD_getcard(this->card);
  this->pCI = cardInfo;
  this->cursorPosition = 0;
  if (this->theNFS4icon == -1) {
    this->memcardanimframe = 0;
    this->count = 0;
  }
  else {
    this->count = this->count + 1;
  }
  if (this->count == 4) {
    this->count = 0;
    fileIdx = this->memcardanimframe + 1;
    this->memcardanimframe = fileIdx;
    if (0x1d < fileIdx) {
      this->memcardanimframe = 0;
    }
  }
  i = this->pCI->status;
  if (i == -1) {
    this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 1;
    if (this->checkingstart == 0) {
      this->checkingstart = ticks;
    }
    i = 0x27b;
    if (800 < ticks - this->checkingstart) {
      i = 0x27f;
    }
    this->fMemCardMessageTextSys = i;
    i = 0;
    if (0 < this->pCI->numfiles) {
      idx = 0;
      do {
        idx = idx >> 0x10;
        if (this->goticon[idx] != '\0') {
          fileIdx = this->fFadeIcon[idx] + 8;
          this->fFadeIcon[idx] = fileIdx;
          if (fileIdx < 0x81) {
            this->PlaceIcons(idx,fadeval);
          }
          else {
            this->fFadeIcon[idx] = 0x80;
            this->goticon[idx] = '\0';
            this->numicon[idx] = '\0';
            this->numblock[idx] = '\0';
            if (this->fMemIconClutId[idx] != 0) {
              Texture_MenuReleaseClutId(this->fMemIconClutId[idx]);
              this->fMemIconClutId[idx] = 0;
            }
          }
        }
        i = i + 1;
        idx = i * 0x10000;
      } while (i * 0x10000 >> 0x10 < this->pCI->numfiles);
    }
    goto DrawMC_statusCheckFinal;
  }
  if (i == -2) {
    this->checkingstart = 0;
    this->fMemCardMessageTextSys = 0x288;
    goto DrawMC_statusCheckFinal;
  }
  this->checkingstart = 0;
  i = 0x27d;
  if (this->pCI->numfiles == 0) {
    i = 0x284;
  }
  this->fMemCardMessageTextSys = i;
  if (this->fGetNewIcons == 0) {
    this->fReadyToGetNewIcons = 0;
DrawMC_perFileLoopTop:
    i = 0;
    if (0 < this->pCI->numfiles) {
      do {
        fileIdx = (short)i;
        if (this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons != 0) {
          this->ReleaseIcons();
          this->fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons = 0;
          this->fGetNewIcons = 0;
          break;
        }
        if ((this->goticon[fileIdx] == '\0') && (CURRENTLYUSINGMEMCARD == 0)) {
          if (this->fGetNewIcons == 0) {
            this->LoadIcon((int)fileIdx);
            goto DrawMC_getNewIconsCheck;
          }
DrawMC_readyToGetNewIcons:
          if (this->fReadyToGetNewIcons != 0) {
            this->goticon[fileIdx] = '\0';
          }
        }
        else {
DrawMC_getNewIconsCheck:
          if (this->fGetNewIcons != 0) goto DrawMC_readyToGetNewIcons;
        }
        if (CURRENTLYUSINGMEMCARD == 0) {
          if (this->goticon[fileIdx] != '\0') {
            if (this->fFadeIcon[fileIdx] == 0) {
              idx = MCRD_fileexists(this->card,"NFS4");
              this->theNFS4icon = idx;
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
          if (this->goticon[fileIdx] != '\0') {
            if ((this->fGetNewIcons == 0) || (this->fReadyToGetNewIcons != 0)) {
              idx = (i << 0x10) >> 0xf;
              fade = *(short *)((int)this->fFadeIcon + idx) - 8;
              *(ushort *)((int)this->fFadeIcon + idx) = fade;
              if ((int)((uint)fade << 0x10) < 0) {
                *(u_short *)((int)this->fFadeIcon + idx) = 0;
              }
            }
            else {
              fadeInc = this->fFadeIcon[fileIdx] + 8;
              this->fFadeIcon[fileIdx] = fadeInc;
              if (0x80 < fadeInc) {
                this->fFadeIcon[fileIdx] = 0x80;
                if (this->fMemIconClutId[fileIdx] != 0) {
                  Texture_MenuReleaseClutId(this->fMemIconClutId[fileIdx]);
                  this->fMemIconClutId[fileIdx] = 0;
                }
                this->goticon[fileIdx] = '\0';
                this->numicon[fileIdx] = '\0';
                this->numblock[fileIdx] = '\0';
              }
            }
            this->PlaceIcons((int)fileIdx,fadeval);
          }
        }
        i = i + 1;
      } while (i * 0x10000 >> 0x10 < this->pCI->numfiles);
    }
  }
  else {
    this->fReadyToGetNewIcons = 1;
    i = 0;
    if (0 < this->pCI->numfiles) {
      idx = 0;
      do {
        i = i + 1;
        if (*(short *)((int)this->fFadeIcon + (idx >> 0xf)) < 0x80) {
          this->fReadyToGetNewIcons = 0;
        }
        idx = i * 0x10000;
      } while (i * 0x10000 >> 0x10 < this->pCI->numfiles);
      goto DrawMC_perFileLoopTop;
    }
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
  CARDINFO_def *cardInfo;
  int status;
  void *cheater;
  int i;
  tScreenMemcard *walk;
  
  cardInfo = MCRD_getcard(this->card);
  i = 0;
  this->pCI = cardInfo;
  DontChangeEnablings = false;
  walk = this;
  if (0 < cardInfo->numfiles) {
    do {
      if ((((this->goticon[i] == '\0') || (0 < walk->fFadeIcon[0])) &&
          (status = this->pCI->status, status != -1)) && (status != -2)) {
        DontChangeEnablings = true;
      }
      i = i + 1;
      walk = (tScreenMemcard *)((int)&(walk)->fPermShapes.fShapes + 2);
    } while (i < cardInfo->numfiles);
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
  short fadeVal0;
  uint fScreenFade;
  char *word;
  int i;
  short fade;
  tScreenMemcard *walk;
  int fadeAmt;
  int boxY;
  uint gridY;
  int w;
  int x;
  int gray;
  int textFlags;
  int textCol;
  int textJustify;
  RECT rr;
  short gridpos;
  
  this->fMemCardMessageTextSys = -1;
  if (this->goticon[this->theNFS4icon] == '\0') {
    this->theNFS4icon = -1;
  }
  systemtask(0);
  fScreenFade = (uint)(ushort)this->fScreenFadeVal;
  gray = fScreenFade * 2 + -0x80;
  fade = (short)gray;
  gray = gray * 0x10000 >> 0x10;
  if ((gray < 0x80) && (gray < 1)) {
    fade = 0;
  }
  else if (0x80 < gray) {
    fade = 0x80;
  }
  gray = (int)(fScreenFade << 0x11) >> 0x11;
  if ((gray < 0x80) && (gray < 1)) {
    gridpos = 0;
  }
  else {
    gridpos = (short)(fScreenFade * 2) >> 1;
    if (0x80 < gray) {
      gridpos = 0x80;
    }
  }
  gray = (int)(fScreenFade << 0x11) >> 0xf;
  if (0x80 < gray) {
    gray = 0x80;
  }
  if (gray < 0) {
    gray = 0;
  }
  if (this->fInitedMemCard == 0) {
    fadeVal0 = this->fScreenFadeVal;
    this->fMemCardMessageTextSys = 0x27c;
    if ((fadeVal0 == 0) && (0x80 < ticks - this->fScreenFadeReadyTick)) {
      Init_Memcard(true,0);
      i = 0;
      walk = this;
      do {
        this->goticon[i] = '\0';
        this->numicon[i] = '\0';
        this->numblock[i] = '\0';
        walk->fFadeIcon[0] = 0x80;
        i = i + 1;
        walk = (tScreenMemcard *)((int)&(walk)->fPermShapes.fShapes + 2);
      } while (i < 0xf);
      this->fInitedMemCard = 1;
    }
    else if (this->fScreenFadeReadyTick == 0) {
      this->fScreenFadeReadyTick = ticks;
    }
    if (this->fInitedMemCard == 0) goto DrawBg47470_calcFadeMessage;
  }
  if (fade != 0x80) {
    this->DrawMemCardStuff((short)gray);
  }
DrawBg47470_calcFadeMessage:
  gray = CalcFadeVal(kRGBVals[(byte)textDefinitions[6][5]],fadeAmt);
  if (this->message != -1) {
    this->fMemCardMessageTextSys = this->message;
  }
  if (this->fMemCardMessageTextSys != -1) {
    word = TextSys_Word(this->fMemCardMessageTextSys);
    sprintf(this->fMemCardMessage,word);
  }
  fScreenFade = (uint)(ushort)kMemCardMessageX;
  rr.w = 0xbe;
  rr.h = 0;
  rr.x = (ushort)kMemCardMessageX;
  rr.y = (short)kMemCardMessageY;
  FETextRender_WordWrapTextRGBJustify(this->fMemCardMessage,rr,textCol,textJustify,0,false);
  word = TextSys_Word(this->player + 0x293);
  FETextRender_FullTextRGB
            (word,(short)kMemCardMessage1X,(short)kMemCardMessage1Y,gray,'\0',2);
  i = 0;
  x = (int)(((GRIDMEMCARD_STARTX & 0xffffU) - (uint)(ushort)GRIDMEMCARDGOURAUDBIT_X) * 0x10000) >>
      0x10;
  w = (int)(((GRIDMEMCARD_WIDTH & 0xffffU) + (uint)(ushort)GRIDMEMCARDGOURAUDBIT_X * 2 + 2) *
           0x10000) >> 0x10;
  gray = ((uint)(ushort)GRIDMEMCARD_HEIGHT + (uint)(ushort)GRIDMEMCARDGOURAUDBIT_Y * 2 +
          (EXTRAYATTOP & 0xffffU) + 6) * 0x10000;
  gray = (gray >> 0x10) - (gray >> 0x1f) >> 1;
  SubtractiveBox
            (x,boxY,w,gray,0x505050,0x505050,0,0);
  SubtractiveBox
            (x,boxY,w,gray,0,0,0x505050,0x505050);
  PSXDrawSquare
            (0,GRIDMEMCARD_STARTX + 2,kMemCardMessage1Y + -2,GRIDMEMCARD_WIDTH + -4,
             kMemCardMessageH1 + -1);
  PSXDrawSquare
            (0,GRIDMEMCARD_STARTX + 2,GRIDMEMCARD_STARTY + MEMCARD_DELTAY * 5 + 1,
             GRIDMEMCARD_WIDTH + -4,kMemCardMessageH + -1);
  do {
    gray = (i << 0x10) >> 0x10;
    this->DrawVerticalLine((short)fScreenFade,
                     (short)((((GRIDMEMCARD_STARTY & 0xffffU) -
                              (uint)(ushort)GRIDMEMCARDGOURAUDBIT_Y) - (EXTRAYATTOP & 0xffffU)) *
                             0x10000 >> 0x10),gridpos,
                     (short)((uint)((gray + (gray - ((i << 0x10) >> 0x1f) >> 1) * -2) *
                                   0x10000) >> 0x10));
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 4);
  gridY = GRIDMEMCARD_STARTY & 0xffff;
  if (EXTRAYATTOP != 0) {
    this->DrawHorizontalLine((short)(((GRIDMEMCARD_STARTX & 0xffffU) -
                                    (uint)(ushort)GRIDMEMCARDGOURAUDBIT_X) * 0x10000 >> 0x10),
                       (short)((gridY - (EXTRAYATTOP & 0xffffU)) * 0x10000 >> 0x10),(short)fScreenFade,1);
  }
  gray = 0;
  do {
    i = (gray << 0x10) >> 0x10;
    this->DrawHorizontalLine((short)(((GRIDMEMCARD_STARTX & 0xffffU) -
                                    (uint)(ushort)GRIDMEMCARDGOURAUDBIT_X) * 0x10000 >> 0x10),
                       (short)gridY,(short)fScreenFade,
                       (short)((uint)((i + (i - ((gray << 0x10) >> 0x1f) >> 1) * -2) *
                                     0x10000) >> 0x10));
    gray = gray + 1;
    i = gray * 0x10000 >> 0x10;
    fScreenFade = gridY + (MEMCARD_DELTAY & 0xffffU);
    gridY = fScreenFade;
  } while (i < 6);
  this->DrawHorizontalLine((short)(((GRIDMEMCARD_STARTX & 0xffffU) -
                                  (uint)(ushort)GRIDMEMCARDGOURAUDBIT_X) * 0x10000 >> 0x10),
                     (short)((fScreenFade + ((kMemCardMessageH & 0xffffU) - (MEMCARD_DELTAY & 0xffffU))) *
                             0x10000 >> 0x10),(short)fScreenFade,
                     (short)((uint)((i + (i - (gray * 0x10000 >> 0x1f) >> 1) * -2) *
                                   0x10000) >> 0x10));
  gray = 0;
  do {
    DrawShapeExtended
              (fScreenFade,textFlags,textCol,textJustify,(int)fade,0,
               (tDrawShapeExtended *)0x0);
    gray = gray + 1;
  } while (gray < 0x10);
  if (this->fInitedMemCard != 0) {
    this->SetEnablings();
  }
  return;
}

/* ---- tScreenMemcard::DrawForeground  (screenmemcard.cpp:690) ---- */
void tScreenMemcard::DrawForeground()

{
  short fade;
  int k;
  int shapeIdx;
  int shapeFlags;
  int shapeX;
  int shapeY;
  int fade_tmp;
  
  fade_tmp = (uint)(ushort)this->fScreenFadeVal * 2 + -0x80;
  fade = (short)fade_tmp;
  k = fade_tmp * 0x10000 >> 0x10;
  if ((k < 0x80) && (k < 1)) {
    fade = 0;
  }
  else if (0x80 < k) {
    fade = 0x80;
  }
  k = 0;
  do {
    DrawShapeExtended(shapeIdx,shapeFlags,shapeX,shapeY,(int)fade,0,
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
  byte inputPlayer;
  tFEApplication *feApp;
  tGlobalMenuDefs *menus;
  uint saveFlags;
  uint loadFlags;
  tScreenMemcard *walk;
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
  menus = menuDefs[0];
  if (this->player != 0) {
    msgId = 0x289;
  }
  i = 0;
  saveFlags = (menuDefs[0]->itemSaveGame).fFlags;
  loadFlags = (menuDefs[0]->itemLoadGame).fFlags;
  (menuDefs[0]->itemLoadGame).fTextDescription = msgId;
  (menus->itemSaveGame).fFlags = saveFlags | 1;
  (menus->itemLoadGame).fFlags = loadFlags | 1;
  walk = this;
  do {
    this->goticon[i] = '\0';
    this->numicon[i] = '\0';
    this->numblock[i] = '\0';
    walk->fFadeIcon[0] = 0x80;
    walk->fMemIconClutId[0] = 0;
    i = i + 1;
    walk = (tScreenMemcard *)((int)&(walk)->fPermShapes.fShapes + 2);
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