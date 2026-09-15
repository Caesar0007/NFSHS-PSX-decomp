/* vtables_tpausemenu.cpp -- #75 data-materialization: tPauseMenu-family vtables (16), faithful member-cast.
 * Real nfs4-f.exe bytes + REAL method addresses: (int(*)(...))&Class::method; overloaded methods
 * use a typed member-pointer cast (ret from header, params from mangle). @0xVA breadcrumbs. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___10tPMenuItem(void *thisp);   /* ~tPMenuItem */
extern "C" void ___14tInsideBoxMenu(void *thisp);   /* ~tInsideBoxMenu */
extern "C" void ___14tPListIterator(void *thisp);   /* ~tPListIterator */
extern "C" void ___18tInsideBoxSongMenu(void *thisp);   /* ~tInsideBoxSongMenu */
extern "C" void ___21tPListIteratorIndexed(void *thisp);   /* ~tPListIteratorIndexed */
extern "C" void ___21tPMenuItemInteractive(void *thisp);   /* ~tPMenuItemInteractive */
extern "C" void ___22tInsideBoxTwoWaySlider(void *thisp);   /* ~tInsideBoxTwoWaySlider */
extern "C" void ___23tPMenuItemCommandButton(void *thisp);   /* ~tPMenuItemCommandButton */
extern "C" void ___24tPMenuItemGoToMenuButton(void *thisp);   /* ~tPMenuItemGoToMenuButton */
extern "C" void ___25tInsideBoxLeftRightSlider(void *thisp);   /* ~tInsideBoxLeftRightSlider */
extern "C" void ___25tPMenuItemLeftRightChoice(void *thisp);   /* ~tPMenuItemLeftRightChoice */
extern "C" void ___25tPMenuItemLeftRightSlider(void *thisp);   /* ~tPMenuItemLeftRightSlider */
extern "C" void ___28tPMenuItemNonInteractiveText(void *thisp);   /* ~tPMenuItemNonInteractiveText */
extern "C" void ___32tPMenuItemLeftRightSliderIndexed(void *thisp);   /* ~tPMenuItemLeftRightSliderIndexed */
extern "C" void ___35tInsideBoxControllerLeftRightSlider(void *thisp);   /* ~tInsideBoxControllerLeftRightSlider */
extern "C" void ___6tPMenu(void *thisp);   /* ~tPMenu */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tInsideBoxTwoWaySlider_vtable[11] = {   /* @0x80010b70 */
  {0, 0, (int (*)(...))0},    /* @0x80010b70  null */
  {0, 0, (int (*)(...))&___22tInsideBoxTwoWaySlider},    /* @0x80010b78  ~tInsideBoxTwoWaySlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010b80  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tInsideBoxTwoWaySlider::ProcessInput},    /* @0x80010b88  ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010b90  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010b98  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))&tInsideBoxTwoWaySlider::Draw},    /* @0x80010ba0  Draw__22tInsideBoxTwoWaySlideriiib */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010ba8  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010bb0  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010bb8  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010bc0  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tInsideBoxLeftRightSlider_vtable[11] = {   /* @0x80010bc8 */
  {0, 0, (int (*)(...))0},    /* @0x80010bc8  null */
  {0, 0, (int (*)(...))&___25tInsideBoxLeftRightSlider},    /* @0x80010bd0  ~tInsideBoxLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010bd8  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::ProcessInput},    /* @0x80010be0  ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010be8  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(void (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010bf0  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))&tInsideBoxLeftRightSlider::Draw},    /* @0x80010bf8  Draw__25tInsideBoxLeftRightSlideriiib */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010c00  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010c08  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010c10  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010c18  UpdateTransition__9tMenuItemb */
};
