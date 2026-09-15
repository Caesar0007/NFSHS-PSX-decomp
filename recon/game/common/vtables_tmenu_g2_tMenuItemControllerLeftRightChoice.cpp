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
