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
