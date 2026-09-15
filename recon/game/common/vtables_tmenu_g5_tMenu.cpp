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

/* These two exact retail tables have no `_vt.*` SYM record.
   SYM-GLOBAL-CARRIER: tBlankMenuItemGoToMenuNFS4Button_vtable
   SYM-GLOBAL-CARRIER: tBlankMenuItemNFS4LeftRightChoice_vtable */
__vtbl_ptr_type tBlankMenuItemGoToMenuNFS4Button_vtable[11] = {   /* @0x800114d8 */
  {0, 0, (int (*)(...))0},    /* @0x800114d8  null */
  {0, 0, (int (*)(...))&___32tBlankMenuItemGoToMenuNFS4Button},    /* @0x800114e0  ~tBlankMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x800114e8  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButton::ProcessInput},    /* @0x800114f0  ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&_vt_Draw_BlankGoTo_b},    /* @0x800114f8  Draw__32tBlankMenuItemGoToMenuNFS4Buttonb [overload by-arity; recon types differ from SYM] */
  {0, 0, (int (*)(...))&_vt_Draw_BlankGoTo_iib},    /* @0x80011500  Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib [overload by-arity; recon types differ from SYM] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80011508  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::TransitionOff},    /* @0x80011510  TransitionOff__27tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::TransitionOn},    /* @0x80011518  TransitionOn__27tMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tBlankMenuItemGoToMenuNFS4Button::TransitionIsFinished},    /* @0x80011520  TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuNFS4Button::UpdateTransition},    /* @0x80011528  UpdateTransition__27tMenuItemGoToMenuNFS4Buttonb */
};
/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tMenu_vtable[11] = {   /* @0x800110c8 */
  {0, 0, (int (*)(...))0},    /* @0x800110c8  null */
  {0, 0, (int (*)(...))&___5tMenu},    /* @0x800110d0  ~tMenu */
  {0, 0, (int (*)(...))&tMenu::Initialize},    /* @0x800110d8  Initialize__5tMenu */
  {0, 0, (int (*)(...))&tMenu::ProcessInput},    /* @0x800110e0  ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x800110e8  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOff},    /* @0x800110f0  TransitionOff__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOn},    /* @0x800110f8  TransitionOn__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionIsFinished},    /* @0x80011100  TransitionIsFinished__5tMenu */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80011108  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenu::Draw},    /* @0x80011110  Draw__5tMenu */
  {0, 0, (int (*)(...))&tMenu::UpdateTransition},    /* @0x80011118  UpdateTransition__5tMenu */
};
__vtbl_ptr_type tMenuItemGoToMenuButton_vtable[11] = {   /* @0x80011120 */
  {0, 0, (int (*)(...))0},    /* @0x80011120  null */
  {0, 0, (int (*)(...))&___23tMenuItemGoToMenuButton},    /* @0x80011128  ~tMenuItemGoToMenuButton */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80011130  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButton::ProcessInput},    /* @0x80011138  ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x80011140  __pure_virtual */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80011148  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80011150  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80011158  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80011160  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80011168  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80011170  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItemLeftRightSlider_vtable[11] = {   /* @0x80011178 */
  {0, 0, (int (*)(...))0},    /* @0x80011178  null */
  {0, 0, (int (*)(...))&___24tMenuItemLeftRightSlider},    /* @0x80011180  ~tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80011188  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::ProcessInput},    /* @0x80011190  ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80011198  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x800111a0  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x800111a8  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x800111b0  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x800111b8  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x800111c0  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x800111c8  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItemLeftRightChoice_vtable[11] = {   /* @0x800111d0 */
  {0, 0, (int (*)(...))0},    /* @0x800111d0  null */
  {0, 0, (int (*)(...))&___24tMenuItemLeftRightChoice},    /* @0x800111d8  ~tMenuItemLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x800111e0  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x800111e8  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x800111f0  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x800111f8  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80011200  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80011208  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80011210  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80011218  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80011220  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItemInteractive_vtable[11] = {   /* @0x80011228 */
  {0, 0, (int (*)(...))0},    /* @0x80011228  null */
  {0, 0, (int (*)(...))&___20tMenuItemInteractive},    /* @0x80011230  ~tMenuItemInteractive */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80011238  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::ProcessInput},    /* @0x80011240  ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x80011248  __pure_virtual */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80011250  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80011258  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80011260  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80011268  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80011270  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80011278  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tMenuItem_vtable[11] = {   /* @0x80011280 */
  {0, 0, (int (*)(...))0},    /* @0x80011280  null */
  {0, 0, (int (*)(...))&___9tMenuItem},    /* @0x80011288  ~tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80011290  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::ProcessInput},    /* @0x80011298  ProcessInput__9tMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800112a0  __pure_virtual */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x800112a8  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x800112b0  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x800112b8  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x800112c0  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x800112c8  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x800112d0  UpdateTransition__9tMenuItemb */
};
