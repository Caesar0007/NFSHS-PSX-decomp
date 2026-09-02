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
void tCreditManager::Init(int arg1)

{
  /* SYM-CODEGEN-CARRIER: arg1 -- the method's trailing `i` mangling proves the
     unused argument; optimized debug consequently has no parameter record. */
  char filename [80];
  
  if (this->fCreditsInitialized == 0) {
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
    this->CreditBuffer = reservememadr("records",filesize(filename),0);
    loadfileatadrz(filename,this->CreditBuffer);
    this->fNumCredits = (u_int)filesize(filename) / 0x144;
    this->fCreditsInitialized = 1;
  }
  return;
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
/* MATCH (2026-08-25, PASS 81/81): SYM records only the block-local `i`.
   EA's nested MIN/MAX expansion restores both fade clamps without the old
   decompiler `iVar2`/`fadeValue`/`uVar3` aliases or an empty asm fence.  The
   fTextFade MAX argument order is significant: field first reproduces the
   retail v1/a0 comparison and result funnel. */
{
  /* SYM-CODEGEN-CARRIER: mainScreen -- caching the global pointer gives the
     retail $a1 48-byte GIV while leaving the real SYM local `i` in $a2.
     Direct `screenMain->tvConfigs[i]` was measured FAIL 25 (84/81); the
     optimized source spelling that caused this handout is not unique. */
  tScreenMain *mainScreen;
  int i;

  if (selected) {
    this->fTVFade = this->fTVFade + 4;
  }
  else {
    this->fTVFade = this->fTVFade + -4;
  }
  this->fTVFade = MIN(0x5c,MAX(this->fTVFade,0));
  if (this->fTVFade < 0x5c) {
    this->fTextFade = MAX(this->fTextFade,0x80 - this->fTVFade);
  }
  mainScreen = screenMain;
  i = 0;
  do {
    mainScreen->tvConfigs[i].flags = mainScreen->tvConfigs[i].flags | 2;
    mainScreen->tvConfigs[i].tint =
        (0x80 - this->fTVFade) * 0x10000 |
        (0x80 - this->fTVFade) * 0x100 |
        (0x80 - this->fTVFade);
    i = i + 1;
  } while (i < 0x10);
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

/* MATCH (w37-a2 + 2026-08-03 follow-up, 58->PASS): SYM records the function-static
   `lasttick` (i.e. FECredits_lastFadeTick; SYM-CARRIER: lasttick), plus the nested
   line-66 `int NNNNN` in $v1 and the outer `this` receiver.  The remaining seven
   identities are optimized away and their private original spellings are not
   recoverable from SYM:
   SYM-CODEGEN-CARRIER: advanceRequested
   SYM-CODEGEN-CARRIER: inputPressed
   SYM-CODEGEN-CARRIER: nextCredit
   SYM-CODEGEN-CARRIER: textFade
   SYM-CODEGEN-CARRIER: currentCredit
   SYM-CODEGEN-CARRIER: backgroundReady
   SYM-CODEGEN-CARRIER: startTicksSnapshot
   Two levers found:
   (1) the fCurrCredit%3-or-bgNumber SwapBackground index is a SEPARATE
   nested-block local (SYM block@0x80035f94) for `currentCredit+1`, not a
   reassignment of currentCredit itself -- keeps currentCredit in $a0 matching the oracle
   instead of drifting to $a1. (2) both `ticks` reads that feed a
   store-after-a-call (fLineTicks, fStartTicks) read `ticks` directly at
   the point of use (not via a cached tick temporary) with the store-order
   `fLineTicks=ticks; StartedLines=1;`. The follow-up's compare-operand
   order makes the ticks `%hi` issue before CREDFADETICKS like retail,
   while the final block-local volatile snapshot preserves retail's
   second ticks load and keeps it in $v1 across the two preceding stores.
   The final two-diff load-order residual was source-shape: spelling the first
   wrap test as `fCurrCredit >= fNumCredits` presents GCC with retail's operand
   order while preserving the same comparison and branch. */
{
  bool advanceRequested;
  int inputPressed;
  int nextCredit;
  int textFade;
  int currentCredit;
  bool backgroundReady;

  if (((0xc < ticks - FECredits_lastFadeTick) && (this->fTextFade == 0)) &&
     (advanceRequested = false, this->fCurrCredit == this->fShowCreditNum)) {
    inputPressed = FEInput_GetNoDebounceKey(0x20,0);
    if ((inputPressed != 0) ||
       (inputPressed = FEInput_GetNoDebounceKey(0x20,1), inputPressed != 0))
    {
      advanceRequested = true;
    }
    if (advanceRequested) {
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
    this->fCurrCredit = this->fCurrCredit + 1;
    if (this->fCurrCredit >= this->fNumCredits) {
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
  textFade = this->fTextFade + this->fTextFadeDir;
  this->fTextFade = textFade;
  if (textFade < 1) {
    this->fTextFade = 0;
  }
  if (0x7f < this->fTextFade) {
    this->fTextFade = 0x80;
  }
  if ((this->fTextFade == 0x80) && (this->StartedTransition == 0)) {
    currentCredit = this->fCurrCredit;
    this->StartedTransition = 1;
    nextCredit = currentCredit + 1;
    this->fShowCreditNum = currentCredit;
    if (nextCredit >= this->fNumCredits) {
      nextCredit = 0;
    }
    if ((currentCredit == (currentCredit / 3) * 3) ||
        (this->CreditBuffer[nextCredit].bgNumber != -1)) {
      screenMain->SwapBackground((int)this->CreditBuffer[nextCredit].bgNumber);
      FECredits_lastFadeTick = ticks;
    }
    else {
      FECredits_lastFadeTick = 0;
    }
  }
  backgroundReady = false;
  if (((this->StartedLines == 0) && (this->StartedTransition != 0)) &&
      (0x80 < ticks - FECredits_lastFadeTick)) {
    backgroundReady = screenMain->DoneLoadingBackground() != 0;
  }
  if (backgroundReady) {
    this->fLineTicks = ticks;
    this->StartedLines = 1;
  }
  if (((this->StartedTextFade == 0) && (this->StartedLines != 0)) &&
     (0x1e < ticks - this->fLineTicks)) {
    int startTicksSnapshot = *(volatile int *)&ticks;
    this->StartedTextFade = 1;
    this->fTextFadeDir = -8;
    this->fStartTicks = startTicksSnapshot;
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
     zero code-size cost. The 2026-08-24 SLD follow-up restores `y` as the
     recorded SHORT and recovers the missing post-join statement: every tag
     case shares one final `y += 8` after the jaguar/rollthedice/normal branch,
     which GCC tail-duplicates into the retail predecessor delay slots.  The
     old branch-local copies made GCC combine the rollthedice increments and
     falsely required an unsigned full-width carrier.  A direct `textY` test
     followed by its unsigned source load reproduces retail's `lh`/`lhu` pair.
     The tail now restores SYM's nested `int width` in $s2 literally, shadowing
     the top-level `width` in $s0.  The six remaining optimized-away identities
     have no recoverable private spelling:
     SYM-CODEGEN-CARRIER: frameTick
     SYM-CODEGEN-CARRIER: titleFadeBase
     SYM-CODEGEN-CARRIER: subTitleFadeBase
     SYM-CODEGEN-CARRIER: text
     SYM-CODEGEN-CARRIER: pixelWidth
     SYM-CODEGEN-CARRIER: tag
     PASS, 451/451 instructions. */
  int frameTick;
  tCredit *fShowCred;
  short y;
  int titleFadeBase;
  int ColTextTitle;
  int subTitleFadeBase;
  int ColTextSubTitle;
  int ColText;
  char *text;
  uint pixelWidth;
  int width;
  short x;
  char *p, *p2;
  byte tag;
  bool hidden;
  bool jaguar;
  bool rollthedice;
  int dist;
  int height;
  tDrawShapeExtended drawFlags;
  RECT r;
  char buffer [292];

  drawFlags.tint[0] = 0xcec844;
  frameTick = ticks >> 4;
  DrawShapeExtended((frameTick - (frameTick / 10) * 10) + 0xe6,0x410,0x10,0x10,0,0,&drawFlags);
  fShowCred = this->CreditBuffer + this->fShowCreditNum;
  FETextRender_SetABR(1,true);
  y = (u_short)fShowCred->subTitleY;
  titleFadeBase = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextTitle = CalcFadeVal(titleFadeBase,0x28);
  subTitleFadeBase = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextSubTitle = CalcFadeVal(subTitleFadeBase,0x28);
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
    text = TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_WordWrapTextRGBJustify(text,r,ColTextTitle,fShowCred->titleJustify,0,false);
  }
  else {
    text = TextSys_Word(fShowCred->titleTextID + 0x514);
    FETextRender_FullTextRGB(text,fShowCred->titleX,fShowCred->titleY,ColTextTitle,'\0',
               fShowCred->titleJustify);
  }
  if (fShowCred->subTitleWidth != 0) {
    r.x = fShowCred->subTitleX;
    r.y = fShowCred->subTitleY;
    r.w = fShowCred->subTitleWidth;
    r.h = 100;
    text = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    y = y + FETextRender_WordWrapTextRGBJustify(text,r,ColTextSubTitle,fShowCred->subTitleJustify,0,false);
  }
  else {
    y = y + 8;
    text = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    FETextRender_FullTextRGB(text,fShowCred->subTitleX,fShowCred->subTitleY,ColTextSubTitle,'\0',
               fShowCred->subTitleJustify);
  }
  if (fShowCred->textY != 0) {
    y = (u_short)fShowCred->textY;
  }
  x = fShowCred->textX;
  width = fShowCred->subTitleWidth;
  if (width == 0) {
    FETextRender_SetFont(0);
    text = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    pixelWidth = textpixels(text);
    text = TextSys_Word(fShowCred->subTitleTextID + 0x514);
    width = pixelWidth - strlen(text);
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
    tag = *p;
    if (tag == 10) {
      /* MATCH (w37-a2): compare the skip-loop against the CAPTURED
         tag, not the literal again -- lets gcc reuse the register
         the initial `if` already loaded instead of a fresh `li`. */
      do {
        p = p + 1;
      } while (*p == tag);
      tag = *(volatile byte *)p;
    }
    if (tag == 9) {
      hidden = true;
      do {
        p = p + 1;
      } while (*p == tag);
    }
    tag = *p;
    if (tag == 0x2a) {
      jaguar = true;
      do {
        p = p + 1;
      } while (*p == tag);
      tag = *(volatile byte *)p;
    }
    if (tag == 0x5e) {
      rollthedice = true;
      do {
        p = p + 1;
      } while (*p == tag);
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
      text = TextSys_Word(0x596);
      FETextRender_WordWrapTextRGBJustify(text,r,ColText,0,0,false);
    }
    else if (rollthedice) {
      for (int rtd = 0; rtd < 0x19; rtd++) {
        text = TextSys_Word(rtd + 0x597);
        FETextRender_FullTextRGB(text,x,y,ColText,'\0',fShowCred->textJustify);
        y = y + 8;
      }
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
    }
    y = y + 8;
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
       a fresh nested `width` for this block (SYM REG s2),
       with `dist` REASSIGNED in place (matches oracle's $s0 reuse). It
       stays LIVE into the second bright-line calc (oracle's `subu s1,v0,
       s2` reuses it there). */
    int width;
    dist = ((ticks - this->fLineTicks) * 0x208) / 0x50;
    width = 200;
    if (dist < 200) {
      width = dist;
      dist = 200;
    }
    if (0x140 < dist) {
      width = 0x140 - dist;
      if (width < 0) {
        width = 0;
      }
      dist = 0x208 - width;
    }
    if (0 < width) {
      ColTextSubTitle = CalcFadeVal(0x505050,0x40);
      ColTextTitle = fShowCred->subTitleY + -2;
      PSXTransDrawBrightEndLine(ColTextSubTitle,dist + -0x25,ColTextTitle,width,4,3,1,0,1);
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
      dist = 0x10c - width;
    }
    if (0 < height) {
      ColTextTitle = CalcFadeVal(0x505050,0x40);
      PSXTransDrawBrightEndLine(ColTextTitle,(int)x,dist + -0x3a,2,height,1,1,0,1);
    }
  }
  return;
}



/* end of fecredits.cpp */
