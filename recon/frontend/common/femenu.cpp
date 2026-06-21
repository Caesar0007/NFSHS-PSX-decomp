/* frontend/common/femenu.cpp -- RECONSTRUCTED (menu/iterator class hierarchy; C++ TU)
 *   71 fns across 12 classes: tListIterator(+Indexed/DoubleIndexed/MultiPlayer/Range/
 *   RangeIndexed) list iterators; tMenuItem(+Interactive/LeftRightChoice/LeftRightSlider/
 *   GoToMenuButton) menu items; tMenu container; + free DrawSlider (GPU slider widget).
 *   Member defs; base ctors via member-init-lists; manual _vf vtable dispatch; ref params.
 */
#include "femenu.h"

/* ---- FEMenu.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) ---- */
tPlayer      gMenu_SubMenuPlayer = -1;   /* @0x800517c0 */


/* ---- tListIterator::ctor  [FEMENU.CPP:61-64] SLD-VERIFIED ---- */

tListIterator::tListIterator(short *selection,char *valPtr)

{
  
  *(void **)&(this->_vf) = (void *)tListIterator_vtable;
  this->fSelectionList = selection;
  this->fValue = valPtr;
  this->fMaxValue = '\0';
  this->fMinValue = '\0';
  return;
}



/* ---- tListIterator::dtor  [FEMENU.CPP:68-68] SLD-VERIFIED ---- */

tListIterator::~tListIterator()

{
  *(void **)&(this->_vf) = (void *)tListIterator_vtable;
  return;
}



/* ---- tListIterator::Value  [FEMENU.CPP:73-74] SLD-VERIFIED ---- */

int tListIterator::Value(tPlayer arg1)

{
  return (u_int)(u_char)*this->fValue;
}



/* ---- tListIterator::TextValue  [FEMENU.CPP:78-79] SLD-VERIFIED ---- */

int tListIterator::TextValue(tPlayer arg1)

{
  u_int uVar1;
  
  uVar1 = (*(*this->_vf)[2].pfn)((char *)this + (int)(*this->_vf)[2].delta,0xffffffff)
  ;
  return (int)this->fSelectionList[uVar1 & 0xff];
}



/* ---- tListIterator::Increment  [FEMENU.CPP:83-86] SLD-VERIFIED ---- */

int tListIterator::Increment(tPlayer arg1)

{
  short sVar1;
  
  *this->fValue = *this->fValue + '\x01';
  sVar1 = this->fSelectionList[(u_char)*this->fValue];
  if (sVar1 == 0) {
    *this->fValue = 0;
  }
  return (int)sVar1;
}



/* ---- tListIterator::Decrement  [FEMENU.CPP:90-97] SLD-VERIFIED ---- */

int tListIterator::Decrement(tPlayer arg1)

{
  int iVar1;
  u_char *pbVar2;

  pbVar2 = (u_char *)this->fValue;
  if (*pbVar2 == 0) {
    iVar1 = (int)this->fSelectionList[(u_char)*pbVar2 + 1];
    if (0 < iVar1) {
      do {
        *pbVar2 = *pbVar2 + 1;
        pbVar2 = (u_char *)this->fValue;
        iVar1 = (int)this->fSelectionList[(u_char)*pbVar2 + 1];
      } while (0 < iVar1);
      return iVar1;
    }
  }
  else {
    iVar1 = *pbVar2 - 1;
    *pbVar2 = (u_char)iVar1;
  }
  return iVar1;
}



/* ---- tListIteratorIndexed::ctor  [FEMENU.CPP:104-106] SLD-VERIFIED ---- */
tListIteratorIndexed::tListIteratorIndexed(short *selection,char *valPtr,char *index)
  : _base_tListIterator(selection,valPtr)
{
  tListIterator *in_v0;
  
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tListIteratorIndexed::dtor  [FEMENU.CPP:110-110] SLD-VERIFIED ---- */

tListIteratorIndexed::~tListIteratorIndexed()

{
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorIndexed_vtable;
  return;
}



/* ---- tListIteratorIndexed::Value  [FEMENU.CPP:114-115] SLD-VERIFIED ---- */

int tListIteratorIndexed::Value(tPlayer arg1)

{
  return (u_int)(u_char)(this->_base_tListIterator).fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorIndexed::TextValue  [FEMENU.CPP:119-120] SLD-VERIFIED ---- */

int tListIteratorIndexed::TextValue(tPlayer arg1)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = (this->_base_tListIterator)._vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&(this->_base_tListIterator).fSelectionList + (int)(*pa_Var1)[2].delta,
                     0xffffffff);
  return (int)(this->_base_tListIterator).fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorIndexed::Increment  [FEMENU.CPP:126-129] SLD-VERIFIED ---- */

int tListIteratorIndexed::Increment(tPlayer arg1)

{
  int iVar1;
  char *pcVar2;
  u_char *pbVar3;
  
  pcVar2 = (this->_base_tListIterator).fValue + (u_char)*this->fIndex;
  *pcVar2 = *pcVar2 + '\x01';
  pbVar3 = (u_char *)((this->_base_tListIterator).fValue + (u_char)*this->fIndex);
  iVar1 = (int)(this->_base_tListIterator).fSelectionList[*pbVar3];
  if (iVar1 == 0) {
    *pbVar3 = 0;
  }
  return iVar1;
}



/* ---- tListIteratorIndexed::Decrement  [FEMENU.CPP:133-140] SLD-VERIFIED ---- */

int tListIteratorIndexed::Decrement(tPlayer arg1)

{
  u_int uVar1;
  int iVar2;
  char *pcVar3;
  u_char *pbVar4;

  pbVar4 = (u_char *)this->fIndex;
  pcVar3 = (this->_base_tListIterator).fValue;
  uVar1 = (u_int)(u_char)pcVar3[*pbVar4];
  if (uVar1 == 0) {
    iVar2 = (int)(this->_base_tListIterator).fSelectionList[(u_char)pcVar3[*pbVar4] + 1];
    if (0 < iVar2) {
      do {
        pcVar3[*pbVar4] = pcVar3[*pbVar4] + '\x01';
        pbVar4 = (u_char *)this->fIndex;
        pcVar3 = (this->_base_tListIterator).fValue;
        iVar2 = (int)(this->_base_tListIterator).fSelectionList[(u_char)pcVar3[*pbVar4] + 1];
      } while (0 < iVar2);
      return iVar2;
    }
  }
  else {
    iVar2 = uVar1 - 1;
    pcVar3[*pbVar4] = (u_char)iVar2;
  }
  return iVar2;
}



/* ---- tListIteratorDoubleIndexed::dtor  [FEMENU.CPP:156-156] SLD-VERIFIED ---- */

tListIteratorDoubleIndexed::~tListIteratorDoubleIndexed()

{
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorDoubleIndexed_vtable;
  return;
}



/* ---- tListIteratorDoubleIndexed::Value  [FEMENU.CPP:160-161] SLD-VERIFIED ---- */

int tListIteratorDoubleIndexed::Value(tPlayer arg1)

{
  return (u_int)(u_char)(this->_base_tListIterator).fValue
                     [(u_int)(u_char)*this->fIndex1 * this->index1multiplier +
                      (u_int)(u_char)*this->fIndex2];
}



/* ---- tListIteratorDoubleIndexed::TextValue  [FEMENU.CPP:165-166] SLD-VERIFIED ---- */

int tListIteratorDoubleIndexed::TextValue(tPlayer arg1)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = (this->_base_tListIterator)._vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&(this->_base_tListIterator).fSelectionList + (int)(*pa_Var1)[2].delta,
                     0xffffffff);
  return (int)(this->_base_tListIterator).fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorDoubleIndexed::Increment  [FEMENU.CPP:172-175] SLD-VERIFIED ---- */

int tListIteratorDoubleIndexed::Increment(tPlayer arg1)

{
  int iVar1;
  char *pcVar2;
  u_char *pbVar3;
  
  pcVar2 = (this->_base_tListIterator).fValue +
           ((u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2);
  *pcVar2 = *pcVar2 + '\x01';
  pbVar3 = (u_char *)((this->_base_tListIterator).fValue +
                   ((u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2))
  ;
  iVar1 = (int)(this->_base_tListIterator).fSelectionList[*pbVar3];
  if (iVar1 == 0) {
    *pbVar3 = 0;
  }
  return iVar1;
}



/* ---- tListIteratorDoubleIndexed::Decrement  [FEMENU.CPP:179-186] SLD-VERIFIED ---- */

int tListIteratorDoubleIndexed::Decrement(tPlayer arg1)

{
  u_int uVar1;
  int iVar2;
  char *pcVar3;
  u_char *pbVar4;
  int iVar5;
  u_char *pbVar6;
  
  pbVar6 = (u_char *)this->fIndex1;
  iVar5 = this->index1multiplier;
  pbVar4 = (u_char *)this->fIndex2;
  pcVar3 = (this->_base_tListIterator).fValue;
  uVar1 = (u_int)(u_char)pcVar3[(u_int)*pbVar6 * iVar5 + (u_int)*pbVar4];
  if (uVar1 == 0) {
    iVar2 = (int)(this->_base_tListIterator).fSelectionList[1];
    if (0 < iVar2) {
      do {
        pcVar3[(u_int)*pbVar6 * iVar5 + (u_int)*pbVar4] =
             pcVar3[(u_int)*pbVar6 * iVar5 + (u_int)*pbVar4] + '\x01';
        pbVar6 = (u_char *)this->fIndex1;
        iVar5 = this->index1multiplier;
        pbVar4 = (u_char *)this->fIndex2;
        pcVar3 = (this->_base_tListIterator).fValue;
        iVar2 = (int)(this->_base_tListIterator).fSelectionList
                     [(u_char)pcVar3[(u_int)*pbVar6 * iVar5 + (u_int)*pbVar4] + 1];
      } while (0 < iVar2);
      return iVar2;
    }
  }
  else {
    iVar2 = uVar1 - 1;
    pcVar3[(u_int)*pbVar6 * iVar5 + (u_int)*pbVar4] = (u_char)iVar2;
  }
  return iVar2;
}



/* ---- tListIteratorMultiPlayer::dtor  [FEMENU.CPP:202-202] SLD-VERIFIED ---- */

tListIteratorMultiPlayer::~tListIteratorMultiPlayer()

{
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorMultiPlayer_vtable;
  return;
}



/* ---- tListIteratorMultiPlayer::Value  [FEMENU.CPP:206-210] SLD-VERIFIED ---- */

char tListIteratorMultiPlayer::Value(tPlayer atIndex)

{
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  return (this->_base_tListIterator).fValue[atIndex];
}



/* ---- tListIteratorMultiPlayer::TextValue  [FEMENU.CPP:214-215] SLD-VERIFIED ---- */

short tListIteratorMultiPlayer::TextValue(tPlayer atIndex)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = (this->_base_tListIterator)._vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&(this->_base_tListIterator).fSelectionList + (int)(*pa_Var1)[2].delta);
  return (this->_base_tListIterator).fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorMultiPlayer::Increment  [FEMENU.CPP:221-227] SLD-VERIFIED ---- */

void tListIteratorMultiPlayer::Increment(tPlayer atIndex)

{
  char *pcVar1;
  u_char *pbVar2;
  
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  pcVar1 = (this->_base_tListIterator).fValue + atIndex;
  *pcVar1 = *pcVar1 + '\x01';
  pbVar2 = (u_char *)((this->_base_tListIterator).fValue + atIndex);
  if ((this->_base_tListIterator).fSelectionList[*pbVar2] == 0) {
    *pbVar2 = 0;
  }
  return;
}



/* ---- tListIteratorMultiPlayer::Decrement  [FEMENU.CPP:231-241] SLD-VERIFIED ---- */

void tListIteratorMultiPlayer::Decrement(tPlayer atIndex)

{
  char cVar1;
  short sVar2;
  char *pcVar3;
  
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  pcVar3 = (this->_base_tListIterator).fValue;
  cVar1 = pcVar3[atIndex];
  if (cVar1 == '\0') {
    sVar2 = (this->_base_tListIterator).fSelectionList[(u_char)pcVar3[atIndex] + 1];
    while (0 < sVar2) {
      pcVar3[atIndex] = pcVar3[atIndex] + '\x01';
      pcVar3 = (this->_base_tListIterator).fValue;
      sVar2 = (this->_base_tListIterator).fSelectionList[(u_char)pcVar3[atIndex] + 1];
    }
    return;
  }
  pcVar3[atIndex] = cVar1 - 1;
  return;
}



/* ---- tListIteratorRange::ctor  [FEMENU.CPP:250-253] SLD-VERIFIED ---- */
tListIteratorRange::tListIteratorRange(char minValue,char maxValue,char *valPtr)
  : _base_tListIterator((short *)0x0,valPtr)
{
  tListIterator *in_v0;
  
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorRange_vtable;
  (this->_base_tListIterator).fMinValue = minValue;
  (this->_base_tListIterator).fMaxValue = maxValue;
  return;
}



/* ---- tListIteratorRange::dtor  [FEMENU.CPP:257-257] SLD-VERIFIED ---- */

tListIteratorRange::~tListIteratorRange()

{
  *(void **)&((this->_base_tListIterator)._vf) = (void *)tListIteratorRange_vtable;
  return;
}



/* ---- tListIteratorRange::Value  [FEMENU.CPP:262-266] SLD-VERIFIED ---- */

int tListIteratorRange::Value(tPlayer arg1)

{
  return (u_int)(u_char)*(this->_base_tListIterator).fValue;
}



/* ---- tListIteratorRange::TextValue  [FEMENU.CPP:270-271] SLD-VERIFIED ---- */

int tListIteratorRange::TextValue(tPlayer arg1)

{
  return 0;
}



/* ---- tListIteratorRange::Increment  [FEMENU.CPP:276-281] SLD-VERIFIED ---- */

int tListIteratorRange::Increment(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  u_char *pbVar3;

  pbVar3 = (u_char *)(this->_base_tListIterator).fValue;
  uVar2 = (u_char)(this->_base_tListIterator).fMaxValue;
  if ((u_int)*pbVar3 < uVar2) {
    iVar1 = (u_int)*pbVar3 + 1;
    *pbVar3 = (u_char)iVar1;
    return iVar1;
  }
  return (u_int)*pbVar3 + 1;
}



/* ---- tListIteratorRange::Decrement  [FEMENU.CPP:285-290] SLD-VERIFIED ---- */

int tListIteratorRange::Decrement(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  u_char *pbVar3;

  pbVar3 = (u_char *)(this->_base_tListIterator).fValue;
  uVar2 = (u_char)(this->_base_tListIterator).fMinValue;
  if (uVar2 < (u_int)*pbVar3) {
    iVar1 = (u_int)*pbVar3 - 1;
    *pbVar3 = (u_char)iVar1;
    return iVar1;
  }
  return (u_int)*pbVar3 - 1;
}



/* ---- tListIteratorRangeIndexed::ctor  [FEMENU.CPP:298-300] SLD-VERIFIED ---- */
tListIteratorRangeIndexed::tListIteratorRangeIndexed(char minValue,char maxValue,char *valPtr,char *index)
  : _base_tListIteratorRange(minValue,maxValue,valPtr)
{
  
  *(void **)&((this->_base_tListIteratorRange)._base_tListIterator._vf) = (void *)tListIteratorRangeIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tListIteratorRangeIndexed::dtor  [FEMENU.CPP:304-304] SLD-VERIFIED ---- */

tListIteratorRangeIndexed::~tListIteratorRangeIndexed()

{
  *(void **)&((this->_base_tListIteratorRange)._base_tListIterator._vf) = (void *)tListIteratorRangeIndexed_vtable;
  return;
}



/* ---- tListIteratorRangeIndexed::Value  [FEMENU.CPP:308-309] SLD-VERIFIED ---- */

int tListIteratorRangeIndexed::Value(tPlayer arg1)

{
  return (u_int)(u_char)(this->_base_tListIteratorRange)._base_tListIterator.fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorRangeIndexed::Increment  [FEMENU.CPP:313-315] SLD-VERIFIED ---- */

int tListIteratorRangeIndexed::Increment(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  u_char *pbVar3;

  pbVar3 = (u_char *)((this->_base_tListIteratorRange)._base_tListIterator.fValue + (u_char)*this->fIndex);
  uVar2 = (u_int)*pbVar3;
  if (uVar2 < (u_char)(this->_base_tListIteratorRange)._base_tListIterator.fMaxValue) {
    iVar1 = uVar2 + 1;
    *pbVar3 = (u_char)iVar1;
    return iVar1;
  }
  return uVar2 + 1;
}



/* ---- tListIteratorRangeIndexed::Decrement  [FEMENU.CPP:319-321] SLD-VERIFIED ---- */

int tListIteratorRangeIndexed::Decrement(tPlayer arg1)

{
  int iVar1;
  u_int uVar2;
  u_char *pbVar3;

  pbVar3 = (u_char *)((this->_base_tListIteratorRange)._base_tListIterator.fValue + (u_char)*this->fIndex);
  uVar2 = (u_int)*pbVar3;
  if ((u_char)(this->_base_tListIteratorRange)._base_tListIterator.fMinValue < uVar2) {
    iVar1 = uVar2 - 1;
    *pbVar3 = (u_char)iVar1;
    return iVar1;
  }
  return uVar2 - 1;
}



/* ---- tMenuItem::ctor  [FEMENU.CPP:423-429] SLD-VERIFIED ---- */

tMenuItem::tMenuItem(u_int textDescription)

{
  *(void **)&(this->_vf) = (void *)tMenuItem_vtable;
  this->fTextDescription = textDescription;
  this->fFlags = 0;
  this->fSelFade = 0;
  this->fButtonImage = -1;
  this->fNumFrames = 0;
  this->fNewMenu = (tMenu *)0x0;
  return;
}



/* ---- tMenuItem::dtor  [FEMENU.CPP:433-433] SLD-VERIFIED ---- */

tMenuItem::~tMenuItem()

{
  *(void **)&(this->_vf) = (void *)tMenuItem_vtable;
  return;
}



/* ---- tMenuItem::DebounceKeys  [FEMENU.CPP:442-443] SLD-VERIFIED ---- */

long tMenuItem::DebounceKeys()

{
  return -1;
}



/* ---- tMenuItem::ProcessInput  [FEMENU.CPP:447-448] SLD-VERIFIED ---- */

void tMenuItem::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  return;
}



/* ---- tMenuItem::UpdateTransition  [FEMENU.CPP:461-462] SLD-VERIFIED ---- */

void tMenuItem::UpdateTransition(bool selected)

{
  this->UpdateSelFade(selected);
  return;
}



/* ---- tMenuItem::TransitionIsFinished  [FEMENU.CPP:466-467] SLD-VERIFIED ---- */

void * tMenuItem::TransitionIsFinished()

{
  return (void *)0x1;
}



/* ---- tMenuItem::UpdateSelFade  [FEMENU.CPP:471-477] SLD-VERIFIED ---- */

void tMenuItem::UpdateSelFade(bool selected)

{
  if (selected != 0) {
    this->fSelFade = this->fSelFade + 0x40;
  }
  else {
    this->fSelFade = this->fSelFade + -10;
  }
  if (0x80 < this->fSelFade) {
    this->fSelFade = 0x80;
  }
  if (this->fSelFade < 0) {
    this->fSelFade = 0;
  }
  return;
}



/* ---- tMenuItem::Draw  [FEMENU.CPP:481-482] SLD-VERIFIED ---- */

int tMenuItem::Draw(int x,int y,bool selected)

{
  int iVar1;
  
  iVar1 = (*(*this->_vf)[4].pfn)
                    ((char *)this + (int)(*this->_vf)[4].delta,
                     selected);
  return iVar1;
}



/* ---- tMenuItem::Draw  [FEMENU.CPP:486-487] SLD-VERIFIED ---- */

int tMenuItem::Draw(int x,int y,int w,bool selected)

{
  int iVar1;
  
  iVar1 = (*(*this->_vf)[6].pfn)((char *)this + (int)(*this->_vf)[6].delta,selected,x,y,0);
  return iVar1;
}



/* ---- tMenuItemInteractive::ctor  [FEMENU.CPP:533-534] SLD-VERIFIED ---- */
tMenuItemInteractive::tMenuItemInteractive(u_int textDescription)
  : _base_tMenuItem(textDescription)
{
  
  *(void **)&((this->_base_tMenuItem)._vf) = (void *)tMenuItemInteractive_vtable;
  return;
}



/* ---- tMenuItemInteractive::dtor  [FEMENU.CPP:538-538] SLD-VERIFIED ---- */

tMenuItemInteractive::~tMenuItemInteractive()

{
  *(void **)&((this->_base_tMenuItem)._vf) = (void *)tMenuItemInteractive_vtable;
  return;
}



/* ---- tMenuItemLeftRightChoice::ctor  [FEMENU.CPP:552-555] SLD-VERIFIED ---- */
tMenuItemLeftRightChoice::tMenuItemLeftRightChoice(u_int textDescription,tListIterator *dataPtr)
  : _base_tMenuItemInteractive(textDescription)
{
  u_int uVar1;
  
  uVar1 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags;
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemLeftRightChoice_vtable;
  this->fData = dataPtr;
  (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags = uVar1 | 0x400;
  return;
}



/* ---- tMenuItemLeftRightChoice::dtor  [FEMENU.CPP:559-559] SLD-VERIFIED ---- */

tMenuItemLeftRightChoice::~tMenuItemLeftRightChoice()

{
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemLeftRightChoice_vtable;
  return;
}



/* ---- tMenuItemLeftRightChoice::ProcessInput  [FEMENU.CPP:563-582] SLD-VERIFIED ---- */

int tMenuItemLeftRightChoice::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  u_int uVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  int SFXnum;
  
  uVar1 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags & 1;
  if (uVar1 == 0) {
    if (keyval == kInput_KeyType_Left) {
      pa_Var2 = this->fData->_vf;
      (*(*pa_Var2)[5].pfn)((char *)this->fData + (int)(*pa_Var2)[5].delta);
      SFXnum = 5;
    }
    else {
      if (keyval != kInput_KeyType_Right) {
        return 0x1000;
      }
      pa_Var2 = this->fData->_vf;
      (*(*pa_Var2)[4].pfn)((char *)this->fData + (int)(*pa_Var2)[4].delta);
      SFXnum = 6;
    }
    uVar1 = 1;
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFX(SFXnum);
  }
  return uVar1;
}



/* ---- tMenuItemLeftRightChoice::Draw  [FEMENU.CPP:590-605] SLD-VERIFIED ---- */

void tMenuItemLeftRightChoice::Draw(bool selected)

{
  short index;
  int iVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [6];
  tMenuTextState textState;
  
  iVar1 = TextSys_WordX((this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription);
  iVar2 = TextSys_WordY((this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription);
  textState = (tMenuTextState)(selected != 0);
  FETextRender_MenuTextPositioned((short)(this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription,(short)iVar1,
             (short)iVar2,textState,textType_Options);
  pa_Var3 = this->fData->_vf;
  index = (*(*pa_Var3)[3].pfn)
                    ((char *)this->fData + (int)(*pa_Var3)[3].delta,
                     gMenu_SubMenuPlayer);
  FETextRender_MenuTextPositioned(index,(short)((u_int)((iVar1 + 0xb4) * 0x10000) >> 0x10),(short)iVar2,textState,
             textType_Options);
  return;
}



/* ---- tMenuItemLeftRightSlider::ctor  [FEMENU.CPP:612-616] SLD-VERIFIED ---- */
tMenuItemLeftRightSlider::tMenuItemLeftRightSlider(u_int textDescription,tListIterator *dataPtr)
  : _base_tMenuItemInteractive(textDescription)
{
  u_int uVar1;
  u_int uVar2;

  uVar1 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags;
  this->fData = dataPtr;
  (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags = uVar1 | 0x80;
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemLeftRightSlider_vtable;
  uVar2 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags;
  (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags = uVar2 | 0x80;
  return;
}



/* ---- tMenuItemLeftRightSlider::dtor  [FEMENU.CPP:621-621] SLD-VERIFIED ---- */

tMenuItemLeftRightSlider::~tMenuItemLeftRightSlider()

{
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemLeftRightSlider_vtable;
  return;
}



/* ---- tMenuItemLeftRightSlider::DebounceKeys  [FEMENU.CPP:625-626] SLD-VERIFIED ---- */

long tMenuItemLeftRightSlider::DebounceKeys()

{
  return 0x600;
}



/* ---- tMenuItemLeftRightSlider::ProcessInput  [FEMENU.CPP:630-650] SLD-VERIFIED ---- */

int tMenuItemLeftRightSlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  short sVar1;
  u_int uVar2;
  int (*pcVar3)(...);
  tListIterator *ptVar4;
  
  uVar2 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags & 1;
  if (uVar2 == 0) {
    if (keyval == kInput_KeyType_Left) {
      ptVar4 = this->fData;
      sVar1 = (*ptVar4->_vf)[5].delta;
      pcVar3 = (*ptVar4->_vf)[5].pfn;
    }
    else {
      if (keyval != kInput_KeyType_Right) {
        return 0x1000;
      }
      ptVar4 = this->fData;
      sVar1 = (*ptVar4->_vf)[4].delta;
      pcVar3 = (*ptVar4->_vf)[4].pfn;
    }
    (*pcVar3)((char *)ptVar4 + (int)sVar1);
    uVar2 = 1;
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFXVol(0x15,0x40);
  }
  return uVar2;
}



/* ---- DrawSlider  [FEMENU.CPP:665-761] SLD-VERIFIED ---- */

/* WARNING: Unable to use type for symbol pkt2 */
/* WARNING: Unable to use type for symbol pkt */
/* WARNING: Unable to use type for symbol tp3 */
/* Decoded Phase 84: DrawSlider(short, short, short, short, short, short, short, short, short, bool,
   short, short) - menu slider widget (1464 B, 8 callers - hot). Common across all left/right/audio
   sliders.
   
   [ghidra-meta] section: front.text
   
   [Locals 2026-05-09] Locals renamed via deep-body inspection. DrawSlider - menu slider widget(1464B, 8 callers - hot, used by every audio/option/sensitivity slider). Renders N rectangles at(fX..fX+fWidth) along the slider track, each rectwidth wide with rectspace gap. Each rect's color
   interpolates: ticks under the active value get a red→yellow→green gradient computed via 3
   trap-guarded fixed-point divides (0xbe/0x7c/-0xd2 R/G/B coefficients); ticks beyond active fall
   to a static dark-blue 0x280f00. CalcFadeVal applies fSelFade master fade. The reverse param flips
   render direction (right-anchor vs left-anchor track). amountWidth = the lit-rectangle span based
   on (value - min)/(max - min). shadow=true switches to a 1-color shadow-only render path(myDarkBlue=0x0a). Renders 2 separate 24-bit-stitch loops for forward vs reverse path.
   
   [Locals 2026-05-10 bulk] Bulk-renamed Ghidra SSA temps to type-hinted user-names (ti=int,
   tu=u_int, ts=short, tb=u_char, tstr=char*, tp=void*, etc.) for audit cleanliness. Generic but
   preserves type info; these are minor secondary-effect register temps that did not warrant
   individual semantic naming. */

void DrawSlider(short value,short min,short max,short fX,short fY,short fWidth,short fHeight,
               short rectwidth,short rectspace,bool reverse,bool shadow,short fSelFade,
               short fFadeVal)

{
  short sVar1;
  int tickFadeColor;
  int tickColor;
  int interp_color;
  int x_pack;
  int iVar2;
  int tu2;
  int ti6;
  int col1;
  int rel_x;
  int ti5;
  int ti2;
  int ti7;
  int amount;
  short ts7;
  int ti8;
  int amountWidth;
  int shiftAmount;
  int endX_minus1;
  short tickX;
  int shadowColor;
  int amount_00;
  short loc_60;
  short loc_58;
  short width;
  short factor;
  short ts1;
  u_char *tp4;
  u_char *pkt2;
  u_char bVar1;
  short ts2;
  u_int *pkt;
  u_int *tp3;
  
  sVar1 = fWidth;
  fWidth = (u_int)(u_short)fWidth;
  x_pack = (int)(u_short)fX;
  amountWidth = (int)sVar1;
  iVar2 = ((int)value - (int)min) * amountWidth;
  ti8 = (int)max - (int)min;
  amount_00 = iVar2 / ti8;
  amount = (int)fSelFade;
  bVar1 = amount == 0;
  shiftAmount = (int)bVar1;
  ts7 = (short)amount_00;
  if (reverse == 0) {
    rel_x = (int)fX;
    pkt = (u_int *)Render_gPacketPtr;
    tp3 = (u_int *)Render_gPalettePtr;
    iVar2 = rel_x;
    while (Render_gPalettePtr = (u_char *)tp3, Render_gPacketPtr = (u_char *)pkt,
          iVar2 < rel_x + amountWidth) {
      *pkt = *pkt & 0xff000000 | *tp3 & 0xffffff;
      Render_gPacketPtr = (u_char *)(pkt + 6);
      *tp3 = *tp3 & 0xff000000 | (u_int)pkt & 0xffffff;
      ts2 = (short)x_pack;
      *(short *)(pkt + 2) = ts2;
      *(short *)((int)pkt + 10) = fY;
      *(short *)(pkt + 3) = ts2 + rectwidth;
      *(short *)((int)pkt + 0xe) = fY;
      *(short *)(pkt + 4) = ts2;
      *(short *)(pkt + 5) = ts2 + rectwidth;
      *(short *)((int)pkt + 0x12) = fY + fHeight;
      *(short *)((int)pkt + 0x16) = fY + fHeight;
      tickColor = 0;
      if (shadow == 0) {
        if ((int)ts2 < rel_x + ts7) {
          if (amount == 0) {
            interp_color = 0xc83c1e;
          }
          else {
            ti5 = ts2 - rel_x;
            amount_00 = amount;
            interp_color = CalcFadeVal(0xc83c1e,((ti5 * -0xd2) / amountWidth + 0xd2 >> shiftAmount)
                                               << 0x10 | (((ti5 * 0x7c) / amountWidth + 0x42 >>
                                                          shiftAmount) << 0x10) >> 8 |
                                               (int)(short)((ti5 * 0xbe) / amountWidth >>
                                                           shiftAmount),amount);
          }
        }
        else {
          interp_color = 0x280f00;
        }
        tickColor = CalcFadeVal(interp_color,amount_00);
      }
      pkt[1] = tickColor;
      SetPolyF4((POLY_F4 *)pkt);
      SetSemiTrans(pkt,0);
      x_pack = x_pack + (u_int)(u_short)rectwidth + (u_int)(u_short)rectspace;
      pkt = (u_int *)Render_gPacketPtr;
      tp3 = (u_int *)Render_gPalettePtr;
      iVar2 = x_pack * 0x10000 >> 0x10;
    }
  }
  else {
    iVar2 = x_pack + fWidth + -1;
    ti2 = (x_pack << 0x10) >> 0x10;
    if (x_pack << 0x10 <= iVar2 * 0x10000) {
      endX_minus1 = ti2 + amountWidth;
      do {
        pkt2 = Render_gPacketPtr;
        tp4 = Render_gPalettePtr;
        *(u_int *)Render_gPacketPtr =
             *(u_int *)Render_gPacketPtr & 0xff000000 | *(u_int *)Render_gPalettePtr & 0xffffff;
        tu2 = (u_int)Render_gPacketPtr & 0xffffff;
        Render_gPacketPtr = Render_gPacketPtr + 0x18;
        *(u_int *)tp4 = *(u_int *)tp4 & 0xff000000 | tu2;
        ts1 = (short)iVar2;
        *(short *)(pkt2 + 8) = ts1;
        *(short *)(pkt2 + 10) = fY;
        *(short *)(pkt2 + 0xc) = ts1 + rectwidth;
        *(short *)(pkt2 + 0xe) = fY;
        *(short *)(pkt2 + 0x10) = ts1;
        *(short *)(pkt2 + 0x14) = ts1 + rectwidth;
        *(short *)(pkt2 + 0x12) = fY + fHeight;
        *(short *)(pkt2 + 0x16) = fY + fHeight;
        ti6 = 0;
        if (shadow == 0) {
          if ((int)ts1 < endX_minus1 - ts7) {
            col1 = 0x280f00;
          }
          else {
            ti7 = endX_minus1 - ts1;
            if (amount == 0) {
              col1 = 0xc83c1e;
            }
            else {
              amount_00 = amount;
              col1 = CalcFadeVal(0xc83c1e,((ti7 * -0xd2) / amountWidth + 0xd2 >> bVar1) << 0x10 |
                                         (((ti7 * 0x7c) / amountWidth + 0x42 >> bVar1) << 0x10) >> 8
                                         | (int)(short)((ti7 * 0xbe) / amountWidth >> bVar1),amount)
              ;
            }
          }
          ti6 = CalcFadeVal(col1,amount_00);
        }
        *(int *)(pkt2 + 4) = ti6;
        SetPolyF4((POLY_F4 *)pkt2);
        SetSemiTrans(pkt2,0);
        iVar2 = iVar2 - ((u_int)(u_short)rectwidth + (u_int)(u_short)rectspace);
      } while (ti2 <= iVar2 * 0x10000 >> 0x10);
    }
  }
  return;
}



/* ---- tMenuItemLeftRightSlider::Draw  [FEMENU.CPP:853-864] SLD-VERIFIED ---- */

void tMenuItemLeftRightSlider::Draw(bool selected)

{
  u_short uVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [6];
  u_int wordnum;
  short fSelFade;
  
  if (this->fX == 0 && this->fY == 0) {
    iVar2 = TextSys_WordX((this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription);
    wordnum = (this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription;
    this->fX = (short)iVar2;
    iVar2 = TextSys_WordY(wordnum);
    this->fY = (short)iVar2;
  }
  FETextRender_MenuTextPositioned((short)(this->_base_tMenuItemInteractive)._base_tMenuItem.fTextDescription,this->fX + 8,
             this->fY + 3,(tMenuTextState)(selected != 0),textType_Options);
  pa_Var3 = this->fData->_vf;
  uVar1 = (*(*pa_Var3)[2].pfn)
                    ((char *)this->fData + (int)(*pa_Var3)[2].delta,0xffffffff);
  if (selected == 0) {
    fSelFade = 0;
  }
  else {
    fSelFade = 0x80;
  }
  DrawSlider(uVar1 & 0xff,(u_short)(u_char)this->fData->fMinValue,(u_short)(u_char)this->fData->fMaxValue,
             this->fX + 0x73,this->fY + 4,this->fWidth,this->fHeight,6,4,false,0,fSelFade,0);
  return;
}



/* ---- tMenuItemLeftRightSlider::SetDimensions  [FEMENU.CPP:868-873] SLD-VERIFIED ---- */

void tMenuItemLeftRightSlider::SetDimensions(short x,short y,short width,short height)

{
  this->fX = x;
  this->fY = y;
  this->fWidth = width;
  this->fHeight = height;
  return;
}



/* ---- tMenuItemGoToMenuButton::ctor  [FEMENU.CPP:881-884] SLD-VERIFIED ---- */

tMenuItemGoToMenuButton::tMenuItemGoToMenuButton(u_int textDescription,tMenu *newMenu,
              void (*OnButtonPress)(tMenuCommand&))
  : _base_tMenuItemInteractive(textDescription)
{
  
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemGoToMenuButton_vtable;
  (this->_base_tMenuItemInteractive)._base_tMenuItem.fNewMenu = newMenu;
  this->fOnButtonPress = (void *)OnButtonPress;
  return;
}



/* ---- tMenuItemGoToMenuButton::dtor  [FEMENU.CPP:888-888] SLD-VERIFIED ---- */

tMenuItemGoToMenuButton::~tMenuItemGoToMenuButton()

{
  *(void **)&((this->_base_tMenuItemInteractive)._base_tMenuItem._vf) = (void *)tMenuItemGoToMenuButton_vtable;
  return;
}



/* ---- tMenuItemGoToMenuButton::ProcessInput  [FEMENU.CPP:897-926] SLD-VERIFIED ---- */

int tMenuItemGoToMenuButton::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  u_int uVar1;
  u_int uVar2;
  void *reg_a3;
  
  uVar2 = (this->_base_tMenuItemInteractive)._base_tMenuItem.fFlags;
  uVar1 = uVar2 & 1;
  if (uVar1 == 0) {
    uVar1 = 2;
    if (keyval == kInput_KeyType_Cross) {
      if ((this->_base_tMenuItemInteractive)._base_tMenuItem.fNewMenu != (tMenu *)0x0) {
        if ((uVar2 & 0x40) == 0) {
          command.type = kMenu_Command_GoToMenu;
        }
        else {
          command.type = kMenu_Command_GoToMenuOneWay;
        }
        command.nextMenu = (this->_base_tMenuItemInteractive)._base_tMenuItem.fNewMenu;
      }
      if (this->fOnButtonPress != (void *)0x0) {
        ((void(*)(tMenuCommand&))this->fOnButtonPress)(command);
      }
      uVar1 = 1;
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  return uVar1;
}



/* ---- tMenu::tMenuConstructor  [FEMENU.CPP:966-980] SLD-VERIFIED ---- */

void tMenu::tMenuConstructor(tMenuItem *firstItem,void *ap)

{
  int i;
  tMenuItem *p;
  tMenuItem *ptVar1;
  
  i = 0;
  this->VertHelp = 0;
  this->fItemList[0] = firstItem;
  while (1) {
    ap = (int *)((int)ap + 4);
    ptVar1 = ((tMenuItem **)ap)[-1];
    this->fItemList[i + 1] = ptVar1;
    if (ptVar1 == (tMenuItem *)0x0) break;
    i = i + 1;
  }
  return;
}



/* ---- tMenu::ctor  [FEMENU.CPP:1009-1018] SLD-VERIFIED ---- */

tMenu::tMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu,
                void (*OnButtonPress)(tMenuCommand&),short title)

{
  *(void **)&(this->_vf) = (void *)tMenu_vtable;
  this->fFlags = flags;
  this->fCurrentItem = 0;
  this->fScreen = screenHandler;
  this->fNextMenu = nextMenu;
  this->fNeverAnyEnabled = 0;
  this->fChildMenu = (tMenu *)0x0;
  this->fOptionsMenu = optionsMenu;
  this->fOnButtonPress = (void *)OnButtonPress;
  this->fTitle = title;
  return;
}



/* ---- tMenu::dtor  [FEMENU.CPP:1022-1022] SLD-VERIFIED ---- */

tMenu::~tMenu()

{
  *(void **)&(this->_vf) = (void *)tMenu_vtable;
  return;
}



/* ---- tMenu::Initialize  [FEMENU.CPP:1026-1044] SLD-VERIFIED ---- */

void tMenu::Initialize()

{
  int iVar1;
  int iVar2;
  int original;
  
  iVar1 = this->fCurrentItem;
  if (((this->fItemList[iVar1]->fFlags ^ 1) & 1) == 0) {
    original = iVar1;
    do {
      iVar2 = this->fCurrentItem;
      if ((this->fItemList[iVar2]->fFlags & 1) == 0) {
        return;
      }
      this->fCurrentItem = iVar2 + 1;
      if (this->fItemList[iVar2 + 1] == (tMenuItem *)0x0) {
        this->fCurrentItem = 0;
      }
    } while (original != this->fCurrentItem);
  }
  return;
}



/* ---- tMenu::ProcessInput  [FEMENU.CPP:1047-1177] SLD-VERIFIED ---- */

void tMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  int iVar1;
  tMenuCommandType tVar2;
  tMenuItem *ptVar3;
  tInputKeyType tVar4;
  int lastItem;
  int iVar5;
  
  if (((this->fFlags & 4) != 0) && (keyval == kInput_KeyType_Start)) {
    keyval = kInput_KeyType_Cross;
  }
  if (((this->fFlags & 0x10000) != 0) && (keyval == kInput_KeyType_Cross)) {
    keyval = kInput_KeyType_Start;
  }
  ptVar3 = this->fItemList[this->fCurrentItem];
  if (ptVar3 != (tMenuItem *)0x0) {
    lastItem = (int)(*ptVar3->_vf)[3].delta;
    (*(*ptVar3->_vf)[3].pfn)((char *)ptVar3 + lastItem,fromPlayer,&keyval,&command);
  }
  tVar4 = keyval;
  if (tVar4 == kInput_KeyType_Triangle) {
    tVar2 = kMenu_Command_BackupMenu;
  }
  else {
    if ((int)tVar4 < 0x11) {
      if (tVar4 == kInput_KeyType_Circle) {
        DisplayHelp(FEApp,0);
        return;
      }
      if ((int)tVar4 < 5) {
        if (tVar4 != kInput_KeyType_Cross) {
          return;
        }
        if (this->fNextMenu == (tMenu *)0x0) {
          return;
        }
        command.type = kMenu_Command_GoToMenu;
        command.nextMenu = this->fNextMenu;
      }
      else {
        if (tVar4 != kInput_KeyType_Square) {
          return;
        }
        if (this->fOptionsMenu == (tMenu *)0x0) {
          return;
        }
        command.type = kMenu_Command_GoToMenu;
        command.nextMenu = this->fOptionsMenu;
      }
      keyval = kInput_KeyType_AlreadyProcessed;
      return;
    }
    if (tVar4 == kInput_KeyType_Down) {
      iVar5 = this->fCurrentItem;
      do {
        iVar1 = this->fCurrentItem;
        this->fCurrentItem = iVar1 + 1;
        if (this->fItemList[iVar1 + 1] == (tMenuItem *)0x0) {
          this->fCurrentItem = 0;
        }
      } while ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0);
      if (this->fCurrentItem != iVar5) {
        AudioCmn_PlayFESFX(4);
      }
      goto MItemProcInp_setProcessed;
    }
    if ((int)tVar4 < 0x401) {
      if (tVar4 != kInput_KeyType_Up) {
        return;
      }
      iVar5 = this->fCurrentItem;
      do {
        iVar1 = this->fCurrentItem;
        if (iVar1 < 1) {
          ptVar3 = this->fItemList[iVar1 + 1];
          while (ptVar3 != (tMenuItem *)0x0) {
            iVar1 = this->fCurrentItem;
            this->fCurrentItem = iVar1 + 1;
            ptVar3 = this->fItemList[iVar1 + 2];
          }
        }
        else {
          this->fCurrentItem = iVar1 + -1;
        }
      } while ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0);
      if (this->fCurrentItem != iVar5) {
        AudioCmn_PlayFESFX(3);
      }
      goto MItemProcInp_setProcessed;
    }
    if (tVar4 != kInput_KeyType_Start) {
      return;
    }
    if (this->fOnButtonPress != (void *)0x0) {
      ((void(*)(tMenuCommand&))this->fOnButtonPress)(command);
      goto MItemProcInp_setProcessed;
    }
    tVar2 = kMenu_Command_StartRace;
    if ((this->fFlags & 1) == 0) {
      if ((this->fFlags & 2) == 0) {
        return;
      }
      command.type = kMenu_Command_Start2PlayerRace;
      goto MItemProcInp_setProcessed;
    }
  }
  command.type = tVar2;
MItemProcInp_setProcessed:
  keyval = kInput_KeyType_AlreadyProcessed;
  return;
}



/* ---- tMenu::GetNumberEnabledItems  [FEMENU.CPP:1195-1208] SLD-VERIFIED ---- */

short tMenu::GetNumberEnabledItems()

{
  u_int *puVar1;
  short i;
  int iVar2;
  short sVar3;
  short result;
  
  sVar3 = 0;
  if (this->fNeverAnyEnabled != 0) {
    return 0;
  }
  iVar2 = 0;
  while (puVar1 = (u_int *)this->fItemList[(short)iVar2], puVar1 != (u_int *)0x0
        ) {
    if (((*puVar1 ^ 1) & 1) != 0) {
      sVar3 = sVar3 + 1;
    }
    iVar2 = iVar2 + 1;
  }
  return sVar3;
}



/* ---- tMenu::Draw  [FEMENU.CPP:1217-1222] SLD-VERIFIED ---- */

void tMenu::Draw()

{
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  short item;

  if (-1 < this->fTitle) {
    FETextRender_Title(this->fTitle);
  }
  item = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pa_Var2 = this->fItemList[item]->_vf;
    (*(*pa_Var2)[4].pfn)
              ((char *)this->fItemList[item] + (int)(*pa_Var2)[4].delta,
               (int)item == this->fCurrentItem);
    item = item + 1;
    ptVar1 = this->fItemList[item];
  }
  return;
}



/* ---- tMenu::UpdateTransition  [FEMENU.CPP:1226-1231] SLD-VERIFIED ---- */

void tMenu::UpdateTransition()

{
  tMenuItem *ptVar1;
  __vtbl_ptr_type (*pa_Var2) [11];
  short item;
  int iVar3;
  
  iVar3 = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pa_Var2 = this->fItemList[(short)iVar3]->_vf;
    (*(*pa_Var2)[10].pfn)
              ((char *)this->fItemList[(short)iVar3] + (int)(*pa_Var2)[10].delta,
               this->fCurrentItem == (int)(short)iVar3);
    iVar3 = iVar3 + 1;
    ptVar1 = this->fItemList[(short)iVar3];
  }
  return;
}



/* ---- tMenu::TransitionOff  [FEMENU.CPP:1235-1236] SLD-VERIFIED ---- */

void tMenu::TransitionOff()

{
  return;
}



/* ---- tMenu::TransitionOn  [FEMENU.CPP:1239-1240] SLD-VERIFIED ---- */

void tMenu::TransitionOn()

{
  return;
}

/* ---- tMenuItem::TransitionOn / TransitionOff  @0x80025aa8 / @0x80025ab0 ----
 * empty base virtuals (overridden by tMenu); not separately reconstructed -- vtable-only
 * refs surfaced by #75 data-materialization. nfs4-f.exe = { jr $ra } (no-op). */
void tMenuItem::TransitionOn()  { return; }
void tMenuItem::TransitionOff() { return; }



/* ---- tMenu::TransitionIsFinished  [FEMENU.CPP:1243-1244] SLD-VERIFIED ---- */

void * tMenu::TransitionIsFinished()

{
  return (void *)0x1;
}



/* ---- tMenu::IsSubMenu  [FEMENU.CPP:1253-1254] SLD-VERIFIED ---- */

void * tMenu::IsSubMenu()

{
  return (void *)0x0;
}



/* ---- tMenu::DebounceKeys  [FEMENU.CPP:1258-1259] SLD-VERIFIED ---- */

long tMenu::DebounceKeys()

{
  __vtbl_ptr_type (*pa_Var1) [11];
  long lVar2;
  
  pa_Var1 = this->fItemList[this->fCurrentItem]->_vf;
  lVar2 = (*(*pa_Var1)[2].pfn)
                    ((char *)this->fItemList[this->fCurrentItem] + (int)(*pa_Var1)[2].delta);
  return lVar2;
}



/* end of femenu.cpp */
