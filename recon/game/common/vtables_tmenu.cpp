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
__vtbl_ptr_type tBlankMenuItemNFS4LeftRightChoice_vtable[11] = {   /* @0x80011530 */
  {0, 0, (int (*)(...))0},    /* @0x80011530  null */
  {0, 0, (int (*)(...))&___33tBlankMenuItemNFS4LeftRightChoice},    /* @0x80011538  ~tBlankMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80011540  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80011548  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80011550  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&_vt_Draw_BlankNFS4LR_iib},    /* @0x80011558  Draw__33tBlankMenuItemNFS4LeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80011560  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::TransitionOff},    /* @0x80011568  TransitionOff__28tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::TransitionOn},    /* @0x80011570  TransitionOn__28tMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tBlankMenuItemNFS4LeftRightChoice::TransitionIsFinished},    /* @0x80011578  TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItemNFS4LeftRightChoice::UpdateTransition},    /* @0x80011580  UpdateTransition__28tMenuItemNFS4LeftRightChoiceb */
};
__vtbl_ptr_type tMemoryCardMenuItem_vtable[11] = {   /* @0x80010a68 */
  {0, 0, (int (*)(...))0},    /* @0x80010a68  null */
  {0, 0, (int (*)(...))&___19tMemoryCardMenuItem},    /* @0x80010a70  ~tMemoryCardMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010a78  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButton::ProcessInput},    /* @0x80010a80  ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMemoryCardMenuItem::Draw},    /* @0x80010a88  Draw__19tMemoryCardMenuItemb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010a90  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010a98  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionOff},    /* @0x80010aa0  TransitionOff__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionOn},    /* @0x80010aa8  TransitionOn__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionIsFinished},    /* @0x80010ab0  TransitionIsFinished__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::UpdateTransition},    /* @0x80010ab8  UpdateTransition__27tMenuItemGoToMenuButtonFadeb */
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
__vtbl_ptr_type tMenuItemControllerLeftRightChoice_vtable[11] = {   /* @0x80010c20 */
  {0, 0, (int (*)(...))0},    /* @0x80010c20  null */
  {0, 0, (int (*)(...))&___34tMenuItemControllerLeftRightChoice},    /* @0x80010c28  ~tMenuItemControllerLeftRightChoice */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010c30  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010c38  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010c40  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))&tMenuItemControllerLeftRightChoice::Draw},    /* @0x80010c48  Draw__34tMenuItemControllerLeftRightChoiceiib */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010c50  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOff},    /* @0x80010c58  TransitionOff__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOn},    /* @0x80010c60  TransitionOn__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionIsFinished},    /* @0x80010c68  TransitionIsFinished__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::UpdateTransition},    /* @0x80010c70  UpdateTransition__22tMenuItemLeftRightFadeb */
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
__vtbl_ptr_type tMenuItemGoToMenuButtonFade_vtable[11] = {   /* @0x80010ac0 */
  {0, 0, (int (*)(...))0},    /* @0x80010ac0  null */
  {0, 0, (int (*)(...))&___27tMenuItemGoToMenuButtonFade},    /* @0x80010ac8  ~tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010ad0  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButton::ProcessInput},    /* @0x80010ad8  ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x80010ae0  __pure_virtual */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010ae8  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010af0  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionOff},    /* @0x80010af8  TransitionOff__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionOn},    /* @0x80010b00  TransitionOn__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::TransitionIsFinished},    /* @0x80010b08  TransitionIsFinished__27tMenuItemGoToMenuButtonFade */
  {0, 0, (int (*)(...))&tMenuItemGoToMenuButtonFade::UpdateTransition},    /* @0x80010b10  UpdateTransition__27tMenuItemGoToMenuButtonFadeb */
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
__vtbl_ptr_type tMenuItemLeftRightFade_vtable[11] = {   /* @0x80010f60 */
  {0, 0, (int (*)(...))0},    /* @0x80010f60  null */
  {0, 0, (int (*)(...))&___22tMenuItemLeftRightFade},    /* @0x80010f68  ~tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010f70  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::ProcessInput},    /* @0x80010f78  ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightChoice::Draw},    /* @0x80010f80  Draw__24tMenuItemLeftRightChoiceb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010f88  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010f90  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOff},    /* @0x80010f98  TransitionOff__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionOn},    /* @0x80010fa0  TransitionOn__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::TransitionIsFinished},    /* @0x80010fa8  TransitionIsFinished__22tMenuItemLeftRightFade */
  {0, 0, (int (*)(...))&tMenuItemLeftRightFade::UpdateTransition},    /* @0x80010fb0  UpdateTransition__22tMenuItemLeftRightFadeb */
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
__vtbl_ptr_type tOptionsMenu_vtable[11] = {   /* @0x80010f08 */
  {0, 0, (int (*)(...))0},    /* @0x80010f08  null */
  {0, 0, (int (*)(...))&___12tOptionsMenu},    /* @0x80010f10  ~tOptionsMenu */
  {0, 0, (int (*)(...))&tMenu::Initialize},    /* @0x80010f18  Initialize__5tMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::ProcessInput},    /* @0x80010f20  ProcessInput__12tOptionsMenu7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tOptionsMenu::DebounceKeys},    /* @0x80010f28  DebounceKeys__12tOptionsMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::TransitionOff},    /* @0x80010f30  TransitionOff__12tOptionsMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::TransitionOn},    /* @0x80010f38  TransitionOn__12tOptionsMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::TransitionIsFinished},    /* @0x80010f40  TransitionIsFinished__12tOptionsMenu */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80010f48  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::Draw},    /* @0x80010f50  Draw__12tOptionsMenu */
  {0, 0, (int (*)(...))&tOptionsMenu::UpdateTransition},    /* @0x80010f58  UpdateTransition__12tOptionsMenu */
};
__vtbl_ptr_type tUserNameMenuItem_vtable[11] = {   /* @0x80010b18 */
  {0, 0, (int (*)(...))0},    /* @0x80010b18  null */
  {0, 0, (int (*)(...))&___17tUserNameMenuItem},    /* @0x80010b20  ~tUserNameMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::DebounceKeys},    /* @0x80010b28  DebounceKeys__9tMenuItem */
  {0, 0, (int (*)(...))&tUserNameMenuItem::ProcessInput},    /* @0x80010b30  ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tUserNameMenuItem::Draw},    /* @0x80010b38  Draw__17tUserNameMenuItemb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010b40  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, int, bool))&tMenuItem::Draw},    /* @0x80010b48  Draw__9tMenuItemiiib [overload] */
  {0, 0, (int (*)(...))&tUserNameMenuItem::TransitionOff},    /* @0x80010b50  TransitionOff__17tUserNameMenuItem */
  {0, 0, (int (*)(...))&tUserNameMenuItem::TransitionOn},    /* @0x80010b58  TransitionOn__17tUserNameMenuItem */
  {0, 0, (int (*)(...))&tUserNameMenuItem::TransitionIsFinished},    /* @0x80010b60  TransitionIsFinished__17tUserNameMenuItem */
  {0, 0, (int (*)(...))&tUserNameMenuItem::UpdateTransition},    /* @0x80010b68  UpdateTransition__17tUserNameMenuItemb */
};
