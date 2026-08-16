/* frontend/common/fecredits.cpp -- RECONSTRUCTED (credits/scroll-text manager; C++ TU)
 *   class tCreditManager ; 7 methods. DrawCurrCredit phantoms (tCredit field offsets,
 *   anim-frame DrawShapeExtended, CalcFadeVal 2nd args, WordWrap color/justify) via m2c.
 */
#include "fecredits.h"

/* ---- FECredits.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes) ---- */
/* MATCH (w35-a10): strong .sdata symbol in front_data.data.s, reached
   absolutely by both oracles (0 %gp_rel tree-wide); an initialised TU-owned
   int is <=G4 -> .sdata -> gp-relative.  Unsized-array asm-label view. */
int CREDFADETICKS = 700;   /* @0x80051aa0; SYM EXT INT */
extern int A_ticks[] __asm__("ticks");
#define ticks A_ticks[0]
extern tScreenMain *A_screenMain[] __asm__("screenMain");
#define screenMain A_screenMain[0]
/* W66-A3 (link): the storage is the blob's `D_80051AA4` (front_data_r03.data.s,
 * the word right after CREDFADETICKS) -- point the asm-label view at the label
 * that actually exists instead of at the project spelling, which nothing defines.
 * Name-only: the unsized-array view (and its absolute lui/lw addressing) is
 * unchanged. */
extern int A_FECredits_lastFadeTick[] __asm__("D_80051AA4");
#define FECredits_lastFadeTick A_FECredits_lastFadeTick[0]


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
/* MATCH (2026-08-11, 35 -> PASS, 81/81): direct fTVFade updates keep their
   result in $v0, while one cached `screenMain` pointer and indexed tvConfigs
   access produce retail's $a1 base with a 48-byte GIV.  The SYM-only loop
   local consequently occupies $a2 exactly.  IDA's raw-fade $v0 / clamped-fade
   $v1 split comes from the natural post-clamp copy shape: clamp iVar2 first,
   then assign fadeValue once after the branch.  Keeping the raw value live
   through that copy prevents coalescing; jump optimization duplicates the
   copy into the nonnegative delay slot and negative arm exactly as retail. */
{
  tScreenMain *mainScreen;
  int iVar1;
  int iVar2;
  int fadeValue;
  uint uVar3;

  if (selected) {
    this->fTVFade = this->fTVFade + 4;
  }
  else {
    this->fTVFade = this->fTVFade + -4;
  }
  iVar2 = this->fTVFade;
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  fadeValue = iVar2;
  __asm__("" : : "r" (iVar2));
  if (0x5c < fadeValue) {
    fadeValue = 0x5c;
  }
  this->fTVFade = fadeValue;
  if (fadeValue < 0x5c) {
    fadeValue = 0x80 - fadeValue;
    if (fadeValue < this->fTextFade) {
      fadeValue = this->fTextFade;
    }
    this->fTextFade = fadeValue;
  }
  mainScreen = screenMain;
  iVar1 = 0;
  do {
    mainScreen->tvConfigs[iVar1].flags = mainScreen->tvConfigs[iVar1].flags | 2;
    uVar3 = 0x80 - this->fTVFade;
    mainScreen->tvConfigs[iVar1].tint = uVar3 * 0x10000 | uVar3 * 0x100 | uVar3;
    iVar1 = iVar1 + 1;
  } while (iVar1 < 0x10);
  if (this->fTVFade == 0) {
    if (this->fRequestDeInit != 0) {
      this->RealDeInit();
    }
  }
  else if (this->fCreditsInitialized != 0) {
    this->SetupCurrCredit();
    if (this->fShowCreditNum != -1) {
      this->DrawCurrCredit();
    }
  }
  return;
}



/* ---- tCreditManager::SetupCurrCredit  [FECREDITS.CPP:155-238] ---- */
void tCreditManager::SetupCurrCredit()

/* MATCH (w37-a2 + 2026-08-03 follow-up, 58->PASS): SYM has only ONE named local for the whole
   fn (function-static `lasttick`, i.e. FECredits_lastFadeTick) besides
   `this` -- everything else is compiler-transient. Two levers found:
   (1) the fCurrCredit%3-or-bgNumber SwapBackground index is a SEPARATE
   nested-block local (SYM block@0x80035f94) for `iVar5+1`, not a
   reassignment of iVar5 itself -- keeps iVar5 in $a0 matching the oracle
   instead of drifting to $a1. (2) both `ticks` reads that feed a
   store-after-a-call (fLineTicks, fStartTicks) read `ticks` directly at
   the point of use (not via a cached `iVar2`) with the store-order
   `fLineTicks=ticks; StartedLines=1;`. The follow-up's compare-operand
   order makes the ticks `%hi` issue before CREDFADETICKS like retail,
   while the final block-local volatile snapshot preserves retail's
   second ticks load and keeps it in $v1 across the two preceding stores.
   The final two-diff load-order residual was source-shape: spelling the first
   wrap test as `fCurrCredit >= fNumCredits` presents GCC with retail's operand
   order while preserving the same comparison and branch. */
{
  bool bVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  void *pvVar3;

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
    if (this->fCurrCredit >= this->fNumCredits) {
      this->fCurrCredit = 0;
    }
    if (this->fCurrCredit < 0) {
      this->fCurrCredit = this->fNumCredits + -1;
    }
  }
  if ((this->fStartTicks != 0) && (ticks - this->fStartTicks > CREDFADETICKS)) {
    iVar3 = this->fCurrCredit + 1;
    this->fCurrCredit = iVar3;
    if (this->fNumCredits <= iVar3) {
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
  iVar4 = this->fTextFade + this->fTextFadeDir;
  this->fTextFade = iVar4;
  if (iVar4 < 1) {
    this->fTextFade = 0;
  }
  if (0x7f < this->fTextFade) {
    this->fTextFade = 0x80;
  }
  if ((this->fTextFade == 0x80) && (this->StartedTransition == 0)) {
    iVar5 = this->fCurrCredit;
    this->StartedTransition = 1;
    this->fShowCreditNum = iVar5;
    if ((iVar5 == (iVar5 / 3) * 3) || (this->CreditBuffer[iVar5].bgNumber != -1)) {
      /* MATCH (w37-a2): SYM shows a SEPARATE nested-block local at
         VA 0x80035f94 (line 66) for iVar5+1, not a reassignment of
         iVar5 itself. */
      int nextIdx = iVar5 + 1;
      if (this->fNumCredits < nextIdx) {
        nextIdx = 0;
      }
      screenMain->SwapBackground((int)this->CreditBuffer[nextIdx].bgNumber);
    }
  }
  if (((this->StartedLines == 0) && (this->StartedTransition != 0)) &&
     (pvVar3 = screenMain->DoneLoadingBackground(), pvVar3 != (void *)0x0)
     ) {
    this->fLineTicks = ticks;
    this->StartedLines = 1;
  }
  if (((this->StartedTextFade == 0) && (this->StartedLines != 0)) &&
     (0x1e < ticks - this->fLineTicks)) {
    int startTicks = *(volatile int *)&ticks;
    this->StartedTextFade = 1;
    this->fTextFadeDir = -8;
    this->fStartTicks = startTicks;
  }
  return;
}



/* ---- tCreditManager::DrawCurrCredit  [FECREDITS.CPP:246] ---- */
void tCreditManager::DrawCurrCredit()

{
  /* MATCH (w37-a2): full SYM-driven rewrite from the raw oracle .s trace
     (asm/nonmatchings/front/DrawCurrCredit__14tCreditManager.s). Prior recon
     invented ~35 locals none of which are in the SYM 8c block (fsize=416);
     the true set is: fShowCred(s1) width(s0) x(AUTO) y(s3) ColTextTitle(s0)
     ColTextSubTitle(s2) ColText(s8) r(AUTO) p(s0) p2(s4) buffer(AUTO), plus
     nested-block hidden(s6) jaguar(s5) rollthedice(s2) rtd(s0) and the tail
     block's dist(s0) width(s2,shadowed) height(s1). Two real bugs found by
     register-tracing vs SYM names: (1) the tag-flag semantics were rotated
     -- TAB(0x9) is really `hidden` (cheat-gated single line), ASTERISK
     (0x2a) is really `jaguar` (big wordwrap box), CARET(0x5e) is really
     `rollthedice` (25x repeat loop) -- opposite of the prior recon's
     labels, though the prior recon's BEHAVIOR per flag happened to be
     right, just mis-named; (2) the y-cursor (subTitleY-based, SYM `y`)
     was split across 3 fabricated locals (tu1/fadeAlpha/fadeAlpha_2)
     instead of being ONE variable updated in place, matching the oracle's
     single $s3 live across the whole function. Also: the DrawShapeExtended
     frame index arg is `(ticks>>4) % 10`, not `ticks/160` (m2c's guess) --
     mathematically equal for ticks>=0 but the oracle's magic-multiply
     divides the ALREADY-SHIFTED value (shift=2 in the div-by-10 sequence),
     so the source must apply `% 10` to `ticks>>4` for the codegen to match.
     Also a real bug: the cheat-gated FullTextRGB color was hardcoded
     `CalcFadeVal(0x505050,0x40)` -- the oracle reloads `this->fTextFade`
     (offset 8) as the 2nd arg, not the literal 0x40 (0x40 IS correct for
     the two tail bright-line CalcFadeVal calls, which stayed literal).
     Result: 610->8 verify_asm diffs, insn count now EXACT (451/451).
     The 2026-08-03 follow-up makes the post-NEWLINE and post-ASTERISK
     tag reads volatile: this defeats GCC's inappropriate cross-join CSE
     and restores both of retail's fresh `lbu v1,0(s0)` instructions at
     zero code-size cost. The 2026-08-03 GCC-2.8.1 follow-up seals the final
     8 diffs: `y` is an unsigned full-width carrier, with explicit 16-bit
     source loads. This lets the scheduler advance `y += 8` before the render
     call without a truncation temporary. Splitting the later `textY` test
     from its unsigned value load reproduces retail's `lh`/`lhu` pair. PASS,
     451/451 instructions. */
  int t16;
  tCredit *fShowCred;
  uint y;
  int lineWidth;
  int ColTextTitle;
  int scrollY;
  int ColTextSubTitle;
  int ColText;
  char *pcVar3;
  uint uVar4;
  int width;
  short x;
  byte *p, *p2;
  byte tagByte;
  bool hidden;
  bool jaguar;
  bool rollthedice;
  int dist;
  int height;
  tDrawShapeExtended drawFlags;
  RECT r;
  char buffer [292];

  drawFlags.tint[0] = 0xcec844;
  t16 = ticks >> 4;
  DrawShapeExtended((t16 - (t16 / 10) * 10) + 0xe6,0x410,0x10,0x10,0,0,&drawFlags);
  fShowCred = this->CreditBuffer + this->fShowCreditNum;
  FETextRender_SetABR(1,true);
  y = (u_short)fShowCred->subTitleY;
  lineWidth = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextTitle = CalcFadeVal(lineWidth,0x28);
  scrollY = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextSubTitle = CalcFadeVal(scrollY,0x28);
  ColText = CalcFadeVal(0x787878,this->fTextFade);
  /* MATCH (w37-a2): physical block order flip (W36 lever #1 De Morgan swap)
     -- the oracle reaches the FullTextRGB body via a `beqz`-taken branch
     target and falls THROUGH into the WordWrap/RECT body, so the source
     condition is `!= 0` with the WordWrap body first (confirmed by m2c). */
  if (fShowCred->titleWidth != 0) {
    r.x = fShowCred->titleX;
    r.y = fShowCred->titleY;
    r.w = fShowCred->titleWidth;
    r.h = 100;
    pcVar3 = TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_WordWrapTextRGBJustify(pcVar3,r,ColTextTitle,fShowCred->titleJustify,0,false);
  }
  else {
    pcVar3 = TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_FullTextRGB(pcVar3,fShowCred->titleX,fShowCred->titleY,ColTextTitle,'\0',
               fShowCred->titleJustify);
  }
  if (fShowCred->subTitleWidth != 0) {
    r.x = fShowCred->subTitleX;
    r.y = fShowCred->subTitleY;
    r.w = fShowCred->subTitleWidth;
    r.h = 100;
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    y = y + FETextRender_WordWrapTextRGBJustify(pcVar3,r,ColTextSubTitle,fShowCred->subTitleJustify,0,false);
  }
  else {
    y = y + 8;
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    FETextRender_FullTextRGB(pcVar3,fShowCred->subTitleX,fShowCred->subTitleY,ColTextSubTitle,'\0',
               fShowCred->subTitleJustify);
  }
  {
    int textY = fShowCred->textY;
    uint nextY = (u_short)fShowCred->textY;
    if (textY != 0) {
      y = nextY;
    }
  }
  x = fShowCred->textX;
  width = fShowCred->subTitleWidth;
  if (width == 0) {
    FETextRender_SetFont(0);
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    uVar4 = textpixels(pcVar3);
    pcVar3 = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    width = uVar4 - strlen(pcVar3);
  }
  if (x == 0) {
    if (fShowCred->subTitleJustify == 0) {
      x = fShowCred->subTitleX + width + 2;
    }
    else {
      x = (fShowCred->subTitleX - width) + -2;
    }
  }
  strcpy(buffer,fShowCred->text);
  p = (byte *)buffer;
  while (p != (byte *)0x0) {
    hidden = false;
    jaguar = false;
    rollthedice = false;
    p2 = (byte *)strchr((char *)p,10);
    if (p2 != 0) {
      *p2 = 0;
    }
    tagByte = *p;
    if (tagByte == 10) {
      /* MATCH (w37-a2): compare the skip-loop against the CAPTURED
         tagByte, not the literal again -- lets gcc reuse the register
         the initial `if` already loaded instead of a fresh `li`. */
      do {
        p = p + 1;
      } while (*p == tagByte);
      tagByte = *(volatile byte *)p;
    }
    if (tagByte == 9) {
      hidden = true;
      do {
        p = p + 1;
      } while (*p == tagByte);
    }
    tagByte = *p;
    if (tagByte == 0x2a) {
      jaguar = true;
      do {
        p = p + 1;
      } while (*p == tagByte);
      tagByte = *(volatile byte *)p;
    }
    if (tagByte == 0x5e) {
      rollthedice = true;
      do {
        p = p + 1;
      } while (*p == tagByte);
    }
    /* MATCH (w37-a2): a single conditional-value store (not two separate
       assignments) -- the oracle computes v0=2000/700 via one branch and
       stores it ONCE, scheduled into the jaguar-branch's delay slot. */
    CREDFADETICKS = rollthedice ? 2000 : 700;
    if (jaguar) {
      r.x = 0xb4;
      r.y = 0x55;
      r.w = 0x118;
      r.h = 100;
      pcVar3 = TextSys_Word(0x596);
      FETextRender_WordWrapTextRGBJustify(pcVar3,r,ColText,0,0,false);
      y = y + 8;
    }
    else if (rollthedice) {
      int rtd = 0;
      do {
        pcVar3 = TextSys_Word(rtd + 0x597);
        FETextRender_FullTextRGB(pcVar3,x,y,ColText,'\0',fShowCred->textJustify);
        y = y + 8;
        rtd = rtd + 1;
      } while (rtd < 0x19);
      y = y + 8;
    }
    else {
      /* MATCH (w37-a2): De Morgan physical block-order flip (W36 lever #1)
         -- the oracle's plain render is the FALL-THROUGH and the cheat
         check is the branch target, so the source condition is `!hidden`
         with the plain-render body first. */
      if (!hidden) {
        FETextRender_FullTextRGB((char *)p,x,y,ColText,'\0',fShowCred->textJustify);
      }
      else {
        if (FECheat_IsCheatEnabled(cheat_MyMomSaysImCool) != 0) {
          FETextRender_FullTextRGB((char *)p,x,y,CalcFadeVal(0x505050,this->fTextFade),'\0',fShowCred->textJustify);
        }
      }
      y = y + 8;
    }
    p = p2;
    if (p2 != 0) {
      p = p2 + 1;
    }
  }
  FETextRender_SetABR(0,false);
  if (this->StartedLines != 0) {
    /* MATCH (w37-a2): SYM shows the tail block's `dist`/`width`/`height`
       as NESTED-BLOCK locals distinct from the earlier top-level `width`
       (subTitleWidth-derived, REG s0) -- reusing that SAME C variable here
       merged the two live ranges and re-colored the earlier one too. Use
       a fresh `width2` for this block's shadowed `width` (SYM REG s2),
       with `dist` REASSIGNED in place (matches oracle's $s0 reuse). It
       stays LIVE into the second bright-line calc (oracle's `subu s1,v0,
       s2` reuses it there). */
    int width2;
    dist = ((ticks - this->fLineTicks) * 0x208) / 0x50;
    width2 = 200;
    if (dist < 200) {
      width2 = dist;
      dist = 200;
    }
    if (0x140 < dist) {
      width2 = 0x140 - dist;
      if (width2 < 0) {
        width2 = 0;
      }
      dist = 0x208 - width2;
    }
    if (0 < width2) {
      ColTextSubTitle = CalcFadeVal(0x505050,0x40);
      ColTextTitle = fShowCred->subTitleY + -2;
      PSXTransDrawBrightEndLine(ColTextSubTitle,dist + -0x25,ColTextTitle,width2,4,3,1,0,1);
    }
    dist = ((ticks - this->fLineTicks) * 0x10c) / 0x50;
    height = 100;
    if (dist < 100) {
      height = dist;
      dist = 100;
    }
    if (0xa8 < dist) {
      height = 0xa8 - dist;
      if (height < 0) {
        height = 0;
      }
      dist = 0x10c - width2;
    }
    if (0 < height) {
      ColTextTitle = CalcFadeVal(0x505050,0x40);
      PSXTransDrawBrightEndLine(ColTextTitle,(int)x,dist + -0x3a,2,height,1,1,0,1);
    }
  }
  return;
}



/* end of fecredits.cpp */
