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
__vtbl_ptr_type tInsideBoxSongMenu_vtable[13] = {   /* @0x80010c78 */
  {0, 0, (int (*)(...))0},    /* @0x80010c78  null */
  {0, 0, (int (*)(...))&___18tInsideBoxSongMenu},    /* @0x80010c80  ~tInsideBoxSongMenu */
  {0, 0, (int (*)(...))&tMenu::Initialize},    /* @0x80010c88  Initialize__5tMenu */
  {0, 0, (int (*)(...))&tInsideBoxSongMenu::ProcessInput},    /* @0x80010c90  ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tInsideBoxSongMenu::DebounceKeys},    /* @0x80010c98  DebounceKeys__18tInsideBoxSongMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOff},    /* @0x80010ca0  TransitionOff__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOn},    /* @0x80010ca8  TransitionOn__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionIsFinished},    /* @0x80010cb0  TransitionIsFinished__5tMenu */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80010cb8  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenu::Draw},    /* @0x80010cc0  Draw__5tMenu */
  {0, 0, (int (*)(...))&tMenu::UpdateTransition},    /* @0x80010cc8  UpdateTransition__5tMenu */
  {0, 0, (int (*)(...))&tInsideBoxSongMenu::Draw},    /* @0x80010cd0  Draw__18tInsideBoxSongMenusssss */
  {0, 0, (int (*)(...))&tInsideBoxSongMenu::DrawOneSong},    /* @0x80010cd8  DrawOneSong__18tInsideBoxSongMenussssss */
};
