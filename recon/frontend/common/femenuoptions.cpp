/* frontend/common/femenuoptions.cpp -- RECONSTRUCTED (options-menu widget hierarchy; C++ TU)
 *   83 fns across 16 classes (tOptionsMenu, tInsideBox family, tMenuItem sliders/choices/sliding
 *   menus, tUserNameMenuItem, tMemoryCardMenuItem) + 7 free helpers (flares, boxes, stick-range,
 *   cheat-check) + data. Member defs; deep tMenuItem/tMenu inheritance; manual _vf dispatch.
 */
#include "femenuoptions.h"

/* EXT/STAT data owned by FeMenuOptions.obj (byte-exact from retail binary) */
/* Force .data (absolute addressing, NOT gp-rel/.sdata): the oracle reaches these via
 * lui %hi/%lo — no %gp_rel(PulsateYellow) exists anywhere in asm/nonmatchings (cf. §3.12#6). */
int PulsateYellow __attribute__((section(".data"))) = 0;        /* @0x800515ac */
int fHelpText = 0;            /* @0x800515b0 */
static int flareextra = 0;     /* file-static */


/* ---- CalcPulsateYellow  [FEMENUOPTIONS.CPP:77-82] SLD-VERIFIED ---- */
void CalcPulsateYellow(void)
{
  int pulsateval;

  pulsateval = ticks[0] % 0x80;
  if (0x40 < pulsateval) {
    pulsateval = 0x80 - pulsateval;
  }
  PulsateYellow = CalcFadeVal(0xbebe,pulsateval);
  return;
}

/* ---- DrawLeftFlare  [FEMENUOPTIONS.CPP:86-108] SLD-VERIFIED ---- */

void DrawLeftFlare(int y,int fSelFade,int fFadeVal,int &flareextra)

{
  int iVar1;
  int iVar2;
  int x;
  int index;
  int flare_intensity;
  int glintFade;
  
  if (fSelFade == 0x80) {
    iVar2 = flareextra + 1;
  }
  else {
    iVar2 = flareextra + 5;
    if (flareextra == 0) goto DrawLeftFlare_clampFlareExtra;
  }
  flareextra = iVar2;
DrawLeftFlare_clampFlareExtra:
  if (0x3c < flareextra) {
    flareextra = 0;
  }
  iVar2 = flareextra;
  if (iVar2 < 0x1f) {
    iVar2 = iVar2 - (iVar2 >> 0x1f);
  }
  else {
    iVar2 = (0x3c - iVar2) - (0x3c - iVar2 >> 0x1f);
  }
  iVar2 = ((iVar2 >> 1) + 0x14) * fSelFade * (0x80 - fFadeVal);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0x7f;
  }
  flare_intensity = iVar2 >> 7;
  glintFade = 0x80 - fSelFade;
  if (0x80 - fSelFade < fFadeVal) {
    glintFade = fFadeVal;
  }
  if (0 < flare_intensity) {
    x = TextSys_WordX(0x1de);
    iVar1 = (flare_intensity << 1) >> 0x1f;
    index = (flare_intensity << 1) / 3 + iVar1;
    Flare_2DHalo(x,y + 5,flare_intensity - (iVar2 >> 0x1f) >> 1,index - iVar1,0x17);
    DrawShapeExtended(0,0,x - 3,y - 1,flare_intensity,(u_int)(flare_intensity != 0),(tDrawShapeExtended *)0x0);
  }
  return;
}



/* ---- SubtractiveBox  [FEMENUOPTIONS.CPP:115-148] SLD-VERIFIED ---- */

void SubtractiveBox(int x,int y,int w,int h,int col1,int col2,int col3,int col4)

{
  u_short tpage;
  int pkt_addr24;
  int pkt_addr24_drm;
  DR_MODE *dr_mode;
  short y_plus_h;
  short x_plus_w;
  short x_s;
  short ts2;
  u_char *prim;
  u_char *prev_pkt;
  
  prim = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  x_s = (short)x;
  x_plus_w = x_s + (short)w;
  y_plus_h = y + (short)h;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x24;
  *(u_int *)prev_pkt = *(u_int *)prev_pkt & 0xff000000 | pkt_addr24;
  prim[3] = 8;
  *(int *)(prim + 4) = col1;
  *(int *)(prim + 0xc) = col2;
  *(int *)(prim + 0x14) = col3;
  *(int *)(prim + 0x1c) = col4;
  prim[7] = 0x3a;
  *(short *)(prim + 8) = x_s;
  *(short *)(prim + 10) = y;
  *(short *)(prim + 0x10) = x_plus_w;
  *(short *)(prim + 0x12) = y;
  *(short *)(prim + 0x18) = x_s;
  *(short *)(prim + 0x1a) = y_plus_h;
  *(short *)(prim + 0x20) = x_plus_w;
  *(short *)(prim + 0x22) = y_plus_h;
  dr_mode = (DR_MODE *)Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
  pkt_addr24_drm = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(u_int *)prev_pkt = *(u_int *)prev_pkt & 0xff000000 | pkt_addr24_drm;
  tpage = GetTPage(2,2,0,0x100);
  SetDrawMode(dr_mode,0,0,(u_int)tpage,(RECT *)0x0);
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionOff  [FEMENUOPTIONS.CPP:168-169] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::TransitionOff()

{
  this->fFadeDir = 0x1e;
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionOn  [FEMENUOPTIONS.CPP:173-179] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::TransitionOn()

{
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x1e;
  (this->_base_tMenuItemGoToMenuButton)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  this->fEnableVal = 0;
  return;
}



/* ---- tMenuItemGoToMenuButtonFade::TransitionIsFinished  [FEMENUOPTIONS.CPP:183-191] SLD-VERIFIED ---- */

void * tMenuItemGoToMenuButtonFade::TransitionIsFinished()

{
  this->fInTransition = 0;
  if (this->fFadeDir < 0) {
    if (0 < this->fFadeVal) {
      this->fInTransition = 1;
    }
  }
  if (0 < this->fFadeDir) {
    if (this->fFadeVal < 0x80) {
      this->fInTransition = 1;
    }
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemGoToMenuButtonFade::UpdateTransition  [FEMENUOPTIONS.CPP:195-199] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButtonFade::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = (this->_base_tMenuItemGoToMenuButton)._base_tMenuItemInteractive._base_tMenuItem._vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&(this->_base_tMenuItemGoToMenuButton)._base_tMenuItemInteractive._base_tMenuItem.fFlags +
             (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemLeftRightFade::ctor  [FEMENUOPTIONS.CPP:204-210] SLD-VERIFIED ---- */
tMenuItemLeftRightFade::tMenuItemLeftRightFade(u_int textDescription,tListIterator *dataPtr)
  : _base_tMenuItemLeftRightChoice(textDescription,dataPtr)
{
  
  *(void **)&((this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tMenuItemLeftRightFade_vtable;
  this->flareextra = 0;
  (this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionOff  [FEMENUOPTIONS.CPP:215-218] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::TransitionOff()

{
  this->fInTransition = 1;
  this->fFadeDir = 0x1e;
  this->fFadeVal = 0;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionOn  [FEMENUOPTIONS.CPP:221-227] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::TransitionOn()

{
  this->fInTransition = 1;
  this->fFadeDir = -0x1e;
  this->flareextra = 0;
  (this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  this->fFadeVal = 0x80;
  return;
}



/* ---- tMenuItemLeftRightFade::TransitionIsFinished  [FEMENUOPTIONS.CPP:231-241] SLD-VERIFIED ---- */

void * tMenuItemLeftRightFade::TransitionIsFinished()

{
  short sVar1;
  
  sVar1 = this->fFadeDir;
  if (sVar1 != 0) {
    if (sVar1 < 0) {
      if (this->fFadeVal < 1) goto LRFadeTrans_resetTrans;
      sVar1 = this->fFadeDir;
    }
    if ((sVar1 < 1) || (this->fFadeVal < 0x80)) {
      this->fInTransition = 1;
      goto LRFadeTrans_returnInv;
    }
  }
LRFadeTrans_resetTrans:
  this->fInTransition = 0;
LRFadeTrans_returnInv:
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemLeftRightFade::UpdateTransition  [FEMENUOPTIONS.CPP:245-249] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = (this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem._vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&(this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fFlags +
             (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tOptionsMenu::ctor  [FEMENUOPTIONS.CPP:267-276] SLD-VERIFIED ---- */

tOptionsMenu::tOptionsMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,int firstframe,int numframes,
              tMenuItem *firstItem,...)
  : _base_tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_base_tMenu._vf = (__vtbl_ptr_type (*)[11])tOptionsMenu_vtable;
  this->_base_tMenu.tMenuConstructor(firstItem,(&firstItem + 1));
  this->fScreenFade = 0;
  this->fPrevItem = 0;
  this->fFirstFrame = firstframe;
  this->fNumFrames = numframes;
  return;
}



/* ---- tOptionsMenu::dtor  [FEMENUOPTIONS.CPP:281-281] SLD-VERIFIED ---- */

tOptionsMenu::~tOptionsMenu()

{
  *(void **)&((this->_base_tMenu)._vf) = (void *)tOptionsMenu_vtable;
  return;
}



/* ---- tOptionsMenu::DebounceKeys  [FEMENUOPTIONS.CPP:286-289] SLD-VERIFIED ---- */

long tOptionsMenu::DebounceKeys()

{
  long lVar1;
  tMenuItem *ptVar2;
  
  ptVar2 = (this->_base_tMenu).fItemList[(this->_base_tMenu).fCurrentItem];
  if ((ptVar2 != (tMenuItem *)0x0) && (((ptVar2->fFlags & 1) ^ 1) != 0)) {
    return (*(*ptVar2->_vf)[2].pfn)((int)ptVar2 + (int)(*ptVar2->_vf)[2].delta);
  }
  return 0;
}



/* ---- tOptionsMenu::TransitionOff  [FEMENUOPTIONS.CPP:293-303] SLD-VERIFIED ---- */

void tOptionsMenu::TransitionOff()

{
  int iVar1;
  tMenuItem *ptVar2;
  int iVar3;
  int i;
  
  i = 0;
  ptVar2 = (this->_base_tMenu).fItemList[0];
  this->fTransitionDirection = '(';
  this->fScreenFade = 0;
  while (ptVar2 != (tMenuItem *)0x0) {
    iVar3 = *(int *)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
    iVar1 = *(int *)(iVar3 + 0x18);
    (**(int (**)(...))(iVar1 + 0x3c))(iVar3 + *(short *)(iVar1 + 0x38));
    i = i + 1;
    ptVar2 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
  }
  this->fInMenuTransition = 1;
  return;
}



/* ---- tOptionsMenu::TransitionOn  [FEMENUOPTIONS.CPP:308-320] SLD-VERIFIED ---- */

void tOptionsMenu::TransitionOn()

{
  int iVar1;
  tMenuItem *ptVar2;
  int iVar3;
  int i;
  
  i = 0;
  ptVar2 = (this->_base_tMenu).fItemList[0];
  this->fTransitionDirection = -0x28;
  this->fInMenuTransition = 1;
  this->fScreenFade = 0x228;
  while (ptVar2 != (tMenuItem *)0x0) {
    iVar3 = *(int *)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
    iVar1 = *(int *)(iVar3 + 0x18);
    (**(int (**)(...))(iVar1 + 0x44))(iVar3 + *(short *)(iVar1 + 0x40));
    i = i + 1;
    ptVar2 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
  }
  return;
}



/* ---- tOptionsMenu::TransitionIsFinished  [FEMENUOPTIONS.CPP:325-358] SLD-VERIFIED ---- */

void * tOptionsMenu::TransitionIsFinished()

{
  tMenuItem *ptVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [10];
  int iVar4;
  int i;
  
  if (((this->fScreenFade < 0x228) || (this->fTransitionDirection < '\x01')) &&
     ((0 < this->fScreenFade || (-1 < this->fTransitionDirection)))) {
    this->fInMenuTransition = 1;
  }
  else {
    this->fInMenuTransition = 0;
  }
  if (this->fInMenuTransition == 0) {
    i = 0;
    ptVar1 = (this->_base_tMenu).fItemList[0];
    while (ptVar1 != (tMenuItem *)0x0) {
      iVar4 = *(int *)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
      iVar2 = *(int *)(iVar4 + 0x18);
      iVar2 = (**(int (**)(...))(iVar2 + 0x4c))(iVar4 + *(short *)(iVar2 + 0x48));
      i = i + 1;
      if (iVar2 != 1) {
        this->fInMenuTransition = 1;
      }
      ptVar1 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
    }
  }
  pa_Var3 = FEApp->fCurrentScreen[0]->_vf;
  i = (*(*pa_Var3)[8].pfn)
                    ((FEApp->fCurrentScreen[0]->fPermShapes).fFilename + (*pa_Var3)[8].delta + -0x14
                    );
  if (i != 1) {
    this->fInMenuTransition = 1;
  }
  return (void *)(this->fInMenuTransition ^ 1);
}



/* ---- tOptionsMenu::UpdateTransition  [FEMENUOPTIONS.CPP:364-422] SLD-VERIFIED ---- */

void tOptionsMenu::UpdateTransition()

{
  int i;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [11];
  int iVar4;
  tMenuItem *ptVar5;
  bool bVar6;
  short sVar7;
  
  if (this->fInMenuTransition == 0) {
    i = 0;
    ptVar5 = (this->_base_tMenu).fItemList[0];
    while (ptVar5 != (tMenuItem *)0x0) {
      ptVar5 = (this->_base_tMenu).fItemList[(short)i];
      pa_Var3 = ptVar5->_vf;
      bVar6 = false;
      if (this->fInMenuTransition == 0) {
        bVar6 = (int)(short)i == (this->_base_tMenu).fCurrentItem;
      }
      (*(*pa_Var3)[10].pfn)((char *)ptVar5 + (int)(*pa_Var3)[10].delta,bVar6);
      i = i + 1;
      ptVar5 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
    }
    goto UpdTrans_callVT7;
  }
  if (this->fTransitionDirection < 0) {
    i = this->fScreenFade + (int)this->fTransitionDirection;
    if (0 < this->fScreenFade) {
      this->fScreenFade = i;
      if (i < 0) {
        this->fScreenFade = 0;
      }
      goto UpdTrans_callVT7;
    }
    i = 0;
    if ((this->_base_tMenu).fItemList[0] == (tMenuItem *)0x0) goto UpdTrans_callVT7;
    do {
      iVar4 = *(int *)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
      iVar2 = *(int *)(iVar4 + 0x18);
      iVar2 = (**(int (**)(...))(iVar2 + 0x4c))(iVar4 + *(short *)(iVar2 + 0x48));
      iVar4 = i + 1;
      if (iVar2 == 0) break;
      i = iVar4;
    } while (*(int *)((int)(this->_base_tMenu).fItemList + (iVar4 * 0x10000 >> 0xe)) != 0);
    ptVar5 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
    if (ptVar5 == (tMenuItem *)0x0) goto UpdTrans_callVT7;
feo_gotItem:
    (*(*ptVar5->_vf)[10].pfn)((char *)ptVar5 + (int)(*ptVar5->_vf)[10].delta,0);
  }
  else {
    i = 0;
    ptVar5 = (this->_base_tMenu).fItemList[0];
    while (ptVar5 != (tMenuItem *)0x0) {
      i = i + 1;
      ptVar5 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
    }
    i = i + -1;
    if (i * 0x10000 >> 0x10 != -1) {
      do {
        sVar7 = (short)i;
        iVar4 = *(int *)((int)(this->_base_tMenu).fItemList + ((i << 0x10) >> 0xe));
        iVar2 = *(int *)(iVar4 + 0x18);
        iVar2 = (**(int (**)(...))(iVar2 + 0x4c))(iVar4 + *(short *)(iVar2 + 0x48));
        i = i + -1;
        if (iVar2 == 0) break;
        sVar7 = (short)i;
      } while (i * 0x10000 >> 0x10 != -1);
      if (sVar7 != -1) {
        ptVar5 = (this->_base_tMenu).fItemList[sVar7];
        goto feo_gotItem;
      }
    }
    if ((this->fScreenFade < 0x228) &&
       (i = this->fScreenFade + (int)this->fTransitionDirection, this->fScreenFade = i,
       0x228 < i)) {
      this->fScreenFade = 0x228;
    }
  }
UpdTrans_callVT7:
  pa_Var3 = (this->_base_tMenu)._vf;
  (*(*pa_Var3)[7].pfn)((int)(this->_base_tMenu).fItemList + (*pa_Var3)[7].delta + -0x10);
  return;
}



/* ---- tOptionsMenu::Draw  [FEMENUOPTIONS.CPP:426-456] SLD-VERIFIED ---- */

void tOptionsMenu::Draw()

{
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  int i;
  bool bVar4;
  tDrawShapeExtended drawFlags;
  
  CalcPulsateYellow();
  ptVar1 = (this->_base_tMenu).fItemList[(this->_base_tMenu).fCurrentItem];
  if ((ptVar1 == (tMenuItem *)0x0) || ((ptVar1->fFlags & 1) != 0)) {
    (this->_base_tMenu).fCurrentItem = 0;
  }
  while ((i = (this->_base_tMenu).fCurrentItem, ((this->_base_tMenu).fItemList[i]->fFlags & 1) != 0 &&
         ((this->_base_tMenu).fItemList[i + 1] != (tMenuItem *)0x0))) {
    (this->_base_tMenu).fCurrentItem = i + 1;
  }
  while ((i = (this->_base_tMenu).fCurrentItem, ((this->_base_tMenu).fItemList[i]->fFlags & 1) != 0 &&
         (0 < i))) {
    (this->_base_tMenu).fCurrentItem = i + -1;
  }
  if ((-1 < this->fFirstFrame) && (0 < this->fNumFrames)) {
    drawFlags.tint[0] = 0xcec844;
    DrawShapeExtended(this->fFirstFrame + ((int)(ticks[0] >> 4) % this->fNumFrames),0x410,0x10,0x10,0,0,&drawFlags);
  }
  i = 0;
  ptVar1 = (this->_base_tMenu).fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    ptVar1 = (this->_base_tMenu).fItemList[(short)i];
    pa_Var2 = ptVar1->_vf;
    bVar4 = false;
    if (this->fInMenuTransition == 0) {
      bVar4 = (int)(short)i == (this->_base_tMenu).fCurrentItem;
    }
    (*(*pa_Var2)[5].pfn)((char *)ptVar1 + (int)(*pa_Var2)[5].delta,0,0,bVar4);
    i = i + 1;
    ptVar1 = *(tMenuItem **)((int)(this->_base_tMenu).fItemList + (i * 0x10000 >> 0xe));
  }
  return;
}



/* ---- tOptionsMenu::ProcessInput  [FEMENUOPTIONS.CPP:462-504] SLD-VERIFIED ---- */

void tOptionsMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  short sVar1;
  
  sVar1 = this->_base_tMenu.GetNumberEnabledItems();
  if (sVar1 == 0) {
    (this->_base_tMenu).fCurrentItem = 0;
    if ((keyval != kInput_KeyType_Triangle) && (keyval != kInput_KeyType_Circle)) {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  this->_base_tMenu.ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tInsideBoxMenu::ctor  [FEMENUOPTIONS.CPP:520-528] SLD-VERIFIED ---- */

tInsideBoxMenu::tInsideBoxMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : _base_tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title)
{
  
  this->_base_tMenu._vf = (__vtbl_ptr_type (*)[11])tInsideBoxMenu_vtable;
  this->_base_tMenu.tMenuConstructor(firstItem,(&firstItem + 1));
  this->fPrevItem = 0;
  this->fMoving = 0;
  this->fMovingDir = 0;
  return;
}



/* ---- tInsideBoxMenu::dtor  [FEMENUOPTIONS.CPP:532-532] SLD-VERIFIED ---- */

tInsideBoxMenu::~tInsideBoxMenu()

{
  *(void **)&((this->_base_tMenu)._vf) = (void *)tInsideBoxMenu_vtable;
  return;
}



/* ---- tInsideBoxMenu::ProcessInput  [FEMENUOPTIONS.CPP:537-554] SLD-VERIFIED ---- */

void tInsideBoxMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  tInputKeyType tVar2;
  tMenuItem *ptVar3;
  
  if (this->fMoving != 0) {
    tVar2 = keyval;
    if ((tVar2 != kInput_KeyType_Up) && (tVar2 != kInput_KeyType_Down))
    goto ProcInpFE_keyUpItemZero;
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  tVar2 = keyval;
ProcInpFE_keyUpItemZero:
  if ((tVar2 == kInput_KeyType_Up) && ((this->_base_tMenu).fCurrentItem == 0)) {
    ptVar3 = (this->_base_tMenu).fItemList[0];
    pa_Var1 = ptVar3->_vf;
    (*(*pa_Var1)[3].pfn)((char *)ptVar3 + (int)(*pa_Var1)[3].delta);
  }
  else if ((keyval != kInput_KeyType_Down) ||
          ((this->_base_tMenu).fItemList[(this->_base_tMenu).fCurrentItem + 1] != (tMenuItem *)0x0)) {
    this->_base_tMenu.ProcessInput(fromPlayer,keyval,command);
  }
  return;
}



/* ---- tInsideBoxMenu::Draw  [FEMENUOPTIONS.CPP:558-605] SLD-VERIFIED ---- */

int tInsideBoxMenu::Draw(short x,short y,short w,short slideOffset,short arg5)

{
  short sVar1;
  u_short uVar2;
  __vtbl_ptr_type (*pa_Var3) [11];
  int i;
  int j;
  tMenuItem *ptVar6;
  bool bVar7;
  
  i = (this->_base_tMenu).fCurrentItem;
  if (i != this->fPrevItem) {
    if (this->fPrevItem < i) {
      this->fMoving = 0x18;
      sVar1 = -4;
    }
    else {
      this->fMoving = -0x18;
      sVar1 = 4;
    }
    this->fMovingDir = sVar1;
    this->fPrevItem = (short)(this->_base_tMenu).fCurrentItem;
  }
  if (this->fMoving != 0) {
    uVar2 = this->fMoving + this->fMovingDir;
    this->fMoving = uVar2;
    if ((this->fMovingDir < 0) && ((int)((u_int)uVar2 << 0x10) < 0)) {
      this->fMoving = 0;
    }
    if ((0 < this->fMovingDir) && (0 < this->fMoving)) {
      this->fMoving = 0;
    }
  }
  i = 0;
  do {
    j = (u_int)(u_short)(this->_base_tMenu).fCurrentItem + i + -2;
    if ((3 < (short)i) &&
       (*(int *)((int)(this->_base_tMenu).fItemList + (j * 0x10000 >> 0xe) + -4) == 0)) {
      return 0;
    }
    j = j * 0x10000 >> 0x10;
    if ((-1 < j) && (ptVar6 = (this->_base_tMenu).fItemList[j], ptVar6 != (tMenuItem *)0x0)) {
      if (this->fMoving == 0) {
        bVar7 = j == (this->_base_tMenu).fCurrentItem;
      }
      else {
        bVar7 = false;
      }
      (*(*ptVar6->_vf)[10].pfn)((char *)ptVar6 + (int)(*ptVar6->_vf)[10].delta,bVar7);
      ptVar6 = (this->_base_tMenu).fItemList[(short)j];
      pa_Var3 = ptVar6->_vf;
      if (this->fMoving == 0) {
        bVar7 = (int)(short)j == (this->_base_tMenu).fCurrentItem;
      }
      else {
        bVar7 = false;
      }
      (*(*pa_Var3)[6].pfn)
                ((char *)ptVar6 + (int)(*pa_Var3)[6].delta,(int)x,
                 (int)this->fMoving + (int)y + (int)slideOffset + ((short)i + -1) * 0x18 + 5,
                 (int)w,bVar7);
    }
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 5);
  return 0;
}



/* ---- tMenuItemSlidingMenu::ctor  [FEMENUOPTIONS.CPP:612-624] SLD-VERIFIED ---- */
tMenuItemSlidingMenu::tMenuItemSlidingMenu(u_int textDescription,short width,short height,short diffx,
          short diffy,bool fillback)
  : _base_tMenuItem(textDescription)
{
  u_int uVar1;
  
  uVar1 = (this->_base_tMenuItem).fFlags;
  this->currMenu = (tInsideBoxMenu *)0x0;
  this->nextMenu = (tInsideBoxMenu *)0x0;
  this->fWidth = width;
  this->fHeight = height;
  (this->_base_tMenuItem).fSelFade = 0;
  (this->_base_tMenuItem).fFlags = uVar1 | 0x80;
  uVar1 = (this->_base_tMenuItem).fFlags;
  *(void **)&((this->_base_tMenuItem)._vf) = (void *)tMenuItemSlidingMenu_vtable;
  this->fDiffX = diffx;
  this->fDiffY = diffy;
  this->fFillback = fillback;
  (this->_base_tMenuItem).fFlags = uVar1 | 0x80;
  return;
}



/* ---- tMenuItemSlidingMenu::dtor  [FEMENUOPTIONS.CPP:628-628] SLD-VERIFIED ---- */

tMenuItemSlidingMenu::~tMenuItemSlidingMenu()

{
  *(void **)&((this->_base_tMenuItem)._vf) = (void *)tMenuItemSlidingMenu_vtable;
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionOff  [FEMENUOPTIONS.CPP:634-641] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::TransitionOff()

{
  this->fFadeDir = 0;
  this->fTransitioningOut = 1;
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    this->fInTransition = 1;
    this->fFadeDir = 0x1e;
    this->fFadeVal = 0;
  }
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionOn  [FEMENUOPTIONS.CPP:648-657] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::TransitionOn()

{
  this->fFadeDir = -0x1e;
  this->fInTransition = 1;
  this->fOpenHeight = 0;
  this->fTransitioningOut = 0;
  this->fFadeVal = 0x80;
  this->fSlideOffset = this->fHeight + (this->fHeight >> 1);
  return;
}



/* ---- tMenuItemSlidingMenu::TransitionIsFinished  [FEMENUOPTIONS.CPP:661-676] SLD-VERIFIED ---- */

void * tMenuItemSlidingMenu::TransitionIsFinished()

{
  short sVar1;
  
  if ((this->currMenu == (tInsideBoxMenu *)0x0) || (this->nextMenu == (tInsideBoxMenu *)0x0)) {
    this->fFadeDir = 0;
  }
  else {
    sVar1 = this->fFadeDir;
    if (sVar1 != 0) {
      if (sVar1 < 0) {
        if (this->fFadeVal < 1) goto SlideMenuTrans_resetTrans;
        sVar1 = this->fFadeDir;
      }
      if ((sVar1 < 1) || (this->fFadeVal < 0x80)) {
        this->fInTransition = 1;
        goto SlideMenuTrans_returnInv;
      }
    }
  }
SlideMenuTrans_resetTrans:
  this->fInTransition = 0;
SlideMenuTrans_returnInv:
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemSlidingMenu::UpdateTransition  [FEMENUOPTIONS.CPP:680-690] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = (this->_base_tMenuItem)._vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)((int)&(this->_base_tMenuItem).fFlags + (int)(*pa_Var1)[9].delta);
  this->_base_tMenuItem.UpdateTransition(selected);
  return;
}



/* ---- tMenuItemSlidingMenu::DebounceKeys  [FEMENUOPTIONS.CPP:696-698] SLD-VERIFIED ---- */

long tMenuItemSlidingMenu::DebounceKeys()

{
  u_int uVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  tInsideBoxMenu *ptVar3;
  
  ptVar3 = this->currMenu;
  uVar1 = 0x600;
  if (ptVar3 != (tInsideBoxMenu *)0x0) {
    pa_Var2 = (ptVar3->_base_tMenu)._vf;
    uVar1 = (*(*pa_Var2)[4].pfn)((int)ptVar3 + (*pa_Var2)[4].delta);
    uVar1 = uVar1 | 0x600;
  }
  return uVar1;
}



/* ---- tMenuItemSlidingMenu::Draw  [FEMENUOPTIONS.CPP:705-706] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::Draw(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  
  pa_Var1 = (this->_base_tMenuItem)._vf;
  (*(*pa_Var1)[5].pfn)((int)&(this->_base_tMenuItem).fFlags + (int)(*pa_Var1)[5].delta,0,0,selected);
  return;
}



/* ---- tMenuItemSlidingMenu::UpdatefOpenHeight  [FEMENUOPTIONS.CPP:711-769] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::UpdatefOpenHeight(bool selected)

{
  int iVar1;
  short sVar2;
  
  this->fClosing = 0;
  if (this->fOpenHeight == 0) {
    this->fSlideOffset = this->fHeight + (this->fHeight >> 1);
  }
  if ((this->nextMenu != this->currMenu) && (iVar1 = this->fOpenHeight + -4, 0 < this->fOpenHeight))
  {
    if (iVar1 < 0) {
      iVar1 = 0;
    }
    this->fOpenHeight = (short)iVar1;
    this->fClosing = 1;
    goto UpdfOpenH_currMenuCheck;
  }
  if (this->nextMenu == (tInsideBoxMenu *)0x0) {
    iVar1 = (int)this->fFadeVal;
    if (0x7f < iVar1) goto feo_fadeCheck;
    if (this->fInTransition != 0) goto UpdfOpenH_currMenuCheck;
  }
  else {
    iVar1 = (int)this->fFadeVal;
feo_fadeCheck:
    if (((0 < iVar1) && (this->currMenu == (tInsideBoxMenu *)0x0)) &&
       (this->nextMenu != (tInsideBoxMenu *)0x0)) {
      iVar1 = iVar1 + -0x28;
      if (this->fInTransition == 0) {
        if (iVar1 < 0) {
          iVar1 = 0;
        }
        this->fFadeVal = (short)iVar1;
      }
      if (this->fTransitioningOut == 0) {
        this->currMenu = this->nextMenu;
      }
      goto UpdfOpenH_currMenuCheck;
    }
    this->currMenu = this->nextMenu;
    if ((this->fTransitioningOut != 0) || (this->fInTransition != 0)) goto UpdfOpenH_currMenuCheck;
    if (this->nextMenu != (tInsideBoxMenu *)0x0) {
      iVar1 = this->fFadeVal + -0x28;
      if (iVar1 < 0) {
        iVar1 = 0;
      }
      this->fFadeVal = (short)iVar1;
      goto UpdfOpenH_currMenuCheck;
    }
    iVar1 = (int)this->fFadeVal;
  }
  sVar2 = (short)(iVar1 + 0x28);
  if (0x80 < iVar1 + 0x28) {
    sVar2 = 0x80;
  }
  this->fFadeVal = sVar2;
UpdfOpenH_currMenuCheck:
  if (this->currMenu != (tInsideBoxMenu *)0x0) {
    if (selected != 0) {
      if (this->fClosing == 0) {
        sVar2 = this->fHeight;
        iVar1 = this->fOpenHeight + 4;
        if ((int)this->fOpenHeight < (int)sVar2) {
          if (iVar1 < sVar2) {
            sVar2 = (short)iVar1;
          }
          this->fOpenHeight = sVar2;
        }
        else {
          iVar1 = this->fSlideOffset + -6;
          if (iVar1 < 0) {
            iVar1 = 0;
          }
          this->fSlideOffset = (short)iVar1;
        }
      }
      if (selected != 0) {
        return;
      }
    }
    iVar1 = this->fOpenHeight + -4;
    if (0 < this->fOpenHeight) {
      if (iVar1 < 0) {
        iVar1 = 0;
      }
      this->fOpenHeight = (short)iVar1;
    }
  }
  return;
}



/* ---- tMenuItemSlidingMenu::Draw  [FEMENUOPTIONS.CPP:777-883] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::Draw(int offx,int offy,bool selected)

{
  short sVar1;
  u_short uVar2;
  bool fPlayList;
  tTexture_ShapeInfo *shape;
  tTexture_ShapeInfo *ptVar6;
  int vtable_ptr;
  int ColText;
  int boxHeight;
  int x;
  int topShapeY;
  int y;
  int ptVar8;
  int tstr10;
  int iVar7;
  int iVar8;
  int sMenuText;
  int pkt_addr24;
  int ti1;
  int tu1;
  int boxWidth_d;
  int drawX;
  tInsideBoxMenu *index;
  int pa_Var3;
  int rowSpacing;
  int hh;
  int itemColor;
  tTexture_ShapeInfo *shapebottom;
  int xx;
  int yy;
  tTexture_ShapeInfo *shapetop;
  int ww;
  RECT full;
  RECT temp;
  tDrawShapeExtended drawFlags;
  int width;
  int gray;
  DRAWENV *drenv;
  u_char bVar1;
  int ptVar3;
  int ptVar4;
  u_char *cur_pkt;
  u_char *daprim;
  
  vtable_ptr = (int)(this->_base_tMenuItem)._vf;
  (**(int (**)(...))(vtable_ptr + 0x5c))
            ((int)&(this->_base_tMenuItem).fFlags + (int)*(short *)(vtable_ptr + 0x58),
             selected);
  ColText = CalcTextFadeSelToHi(textType_Options,(this->_base_tMenuItem).fSelFade,this->fFadeVal);
  boxHeight = TextSys_WordX((this->_base_tMenuItem).fTextDescription);
  x = boxHeight + offx;
  topShapeY = TextSys_WordY((this->_base_tMenuItem).fTextDescription);
  shape = gHelpShapes;
  fHelpText = -1;
  y = topShapeY + offy;
  fPlayList = (tInsideBoxSongMenu *)this->currMenu == &menuDefs->menuPlayListMenu;
  if ((this->fFadeVal != 0x80) && (fPlayList)) {
    DrawLeftFlare(y,(int)(this->_base_tMenuItem).fSelFade,(int)this->fFadeVal,
               flareextra);
  }
  if ((this->currMenu != (tInsideBoxMenu *)0x0) || (ptVar8 = 0, fPlayList)) {
    drawFlags.tint[0] = CalcFadeVal(0,0xbebe,(int)(this->_base_tMenuItem).fSelFade,(int)this->fFadeVal);
    DrawShapeExtended(0x39,0x18,((x + (fPlayList ? 0xdc : (int)this->fWidth)) - (int)shape[0x1e].width) - 0xa,(fPlayList ? y + -3 : y + -2),0,1,&drawFlags);
    DrawShapeExtended(0x3a,0x18,((x + (fPlayList ? 0xdc : (int)this->fWidth)) - (int)shape[0x1e].width) - 0xa,(fPlayList ? y + 3 : y + 4),0,1,&drawFlags);
    ptVar8 = (int)this->currMenu;
  }
  if (ptVar8 != 0) {
    uVar2 = this->fOpenHeight;
    sVar1 = this->fWidth;
    ww = (int)sVar1;
    xx = x + this->fDiffX;
    hh = (u_int)uVar2 << 0x10;
    yy = y + this->fDiffY;
    drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
    daprim = Render_gPacketPtr;
    cur_pkt = Render_gPalettePtr;
    full.x = 0;
    full.y = *(short *)((char *)drenv + 2);
    full.h = (short)screenheight;
    full.w = 0x200;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)cur_pkt = *(u_int *)cur_pkt & 0xff000000 | pkt_addr24;
    SetDrawArea((DR_AREA *)daprim,&full);
    width = hh >> 0x11;
    gray = 0x505050;
    SubtractiveBox(xx,yy,ww,width,gray,gray,0,0);
    SubtractiveBox(xx,yy + width,ww,width,0,0,gray,gray);
    ptVar6 = gHelpShapes;
    shapetop = ptVar6 + 0x1f;
    shapebottom = ptVar6 + 0x20;
    index = this->currMenu;
    pa_Var3 = (int)(index->_base_tMenu)._vf;
    (**(int (**)(...))(pa_Var3 + 0x5c))
              ((int)(index->_base_tMenu).fItemList + *(short *)(pa_Var3 + 0x58) + -0x10,
               xx * 0x10000 >> 0x10,yy * 0x10000 >> 0x10,ww,
               (int)((u_int)(u_short)this->fSlideOffset << 0x11) >> 0x10,(int)this->fHeight);
    itemColor = hh >> 0x10;
    if ((this->fFillback != 0) && (shapetop->height < itemColor)) {
      DrawShapeExtended(0x1f,0xc,xx,yy,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x1f,8,(xx + ww) - (int)shapetop->width,yy,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x20,0xc,xx,(yy + itemColor) - (int)shapebottom->height,0,0,(tDrawShapeExtended *)0x0);
      DrawShapeExtended(0x20,8,(xx + ww) - (int)shapebottom->width,(yy + itemColor) - (int)shapebottom->height,0,0,(tDrawShapeExtended *)0x0);
    }
    PSXDrawSquare(0,xx + shapetop->width + 5,yy,
               ((ww - shapetop->width) - (int)shapebottom->width) + -10,itemColor);
    ti1 = (int)shapetop->height;
    if (ti1 + shapebottom->height < itemColor) {
      PSXDrawSquare(0,xx,yy + ti1,ww,(itemColor - ti1) - (int)shapebottom->height);
    }
    daprim = Render_gPacketPtr;
    cur_pkt = Render_gPalettePtr;
    temp.x = (short)xx;
    ti1 = -0x1000000;
    temp.y = *(short *)((char *)drenv + 2) + (short)yy;
    *(u_int *)Render_gPacketPtr =
         *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
    tu1 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *(u_int *)cur_pkt = *(u_int *)cur_pkt & 0xff000000 | tu1;
    temp.w = sVar1;
    temp.h = uVar2;
    SetDrawArea((DR_AREA *)daprim,&temp);
    if (fHelpText != -1) {
      tstr10 = (int)TextSys_Word(fHelpText);
      iVar7 = TextSys_WordX(fHelpText);
      iVar8 = TextSys_WordY(fHelpText);
      FETextRender_FullTextRGB((char *)tstr10,(short)iVar7,(short)iVar8,PulsateYellow,'\0',2);
    }
    sMenuText = (int)TextSys_Word((this->_base_tMenuItem).fTextDescription);
    FETextRender_FullTextRGB((char *)sMenuText,(short)x,(short)y,ColText,'\0',(u_short)fPlayList);
    DrawShapeExtended(0x1e,8,(x + (fPlayList ? 0xdc : (int)this->fWidth)) - (int)shape[0x1e].width,y + -2,(int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
    if (this->fFillback != 0) {
      PSXDrawSquare(0,x,y + -2,(int)this->fWidth - (int)shape[0x1e].width,
                 (int)shape[0x1e].height);
    }
  }
  return;
}



/* ---- tMenuItemSlidingMenu::ProcessInput  [FEMENUOPTIONS.CPP:890-900] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  tInsideBoxMenu *ptVar2;
  
  if ((this->fOpenHeight == this->fHeight) &&
     (ptVar2 = this->currMenu, ptVar2 != (tInsideBoxMenu *)0x0)) {
    pa_Var1 = (ptVar2->_base_tMenu)._vf;
    (*(*pa_Var1)[3].pfn)((int)ptVar2 + (*pa_Var1)[3].delta);
  }
  if (keyval == kInput_KeyType_Down) {
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  this->_base_tMenuItem.ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuItemSlidingMenu::SetMenu  [FEMENUOPTIONS.CPP:904-918] SLD-VERIFIED ---- */

void tMenuItemSlidingMenu::SetMenu(bool bothmenus,tInsideBoxMenu *menu)

{
  
  this->nextMenu = menu;
  if (bothmenus != 0) {
    this->currMenu = menu;
  }
  if (this->nextMenu == (tInsideBoxMenu *)0x0) {
    (this->_base_tMenuItem).fFlags = (this->_base_tMenuItem).fFlags | 1;
    return;
  }
  (this->_base_tMenuItem).fFlags = (this->_base_tMenuItem).fFlags & 0xfffffffe;
  return;
}



/* ---- tMenuItemSlidingActivated::UpdatefOpenHeight  [FEMENUOPTIONS.CPP:925-931] SLD-VERIFIED ---- */

int tMenuItemSlidingActivated::UpdatefOpenHeight(bool arg1)

{
  short sVar1;
  int iVar2;
  u_int uVar3;
  int iVar4;
  
  if (this->fActive == 0) {
    sVar1 = (this->_base_tMenuItemSlidingMenu).fSlideOffset + 3;
  }
  else {
    sVar1 = (this->_base_tMenuItemSlidingMenu).fSlideOffset + -3;
  }
  (this->_base_tMenuItemSlidingMenu).fSlideOffset = sVar1;
  iVar4 = (int)(this->_base_tMenuItemSlidingMenu).fSlideOffset;
  iVar2 = (u_int)(u_short)(this->_base_tMenuItemSlidingMenu).fHeight << 0x10;
  iVar2 = (iVar2 >> 0x10) + (iVar2 >> 0x11);
  uVar3 = (u_int)(iVar4 < iVar2);
  if (uVar3 != 0) {
    iVar2 = iVar4;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  (this->_base_tMenuItemSlidingMenu).fSlideOffset = (short)iVar2;
  return uVar3;
}



/* ---- tMenuItemSlidingActivated::TransitionOff  [FEMENUOPTIONS.CPP:937-944] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::TransitionOff()

{
  (this->_base_tMenuItemSlidingMenu).fFadeDir = 0;
  (this->_base_tMenuItemSlidingMenu).fTransitioningOut = 1;
  if ((this->_base_tMenuItemSlidingMenu).currMenu != (tInsideBoxMenu *)0x0) {
    (this->_base_tMenuItemSlidingMenu).fInTransition = 1;
    (this->_base_tMenuItemSlidingMenu).fFadeDir = 0x1e;
    (this->_base_tMenuItemSlidingMenu).fFadeVal = 0;
  }
  return;
}



/* ---- tMenuItemSlidingActivated::TransitionOn  [FEMENUOPTIONS.CPP:949-960] SLD-FLAG:NONMONO ---- */

void tMenuItemSlidingActivated::TransitionOn()

{
  short sVar1;

  sVar1 = (this->_base_tMenuItemSlidingMenu).fHeight;
  (this->_base_tMenuItemSlidingMenu).fFadeDir = -0x1e;
  (this->_base_tMenuItemSlidingMenu).fInTransition = 1;
  this->fActive = 0;
  (this->_base_tMenuItemSlidingMenu).fTransitioningOut = 0;
  (this->_base_tMenuItemSlidingMenu).fFadeVal = 0x80;
  (this->_base_tMenuItemSlidingMenu).fOpenHeight = sVar1;
  (this->_base_tMenuItemSlidingMenu).fSlideOffset = sVar1 + (sVar1 >> 1);
  return;
}



/* ---- tMenuItemSlidingActivated::TransitionIsFinished  [FEMENUOPTIONS.CPP:964-979] SLD-VERIFIED ---- */

void * tMenuItemSlidingActivated::TransitionIsFinished()

{
  short sVar1;
  
  if (((this->_base_tMenuItemSlidingMenu).currMenu == (tInsideBoxMenu *)0x0) ||
     ((this->_base_tMenuItemSlidingMenu).nextMenu == (tInsideBoxMenu *)0x0)) {
    (this->_base_tMenuItemSlidingMenu).fFadeDir = 0;
  }
  else {
    sVar1 = (this->_base_tMenuItemSlidingMenu).fFadeDir;
    if (sVar1 != 0) {
      if (sVar1 < 0) {
        if ((this->_base_tMenuItemSlidingMenu).fFadeVal < 1) goto SlideActvTrans_resetTrans;
        sVar1 = (this->_base_tMenuItemSlidingMenu).fFadeDir;
      }
      if ((sVar1 < 1) || ((this->_base_tMenuItemSlidingMenu).fFadeVal < 0x80)) {
        (this->_base_tMenuItemSlidingMenu).fInTransition = 1;
        goto SlideActvTrans_returnInv;
      }
    }
  }
SlideActvTrans_resetTrans:
  (this->_base_tMenuItemSlidingMenu).fInTransition = 0;
SlideActvTrans_returnInv:
  return (void *)((this->_base_tMenuItemSlidingMenu).fInTransition ^ 1);
}



/* ---- tMenuItemSlidingActivated::UpdateTransition  [FEMENUOPTIONS.CPP:983-986] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)(this->_base_tMenuItemSlidingMenu).fFadeVal + (int)(this->_base_tMenuItemSlidingMenu).fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = (this->_base_tMenuItemSlidingMenu)._base_tMenuItem._vf;
  (this->_base_tMenuItemSlidingMenu).fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)
            ((int)&(this->_base_tMenuItemSlidingMenu)._base_tMenuItem.fFlags + (int)(*pa_Var1)[9].delta);
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tMenuItemSlidingActivated::ProcessInput  [FEMENUOPTIONS.CPP:990-1044] SLD-VERIFIED ---- */

void tMenuItemSlidingActivated::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  AudioMus_tSongList *pAVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [11];
  tInsideBoxMenu *ptVar4;
  
  if (keyval == kInput_KeyType_Cross) {
    if (this->fActive == 0) {
      AudioCmn_PlayFESFX(0);
      this->fActive = 1;
      keyval = kInput_KeyType_AlreadyProcessed;
      AudioMus_StopSong(0x14);
      AudioMus_SysCleanUp();
      AudioMus_SysStartUp(0xc000,0x18000,"ymus");
      AudioMus_PlaySong("game*");
      pAVar1 = AudioMus_GetSongList("*",0);
      screenAudio->songlist = pAVar1;
    }
  }
  else if ((keyval == kInput_KeyType_Triangle) && (this->fActive != 0)) {
    AudioCmn_PlayFESFX(1);
    this->fActive = 0;
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioMus_StopSong(0x14);
    if (screenAudio->songlist != (AudioMus_tSongList *)0x0) {
      purgememadr(screenAudio->songlist);
    }
    screenAudio->songlist = (AudioMus_tSongList *)0x0;
    AudioMus_SysCleanUp();
    AudioMus_SysStartUp(0xd800,0x18000,"amus");
    AudioMus_PlaySong("zmenu*");
  }
  if ((this->_base_tMenuItemSlidingMenu).fSlideOffset == 0) {
    iVar2 = this->fActive;
    if (iVar2 == 0) goto SlideActivProc_callBaseProcess;
    ptVar4 = (this->_base_tMenuItemSlidingMenu).currMenu;
    if (ptVar4 != (tInsideBoxMenu *)0x0) {
      pa_Var3 = (ptVar4->_base_tMenu)._vf;
      (*(*pa_Var3)[3].pfn)
                ((int)(ptVar4->_base_tMenu).fItemList + (*pa_Var3)[3].delta + -0x10,fromPlayer,keyval,
                 command);
      goto SlideActivProc_getActive;
    }
  }
  else {
SlideActivProc_getActive:
    iVar2 = this->fActive;
  }
  if ((iVar2 != 0) && ((keyval == kInput_KeyType_Up || (keyval == kInput_KeyType_Down)))) {
    keyval = kInput_KeyType_AlreadyProcessed;
  }
SlideActivProc_callBaseProcess:
  ((tMenuItem *)this)->ProcessInput(fromPlayer,keyval,command);
  return;
}



/* ---- tMenuItemLeftRightFade::MyLeftRightDraw  [FEMENUOPTIONS.CPP:1063-1075] SLD-VERIFIED ---- */

void tMenuItemLeftRightFade::MyLeftRightDraw(int x,int y)

{
  int ColText;
  char *sMenuText;
  tDrawShapeExtended aCol;
  
  aCol.tint[0] = CalcFadeVal(0xc83c1e,0xbebe,
                            (int)(this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,(int)this->fFadeVal);
  DrawLeftFlare(y,(int)(this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
             (int)this->fFadeVal,this->flareextra);
  ColText = CalcTextFadeSelToHi(textType_Options,
                   (this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
                   this->fFadeVal);
  sMenuText = TextSys_Word((this->_base_tMenuItemLeftRightChoice)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,ColText,'\0',1);
  DrawShapeExtended(0x2e,0x18,x + 0x1a,y + 1,0,0,&aCol);
  DrawShapeExtended(0x2f,0x18,x + 0xc8,y + 1,0,0,&aCol);
  return;
}



/* ---- tMenuItemDisplayLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1085-1102] SLD-VERIFIED ---- */

int tMenuItemDisplayLeftRightChoice::Draw(int offx,int offy,bool selected)

{
  short sVar1;
  int iVar2;
  int iVar3;
  int ColText;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var4) [6];
  tListIterator *ptVar5;
  int iVar6;
  
  iVar2 = 0x80;
  if ((this->_base_tMenuItemLeftRightFade).fFadeVal != 0x80) {
    iVar3 = TextSys_WordX((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    iVar2 = TextSys_WordY((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    ColText = CalcTextFadeSelToHi(textType_Options,
                     (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fSelFade,(this->_base_tMenuItemLeftRightFade).fFadeVal);
    iVar6 = (iVar2 + offy) * 0x10000;
    this->_base_tMenuItemLeftRightFade.MyLeftRightDraw((iVar3 + offx) * 0x10000 >> 0x10,iVar6 >> 0x10);
    ptVar5 = (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice.fData;
    pa_Var4 = ptVar5->_vf;
    sVar1 = (*(*pa_Var4)[3].pfn)
                      ((char *)ptVar5 + (int)(*pa_Var4)[3].delta,gMenu_SubMenuPlayer);
    sMenuText = TextSys_Word((int)sVar1);
    iVar2 = 2;
    FETextRender_FullTextRGB(sMenuText,(short)((u_int)((iVar3 + offx + 0x73) * 0x10000) >> 0x10),
               (short)((u_int)iVar6 >> 0x10),ColText,'\0',2);
  }
  return iVar2;
}



/* ---- tMenuItemOnOffLeftRightChoice::TransitionOn  [FEMENUOPTIONS.CPP:1105-1107] SLD-VERIFIED ---- */

void tMenuItemOnOffLeftRightChoice::TransitionOn()

{
  u_int cVar1;
  u_int bSet;
  tListIterator *ptVar2;
  __vtbl_ptr_type (*pa_Var3) [6];

  ptVar2 = (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice.fData;
  pa_Var3 = ptVar2->_vf;
  cVar1 = (*(u_char (*)(char *, int))(*pa_Var3)[2].pfn)((char *)ptVar2 + (int)(*pa_Var3)[2].delta,0xffffffff);
  bSet = (0 < cVar1);
  this->fOnFade = (u_short)(bSet << 7);
  this->_base_tMenuItemLeftRightFade.TransitionOn();
  return;
}



/* ---- tMenuItemOnOffLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1111-1140] SLD-VERIFIED ---- */

int tMenuItemOnOffLeftRightChoice::Draw(int offx,int offy,bool selected)

{
  char cVar1;
  char *pcVar2;
  __vtbl_ptr_type (*pa_Var3) [6];
  int iVar4;
  int iVar5;
  tListIterator *ptVar6;
  short sVar7;
  int ColTextOn;
  int ColTextOff;
  
  pcVar2 = (char *)0x80;
  if ((this->_base_tMenuItemLeftRightFade).fFadeVal != 0x80) {
    ptVar6 = (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice.fData;
    pa_Var3 = ptVar6->_vf;
    cVar1 = (*(*pa_Var3)[2].pfn)
                      ((char *)ptVar6 + (int)(*pa_Var3)[2].delta,0xffffffff,offy,
                       selected);
    if (cVar1 == '\0') {
      sVar7 = this->fOnFade + -0x20;
    }
    else {
      sVar7 = this->fOnFade + 0x20;
    }
    this->fOnFade = sVar7;
    if (0x80 < this->fOnFade) {
      this->fOnFade = 0x80;
    }
    if (this->fOnFade < 0) {
      this->fOnFade = 0;
    }
    iVar4 = TextSys_WordX((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    iVar4 = iVar4 + offx;
    iVar5 = TextSys_WordY((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    CalcOnOffFade(textType_Options,this->fOnFade,
               (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fSelFade,(this->_base_tMenuItemLeftRightFade).fFadeVal,&ColTextOn,&ColTextOff);
    iVar5 = (iVar5 + offy) * 0x10000;
    this->_base_tMenuItemLeftRightFade.MyLeftRightDraw(iVar4 * 0x10000 >> 0x10,iVar5 >> 0x10);
    pcVar2 = TextSys_Word(0x66);
    sVar7 = (short)((u_int)iVar5 >> 0x10);
    FETextRender_FullTextRGB(pcVar2,(short)((u_int)((iVar4 + 0x37) * 0x10000) >> 0x10),sVar7,ColTextOn,'\0',0);
    pcVar2 = TextSys_Word(0x67);
    FETextRender_FullTextRGB(pcVar2,(short)((u_int)((iVar4 + 0x9e) * 0x10000) >> 0x10),sVar7,ColTextOff,'\0',0);
  }
  return (int)pcVar2;
}



/* ---- tMenuItemLeftRightAudioSlider::ctor  [FEMENUOPTIONS.CPP:1152-1156] SLD-VERIFIED ---- */
tMenuItemLeftRightAudioSlider::tMenuItemLeftRightAudioSlider(u_int textDescription,tListIterator *dataPtr,
          int AudioArt)
  : _base_tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tMenuItemLeftRightAudioSlider_vtable;
  this->fAudioArt = (short)AudioArt;
  this->flareextra = 0;
  (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::dtor  [FEMENUOPTIONS.CPP:1160-1160] SLD-VERIFIED ---- */

tMenuItemLeftRightAudioSlider::~tMenuItemLeftRightAudioSlider()

{
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tMenuItemLeftRightAudioSlider_vtable;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::Draw  [FEMENUOPTIONS.CPP:1167-1201] SLD-VERIFIED ---- */

int tMenuItemLeftRightAudioSlider::Draw(int ox,int oy,bool selected)

{
  u_short uVar1;
  int coltext;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var3) [6];
  tListIterator *ptVar4;
  u_int uVar5;
  int iVar6;
  tDrawShapeExtended tCol;
  
  coltext = TextSys_WordX((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  uVar5 = (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription;
  (this->_base_tMenuItemLeftRightSlider).fX = (short)coltext + (short)ox;
  coltext = TextSys_WordY(uVar5);
  uVar5 = (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription;
  (this->_base_tMenuItemLeftRightSlider).fY = (short)coltext + (short)oy;
  coltext = TextSys_WordFlags((int)(short)uVar5);
  iVar6 = kRGBVals[(u_char)textDefinitions[coltext][5]];
  coltext = TextSys_WordFlags((int)(short)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  coltext = kRGBVals[(u_char)textDefinitions[coltext][4]];
  DrawLeftFlare((int)(this->_base_tMenuItemLeftRightSlider).fY,
             (int)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
             (int)this->fFadeVal,this->flareextra);
  coltext = CalcFadeVal(coltext,iVar6,
                     (int)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
                     (int)this->fFadeVal);
  iVar6 = 0x80;
  if (this->fFadeVal != 0x80) {
    sMenuText = TextSys_Word((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    FETextRender_FullTextRGB(sMenuText,(this->_base_tMenuItemLeftRightSlider).fX,(this->_base_tMenuItemLeftRightSlider).fY,
               coltext,'\0',1);
    tCol.tint[0] = CalcFadeVal(0x551e00,0xbebe,
                              (int)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,(int)this->fFadeVal);
    if ((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade != 0) {
      DrawShapeExtended(this->fAudioArt + 1,0x10,0,0,0,0,&tCol);
    }
    ptVar4 = (this->_base_tMenuItemLeftRightSlider).fData;
    pa_Var3 = ptVar4->_vf;
    uVar1 = (*(*pa_Var3)[2].pfn)((char *)ptVar4 + (int)(*pa_Var3)[2].delta,0xffffffff)
    ;
    ptVar4 = (this->_base_tMenuItemLeftRightSlider).fData;
    iVar6 = (int)this->fFadeVal;
    DrawSlider(uVar1 & 0xff,(u_short)(u_char)ptVar4->fMinValue,(u_short)(u_char)ptVar4->fMaxValue,
               (this->_base_tMenuItemLeftRightSlider).fX + 0x14,(this->_base_tMenuItemLeftRightSlider).fY + 1,
               (this->_base_tMenuItemLeftRightSlider).fWidth,(this->_base_tMenuItemLeftRightSlider).fHeight,4,4,
               false,0,(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
               this->fFadeVal);
  }
  return iVar6;
}



/* ---- tMenuItemLeftRightAudioSlider::Percentage  [FEMENUOPTIONS.CPP:1204-1209] SLD-VERIFIED ---- */

int tMenuItemLeftRightAudioSlider::Percentage()

{
  char cVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  u_int uVar3;
  int iVar4;
  tListIterator *ptVar5;
  int iVar6;
  int percent;
  
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  pa_Var2 = ptVar5->_vf;
  uVar3 = (*(*pa_Var2)[2].pfn)((char *)ptVar5 + (int)(*pa_Var2)[2].delta,0xffffffff);
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  iVar6 = ((uVar3 & 0xff) - (u_int)(u_char)ptVar5->fMinValue) * 100;
  iVar4 = (u_int)(u_char)ptVar5->fMaxValue - (u_int)(u_char)ptVar5->fMinValue;
  percent = iVar6 / iVar4;
  cVar1 = (*(*ptVar5->_vf)[2].pfn)
                    ((char *)ptVar5 + (int)(*ptVar5->_vf)[2].delta,0xffffffff);
  if ((cVar1 != '\0') && (percent < 100)) {
    percent = percent + 1;
  }
  return percent;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionOff  [FEMENUOPTIONS.CPP:1212-1214] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::TransitionOff()

{
  this->fFadeVal = 0;
  this->fFadeDir = 0x3c;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionOn  [FEMENUOPTIONS.CPP:1217-1220] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::TransitionOn()

{
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x3c;
  (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  return;
}



/* ---- tMenuItemLeftRightAudioSlider::TransitionIsFinished  [FEMENUOPTIONS.CPP:1223-1231] SLD-VERIFIED ---- */

void * tMenuItemLeftRightAudioSlider::TransitionIsFinished()

{
  this->fInTransition = 0;
  if ((this->fFadeDir < 0) && (0 < this->fFadeVal)) {
    this->fInTransition = 1;
  }
  if ((0 < this->fFadeDir) && (this->fFadeVal < 0x80)) {
    this->fInTransition = 1;
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tMenuItemLeftRightAudioSlider::UpdateTransition  [FEMENUOPTIONS.CPP:1234-1236] SLD-VERIFIED ---- */

void tMenuItemLeftRightAudioSlider::UpdateTransition(bool selected)

{
  int iVar1;
  
  iVar1 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar1) {
    iVar1 = 0x80;
  }
  if (iVar1 < 0) {
    iVar1 = 0;
  }
  this->fFadeVal = (short)iVar1;
  ((tMenuItem *)this)->UpdateTransition(selected);
  return;
}



/* ---- tInsideBoxSongMenu::ctor  [FEMENUOPTIONS.CPP:1247-1259] SLD-VERIFIED ---- */

tInsideBoxSongMenu::tInsideBoxSongMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,
              tMenu *optionsMenu,void (*OnButtonPress)(tMenuCommand&),short title,tMenuItem *firstItem,...)
  : _base_tInsideBoxMenu()
{
  tInsideBoxSongMenu *ptVar1;
  int j;
  
  *(tMenu *)this = tMenu(flags,screenHandler,nextMenu,optionsMenu,OnButtonPress,title);
  j = 0;
  *(void **)&((this->_base_tInsideBoxMenu)._base_tMenu._vf) = (void *)tInsideBoxSongMenu_vtable;
  ptVar1 = this;
  do {
    ptVar1->fSelFade[0] = 0;
    ptVar1->fOnOffFade[0] = 0;
    j = j + 1;
    ptVar1 = (tInsideBoxSongMenu *)((int)&(ptVar1->_base_tInsideBoxMenu)._base_tMenu.fFlags + 2);
  } while (j < 5);
  ((tMenu *)this)->tMenuConstructor(firstItem,(&firstItem + 1));
  (this->_base_tInsideBoxMenu).fMoving = 0;
  (this->_base_tInsideBoxMenu).fMovingDir = 0;
  return;
}



/* ---- tInsideBoxSongMenu::dtor  [FEMENUOPTIONS.CPP:1263-1263] SLD-VERIFIED ---- */

tInsideBoxSongMenu::~tInsideBoxSongMenu()

{
  *(void **)&((this->_base_tInsideBoxMenu)._base_tMenu._vf) = (void *)tInsideBoxSongMenu_vtable;
  return;
}



/* ---- tInsideBoxSongMenu::Draw  [FEMENUOPTIONS.CPP:1271-1314] SLD-VERIFIED ---- */

void tInsideBoxSongMenu::Draw(short x,short y,short w,short slideOffset,short maxheight)

{
  short sVar1;
  u_short uVar2;
  short sVar3;
  int iVar4;
  int iVar5;
  tInsideBoxSongMenu *ptVar6;
  __vtbl_ptr_type (*pa_Var7) [11];
  int song;
  int j;
  int drawY;
  
  if (screenAudio->songlist != (AudioMus_tSongList *)0x0) {
    j = 0;
    ptVar6 = this;
    do {
      if (j != 2) {
        iVar4 = ptVar6->fSelFade[0] + -8;
        if (iVar4 < 0) {
          iVar4 = 0;
        }
        ptVar6->fSelFade[0] = (short)iVar4;
      }
      j = j + 1;
      ptVar6 = (tInsideBoxSongMenu *)((int)&(ptVar6->_base_tInsideBoxMenu)._base_tMenu.fFlags + 2);
    } while (j < 5);
    j = this->fSelFade[2] + 8;
    if (0x80 < j) {
      j = 0x80;
    }
    sVar3 = (this->_base_tInsideBoxMenu).fMoving;
    sVar1 = (this->_base_tInsideBoxMenu).fMoving;
    this->fSelFade[2] = (short)j;
    if (sVar3 != 0) {
      uVar2 = sVar1 + (this->_base_tInsideBoxMenu).fMovingDir * 2;
      (this->_base_tInsideBoxMenu).fMoving = uVar2;
      if (((this->_base_tInsideBoxMenu).fMovingDir < 0) && ((int)((u_int)uVar2 << 0x10) < 0)) {
        (this->_base_tInsideBoxMenu).fMoving = 0;
      }
      if ((0 < (this->_base_tInsideBoxMenu).fMovingDir) && (0 < (this->_base_tInsideBoxMenu).fMoving)) {
        (this->_base_tInsideBoxMenu).fMoving = 0;
      }
    }
    j = 0;
    drawY = -0x28;
    ptVar6 = this;
    do {
      iVar5 = screenAudio->fSelectedSong + j;
      song = iVar5 + -2;
      if ((-1 < song) && (song < screenAudio->songlist->numsongs)) {
        if (*(int *)(frontEnd.checkPointDisplay + iVar5 * 4 + -3) == 0) {
          sVar3 = ptVar6->fOnOffFade[0] + -0x20;
        }
        else {
          sVar3 = ptVar6->fOnOffFade[0] + 0x20;
        }
        ptVar6->fOnOffFade[0] = sVar3;
        if (0x80 < ptVar6->fOnOffFade[0]) {
          ptVar6->fOnOffFade[0] = 0x80;
        }
        if (ptVar6->fOnOffFade[0] < 0) {
          ptVar6->fOnOffFade[0] = 0;
        }
        pa_Var7 = (this->_base_tInsideBoxMenu)._base_tMenu._vf;
        (*pa_Var7[1][1].pfn)
                  ((int)(this->_base_tInsideBoxMenu)._base_tMenu.fItemList + pa_Var7[1][1].delta + -0x10,
                   song * 0x10000 >> 0x10,(int)x,
                   (int)(((u_int)(u_short)slideOffset +
                         (u_int)(u_short)(this->_base_tInsideBoxMenu).fMoving +
                         (int)y + (maxheight + -0x15 >> 1) + drawY) * 0x10000) >> 0x10,(int)w,
                   (int)ptVar6->fOnOffFade[0],(int)ptVar6->fSelFade[0]);
      }
      drawY = drawY + 0x15;
      j = j + 1;
      ptVar6 = (tInsideBoxSongMenu *)((int)&(ptVar6->_base_tInsideBoxMenu)._base_tMenu.fFlags + 2);
    } while (j < 5);
  }
  return;
}



/* ---- tInsideBoxSongMenu::DrawOneSong  [FEMENUOPTIONS.CPP:1317-1340] SLD-VERIFIED ---- */

void tInsideBoxSongMenu::DrawOneSong(short songnum,short x,short y,short w,short fOnOffFade,
               short fSelFade)

{
  short sVar1;
  int Col;
  int ColText;
  char *pcVar3;
  u_short in_register_0000001a;
  int iVar4;
  int iVar5;
  int ColTextOn;
  int ColTextOff;
  
  sVar1 = w;
  w = (u_int)(u_short)w;
  iVar4 = (int)x;
  Col = CalcFadeVal(0x551e00,0x28);   /* H13: 2nd arg is the literal 0x28 (oracle 0x8001EC84 $a1=0x28), not x */
  CalcOnOffFade(textType_Options,fOnOffFade,fSelFade,0,&ColTextOn,&ColTextOff);
  ColText = CalcTextFadeSelToHi(textType_Options,fSelFade,0);
  iVar5 = (int)((u_int)(u_short)songnum << 0x10) >> 10;
  FETextRender_FullTextRGB(*(char **)((int)&screenAudio->songlist[1].currentsong + iVar5),
             (short)((u_int)((iVar4 + 3) * 0x10000) >> 0x10),y + 2,ColText,'\0',0);
  FETextRender_FullTextRGB(*(char **)((int)&screenAudio->songlist[2].numsongs + iVar5),
             (short)((u_int)((iVar4 + 2) * 0x10000) >> 0x10),y + 10,ColText,'\0',0);
  pcVar3 = TextSys_Word(0x66);
  FETextRender_FullTextRGB(pcVar3,(short)((iVar4 + w + -0x5a) * 0x10000 >> 0x10),y + 6,ColTextOn,'\0',2);
  pcVar3 = TextSys_Word(0x67);
  FETextRender_FullTextRGB(pcVar3,(short)((iVar4 + w + -0x1e) * 0x10000 >> 0x10),y + 6,ColTextOff,'\0',2);
  iVar4 = (int)x;
  iVar5 = (int)sVar1;
  ColText = (int)y;
  PSXDrawSquare(Col,iVar4 + iVar5 + -0x78,ColText,2,0x13);
  PSXDrawSquare(Col,iVar4 + iVar5 + -0x3c,ColText,2,0x13);
  PSXDrawSquare(Col,iVar4,ColText,iVar5,1);
  PSXDrawSquare(Col,iVar4,ColText + 0x13,iVar5,-1);
  return;
}



/* ---- tInsideBoxSongMenu::DebounceKeys  [FEMENUOPTIONS.CPP:1344-1345] SLD-VERIFIED ---- */

long tInsideBoxSongMenu::DebounceKeys()

{
  return 0x1e00;
}



/* ---- tInsideBoxSongMenu::ProcessInput  [FEMENUOPTIONS.CPP:1350-1408] SLD-VERIFIED ---- */

int tInsideBoxSongMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  short sVar1;
  tInputKeyType tVar2;
  tScreenAudio *ptVar3;
  int iVar4;
  int j;
  int iVar5;
  int iVar6;
  
  if (screenAudio->songlist == (AudioMus_tSongList *)0x0) {
    return 0;
  }
  if (keyval == kInput_KeyType_Left) {
    iVar4 = 5;
InBoxSong_playSfx:
    AudioCmn_PlayFESFX(iVar4);
  }
  else {
    iVar4 = 6;
    if (keyval == kInput_KeyType_Right) goto InBoxSong_playSfx;
  }
  tVar2 = keyval;
  if (tVar2 == kInput_KeyType_Down) {
    if ((screenAudio->songlist->numsongs + -1 <= (int)screenAudio->fSelectedSong) ||
       ((this->_base_tInsideBoxMenu).fMoving != 0)) goto InBoxSong_finishReturn;
    (this->_base_tInsideBoxMenu).fMoving = 0x15;
    (this->_base_tInsideBoxMenu).fMovingDir = -4;
    iVar5 = 0;
    j = 0;
    do {
      iVar6 = j + 1;
      *(short *)((int)this->fOnOffFade + iVar5) = this->fOnOffFade[j + 1];
      *(short *)((int)this->fSelFade + iVar5) = this->fSelFade[j + 1];
      ptVar3 = screenAudio;
      iVar5 = iVar6 * 2;
      j = iVar6;
    } while (iVar6 < 4);
    this->fOnOffFade[4] = 0;
    this->fSelFade[4] = 0;
    iVar4 = 4;
    sVar1 = ptVar3->fSelectedSong + 1;
  }
  else {
    if (0x400 < (int)tVar2) {
      if ((tVar2 != kInput_KeyType_Left) && (tVar2 != kInput_KeyType_Right)) {
        return 0x1000;
      }
      frontEnd.FEPlayList[screenAudio->fSelectedSong] =
           (u_int)(frontEnd.FEPlayList[screenAudio->fSelectedSong] == 0);
      goto InBoxSong_finishReturn;
    }
    if (tVar2 != kInput_KeyType_Up) {
      return -0x7ffb0000;
    }
    if ((screenAudio->fSelectedSong < 1) || ((this->_base_tInsideBoxMenu).fMoving != 0))
    goto InBoxSong_finishReturn;
    (this->_base_tInsideBoxMenu).fMoving = -0x15;
    (this->_base_tInsideBoxMenu).fMovingDir = 4;
    j = 4;
    do {
      iVar5 = j + -1;
      this->fOnOffFade[j] = this->fOnOffFade[j + -1];
      this->fSelFade[j] = this->fOnOffFade[j + 4];
      ptVar3 = screenAudio;
      j = iVar5;
    } while (0 < iVar5);
    this->fOnOffFade[0] = 0;
    this->fSelFade[0] = 0;
    iVar4 = 3;
    sVar1 = ptVar3->fSelectedSong + -1;
  }
  ptVar3->fSelectedSong = sVar1;
  AudioCmn_PlayFESFX(iVar4);
InBoxSong_finishReturn:
  keyval = kInput_KeyType_AlreadyProcessed;
  return 1;
}



/* ---- tMenuItemControllerLeftRightChoice::Draw  [FEMENUOPTIONS.CPP:1423-1459] SLD-VERIFIED ---- */

int tMenuItemControllerLeftRightChoice::Draw(int ox,int oy,bool selected)

{
  tTexture_ShapeInfo *shape;
  short sVar2;
  int iVar3;
  int iVar4;
  int Col;
  int ColText;
  char *pcVar6;
  __vtbl_ptr_type (*pa_Var7) [6];
  short y;
  tListIterator *ptVar8;
  tDrawShapeExtended tCol;
  tDrawShapeExtended drawFlags;
  
  iVar3 = TextSys_WordX((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  iVar3 = iVar3 + ox;
  iVar4 = TextSys_WordY((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  shape = gHelpShapes;
  Col = CalcFadeVal(0xc83c1e,0xbebe,
                     (int)(this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
                     (int)(this->_base_tMenuItemLeftRightFade).fFadeVal);
  ColText = CalcTextFadeSelToHi(textType_Options,
                   (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fSelFade,(this->_base_tMenuItemLeftRightFade).fFadeVal);
  if ((this->_base_tMenuItemLeftRightFade).fFadeVal != 0x80) {
    tCol.tint[0] = Col;
    pcVar6 = TextSys_Word((this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    y = (short)((u_int)((iVar4 + oy) * 0x10000) >> 0x10);
    FETextRender_FullTextRGB(pcVar6,(short)((u_int)(iVar3 * 0x10000) >> 0x10),y,ColText,'\0',0);
    ptVar8 = (this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice.fData;
    pa_Var7 = ptVar8->_vf;
    sVar2 = (*(*pa_Var7)[3].pfn)
                      ((char *)ptVar8 + (int)(*pa_Var7)[3].delta,gMenu_SubMenuPlayer);
    pcVar6 = TextSys_Word((int)sVar2);
    FETextRender_FullTextRGB(pcVar6,(short)((u_int)((iVar3 + 0x97) * 0x10000) >> 0x10),y,ColText,'\0',2);
  }
  drawFlags.tint[0] = CalcFadeVal(0,0xbebe,(int)(this->_base_tMenuItemLeftRightFade)._base_tMenuItemLeftRightChoice._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
                            (int)(this->_base_tMenuItemLeftRightFade).fFadeVal);
  DrawShapeExtended(0xa,0x18,iVar3 + 0x83,(int)y,0,1,&drawFlags);
  DrawShapeExtended(0xb,0x18,iVar3 + 0xa1,(int)y,0,1,&drawFlags);
  DrawShapeExtended(0x1e,8,iVar3 - ((int)shape[0x1e].width - 0xb0),(int)y - 3,(int)(this->_base_tMenuItemLeftRightFade).fFadeVal,0,(tDrawShapeExtended *)0x0);
  Col = (int)shape[0x1e].height;
  PSXDrawSquare(0,iVar3 * 0x10000 >> 0x10,((iVar4 + oy) * 0x10000 >> 0x10) + -3,
             0xb0 - shape[0x1e].width,Col);
  return Col;
}



/* ---- tInsideBoxLeftRightSlider::ctor  [FEMENUOPTIONS.CPP:1465-1469] SLD-VERIFIED ---- */
tInsideBoxLeftRightSlider::tInsideBoxLeftRightSlider(u_int textDescription,tListIterator *dataPtr)
  : _base_tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tInsideBoxLeftRightSlider_vtable;
  (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  (this->_base_tMenuItemLeftRightSlider).fHeight = 5;
  return;
}



/* ---- tInsideBoxLeftRightSlider::dtor  [FEMENUOPTIONS.CPP:1473-1473] SLD-VERIFIED ---- */

tInsideBoxLeftRightSlider::~tInsideBoxLeftRightSlider()

{
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tInsideBoxLeftRightSlider_vtable;
  return;
}



/* ---- tInsideBoxLeftRightSlider::Draw  [FEMENUOPTIONS.CPP:1480-1493] SLD-VERIFIED ---- */

int tInsideBoxLeftRightSlider::Draw(int x,int y,int w,bool selected)

{
  short fSelFade;
  u_short uVar1;
  int col;
  int coltext;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var3) [6];
  tListIterator *ptVar4;
  
  (this->_base_tMenuItemLeftRightSlider).fX = (short)x;
  (this->_base_tMenuItemLeftRightSlider).fY = (short)y;
  col = CalcFadeVal(0x551e00,0xc83c1e,
                     (int)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade);
  coltext = CalcTextFadeUnselToSel(textType_Options,
                      (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,0);
  PSXDrawSquare(col,(int)(this->_base_tMenuItemLeftRightSlider).fX,(int)(this->_base_tMenuItemLeftRightSlider).fY
             ,w,1);
  PSXDrawSquare(col,(int)(this->_base_tMenuItemLeftRightSlider).fX,(this->_base_tMenuItemLeftRightSlider).fY + 8,
             w,1);
  sMenuText = TextSys_Word((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  FETextRender_FullTextRGB(sMenuText,(this->_base_tMenuItemLeftRightSlider).fX + 4,
             (this->_base_tMenuItemLeftRightSlider).fY + 10,coltext,'\0',0);
  ptVar4 = (this->_base_tMenuItemLeftRightSlider).fData;
  pa_Var3 = ptVar4->_vf;
  uVar1 = (*(*pa_Var3)[2].pfn)((char *)ptVar4 + (int)(*pa_Var3)[2].delta,0xffffffff);
  ptVar4 = (this->_base_tMenuItemLeftRightSlider).fData;
  fSelFade = (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade;
  col = (int)fSelFade;
  DrawSlider(uVar1 & 0xff,(u_short)(u_char)ptVar4->fMinValue,(u_short)(u_char)ptVar4->fMaxValue,
             (this->_base_tMenuItemLeftRightSlider).fX + 4,(this->_base_tMenuItemLeftRightSlider).fY + 2,
             (short)((u_int)((w + -8) * 0x10000) >> 0x10),(this->_base_tMenuItemLeftRightSlider).fHeight,4,
             4,false,0,fSelFade,0);
  return col;
}



/* ---- tInsideBoxTwoWaySlider::ctor  [FEMENUOPTIONS.CPP:1497-1504] SLD-VERIFIED ---- */
tInsideBoxTwoWaySlider::tInsideBoxTwoWaySlider(u_int textDescription,tListIterator *dataPtr,int type)
  : _base_tMenuItemLeftRightSlider(textDescription,dataPtr)
{
  
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tInsideBoxTwoWaySlider_vtable;
  this->fType = (short)type;
  (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade = 0;
  (this->_base_tMenuItemLeftRightSlider).fHeight = 5;
  this->fActive = 0;
  return;
}



/* ---- tInsideBoxTwoWaySlider::dtor  [FEMENUOPTIONS.CPP:1508-1508] SLD-VERIFIED ---- */

tInsideBoxTwoWaySlider::~tInsideBoxTwoWaySlider()

{
  *(void **)&((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem._vf) = (void *)tInsideBoxTwoWaySlider_vtable;
  return;
}



/* ---- tInsideBoxTwoWaySlider::ProcessInput  [FEMENUOPTIONS.CPP:1512-1536] SLD-VERIFIED ---- */

int tInsideBoxTwoWaySlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  tInputKeyType tVar1;
  
  tVar1 = keyval;
  if (tVar1 == kInput_KeyType_Cross) {
    AudioCmn_PlayFESFX(0);
    this->fActive = 1;
    keyval = kInput_KeyType_AlreadyProcessed;
    tVar1 = keyval;
  }
  if (tVar1 == kInput_KeyType_R1) {
    tVar1 = kInput_KeyType_R1;
    if (this->fActive != 0) {
      AudioCmn_PlayFESFX(1);
      this->fActive = 0;
      keyval = kInput_KeyType_AlreadyProcessed;
      goto IBTwoWaySlide_activeCheck;
    }
  }
  else {
IBTwoWaySlide_activeCheck:
    if (this->fActive != 0) goto IBTwoWaySlide_processed;
    tVar1 = keyval;
  }
  if ((tVar1 != kInput_KeyType_Left) && (tVar1 != kInput_KeyType_Right)) {
    return 0x1000;
  }
IBTwoWaySlide_processed:
  keyval = kInput_KeyType_AlreadyProcessed;
  return 1;
}



/* ---- tInsideBoxTwoWaySlider::Draw  [FEMENUOPTIONS.CPP:1543-1573] SLD-VERIFIED ---- */

int tInsideBoxTwoWaySlider::Draw(int x,int y,int w,bool selected)

{
  short sVar1;
  u_short uVar2;
  int col2;
  int col;
  int coltext;
  char *sMenuText;
  __vtbl_ptr_type (*pa_Var4) [6];
  tListIterator *ptVar5;
  int ww;
  short fWidth;
  
  if (this->fActive != 0) {
    this->Calibrate();
  }
  sVar1 = (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade;
  (this->_base_tMenuItemLeftRightSlider).fX = (short)x;
  (this->_base_tMenuItemLeftRightSlider).fY = (short)y;
  col2 = CalcFadeVal(0x551e00,0xc83c1e,(int)sVar1);
  col = CalcFadeVal(0x551e00,0xbebe,
                   (int)(this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade);
  coltext = CalcTextFadeUnselToSel(textType_Options,
                      (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,0);
  ww = (w >> 1) + -4;
  PSXDrawSquare(col2,(int)(this->_base_tMenuItemLeftRightSlider).fX,(int)(this->_base_tMenuItemLeftRightSlider).fY
             ,ww,1);
  PSXDrawSquare(col2,(this->_base_tMenuItemLeftRightSlider).fX + ww + 8,
             (int)(this->_base_tMenuItemLeftRightSlider).fY,ww,1);
  PSXDrawSquare(col2,(int)(this->_base_tMenuItemLeftRightSlider).fX,(this->_base_tMenuItemLeftRightSlider).fY + 8,
             ww,1);
  PSXDrawSquare(col2,(this->_base_tMenuItemLeftRightSlider).fX + ww + 9,
             (this->_base_tMenuItemLeftRightSlider).fY + 8,ww,1);
  PSXDrawSquare(col,(this->_base_tMenuItemLeftRightSlider).fX + ww + 3,
             (int)(this->_base_tMenuItemLeftRightSlider).fY,2,9);
  sMenuText = TextSys_Word((this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
  FETextRender_FullTextRGB(sMenuText,(this->_base_tMenuItemLeftRightSlider).fX + 4,
             (this->_base_tMenuItemLeftRightSlider).fY + 10,coltext,'\0',0);
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  pa_Var4 = ptVar5->_vf;
  uVar2 = (*(*pa_Var4)[2].pfn)((char *)ptVar5 + (int)(*pa_Var4)[2].delta,0xffffffff);
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  fWidth = (short)((u_int)(((w >> 1) + -8) * 0x10000) >> 0x10);
  DrawSlider(uVar2 & 0xff,(u_short)(u_char)ptVar5->fMinValue,(u_short)(u_char)ptVar5->fMaxValue,
             (this->_base_tMenuItemLeftRightSlider).fX + 1,(this->_base_tMenuItemLeftRightSlider).fY + 2,fWidth,
             (this->_base_tMenuItemLeftRightSlider).fHeight,4,4,true,0,
             (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade,0);
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  pa_Var4 = ptVar5->_vf;
  uVar2 = (*(*pa_Var4)[2].pfn)((char *)ptVar5 + (int)(*pa_Var4)[2].delta,0xffffffff);
  ptVar5 = (this->_base_tMenuItemLeftRightSlider).fData;
  sVar1 = (this->_base_tMenuItemLeftRightSlider)._base_tMenuItemInteractive._base_tMenuItem.fSelFade;
  col2 = (int)sVar1;
  DrawSlider(uVar2 & 0xff,(u_short)(u_char)ptVar5->fMinValue,(u_short)(u_char)ptVar5->fMaxValue,
             (short)(((u_int)(u_short)(this->_base_tMenuItemLeftRightSlider).fX + ww + 10) * 0x10000 >>
                    0x10),(this->_base_tMenuItemLeftRightSlider).fY + 2,fWidth,
             (this->_base_tMenuItemLeftRightSlider).fHeight,4,4,false,0,sVar1,0);
  return col2;
}



/* ---- GetCurrentStickRange  [FEMENUOPTIONS.CPP:1578-1582] SLD-VERIFIED ---- */

char GetCurrentStickRange(int player)

{
  u_int uVar1;
  int range2;
  int range1;
  
  uVar1 = (u_int)gPadinfo.buf[player * 4].data.negcon.twist;
  range1 = 0x80 - uVar1;
  if (range1 < 1) {
    range1 = uVar1 - 0x80;
  }
  uVar1 = (u_int)gPadinfo.buf[player * 4].data.negcon.buttonI;
  range2 = 0x80 - uVar1;
  if (range2 < 1) {
    range2 = uVar1 - 0x80;
  }
  if (range2 < range1) {
    range2 = range1;
  }
  return (char)range2;
}



/* ---- GetCurrentStickRange2  [FEMENUOPTIONS.CPP:1586-1590] SLD-VERIFIED ---- */

char GetCurrentStickRange2(int player)

{
  u_int uVar1;
  int range2;
  int range1;
  
  uVar1 = (u_int)gPadinfo.buf[player * 4].data.negcon.buttonII;
  range1 = 0x80 - uVar1;
  if (range1 < 1) {
    range1 = uVar1 - 0x80;
  }
  uVar1 = (u_int)gPadinfo.buf[player * 4].data.negcon.leftshift;
  range2 = 0x80 - uVar1;
  if (range2 < 1) {
    range2 = uVar1 - 0x80;
  }
  if (range2 < range1) {
    range2 = range1;
  }
  return (char)range2;
}



/* ---- tInsideBoxTwoWaySlider::Calibrate  [FEMENUOPTIONS.CPP:1595-1678] SLD-VERIFIED ---- */

void tInsideBoxTwoWaySlider::Calibrate()

{
  uchar uVar1;
  short sVar2;
  u_char range;
  char cVar4;
  u_char bVar5;
  int iVar6;
  u_int uVar7;
  u_int uVar8;
  int iVar9;
  u_int player;
  
  player = (u_int)(u_char)FEApp->fInputPlayer;
  fHelpText = GetHelpText(screenControllerConfig[0]);
  sVar2 = this->fType;
  if (sVar2 == 1) {
    uVar1 = gPadinfo.buf[player * 4].ID;
    if (uVar1 == '#') {
      uVar8 = (u_int)gPadinfo.buf[player * 4].data.negcon.twist;
      if (uVar8 < 0x80) {
        iVar6 = 0x80 - uVar8;
      }
      else {
        iVar6 = uVar8 - 0x80;
      }
      iVar9 = (u_char)frontEnd.steeringRange[player] - 10;
      if (iVar9 < iVar6) {
        iVar6 = iVar9;
      }
      cVar4 = (char)iVar6;
      if (iVar6 < 0) {
        cVar4 = '\0';
      }
      frontEnd.deadSpot[player] = cVar4;
    }
    else if ((uVar1 == 'S') || (uVar1 == 's')) {
      range = GetCurrentStickRange(player);
      uVar7 = (u_char)frontEnd.J1MAX[player] - 10;
      uVar8 = (u_int)range;
      if ((int)uVar7 < (int)(u_int)range) {
        uVar8 = uVar7;
      }
      cVar4 = (char)uVar8;
      if ((int)uVar8 < 0) {
        cVar4 = '\0';
      }
      frontEnd.J1MIN[player] = cVar4;
    }
  }
  else if (sVar2 < 2) {
    if (sVar2 == 0) {
      uVar1 = gPadinfo.buf[player * 4].ID;
      if (uVar1 == '#') {
        uVar8 = (u_int)gPadinfo.buf[player * 4].data.negcon.twist;
        if (uVar8 < 0x80) {
          iVar6 = 0x80 - uVar8;
        }
        else {
          iVar6 = uVar8 - 0x80;
        }
        iVar9 = (u_char)frontEnd.deadSpot[player] + 10;
        if (iVar6 < iVar9) {
          iVar6 = iVar9;
        }
        frontEnd.steeringRange[player] = (char)iVar6;
      }
      else if ((uVar1 == 'S') || (uVar1 == 's')) {
        range = GetCurrentStickRange(player);
        uVar8 = (u_char)frontEnd.J1MIN[player] + 10;
        if (range < uVar8) {
          range = (u_char)uVar8;
        }
        frontEnd.J1MAX[player] = range;
      }
    }
  }
  else if (sVar2 == 2) {
    uVar1 = gPadinfo.buf[player * 4].ID;
    if (uVar1 == '#') {
      frontEnd.ImaxRange[player] = gPadinfo.buf[player * 4].data.negcon.buttonI;
    }
    else if ((uVar1 == 'S') || (uVar1 == 's')) {
      range = GetCurrentStickRange2(player);
      uVar7 = (u_char)frontEnd.J2MIN[player] + 10;
      uVar8 = (u_int)range;
      if (range < uVar7) {
        uVar8 = uVar7;
      }
      /* @0x8001FB80: first (unclamped) J2MAX write; @0x8001FB84-94: second write stores
       * (uVar8>=0 ? uVar8 : 0) -- a clamp-to-nonnegative (delay-slot store). The recon wrote the
       * unclamped (char)uVar8 twice, dropping the negative->0 clamp (mirror J2MIN below) (M11). */
      frontEnd.J2MAX[player] = (char)uVar8;
      cVar4 = (char)uVar8;
      if ((int)uVar8 < 0) {
        cVar4 = '\0';
      }
      frontEnd.J2MAX[player] = cVar4;
    }
  }
  else if (sVar2 == 3) {
    uVar1 = gPadinfo.buf[player * 4].ID;
    if (uVar1 == '#') {
      range = gPadinfo.buf[player * 4].data.negcon.buttonII;
      bVar5 = 10;
      if (9 < range) {
        bVar5 = range;
      }
      frontEnd.IImaxRange[player] = bVar5;
    }
    else if ((uVar1 == 'S') || (uVar1 == 's')) {
      range = GetCurrentStickRange2(player);
      uVar7 = (u_char)frontEnd.J2MAX[player] - 10;
      uVar8 = (u_int)range;
      if ((int)uVar7 < (int)(u_int)range) {
        uVar8 = uVar7;
      }
      cVar4 = (char)uVar8;
      if ((int)uVar8 < 0) {
        cVar4 = '\0';
      }
      frontEnd.J2MIN[player] = cVar4;
    }
  }
  return;
}



/* ---- tUserNameMenuItem::ctor  [FEMENUOPTIONS.CPP:1688-1697] SLD-VERIFIED ---- */
tUserNameMenuItem::tUserNameMenuItem(u_int textDescription)
  : _base_tMenuItem(textDescription)
{
  short i;
  
  i = 0;
  *(void **)&((this->_base_tMenuItem)._vf) = (void *)tUserNameMenuItem_vtable;
  this->fCurrentRow = 0;
  this->fCurrentColumn = 0;
  do {
    this->fRowList[0][(short)i * 9] = '\0';
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 10);
  this->fData = (char *)0x0;
  return;
}



/* ---- CheckForCheats  [FEMENUOPTIONS.CPP:1701-1708] SLD-VERIFIED ---- */

void * CheckForCheats(char *fData)

{
  u_int len;
  void *pvVar2;
  
  for (len = strlen(fData); (int)len < 8; len = len + 1) {
    fData[len] = '\0';
  }
  pvVar2 = FECheat_ActivateCheat(fData);
  if ((pvVar2 == (void *)0x0) &&
     (pvVar2 = FECheat_ActivateBonusByCode(fData), pvVar2 == (void *)0x0)) {
    return (void *)0x0;
  }
  return (void *)0x1;
}



/* ---- tUserNameMenuItem::ProcessInput  [FEMENUOPTIONS.CPP:1712-1849] SLD-VERIFIED ---- */

int tUserNameMenuItem::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  u_char bVar1;
  u_short uVar2;
  short sVar3;
  short sVar4;
  u_int uVar5;
  void *pvVar6;
  int iVar7;
  tInputKeyType tVar8;
  int iVar9;
  u_int uVar10;
  
  sVar4 = menu_kUserNameRows;
  tVar8 = keyval;
  if (tVar8 == kInput_KeyType_Down) {
UserNameProcInp_handleUpDown:
    if (tVar8 == kInput_KeyType_Up) {
      uVar2 = this->fCurrentRow - 1;
      this->fCurrentRow = uVar2;
      iVar9 = 3;
      if ((int)((u_int)uVar2 << 0x10) < 0) {
        this->fCurrentRow = menu_kUserNameRows + -1;
      }
    }
    else {
      sVar3 = this->fCurrentRow + 1;
      this->fCurrentRow = sVar3;
      iVar9 = 4;
      if (sVar4 <= sVar3) {
        this->fCurrentRow = 0;
      }
    }
    AudioCmn_PlayFESFX(iVar9);
    if (this->fCurrentColumn < 0) {
      this->fCurrentColumn = 0;
    }
UserNameProcInp_markProcessed:
    keyval = kInput_KeyType_AlreadyProcessed;
  }
  else if ((int)tVar8 < 0x401) {
    if (tVar8 == kInput_KeyType_Cross) {
      uVar5 = strlen(this->fData);
      bVar1 = this->fRowList[0][(int)this->fCurrentColumn + this->fCurrentRow * 9];
      uVar10 = (u_int)bVar1;
      sVar4 = (short)uVar5;
      if (uVar10 - 0x23 < 2) {
        iVar9 = 0x15;
        if (0 < sVar4) {
          this->fData[sVar4 + -1] = '\0';
          goto UserNameProcInp_playSfxAndMarkProcessed;
        }
        goto UserNameProcInp_markProcessed;
      }
      if ((uVar10 == 0x21) || (uVar10 == 0x40)) {
        pvVar6 = CheckForCheats(this->fData);
        if (pvVar6 != (void *)0x0) {
          *this->fData = '\0';
          goto UserNameProcInp_skipDashColumns;
        }
        tVar8 = kInput_KeyType_Triangle;
        if ((FEApp->fCurrentMenu[0]->fFlags & 0x100) == 0) {
          tVar8 = kInput_KeyType_Start;
        }
        keyval = tVar8;
      }
      else if ((uVar10 == 0x26) || (uVar10 == 0x5e)) {
        iVar9 = (int)sVar4;
        if (iVar9 < this->fMaxStringLength) {
          this->fData[iVar9] = ' ';
          this->fData[iVar9 + 1] = '\0';
          AudioCmn_PlayFESFX(0x15);
          goto UserNameProcInp_skipDashColumns;
        }
      }
      else {
        iVar7 = (int)sVar4;
        iVar9 = 0x15;
        if (iVar7 < this->fMaxStringLength) {
          this->fData[iVar7] = bVar1;
          this->fData[iVar7 + 1] = '\0';
          goto UserNameProcInp_playSfxAndMarkProcessed;
        }
      }
      AudioCmn_PlayFESFX(1);
    }
    else if (tVar8 == kInput_KeyType_Up) goto UserNameProcInp_handleUpDown;
  }
  else {
    if (tVar8 == kInput_KeyType_Left) {
      uVar2 = this->fCurrentColumn - 1;
      this->fCurrentColumn = uVar2;
      iVar9 = 3;
      if ((int)((u_int)uVar2 << 0x10) < 0) {
        this->fCurrentColumn = 5;
      }
UserNameProcInp_playSfxAndMarkProcessed:
      AudioCmn_PlayFESFX(iVar9);
      goto UserNameProcInp_markProcessed;
    }
    if (tVar8 == kInput_KeyType_Right) {
      sVar4 = this->fCurrentColumn + 1;
      this->fCurrentColumn = sVar4;
      if (5 < sVar4) {
        this->fCurrentColumn = 0;
      }
      AudioCmn_PlayFESFX(4);
      keyval = kInput_KeyType_AlreadyProcessed;
      sVar4 = this->fCurrentColumn;
      iVar9 = this->fCurrentRow * 9;
      iVar7 = 0x2d;
      if (this->fRowList[0][this->fCurrentColumn + iVar9] != '-')
      goto UserNameProcInp_convertAndReturn;
      do {
        this->fCurrentColumn = sVar4 + 1;
        if (5 < (short)(sVar4 + 1)) {
          this->fCurrentColumn = 0;
        }
        sVar4 = this->fCurrentColumn;
      } while (this->fRowList[0][this->fCurrentColumn + iVar9] == '-');
    }
  }
UserNameProcInp_skipDashColumns:
  iVar9 = this->fCurrentRow * 9;
  iVar7 = 0x2d;
  if (this->fRowList[0][this->fCurrentColumn + iVar9] == '-') {
    iVar7 = (u_short)this->fCurrentColumn - 1;
    do {
      this->fCurrentColumn = (short)iVar7;
      if (iVar7 << 0x10 < 0) {
        this->fCurrentColumn = 5;
      }
      iVar7 = (u_short)this->fCurrentColumn - 1;
    } while (this->fRowList[0][this->fCurrentColumn + iVar9] == '-');
  }
UserNameProcInp_convertAndReturn:
  Stattool_SamNelsonsUpperLowerStringConverterForRecords(this->fData);
  return iVar7;
}



/* ---- SpecialCharacter  [FEMENUOPTIONS.CPP:1853-1869] SLD-VERIFIED ---- */

int SpecialCharacter(char current)

{
  int ret;

  ret = 0;
  switch((u_char)current) {
  case 0xe4:
    ret = 0x51;
    break;
  case 0xf6:
    ret = 0x52;
    break;
  case 0xfc:
    ret = 0x53;
    break;
  case 0xe9:
    ret = 0x54;
    break;
  case 0xe8:
    ret = 0x55;
    break;
  case 0xe1:
    ret = 0x56;
    break;
  case 0xed:
    ret = 0x57;
    break;
  case 0xf3:
    ret = 0x58;
    break;
  case 0xfa:
    ret = 0x59;
    break;
  case 0xf1:
    ret = 0x5a;
    break;
  case 0xe5:
    ret = 0x5b;
  }
  return ret;
}



/* ---- tUserNameMenuItem::Draw  [FEMENUOPTIONS.CPP:1874-1966] SLD-VERIFIED ---- */

int tUserNameMenuItem::Draw(bool selected)

{
  char current_00;
  tTexture_ShapeInfo *shape;
  short sVar2;
  int shapetodraw;
  int x;
  int y;
  int ColText;
  int Col;
  char *sMenuText;
  u_int sl;
  int current;
  int iVar5;
  int yy;
  int j;
  int xx;
  int startx;
  char output [2];
  /* SYM AUTO local optimizer-ELIMINATED (disasm: cursor draw uses fFlags, slot sp+0x28 unused) */
  tDrawShapeExtended tCol;
  tDrawShapeExtended fFlags;
  int cursorX;
  
  x = TextSys_WordX((this->_base_tMenuItem).fTextDescription);
  y = TextSys_WordY((this->_base_tMenuItem).fTextDescription);
  shape = gHelpShapes;
  if (this->fFadeVal != 0x80) {
    output[1] = '\0';
    ColText = CalcFadeVal(0xbebe,(int)this->fFadeVal);
    Col = CalcFadeVal(0xbebe,(int)this->fFadeVal);
    j = 0;
    sMenuText = TextSys_Word((this->_base_tMenuItem).fTextDescription);
    FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,ColText,'\0',0);
    sl = strlen(this->fData);
    sVar2 = (short)sl;
    startx = x + 0x4e + this->fMaxStringLength * -10;
    iVar5 = x;
    if (0 < sVar2) {
      do {
        output[0] = this->fData[(short)j];
        FETextRender_FullTextRGB(output,(short)((u_int)((startx + (short)j * 0x14) * 0x10000) >> 0x10),
                   (short)((u_int)((y + 0x11) * 0x10000) >> 0x10),ColText,'\x01',0);
        j = j + 1;
      } while (j * 0x10000 >> 0x10 < (int)sVar2);
    }
    sl = sl & 0xffff;
    if (sVar2 < this->fMaxStringLength) {
      do {
        PSXDrawSquare(Col,(startx * 0x10000 >> 0x10) + (short)sl * 0x14,y + 0x19,0x11,1);
        sl = sl + 1;
      } while ((int)(sl * 0x10000) >> 0x10 < (int)this->fMaxStringLength);
    }
    if (this->fFadeVal == 0) {
      fFlags.tint[0] = PulsateYellow;
      current = (int)this->fCurrentColumn + this->fCurrentRow * 9;
      current_00 = this->fRowList[0][current];
      if ((current_00 == '!') || (current_00 == '@')) {
        shapetodraw = 0x4e;
        cursorX = this->fCurrentColumn * 0x1c + 0xfd;
      }
      else if ((u_char)(current_00 - 0x23U) < 2) {
        shapetodraw = 0x4f;
        cursorX = this->fCurrentColumn * 0x1c + 0xfd;
      }
      else if ((current_00 == '&') || (current_00 == '^')) {
        shapetodraw = 0x50;
        cursorX = this->fCurrentColumn * 0x1c + 0xfd;
      }
      else {
        if ((u_char)(current_00 - 0x61U) < 0x1a) {
          shapetodraw = (u_char)this->fRowList[0][current] - 0x37;
        }
        else if ((u_char)(current_00 - 0x30U) < 0xa) {
          shapetodraw = (u_char)this->fRowList[0][current] + 0x14;
        }
        else {
          shapetodraw = SpecialCharacter(current_00);
        }
        cursorX = (this->fCurrentColumn * 0x1c + 0x102) - 5;
      }
      yy = *(short *)&MENUUSERNAME_STARTY /* @0x800529b2 */ + this->fCurrentRow * 0xf;
      DrawShapeExtended(shapetodraw,0x10,cursorX,yy - 3,0,0,&fFlags);
    }
  }
  xx = x + 0x9c;
  DrawShapeExtended(0x1e,8,xx - (int)shape[0x1e].width,y + -3,(int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
  iVar5 = 0x9c;
  PSXDrawSquare(0,x,y + -3,0x9c - shape[0x1e].width,(int)shape[0x1e].height);
  shape = gHelpShapes;
  DrawShapeExtended(0x21,8,xx - (int)shape[0x21].width,y + 0xc,(int)this->fFadeVal,0,(tDrawShapeExtended *)0x0);
  iVar5 = (int)shape[0x21].height;
  PSXDrawSquare(0,x,y + 0xc,0x9c - shape[0x21].width,iVar5);
  return iVar5;
}



/* ---- tUserNameMenuItem::TransitionOff  [FEMENUOPTIONS.CPP:1973-1974] SLD-VERIFIED ---- */

void tUserNameMenuItem::TransitionOff()

{
  this->fFadeDir = 0x1e;
  return;
}



/* ---- tUserNameMenuItem::TransitionOn  [FEMENUOPTIONS.CPP:1978-2013] SLD-VERIFIED ---- */

void tUserNameMenuItem::TransitionOn()

{
  char cVar1;
  short sVar2;
  u_int *puVar3;
  char *fmt;
  u_int uVar4;
  short sVar5;
  int iVar6;
  int i;
  short NumberOfRows [6];
  
  i = 0;
  do {
    fmt = TextSys_Word((short)i + 0x1fb);
    sprintf(this->fRowList[0] + (short)i * 9,fmt);
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 10);
  i = 0;
  uVar4 = (int)NumberOfRows + 3U & 3;
  puVar3 = (u_int *)(((int)NumberOfRows + 3U) - uVar4);
  *puVar3 = *puVar3 & -1 << (uVar4 + 1) * 8 | 0x00090007U /* @0x80010a00 */ >> (3 - uVar4) * 8;
  NumberOfRows[0] = 0x00090007U /* @0x80010a00 */;
  NumberOfRows[1] = _UNK_80010a02;
  uVar4 = (int)NumberOfRows + 7U & 3;
  puVar3 = (u_int *)(((int)NumberOfRows + 7U) - uVar4);
  *puVar3 = *puVar3 & -1 << (uVar4 + 1) * 8 | 0x00090009U /* @0x80010a04 */ >> (3 - uVar4) * 8;
  NumberOfRows[2] = 0x00090009U /* @0x80010a04 */;
  NumberOfRows[3] = _UNK_80010a06;
  uVar4 = (int)NumberOfRows + 0xbU & 3;
  puVar3 = (u_int *)(((int)NumberOfRows + 0xbU) - uVar4);
  *puVar3 = *puVar3 & -1 << (uVar4 + 1) * 8 | 0x00090008U /* @0x80010a08 */ >> (3 - uVar4) * 8;
  NumberOfRows[4] = 0x00090008U /* @0x80010a08 */;
  NumberOfRows[5] = _UNK_80010a0a;
  menu_kUserNameRows = NumberOfRows[(u_char)frontEnd.language];
  this->fCurrentRow = 0;
  cVar1 = this->fRowList[0][this->fCurrentColumn];
  if ((cVar1 != '!') && (cVar1 != '@')) {
    while (i < menu_kUserNameRows) {
      this->fCurrentColumn = 0;
      i = this->fCurrentRow * 9;
      cVar1 = this->fRowList[0][i];
      iVar6 = 0;
      if ((cVar1 != '!') && (cVar1 != '@')) {
        while (uVar4 = strlen(this->fRowList[0] + i), iVar6 < (int)uVar4) {
          sVar5 = this->fCurrentColumn + 1;
          iVar6 = (int)sVar5;
          i = this->fCurrentRow * 9;
          this->fCurrentColumn = sVar5;
          cVar1 = this->fRowList[0][iVar6 + i];
          if ((cVar1 == '!') || (cVar1 == '@')) break;
        }
      }
      sVar5 = this->fCurrentRow + 1;
      i = (int)sVar5;
      this->fCurrentRow = sVar5;
      cVar1 = this->fRowList[0][(int)this->fCurrentColumn + i * 9];
      if ((cVar1 == '!') || (cVar1 == '@')) break;
    }
  }
  sVar2 = this->fCurrentRow;
  this->fFadeVal = 0x80;
  this->fFadeDir = -0x1e;
  sVar5 = this->fPlayer;
  (this->_base_tMenuItem).fSelFade = 0;
  this->fCurrentRow = sVar2 + -1;
  if (FEApp->speechToPlay[sVar5] != -1) {
    FeAudio_AsyncPlaySpeech(2,FEApp->speechToPlay[sVar5]);
    FEApp->speechToPlay[this->fPlayer] = -1;
  }
  return;
}



/* ---- tUserNameMenuItem::TransitionIsFinished  [FEMENUOPTIONS.CPP:2018-2028] SLD-VERIFIED ---- */

void * tUserNameMenuItem::TransitionIsFinished()

{
  this->fInTransition = 0;
  if (this->fFadeDir < 0) {
    if (0 < this->fFadeVal) {
      this->fInTransition = 1;
    }
  }
  if (0 < this->fFadeDir) {
    if (this->fFadeVal < 0x80 || (*(u_short*)&ginfo[16]) != 0) {
      this->fInTransition = 1;
    }
  }
  return (void *)(this->fInTransition ^ 1);
}



/* ---- tUserNameMenuItem::UpdateTransition  [FEMENUOPTIONS.CPP:2032-2038] SLD-VERIFIED ---- */

void tUserNameMenuItem::UpdateTransition(bool selected)

{
  __vtbl_ptr_type (*pa_Var1) [11];
  int iVar2;
  
  iVar2 = (int)this->fFadeVal + (int)this->fFadeDir;
  if (0x80 < iVar2) {
    iVar2 = 0x80;
  }
  if (iVar2 < 0) {
    iVar2 = 0;
  }
  pa_Var1 = (this->_base_tMenuItem)._vf;
  this->fFadeVal = (short)iVar2;
  (*(*pa_Var1)[9].pfn)((int)this + (int)(*pa_Var1)[9].delta);
  this->_base_tMenuItem.UpdateTransition(selected);
  return;
}



/* ---- tMemoryCardMenuItem::Draw  [FEMENUOPTIONS.CPP:2048-2085] SLD-VERIFIED ---- */

int tMemoryCardMenuItem::Draw(bool selected)

{
  tTexture_ShapeInfo *shape;
  short sVar2;
  int x;
  int y;
  int iVar4;
  int Col;
  char *sMenuText;
  short fEnableSlide;
  int iVar6;
  int ColText;
  int fEnableFade;
  int amount;
  int fWidth;
  /* SYM AUTO local optimizer-ELIMINATED (disasm: draw passes NULL, slot sp+0x20 unused) */
  tDrawShapeExtended tCol;
  
  if (((this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fFlags & 1) == 0) {
    sVar2 = (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal + 8;
  }
  else {
    sVar2 = (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal + -8;
  }
  (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal = sVar2;
  sVar2 = (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal;
  fEnableSlide = (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal;
  if ((sVar2 < 0x100) && (sVar2 < 1)) {
    fEnableSlide = 0;
  }
  else if (0x100 < sVar2) {
    fEnableSlide = 0x100;
  }
  (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal = fEnableSlide;
  iVar6 = (int)fEnableSlide;
  fEnableFade = 0x80;
  if ((iVar6 < 0x80) && (fEnableFade = 0, 0 < iVar6)) {
    fEnableFade = iVar6;
  }
  iVar6 = (int)(this->_base_tMenuItemGoToMenuButtonFade).fFadeVal;
  if ((iVar6 != 0x80) && (iVar6 = 0, (this->_base_tMenuItemGoToMenuButtonFade).fEnableVal != 0)) {
    x = TextSys_WordX((this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    y = TextSys_WordY((this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
    ColText = CalcTextFadeSelToHi(textType_Options,
                       (this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fSelFade,
                       (this->_base_tMenuItemGoToMenuButtonFade).fFadeVal);
    amount = (int)(this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fSelFade;
    Col = CalcFadeVal(0xc83c1e,0xbebe,amount,(int)(this->_base_tMenuItemGoToMenuButtonFade).fFadeVal);
    CalcFadeVal(Col,amount);
    iVar6 = CalcFadeVal(ColText,amount);
    if (iVar6 != 0) {
      sMenuText = TextSys_Word((this->_base_tMenuItemGoToMenuButtonFade)._base_tMenuItemGoToMenuButton._base_tMenuItemInteractive._base_tMenuItem.fTextDescription);
      FETextRender_FullTextRGB(sMenuText,(short)x,(short)y,iVar6,'\0',0);
    }
    shape = gHelpShapes;
    fWidth = fEnableFade * 0x96;   /* H14: was fWidth (uninitialized); oracle 0x80020A30 __MULT($s3=fEnableFade,0x96) */
    if (fWidth < 0) {
      fWidth = fWidth + 0x7f;
    }
    fWidth = (fWidth >> 7) * (0x80 - (this->_base_tMenuItemGoToMenuButtonFade).fFadeVal);
    if (fWidth < 0) {
      fWidth = fWidth + 0x7f;
    }
    DrawShapeExtended(0x1e,8,(x + (fWidth >> 7)) - (int)shape[0x1e].width,y + -3,0,0,(tDrawShapeExtended *)0x0);
    iVar4 = (int)shape[0x1e].width;
    iVar6 = 0;
    if (iVar4 < fWidth >> 7) {
      iVar6 = (int)shape[0x1e].height;
      PSXDrawSquare(0,x,y + -3,(fWidth >> 7) - iVar4,iVar6);
    }
  }
  return iVar6;
}



/* ---- tInsideBoxControllerLeftRightSlider::ProcessInput  [FEMENUOPTIONS.CPP:2088-2094] SLD-VERIFIED ---- */

void tInsideBoxControllerLeftRightSlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  char cVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  tInputKeyType tVar3;
  tListIterator *ptVar4;
  
  tVar3 = keyval;
  if (((tVar3 == kInput_KeyType_Left) || (tVar3 == kInput_KeyType_Right)) &&
     ((tVar3 != kInput_KeyType_Right ||
      (ptVar4 = (this->_base_tInsideBoxLeftRightSlider)._base_tMenuItemLeftRightSlider.fData,
      pa_Var2 = ptVar4->_vf,
      cVar1 = (*(*pa_Var2)[2].pfn)
                        ((char *)ptVar4 + (int)(*pa_Var2)[2].delta,0xffffffff),
      cVar1 != ((this->_base_tInsideBoxLeftRightSlider)._base_tMenuItemLeftRightSlider.fData)->fMaxValue)))) {
    screenControllerConfig[0]->fResetShakeTimeOut = 1;
  }
  ((tMenuItemLeftRightSlider *)this)->ProcessInput(fromPlayer,keyval,command)
  ;
  return;
}



/* end of femenuoptions.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
short _UNK_80010a02, _UNK_80010a06, _UNK_80010a0a;

extern "C" {
void ___25tInsideBoxLeftRightSlider(void *);
void ___35tInsideBoxControllerLeftRightSlider(void *thisp) { ___25tInsideBoxLeftRightSlider(thisp); }
}

extern "C" {
void ___23tMenuItemGoToMenuButton(void *);
void ___27tMenuItemGoToMenuButtonFade(void *thisp) { ___23tMenuItemGoToMenuButton(thisp); }
}

extern "C" {
void ___9tMenuItem(void *);
void ___17tUserNameMenuItem(void *thisp) { ___9tMenuItem(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___34tMenuItemControllerLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___29tMenuItemOnOffLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___31tMenuItemDisplayLeftRightChoice(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

extern "C" {
void ___20tMenuItemSlidingMenu(void *);
void ___25tMenuItemSlidingActivated(void *thisp) { ___20tMenuItemSlidingMenu(thisp); }
}

extern "C" {
void ___24tMenuItemLeftRightChoice(void *);
void ___22tMenuItemLeftRightFade(void *thisp) { ___24tMenuItemLeftRightChoice(thisp); }
}

/* cont.34: tMenuItemGoToMenuNFS4Button::Draw(bool) nullsub re-attributed from front.c.
   The class declares Draw(bool) (nfs4_types.h) so the REAL method def mangles to the
   exact oracle symbol Draw__27tMenuItemGoToMenuNFS4Buttonb (0x8001BF40 = jr ra;nop).
   (extern-C free-fn form would clash with the member's mangled symbol.) */
void tMenuItemGoToMenuNFS4Button::Draw(bool /*selected*/) {}  /* @0x8001BF40 */
