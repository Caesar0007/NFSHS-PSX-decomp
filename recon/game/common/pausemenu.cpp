/* game/common/pausemenu.cpp -- RECONSTRUCTED (in-race pause-menu widget hierarchy; C++ TU)
 *   60 fns across 11 classes (tPListIterator[Indexed], tPMenuItem + NonInteractiveText/
 *   Interactive/LeftRightChoice/LeftRightSlider[Indexed]/GoToMenuButton/CommandButton, tPMenu)
 *   + 3 free text helpers. Member defs; manual _vf vtable dispatch; base-subobject _base_ routing.
 */
#include "../../nfs4_types.h"
#include "pausemenu_externs.h"

/* STAT data owned by PauseMenu.obj (gPause_CurrentY @0x8013ddc4, file-static int) */
static int gPause_CurrentY;


/* ---- PauseMenu_FullText  [PAUSEMENU.CPP:60-82] SLD-VERIFIED ---- */

void PauseMenu_FullText(char *sMenuText,short x,short flags,short color)

{
  int iVar1;

  if (gPause_CurrentY == 0x62) {
    x = 0xa0;
    flags = 2;
    color = 6;
  }
  if (flags == 1) {
    iVar1 = textpixels(sMenuText);
    x = x - (short)iVar1;
  }
  else if (flags == 2) {
    iVar1 = textpixels(sMenuText);
    x = x - (short)(iVar1 / 2);
  }
  Font_TextColor((int)color);
  Font_TextXY(sMenuText,(int)x,gPause_CurrentY);
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

int tPListIterator::Value(tPlayer arg1)

{
  return *this->fValue;
}



/* ---- tPListIterator::TextValue  [PAUSEMENU.CPP:139-140] SLD-VERIFIED ---- */

int tPListIterator::TextValue(tPlayer arg1)

{
  u_int uVar1;
  
  uVar1 = (*(*this->_vf)[2].pfn)((int)&this->fSelectionList + (int)(*this->_vf)[2].delta,0xffffffff)
  ;
  return (int)this->fSelectionList[uVar1 & 0xff];
}



/* ---- tPListIterator::Increment  [PAUSEMENU.CPP:144-149] SLD-VERIFIED ---- */

int tPListIterator::Increment(tPlayer arg1)

{
  *this->fValue = *this->fValue + 1;
  if (this->fSelectionList[*this->fValue] == 0) {
    *this->fValue = 0;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return 1;
}



/* ---- tPListIterator::Decrement  [PAUSEMENU.CPP:154-163] SLD-VERIFIED ---- */

int tPListIterator::Decrement(tPlayer arg1)

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
  return 1;
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

int tPListIteratorIndexed::Value(tPlayer arg1)

{
  return this->fValue[(u_char)*this->fIndex];
}



/* ---- tPListIteratorIndexed::TextValue  [PAUSEMENU.CPP:212-213] SLD-VERIFIED ---- */

int tPListIteratorIndexed::TextValue(tPlayer arg1)

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

int tPListIteratorIndexed::Increment(tPlayer arg1)

{
  int *piVar1;
  
  piVar1 = this->fValue + (u_char)*this->fIndex;
  *piVar1 = *piVar1 + 1;
  piVar1 = this->fValue + (u_char)*this->fIndex;
  if (this->fSelectionList[*piVar1] == 0) {
    *piVar1 = 0;
  }
  AudioCmn_PlayPauseSound(5);
  gMPauseUpdateNextTime = 1;
  return 1;
}



/* ---- tPListIteratorIndexed::Decrement  [PAUSEMENU.CPP:229-238] SLD-VERIFIED ---- */

int tPListIteratorIndexed::Decrement(tPlayer arg1)

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
  return 1;
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

void * tPMenuItem::Debounce()

{
  return (void *)0x1;
}



/* ---- tPMenuItem::ProcessInput  [PAUSEMENU.CPP:266-267] SLD-VERIFIED ---- */

void tPMenuItem::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  return;
}



/* ---- tPMenuItemNonInteractiveText::ctor  [PAUSEMENU.CPP:273-274] SLD-VERIFIED ---- */
tPMenuItemNonInteractiveText::tPMenuItemNonInteractiveText(u_int textDescription)
  : _base_tPMenuItem(textDescription)
{
  
  (this->_base_tPMenuItem)._vf = (__vtbl_ptr_type (*) [7])tPMenuItemNonInteractiveText_vtable;
  return;
}



/* ---- tPMenuItemNonInteractiveText::dtor  [PAUSEMENU.CPP:278-278] SLD-VERIFIED ---- */

tPMenuItemNonInteractiveText::~tPMenuItemNonInteractiveText()

{
  (this->_base_tPMenuItem)._vf = (__vtbl_ptr_type (*) [7])tPMenuItemNonInteractiveText_vtable;
  return;
}



/* ---- tPMenuItemNonInteractiveText::Draw  [PAUSEMENU.CPP:283-284] SLD-VERIFIED ---- */

void tPMenuItemNonInteractiveText::Draw(bool selected)

{
  
  PauseMenu_MenuText((short)(this->_base_tPMenuItem).fTextDescription,false,0);
  return;
}



/* ---- tPMenuItemInteractive::ctor  [PAUSEMENU.CPP:297-298] SLD-VERIFIED ---- */
tPMenuItemInteractive::tPMenuItemInteractive(u_int textDescription)
  : _base_tPMenuItem(textDescription)
{
  
  (this->_base_tPMenuItem)._vf = (__vtbl_ptr_type (*) [7])tPMenuItemInteractive_vtable;
  return;
}



/* ---- tPMenuItemInteractive::dtor  [PAUSEMENU.CPP:302-302] SLD-VERIFIED ---- */

tPMenuItemInteractive::~tPMenuItemInteractive()

{
  (this->_base_tPMenuItem)._vf = (__vtbl_ptr_type (*) [7])tPMenuItemInteractive_vtable;
  return;
}



/* ---- tPMenuItemInteractive::Draw  [PAUSEMENU.CPP:311-312] SLD-VERIFIED ---- */

void tPMenuItemInteractive::Draw(bool selected)

{
  PauseMenu_MenuText((short)(this->_base_tPMenuItem).fTextDescription,selected,(this->_base_tPMenuItem).fFlags & 1
            );
  return;
}



/* ---- tPMenuItemLeftRightChoice::ctor  [PAUSEMENU.CPP:319-321] SLD-VERIFIED ---- */
tPMenuItemLeftRightChoice::tPMenuItemLeftRightChoice(u_int textDescription,tPListIterator *dataPtr)
  : _base_tPMenuItemInteractive(textDescription)
{
  
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightChoice_vtable;
  this->fData = dataPtr;
  return;
}



/* ---- tPMenuItemLeftRightChoice::dtor  [PAUSEMENU.CPP:325-325] SLD-VERIFIED ---- */

tPMenuItemLeftRightChoice::~tPMenuItemLeftRightChoice()

{
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightChoice_vtable;
  return;
}



/* ---- tPMenuItemLeftRightChoice::ProcessInput  [PAUSEMENU.CPP:329-341] SLD-VERIFIED ---- */

int tPMenuItemLeftRightChoice::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  short sVar1;
  int (*pcVar2)(...);
  tPListIterator *ptVar3;
  
  if (keyval == kInput_KeyType_Left) {
    ptVar3 = this->fData;
    sVar1 = (*ptVar3->_vf)[5].delta;
    pcVar2 = (*ptVar3->_vf)[5].pfn;
  }
  else {
    if (keyval != kInput_KeyType_Right) {
      return 0x1000;
    }
    ptVar3 = this->fData;
    sVar1 = (*ptVar3->_vf)[4].delta;
    pcVar2 = (*ptVar3->_vf)[4].pfn;
  }
  (*pcVar2)((int)&ptVar3->fSelectionList + (int)sVar1,0xffffffff);
  keyval = kInput_KeyType_AlreadyProcessed;
  return 1;
}



/* ---- tPMenuItemLeftRightChoice::Draw  [PAUSEMENU.CPP:346-369] SLD-VERIFIED ---- */

void tPMenuItemLeftRightChoice::Draw(bool selected)

{
  u_char *prim_00;
  short index;
  short x;
  int labelStrId;
  int vtable_p;
  int valueStrId;
  int labelText;
  int color;
  int pkt_addr24;
  int color_packed;
  short selected_00;
  POLY_GT4 *prim;
  u_char *prev_pkt;
  u_char *cur_pkt;
  u_char *drmode_p;
  int y;
  
  labelStrId = TextSys_WordX((this->_base_tPMenuItemInteractive)._base_tPMenuItem.fTextDescription);
  selected_00 = (short)selected;
  PauseMenu_MenuTextPositioned((short)(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fTextDescription,selected_00,
             (u_short)(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fFlags & 1,(short)labelStrId);
  vtable_p = (int)this->fData->_vf;
  index = (**(int (**)(...))(vtable_p + 0x1c))
                    ((int)&this->fData->fSelectionList + (int)*(short *)(vtable_p + 0x18),0xffffffff
                    );
  valueStrId = TextSys_WordX((int)index);
  x = (short)valueStrId;
  PauseMenu_MenuTextPositioned(index,selected_00,(u_short)(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fFlags & 1,x);
  y = gPause_CurrentY;
  prev_pkt = Render_gPacketPtr;
  cur_pkt = Render_gPalettePtr;
  if ((selected != 0) && (GameSetup_gData.userSetting.language == 0))
  {
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x34;
    *(u_int *)cur_pkt = *(u_int *)cur_pkt & 0xff000000 | pkt_addr24;
    labelText = (int)TextSys_Word((int)index);
    color = textpixels((char *)labelText);
    Hud_BuildGT4((POLY_GT4 *)prev_pkt,HudPmx_gShapes + 0x12,(x - color) + -8,y + 5,0xbebe);
    prim_00 = Render_gPacketPtr;
    drmode_p = Render_gPalettePtr;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    color_packed = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x34;
    *(u_int *)drmode_p = *(u_int *)drmode_p & 0xff000000 | color_packed;
    Hud_BuildGT4((POLY_GT4 *)prim_00,HudPmx_gShapes + 0x13,x + 4,y + 5,0xbebe);
  }
  return;
}



/* ---- tPMenuItemLeftRightSlider::ctor  [PAUSEMENU.CPP:441-444] SLD-VERIFIED ---- */
tPMenuItemLeftRightSlider::tPMenuItemLeftRightSlider(u_int textDescription,int *dataPtr,char maxVal)
  : _base_tPMenuItemInteractive(textDescription)
{
  
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSlider_vtable;
  this->fData = dataPtr;
  this->fMaxVal = maxVal;
  return;
}



/* ---- tPMenuItemLeftRightSlider::dtor  [PAUSEMENU.CPP:449-449] SLD-VERIFIED ---- */

tPMenuItemLeftRightSlider::~tPMenuItemLeftRightSlider()

{
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSlider_vtable;
  return;
}



/* ---- tPMenuItemLeftRightSlider::Debounce  [PAUSEMENU.CPP:453-454] SLD-VERIFIED ---- */

void * tPMenuItemLeftRightSlider::Debounce()

{
  return (void *)0x0;
}



/* ---- tPMenuItemLeftRightSlider::ProcessInput  [PAUSEMENU.CPP:458-485] SLD-VERIFIED ---- */

int tPMenuItemLeftRightSlider::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  bool bVar1;
  int iVar2;
  u_int uVar3;
  u_int uVar4;
  u_char sound;
  
  bVar1 = false;
  if (keyval == kInput_KeyType_Left) {
    if (0 < *this->fData) {
      gMPauseUpdateNextTime = 1;
      iVar2 = *this->fData - (u_char)this->fMaxVal / 0x1e;
      if (iVar2 < 0) {
        iVar2 = 0;
      }
      *this->fData = iVar2;
PMLeftRtSlide_setPlayed:
      bVar1 = true;
    }
  }
  else {
    iVar2 = 0x1000;
    if (keyval != kInput_KeyType_Right) goto PMLeftRtSlide_playSound;
    if (*this->fData < (int)(u_int)(u_char)this->fMaxVal) {
      gMPauseUpdateNextTime = 1;
      uVar3 = (u_int)(u_char)this->fMaxVal;
      uVar4 = *this->fData + uVar3 / 0x1e;
      if ((int)uVar4 <= (int)uVar3) {
        uVar3 = uVar4;
      }
      *this->fData = uVar3;
      goto PMLeftRtSlide_setPlayed;
    }
  }
  iVar2 = 1;
  keyval = kInput_KeyType_AlreadyProcessed;
PMLeftRtSlide_playSound:
  if (bVar1) {
    AudioCmn_PlayPauseSound(5);
  }
  return iVar2;
}



/* ---- tPMenuItemLeftRightSlider::Draw  [PAUSEMENU.CPP:498-534] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSlider::Draw(bool selected)

{
  u_char *prim;
  int labelStrId;
  int drmode_addr24;
  u_int uVar1;
  int pkt_addr24;
  int iVar2;
  int tickX;
  int xacc;
  int fadeColor;
  u_long col;
  int tickColor;
  short y;
  int label_y_pack;
  int label_y;
  int i;
  int endX;
  int valueX;
  int xpos;
  short x;
  u_char *tp1;
  u_char *tp2;
  u_char *tp3;
  int ti1;
  
  iVar2 = selected;
  endX = 0;
  xacc = 0x42;
  labelStrId = TextSys_WordX((this->_base_tPMenuItemInteractive)._base_tPMenuItem.fTextDescription);
  tickX = (int)(short)labelStrId;
  x = (short)labelStrId;
  label_y_pack = (int)(u_short)gPause_CurrentY;
  PauseMenu_MenuTextPositioned((short)(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fTextDescription,(short)iVar2,
             (u_short)(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fFlags & 1,(short)labelStrId);
  label_y = label_y_pack + 4;
  do {
    tp2 = Render_gPacketPtr;
    tp1 = Render_gPalettePtr;
    if (0xe < endX) {
      Hud_FBuildF4(0,x + 0x3f,(label_y * 0x10000 >> 0x10) + 1,0x4f,7,0,'\0','\0');
      return;
    }
    pkt_addr24 = (int)(u_char)this->fMaxVal;
    ti1 = *this->fData * 0xf;
    tickColor = 0x323232;
    if (endX < ti1 / pkt_addr24) {
      xpos = tickX + xacc;
      tickColor = 0x808080;
      if (iVar2 != 0) {
        tickColor = 0xbebe;
        goto Draw7ac8_labelYWrite;
      }
    }
    else {
Draw7ac8_labelYWrite:
      if ((iVar2 != 0) && (GameSetup_gData.userSetting.language == 0)) {
        fadeColor = (label_y * 0x10000 >> 0x10) + 2;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        drmode_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)tp1 = *(u_int *)tp1 & 0xff000000 | drmode_addr24;
        Hud_BuildGT4((POLY_GT4 *)tp2,HudPmx_gShapes + 0x12,tickX + 0x35,fadeColor,0xbebe);
        prim = Render_gPacketPtr;
        tp3 = Render_gPalettePtr;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        uVar1 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x34;
        *(u_int *)tp3 = *(u_int *)tp3 & 0xff000000 | uVar1;
        Hud_BuildGT4((POLY_GT4 *)prim,HudPmx_gShapes + 0x13,tickX + 0x90,fadeColor,0xbebe);
      }
    }
    Hud_FBuildF4(0,xpos,(label_y * 0x10000 >> 0x10) + 2,3,5,tickColor,'\0','\0');
    endX = endX + 1;
    xacc = xacc + 5;
  } while( true );
}



/* ---- tPMenuItemLeftRightSliderIndexed::ctor  [PAUSEMENU.CPP:541-543] SLD-VERIFIED ---- */
tPMenuItemLeftRightSliderIndexed::tPMenuItemLeftRightSliderIndexed(u_int textDescription,int *dataPtr,char maxVal,
          char *index)
  : _base_tPMenuItemLeftRightSlider(textDescription,dataPtr,maxVal)
{
  
  (this->_base_tPMenuItemLeftRightSlider)._base_tPMenuItemInteractive._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSliderIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::dtor  [PAUSEMENU.CPP:547-547] SLD-VERIFIED ---- */

tPMenuItemLeftRightSliderIndexed::~tPMenuItemLeftRightSliderIndexed()

{
  (this->_base_tPMenuItemLeftRightSlider)._base_tPMenuItemInteractive._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemLeftRightSliderIndexed_vtable;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::ProcessInput  [PAUSEMENU.CPP:553-558] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSliderIndexed::ProcessInput(tInputKeyType &keyval,tPMenuCommand &command)

{
  int *orgdata;
  
  orgdata = (this->_base_tPMenuItemLeftRightSlider).fData;
  (this->_base_tPMenuItemLeftRightSlider).fData = orgdata + (u_char)*this->fIndex;
  this->_base_tPMenuItemLeftRightSlider.ProcessInput(keyval,command);
  (this->_base_tPMenuItemLeftRightSlider).fData = orgdata;
  return;
}



/* ---- tPMenuItemLeftRightSliderIndexed::Draw  [PAUSEMENU.CPP:561-566] SLD-VERIFIED ---- */

void tPMenuItemLeftRightSliderIndexed::Draw(bool selected)

{
  int *orgdata;
  
  orgdata = (this->_base_tPMenuItemLeftRightSlider).fData;
  (this->_base_tPMenuItemLeftRightSlider).fData = orgdata + (u_char)*this->fIndex;
  this->_base_tPMenuItemLeftRightSlider.Draw(selected);
  (this->_base_tPMenuItemLeftRightSlider).fData = orgdata;
  return;
}



/* ---- tPMenuItemGoToMenuButton::ctor  [PAUSEMENU.CPP:573-576] SLD-VERIFIED ---- */

tPMenuItemGoToMenuButton::tPMenuItemGoToMenuButton(u_int textDescription,tPMenu *newMenu,
              void (*OnButtonPress)(tPMenuCommand&))
  : _base_tPMenuItemInteractive(textDescription)
{
  
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemGoToMenuButton_vtable;
  this->fNewMenu = newMenu;
  this->fOnButtonPress = (u_char **)OnButtonPress;
  return;
}



/* ---- tPMenuItemGoToMenuButton::dtor  [PAUSEMENU.CPP:580-580] SLD-VERIFIED ---- */

tPMenuItemGoToMenuButton::~tPMenuItemGoToMenuButton()

{
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
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
    pa_Var1 = (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf;
    iVar2 = (*(*pa_Var1)[2].pfn)
                      ((int)&(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fFlags +
                       (int)(*pa_Var1)[2].delta);
    if (iVar2 != 0) {
      command.type = kMPause_GoToMenu;
      pa_Var1 = (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf;
      ptVar3 = (tPMenu *)
               (*(*pa_Var1)[2].pfn)
                         ((int)&(this->_base_tPMenuItemInteractive)._base_tPMenuItem.fFlags +
                          (int)(*pa_Var1)[2].delta);
      command.nextMenu = ptVar3;
    }
    if (this->fOnButtonPress != (u_char **)0x0) {
      (*(void (*)(tPMenuCommand&))this->fOnButtonPress)(command);
    }
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  return;
}



/* ---- tPMenuItemCommandButton::ctor  [PAUSEMENU.CPP:613-615] SLD-VERIFIED ---- */
tPMenuItemCommandButton::tPMenuItemCommandButton(u_int textDescription,tPMenuCommandType command)
  : _base_tPMenuItemInteractive(textDescription)
{
  
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
       (__vtbl_ptr_type (*) [7])tPMenuItemCommandButton_vtable;
  this->fCommand = command;
  return;
}



/* ---- tPMenuItemCommandButton::dtor  [PAUSEMENU.CPP:619-619] SLD-VERIFIED ---- */

tPMenuItemCommandButton::~tPMenuItemCommandButton()

{
  (this->_base_tPMenuItemInteractive)._base_tPMenuItem._vf =
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
    while (ptVar3 = this->fItemList[this->fCurrentItem], ptVar3 != (tPMenuItem *)0x0) {
      bVar1 = false;
      if (((ptVar3->fFlags & 1) != 0) ||
         (iVar2 = (*(*ptVar3->_vf)[5].pfn)((int)&ptVar3->fFlags + (int)(*ptVar3->_vf)[5].delta),
         iVar2 == 0)) {
        bVar1 = true;
      }
      if (!bVar1) {
        return;
      }
      this->fCurrentItem = this->fCurrentItem + 1;
    }
  }
  return;
}



/* ---- tPMenu::Debounce  [PAUSEMENU.CPP:698-699] SLD-VERIFIED ---- */

void * tPMenu::Debounce()

{
  __vtbl_ptr_type (*pa_Var1) [7];
  void *pvVar2;
  
  pa_Var1 = this->fItemList[this->fCurrentItem]->_vf;
  pvVar2 = (void *)(*(*pa_Var1)[3].pfn)
                             ((int)&this->fItemList[this->fCurrentItem]->fFlags +
                              (int)(*pa_Var1)[3].delta);
  return pvVar2;
}



/* ---- tPMenu::CheckForDisabled  [PAUSEMENU.CPP:703-712] SLD-VERIFIED ---- */

void tPMenu::CheckForDisabled()

{
  bool bVar1;
  __vtbl_ptr_type (*pa_Var2) [7];
  int iVar3;
  tPMenuItem *ptVar4;
  
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
    if (iVar3 < 1) {
      ptVar4 = this->fItemList[iVar3 + 1];
      while (ptVar4 != (tPMenuItem *)0x0) {
        iVar3 = this->fCurrentItem;
        this->fCurrentItem = iVar3 + 1;
        ptVar4 = this->fItemList[iVar3 + 2];
      }
    }
    else {
      this->fCurrentItem = iVar3 + -1;
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
  
  ptVar4 = this->fItemList[this->fCurrentItem];
  if (ptVar4 != (tPMenuItem *)0x0) {
    (*(*ptVar4->_vf)[4].pfn)((int)&ptVar4->fFlags + (int)(*ptVar4->_vf)[4].delta);
  }
  tVar5 = keyval;
  if (tVar5 == kInput_KeyType_Up) {
    AudioCmn_PlayPauseSound(3);
    do {
      iVar2 = this->fCurrentItem;
      if (iVar2 < 1) {
        ptVar4 = this->fItemList[iVar2 + 1];
        while (ptVar4 != (tPMenuItem *)0x0) {
          iVar2 = this->fCurrentItem;
          this->fCurrentItem = iVar2 + 1;
          ptVar4 = this->fItemList[iVar2 + 2];
        }
      }
      else {
        this->fCurrentItem = iVar2 + -1;
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
  }
  if ((int)tVar5 < 0x201) {
    if (tVar5 != kInput_KeyType_Triangle) {
      return;
    }
    AudioCmn_PlayPauseSound(4);
    command.type = kMPause_BackupMenu;
  }
  else {
    if (tVar5 == kInput_KeyType_Down) {
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
    }
    if (tVar5 != kInput_KeyType_Start) {
      return;
    }
    AudioCmn_PlayPauseSound(4);
    command.type = kMPause_Continue;
  }
  keyval = kInput_KeyType_AlreadyProcessed;
  return;
}



/* ---- tPMenu::Draw  [PAUSEMENU.CPP:783-801] SLD-VERIFIED ---- */

void tPMenu::Draw()

{
  __vtbl_ptr_type (*pa_Var1) [7];
  tPMenuItem *ptVar2;
  bool bVar3;
  short item;
  
  this->CheckForDisabled();
  item = 1;
  pa_Var1 = this->fItemList[0]->_vf;
  gPause_CurrentY = 0x62;
  (*(*pa_Var1)[6].pfn)((int)&this->fItemList[0]->fFlags + (int)(*pa_Var1)[6].delta,0);
  gPause_CurrentY = 0x75;
  while( true ) {
    ptVar2 = this->fItemList[item];
    if (ptVar2 == (tPMenuItem *)0x0) break;
    if (((ptVar2->fFlags ^ 1) & 1) != 0) {
      if (this->fHighlight == 0) {
        pa_Var1 = ptVar2->_vf;
        bVar3 = false;
      }
      else {
        pa_Var1 = ptVar2->_vf;
        bVar3 = (int)item == this->fCurrentItem;
      }
      (*(*pa_Var1)[6].pfn)((int)&ptVar2->fFlags + (int)(*pa_Var1)[6].delta,bVar3);
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
  for (i = 1; i <= this->fNumItems; i = i + 1) {
    if ((this->fItemList[i]->fFlags & 1) != 0) {
      ret = ret + -1;
    }
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

void * tPMenuItemInteractive::IsNavigable()

{
  return (void *)0x1;
}



/* ---- tPMenuItemNonInteractiveText::IsNavigable  [PAUSEMENU.CPP:288-307] SLD-FLAG:NONMONO ---- */

void * tPMenuItemNonInteractiveText::IsNavigable()

{
  return (void *)0x0;
}



/* ---- tPMenuItem::IsEnabled  [PAUSEMENU.CPP:?] SLD-FLAG:NO_SLD ---- */

void * tPMenuItem::IsEnabled()

{
  return (void *)((this->fFlags ^ 1) & 1);
}



/* ---- tPMenuItem::IsDisabled  [PAUSEMENU.CPP:?] SLD-FLAG:NO_SLD ---- */

void * tPMenuItem::IsDisabled()

{
  int ret;
  short item;
  int *orgdata;
  u_int col;
  int i;
  
  return (void *)(this->fFlags & 1);
}



/* end of pausemenu.cpp */
