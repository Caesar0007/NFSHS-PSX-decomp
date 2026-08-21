/* game/common/pausemenu.cpp -- RECONSTRUCTED (in-race pause-menu widget hierarchy; C++ TU)
 *   60 fns across 11 classes (tPListIterator[Indexed], tPMenuItem + NonInteractiveText/
 *   Interactive/LeftRightChoice/LeftRightSlider[Indexed]/GoToMenuButton/CommandButton, tPMenu)
 *   + 3 free text helpers. Member defs; manual _vf vtable dispatch; base-subobject _base_ routing.
 */
#include "../../nfs4_types.h"
#include "pausemenu_externs.h"

/* Data owned by PauseMenu.obj.  SYM records ChangedEnabling as EXT BOOL and
   gPause_CurrentY as file-static INT. */
bool ChangedEnabling;   /* @0x8013d2ec; CC1PLPSX bool is 4 bytes */
static int gPause_CurrentY;


/* ---- PauseMenu_FullText  [PAUSEMENU.CPP:60-82] SLD-VERIFIED ---- */

void PauseMenu_FullText(char *sMenuText,short x,short flags,short color)

{
  char *str;
  int iVar1;

  str = sMenuText;
  if (gPause_CurrentY == 0x62) {
    x = 0xa0;
    flags = 2;
    color = 6;
  }
  if (flags == 1) {
    iVar1 = textpixels(str);
    x = x - (short)iVar1;
  }
  else if (flags == 2) {
    iVar1 = textpixels(sMenuText);
    x = x - (short)(iVar1 / 2);
  }
  Font_TextColor((int)color);
  Font_TextXY(str,(int)x,gPause_CurrentY);
  return;
}



/* ---- PauseMenu_MenuTextPositioned  [PAUSEMENU.CPP:87-99] SLD-VERIFIED ---- */

void PauseMenu_MenuTextPositioned(short index,short selected,short disabled,short x)

{
  char *str;
  int iVar1;
  char *sMenuText;
  short color;
  
  iVar1 = TextSys_WordFlags((int)index);
  sMenuText = TextSys_Word((int)index);
  color = 4;
  if (selected != 0) {
    color = 3;
  }
  PauseMenu_FullText(sMenuText,x,(short)iVar1,color);
  return;
}



/* ---- PauseMenu_MenuText  [PAUSEMENU.CPP:103-109] SLD-VERIFIED ---- */

void PauseMenu_MenuText(short index,bool selected,bool disabled)

{
  int iVar1;
  
  iVar1 = TextSys_WordX((int)index);
  PauseMenu_MenuTextPositioned(index,(short)selected,
             (short)disabled,(short)iVar1);
  return;
}



/* ---- tPListIterator::ctor  [PAUSEMENU.CPP:123-125] SLD-VERIFIED ---- */

tPListIterator::tPListIterator(short *selection,int *valPtr)

{
  
  this->_vf = (__vtbl_ptr_type (*) [6])tPListIterator_vtable;
  this->fSelectionList = selection;
  this->fValue = valPtr;
  return;
}



/* ---- tPListIterator::dtor  [PAUSEMENU.CPP:129-129] SLD-VERIFIED ---- */

tPListIterator::~tPListIterator()

{
  this->_vf = (__vtbl_ptr_type (*) [6])tPListIterator_vtable;
  return;
}



/* ---- tPListIterator::Value  [PAUSEMENU.CPP:134-135] SLD-VERIFIED ---- */

char tPListIterator::Value(tPlayer arg1)

{
  return *this->fValue;
}



/* ---- tPListIterator::TextValue  [PAUSEMENU.CPP:139-140] SLD-VERIFIED ---- */

short tPListIterator::TextValue(tPlayer arg1)

{
  u_int uVar1;
  
  uVar1 = (*(*this->_vf)[2].pfn)((int)&this->fSelectionList + (int)(*this->_vf)[2].delta,0xffffffff)
  ;
  return (int)this->fSelectionList[uVar1 & 0xff];
}



/* ---- tPListIterator::Increment  [PAUSEMENU.CPP:144-149] SLD-VERIFIED ---- */

void tPListIterator::Increment(tPlayer arg1)

{
  *this->fValue = *this->fValue + 1;
  if (this->fSelectionList[*this->fValue] == 0) {
    *this->fValue = 0;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return;
}



/* ---- tPListIterator::Decrement  [PAUSEMENU.CPP:154-163] SLD-VERIFIED ---- */

void tPListIterator::Decrement(tPlayer arg1)

{
  short sVar1;
  int *piVar2;
  int *pWork;
  
  piVar2 = this->fValue;
  pWork = piVar2;
  if (*piVar2 == 0) {
    sVar1 = this->fSelectionList[1];
    while (0 < sVar1) {
      *pWork = *pWork + 1;
      pWork = this->fValue;
      sVar1 = this->fSelectionList[*pWork + 1];
    }
  }
  else {
    *piVar2 = *piVar2 + -1;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return;
}



/* ---- tPListIteratorIndexed::ctor  [PAUSEMENU.CPP:197-199] SLD-VERIFIED ---- */
tPListIteratorIndexed::tPListIteratorIndexed(short *selection,int *valPtr,char *index)
  : tPListIterator(selection,valPtr)
{
  
  this->_vf = (__vtbl_ptr_type (*) [6])tPListIteratorIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tPListIteratorIndexed::dtor  [PAUSEMENU.CPP:203-203] SLD-VERIFIED ---- */

tPListIteratorIndexed::~tPListIteratorIndexed()

{
  this->_vf = (__vtbl_ptr_type (*) [6])tPListIteratorIndexed_vtable;
  return;
}



/* ---- tPListIteratorIndexed::Value  [PAUSEMENU.CPP:207-208] SLD-VERIFIED ---- */

char tPListIteratorIndexed::Value(tPlayer arg1)

{
  return this->fValue[(u_char)*this->fIndex];
}



/* ---- tPListIteratorIndexed::TextValue  [PAUSEMENU.CPP:212-213] SLD-VERIFIED ---- */

short tPListIteratorIndexed::TextValue(tPlayer arg1)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = this->_vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&this->fSelectionList + (int)(*pa_Var1)[2].delta,
                     0xffffffff);
  return (int)this->fSelectionList[uVar2 & 0xff];
}



/* ---- tPListIteratorIndexed::Increment  [PAUSEMENU.CPP:219-224] SLD-VERIFIED ---- */

void tPListIteratorIndexed::Increment(tPlayer arg1)

{
  this->fValue[(u_char)*this->fIndex] =
      this->fValue[(u_char)*this->fIndex] + 1;
  if (this->fSelectionList[this->fValue[(u_char)*this->fIndex]] == 0) {
    this->fValue[(u_char)*this->fIndex] = 0;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return;
}



/* ---- tPListIteratorIndexed::Decrement  [PAUSEMENU.CPP:229-238] SLD-VERIFIED ---- */

void tPListIteratorIndexed::Decrement(tPlayer arg1)

{
  short sVar1;
  int iVar2;
  int *piVar3;
  u_char *pbVar4;
  
  pbVar4 = (u_char *)this->fIndex;
  piVar3 = this->fValue;
  iVar2 = piVar3[*pbVar4];
  if (iVar2 == 0) {
    sVar1 = this->fSelectionList[1];
    while (0 < sVar1) {
      piVar3[*pbVar4] = piVar3[*pbVar4] + 1;
      pbVar4 = (u_char *)this->fIndex;
      piVar3 = this->fValue;
      sVar1 = this->fSelectionList[piVar3[*pbVar4] + 1];
    }
  }
  else {
    piVar3[*pbVar4] = iVar2 + -1;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return;
}



/* ---- tPMenuItem::ctor  [PAUSEMENU.CPP:246-248] SLD-VERIFIED ---- */

tPMenuItem::tPMenuItem(u_int textDescription)

{
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItem_vtable;
  this->fTextDescription = textDescription;
  this->fFlags = 0;
  return;
}



/* ---- tPMenuItem::dtor  [PAUSEMENU.CPP:252-252] SLD-VERIFIED ---- */

tPMenuItem::~tPMenuItem()

{
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItem_vtable;
  return;
}



/* ---- tPMenuItem::NextMenu  [PAUSEMENU.CPP:256-257] SLD-VERIFIED ---- */

tPMenu * tPMenuItem::NextMenu()

{
  return (tPMenu *)0x0;
}



/* ---- tPMenuItem::Debounce  [PAUSEMENU.CPP:261-262] SLD-VERIFIED ---- */

bool tPMenuItem::Debounce()

{
  return 1;
}



/* ---- tPMenuItem::ProcessInput  [PAUSEMENU.CPP:266-267] SLD-VERIFIED ---- */

void tPMenuItem::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  return;
}



/* ---- tPMenuItemNonInteractiveText::ctor  [PAUSEMENU.CPP:273-274] SLD-VERIFIED ---- */
tPMenuItemNonInteractiveText::tPMenuItemNonInteractiveText(u_int textDescription)
  : tPMenuItem(textDescription)
{
  
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItemNonInteractiveText_vtable;
  return;
}



/* ---- tPMenuItemNonInteractiveText::dtor  [PAUSEMENU.CPP:278-278] SLD-VERIFIED ---- */

tPMenuItemNonInteractiveText::~tPMenuItemNonInteractiveText()

{
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItemNonInteractiveText_vtable;
  return;
}



/* ---- tPMenuItemNonInteractiveText::Draw  [PAUSEMENU.CPP:283-284] SLD-VERIFIED ---- */

void tPMenuItemNonInteractiveText::Draw(bool selected)

{
  
  PauseMenu_MenuText((short)this->fTextDescription,false,0);
  return;
}



/* ---- tPMenuItemInteractive::ctor  [PAUSEMENU.CPP:297-298] SLD-VERIFIED ---- */
tPMenuItemInteractive::tPMenuItemInteractive(u_int textDescription)
  : tPMenuItem(textDescription)
{
  
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItemInteractive_vtable;
  return;
}



/* ---- tPMenuItemInteractive::dtor  [PAUSEMENU.CPP:302-302] SLD-VERIFIED ---- */

tPMenuItemInteractive::~tPMenuItemInteractive()

{
  this->_vf = (__vtbl_ptr_type (*) [7])tPMenuItemInteractive_vtable;
  return;
}



/* ---- tPMenuItemInteractive::Draw  [PAUSEMENU.CPP:311-312] SLD-VERIFIED ---- */

void tPMenuItemInteractive::Draw(bool selected)

{
  PauseMenu_MenuText((short)this->fTextDescription,selected,this->fFlags & 1
            );
  return;
}



/* ---- tPMenuItemLeftRightChoice::ctor  [PAUSEMENU.CPP:319-321] SLD-VERIFIED ---- */
tPMenuItemLeftRightChoice::tPMenuItemLeftRightChoice(u_int textDescription,tPListIterator *dataPtr)
  : tPMenuItemInteractive(textDescription)
{
  
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightChoice_vtable;
  this->fData = dataPtr;
  return;
}



/* ---- tPMenuItemLeftRightChoice::dtor  [PAUSEMENU.CPP:325-325] SLD-VERIFIED ---- */

tPMenuItemLeftRightChoice::~tPMenuItemLeftRightChoice()

{
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightChoice_vtable;
  return;
}



/* ---- tPMenuItemLeftRightChoice::ProcessInput  [PAUSEMENU.CPP:329-341] SLD-VERIFIED ---- */

void tPMenuItemLeftRightChoice::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  if (keyval == kInput_KeyType_Left) {
    goto left;
  }
  if (keyval == kInput_KeyType_Right) {
    goto right;
  }
  return;

left:
    (*(*this->fData->_vf)[5].pfn)
              ((int)&this->fData->fSelectionList + (int)(*this->fData->_vf)[5].delta,
               0xffffffff);
    goto processed;
right:
    (*(*this->fData->_vf)[4].pfn)
              ((int)&this->fData->fSelectionList + (int)(*this->fData->_vf)[4].delta,
               0xffffffff);
processed:
  keyval = kInput_KeyType_AlreadyProcessed;
  return;
}



/* ---- tPMenuItemLeftRightChoice::Draw  [PAUSEMENU.CPP:346-369] SLD-VERIFIED ---- */

void tPMenuItemLeftRightChoice::Draw(bool selected)

{
  short index;
  short x;
  int vtable_p;
  int y;

  PauseMenu_MenuTextPositioned((short)this->fTextDescription, (short)selected,
             *(volatile u_int *)&this->fFlags & 1,
             (short)TextSys_WordX(this->fTextDescription));
  vtable_p = (int)this->fData->_vf;
  index = (**(int (**)(...))(vtable_p + 0x1c))
                    ((int)&this->fData->fSelectionList + (int)*(short *)(vtable_p + 0x18),0xffffffff
                    );
  x = (short)TextSys_WordX((int)index);
  PauseMenu_MenuTextPositioned(index, (short)selected,
                               *(volatile u_int *)&this->fFlags & 1, x);
  y = gPause_CurrentY;
  if ((selected != 0) && (GameSetup_gData.userSetting.language == 0))
  {
    struct PMenuTag {
      u_int addr : 24;
      u_int len : 8;
    };
    POLY_GT4 *prim;

    prim = (POLY_GT4 *)Render_gPacketPtr;
    ((PMenuTag *)prim)->addr = ((PMenuTag *)Render_gPalettePtr)->addr;
    ((PMenuTag *)Render_gPalettePtr)->addr = (u_int)prim;
    Render_gPacketPtr = (u_char *)(prim + 1);
    Hud_BuildGT4(prim, HudPmx_gShapes + 0x12,
                 x - textpixels(TextSys_Word((int)index)) - 8, y + 5, 0xbebe);

    prim = (POLY_GT4 *)Render_gPacketPtr;
    ((PMenuTag *)prim)->addr = ((PMenuTag *)Render_gPalettePtr)->addr;
    ((PMenuTag *)Render_gPalettePtr)->addr = (u_int)prim;
    Render_gPacketPtr = (u_char *)(prim + 1);
    Hud_BuildGT4(prim, HudPmx_gShapes + 0x13, x + 4, y + 5, 0xbebe);
  }
}



/* ---- tPMenuItemLeftRightSlider::ctor  [PAUSEMENU.CPP:441-444] SLD-VERIFIED ---- */
tPMenuItemLeftRightSlider::tPMenuItemLeftRightSlider(u_int textDescription,int *dataPtr,char maxVal)
  : tPMenuItemInteractive(textDescription)
{
  
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSlider_vtable;
  this->fData = dataPtr;
  this->fMaxVal = maxVal;
  return;
}



/* ---- tPMenuItemLeftRightSlider::dtor  [PAUSEMENU.CPP:449-449] SLD-VERIFIED ---- */

tPMenuItemLeftRightSlider::~tPMenuItemLeftRightSlider()

{
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSlider_vtable;
  return;
}



/* ---- tPMenuItemLeftRightSlider::Debounce  [PAUSEMENU.CPP:453-454] SLD-VERIFIED ---- */

bool tPMenuItemLeftRightSlider::Debounce()

{
  return 0;
}



/* ---- tPMenuItemLeftRightSlider::ProcessInput  [PAUSEMENU.CPP:458-485] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSlider::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  bool sound;
  
  sound = false;
  if (keyval == kInput_KeyType_Left) {
    goto PMLeftRtSlide_left;
  }
  if (keyval == kInput_KeyType_Right) {
    goto PMLeftRtSlide_right;
  }
  goto PMLeftRtSlide_playSound;

PMLeftRtSlide_left:
    if (0 < *this->fData) {
      int value;

      gMPauseUpdateNextTime = 1;
      value = *this->fData - (u_char)this->fMaxVal / 0x1e;
      if (value < 0) {
        value = 0;
      }
      *this->fData = value;
      goto PMLeftRtSlide_setPlayed;
    }
    goto PMLeftRtSlide_processed;
PMLeftRtSlide_right:
    if (*this->fData < (int)(u_int)(u_char)this->fMaxVal) {
      u_int max;
      int value;

      gMPauseUpdateNextTime = 1;
      value = *this->fData + (u_char)this->fMaxVal / 0x1e;
      max = (u_char)this->fMaxVal;
      if (value <= (int)max) {
        max = value;
      }
      *this->fData = max;
    }
    else {
      goto PMLeftRtSlide_processed;
    }
PMLeftRtSlide_setPlayed:
  sound = true;
PMLeftRtSlide_processed:
  keyval = kInput_KeyType_AlreadyProcessed;
PMLeftRtSlide_playSound:
  if (sound) {
    AudioCmn_PlayPauseSound(5);
  }
  return;
}



/* ---- tPMenuItemLeftRightSlider::Draw  [PAUSEMENU.CPP:498-534] SLD-VERIFIED ---- */

/*
 * MATCH: the SLD statement order and the three empty allocation fences below
 * move this function from 31 to 8 diffs.  allocsim confirms the complete
 * retail handout: y/s3, packetPtr/s4, i/s5, x/s6, the generated step/s7,
 * and xpos/fp.  The remaining named angle is loop.c's affine constant:
 * this spelling reduces i*5 with add=0 and adds 66 at the use, while retail
 * initializes the reduced GIV to 66.  A separate offset local or inline
 * helper does produce add=66, but grows vars 8 to 16 and regresses to 77.
 *
 * W59-A4 ORACLE EVIDENCE (upgrades the note above from "loop.c affine constant"
 * to a real source fact): the oracle carries `addiu $s7,$s7,0x5` at 800A7BF4
 * (Draw__25tPMenuItemLeftRightSliderb.s:152) next to `addiu $s7,$zero,0x42`
 * @800A7A18 -- retail did NOT reduce a giv, it wrote a REAL stepping local
 * (`step = 66; ...; step += 5;`) and the use is `addu $fp,$s6,$s7` = x + step.
 * MEASURED (all with the i*5 fence removed, since `step` supplies its refs):
 *   step local, decl anywhere in the list       -> 83  (frame 88 vs retail 80)
 *   + read-only fence on step / xpos / x        -> 83 / 84 / 84
 *   + 2-operand step fence                      -> 95
 *   decl-order sweep (step first/mid/last)      -> 83 (inert)
 *   dropping the i*5 fence alone (no step)      -> 81
 * The 83-basin is instruction-for-instruction closer (it HAS `li s7,66` +
 * `addu fp,s6,s7`) but costs 8 EXTRA BYTES OF `vars` -- one spilled pseudo the
 * retail frame does not have, with the same 10 saved regs.  That spill, not the
 * giv, is the real blocker: a local-alloc/QTY question (06E instrument gap).
 * Do NOT re-run the plain "separate offset local" experiment; it is receipted
 * twice now.  Next move is qtytrace on the 83-basin to name the spilled pseudo.
 *
 * ✅ W71-A22 (2026-08-21): **SEALED, PASS 169/169** -- and everything above is
 * now HISTORY, kept only as the falsification trail.  Both prior notes were
 * chasing the giv from the WRONG SIDE: the real defect was that `xpos` was
 * computed INSIDE the `if` (retail computes it unconditionally -- its
 * `addu $fp,$s6,$s7` is the `beqz` DELAY-SLOT insn, so it runs on both paths).
 * Hoisting it out of the guard AND spelling it as a block-local
 * `int off = i*5 + 66; xpos = x + off;` gives loop.c the `mult 5 add 66` giv
 * (= retail's `li $s7,66` / `addiu $s7,$s7,5`) with NO frame growth and NO
 * fence -- the 83-basin's extra spill was an artifact of the `step` local
 * competing with a still-conditional xpos.  The i*5 fence is retired with it,
 * so only TWO empty allocation fences remain in this function (the header
 * sentence above says three; it is stale as of this seal).
 * SEQUENCE MEASURED THIS WAVE (each a real gate run): conditional xpos +
 * step local 81-83; conditional xpos, i*5 fence dropped 81; `off` local while
 * still conditional 77 (frame 88 -- the 0xFF000000 bitfield mask then LICMs
 * into $fp and evicts xpos to the stack); unconditional flat
 * `x + (i*5+66)` 98 @169; unconditional `(i*5+66) + x` 5 @170 (fold
 * reassociates to `i*5 + (x+66)`); unconditional two-statement
 * `xpos = i*5+66; xpos += x;` 106; unconditional `off` local with `off + x`
 * 2 @169; with `x + off` **PASS**.
 */

void tPMenuItemLeftRightSlider::Draw(bool selected)

{
  short x;
  short y;
  int i;
  u_long col;
  int xpos;

  x = (short)TextSys_WordX(this->fTextDescription);
  y = gPause_CurrentY;
  PauseMenu_MenuTextPositioned((short)this->fTextDescription, (short)selected,
             *(volatile u_int *)&this->fFlags & 1, x);
  y += 4;
  i = 0;
  while (i < 15) {
    col = 0x323232;
    /* 🔴 CORRECTNESS + MATCH (W71-A22): retail computes xpos UNCONDITIONALLY --
       its `addu $fp,$s6,$s7` @800A7AB8 sits in the `beqz $v0,.L800A7AD4` DELAY
       SLOT, so it runs on BOTH paths (methodology S3.1).  The old shape computed
       it only inside the `if`, so every UNFILLED slider segment (the arm the
       guard skips) was drawn at the LAST FILLED segment's x instead of its own --
       and on i==0-false it read an uninitialised xpos.  Hud_FBuildF4 below uses
       xpos every iteration, so this was visible in the pause-menu slider.
       MATCH: the `off` BLOCK-LOCAL is what makes loop.c reduce the giv with
       `add 66` (= retail's `li $s7,66` + `addiu $s7,$s7,5`); a flat
       `xpos = (i*5+66) + x;` lets fold reassociate to `i*5 + (x+66)` -- giv
       add 0 + an in-loop `addiu v1,s6,66` (5 diffs), and the two-statement
       `xpos = i*5+66; xpos += x;` form loses the whole band (106).  -dL receipt:
       `Insn 109: giv ... mult 5 add 66 ... reduced` vs the old basin's
       `mult 5 add 0`.  `x + off` (not `off + x`) is load-bearing: it emits
       retail's `addu $fp,$s6,$s7` operand order (`off + x` = 2 diffs).
       This also RETIRES the old `__asm__("" : : "r"(i * 5))` allocation fence --
       the giv now supplies those refs by itself. */
    {
      int off = i * 5 + 66;
      xpos = x + off;
    }
    if (i < (*this->fData * 15) / (u_char)this->fMaxVal) {
      col = 0x808080;
      if (selected != 0) {
        col = 0xbebe;
      }
    }
    if ((selected != 0) && (GameSetup_gData.userSetting.language == 0)) {
      struct PMenuTag {
        u_int addr : 24;
        u_int len : 8;
      };
      POLY_GT4 *prim;
      u_char **packetPtr; /* SYM-CODEGEN-CARRIER: packetPtr -- allocsim-confirmed retail $s4. */

      packetPtr = (u_char **)0x1f800004;
      prim = (POLY_GT4 *)*packetPtr;
      ((PMenuTag *)prim)->addr = ((PMenuTag *)Render_gPalettePtr)->addr;
      ((PMenuTag *)Render_gPalettePtr)->addr = (u_int)prim;
      *packetPtr = (u_char *)(prim + 1);
      Hud_BuildGT4(prim, HudPmx_gShapes + 0x12, x + 53, y + 2, 0xbebe);

      prim = (POLY_GT4 *)*packetPtr;
      ((PMenuTag *)prim)->addr = ((PMenuTag *)Render_gPalettePtr)->addr;
      ((PMenuTag *)Render_gPalettePtr)->addr = (u_int)prim;
      *packetPtr = (u_char *)(prim + 1);
      Hud_BuildGT4(prim, HudPmx_gShapes + 0x13, x + 144, y + 2, 0xbebe);
      __asm__("" : : "r"((int)x), "r"(packetPtr));
    }
    Hud_FBuildF4(0, xpos, y + 2, 3, 5, col, '\0', '\0');
    __asm__("" : : "r"(y), "r"(i));
    i++;
  }
  Hud_FBuildF4(0, x + 63, y + 1, 79, 7, 0, '\0', '\0');
}



/* ---- tPMenuItemLeftRightSliderIndexed::ctor  [PAUSEMENU.CPP:541-543] SLD-VERIFIED ---- */
tPMenuItemLeftRightSliderIndexed::tPMenuItemLeftRightSliderIndexed(u_int textDescription,int *dataPtr,char maxVal,
          char *index)
  : tPMenuItemLeftRightSlider(textDescription,dataPtr,maxVal)
{
  
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSliderIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::dtor  [PAUSEMENU.CPP:547-547] SLD-VERIFIED ---- */

tPMenuItemLeftRightSliderIndexed::~tPMenuItemLeftRightSliderIndexed()

{
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSliderIndexed_vtable;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::ProcessInput  [PAUSEMENU.CPP:553-558] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSliderIndexed::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  int *orgdata;
  
  orgdata = this->fData;
  this->fData = orgdata + (u_char)*this->fIndex;
  this->tPMenuItemLeftRightSlider::ProcessInput(keyval,command);
  this->fData = orgdata;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::Draw  [PAUSEMENU.CPP:561-566] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSliderIndexed::Draw(bool selected)

{
  int *orgdata;
  
  orgdata = this->fData;
  this->fData = orgdata + (u_char)*this->fIndex;
  this->tPMenuItemLeftRightSlider::Draw(selected);
  this->fData = orgdata;
  return;
}



/* ---- tPMenuItemGoToMenuButton::ctor  [PAUSEMENU.CPP:573-576] SLD-VERIFIED ---- */

tPMenuItemGoToMenuButton::tPMenuItemGoToMenuButton(u_int textDescription,tPMenu *newMenu,
              void (*OnButtonPress)(tPMenuCommand&))
  : tPMenuItemInteractive(textDescription)
{
  
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemGoToMenuButton_vtable;
  this->fNewMenu = newMenu;
  this->fOnButtonPress = OnButtonPress;
  return;
}



/* ---- tPMenuItemGoToMenuButton::dtor  [PAUSEMENU.CPP:580-580] SLD-VERIFIED ---- */

tPMenuItemGoToMenuButton::~tPMenuItemGoToMenuButton()

{
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemGoToMenuButton_vtable;
  return;
}



/* ---- tPMenuItemGoToMenuButton::NextMenu  [PAUSEMENU.CPP:584-585] SLD-VERIFIED ---- */

tPMenu * tPMenuItemGoToMenuButton::NextMenu()

{
  return this->fNewMenu;
}



/* ---- tPMenuItemGoToMenuButton::ProcessInput  [PAUSEMENU.CPP:589-604] SLD-VERIFIED ---- */

void tPMenuItemGoToMenuButton::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  __vtbl_ptr_type (*pa_Var1) [7];
  int iVar2;
  tPMenu *ptVar3;
  
  if (keyval == kInput_KeyType_Cross) {
    AudioCmn_PlayPauseSound(4);
    pa_Var1 = this->_vf;
    iVar2 = (*(*pa_Var1)[2].pfn)
                      ((int)&this->fFlags +
                       (int)(*pa_Var1)[2].delta);
    if (iVar2 != 0) {
      command.type = kMPause_GoToMenu;
      pa_Var1 = this->_vf;
      ptVar3 = (tPMenu *)
               (*(*pa_Var1)[2].pfn)
                         ((int)&this->fFlags +
                          (int)(*pa_Var1)[2].delta);
      command.nextMenu = ptVar3;
    }
    if (this->fOnButtonPress != 0x0) {
      (*this->fOnButtonPress)(command);
    }
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  return;
}



/* ---- tPMenuItemCommandButton::ctor  [PAUSEMENU.CPP:613-615] SLD-VERIFIED ---- */
tPMenuItemCommandButton::tPMenuItemCommandButton(u_int textDescription,tPMenuCommandType command)
  : tPMenuItemInteractive(textDescription)
{
  
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemCommandButton_vtable;
  this->fCommand = command;
  return;
}



/* ---- tPMenuItemCommandButton::dtor  [PAUSEMENU.CPP:619-619] SLD-VERIFIED ---- */

tPMenuItemCommandButton::~tPMenuItemCommandButton()

{
  this->_vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemCommandButton_vtable;
  return;
}



/* ---- tPMenuItemCommandButton::ProcessInput  [PAUSEMENU.CPP:623-632] SLD-VERIFIED ---- */

void tPMenuItemCommandButton::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  
  if (keyval == kInput_KeyType_Cross) {
    AudioCmn_PlayPauseSound(4);
    command.type = this->fCommand;
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  return;
}



/* ---- tPMenu::tPMenuConstructor  [PAUSEMENU.CPP:640-659] SLD-VERIFIED ---- */

void tPMenu::tPMenuConstructor(tPMenuItem *firstItem,void *ap)

{
  tPMenuItem *p;
  int iVar2;
  int iVar3;

  ap = (void *)((int)ap + 4);
  this->fItemList[0] = firstItem;
  this->fNumItems = 0;
  p = ((tPMenuItem **)ap)[-1];
  this->fItemList[1] = p;
  if (p != (tPMenuItem *)0x0) {
    iVar3 = 4;
    do {
      iVar3 = iVar3 + 4;
      this->fNumItems = this->fNumItems + 1;
      ap = (void *)((int)ap + 4);
      iVar2 = ((int *)ap)[-1];
      *(int *)((int)this + iVar3 + 8) = iVar2;
    } while (iVar2 != 0);
  }
  return;
}



/* ---- tPMenu::ctor  [PAUSEMENU.CPP:669-675] SLD-VERIFIED ---- */

tPMenu::tPMenu(tPMenuItem *firstItem, ...)

{
  
  this->_vf = (__vtbl_ptr_type (*) [5])tPMenu_vtable;
  this->fCurrentItem = 0;
  this->tPMenuConstructor(firstItem,(u_char *)(&firstItem + 1));
  return;
}



/* ---- tPMenu::dtor  [PAUSEMENU.CPP:679-679] SLD-VERIFIED ---- */

tPMenu::~tPMenu()

{
  this->_vf = (__vtbl_ptr_type (*) [5])tPMenu_vtable;
  return;
}



/* ---- tPMenu::Initialize  [PAUSEMENU.CPP:683-695] SLD-VERIFIED ---- */

void tPMenu::Initialize()

{
  bool bVar1;
  int iVar2;
  tPMenuItem *ptVar3;
  
  this->fCurrentItem = 0;
  this->fHighlight = 1;
  ptVar3 = this->fItemList[this->fCurrentItem];
  bVar1 = false;
  if (((ptVar3->fFlags ^ 1) & 1) != 0) {
    iVar2 = (*(*ptVar3->_vf)[5].pfn)((int)&ptVar3->fFlags + (int)(*ptVar3->_vf)[5].delta);
    bVar1 = iVar2 != 0;
  }
  if (!bVar1) {
    while (true) {
      bool disabled;

      ptVar3 = this->fItemList[this->fCurrentItem];
      if (ptVar3 == (tPMenuItem *)0x0) {
        break;
      }
      disabled = false;
      if (((ptVar3->fFlags & 1) != 0) ||
         (iVar2 = (*(*ptVar3->_vf)[5].pfn)((int)&ptVar3->fFlags + (int)(*ptVar3->_vf)[5].delta),
         iVar2 == 0)) {
        disabled = true;
      }
      if (!disabled) {
        return;
      }
      this->fCurrentItem = this->fCurrentItem + 1;
    }
  }
  return;
}



/* ---- tPMenu::Debounce  [PAUSEMENU.CPP:698-699] SLD-VERIFIED ---- */

bool tPMenu::Debounce()

{
  __vtbl_ptr_type (*pa_Var1) [7];
  
  pa_Var1 = this->fItemList[this->fCurrentItem]->_vf;
  /* SYM declares the virtual result as native bool.  Preserve that result type
     at the manual vtable boundary so GCC trusts the callee's normalization,
     just as it would for the original C++ virtual call. */
  return (*(bool (*)(...))(*pa_Var1)[3].pfn)
                         ((int)&this->fItemList[this->fCurrentItem]->fFlags +
                          (int)(*pa_Var1)[3].delta);
}



/* ---- tPMenu::CheckForDisabled  [PAUSEMENU.CPP:703-712] SLD-VERIFIED ---- */

void tPMenu::CheckForDisabled()

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [7];
  int iVar3;
  tPMenuItem *ptVar4;
  tPMenu *ptVar5;
  
  while( true ) {
    pa_Var2 = this->fItemList[this->fCurrentItem]->_vf;
    bVar1 = false;
    iVar3 = (*(*pa_Var2)[5].pfn)
                      ((int)&this->fItemList[this->fCurrentItem]->fFlags + (int)(*pa_Var2)[5].delta)
    ;
    if ((iVar3 == 0) || ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0)) {
      bVar1 = true;
    }
    if (!bVar1) break;
    iVar3 = this->fCurrentItem;
    if (0 < this->fCurrentItem) {
      this->fCurrentItem = iVar3 + -1;
    }
    else {
      ptVar4 = this->fItemList[iVar3 + 1];
      if (ptVar4 != (tPMenuItem *)0x0) {
        do {
          ptVar5 = (tPMenu *)((char *)this + ((this->fCurrentItem + 2) << 2));
          this->fCurrentItem = this->fCurrentItem + 1;
          ptVar4 = ptVar5->fItemList[0];
        } while (ptVar4 != (tPMenuItem *)0x0);
      }
    }
  }
  return;
}



/* ---- tPMenu::ProcessInput  [PAUSEMENU.CPP:718-772] SLD-VERIFIED ---- */

void tPMenu::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  bool bVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [7];
  tPMenuItem *ptVar4;
  tInputKeyType tVar5;
  tPMenu *ptVar6;
  
  ptVar4 = this->fItemList[this->fCurrentItem];
  if (ptVar4 != (tPMenuItem *)0x0) {
    (*(*ptVar4->_vf)[4].pfn)((int)&ptVar4->fFlags + (int)(*ptVar4->_vf)[4].delta);
  }
  tVar5 = keyval;
  switch (tVar5) {
    case kInput_KeyType_Up:
      AudioCmn_PlayPauseSound(3);
      do {
        iVar2 = this->fCurrentItem;
        if (0 < this->fCurrentItem) {
          this->fCurrentItem = iVar2 + -1;
        }
        else {
          if (this->fItemList[iVar2 + 1] != (tPMenuItem *)0x0) {
            do {
              ptVar6 = (tPMenu *)((char *)this + ((this->fCurrentItem + 2) << 2));
              this->fCurrentItem = this->fCurrentItem + 1;
            } while (ptVar6->fItemList[0] != (tPMenuItem *)0x0);
          }
        }
        pa_Var3 = this->fItemList[this->fCurrentItem]->_vf;
        bVar1 = false;
        iVar2 = (*(*pa_Var3)[5].pfn)
                          ((int)&this->fItemList[this->fCurrentItem]->fFlags +
                           (int)(*pa_Var3)[5].delta);
        if ((iVar2 == 0) || ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0)) {
          bVar1 = true;
        }
      } while (bVar1);
      keyval = kInput_KeyType_AlreadyProcessed;
      return;

    case kInput_KeyType_Down:
      AudioCmn_PlayPauseSound(3);
      do {
        iVar2 = this->fCurrentItem;
        this->fCurrentItem = iVar2 + 1;
        if (this->fItemList[iVar2 + 1] == (tPMenuItem *)0x0) {
          this->fCurrentItem = 0;
        }
        pa_Var3 = this->fItemList[this->fCurrentItem]->_vf;
        bVar1 = false;
        iVar2 = (*(*pa_Var3)[5].pfn)
                          ((int)&this->fItemList[this->fCurrentItem]->fFlags +
                           (int)(*pa_Var3)[5].delta);
        if ((iVar2 == 0) || ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0)) {
          bVar1 = true;
        }
      } while (bVar1);
      keyval = kInput_KeyType_AlreadyProcessed;
      return;

    case kInput_KeyType_Start:
      AudioCmn_PlayPauseSound(4);
      command.type = kMPause_Continue;
      keyval = kInput_KeyType_AlreadyProcessed;
      return;

    case kInput_KeyType_Triangle:
      AudioCmn_PlayPauseSound(4);
      command.type = kMPause_BackupMenu;
      break;

    default:
      return;
  }
  keyval = kInput_KeyType_AlreadyProcessed;
  return;
}



/* ---- tPMenu::Draw  [PAUSEMENU.CPP:783-801] SLD-VERIFIED ---- */

void tPMenu::Draw()

{
  short item;
  __vtbl_ptr_type (*pa_Var1) [7];
  tPMenuItem *ptVar2;
  
  this->CheckForDisabled();
  ptVar2 = this->fItemList[0];
  pa_Var1 = ptVar2->_vf;
  gPause_CurrentY = 0x62;
  (*(*pa_Var1)[6].pfn)((int)&ptVar2->fFlags + (int)(*pa_Var1)[6].delta,false);
  item = 1;
  gPause_CurrentY = 0x75;
  while( true ) {
    tPMenuItem *ptVar4;

    ptVar4 = this->fItemList[item];
    if (ptVar4 == (tPMenuItem *)0x0) break;
    if (((ptVar4->fFlags ^ 1) & 1) != 0) {
      if (this->fHighlight != 0) {
        (*(*ptVar4->_vf)[6].pfn)
            ((int)&ptVar4->fFlags + (int)(*ptVar4->_vf)[6].delta,
             (int)item == this->fCurrentItem);
      }
      else {
        (*(*ptVar4->_vf)[6].pfn)
            ((int)&ptVar4->fFlags + (int)(*ptVar4->_vf)[6].delta,false);
      }
      gPause_CurrentY = gPause_CurrentY + 0xd;
    }
    item = item + 1;
  }
  return;
}



/* ---- tPMenu::NumEnabledItems  [PAUSEMENU.CPP:805-814] SLD-VERIFIED ---- */

int tPMenu::NumEnabledItems()

{
  int i;
  int ret;

  ret = this->fNumItems;
  i = 1;
  while (true) {
    if (this->fNumItems < i) {
      break;
    }
    if ((this->fItemList[i]->fFlags & 1) != 0) {
      ret = ret + -1;
    }
    i = i + 1;
  }
  return ret;
}

/* ---- tPMenu::ItemEnabledNum  [PAUSEMENU.CPP:818-825] SLD-VERIFIED ---- */

int tPMenu::ItemEnabledNum(int num)

{
  int i;
  int ret;

  ret = num;
  i = 0;
  while (1) {
    if (i >= num) break;
    if ((this->fItemList[i]->fFlags & 1) != 0) {
      ret = ret + -1;
    }
    i = i + 1;
  }
  return ret;
}

/* ---- tPMenuItemInteractive::IsNavigable  [PAUSEMENU.CPP:306-825] SLD-FLAG:NONMONO ---- */

bool tPMenuItemInteractive::IsNavigable()

{
  return 1;
}



/* ---- tPMenuItemNonInteractiveText::IsNavigable  [PAUSEMENU.CPP:288-307] SLD-FLAG:NONMONO ---- */

bool tPMenuItemNonInteractiveText::IsNavigable()

{
  return 0;
}



/* ---- tPMenuItem::IsEnabled  [PAUSEMENU.CPP:?] SLD-FLAG:NO_SLD ---- */

bool tPMenuItem::IsEnabled()

{
  return (this->fFlags ^ 1) & 1;
}



/* ---- tPMenuItem::IsDisabled  [PAUSEMENU.CPP:?] SLD-FLAG:NO_SLD ---- */

bool tPMenuItem::IsDisabled()

{
  int ret;
  short item;
  int *orgdata;
  u_int col;
  int i;
  
  return this->fFlags & 1;
}



/* end of pausemenu.cpp */
