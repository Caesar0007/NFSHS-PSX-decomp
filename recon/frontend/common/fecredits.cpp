/* frontend/common/fecredits.cpp -- RECONSTRUCTED (credits/scroll-text manager; C++ TU)
 *   class tCreditManager ; 7 methods. DrawCurrCredit phantoms (tCredit field offsets,
 *   anim-frame DrawShapeExtended, CalcFadeVal 2nd args, WordWrap color/justify) via m2c. */
#define NFS4_TU_FECREDITS   /* owner key: tCredit stays single-form here keep retail's C-style typedef form (2nd TPDEF at the definition) */
#include "fecredits.h"




/* ---- FECredits.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes) ---- */
/* P880: ticks and screenMain use their existing scalar declarations from
   fecredits_externs.h. Their former unsized-array aliases were not source
   storage; deleting them preserves the entire seven-function object. */
int CREDFADETICKS = 700;   /* @0x80051aa0; SYM EXT INT */


/* ---- tCreditManager::Setup  [FECREDITS.CPP:32-35] ---- */
#line 29 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
void tCreditManager::Setup()


{
  this->fCreditsInitialized = 0;
  this->fRequestDeInit = 0;
  this->fTVFade = 0;
}



/* ---- tCreditManager::Init  [FECREDITS.CPP:57-99] ---- */
  /* The trailing int remains in the ABI; retail SYM has no name for this
     unused parameter, so the definition leaves it unnamed.
     Source/SLD follow-up (2026-11-01): the initialized early return and real
     zero-store/credit-selection order preserve all56 words and restore the
     root end99 plus every instruction tag. The selected compiler schedules
     the later ShowCreditNum/TextFade constants before those earlier stores.
     Receipt: build/tmp/v/fecredits_fresh_20261101/proof.json. */
#line 54 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
void tCreditManager::Init(int)


{
  char filename [80]; if (this->fCreditsInitialized != 0) return;

    if (this->fRequestDeInit != 0) {
      this->fRequestDeInit = 0;
    }
    this->fStartTicks = 0;
    this->StartedTransition = 0;
    this->StartedLines = 0;
    this->StartedTextFade = 0;

    this->fRequestDeInit = 0;
    this->fShowCreditNum = -1;
    this->fCurrCredit = 0;
    this->fTextFade = 0x80;










    sprintf(filename,"%szcred%d.dat",Paths_Paths[0x25],(uint)(byte)frontEnd.language);







    this->CreditBuffer = reservememadr("records",filesize(filename),0);

    loadfileatadrz(filename,this->CreditBuffer);
    this->fNumCredits = (u_int)filesize(filename) / 0x144;




    this->fCreditsInitialized = 1;
}



/* ---- tCreditManager::DeInit  [FECREDITS.CPP:102-103] ---- */
#line 99 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
void tCreditManager::DeInit()


{
  this->fRequestDeInit = 1;
}



/* ---- tCreditManager::RealDeInit  [FECREDITS.CPP:107-117] ---- */
/* Source/SLD recovery: clear the request, return if already inactive, otherwise
 * release the buffer and fall through. The real body ends117. This preserves
 * all16 instructions/tags while restoring root end10 instead of11; simply
 * deleting the old inner return loses four correct epilogue tags.
 * Receipt: build/tmp/v/fecredits_cleanup_20261101/probes.json. */
#line 104 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
void tCreditManager::RealDeInit()


{
  
  this->fRequestDeInit = 0;


  if (this->fCreditsInitialized == 0) return;


  purgememadr(this->CreditBuffer);
  this->fCreditsInitialized = 0;
}





/* ---- tCreditManager::Draw  [FECREDITS.CPP:120-151] ---- */
void tCreditManager::Draw(bool selected)
/* MATCH (2026-08-25, PASS 81/81): SYM records only the block-local `i`.
   EA's nested MIN/MAX expansion restores both fade clamps without the old
   decompiler `iVar2`/`fadeValue`/`uVar3` aliases or an empty asm fence.  The
   fTextFade MAX argument order is significant: field first reproduces the
   retail v1/a0 comparison and result funnel.
   P880: direct scalar screenMain access also removes the extra mainScreen
   local; the native i/REG6 loop and all normal object bytes stay unchanged.
   Source/SLD follow-up (2026-11-01): genuine RealDeInit-arm return140 and
   implicit terminal fallthrough restore81 tags and all four block line/address
   records without changing the whole normal object or any declaration. */

#line 120 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
{
  if (selected) {
    this->fTVFade = this->fTVFade + 4;
  } else { this->fTVFade = this->fTVFade + -4;
  }
  this->fTVFade = MIN(0x5c,MAX(this->fTVFade,0));
  if (this->fTVFade < 0x5c) {
    this->fTextFade = MAX(this->fTextFade,0x80 - this->fTVFade);
  }
  { int i; i = 0; do {

      screenMain->tvConfigs[i].flags = screenMain->tvConfigs[i].flags | 2;
      screenMain->tvConfigs[i].tint = (0x80 - this->fTVFade) * 0x10000 | (0x80 - this->fTVFade) * 0x100 | (0x80 - this->fTVFade);
      i = i + 1; } while (i < 0x10);
  }
  if (this->fTVFade == 0) {


    if (this->fRequestDeInit != 0) {
      this->RealDeInit();
      return; }
  }
  else if (this->fCreditsInitialized != 0) {



    this->SetupCurrCredit();

    if (this->fShowCreditNum != -1) {
      this->DrawCurrCredit();
    }
  } }



/* ---- tCreditManager::SetupCurrCredit  [FECREDITS.CPP:155-238] ---- */
      /* MATCH (w37-a2): SYM shows a SEPARATE nested-block local at
         VA 0x80035f94 (line 66) for currentCredit+1, not a reassignment of
         currentCredit itself. */
  /* SYM5f1f9a: function-local STAT INT at object data+4, retail80051AA4.
     Explicit zero initialization retains the native initialized data run
     after CREDFADETICKS; link ownership excludes the raw oracle-only copy. */
void tCreditManager::SetupCurrCredit()

/* MATCH (w37-a2 + later source-restoration rounds): SYM records function-static
   `lasttick`, nested-block `NNNNN` in $v1, and `this`. The input-key tests now
   use direct short-circuiting. Source follow-up removes backgroundReady and
   textFade through the real background predicate and compound field update.
   Their old captures were not necessary source objects. Reusing fShowCreditNum after its assignment
   removes the source-only currentCredit carrier while preserving 199 instructions.
   The final time read uses the existing FE_Ticks getter directly. The current
   vars.h already declares the ISR-updated ticks global volatile; the old
   captured value and explicit volatile cast are unnecessary on this source
   shape. Repricing that old failure restores the two real getter regions
   without adding a qualifier, source object or artificial scope.
   Two levers found:
   (1) the fCurrCredit%3-or-bgNumber SwapBackground index is a SEPARATE
   nested-block local (SYM block@0x80035f94) for `currentCredit+1`, not a
   reassignment of currentCredit itself -- keeps currentCredit in $a0 matching the oracle
   instead of drifting to $a1. (2) both `FE_Ticks()` reads that feed a
   store-after-a-call (fLineTicks, fStartTicks) read `FE_Ticks()` directly at
   the point of use (not via a cached tick temporary) with the store-order
   `fLineTicks=FE_Ticks(); StartedLines=1;`. The follow-up's compare-operand
   order makes the FE_Ticks() `%hi` issue before CREDFADETICKS like retail,
   while real final field/source order preserves retail's second FE_Ticks()
   load and its $v1 value without a caller-local capture.
   Real nested timer guards also remove nextCredit: the outer start-time guard
   owns the inner elapsed-time predicate and its getter regions. A direct field
   increment then retains the supplied regions without a capture declaration.
   Source/SLD receipt: build/tmp/v/credits_tick_getter_20261101/proof.json.
   The inferred getter spelling is not uniquely retained original text.
   The final two-diff load-order residual was source-shape: spelling the first
   wrap test as `fCurrCredit >= fNumCredits` presents GCC with retail's operand
   order while preserving the same comparison and branch. */

#line 155 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
{
  static int lasttick = 0;
  if (((0xc < FE_Ticks() - lasttick) && (this->fTextFade == 0)) && this->fCurrCredit == this->fShowCreditNum)
  {
    if (FEInput_GetNoDebounceKey(0x20,0) != 0 || FEInput_GetNoDebounceKey(0x20,1) != 0)
    {
      AudioCmn_PlayFESFX(6);
      this->fCurrCredit = this->fShowCreditNum + 1;
      lasttick = FE_Ticks();
      this->fStartTicks = 0; }










    if (this->fCurrCredit >= this->fNumCredits) {
      this->fCurrCredit = 0;
    } if (this->fCurrCredit < 0) {
      this->fCurrCredit = this->fNumCredits + -1;
    }
  }


  if (this->fStartTicks != 0)
  {
    if (FE_Ticks() - this->fStartTicks > CREDFADETICKS) {

    this->fCurrCredit++;
    if (this->fNumCredits <= this->fCurrCredit) {
      this->fCurrCredit = 0;
    } if (this->fCurrCredit < 0) {
      this->fCurrCredit = this->fNumCredits + -1;
    }
    this->fStartTicks = 0;
    } }


  if (this->fShowCreditNum != this->fCurrCredit) {


    this->fTextFadeDir = 8;
    this->StartedTransition = 0;
    this->StartedLines = 0;
    this->StartedTextFade = 0;
  }

  this->fTextFade += this->fTextFadeDir;

  if (this->fTextFade < 1) {
    this->fTextFade = 0;
  } if (0x7f < this->fTextFade) {
    this->fTextFade = 0x80;
  }


  if ((this->fTextFade == 0x80) && (this->StartedTransition == 0))
  {
    this->StartedTransition = 1;
    this->fShowCreditNum = this->fCurrCredit;
    if ((this->fShowCreditNum == (this->fShowCreditNum / 3) * 3) || (this->CreditBuffer[this->fShowCreditNum].bgNumber != -1))
    {
      int NNNNN = this->fShowCreditNum + 1;
      if (this->fNumCredits < NNNNN) { NNNNN = 0;
      } screenMain->SwapBackground((int)this->CreditBuffer[NNNNN].bgNumber);
    }
  }


  if (((this->StartedLines == 0) && (this->StartedTransition != 0)) && screenMain->DoneLoadingBackground())
  {
    this->StartedLines = 1;
    this->fLineTicks = FE_Ticks();
  }

  if (((this->StartedTextFade == 0) && (this->StartedLines != 0)) && (0x1e < FE_Ticks() - this->fLineTicks))
  {
    this->fStartTicks = FE_Ticks();
    this->StartedTextFade = 1;
    this->fTextFadeDir = -8; } return; }



/* ---- tCreditManager::DrawCurrCredit  [FECREDITS.CPP:246] ---- */
    /* MATCH (w37-a2): SYM shows the tail block's `dist`/`width`/`height`
       as NESTED-BLOCK locals distinct from the earlier top-level `width`
       (subTitleWidth-derived, REG s0) -- reusing that SAME C variable here
       merged the two live ranges and re-colored the earlier one too. Use
       a fresh nested `width` for this block (SYM REG s2),
       with `dist` REASSIGNED in place (matches oracle's $s0 reuse). It
       stays LIVE into the second bright-line calc (oracle's `subu s1,v0,
       s2` reuses it there). */
      /* MATCH (w37-a2): De Morgan physical block-order flip (W36 lever #1)
         -- the oracle's plain render is the FALL-THROUGH and the cheat
         check is the branch target, so the source condition is `!hidden`
         with the plain-render body first. */
    /* Real conditional assignment arms retain distinct363/366 source notes.
       GCC merges both stores into the single retail store in the jaguar
       branch's slot; a shared ternary had hidden those two supplied tags. */
    /* W85-S5: same removal as the tag==10 arm above -- plain join re-read. */
    /* W85-S5: was `tag = *(volatile byte *)p;` INSIDE the block.  A plain
       re-read placed at the JOIN is byte-identical (7/7 PASS): the skip loop
       invalidates gcc's value for `*p`, so the join load is emitted fresh --
       no volatile needed.  Same shape the tag==9 arm already used. */
      /* MATCH (w37-a2): compare the skip-loop against the CAPTURED
         tag, not the literal again -- lets gcc reuse the register
         the initial `if` already loaded instead of a fresh `li`. */
  /* MATCH (w37-a2): physical block order flip (W36 lever #1 De Morgan swap)
     -- the oracle reaches the FullTextRGB body via a `beqz`-taken branch
     target and falls THROUGH into the WordWrap/RECT body, so the source
     condition is `!= 0` with the WordWrap body first (confirmed by m2c). */
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
     frame index arg is `(FE_Ticks()>>4) % 10`, not `FE_Ticks()/160` (m2c's guess) --
     mathematically equal for FE_Ticks()>=0 but the oracle's magic-multiply
     divides the ALREADY-SHIFTED value (shift=2 in the div-by-10 sequence),
     so the source must apply `% 10` to `FE_Ticks()>>4` for the codegen to match.
     Also a real bug: the cheat-gated FullTextRGB color was hardcoded
     `CalcFadeVal(0x505050,0x40)` -- the oracle reloads `this->fTextFade`
     (offset 8) as the 2nd arg, not the literal 0x40 (0x40 IS correct for
     the two tail bright-line CalcFadeVal calls, which stayed literal).
     Result: 610->8 verify_asm diffs, insn count now EXACT (451/451).
     Historically the 2026-08-03 follow-up made two tag reads volatile;
     later join-position recovery removed both qualifiers. That old necessity
     claim is superseded by the current ordinary reads documented above.
     That recovery restores both retail `lbu v1,0(s0)` reads at
     zero code-size cost. The 2026-08-24 SLD follow-up restores `y` as the
     recorded SHORT and recovers the missing post-join statement: every tag
     case shares one final `y += 8` after the jaguar/rollthedice/normal branch,
     which GCC tail-duplicates into the retail predecessor delay slots.  The
     old branch-local copies made GCC combine the rollthedice increments and
     falsely required an unsigned full-width carrier.  A direct `textY` test
     followed by its unsigned source load reproduces retail's `lh`/`lhu` pair.
     The tail now restores SYM's nested `int width` in $s2 literally, shadowing
     the top-level `width` in $s0.  P862 removes five source-only locals with
     direct expressions and the retained color locals. Each color's two-step
     fade follows retail SLD 269/270 and 272/273; the remaining tag snapshot
     has no supplied original spelling or proved source-object necessity;
     it remains the explicit source-review item below, not an exemption.
     PASS, 451/451 instructions. */
/* SOURCE-REVIEW-UNRESOLVED: tag is not supplied as an original local. Its
 * captured skip sentinel still needs source/macro recovery; literal-loop
 * failures do not prove a distinct source object. All451 numeric tags now
 * agree, but the parser-loop end remains149 versus retail148 at+0x534.
 * Receipt: build/tmp/v/credits_tick_getter_20261101/proof.json. */
#line 243 "C:/nfs4/FRONTEND/COMMON/FECREDITS.CPP"
void tCreditManager::DrawCurrCredit()


{
  tDrawShapeExtended drawFlags;
  tCredit *fShowCred; int width; short x; short y; int ColTextTitle; int ColTextSubTitle; int ColText; RECT r; char *p, *p2; char buffer [292]; byte tag; drawFlags.tint[0] = 0xcec844;
  DrawShapeExtended(((FE_Ticks() >> 4) % 10) + 0xe6,0x410,0x10,0x10,0,0,&drawFlags);


  fShowCred = this->CreditBuffer + this->fShowCreditNum;










  FETextRender_SetABR(1,true);



  y = (u_short)fShowCred->subTitleY;

  ColTextTitle = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextTitle = CalcFadeVal(ColTextTitle,0x28);

  ColTextSubTitle = CalcFadeVal(0xbebe,this->fTextFade);
  ColTextSubTitle = CalcFadeVal(ColTextSubTitle,0x28);
  ColText = CalcFadeVal(0x787878,this->fTextFade);


  if (fShowCred->titleWidth != 0) {


    r.x = fShowCred->titleX; r.y = fShowCred->titleY; r.w = fShowCred->titleWidth; r.h = 100;
    FETextRender_WordWrapTextRGBJustify(TextSys_Word(fShowCred->titleTextID + 0x514),
        r,ColTextTitle,fShowCred->titleJustify,0,false);
  }
  else {
    FETextRender_FullTextRGB(TextSys_Word(fShowCred->titleTextID + 0x514),
               fShowCred->titleX,fShowCred->titleY,ColTextTitle,'\0',
               fShowCred->titleJustify);
  }

  if (fShowCred->subTitleWidth != 0) {


    r.x = fShowCred->subTitleX; r.y = fShowCred->subTitleY; r.w = fShowCred->subTitleWidth; r.h = 100;
    y = y + FETextRender_WordWrapTextRGBJustify(TextSys_Word(fShowCred->subTitleTextID + 0x514),
        r,ColTextSubTitle,fShowCred->subTitleJustify,0,false);
  }
  else {

    FETextRender_FullTextRGB(TextSys_Word(fShowCred->subTitleTextID + 0x514),
               fShowCred->subTitleX,fShowCred->subTitleY,ColTextSubTitle,'\0',
               fShowCred->subTitleJustify);
    y = y + 8;
  }





  if (fShowCred->textY != 0) {
    y = (u_short)fShowCred->textY;
  } x = fShowCred->textX;

  width = fShowCred->subTitleWidth;
  if (width == 0) {

    FETextRender_SetFont(0);
    width = textpixels(TextSys_Word(fShowCred->subTitleTextID + 0x514)) -
        strlen(TextSys_Word(fShowCred->subTitleTextID + 0x514));
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
    bool hidden;
    bool jaguar;
    bool rollthedice; hidden = false; jaguar = false;
    rollthedice = false;

    p2 = (byte *)strchr((char *)p,10);
    if (p2 != 0) {
      *p2 = 0;
    } tag = *p; if (tag == 10) { do {
        p = p + 1; } while (*p == tag);
    } tag = *p; if (tag == 9) { hidden = true;
      do {

        p = p + 1; } while (*p == tag);
    }
    tag = *p; if (tag == 0x2a) { jaguar = true; do {


        p = p + 1; } while (*p == tag);
    }
    tag = *p; if (tag == 0x5e) { rollthedice = true; do {


        p = p + 1; } while (*p == tag);
    }
    if (rollthedice) CREDFADETICKS = 2000;

    else
      CREDFADETICKS = 700;

    if (jaguar) {

      r.x = 0xb4; r.y = 0x55; r.w = 0x118; r.h = 100;

      FETextRender_WordWrapTextRGBJustify(TextSys_Word(0x596),r,ColText,0,0,false);
    }
    else if (rollthedice)
    {
      for (int rtd = 0; rtd < 0x19; rtd++) {

        FETextRender_FullTextRGB(TextSys_Word(rtd + 0x597),x,y,ColText,'\0',fShowCred->textJustify);
        y = y + 8;
      }
    }
    else { if (!hidden) {

        FETextRender_FullTextRGB((char *)p,x,y,ColText,'\0',fShowCred->textJustify);
      }
      else { if (FECheat_IsCheatEnabled(cheat_MyMomSaysImCool) != 0) {
          FETextRender_FullTextRGB((char *)p,x,y,CalcFadeVal(0x505050,this->fTextFade),'\0',fShowCred->textJustify);
        }
      } } y = y + 8;
    p = p2;

    if (p2 != 0) {
      p = p2 + 1;
      {}
    }
  }
  FETextRender_SetABR(0,false);






  if (this->StartedLines != 0)
  { int dist;
    int width;
    int height; dist = ((FE_Ticks() - this->fLineTicks) * 0x208) / 0x50;
    width = 200;
    if (dist < 200) {

      width = dist;
      dist = 200;
    }
    if (0x140 < dist) {

      width = 0x140 - dist; if (width < 0) { width = 0;
      } dist = 0x208 - width;
    }

    if (0 < width) {





      ColTextSubTitle = CalcFadeVal(0x505050,0x40); ColTextTitle = fShowCred->subTitleY + -2; PSXTransDrawBrightEndLine(ColTextSubTitle,dist + -0x25,ColTextTitle,width,4,3,1,0,1);
    }

    dist = ((FE_Ticks() - this->fLineTicks) * 0x10c) / 0x50;
    height = 100;
    if (dist < 100) {

      height = dist;
      dist = 100;
    }
    if (0xa8 < dist) {

      height = 0xa8 - dist; if (height < 0) { height = 0;
      } dist = 0x10c - width;
    }

    if (0 < height) {





      ColTextTitle = CalcFadeVal(0x505050,0x40); PSXTransDrawBrightEndLine(ColTextTitle,(int)x,dist + -0x3a,2,height,1,1,0,1); } } return; }



/* end of fecredits.cpp */
