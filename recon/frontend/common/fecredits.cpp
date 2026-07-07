/* frontend/common/fecredits.cpp -- RECONSTRUCTED (credits/scroll-text manager; C++ TU)
 *   class tCreditManager ; 7 methods. DrawCurrCredit phantoms (tCredit field offsets,
 *   anim-frame DrawShapeExtended, CalcFadeVal 2nd args, WordWrap color/justify) via m2c.
 */
#include "fecredits.h"

/* ---- FECredits.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes) ---- */
int CREDFADETICKS = 700;   /* @0x80051aa0  credit fade-out tick threshold (code resets 700/2000) */


/* ---- tCreditManager::Setup  [FECREDITS.CPP:32-35] ---- */
void tCreditManager::Setup()

{
  this->fCreditsInitialized = 0;
  this->fRequestDeInit = 0;
  this->fTVFade = 0;
  return;
}



/* ---- tCreditManager::Init  [FECREDITS.CPP:57-99] ---- */
int tCreditManager::Init(int arg1)

{
  uint uVar1;
  int reserve_offset;
  tCredit *loadAddr;
  char filename [80];
  
  uVar1 = this->fCreditsInitialized;
  if (uVar1 == 0) {
    if (this->fRequestDeInit != 0) {
      this->fRequestDeInit = 0;
    }
    this->fShowCreditNum = -1;
    this->fTextFade = 0x80;
    this->fStartTicks = 0;
    this->StartedTransition = 0;
    this->StartedLines = 0;
    this->StartedTextFade = 0;
    this->fRequestDeInit = 0;
    this->fCurrCredit = 0;
    sprintf(filename,"%szcred%d.dat",Paths_Paths[0x25],(uint)(byte)frontEnd.language);
    reserve_offset = filesize(filename);
    loadAddr = reservememadr("records",reserve_offset,0);
    this->CreditBuffer = loadAddr;
    loadfileatadrz(filename,loadAddr);
    uVar1 = filesize(filename);
    this->fCreditsInitialized = 1;
    uVar1 = uVar1 / 0x144;
    this->fNumCredits = uVar1;
  }
  return uVar1;
}



/* ---- tCreditManager::DeInit  [FECREDITS.CPP:102-103] ---- */
void tCreditManager::DeInit()

{
  this->fRequestDeInit = 1;
  return;
}



/* ---- tCreditManager::RealDeInit  [FECREDITS.CPP:107-117] ---- */
void tCreditManager::RealDeInit()

{
  
  this->fRequestDeInit = 0;
  if (this->fCreditsInitialized != 0) {
    purgememadr(this->CreditBuffer);
    this->fCreditsInitialized = 0;
  }
  return;
}



/* ---- tCreditManager::Draw  [FECREDITS.CPP:120-151] ---- */
void tCreditManager::Draw(bool selected)

{
  int iVar1;
  int iVar2;
  uint uVar3;
  tScreenMain *ptVar4;
  int i;
  
  if (selected == 0) {
    iVar1 = this->fTVFade + -4;
  }
  else {
    iVar1 = this->fTVFade + 4;
  }
  this->fTVFade = iVar1;
  iVar1 = this->fTVFade;
  if (iVar1 < 0) {
    iVar1 = 0;
  }
  iVar2 = iVar1;
  if (0x5c < iVar1) {
    iVar2 = 0x5c;
  }
  this->fTVFade = iVar2;
  if (iVar1 < 0x5c) {
    iVar1 = 0x80 - iVar2;
    if (0x80 - iVar2 < this->fTextFade) {
      iVar1 = this->fTextFade;
    }
    this->fTextFade = iVar1;
  }
  iVar1 = 0;
  ptVar4 = screenMain;
  do {
    ptVar4->tvConfigs[0].flags = ptVar4->tvConfigs[0].flags | 2;
    iVar1 = iVar1 + 1;
    uVar3 = 0x80 - this->fTVFade;
    ptVar4->tvConfigs[0].tint = uVar3 * 0x10000 | uVar3 * 0x100 | uVar3;
    ptVar4 = (tScreenMain *)&(ptVar4)->fSwapShapes.fDestFile;
  } while (iVar1 < 0x10);
  if (this->fTVFade == 0) {
    if (this->fRequestDeInit != 0) {
      this->RealDeInit();
    }
  }
  else if ((this->fCreditsInitialized != 0) && (this->SetupCurrCredit(), this->fShowCreditNum != -1))
  {
    this->DrawCurrCredit();
  }
  return;
}



/* ---- tCreditManager::SetupCurrCredit  [FECREDITS.CPP:155-238] ---- */
void tCreditManager::SetupCurrCredit()

{
  bool bVar1;
  int iVar2;
  void *pvVar3;
  int NNNNN;
  
  if (((0xc < ticks - FECredits_lastFadeTick) && (this->fTextFade == 0)) &&
     (bVar1 = false, this->fCurrCredit == this->fShowCreditNum)) {
    iVar2 = FEInput_GetNoDebounceKey(0x20,0);
    if ((iVar2 != 0) ||
       (iVar2 = FEInput_GetNoDebounceKey(0x20,1), iVar2 != 0))
    {
      bVar1 = true;
    }
    if (bVar1) {
      AudioCmn_PlayFESFX(6);
      this->fStartTicks = 0;
      this->fCurrCredit = this->fShowCreditNum + 1;
      FECredits_lastFadeTick = ticks;
    }
    if (this->fNumCredits <= this->fCurrCredit) {
      this->fCurrCredit = 0;
    }
    if (this->fCurrCredit < 0) {
      this->fCurrCredit = this->fNumCredits + -1;
    }
  }
  if ((this->fStartTicks != 0) && (CREDFADETICKS < ticks - this->fStartTicks)) {
    iVar2 = this->fCurrCredit + 1;
    this->fCurrCredit = iVar2;
    if (this->fNumCredits <= iVar2) {
      this->fCurrCredit = 0;
    }
    if (this->fCurrCredit < 0) {
      this->fCurrCredit = this->fNumCredits + -1;
    }
    this->fStartTicks = 0;
  }
  if (this->fShowCreditNum != this->fCurrCredit) {
    this->fTextFadeDir = 8;
    this->StartedTransition = 0;
    this->StartedLines = 0;
    this->StartedTextFade = 0;
  }
  iVar2 = this->fTextFade + this->fTextFadeDir;
  this->fTextFade = iVar2;
  if (iVar2 < 1) {
    this->fTextFade = 0;
  }
  if (0x7f < this->fTextFade) {
    this->fTextFade = 0x80;
  }
  if ((this->fTextFade == 0x80) && (this->StartedTransition == 0)) {
    iVar2 = this->fCurrCredit;
    this->StartedTransition = 1;
    this->fShowCreditNum = iVar2;
    if ((iVar2 == (iVar2 / 3) * 3) || (this->CreditBuffer[iVar2].bgNumber != -1)) {
      iVar2 = iVar2 + 1;
      if (this->fNumCredits < iVar2) {
        iVar2 = 0;
      }
      screenMain->SwapBackground((int)this->CreditBuffer[iVar2].bgNumber);
    }
  }
  if (((this->StartedLines == 0) && (this->StartedTransition != 0)) &&
     (pvVar3 = screenMain->DoneLoadingBackground(), iVar2 = ticks, pvVar3 != (void *)0x0)
     ) {
    this->StartedLines = 1;
    this->fLineTicks = iVar2;
  }
  iVar2 = ticks;
  if (((this->StartedTextFade == 0) && (this->StartedLines != 0)) &&
     (0x1e < ticks - this->fLineTicks)) {
    this->StartedTextFade = 1;
    this->fTextFadeDir = -8;
    this->fStartTicks = iVar2;
  }
  return;
}



/* ---- tCreditManager::DrawCurrCredit  [FECREDITS.CPP:246] ---- */
void tCreditManager::DrawCurrCredit()

{
  short justify;
  int lineWidth;
  int ColTextTitle;
  int scrollY;
  int ColTextSubTitle;
  int ColText;
  int wordText;
  char *pcVar3;
  uint uVar4;
  int p2;
  int shape_p;
  byte tagByte;
  byte bVar5;
  short lineY;
  int i;
  int iVar6;
  int dist;
  byte *s, *p;
  int rtd;
  int height;
  tCredit *fShowCred;
  int arg5;
  int width;
  int w;
  short y;
  int fadeAlpha;
  int fadeAlpha_2;
  char *lineText;
  byte isJaguarLine;
  byte isHiddenLine;
  int textColor;
  tDrawShapeExtended drawFlags;
  RECT r;
  char buffer [292];
  short x;
  short tu1;
  bool hidden;
  bool rollthedice;
  byte jaguar;
  
  drawFlags.tint[0] = 0xcec844;
  DrawShapeExtended(((ticks >> 4) - (ticks / 0xa0) * 10) + 0xe6,0x410,0x10,0x10,0,0,&drawFlags);
  fShowCred = this->CreditBuffer + this->fShowCreditNum;
  FETextRender_SetABR(1,true);
  tu1 = fShowCred->subTitleY;
  lineWidth = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextTitle = CalcFadeVal(lineWidth,0x28);
  scrollY = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextSubTitle = CalcFadeVal(scrollY,0x28);
  ColText = CalcFadeVal(0x787878,this->fTextFade);
  if (fShowCred->titleWidth == 0) {
    pcVar3 = TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_FullTextRGB(pcVar3,fShowCred->titleX,fShowCred->titleY,ColTextTitle,'\0',
               fShowCred->titleJustify);
  }
  else {
    r.x = fShowCred->titleX;
    r.y = fShowCred->titleY;
    r.w = fShowCred->titleWidth;
    r.h = 100;
    wordText = (int)TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_WordWrapTextRGBJustify((char *)wordText,r,ColTextTitle,fShowCred->titleJustify,0,false);
  }
  if (fShowCred->subTitleWidth == 0) {
    fadeAlpha = (ushort)tu1 + 8;
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    ColTextTitle = (int)fShowCred->subTitleY;
    FETextRender_FullTextRGB(pcVar3,fShowCred->subTitleX,fShowCred->subTitleY,ColTextSubTitle,'\0',
               fShowCred->subTitleJustify);
  }
  else {
    r.x = fShowCred->subTitleX;
    r.y = fShowCred->subTitleY;
    r.w = fShowCred->subTitleWidth;
    r.h = 100;
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    ColTextTitle = FETextRender_WordWrapTextRGBJustify(pcVar3,r,ColTextSubTitle,fShowCred->subTitleJustify,0,false);
    fadeAlpha = (uint)(ushort)tu1 + ColTextTitle;
    ColTextTitle = ColTextSubTitle;
  }
  if (fShowCred->textY != 0) {
    fadeAlpha = (uint)fShowCred->textY;
  }
  x = fShowCred->textX;
  lineY = fShowCred->subTitleWidth;
  if (lineY == 0) {
    FETextRender_SetFont(0);
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    ColTextSubTitle = textpixels(pcVar3);
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    uVar4 = strlen(pcVar3);
    lineY = (short)ColTextSubTitle - (short)uVar4;
  }
  if (x == 0) {
    if (fShowCred->subTitleJustify == 0) {
      x = fShowCred->subTitleX + lineY + 2;
    }
    else {
      x = (fShowCred->subTitleX - lineY) + -2;
    }
  }
  strcpy(buffer,fShowCred->text);
  s = (byte *)buffer;
  do {
    jaguar = 0;
    if (s == (byte *)0x0) {
      FETextRender_SetABR(0,false);
      if (this->StartedLines != 0) {
        ColTextSubTitle = ((ticks - this->fLineTicks) * 0x208) / 0x50;
        iVar6 = ColTextSubTitle;
        w = 200;
        if (ColTextSubTitle < 200) {
          iVar6 = 200;
          w = ColTextSubTitle;
        }
        if (0x140 < ColTextSubTitle) {
          w = 0x140 - iVar6;
          if (w < 0) {
            w = 0;
          }
          iVar6 = 0x208 - w;
        }
        if (0 < w) {
          ColTextSubTitle = CalcFadeVal(0x505050,0x40);
          ColTextTitle = fShowCred->subTitleY + -2;
          PSXTransDrawBrightEndLine(ColTextSubTitle,iVar6 + -0x25,ColTextTitle,w,4,3,1,0,1);
        }
        ColTextSubTitle = ((ticks - this->fLineTicks) * 0x10c) / 0x50;
        iVar6 = ColTextSubTitle;
        arg5 = 100;
        if (ColTextSubTitle < 100) {
          iVar6 = 100;
          arg5 = ColTextSubTitle;
        }
        if (0xa8 < ColTextSubTitle) {
          arg5 = 0xa8 - iVar6;
          if (arg5 < 0) {
            arg5 = 0;
          }
          iVar6 = 0x10c - w;
        }
        if (0 < arg5) {
          ColTextTitle = CalcFadeVal(0x505050,0x40);
          PSXTransDrawBrightEndLine(ColTextTitle,(int)x,iVar6 + -0x3a,2,arg5,1,1,0,1);
        }
      }
      return;
    }
    rollthedice = false;
    hidden = false;
    p2 = (int)strchr((char *)s,10);
    if (p2 != 0) {
      *(u_char *)p2 = 0;
    }
    tagByte = *s;
    if (tagByte == 10) {
      do {
        s = s + 1;
      } while (*s == 10);
      tagByte = *s;
    }
    if (tagByte == 9) {
      jaguar = 1;
      do {
        s = s + 1;
      } while (*s == 9);
    }
    bVar5 = *s;
    if (bVar5 == 0x2a) {
      rollthedice = true;
      do {
        s = s + 1;
      } while (*s == 0x2a);
      bVar5 = *s;
    }
    if (bVar5 == 0x5e) {
      hidden = true;
      do {
        s = s + 1;
      } while (*s == 0x5e);
    }
    CREDFADETICKS = 2000;
    if (!hidden) {
      CREDFADETICKS = 700;
    }
    if (rollthedice) {
      r.x = 0xb4;
      r.y = 0x55;
      r.w = 0x118;
      r.h = 100;
      pcVar3 = TextSys_Word(0x596);
      ColTextTitle = ColText;
      FETextRender_WordWrapTextRGBJustify(pcVar3,r,ColText,0,0,false);
      fadeAlpha = fadeAlpha + 8;
    }
    else if (hidden) {
      ColTextSubTitle = 0;
      do {
        fadeAlpha_2 = fadeAlpha;
        pcVar3 = TextSys_Word(ColTextSubTitle + 0x597);
        ColTextTitle = (int)(short)fadeAlpha_2;
        ColTextSubTitle = ColTextSubTitle + 1;
        FETextRender_FullTextRGB(pcVar3,x,(short)fadeAlpha_2,ColText,'\0',fShowCred->textJustify);
        fadeAlpha = fadeAlpha_2 + 8;
      } while (ColTextSubTitle < 0x19);
      fadeAlpha = fadeAlpha_2 + 0x10;
    }
    else {
      if ((bool)jaguar) {
        shape_p = (int)FECheat_IsCheatEnabled(cheat_MyMomSaysImCool);
        if (shape_p != 0) {
          ColTextSubTitle = CalcFadeVal(0x505050,0x40);
          justify = fShowCred->textJustify;
          goto DrawCredit_emitText;
        }
      }
      else {
        justify = fShowCred->textJustify;
        ColTextSubTitle = ColText;
DrawCredit_emitText:
        ColTextTitle = (int)(short)fadeAlpha;
        FETextRender_FullTextRGB((char *)s,x,(short)fadeAlpha,ColTextSubTitle,'\0',justify);
      }
      fadeAlpha = fadeAlpha + 8;
    }
    s = (byte *)p2;
    if (p2 != 0) {
      s = (byte *)(p2 + 1);
    }
  } while( true );
}



/* end of fecredits.cpp */
