/* vtables_tmenu.cpp -- #75 data-materialization: tMenu-family vtables (28), faithful member-cast.
 * Real nfs4-f.exe bytes + REAL method addresses: (int(*)(...))&Class::method; overloaded methods
 * use a typed member-pointer cast (ret from header, params from mangle). @0xVA breadcrumbs. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w64-a19 LINK FIX: nfs4_types.h declares three of these overloads with the WRONG
 * parameter types -- Draw(int) and Draw(int,int,char) -- so the member-pointer casts
 * below resolved to manglings that NOTHING in the tree defines
 * (Draw__32tBlankMenuItemGoToMenuNFS4Buttoni, ...iic, Draw__33...LeftRightChoiceiic),
 * three hard link errors.  The real definitions, in femenudefs.cpp, are the `b` (bool)
 * forms already named in each slot's @VA comment.  nfs4_types.h and femenudefs.cpp are
 * user-owned files (AGENT_GUIDE 5), so the slots take the address through an
 * asm-labelled extern instead: same function, same VA after link, and the data byte is
 * a relocation either way -- zero byte change. */
extern "C" void _vt_Draw_BlankGoTo_b()     asm("Draw__32tBlankMenuItemGoToMenuNFS4Buttonb");
extern "C" void _vt_Draw_BlankGoTo_iib()   asm("Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib");
extern "C" void _vt_Draw_BlankNFS4LR_iib() asm("Draw__33tBlankMenuItemNFS4LeftRightChoiceiib");

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___10tMenuBlank(void *thisp);   /* ~tMenuBlank */
extern "C" void ___12tMenuOptions(void *thisp);   /* ~tMenuOptions */
extern "C" void ___12tOptionsMenu(void *thisp);   /* ~tOptionsMenu */
extern "C" void ___15tMenuNFS4Bottom(void *thisp);   /* ~tMenuNFS4Bottom */
extern "C" void ___17tUserNameMenuItem(void *thisp);   /* ~tUserNameMenuItem */
extern "C" void ___18tMenuNFS4TwoPlayer(void *thisp);   /* ~tMenuNFS4TwoPlayer */
extern "C" void ___19tMemoryCardMenuItem(void *thisp);   /* ~tMemoryCardMenuItem */
extern "C" void ___20tMenuItemInteractive(void *thisp);   /* ~tMenuItemInteractive */
extern "C" void ___20tMenuItemSlidingMenu(void *thisp);   /* ~tMenuItemSlidingMenu */
extern "C" void ___22tMenuItemLeftRightFade(void *thisp);   /* ~tMenuItemLeftRightFade */
extern "C" void ___23tMenuItemGoToMenuButton(void *thisp);   /* ~tMenuItemGoToMenuButton */
extern "C" void ___24tMenuItemLeftRightChoice(void *thisp);   /* ~tMenuItemLeftRightChoice */
extern "C" void ___24tMenuItemLeftRightSlider(void *thisp);   /* ~tMenuItemLeftRightSlider */
extern "C" void ___25tMenuItemSlidingActivated(void *thisp);   /* ~tMenuItemSlidingActivated */
extern "C" void ___27tMenuItemGoToMenuButtonFade(void *thisp);   /* ~tMenuItemGoToMenuButtonFade */
extern "C" void ___27tMenuItemGoToMenuNFS4Button(void *thisp);   /* ~tMenuItemGoToMenuNFS4Button */
extern "C" void ___28tMenuItemNFS4LeftRightChoice(void *thisp);   /* ~tMenuItemNFS4LeftRightChoice */
extern "C" void ___29tMenuItemLeftRightAudioSlider(void *thisp);   /* ~tMenuItemLeftRightAudioSlider */
extern "C" void ___29tMenuItemOnOffLeftRightChoice(void *thisp);   /* ~tMenuItemOnOffLeftRightChoice */
extern "C" void ___29tMenuItemOptionsTwoItemChoice(void *thisp);   /* ~tMenuItemOptionsTwoItemChoice */
extern "C" void ___31tMenuItemDisplayLeftRightChoice(void *thisp);   /* ~tMenuItemDisplayLeftRightChoice */
extern "C" void ___31tMenuItemOptionsLeftRightChoice(void *thisp);   /* ~tMenuItemOptionsLeftRightChoice */
extern "C" void ___32tBlankMenuItemGoToMenuNFS4Button(void *thisp);   /* ~tBlankMenuItemGoToMenuNFS4Button */
extern "C" void ___33tBlankMenuItemNFS4LeftRightChoice(void *thisp);   /* ~tBlankMenuItemNFS4LeftRightChoice */
extern "C" void ___34tMenuItemControllerLeftRightChoice(void *thisp);   /* ~tMenuItemControllerLeftRightChoice */
extern "C" void ___5tMenu(void *thisp);   /* ~tMenu */
extern "C" void ___9tMenuItem(void *thisp);   /* ~tMenuItem */
extern "C" void ___9tMenuNFS4(void *thisp);   /* ~tMenuNFS4 */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tMenuOptions_vtable[12] = {   /* @0x80010620 */
  {0, 0, (int (*)(...))0},    /* @0x80010620  null */
  {0, 0, (int (*)(...))&___12tMenuOptions},    /* @0x80010628  ~tMenuOptions */
  {0, 0, (int (*)(...))&tMenuNFS4::Initialize},    /* @0x80010630  Initialize__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuOptions::ProcessInput},    /* @0x80010638  ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x80010640  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenuOptions::TransitionOff},    /* @0x80010648  TransitionOff__12tMenuOptions */
  {0, 0, (int (*)(...))&tMenuOptions::TransitionOn},    /* @0x80010650  TransitionOn__12tMenuOptions */
  {0, 0, (int (*)(...))&tMenuOptions::TransitionIsFinished},    /* @0x80010658  TransitionIsFinished__12tMenuOptions */
  {0, 0, (int (*)(...))&tMenuOptions::IsSubMenu},    /* @0x80010660  IsSubMenu__12tMenuOptions */
  {0, 0, (int (*)(...))&tMenuOptions::Draw},    /* @0x80010668  Draw__12tMenuOptions */
  {0, 0, (int (*)(...))&tMenuNFS4::UpdateTransition},    /* @0x80010670  UpdateTransition__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::DrawItem},    /* @0x80010678  DrawItem__9tMenuNFS4i */
};
__vtbl_ptr_type tMenuBlank_vtable[12] = {   /* @0x80010680 */
  {0, 0, (int (*)(...))0},    /* @0x80010680  null */
  {0, 0, (int (*)(...))&___10tMenuBlank},    /* @0x80010688  ~tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::Initialize},    /* @0x80010690  Initialize__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::ProcessInput},    /* @0x80010698  ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuBlank::DebounceKeys},    /* @0x800106a0  DebounceKeys__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::TransitionOff},    /* @0x800106a8  TransitionOff__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::TransitionOn},    /* @0x800106b0  TransitionOn__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::TransitionIsFinished},    /* @0x800106b8  TransitionIsFinished__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x800106c0  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenuBlank::Draw},    /* @0x800106c8  Draw__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuBlank::UpdateTransition},    /* @0x800106d0  UpdateTransition__10tMenuBlank */
  {0, 0, (int (*)(...))&tMenuNFS4::DrawItem},    /* @0x800106d8  DrawItem__9tMenuNFS4i */
};
__vtbl_ptr_type tMenuNFS4Bottom_vtable[12] = {   /* @0x800106e0 */
  {0, 0, (int (*)(...))0},    /* @0x800106e0  null */
  {0, 0, (int (*)(...))&___15tMenuNFS4Bottom},    /* @0x800106e8  ~tMenuNFS4Bottom */
  {0, 0, (int (*)(...))&tMenuNFS4::Initialize},    /* @0x800106f0  Initialize__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::ProcessInput},    /* @0x800106f8  ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x80010700  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOff},    /* @0x80010708  TransitionOff__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOn},    /* @0x80010710  TransitionOn__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionIsFinished},    /* @0x80010718  TransitionIsFinished__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80010720  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4Bottom::Draw},    /* @0x80010728  Draw__15tMenuNFS4Bottom */
  {0, 0, (int (*)(...))&tMenuNFS4::UpdateTransition},    /* @0x80010730  UpdateTransition__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::DrawItem},    /* @0x80010738  DrawItem__9tMenuNFS4i */
};
__vtbl_ptr_type tMenuNFS4TwoPlayer_vtable[12] = {   /* @0x80010740 */
  {0, 0, (int (*)(...))0},    /* @0x80010740  null */
  {0, 0, (int (*)(...))&___18tMenuNFS4TwoPlayer},    /* @0x80010748  ~tMenuNFS4TwoPlayer */
  {0, 0, (int (*)(...))&tMenuNFS4::Initialize},    /* @0x80010750  Initialize__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::ProcessInput},    /* @0x80010758  ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x80010760  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOff},    /* @0x80010768  TransitionOff__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOn},    /* @0x80010770  TransitionOn__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionIsFinished},    /* @0x80010778  TransitionIsFinished__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80010780  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4::Draw},    /* @0x80010788  Draw__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::UpdateTransition},    /* @0x80010790  UpdateTransition__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4TwoPlayer::DrawItem},    /* @0x80010798  DrawItem__18tMenuNFS4TwoPlayeri */
};
__vtbl_ptr_type tMenuNFS4_vtable[12] = {   /* @0x800107a0 */
  {0, 0, (int (*)(...))0},    /* @0x800107a0  null */
  {0, 0, (int (*)(...))&___9tMenuNFS4},    /* @0x800107a8  ~tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::Initialize},    /* @0x800107b0  Initialize__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::ProcessInput},    /* @0x800107b8  ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x800107c0  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOff},    /* @0x800107c8  TransitionOff__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionOn},    /* @0x800107d0  TransitionOn__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::TransitionIsFinished},    /* @0x800107d8  TransitionIsFinished__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x800107e0  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenuNFS4::Draw},    /* @0x800107e8  Draw__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::UpdateTransition},    /* @0x800107f0  UpdateTransition__9tMenuNFS4 */
  {0, 0, (int (*)(...))&tMenuNFS4::DrawItem},    /* @0x800107f8  DrawItem__9tMenuNFS4i */
};
__vtbl_ptr_type tMenuItemOptionsTwoItemChoice_vtable[11] = {   /* @0x80010800 */
  {0, 0, (int (*)(...))0},    /* @0x80010800  null */
  {0, 0, (int (*)(...))&___29tMenuItemOptionsTwoItemChoice},    /* @0x80010808  ~tMenuItemOptionsTwoItemChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010810  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010818  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010820  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemOptionsTwoItemChoice::Draw},    /* @0x80010828  Draw__29tMenuItemOptionsTwoItemChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010830  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010838  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemOptionsTwoItemChoice::TransitionOn},    /* @0x80010840  TransitionOn__29tMenuItemOptionsTwoItemChoice */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010848  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010850  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItemOptionsLeftRightChoice_vtable[11] = {   /* @0x80010858 */
  {0, 0, (int (*)(...))0},    /* @0x80010858  null */
  {0, 0, (int (*)(...))&___31tMenuItemOptionsLeftRightChoice},    /* @0x80010860  ~tMenuItemOptionsLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010868  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010870  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010878  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemOptionsLeftRightChoice::Draw},    /* @0x80010880  Draw__31tMenuItemOptionsLeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010888  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010890  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010898  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x800108a0  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x800108a8  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItemNFS4LeftRightChoice_vtable[11] = {   /* @0x800108b0 */
  {0, 0, (int (*)(...))0},    /* @0x800108b0  null */
  {0, 0, (int (*)(...))&___28tMenuItemNFS4LeftRightChoice},    /* @0x800108b8  ~tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x800108c0  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x800108c8  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x800108d0  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::Draw},    /* @0x800108d8  Draw__28tMenuItemNFS4LeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x800108e0  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::TransitionOff},    /* @0x800108e8  TransitionOff__28tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::TransitionOn},    /* @0x800108f0  TransitionOn__28tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::TransitionIsFinished},    /* @0x800108f8  TransitionIsFinished__28tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::UpdateTransition},    /* @0x80010900  UpdateTransition__28tMenuItemNFS4LeftRightChoiceb */
};
__vtbl_ptr_type tMenuItemGoToMenuNFS4Button_vtable[11] = {   /* @0x80010908 */
  {0, 0, (int (*)(...))0},    /* @0x80010908  null */
  {0, 0, (int (*)(...))&___27tMenuItemGoToMenuNFS4Button},    /* @0x80010910  ~tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010918  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButton::ProcessInput},    /* @0x80010920  ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))(void (tMenuItemGoToMenuNFS4Button::*)(bool))&tMenuItemGoToMenuNFS4Button::Draw},    /* @0x80010928  Draw__27tMenuItemGoToMenuNFS4Buttonb [overload] */
  {0, 0, (int (*)(...))(void (tMenuItemGoToMenuNFS4Button::*)(int, int, bool))&tMenuItemGoToMenuNFS4Button::Draw},    /* @0x80010930  Draw__27tMenuItemGoToMenuNFS4Buttoniib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010938  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::TransitionOff},    /* @0x80010940  TransitionOff__27tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::TransitionOn},    /* @0x80010948  TransitionOn__27tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::TransitionIsFinished},    /* @0x80010950  TransitionIsFinished__27tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::UpdateTransition},    /* @0x80010958  UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb */
};
