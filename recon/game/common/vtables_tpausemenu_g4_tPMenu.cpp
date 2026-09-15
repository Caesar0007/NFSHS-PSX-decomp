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
__vtbl_ptr_type tPMenu_vtable[5] = {   /* @0x8005611c */
  {0, 0, (int (*)(...))0},    /* @0x8005611c  null */
  {0, 0, (int (*)(...))&___6tPMenu},    /* @0x80056124  ~tPMenu */
  {0, 0, (int (*)(...))&tPMenu::Initialize},    /* @0x8005612c  Initialize__6tPMenu */
  {0, 0, (int (*)(...))&tPMenu::ProcessInput},    /* @0x80056134  ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenu::Draw},    /* @0x8005613c  Draw__6tPMenu */
};
__vtbl_ptr_type tPMenuItemCommandButton_vtable[7] = {   /* @0x80056144 */
  {0, 0, (int (*)(...))0},    /* @0x80056144  null */
  {0, 0, (int (*)(...))&___23tPMenuItemCommandButton},    /* @0x8005614c  ~tPMenuItemCommandButton */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x80056154  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x8005615c  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemCommandButton::ProcessInput},    /* @0x80056164  ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x8005616c  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x80056174  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemGoToMenuButton_vtable[7] = {   /* @0x8005617c */
  {0, 0, (int (*)(...))0},    /* @0x8005617c  null */
  {0, 0, (int (*)(...))&___24tPMenuItemGoToMenuButton},    /* @0x80056184  ~tPMenuItemGoToMenuButton */
  {0, 0, (int (*)(...))&tPMenuItemGoToMenuButton::NextMenu},    /* @0x8005618c  NextMenu__24tPMenuItemGoToMenuButton */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x80056194  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemGoToMenuButton::ProcessInput},    /* @0x8005619c  ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x800561a4  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x800561ac  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemLeftRightSliderIndexed_vtable[7] = {   /* @0x800561b4 */
  {0, 0, (int (*)(...))0},    /* @0x800561b4  null */
  {0, 0, (int (*)(...))&___32tPMenuItemLeftRightSliderIndexed},    /* @0x800561bc  ~tPMenuItemLeftRightSliderIndexed */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800561c4  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Debounce},    /* @0x800561cc  Debounce__25tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSliderIndexed::ProcessInput},    /* @0x800561d4  ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x800561dc  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSliderIndexed::Draw},    /* @0x800561e4  Draw__32tPMenuItemLeftRightSliderIndexedb */
};
__vtbl_ptr_type tPMenuItemLeftRightSlider_vtable[7] = {   /* @0x800561ec */
  {0, 0, (int (*)(...))0},    /* @0x800561ec  null */
  {0, 0, (int (*)(...))&___25tPMenuItemLeftRightSlider},    /* @0x800561f4  ~tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800561fc  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Debounce},    /* @0x80056204  Debounce__25tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::ProcessInput},    /* @0x8005620c  ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x80056214  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Draw},    /* @0x8005621c  Draw__25tPMenuItemLeftRightSliderb */
};
__vtbl_ptr_type tPMenuItemLeftRightChoice_vtable[7] = {   /* @0x80056224 */
  {0, 0, (int (*)(...))0},    /* @0x80056224  null */
  {0, 0, (int (*)(...))&___25tPMenuItemLeftRightChoice},    /* @0x8005622c  ~tPMenuItemLeftRightChoice */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x80056234  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x8005623c  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightChoice::ProcessInput},    /* @0x80056244  ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x8005624c  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightChoice::Draw},    /* @0x80056254  Draw__25tPMenuItemLeftRightChoiceb */
};
__vtbl_ptr_type tPMenuItemInteractive_vtable[7] = {   /* @0x8005625c */
  {0, 0, (int (*)(...))0},    /* @0x8005625c  null */
  {0, 0, (int (*)(...))&___21tPMenuItemInteractive},    /* @0x80056264  ~tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x8005626c  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x80056274  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x8005627c  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x80056284  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x8005628c  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemNonInteractiveText_vtable[7] = {   /* @0x80056294 */
  {0, 0, (int (*)(...))0},    /* @0x80056294  null */
  {0, 0, (int (*)(...))&___28tPMenuItemNonInteractiveText},    /* @0x8005629c  ~tPMenuItemNonInteractiveText */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800562a4  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x800562ac  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x800562b4  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemNonInteractiveText::IsNavigable},    /* @0x800562bc  IsNavigable__28tPMenuItemNonInteractiveText */
  {0, 0, (int (*)(...))&tPMenuItemNonInteractiveText::Draw},    /* @0x800562c4  Draw__28tPMenuItemNonInteractiveTextb */
};
__vtbl_ptr_type tPMenuItem_vtable[7] = {   /* @0x800562cc */
  {0, 0, (int (*)(...))0},    /* @0x800562cc  null */
  {0, 0, (int (*)(...))&___10tPMenuItem},    /* @0x800562d4  ~tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800562dc  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x800562e4  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x800562ec  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800562f4  __pure_virtual */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800562fc  __pure_virtual */
};
__vtbl_ptr_type tPListIteratorIndexed_vtable[6] = {   /* @0x80056304 */
  {0, 0, (int (*)(...))0},    /* @0x80056304  null */
  {0, 0, (int (*)(...))&___21tPListIteratorIndexed},    /* @0x8005630c  ~tPListIteratorIndexed */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Value},    /* @0x80056314  Value__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::TextValue},    /* @0x8005631c  TextValue__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Increment},    /* @0x80056324  Increment__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Decrement},    /* @0x8005632c  Decrement__21tPListIteratorIndexed7tPlayer */
};
__vtbl_ptr_type tPListIterator_vtable[6] = {   /* @0x80056334 */
  {0, 0, (int (*)(...))0},    /* @0x80056334  null */
  {0, 0, (int (*)(...))&___14tPListIterator},    /* @0x8005633c  ~tPListIterator */
  {0, 0, (int (*)(...))&tPListIterator::Value},    /* @0x80056344  Value__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::TextValue},    /* @0x8005634c  TextValue__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::Increment},    /* @0x80056354  Increment__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::Decrement},    /* @0x8005635c  Decrement__14tPListIterator7tPlayer */
};
