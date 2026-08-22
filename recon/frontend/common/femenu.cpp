/* frontend/common/femenu.cpp -- RECONSTRUCTED (menu/iterator class hierarchy; C++ TU)
 *   71 fns across 12 classes: tListIterator(+Indexed/DoubleIndexed/MultiPlayer/Range/
 *   RangeIndexed) list iterators; tMenuItem(+Interactive/LeftRightChoice/LeftRightSlider/
 *   GoToMenuButton) menu items; tMenu container; + free DrawSlider (GPU slider widget).
 *   Member defs; base ctors via member-init-lists; manual _vf vtable dispatch; ref params.
 */
#include "femenu.h"

typedef struct tFEMenuPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tFEMenuPrimTag;

/* ---- FEMenu.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) ---- */
/* SYM-CARRIER: gMenu_SubMenuPlayer -- measured unsized-array spelling preserves retail addressing. */
tPlayer      gMenu_SubMenuPlayer[] = { (tPlayer)-1 };   /* @0x800517c0 -- unsized-array form (§3.12 #5) */


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

char tListIterator::Value(tPlayer)

{
  return (u_int)(u_char)*this->fValue;
}



/* ---- tListIterator::TextValue  [FEMENU.CPP:78-79] SLD-VERIFIED ---- */

short tListIterator::TextValue(tPlayer)

{
  return (int)this->fSelectionList[
      (*(*this->_vf)[2].pfn)((char *)this + (int)(*this->_vf)[2].delta,0xffffffff) & 0xff];
}



/* ---- tListIterator::Increment  [FEMENU.CPP:83-86] SLD-VERIFIED ---- */

void tListIterator::Increment(tPlayer)

{
  *this->fValue = *this->fValue + '\x01';
  if (this->fSelectionList[(u_char)*this->fValue] == 0) {
    *this->fValue = 0;
  }
}



/* ---- tListIterator::Decrement  [FEMENU.CPP:90-97] SLD-VERIFIED ---- */

void tListIterator::Decrement(tPlayer)

{
  /* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
     gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
  if (this->fValue[0] == '\0') {
    while (0 < (int)this->fSelectionList[this->fValue[0] + 1]) {
      this->fValue[0] = this->fValue[0] + 1;
    }
  }
  else {
    this->fValue[0] = this->fValue[0] - 1;
  }
}



/* ---- tListIteratorIndexed::ctor  [FEMENU.CPP:104-106] SLD-VERIFIED ---- */
tListIteratorIndexed::tListIteratorIndexed(short *selection,char *valPtr,char *index)
  : tListIterator(selection,valPtr)
{
  *(void **)&(this->_vf) = (void *)tListIteratorIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tListIteratorIndexed::dtor  [FEMENU.CPP:110-110] SLD-VERIFIED ---- */

tListIteratorIndexed::~tListIteratorIndexed()

{
  *(void **)&(this->_vf) = (void *)tListIteratorIndexed_vtable;
  return;
}



/* ---- tListIteratorIndexed::Value  [FEMENU.CPP:114-115] SLD-VERIFIED ---- */

char tListIteratorIndexed::Value(tPlayer)

{
  return (u_int)(u_char)this->fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorIndexed::TextValue  [FEMENU.CPP:119-120] SLD-VERIFIED ---- */

short tListIteratorIndexed::TextValue(tPlayer)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = this->_vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&this->fSelectionList + (int)(*pa_Var1)[2].delta,
                     0xffffffff);
  return (int)this->fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorIndexed::Increment  [FEMENU.CPP:126-129] SLD-VERIFIED ---- */

void tListIteratorIndexed::Increment(tPlayer)

{
  this->fValue[(u_char)*this->fIndex] =
      this->fValue[(u_char)*this->fIndex] + '\x01';
  if (this->fSelectionList[(u_char)this->fValue[(u_char)*this->fIndex]] == 0) {
    this->fValue[(u_char)*this->fIndex] = 0;
  }
}



/* ---- tListIteratorIndexed::Decrement  [FEMENU.CPP:133-140] SLD-VERIFIED ---- */

void tListIteratorIndexed::Decrement(tPlayer)

{
  /* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
     gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
  if (this->fValue[*this->fIndex] == '\0') {
    while (0 < (int)this->fSelectionList[this->fValue[*this->fIndex] + 1]) {
      this->fValue[*this->fIndex] = this->fValue[*this->fIndex] + 1;
    }
  }
  else {
    this->fValue[*this->fIndex] = this->fValue[*this->fIndex] - 1;
  }
}



/* ---- tListIteratorDoubleIndexed::dtor  [FEMENU.CPP:156-156] SLD-VERIFIED ---- */

tListIteratorDoubleIndexed::~tListIteratorDoubleIndexed()

{
  *(void **)&(this->_vf) = (void *)tListIteratorDoubleIndexed_vtable;
  return;
}



/* ---- tListIteratorDoubleIndexed::Value  [FEMENU.CPP:160-161] SLD-VERIFIED ---- */

char tListIteratorDoubleIndexed::Value(tPlayer)

{
  return (u_int)(u_char)this->fValue
                     [(u_int)(u_char)*this->fIndex1 * this->index1multiplier +
                      (u_int)(u_char)*this->fIndex2];
}



/* ---- tListIteratorDoubleIndexed::TextValue  [FEMENU.CPP:165-166] SLD-VERIFIED ---- */

short tListIteratorDoubleIndexed::TextValue(tPlayer)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = this->_vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&this->fSelectionList + (int)(*pa_Var1)[2].delta,
                     0xffffffff);
  return (int)this->fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorDoubleIndexed::Increment  [FEMENU.CPP:172-175] SLD-VERIFIED ---- */

void tListIteratorDoubleIndexed::Increment(tPlayer)

{
  this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier +
               (u_int)(u_char)*this->fIndex2] =
      this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier +
                   (u_int)(u_char)*this->fIndex2] + '\x01';
  if (this->fSelectionList[(u_char)this->fValue[
          (u_int)(u_char)*this->fIndex1 * this->index1multiplier +
          (u_int)(u_char)*this->fIndex2]] == 0) {
    this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier +
                 (u_int)(u_char)*this->fIndex2] = 0;
  }
}



/* ---- tListIteratorDoubleIndexed::Decrement  [FEMENU.CPP:179-186] SLD-VERIFIED ---- */

void tListIteratorDoubleIndexed::Decrement(tPlayer)

{
  /* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
     gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
  if (this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] == '\0') {
    while (0 < (int)this->fSelectionList
                    [this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] + 1]) {
      this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] =
           this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] + 1;
    }
  }
  else {
    this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] =
         this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] - 1;
  }
}



/* ---- tListIteratorMultiPlayer::dtor  [FEMENU.CPP:202-202] SLD-VERIFIED ---- */

tListIteratorMultiPlayer::~tListIteratorMultiPlayer()

{
  *(void **)&(this->_vf) = (void *)tListIteratorMultiPlayer_vtable;
  return;
}



/* ---- tListIteratorMultiPlayer::Value  [FEMENU.CPP:206-210] SLD-VERIFIED ---- */

char tListIteratorMultiPlayer::Value(tPlayer atIndex)

{
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  return this->fValue[atIndex];
}



/* ---- tListIteratorMultiPlayer::TextValue  [FEMENU.CPP:214-215] SLD-VERIFIED ---- */

short tListIteratorMultiPlayer::TextValue(tPlayer atIndex)

{
  __vtbl_ptr_type (*pa_Var1) [6];
  u_int uVar2;
  
  pa_Var1 = this->_vf;
  uVar2 = (*(*pa_Var1)[2].pfn)
                    ((int)&this->fSelectionList + (int)(*pa_Var1)[2].delta);
  return this->fSelectionList[uVar2 & 0xff];
}



/* ---- tListIteratorMultiPlayer::Increment  [FEMENU.CPP:221-227] SLD-VERIFIED ---- */

void tListIteratorMultiPlayer::Increment(tPlayer atIndex)

{
  char *pcVar1;
  u_char *pbVar2;
  
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  pcVar1 = this->fValue + atIndex;
  *pcVar1 = *pcVar1 + '\x01';
  pbVar2 = (u_char *)(this->fValue + atIndex);
  if (this->fSelectionList[*pbVar2] == 0) {
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
  pcVar3 = this->fValue;
  cVar1 = pcVar3[atIndex];
  if (cVar1 == '\0') {
    sVar2 = this->fSelectionList[(u_char)pcVar3[atIndex] + 1];
    while (0 < sVar2) {
      pcVar3[atIndex] = pcVar3[atIndex] + '\x01';
      pcVar3 = this->fValue;
      sVar2 = this->fSelectionList[(u_char)pcVar3[atIndex] + 1];
    }
    return;
  }
  pcVar3[atIndex] = cVar1 - 1;
  return;
}



/* ---- tListIteratorRange::ctor  [FEMENU.CPP:250-253] SLD-VERIFIED ---- */
tListIteratorRange::tListIteratorRange(char minValue,char maxValue,char *valPtr)
  : tListIterator((short *)0x0,valPtr)
{
  *(void **)&(this->_vf) = (void *)tListIteratorRange_vtable;
  this->fMinValue = minValue;
  this->fMaxValue = maxValue;
  return;
}



/* ---- tListIteratorRange::dtor  [FEMENU.CPP:257-257] SLD-VERIFIED ---- */

tListIteratorRange::~tListIteratorRange()

{
  *(void **)&(this->_vf) = (void *)tListIteratorRange_vtable;
  return;
}



/* ---- tListIteratorRange::Value  [FEMENU.CPP:262-266] SLD-VERIFIED ---- */

char tListIteratorRange::Value(tPlayer)

{
  return (u_int)(u_char)*this->fValue;
}



/* ---- tListIteratorRange::TextValue  [FEMENU.CPP:270-271] SLD-VERIFIED ---- */

short tListIteratorRange::TextValue(tPlayer)

{
  return 0;
}



/* ---- tListIteratorRange::Increment  [FEMENU.CPP:276-281] SLD-VERIFIED ---- */

void tListIteratorRange::Increment(tPlayer)

{
  if ((u_int)(u_char)*this->fValue < (u_char)this->fMaxValue) {
    *this->fValue = (u_char)*this->fValue + '\x01';
  }
  return;
}



/* ---- tListIteratorRange::Decrement  [FEMENU.CPP:285-290] SLD-VERIFIED ---- */

void tListIteratorRange::Decrement(tPlayer)

{
  if ((u_char)this->fMinValue < (u_int)(u_char)*this->fValue) {
    *this->fValue = (u_char)((u_int)(u_char)*this->fValue - 1);
  }
  return;
}



/* ---- tListIteratorRangeIndexed::ctor  [FEMENU.CPP:298-300] SLD-VERIFIED ---- */
tListIteratorRangeIndexed::tListIteratorRangeIndexed(char minValue,char maxValue,char *valPtr,char *index)
  : tListIteratorRange(minValue,maxValue,valPtr)
{
  
  *(void **)&(this->_vf) = (void *)tListIteratorRangeIndexed_vtable;
  this->fIndex = index;
  return;
}



/* ---- tListIteratorRangeIndexed::dtor  [FEMENU.CPP:304-304] SLD-VERIFIED ---- */

tListIteratorRangeIndexed::~tListIteratorRangeIndexed()

{
  *(void **)&(this->_vf) = (void *)tListIteratorRangeIndexed_vtable;
  return;
}



/* ---- tListIteratorRangeIndexed::Value  [FEMENU.CPP:308-309] SLD-VERIFIED ---- */

char tListIteratorRangeIndexed::Value(tPlayer)

{
  return (u_int)(u_char)this->fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorRangeIndexed::Increment  [FEMENU.CPP:313-315] SLD-VERIFIED ---- */

void tListIteratorRangeIndexed::Increment(tPlayer)

{
  if ((u_int)(u_char)this->fValue[(u_char)*this->fIndex] <
      (u_char)this->fMaxValue) {
    this->fValue[(u_char)*this->fIndex] =
        (u_char)this->fValue[(u_char)*this->fIndex] + '\x01';
  }
  return;
}



/* ---- tListIteratorRangeIndexed::Decrement  [FEMENU.CPP:319-321] SLD-VERIFIED ---- */

void tListIteratorRangeIndexed::Decrement(tPlayer)

{
  if ((u_char)this->fMinValue <
      (u_int)(u_char)this->fValue[(u_char)*this->fIndex]) {
    this->fValue[(u_char)*this->fIndex] =
        (u_char)((u_int)(u_char)this->fValue[(u_char)*this->fIndex] - 1);
  }
  return;
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

bool tMenuItem::TransitionIsFinished()

{
  return 1;
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

void tMenuItem::Draw(int x,int y,bool selected)

{
  (*(*this->_vf)[4].pfn)((char *)this + (int)(*this->_vf)[4].delta,
                         selected);
}



/* ---- tMenuItem::Draw  [FEMENU.CPP:486-487] SLD-VERIFIED ---- */

void tMenuItem::Draw(int x,int y,int w,bool selected)

{
  (*(*this->_vf)[6].pfn)((char *)this + (int)(*this->_vf)[6].delta,
                         selected,x,y,0);
}



/* ---- tMenuItemInteractive::ctor  [FEMENU.CPP:533-534] SLD-VERIFIED ---- */
tMenuItemInteractive::tMenuItemInteractive(u_int textDescription)
  : tMenuItem(textDescription)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemInteractive_vtable;
  return;
}



/* ---- tMenuItemInteractive::dtor  [FEMENU.CPP:538-538] SLD-VERIFIED ---- */

tMenuItemInteractive::~tMenuItemInteractive()

{
  *(void **)&(this->_vf) = (void *)tMenuItemInteractive_vtable;
  return;
}



/* ---- tMenuItemLeftRightChoice::ctor  [FEMENU.CPP:552-555] SLD-VERIFIED ---- */
tMenuItemLeftRightChoice::tMenuItemLeftRightChoice(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemInteractive(textDescription)
{
  u_int uVar1;
  
  uVar1 = this->fFlags;
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightChoice_vtable;
  this->fData = dataPtr;
  this->fFlags = uVar1 | 0x400;
  return;
}



/* ---- tMenuItemLeftRightChoice::dtor  [FEMENU.CPP:559-559] SLD-VERIFIED ---- */

tMenuItemLeftRightChoice::~tMenuItemLeftRightChoice()

{
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightChoice_vtable;
  return;
}



/* ---- tMenuItemLeftRightChoice::ProcessInput  [FEMENU.CPP:563-582] SLD-VERIFIED ---- */

void tMenuItemLeftRightChoice::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  u_int uVar1;
  __vtbl_ptr_type (*pa_Var2) [6];
  tListIterator *ptVar3;
  int SFXnum;
  /* MATCH: SYM fsize=32 for this fn but our frame computes 24 -- 8 bytes of
     retail frame have no named SYM local; this filler reproduces the SYM's
     own frame size (do not delete: frame size is part of the byte match). */
  int frameFiller[2];

  uVar1 = this->fFlags & 1;
  if (uVar1 != 0) {
    return;
  }
  switch (keyval) {
  case kInput_KeyType_Left:
    ptVar3 = this->fData;
    pa_Var2 = ptVar3->_vf;
    (*(*pa_Var2)[5].pfn)((char *)ptVar3 + (int)(*pa_Var2)[5].delta);
    SFXnum = 5;
    break;
  case kInput_KeyType_Right:
    ptVar3 = this->fData;
    pa_Var2 = ptVar3->_vf;
    (*(*pa_Var2)[4].pfn)((char *)ptVar3 + (int)(*pa_Var2)[4].delta);
    SFXnum = 6;
    break;
  default:
    return;
  }
  keyval = kInput_KeyType_AlreadyProcessed;
  AudioCmn_PlayFESFX(SFXnum);
  /* MATCH: retail falls off the end here -- no return-value materialization
     ($v0 is the AudioCmn_PlayFESFX leftover in the oracle). */
}



/* ---- tMenuItemLeftRightChoice::Draw  [FEMENU.CPP:590-605] SLD-VERIFIED ---- */

void tMenuItemLeftRightChoice::Draw(bool selected)

{
  short index;
  int iVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [6];
  tMenuTextState textState;

  iVar1 = TextSys_WordX(this->fTextDescription);
  iVar2 = TextSys_WordY(this->fTextDescription);
  textState = (tMenuTextState)(selected != 0);
  FETextRender_MenuTextPositioned((short)this->fTextDescription,(short)iVar1,
             (short)iVar2,textState,textType_Options);
  pa_Var3 = this->fData->_vf;
  index = (*(*pa_Var3)[3].pfn)
                    ((char *)this->fData + (int)(*pa_Var3)[3].delta,
                     gMenu_SubMenuPlayer[0]);
  FETextRender_MenuTextPositioned(index,(short)((u_int)((iVar1 + 0xb4) * 0x10000) >> 0x10),(short)iVar2,textState,
             textType_Options);
  return;
}



/* ---- tMenuItemLeftRightSlider::ctor  [FEMENU.CPP:612-616] SLD-VERIFIED ---- */
tMenuItemLeftRightSlider::tMenuItemLeftRightSlider(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemInteractive(textDescription)
{
  u_int uVar1;
  u_int uVar2;

  uVar1 = this->fFlags;
  this->fData = dataPtr;
  this->fFlags = uVar1 | 0x80;
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightSlider_vtable;
  uVar2 = this->fFlags;
  this->fFlags = uVar2 | 0x80;
  return;
}



/* ---- tMenuItemLeftRightSlider::dtor  [FEMENU.CPP:621-621] SLD-VERIFIED ---- */

tMenuItemLeftRightSlider::~tMenuItemLeftRightSlider()

{
  *(void **)&(this->_vf) = (void *)tMenuItemLeftRightSlider_vtable;
  return;
}



/* ---- tMenuItemLeftRightSlider::DebounceKeys  [FEMENU.CPP:625-626] SLD-VERIFIED ---- */

long tMenuItemLeftRightSlider::DebounceKeys()

{
  return 0x600;
}



/* ---- tMenuItemLeftRightSlider::ProcessInput  [FEMENU.CPP:630-650] SLD-VERIFIED ---- */

void tMenuItemLeftRightSlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  short sVar1;
  u_int uVar2;
  int (*pcVar3)(...);
  tListIterator *ptVar4;
  /* MATCH: SYM fsize frame filler -- see tMenuItemLeftRightChoice::ProcessInput. */
  int frameFiller[2];

  uVar2 = this->fFlags & 1;
  if (uVar2 != 0) {
    return;
  }
  switch (keyval) {
  case kInput_KeyType_Left:
    ptVar4 = this->fData;
    (*(*ptVar4->_vf)[5].pfn)((char *)ptVar4 + (int)(*ptVar4->_vf)[5].delta);
    break;
  case kInput_KeyType_Right:
    ptVar4 = this->fData;
    (*(*ptVar4->_vf)[4].pfn)((char *)ptVar4 + (int)(*ptVar4->_vf)[4].delta);
    break;
  default:
    return;
  }
  /* MATCH: this natural statement order produces retail's exact instruction set and
     register allocation.  GCC sched2 instead chooses li a1 for the call delay slot;
     the narrow build receipt restores retail's legal ordering by preparing a1 and
     the processed-key value before the jal, then placing this store in its slot. */
  AudioCmn_PlayFESFXVol(0x15,0x40);
  keyval = kInput_KeyType_AlreadyProcessed;
  /* MATCH: retail falls off the end (no return-value materialization). */
}



/* ---- DrawSlider  [FEMENU.CPP:665-761] SLD-VERIFIED ---- */

/* MATCH W59: 203 -> 169 diffs.  The natural non-volatile fSelFade parameter
   restores retail's direct incoming-slot loads; a reverse-arm value identity
   plus one read-only fence corrects the opening local-alloc handout (260 ->
   187), and keeping myDarkBlue live at the join fixes the s6/s7 tail (->169).
   Both asm templates are empty and name no hard register.  Measured rejects:
   non-volatile alone 260; identity fence 267; a second read-only fence 192;
   loop placement 244; forward volatile local 282; OR term/order shapes 293+.
   qtytrace is not authoritative here: instrumented cc1plus differs by d311. */
/* MATCH W63: 169 -> 168 diffs (375 -> 374 instructions; retail 366).  Writing
   the forward arm's two-stage fade as a nested call removes one intermediate
   result move while preserving the same calls and branch behavior. */
/* W59-A9 2026-08-14 -- THE PARM-READ-MODE QUESTION, ANSWERED (re-gated 168 @ 374/366).
   Method: census every incoming-slot load on BOTH sides (ours via tools/ourdis.py,
   retail via asm/nonmatchings/front/DrawSlider__FsssssssssbT9ss.s).

     slot   param        RETAIL              OURS
     0x80   fY           lhu x1              lhu x1
     0x84   fWidth       lh x1 AND lw x1     lh x1 AND lw x1     <- both dual-mode
     0x88   fHeight      lhu x1              lhu x1
     0x8C   rectwidth    lhu x1              lhu x1
     0x90   rectspace    lhu x1              lhu x1
     0x94   reverse      lw x1               lw x1
     0x98   shadow       lw x2               lw x2
     0x9C   fSelFade     lh x1  ONLY         lh x1 + lw x1       <- THE DELTA
     0xA0   fFadeVal     lhu x1              lhu x1

   So the two builds agree on the read mode of EVERY parameter except one, and the
   whole 374-vs-366 instruction surplus starts with ONE extra load: `lw $a1,0x9C($sp)`.

   MECHANISM (why two modes exist at all): the MIPS backend PROMOTES a stack-passed
   `short` argument to a word-mode home, so the incoming slot legitimately holds a
   sign-extended word.  gcc-2.8 therefore reads the SAME slot with `lh` for a HImode
   use and with `lw` for an SImode use, and cse never unifies the two (different
   modes => different MEMs).  0x84 shows this is normal: retail itself reads fWidth
   both ways (`lh` for the `(value-min)*fWidth` multiply, `lw` for a later int use).
   The bug is not "retail uses lh, we use lw" -- it is that OUR body contains an
   SImode use of fSelFade that retail's does not.

   WHERE OURS' SImode USE COMES FROM: the reverse arm caches the parameter
   (`reverseSelFade = fSelFade;`) and hands it to `CalcFadeVal(int,int,int)`, an
   int-typed callee -- an SImode read of a promoted short parm.  Retail reads
   0x9C exactly ONCE and that single `lh $a1` feeds ONLY the `sltiu $t1,$a1,1`
   that computes `factor = !fSelFade`, which is then spilled to 0x28($sp) and
   RE-READ (`lhu $t2,0x28($sp)`) at the shift sites.  After that `sltiu` the raw
   parameter value is DEAD in retail: the 3-arg `CalcFadeVal__Fiii` call in the
   reverse arm takes its fade in $s5, which is loaded at 0x80024F8C from $a1 in
   the reverse-arm preamble, not from the parameter slot.

   => NEXT ANGLE (structural, not a dial): re-derive the reverse arm so it consumes
   `factor` / the reverse-arm $s5 value instead of re-reading the parameter, i.e.
   remove the only SImode use of fSelFade.  Verify first WHAT retail's $s5 actually
   holds on that path (it is 0xFFFFFF in the forward arm -- a 24-bit stitch mask --
   and `addu $s5,$a1,$zero` in the reverse arm): if it is not fSelFade, our reverse
   arm is passing the wrong VALUE, which would make this a semantic correction
   rather than a codegen dial.  That check is the first thing the next worker
   should do; it is cheap and it decides the whole remaining 116-line diff.

   FALSIFIED HERE (each re-measured from the 168 base, none kept):
     - `reverseSelFade = factor;`  gates 165 but is SEMANTICALLY WRONG (factor is
       !fSelFade), recorded only so the number is not mistaken for a win;
     - dropping the W59 read-only fence, or re-pointing it at `factor` / `x1`, does
       not compile as a standalone edit: `reverseSelFade` is also read at the
       `if (reverseSelFade)` test and as the 3rd CalcFadeVal argument, so the local
       cannot simply be deleted -- the reverse arm has to be re-derived as a whole.
   NOTE for the instrument lane: C:/Temp/gcc-2.8.1-src/extracted/ carries only the
   pass files (cse.c, local-alloc.c, global.c, loop.c, reorg.c, sched.c, flow.c,
   jump.c, regclass.c, caller-save.c, toplev.c) -- expr.c and function.c
   (assign_parms, promote_mode) are NOT in that extraction, so the promotion rule
   above is stated from the emitted code, not cited to a line.

   W61-A16 2026-08-15 -- THE SPILL-SLOT=DECLARATION-ORDER LAW DOES NOT APPLY HERE
   (checked on request; re-gated 168 @ 374/366 before and after -- nothing landed).
   SYM 8c @0x80024c2c: fsize 112, mask 0xc0ff0000, AUTO map fHeight -0x60 => sp+16,
   rectspace -0x58 => sp+24, width -0x50 => sp+32, factor -0x48 => sp+40.  OUR build
   already emits sh/lhu at exactly 16/24/32/40(sp), and all ten callee-save slots
   (72..108) are identical, so there is NO offset permutation to fix; our fn-scope
   declaration order (prim, x1, width, factor, myDarkBlue, Col) already equals the
   SYM block order.  What the SYM DOES add to the W59-A9 finding above:
     - myDarkBlue is REG $0x1e = $fp and fFadeVal is REG $0x16 = $s6 in retail;
       ours puts myDarkBlue in $s6 and fFadeVal in $s4.  That 2-register rotation --
       not the frame -- is what makes the prologue read `sw s4,88(sp)` where retail
       has `sw fp,104(sp)`; the save-order diff is a CONSEQUENCE, not a cause.
     - fSelFade carries an ARG record but NO REG/AUTO home, confirming from the SYM
       side that retail never copied it anywhere: the single `lh` + the 0x28(sp)
       re-read of `factor` IS the retail shape.
   So the two open items are (1) delete our only SImode use of fSelFade [the count
   gap] and (2) re-price the myDarkBlue/fFadeVal rotation as a global-allocno tie.
   Frame/declaration dials are spent on this function.

   W71-A17 2026-08-21 -- 168 -> 161 @373/366 (three landings, each gated, whole-TU
   72/73 held).  All three came from reading the ORACLE'S BLOCK SHAPE rather than
   dialling the allocator:
     (1) FORWARD ARM SHAPE.  Retail's forward fade block is NOT the nested
         `CalcFadeVal(CalcFadeVal(...),fFadeVal)` the W63 note installed; both arms
         are the SAME shape -- a per-arm Col then ONE shared 2-arg call:
           @0x80024DD4 lw t2,0x38(sp); beqz t2,.L80024EF0 [ds: addu v0,fp,zero]
           ... jal CalcFadeVal__Fiii ... j .L80024F00 [ds: addu a0,v0,zero]
           .L80024EF0: j .L80024F00 [ds: addu a0,v0,zero]
           .L80024F00: jal CalcFadeVal__Fii
         i.e. `Col = myDarkBlue; if (fSelFade) Col = CalcFadeVal3(...);
               Col = CalcFadeVal(Col,fFadeVal);`  (the reverse arm's .L80025154 is
         the same tree with the myDarkBlue copy in its own block).  Nested form 168,
         if/else form 169, DEFAULT-THEN-OVERRIDE form 168 (fwd) then 167 (both arms).
     (2) THE PACKET-SLOT ADDRESS: a FUNCTION-SCOPE `u_char **pslot;` assigned at the
         top of each loop body (`pslot = (u_char **)0x1f800004;`) instead of the bare
         `Render_gPacketPtr` macro -- 167 -> 161.  With the macro, loop.c hoists the
         address AND reload SPILLS it to 52(sp) (`lui t2/ori t2,t2,4` + `sw t2,52(sp)`
         + two `lw t2,52(sp)` per iteration); with the named local the hoist lands in
         a callee-saved reg instead (s4), killing the spill/reload pair.
         *** THE NAMED REMAINING BLOCKER (one fact, both loops) ***
         Retail does NOT hoist it at all: `lui a1,0x1F80` sits in the BACK-EDGE delay
         slot (@0x80024F54) with `ori a1,a1,4` as the loop-top insn (@0x80024D28) --
         a per-iteration rematerialisation in a CALLER-saved reg (its live range never
         crosses a call).  That frees retail's $s4 for `factor`, which is why retail
         reads the shift count as `srav a3,a3,s4` where we pay `lhu t2,40(sp); addu
         v0,t2,zero` -- and why the whole saved-register band is rotated by one
         (ours s4=pslot,s5=0xFFFFFF,s6=myDarkBlue,fp=fSelFade vs retail
         s4=factor,s5=0xFFFFFF,s6=fFadeVal,s7=rectwidth,fp=myDarkBlue).
         => the wanted device is a SELECTIVE anti-LICM for THIS movable only: retail's
         loop.c still hoists 0xFFFFFF (preheader `lui s5;ori s5`) while declining
         0xFF000000 (in-loop `lui t2,65280`), so a blanket LICM kill is wrong.
         FALSIFIED here (each re-gated from 161, all reverted):
           block-scope pslot inside the loop body   260 @368 (the decl plants
             NOTE_INSN_BLOCK_BEG -> jump.c:2296 re-rotates the loop and every stack
             parm flips to lw+sll/sra);
           identity launder `__asm__("" : "+r"(pslot))` in-loop  467 @371;
           second (redundant) `pslot = ...` before the store    161 (cse deletes it);
           `u_char * volatile *pslot`                            161 (inert);
           read via the macro + write via pslot, and vice versa  161 (cse unifies);
           label+goto forward loop (full anti-LICM)             403 @369 -- and the
             address is STILL commoned into s3 by cse, so the goto only costs the
             parm-read modes;
           read-only fence on `factor` at the loop top (ref-step promote, both loops)
             163 @375; the same fence inside the `x1 < fX+width` arm 164 @374;
           read-only fence on `pslot` at the END of both loop bodies (live-range
             DEMOTE direction) 179 @373.
     (3) OR-CHAIN ORDER, FALSIFIED (do not retry): retail's stitch combines
         `or a1,a1,v1` (blue|green) then `or a1,a1,a3` (|red) while its three divides
         issue red,green,blue.  Re-spelling the OR as blue|green|red gates 311 and as
         red|(green|blue) gates 267 -- the divide order follows the source and
         dominates; the OR association is downstream noise, not the dial.
   Residual census at 161 (tools/opcen.py): lw 35v31, nop 26v23, sw 24v23, lhu 13v12,
   bnez 13v12, j 3v5, beqz 5v6 -- i.e. +7 insns, all traceable to the s4 occupancy
   above plus the forward loop's back-edge shape (retail `beqz OUT; nop; j TOP [ds:
   lui a1]`, ours `bnez TOP`).

   W72-A5 2026-08-22 -- THE SELECTIVE ANTI-LICM IS NAMED AND SOURCE-CITED
   (re-baselined 161 @373/366; NOT landed -- every reachable spelling of the
   device costs more than the 7 insns it buys.  Read this before touching the
   loops again.)

   THE MECHANISM, read out of gcc-2.8.1 loop.c (C:/Temp/gcc-2.8.1-src/extracted)
   and confirmed against a real CC1PLPSX -dL dump of THIS function
   (tools/rtl_dump.py; scratch/rtl/femenu.i.loop):

   scan_loop() only ever BUILDS a movable when one of three conditions holds
   (loop.c:691-703):
       (1) ! maybe_never && ! loop_reg_used_before_p(...)
       (2) ! REG_USERVAR_P (SET_DEST) && ! REG_LOOP_TEST_P (SET_DEST)
       (3) reg_in_basic_block_p (p, SET_DEST)
   and `maybe_never` is set to 1 by loop.c:922-931 at the FIRST CODE_LABEL or
   JUMP_INSN the scan meets -- which is `scan_start` ITSELF, because scan_loop
   REQUIRES scan_start to be a CODE_LABEL (loop.c:569-578; otherwise the loop is
   reported "phony" and LICM is skipped entirely).  The ONLY thing that clears it
   again is a NOTE_INSN_LOOP_VTOP at loop_depth 0 (loop.c:936-938) -- the note gcc
   plants at the virtual top of a ROTATED loop.
   => A ROTATED loop (bottom test, `bnez TOP` back-edge) resets maybe_never to 0
      and therefore lets condition (1) admit EVERY loop-invariant set, INCLUDING
      sets of NAMED USER VARIABLES.  An UN-ROTATED loop (top test + unconditional
      `j TOP` back-edge) has no VTOP note, so maybe_never stays 1 for the whole
      body and condition (1) NEVER fires -- leaving only (2) [anonymous compiler
      temps] and (3) [single-basic-block regs] to admit a movable.
   THAT is the inverse of the 21B-3 born-in-the-loop law, and it is SELECTIVE BY
   CONSTRUCTION -- which is exactly the split retail shows:
       0x00FFFFFF  = an anonymous cse temp -> condition (2) holds -> HOISTED
                     (retail preheader `lui s5 / ori s5` @0x80024D08-0C)
       0x1F800004  = held in a NAMED pointer used in BOTH arms -> (2) fails
                     (REG_USERVAR_P), (3) fails (reg_in_basic_block_p returns 0 as
                     soon as REGNO_FIRST_UID is in the other arm, loop.c:1071),
                     (1) fails (maybe_never) -> NO MOVABLE -> per-iteration remat
       0xFF000000  = anonymous temp, life 2, savings 2 -> movable, but declined by
                     the COST test below; retail `lui t2,65280` in-loop @0x80024D2C
   Our -dL reproduces the cost side exactly: threshold = (loop_has_call ? 1 : 2)
   * (1 + n_non_fixed_regs) = 30 here (solved from three dump rows -- life 5 /
   savings 1 declined, life 8 / savings 4 moved, life 22 / savings 2 declined after
   seven moves at -3 each), and the move test is
   `threshold * savings * lifetime >= insn_count` (loop.c:1640) with insn_count
   113/115.  Our packet-slot rows are
       Insn 445: regno 105 (life 189), global move-insn savings 1  moved to 775
       Insn 128: regno 105 (life 320), global move-insn savings 1 halved since
                 already moved  moved to 788
   -- savings 1, so it would need lifetime <= 3 to be declined on COST, and
   m->lifetime is the FUNCTION-WIDE luid span (loop.c:793), which for a variable
   used in both arms is 189/320.  The cost route is therefore unreachable here;
   only the maybe_never route is.

   PROOF THE ROUTE WORKS (measured, then reverted): un-rotating BOTH loops as
   `while (1) { if (!(cond)) break; ... }` removes the movable outright -- the -dL
   row for regno 105 disappears and is replaced by
       Insn 461: possible biv, reg 105, const = 528482308
   i.e. the 0x1F800004 address is now rematerialised per iteration, which IS
   retail's shape.  (Retail's `ori $a1,$a1,4` is the loop-top insn @0x80024D28 and
   the `lui $a1,0x1F80` sits in the back-edge delay slot @0x80024F54 with a copy in
   the entry block @0x80024D24 -- an UN-hoisted 2-insn `li` whose high half reorg
   stole into the `j` slot.  It is NOT a hoisted constant, and the low half is
   `ori`, not `addiu`, so it is a `li` constant and not an `la` address, per
   methodology 3.16.)

   WHY IT IS NOT LANDED -- the un-rotation is not free, and its collateral is
   larger than the 7-insn surplus it removes.  All re-gated from the 161 base:
       both loops un-rotated (break)             332 @360, frame 104
       both loops un-rotated (goto shared tail)  332 @360, frame 104  -- IDENTICAL
                                                 to break (jump.c canonicalises the
                                                 two at that position)
       forward loop only                         329 @371
       reverse loop only                         299 @367
       read-only fence on `pslot` placed BEFORE its set inside both loop bodies
         (the zero-insn way to make loop_reg_used_before_p return 1 and break
          condition (1) WITHOUT touching the rotation)   331 @375, frame 120 --
          the fence forces pslot live-in to the loop, so gcc materialises the
          address in the preheader anyway AND grows the frame.  Route closed.
   The un-rotated basin loses 8 frame bytes (104 vs the SYM fsize 112) and flips
   every stack-parameter read from `lh` to `lw + sll/sra` -- the same collateral the
   W71 block-scope and goto-loop probes recorded.  tools/opcen.py makes the
   comparison honest: the 161 basin diverges on SEVEN opcode classes
   (beqz 5v6, bnez 13v12, j 3v5, lhu 13v12, lw 35v31, nop 26v23, sw 24v23 = +7),
   while the reverse-only un-rotated basin diverges on ELEVEN -- it additionally
   loses addu 37v39, sll 34v36, slt 5v6, sra 16v17.  Count parity improves,
   structure does not, so the 161 basin is kept.

   THE NEXT WORKER'S TASK IS NOW SHARP, AND IT IS NOT "find the anti-LICM":
   the anti-LICM IS the un-rotation.  What has to be solved WITH it is the loop
   ENTRY / BLOCK ORDER, and retail hands that over too:
     - retail's forward loop IS zero-trip-guarded (`slt $v0,$v1,$a0; beqz $v0,
       .L800251B4` @0x80024CFC-D00, so duplicate_loop_exit_test DID run) yet its
       back edge is the UN-inverted `beqz .L800251B4; nop; j .L80024D28`, because
       jump.c's jump-around-jump inversion only fires when the exit label DIRECTLY
       follows the `j`.  In retail the next label is the ELSE ARM (.L80024F58) and
       the loop's exit runs all the way to the shared function tail (.L800251B4).
       Ours inverts to `bnez TOP`, so our exit label sits immediately after the loop.
     - so the wanted shape is a guarded, un-rotated loop whose exit jumps to the
       FUNCTION TAIL past the other arm: reproduce retail's BLOCK ORDER first (the
       13D/16C family), and only then re-measure the frame and the parm-read modes.
       A plain `goto` to a label at the end of the function was already tried and is
       byte-identical to `break` at that position, so the block-order dial has to
       come from the ARM layout, not from the loop keyword.
   Instruments for that pass: tools/rtl_dump.py -dL (the movable table above is the
   ground truth for any hoist claim), the instrumented cc1 at
   C:/Temp/nfs4-instr-cc1 for [find_free_reg]/[qty_order] once the shape is right,
   and tools/opcen.py plus the frame size (SYM fsize 112) as the go/no-go metric --
   the gate's LCS number is NON-MONOTONE across a frame-size change (every sp
   displacement shifts by 8) and must not be used to compare these basins. */

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
               short rectwidth,short rectspace,bool reverse,bool shadow,
               short fSelFade,
               short fFadeVal)

{
  POLY_F4 *prim;
  u_char **pslot;
  short x1;
  short width;
  short factor;
  int myDarkBlue;
  int Col;

  factor = !fSelFade;
  myDarkBlue = 0xc83c1e;
  width = ((value - min) * fWidth) / (max - min);
  if (!reverse) {
    x1 = fX;
    while (x1 < fX + fWidth) {
      pslot = (u_char **)0x1f800004;
      prim = (POLY_F4 *)*pslot;
      ((tFEMenuPrimTag *)prim)->addr = ((tFEMenuPrimTag *)Render_gPalettePtr)->addr;
      *pslot = (u_char *)prim + 0x18;
      ((tFEMenuPrimTag *)Render_gPalettePtr)->addr = (u_int)prim;
      prim->x0 = x1;
      prim->y0 = fY;
      prim->x1 = x1 + rectwidth;
      prim->y1 = fY;
      prim->x2 = x1;
      prim->y2 = fY + fHeight;
      prim->x3 = x1 + rectwidth;
      prim->y3 = fY + fHeight;
      Col = 0;
      if (!shadow) {
        /* MATCH: duplicated fade call sites cross-jump to retail's shared tail. */
        if (x1 < fX + width) {
          Col = myDarkBlue;
          if (fSelFade) {
            Col = CalcFadeVal(myDarkBlue,
                    (short)((((x1 - fX) * 0xbe) / fWidth) >> factor) |
                    (((((x1 - fX) * 0x7c) / fWidth + 0x42) >> factor) << 16) >> 8 |
                    ((((x1 - fX) * -0xd2) / fWidth + 0xd2) >> factor) << 16,fSelFade);
          }
          Col = CalcFadeVal(Col,fFadeVal);
        }
        else {
          Col = CalcFadeVal(0x280f00,fFadeVal);
        }
      }
      *(int *)((u_char *)prim + 4) = Col;
      SetPolyF4(prim);
      SetSemiTrans(prim,0);
      x1 += rectwidth + rectspace;
    }
  }
  else {
    short reverseSelFade;

    reverseSelFade = fSelFade;
    x1 = fX + fWidth - 1;
    __asm__("" : : "r"(reverseSelFade));
    while (fX <= x1) {
      pslot = (u_char **)0x1f800004;
      prim = (POLY_F4 *)*pslot;
      ((tFEMenuPrimTag *)prim)->addr = ((tFEMenuPrimTag *)Render_gPalettePtr)->addr;
      *pslot = (u_char *)prim + 0x18;
      ((tFEMenuPrimTag *)Render_gPalettePtr)->addr = (u_int)prim;
      prim->x0 = x1;
      prim->y0 = fY;
      prim->x1 = x1 + rectwidth;
      prim->y1 = fY;
      prim->x2 = x1;
      prim->y2 = fY + fHeight;
      prim->x3 = x1 + rectwidth;
      prim->y3 = fY + fHeight;
      Col = 0;
      if (!shadow) {
        /* MATCH: duplicated fade call sites cross-jump to retail's shared tail. */
        if (x1 >= fX + fWidth - width) {
          Col = myDarkBlue;
          if (reverseSelFade) {
            Col = CalcFadeVal(myDarkBlue,
                (short)((((fX + fWidth - x1) * 0xbe) / fWidth) >> factor) |
                (((((fX + fWidth - x1) * 0x7c) / fWidth + 0x42) >> factor) << 16) >> 8 |
                ((((fX + fWidth - x1) * -0xd2) / fWidth + 0xd2) >> factor) << 16,reverseSelFade);
          }
          Col = CalcFadeVal(Col,fFadeVal);
        }
        else {
          Col = CalcFadeVal(0x280f00,fFadeVal);
        }
      }
      *(int *)((u_char *)prim + 4) = Col;
      SetPolyF4(prim);
      SetSemiTrans(prim,0);
      x1 -= rectwidth + rectspace;
    }
  }
  __asm__("" : : "r"(myDarkBlue));
}



/* ---- tMenuItemLeftRightSlider::Draw  [FEMENU.CPP:853-864] SLD-VERIFIED ---- */
/* MATCH 100% (W57-A5, was 79). The W56-A9 "allocator tie-break" verdict was WRONG:
   the s1/s2 rotation was a SYMPTOM of two source-shape defects, both now fixed --
   (1) the fSelFade select was a local if/else, which gcc folded into `(selected!=0)<<7`
       reusing the text-state bool (one pseudo doing two jobs); retail writes the select
       INLINE as the 12th argument so each arm stores 0x80 / 0 straight into 44(sp);
   (2) the vtable result local was `u_short` + `& 0xff` at the use site, which sank the
       `andi` past the lbu chain and cost a `move`; retail's local is `u_char` (mask at
       the assignment, right after the jalr). */

void tMenuItemLeftRightSlider::Draw(bool selected)

{
  u_char uVar1;
  int iVar2;
  __vtbl_ptr_type (*pa_Var3) [6];
  u_int wordnum;
  
  if (this->fX == 0 && this->fY == 0) {
    iVar2 = TextSys_WordX(this->fTextDescription);
    wordnum = this->fTextDescription;
    this->fX = (short)iVar2;
    iVar2 = TextSys_WordY(wordnum);
    this->fY = (short)iVar2;
  }
  FETextRender_MenuTextPositioned((short)this->fTextDescription,this->fX + 8,
             this->fY + 3,(tMenuTextState)(selected != 0),textType_Options);
  pa_Var3 = this->fData->_vf;
  uVar1 = (*(*pa_Var3)[2].pfn)
                    ((char *)this->fData + (int)(*pa_Var3)[2].delta,0xffffffff);
  /* MATCH (W57-A5): the fSelFade select is written INLINE as the 12th argument -- retail
     branches and stores 0x80 / 0 straight into the outgoing 44(sp) arg slot; routing it
     through a local makes gcc fold it to `(selected!=0) << 7` off the text-state bool. */
  DrawSlider(uVar1,(u_short)(u_char)this->fData->fMinValue,(u_short)(u_char)this->fData->fMaxValue,
             this->fX + 0x73,this->fY + 4,this->fWidth,this->fHeight,6,4,false,0,
             selected ? 0x80 : 0,0);
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
  : tMenuItemInteractive(textDescription)
{
  
  *(void **)&(this->_vf) = (void *)tMenuItemGoToMenuButton_vtable;
  this->fNewMenu = newMenu;
  this->fOnButtonPress = OnButtonPress;
  return;
}



/* ---- tMenuItemGoToMenuButton::dtor  [FEMENU.CPP:888-888] SLD-VERIFIED ---- */

tMenuItemGoToMenuButton::~tMenuItemGoToMenuButton()

{
  *(void **)&(this->_vf) = (void *)tMenuItemGoToMenuButton_vtable;
  return;
}



/* ---- tMenuItemGoToMenuButton::ProcessInput  [FEMENU.CPP:897-926] SLD-VERIFIED ---- */

void tMenuItemGoToMenuButton::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &command)

{
  u_int uVar1;
  u_int uVar2;
  void *reg_a3;
  /* MATCH: SYM fsize frame filler -- see tMenuItemLeftRightChoice::ProcessInput. */
  int frameFiller[2];

  uVar2 = this->fFlags;
  uVar1 = uVar2 & 1;
  if (uVar1 != 0) {
    return;
  }
  if (keyval != kInput_KeyType_Cross) {
    return;
  }
  if (this->fNewMenu != (tMenu *)0x0) {
    if ((uVar2 & 0x40) != 0) {
      command.type = kMenu_Command_GoToMenuOneWay;
    }
    else {
      command.type = kMenu_Command_GoToMenu;
    }
    command.nextMenu = this->fNewMenu;
  }
  if (this->fOnButtonPress != 0x0) {
    (*this->fOnButtonPress)(command);
  }
  keyval = kInput_KeyType_AlreadyProcessed;
  return;
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
  this->fOnButtonPress = OnButtonPress;
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
/* MATCH W62 (2026-08-10): PASS, 169 -> 0 diffs.  The retail body is a
   switch ordered Up/Down/Cross/Start/Circle/Square/Triangle and has only
   the SYM local `lastItem`.  Keeping the virtual dispatch as one expression
   gives IDA's item=$v1, delta=$a0 allocation and leaves lastItem=$a0 for the
   two navigation cases. */

void tMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  tMenuItem *ptVar3;
  int lastItem;
  
  if (((this->fFlags & 4) != 0) && (keyval == kInput_KeyType_Start)) {
    keyval = kInput_KeyType_Cross;
  }
  if (((this->fFlags & 0x10000) != 0) && (keyval == kInput_KeyType_Cross)) {
    keyval = kInput_KeyType_Start;
  }
  ptVar3 = this->fItemList[this->fCurrentItem];
  if (ptVar3 != (tMenuItem *)0x0) {
    (*(*ptVar3->_vf)[3].pfn)
        ((char *)ptVar3 + (int)(*ptVar3->_vf)[3].delta,fromPlayer,&keyval,&command);
  }
  switch (keyval) {
    case kInput_KeyType_Up:
      lastItem = this->fCurrentItem;
      do {
        if (this->fCurrentItem > 0) {
          this->fCurrentItem--;
        }
        else {
          while (this->fItemList[this->fCurrentItem + 1] != (tMenuItem *)0x0) {
            this->fCurrentItem++;
          }
        }
      } while ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0);
      if (this->fCurrentItem != lastItem) {
        AudioCmn_PlayFESFX(3);
      }
      keyval = kInput_KeyType_AlreadyProcessed;
      break;

    case kInput_KeyType_Down:
      lastItem = this->fCurrentItem;
      do {
        this->fCurrentItem++;
        if (this->fItemList[this->fCurrentItem] == (tMenuItem *)0x0) {
          this->fCurrentItem = 0;
        }
      } while ((this->fItemList[this->fCurrentItem]->fFlags & 1) != 0);
      if (this->fCurrentItem != lastItem) {
        AudioCmn_PlayFESFX(4);
      }
      keyval = kInput_KeyType_AlreadyProcessed;
      break;

    case kInput_KeyType_Cross:
      if (this->fNextMenu != (tMenu *)0x0) {
        command.type = kMenu_Command_GoToMenu;
        command.nextMenu = this->fNextMenu;
        keyval = kInput_KeyType_AlreadyProcessed;
      }
      break;

    case kInput_KeyType_Start:
      if (this->fOnButtonPress != 0x0) {
        (*this->fOnButtonPress)(command);
        keyval = kInput_KeyType_AlreadyProcessed;
      }
      else if ((this->fFlags & 1) != 0) {
        command.type = kMenu_Command_StartRace;
        keyval = kInput_KeyType_AlreadyProcessed;
      }
      else if ((this->fFlags & 2) != 0) {
        command.type = kMenu_Command_Start2PlayerRace;
        keyval = kInput_KeyType_AlreadyProcessed;
      }
      break;

    case kInput_KeyType_Circle:
      DisplayHelp(FEApp,0);
      break;

    case kInput_KeyType_Square:
      if (this->fOptionsMenu != (tMenu *)0x0) {
        command.type = kMenu_Command_GoToMenu;
        command.nextMenu = this->fOptionsMenu;
        keyval = kInput_KeyType_AlreadyProcessed;
      }
      break;

    case kInput_KeyType_Triangle:
      command.type = kMenu_Command_BackupMenu;
      keyval = kInput_KeyType_AlreadyProcessed;
      break;
  }
  return;
}



/* ---- tMenu::GetNumberEnabledItems  [FEMENU.CPP:1195-1208] SLD-VERIFIED ---- */

short tMenu::GetNumberEnabledItems()

{
  u_int *puVar1;
  short result;
  short i;
  
  /* MATCH: the loop count is initialized only after the early-return
     guard.  GCC fills the guard delay slot with result=0, then retains
     the retail result-to-index copy instead of folding i to literal zero. */
  if (this->fNeverAnyEnabled != 0) {
    return 0;
  }
  result = 0;
  i = result;
  /* The explicit backedge prevents GCC's loop pass from rotating this into
     a bottom-tested loop; retail performs the null test at the loop head. */
GetNumberEnabledItems_loop:
  puVar1 = (u_int *)this->fItemList[i];
  if (puVar1 != (u_int *)0x0) {
    if (((*puVar1 ^ 1) & 1) != 0) {
      result = result + 1;
    }
    i = i + 1;
    goto GetNumberEnabledItems_loop;
  }
  return result;
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

  item = 0;
  ptVar1 = this->fItemList[0];
  while (ptVar1 != (tMenuItem *)0x0) {
    pa_Var2 = this->fItemList[item]->_vf;
    (*(*pa_Var2)[10].pfn)
              ((char *)this->fItemList[item] + (int)(*pa_Var2)[10].delta,
               this->fCurrentItem == (int)item);
    item = item + 1;
    ptVar1 = this->fItemList[item];
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

/* ---- tMenu::TransitionIsFinished  [FEMENU.CPP:1243-1244] SLD-VERIFIED ---- */

bool tMenu::TransitionIsFinished()

{
  return 1;
}



/* ---- tMenu::IsSubMenu  [FEMENU.CPP:1253-1254] SLD-VERIFIED ---- */

bool tMenu::IsSubMenu()

{
  return 0;
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



/* ---- tMenuItem::TransitionOn / TransitionOff  @0x80025aa8 / @0x80025ab0 ----
 * empty base virtuals (overridden by tMenu); not separately reconstructed -- vtable-only
 * refs surfaced by #75 data-materialization. nfs4-f.exe = { jr $ra } (no-op). */
void tMenuItem::TransitionOn()  { return; }
void tMenuItem::TransitionOff() { return; }



/* end of femenu.cpp */
