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
__vtbl_ptr_type tMenuItemLeftRightAudioSlider_vtable[11] = {   /* @0x80010ce0 */
  {0, 0, (int (*)(...))0},    /* @0x80010ce0  null */
  {0, 0, (int (*)(...))&___29tMenuItemLeftRightAudioSlider},    /* @0x80010ce8  ~tMenuItemLeftRightAudioSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010cf0  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::ProcessInput},    /* @0x80010cf8  ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010d00  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))&tMenuItemLeftRightAudioSlider::Draw},    /* @0x80010d08  Draw__29tMenuItemLeftRightAudioSlideriib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010d10  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemLeftRightAudioSlider::TransitionOff},    /* @0x80010d18  TransitionOff__29tMenuItemLeftRightAudioSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightAudioSlider::TransitionOn},    /* @0x80010d20  TransitionOn__29tMenuItemLeftRightAudioSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightAudioSlider::TransitionIsFinished},    /* @0x80010d28  TransitionIsFinished__29tMenuItemLeftRightAudioSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightAudioSlider::UpdateTransition},    /* @0x80010d30  UpdateTransition__29tMenuItemLeftRightAudioSliderb */
};
__vtbl_ptr_type tMenuItemOnOffLeftRightChoice_vtable[11] = {   /* @0x80010d38 */
  {0, 0, (int (*)(...))0},    /* @0x80010d38  null */
  {0, 0, (int (*)(...))&___29tMenuItemOnOffLeftRightChoice},    /* @0x80010d40  ~tMenuItemOnOffLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010d48  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010d50  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010d58  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemOnOffLeftRightChoice::Draw},    /* @0x80010d60  Draw__29tMenuItemOnOffLeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010d68  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOff},    /* @0x80010d70  TransitionOff__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemOnOffLeftRightChoice::TransitionOn},    /* @0x80010d78  TransitionOn__29tMenuItemOnOffLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionIsFinished},    /* @0x80010d80  TransitionIsFinished__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::UpdateTransition},    /* @0x80010d88  UpdateTransition__22tMenuItemLeftRightFadeb */
};
__vtbl_ptr_type tMenuItemDisplayLeftRightChoice_vtable[11] = {   /* @0x80010d90 */
  {0, 0, (int (*)(...))0},    /* @0x80010d90  null */
  {0, 0, (int (*)(...))&___31tMenuItemDisplayLeftRightChoice},    /* @0x80010d98  ~tMenuItemDisplayLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010da0  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010da8  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010db0  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemDisplayLeftRightChoice::Draw},    /* @0x80010db8  Draw__31tMenuItemDisplayLeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010dc0  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOff},    /* @0x80010dc8  TransitionOff__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOn},    /* @0x80010dd0  TransitionOn__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionIsFinished},    /* @0x80010dd8  TransitionIsFinished__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::UpdateTransition},    /* @0x80010de0  UpdateTransition__22tMenuItemLeftRightFadeb */
};
__vtbl_ptr_type tMenuItemSlidingActivated_vtable[12] = {   /* @0x80010de8 */
  {0, 0, (int (*)(...))0},    /* @0x80010de8  null */
  {0, 0, (int (*)(...))&___25tMenuItemSlidingActivated},    /* @0x80010df0  ~tMenuItemSlidingActivated */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::DebounceKeys},    /* @0x80010df8  DebounceKeys__20tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::ProcessInput},    /* @0x80010e00  ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))(void (tMenuItemSlidingMenu::*)(bool))&tMenuItemSlidingMenu::Draw},    /* @0x80010e08  Draw__20tMenuItemSlidingMenub [overload] */
  {0, 0, (int (*)(...))(void (tMenuItemSlidingMenu::*)(int, int, bool))&tMenuItemSlidingMenu::Draw},    /* @0x80010e10  Draw__20tMenuItemSlidingMenuiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010e18  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::TransitionOff},    /* @0x80010e20  TransitionOff__25tMenuItemSlidingActivated */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::TransitionOn},    /* @0x80010e28  TransitionOn__25tMenuItemSlidingActivated */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::TransitionIsFinished},    /* @0x80010e30  TransitionIsFinished__25tMenuItemSlidingActivated */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::UpdateTransition},    /* @0x80010e38  UpdateTransition__25tMenuItemSlidingActivatedb */
  {0, 0, (int (*)(...))&tMenuItemSlidingActivated::UpdatefOpenHeight},    /* @0x80010e40  UpdatefOpenHeight__25tMenuItemSlidingActivatedb */
};
__vtbl_ptr_type tMenuItemSlidingMenu_vtable[12] = {   /* @0x80010e48 */
  {0, 0, (int (*)(...))0},    /* @0x80010e48  null */
  {0, 0, (int (*)(...))&___20tMenuItemSlidingMenu},    /* @0x80010e50  ~tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::DebounceKeys},    /* @0x80010e58  DebounceKeys__20tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::ProcessInput},    /* @0x80010e60  ProcessInput__20tMenuItemSlidingMenu7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))(void (tMenuItemSlidingMenu::*)(bool))&tMenuItemSlidingMenu::Draw},    /* @0x80010e68  Draw__20tMenuItemSlidingMenub [overload] */
  {0, 0, (int (*)(...))(void (tMenuItemSlidingMenu::*)(int, int, bool))&tMenuItemSlidingMenu::Draw},    /* @0x80010e70  Draw__20tMenuItemSlidingMenuiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010e78  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::TransitionOff},    /* @0x80010e80  TransitionOff__20tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::TransitionOn},    /* @0x80010e88  TransitionOn__20tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::TransitionIsFinished},    /* @0x80010e90  TransitionIsFinished__20tMenuItemSlidingMenu */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::UpdateTransition},    /* @0x80010e98  UpdateTransition__20tMenuItemSlidingMenub */
  {0, 0, (int (*)(...))&tMenuItemSlidingMenu::UpdatefOpenHeight},    /* @0x80010ea0  UpdatefOpenHeight__20tMenuItemSlidingMenub */
};
