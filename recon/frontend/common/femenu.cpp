/* frontend/common/femenu.cpp -- RECONSTRUCTED (menu/iterator class hierarchy; C++ TU)
 *   71 fns across 12 classes: tListIterator(+Indexed/DoubleIndexed/MultiPlayer/Range/
 *   RangeIndexed) list iterators; tMenuItem(+Interactive/LeftRightChoice/LeftRightSlider/
 *   GoToMenuButton) menu items; tMenu container; + free DrawSlider (GPU slider widget).
 *   Member defs; base ctors via member-init-lists; virtual dispatch through compiler-built vtables; ref params. */
#define NFS4_FE_LIST_OWNER   /* FEMenu.obj: every tListIterator class; range-accessor copies LINK_STRIPPED */
#include "femenu.h"


/* ---- FEMenu.obj-OWNED globals -- DEFINED here (self-contained; .data=real EXE bytes) ---- */
/* P872: native SYM 563d74 is scalar ENUM tPlayer (4 B). Frontend -G0
   preserves retail addressing without the old unsized-array carrier. */
tPlayer      gMenu_SubMenuPlayer = (tPlayer)-1;   /* @0x800517c0 */


/* ---- tListIterator::ctor  [FEMENU.CPP:61-64] SLD-VERIFIED ---- */

#line 58 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIterator::tListIterator(short *selection,char *valPtr)


{
  this->fSelectionList = selection;
  this->fValue = valPtr;
  this->fMaxValue = '\0'; this->fMinValue = '\0';
}



/* ---- tListIterator::dtor  [FEMENU.CPP:68-68] SLD-VERIFIED ---- */


#line 68 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIterator::~tListIterator() {}



/* ---- tListIterator::Value  [FEMENU.CPP:73-74] SLD-VERIFIED ---- */

#line 70 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIterator::Value(tPlayer)


{
  return (u_int)(u_char)*this->fValue;
}



/* ---- tListIterator::TextValue  [FEMENU.CPP:78-79] SLD-VERIFIED ---- */

#line 75 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tListIterator::TextValue(tPlayer)


{
  return (int)this->fSelectionList[this->Value((tPlayer)-1) & 0xff];
}



/* ---- tListIterator::Increment  [FEMENU.CPP:83-86] SLD-VERIFIED ---- */

#line 80 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIterator::Increment(tPlayer)


{
  *this->fValue = *this->fValue + '\x01';
  if (this->fSelectionList[(u_char)*this->fValue] == 0) {
    *this->fValue = 0;
  }
}



/* ---- tListIterator::Decrement  [FEMENU.CPP:90-97] SLD-VERIFIED ---- */

/* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
   gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
#line 87 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIterator::Decrement(tPlayer)


{
  if (this->fValue[0] == '\0') {

    while (0 < (int)this->fSelectionList[this->fValue[0] + 1]) {
      this->fValue[0] = this->fValue[0] + 1; }
  }
  else
    this->fValue[0] = this->fValue[0] - 1;
}



/* ---- tListIteratorIndexed::ctor  [FEMENU.CPP:104-106] SLD-VERIFIED ---- */

#line 103 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorIndexed::tListIteratorIndexed(short *selection,char *valPtr,char *index)
  : tListIterator(selection,valPtr)
{
  this->fIndex = index;
}



/* ---- tListIteratorIndexed::dtor  [FEMENU.CPP:110-110] SLD-VERIFIED ---- */


#line 110 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorIndexed::~tListIteratorIndexed() {}



/* ---- tListIteratorIndexed::Value  [FEMENU.CPP:114-115] SLD-VERIFIED ---- */

#line 111 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIteratorIndexed::Value(tPlayer)


{
  return (u_int)(u_char)this->fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorIndexed::TextValue  [FEMENU.CPP:119-120] SLD-VERIFIED ---- */

#line 116 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tListIteratorIndexed::TextValue(tPlayer)


{
  return (int)this->fSelectionList[this->Value((tPlayer)-1) & 0xff];
}



/* ---- tListIteratorIndexed::Increment  [FEMENU.CPP:126-129] SLD-VERIFIED ---- */

#line 123 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorIndexed::Increment(tPlayer)


{
  this->fValue[(u_char)*this->fIndex] = this->fValue[(u_char)*this->fIndex] + '\x01';
  if (this->fSelectionList[(u_char)this->fValue[(u_char)*this->fIndex]] == 0) {
    this->fValue[(u_char)*this->fIndex] = 0; }
}



/* ---- tListIteratorIndexed::Decrement  [FEMENU.CPP:133-140] SLD-VERIFIED ---- */

/* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
   gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
#line 130 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorIndexed::Decrement(tPlayer)


{
  if (this->fValue[*this->fIndex] == '\0') {

    while (0 < (int)this->fSelectionList[this->fValue[*this->fIndex] + 1]) {
      this->fValue[*this->fIndex] = this->fValue[*this->fIndex] + 1; }
  }
  else
    this->fValue[*this->fIndex] = this->fValue[*this->fIndex] - 1;
}



/* ---- tListIteratorDoubleIndexed::dtor  [FEMENU.CPP:156-156] SLD-VERIFIED ---- */


/* GAP-EVIDENCED ctor (name forced by the class): retail FEMenu.obj records TPDEF tListIteratorDoubleIndexed x13 like every other iterator class (ctor 3 + 5 methods x 2;
   ours 10 without a ctor), and FEMENU.CPP leaves a ctor-sized gap (141-155) before the dtor, as for tListIteratorIndexed.
   Nothing constructs it, so the retail link removed it (absent from NFS4.MAP): LINK_STRIPPED (FESCR2). */
tListIteratorDoubleIndexed::tListIteratorDoubleIndexed(short *selection,char *valPtr,char *index1,int multiplier,char *index2)
  : tListIterator(selection,valPtr)
{
  this->fIndex1 = index1;
  this->index1multiplier = multiplier;
  this->fIndex2 = index2;
}
#line 156 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorDoubleIndexed::~tListIteratorDoubleIndexed() {}



/* ---- tListIteratorDoubleIndexed::Value  [FEMENU.CPP:160-161] SLD-VERIFIED ---- */

#line 157 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIteratorDoubleIndexed::Value(tPlayer)


{
  return (u_int)(u_char)this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2];
}



/* ---- tListIteratorDoubleIndexed::TextValue  [FEMENU.CPP:165-166] SLD-VERIFIED ---- */

#line 162 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tListIteratorDoubleIndexed::TextValue(tPlayer)


{
  return (int)this->fSelectionList[this->Value((tPlayer)-1) & 0xff];
}



/* ---- tListIteratorDoubleIndexed::Increment  [FEMENU.CPP:172-175] SLD-VERIFIED ---- */

#line 169 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorDoubleIndexed::Increment(tPlayer)


{
  this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2] = this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2] + '\x01';
  if (this->fSelectionList[(u_char)this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2]] == 0) {
    this->fValue[(u_int)(u_char)*this->fIndex1 * this->index1multiplier + (u_int)(u_char)*this->fIndex2] = 0; }
}



/* ---- tListIteratorDoubleIndexed::Decrement  [FEMENU.CPP:179-186] SLD-VERIFIED ---- */

/* MATCH: SYM = FCN VOID, no locals; plain while (jump.c duplicate_loop_exit_test)
   gives the oracle's pre-loop guard copy with andi 0xFF re-mask (no ==0 const-fold) */
#line 176 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorDoubleIndexed::Decrement(tPlayer)


{
  if (this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] == '\0') {

    while (0 < (int)this->fSelectionList[this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] + 1]) {
      this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] = this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] + 1; }
  }
  else
    this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] = this->fValue[(u_int)*this->fIndex1 * this->index1multiplier + (u_int)*this->fIndex2] - 1;
}



/* ---- tListIteratorMultiPlayer::dtor  [FEMENU.CPP:202-202] SLD-VERIFIED ---- */


/* GAP-EVIDENCED ctor (name forced by the class): retail FEMenu.obj records TPDEF tListIteratorMultiPlayer x13 like every other iterator class (ctor 3 + 5 methods x 2;
   ours 10 without a ctor), and FEMENU.CPP leaves a ctor-sized gap (187-201) before the dtor, as for tListIteratorIndexed.
   Nothing constructs it, so the retail link removed it (absent from NFS4.MAP): LINK_STRIPPED (FESCR2). */
tListIteratorMultiPlayer::tListIteratorMultiPlayer(short *selection,char *valPtr)
  : tListIterator(selection,valPtr)
{
}
#line 202 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorMultiPlayer::~tListIteratorMultiPlayer() {}



/* ---- tListIteratorMultiPlayer::Value  [FEMENU.CPP:206-210] SLD-VERIFIED ---- */

#line 203 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIteratorMultiPlayer::Value(tPlayer atIndex)


{
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  return this->fValue[atIndex];
}



/* ---- tListIteratorMultiPlayer::TextValue  [FEMENU.CPP:214-215] SLD-VERIFIED ---- */

#line 211 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tListIteratorMultiPlayer::TextValue(tPlayer atIndex)


{
  return this->fSelectionList[this->Value(atIndex) & 0xff];   /* the hand call passed no argument: a1 still held atIndex */
}



/* ---- tListIteratorMultiPlayer::Increment  [FEMENU.CPP:221-227] SLD-VERIFIED ---- */

#line 218 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorMultiPlayer::Increment(tPlayer atIndex)


{
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  this->fValue[atIndex]++;
  if (this->fSelectionList[(u_char)this->fValue[atIndex]] == 0) {
    this->fValue[atIndex] = 0; }
}



/* ---- tListIteratorMultiPlayer::Decrement  [FEMENU.CPP:231-241] SLD-VERIFIED ---- */

#line 228 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorMultiPlayer::Decrement(tPlayer atIndex)


{
  if (atIndex == kPlayerBoth) {
    atIndex = kPlayerOne;
  }
  if (this->fValue[atIndex] == '\0') {

    while (0 < this->fSelectionList[(u_char)this->fValue[atIndex] + 1]) {
      this->fValue[atIndex]++; }
  }
  else {
    this->fValue[atIndex]--;
  }
}



/* ---- tListIteratorRange::ctor  [FEMENU.CPP:250-253] SLD-VERIFIED ---- */

#line 249 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorRange::tListIteratorRange(char minValue,char maxValue,char *valPtr)
  : tListIterator((short *)0x0,valPtr)
{
  this->fMinValue = minValue;
  this->fMaxValue = maxValue;
}



/* ---- tListIteratorRange::dtor  [FEMENU.CPP:257-257] SLD-VERIFIED ---- */


#line 257 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorRange::~tListIteratorRange() {}



/* ---- tListIteratorRange::Value  [FEMENU.CPP:262-266] SLD-VERIFIED ---- */

#line 259 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIteratorRange::Value(tPlayer)


{
  /* Retail SLD has three non-emitting lines before this return.
     It records no local or call in that region; the original text
     cannot be determined from this SYM and instruction stream. */
  return (u_int)(u_char)*this->fValue;
}



/* ---- tListIteratorRange::TextValue  [FEMENU.CPP:270-271] SLD-VERIFIED ---- */

#line 267 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tListIteratorRange::TextValue(tPlayer)


{
  return 0;
}



/* ---- tListIteratorRange::Increment  [FEMENU.CPP:276-281] SLD-VERIFIED ---- */

#line 273 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorRange::Increment(tPlayer)


{
  /* Retail SLD leaves three non-emitting lines before this guard.
     No source local or call is recorded there; their original
     contents are not uniquely recoverable from SYM and code. */
  if ((u_int)(u_char)*this->fValue < (u_char)this->fMaxValue) {
    *this->fValue = (u_char)*this->fValue + '\x01';
  }
}



/* ---- tListIteratorRange::Decrement  [FEMENU.CPP:285-290] SLD-VERIFIED ---- */

#line 282 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorRange::Decrement(tPlayer)


{
  /* Retail SLD leaves three non-emitting lines before this guard.
     No source local or call is recorded there; their original
     contents are not uniquely recoverable from SYM and code. */
  if ((u_char)this->fMinValue < (u_int)(u_char)*this->fValue) {
    *this->fValue = (u_char)((u_int)(u_char)*this->fValue - 1);
  }
}



/* ---- tListIteratorRangeIndexed::ctor  [FEMENU.CPP:298-300] SLD-VERIFIED ---- */

#line 297 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorRangeIndexed::tListIteratorRangeIndexed(char minValue,char maxValue,char *valPtr,char *index)
  : tListIteratorRange(minValue,maxValue,valPtr)
{
  this->fIndex = index;
}



/* ---- tListIteratorRangeIndexed::dtor  [FEMENU.CPP:304-304] SLD-VERIFIED ---- */


#line 304 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tListIteratorRangeIndexed::~tListIteratorRangeIndexed() {}



/* ---- tListIteratorRangeIndexed::Value  [FEMENU.CPP:308-309] SLD-VERIFIED ---- */

#line 305 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
char tListIteratorRangeIndexed::Value(tPlayer)


{
  return (u_int)(u_char)this->fValue[(u_char)*this->fIndex];
}



/* ---- tListIteratorRangeIndexed::Increment  [FEMENU.CPP:313-315] SLD-VERIFIED ---- */

#line 310 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorRangeIndexed::Increment(tPlayer)


{
  if ((u_int)(u_char)this->fValue[(u_char)*this->fIndex] < (u_char)this->fMaxValue) {
    this->fValue[(u_char)*this->fIndex] = (u_char)this->fValue[(u_char)*this->fIndex] + '\x01';
  }
}



/* ---- tListIteratorRangeIndexed::Decrement  [FEMENU.CPP:319-321] SLD-VERIFIED ---- */

#line 316 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tListIteratorRangeIndexed::Decrement(tPlayer)


{
  if ((u_char)this->fMinValue < (u_int)(u_char)this->fValue[(u_char)*this->fIndex]) {
    this->fValue[(u_char)*this->fIndex] = (u_char)((u_int)(u_char)this->fValue[(u_char)*this->fIndex] - 1);
  }
}



/* ---- tMenuItem::ctor  [FEMENU.CPP:423-429] SLD-VERIFIED ---- */

#line 420 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItem::tMenuItem(u_int textDescription)


{
  this->fTextDescription = textDescription;
  this->fFlags = 0;
  this->fSelFade = 0;
  this->fButtonImage = -1;
  this->fNumFrames = 0;
  this->fNewMenu = (tMenu *)0x0;
}



/* ---- tMenuItem::dtor  [FEMENU.CPP:433-433] SLD-VERIFIED ---- */


#line 433 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItem::~tMenuItem() {}



/* ---- tMenuItem::DebounceKeys  [FEMENU.CPP:442-443] SLD-VERIFIED ---- */

#line 439 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
long tMenuItem::DebounceKeys()


{
  return -1;
}



/* ---- tMenuItem::ProcessInput  [FEMENU.CPP:447-448] SLD-VERIFIED ---- */


#line 446 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItem::ProcessInput(tPlayer,tInputKeyType &,tMenuCommand &)
{
}



/* ---- tMenuItem::UpdateTransition  [FEMENU.CPP:461-462] SLD-VERIFIED ---- */

#line 458 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItem::UpdateTransition(bool selected)


{
  this->UpdateSelFade(selected);
}



/* ---- tMenuItem::TransitionIsFinished  [FEMENU.CPP:466-467] SLD-VERIFIED ---- */

#line 463 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
bool tMenuItem::TransitionIsFinished()


{
  return 1;
}



/* ---- tMenuItem::UpdateSelFade  [FEMENU.CPP:471-477] SLD-VERIFIED ---- */

#line 468 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItem::UpdateSelFade(bool selected)


{
  if (selected != 0) {
    this->fSelFade = this->fSelFade + 0x40;
  } else { this->fSelFade = this->fSelFade + -10;
  }
  if (0x80 < this->fSelFade) { this->fSelFade = 0x80;
  } if (this->fSelFade < 0) { this->fSelFade = 0; } return; }



/* ---- tMenuItem::Draw  [FEMENU.CPP:481-482] SLD-VERIFIED ---- */
/* The `iib` signature retains both unused coordinates; retail SYM has
   no source names for them. */

#line 478 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItem::Draw(int,int,bool selected)


{
  this->Draw(selected);
}



/* ---- tMenuItem::Draw  [FEMENU.CPP:486-487] SLD-VERIFIED ---- */
/* The mangled `iiib` signature retains this unused third coordinate;
   retail SYM has no source name for it. */

#line 483 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItem::Draw(int x,int y,int,bool selected)


{
  this->Draw(selected,x,y,0);
}



/* ---- tMenuItemInteractive::ctor  [FEMENU.CPP:533-534] SLD-VERIFIED ---- */

#line 532 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemInteractive::tMenuItemInteractive(u_int textDescription)
  : tMenuItem(textDescription)
{
}



/* ---- tMenuItemInteractive::dtor  [FEMENU.CPP:538-538] SLD-VERIFIED ---- */


#line 538 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemInteractive::~tMenuItemInteractive() {}



/* ---- tMenuItemLeftRightChoice::ctor  [FEMENU.CPP:552-555] SLD-VERIFIED ---- */

#line 551 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemLeftRightChoice::tMenuItemLeftRightChoice(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemInteractive(textDescription)
{
  this->fData = dataPtr;
  this->fFlags |= 0x400;
}



/* ---- tMenuItemLeftRightChoice::dtor  [FEMENU.CPP:559-559] SLD-VERIFIED ---- */


#line 559 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemLeftRightChoice::~tMenuItemLeftRightChoice() {}



/* ---- tMenuItemLeftRightChoice::ProcessInput  [FEMENU.CPP:563-582] SLD-VERIFIED ---- */

  /* MATCH: retail falls off the end here -- no return-value materialization
     ($v0 is the AudioCmn_PlayFESFX leftover in the oracle). */
  /* SYM-INLINE-THIS: the real tMenuItem predicate receiver is restored.
     Retail frame 32 with no local record: the outgoing-argument area of a
     5-argument call (FRONT20 2026-11-07; the former frameFiller[2] array
     left an AUTO record retail does not have). */
  /* The unused command reference remains in the `R12tMenuCommand` ABI;
     retail SYM leaves its source name absent. */
#line 559 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemLeftRightChoice::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &)


{
  if (!IsEnabled()) {
    return; FETextRender_MenuTextPositioned(0,0,0,0,0); /* DEVICE (exact-only): unreachable 5-argument call; it raises the outgoing-argument area to 20 bytes (retail frame 32, no local record, no store) and is deleted with the dead code */
  }
  switch (keyval) {
  case kInput_KeyType_Left:

    this->fData->Decrement(fromPlayer);
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFX(5);
    break;
  case kInput_KeyType_Right:
    this->fData->Increment(fromPlayer);
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFX(6);
    break;
  default:
    return;
  }
}



/* ---- tMenuItemLeftRightChoice::Draw  [FEMENU.CPP:590-605] SLD-VERIFIED ---- */

/* Retail SYM records no locals in this Draw method.  A const use-site x
   and the shared y result both optimize out of debug while GCC calls
   TextSys_WordX/WordY once and reuses their values across two renders.
   Their semantic names follow those APIs, not recovered source spelling.
   The `int` value shape is codegen-proven: shortening x or both values
   gave FAIL 5 at 52/51 instructions in earlier probes.  The retained
   source form is byte-PASS and its native declaration tree is exact. */
#line 587 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemLeftRightChoice::Draw(bool selected)


{


  int y;
  const int x = TextSys_WordX(this->fTextDescription);
  y = TextSys_WordY(this->fTextDescription);
  FETextRender_MenuTextPositioned((short)this->fTextDescription,(short)x,
             (short)y,(tMenuTextState)(selected != 0),textType_Options);





  const short value = this->fData->TextValue(gMenu_SubMenuPlayer); /* DEVICE (exact-only): retail tags the TextValue call (13) apart from the draw (15); const temp, no SYM record */
  FETextRender_MenuTextPositioned(value,
             (short)((u_int)((x + 0xb4) * 0x10000) >> 0x10),(short)y,(tMenuTextState)(selected != 0),textType_Options); return;
}



/* ---- tMenuItemLeftRightSlider::ctor  [FEMENU.CPP:612-616] SLD-VERIFIED ---- */

#line 611 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemLeftRightSlider::tMenuItemLeftRightSlider(u_int textDescription,tListIterator *dataPtr)
  : tMenuItemInteractive(textDescription)
{
  this->fFlags |= 0x80;
  this->fData = dataPtr;
  this->fFlags |= 0x80;
}



/* ---- tMenuItemLeftRightSlider::dtor  [FEMENU.CPP:621-621] SLD-VERIFIED ---- */


#line 621 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemLeftRightSlider::~tMenuItemLeftRightSlider() {}



/* ---- tMenuItemLeftRightSlider::DebounceKeys  [FEMENU.CPP:625-626] SLD-VERIFIED ---- */

#line 622 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
long tMenuItemLeftRightSlider::DebounceKeys()


{
  return 0x600;
}



/* ---- tMenuItemLeftRightSlider::ProcessInput  [FEMENU.CPP:630-650] SLD-VERIFIED ---- */
/* Retail leaves the command reference unnamed. Frame 32 with no local record = a
   5-argument call's outgoing area (see LeftRightChoice::ProcessInput).
   Case-local sound calls merge into the single retail call site. */

#line 626 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemLeftRightSlider::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
              tMenuCommand &)


{
  if (!IsEnabled()) {
    return; FETextRender_MenuTextPositioned(0,0,0,0,0); /* DEVICE (exact-only): unreachable 5-argument call; it raises the outgoing-argument area to 20 bytes (retail frame 32, no local record, no store) and is deleted with the dead code */
  }
  switch (keyval) {
  case kInput_KeyType_Left:

    this->fData->Decrement(fromPlayer);
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFXVol(0x15,0x40);

    return;
  case kInput_KeyType_Right:
    this->fData->Increment(fromPlayer);
    keyval = kInput_KeyType_AlreadyProcessed;
    AudioCmn_PlayFESFXVol(0x15,0x40);
    return;
  default:
    return;
  }
}



/* ---- DrawSlider  [FEMENU.CPP:665-761] SLD-VERIFIED ---- */
/* red/green/blue/color: retail SYM records none of them; `short` channel locals get no record (promoted
   pseudo) and give the retail sign-extensions; tags 31/32/33 + compose 35 + call 36 (rel) = retail. Names inferred. */
#line 659 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void DrawSlider(short value,short min,short max,short fX,short fY,short fWidth,short fHeight,
               short rectwidth,short rectspace,bool reverse,bool shadow,
               short fSelFade,
               short fFadeVal)


{
  POLY_F4 *prim;
  short x1;
  short width;
  short factor;
  int myDarkBlue;
  int Col;
  short red; short green; short blue; int color; factor = !fSelFade;



  myDarkBlue = 0xc83c1e;


  width = ((value - min) * fWidth) / (max - min);

  if (!reverse) {
    x1 = fX;

    while (x1 < fX + fWidth) {

      prim = (POLY_F4 *)Render_gPacketPtr, Render_gPacketPtr = (u_char *)prim + 0x18; addPrim(Render_gPalettePtr,prim);

      prim->x0 = x1; prim->y0 = fY; prim->x1 = x1 + rectwidth; prim->y1 = fY; prim->x2 = x1; prim->y2 = fY + fHeight; prim->y3 = fY + fHeight; prim->x3 = x1 + rectwidth;

      if (shadow) {
        Col = 0;
      } else { if (x1 < fX + width) {

          if (fSelFade) {

            red = (((x1 - fX) * 0xbe) / fWidth) >> factor;
            green = ((((x1 - fX) * 0x7c) / fWidth) + 0x42) >> factor;
            blue = (((x1 - fX) * -0xd2) / fWidth + 0xd2) >> factor;

            color = blue << 16 | green << 8 | red;
            Col = CalcFadeVal(myDarkBlue, color, fSelFade);
          }
          else {
            Col = myDarkBlue;
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

    x1 = fX + fWidth - 1;

    while (x1 >= fX) {

      prim = (POLY_F4 *)Render_gPacketPtr, Render_gPacketPtr = (u_char *)prim + 0x18; addPrim(Render_gPalettePtr,prim);

      prim->x0 = x1; prim->y0 = fY; prim->x1 = x1 + rectwidth; prim->y1 = fY; prim->x2 = x1; prim->y2 = fY + fHeight; prim->y3 = fY + fHeight; prim->x3 = x1 + rectwidth;

      if (shadow) {
        Col = 0;
      } else { if (x1 >= fX + fWidth - width) {

          if (fSelFade) {

            red = (((fX + fWidth - x1) * 0xbe) / fWidth) >> factor;
            green = ((((fX + fWidth - x1) * 0x7c) / fWidth) + 0x42) >> factor;
            blue = (((fX + fWidth - x1) * -0xd2) / fWidth + 0xd2) >> factor;

            color = blue << 16 | green << 8 | red;
            Col = CalcFadeVal(myDarkBlue, color, fSelFade);
          }
          else {

            Col = myDarkBlue;
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

/* MATCH (W57-A5): the fSelFade select is written INLINE as the 12th argument -- retail
   branches and stores 0x80 / 0 straight into the outgoing 44(sp) arg slot; routing it
   through a local makes gcc fold it to `(selected!=0) << 7` off the text-state bool. */
#line 850 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemLeftRightSlider::Draw(bool selected)


{
  if (this->fX == 0 && this->fY == 0) {

    this->fX = (short)TextSys_WordX(this->fTextDescription);
    this->fY = (short)TextSys_WordY(this->fTextDescription);
  }
  FETextRender_MenuTextPositioned((short)this->fTextDescription,this->fX + 8,
             this->fY + 3,(tMenuTextState)(selected != 0),textType_Options);
  DrawSlider((u_char)this->fData->Value((tPlayer)-1),
             (u_short)this->fData->MinValue(),(u_short)this->fData->MaxValue(),
             this->fX + 0x73,this->fY + 4,this->fWidth,this->fHeight,6,4,false,0,
             selected ? 0x80 : 0,0);
}



/* ---- tMenuItemLeftRightSlider::SetDimensions  [FEMENU.CPP:868-873] SLD-VERIFIED ---- */

#line 865 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemLeftRightSlider::SetDimensions(short x,short y,short width,short height)


{
  this->fX = x;
  this->fY = y;

  this->fWidth = width;
  this->fHeight = height;
}



/* ---- tMenuItemGoToMenuButton::ctor  [FEMENU.CPP:881-884] SLD-VERIFIED ---- */


#line 879 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemGoToMenuButton::tMenuItemGoToMenuButton(u_int textDescription,tMenu *newMenu,
              void (*OnButtonPress)(tMenuCommand&))
  : tMenuItemInteractive(textDescription)
{
  this->fNewMenu = newMenu;
  this->fOnButtonPress = OnButtonPress;
}



/* ---- tMenuItemGoToMenuButton::dtor  [FEMENU.CPP:888-888] SLD-VERIFIED ---- */


#line 888 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenuItemGoToMenuButton::~tMenuItemGoToMenuButton() {}



/* ---- tMenuItemGoToMenuButton::ProcessInput  [FEMENU.CPP:897-926] SLD-VERIFIED ---- */

  /* Frame 32 with no local record = a 5-argument call's outgoing area
     (see LeftRightChoice::ProcessInput; frameFiller[2] removed). */
#line 893 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenuItemGoToMenuButton::ProcessInput(tPlayer,tInputKeyType &keyval,
              tMenuCommand &command)


{
  if (!IsEnabled()) {
    return; FETextRender_MenuTextPositioned(0,0,0,0,0); /* DEVICE (exact-only): unreachable 5-argument call; it raises the outgoing-argument area to 20 bytes (retail frame 32, no local record, no store) and is deleted with the dead code */
  }
  if (keyval == kInput_KeyType_Cross)
  {

    if (NewMenu() != (tMenu *)0x0)







    {
      if ((this->fFlags & 0x40) != 0) {
        command.type = kMenu_Command_GoToMenuOneWay;
      }
      else { command.type = kMenu_Command_GoToMenu;
      } command.nextMenu = NewMenu();
    }
    if (this->fOnButtonPress != 0x0) {
      (*this->fOnButtonPress)(command);
    } keyval = kInput_KeyType_AlreadyProcessed;


    return;
  }
}



/* ---- tMenu::tMenuConstructor  [FEMENU.CPP:966-980] SLD-VERIFIED ---- */

/* SYM: `i` is the only function-scope local; `p` belongs to the loop block
   that opens at 0x80025440 (SLD line 8). */
#line 963 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::tMenuConstructor(tMenuItem *firstItem,void *ap)


{
  int i; this->VertHelp = 0;



  this->fItemList[0] = firstItem;

  for (i = 0; ; i = i + 1) {
    tMenuItem *p;
    ap = (int *)((int)ap + 4); p = ((tMenuItem **)ap)[-1];
    this->fItemList[i + 1] = p;
    if (p == (tMenuItem *)0x0) break;
  }

  return; }



/* ---- tMenu::ctor  [FEMENU.CPP:1009-1018] SLD-VERIFIED ---- */

#line 1005 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenu::tMenu(u_int flags,tScreen *screenHandler,tMenu *nextMenu,tMenu *optionsMenu,
                void (*OnButtonPress)(tMenuCommand&),short title)


{
  this->fFlags = flags;
  this->fCurrentItem = 0;
  this->fScreen = screenHandler;
  this->fNextMenu = nextMenu;
  this->fOptionsMenu = optionsMenu;
  this->fOnButtonPress = OnButtonPress;
  this->fTitle = title;
  this->fNeverAnyEnabled = 0;
  this->fChildMenu = (tMenu *)0x0;
}



/* ---- tMenu::dtor  [FEMENU.CPP:1022-1022] SLD-VERIFIED ---- */


#line 1022 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
tMenu::~tMenu() {}



/* ---- tMenu::Initialize  [FEMENU.CPP:1026-1044] SLD-VERIFIED ---- */

#line 1023 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::Initialize()


{
  int original;

  if (this->fItemList[this->fCurrentItem]->IsEnabled()) {
    return;
  }

  original = this->fCurrentItem;

  while (!this->fItemList[this->fCurrentItem]->IsEnabled()) {

    this->fCurrentItem++;

    if (this->fItemList[this->fCurrentItem] == (tMenuItem *)0x0) {
      this->fCurrentItem = 0;
    }
    if (original == this->fCurrentItem) break;
  }
}



/* ---- tMenu::ProcessInput  [FEMENU.CPP:1047-1177] SLD-VERIFIED ---- */
/* MATCH W62 (2026-08-10): PASS, 169 -> 0 diffs.  The retail body is a
   switch ordered Up/Down/Cross/Start/Circle/Square/Triangle and has only
   the SYM local `lastItem`.  Keeping the virtual dispatch as one expression
   gives IDA's item=$v1, delta=$a0 allocation and leaves lastItem=$a0 for the
   two navigation cases. */

#line 1044 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)


{
  int lastItem;
  
  if ((this->fFlags & 4) != 0) {

    if (keyval == kInput_KeyType_Start) {
    keyval = kInput_KeyType_Cross;
  } }

  if ((this->fFlags & 0x10000) != 0) {

    if (keyval == kInput_KeyType_Cross) {
    keyval = kInput_KeyType_Start;
  } }


  if (this->fItemList[this->fCurrentItem] != (tMenuItem *)0x0) {

    this->fItemList[this->fCurrentItem]->ProcessInput(fromPlayer,keyval,command);
  }








  switch (keyval)
  { case kInput_KeyType_Up:

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
      } while (!this->fItemList[this->fCurrentItem]->IsEnabled());

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
      } while (!this->fItemList[this->fCurrentItem]->IsEnabled());

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
      FEApp->DisplayHelp(0);
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


      return; } }



/* ---- tMenu::GetNumberEnabledItems  [FEMENU.CPP:1195-1208] SLD-VERIFIED ---- */


#line 1194 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
short tMenu::GetNumberEnabledItems()
{
  if (this->fNeverAnyEnabled != 0) {
    return 0;
  }
  short result = 0;
  short i;

  for (i = 0; this->fItemList[i] != 0; i++) {

    if (this->fItemList[i]->IsEnabled()) {
      result = result + 1;
    } }

  return result;
}



/* ---- tMenu::Draw  [FEMENU.CPP:1217-1222] SLD-VERIFIED ---- */

  /* SYM: `item` lives in the block that opens at 0x80025928, after the title
     guard -- not at function scope. */
#line 1214 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::Draw()


{
  if (-1 < this->fTitle) {
    FETextRender_Title(this->fTitle);
  }
  { short item; item = 0; while (this->fItemList[item] != (tMenuItem *)0x0) {
      this->fItemList[item]->Draw((int)item == this->fCurrentItem); item = item + 1; } } return; }



/* ---- tMenu::UpdateTransition  [FEMENU.CPP:1226-1231] SLD-VERIFIED ---- */

#line 1223 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::UpdateTransition()


{
  { short item; item = 0; while (this->fItemList[item] != (tMenuItem *)0x0) {
      this->fItemList[item]->UpdateTransition(this->fCurrentItem == (int)item); item = item + 1;
    }
  } return;
}



/* ---- tMenu::TransitionOff  [FEMENU.CPP:1235-1236] SLD-VERIFIED ---- */


#line 1234 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::TransitionOff()
{
}



/* ---- tMenu::TransitionOn  [FEMENU.CPP:1239-1240] SLD-VERIFIED ---- */


#line 1238 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
void tMenu::TransitionOn()
{
}

/* ---- tMenu::TransitionIsFinished  [FEMENU.CPP:1243-1244] SLD-VERIFIED ---- */

#line 1240 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
bool tMenu::TransitionIsFinished()


{
  return 1;
}



/* ---- tMenu::IsSubMenu  [FEMENU.CPP:1253-1254] SLD-VERIFIED ---- */

#line 1250 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
bool tMenu::IsSubMenu()


{
  return 0;
}



/* ---- tMenu::DebounceKeys  [FEMENU.CPP:1258-1259] SLD-VERIFIED ---- */

#line 1255 "C:/nfs4/FRONTEND/COMMON/FEMENU.CPP"
long tMenu::DebounceKeys()


{
  return this->fItemList[this->fCurrentItem]->DebounceKeys();
}



/* ---- tMenuItem::TransitionOn / TransitionOff  @0x80025aa8 / @0x80025ab0 ----
 * empty base virtuals (overridden by tMenu); not separately reconstructed -- vtable-only
 * refs surfaced by #75 data-materialization. nfs4-f.exe = { jr $ra } (no-op). */

#line 275 "C:/nfs4/FRONTEND/COMMON/FEMENU.H"
/* body in-class (fe_core_types.h, NFS4_TU_FEMENU; FESCR2) */

#line 274 "C:/nfs4/FRONTEND/COMMON/FEMENU.H"
/* body in-class (fe_core_types.h, NFS4_TU_FEMENU; FESCR2) */



/* end of femenu.cpp */
