/* vtables_tpausemenu.cpp -- #75 data-materialization: tPauseMenu-family vtables (16), faithful member-cast.
 * Real nfs4-f.exe bytes + REAL method addresses: (int(*)(...))&Class::method; overloaded methods
 * use a typed member-pointer cast (ret from header, params from mangle). @0xVA breadcrumbs. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

static int _vtdtor_tInsideBoxControllerLeftRightSlider(tInsideBoxControllerLeftRightSlider *p){ p->~tInsideBoxControllerLeftRightSlider(); return 0; }
static int _vtdtor_tInsideBoxLeftRightSlider(tInsideBoxLeftRightSlider *p){ p->~tInsideBoxLeftRightSlider(); return 0; }
static int _vtdtor_tInsideBoxMenu(tInsideBoxMenu *p){ p->~tInsideBoxMenu(); return 0; }
static int _vtdtor_tInsideBoxSongMenu(tInsideBoxSongMenu *p){ p->~tInsideBoxSongMenu(); return 0; }
static int _vtdtor_tInsideBoxTwoWaySlider(tInsideBoxTwoWaySlider *p){ p->~tInsideBoxTwoWaySlider(); return 0; }
static int _vtdtor_tPListIterator(tPListIterator *p){ p->~tPListIterator(); return 0; }
static int _vtdtor_tPListIteratorIndexed(tPListIteratorIndexed *p){ p->~tPListIteratorIndexed(); return 0; }
static int _vtdtor_tPMenu(tPMenu *p){ p->~tPMenu(); return 0; }
static int _vtdtor_tPMenuItem(tPMenuItem *p){ p->~tPMenuItem(); return 0; }
static int _vtdtor_tPMenuItemCommandButton(tPMenuItemCommandButton *p){ p->~tPMenuItemCommandButton(); return 0; }
static int _vtdtor_tPMenuItemGoToMenuButton(tPMenuItemGoToMenuButton *p){ p->~tPMenuItemGoToMenuButton(); return 0; }
static int _vtdtor_tPMenuItemInteractive(tPMenuItemInteractive *p){ p->~tPMenuItemInteractive(); return 0; }
static int _vtdtor_tPMenuItemLeftRightChoice(tPMenuItemLeftRightChoice *p){ p->~tPMenuItemLeftRightChoice(); return 0; }
static int _vtdtor_tPMenuItemLeftRightSlider(tPMenuItemLeftRightSlider *p){ p->~tPMenuItemLeftRightSlider(); return 0; }
static int _vtdtor_tPMenuItemLeftRightSliderIndexed(tPMenuItemLeftRightSliderIndexed *p){ p->~tPMenuItemLeftRightSliderIndexed(); return 0; }
static int _vtdtor_tPMenuItemNonInteractiveText(tPMenuItemNonInteractiveText *p){ p->~tPMenuItemNonInteractiveText(); return 0; }

__vtbl_ptr_type tInsideBoxControllerLeftRightSlider_vtable[11] = {   /* @0x80010a10 */
  {0, 0, (int (*)(...))0},    /* @0x80010a10  null */
  {0, 0, (int (*)(...))&_vtdtor_tInsideBoxControllerLeftRightSlider},    /* @0x80010a18  ~tInsideBoxControllerLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010a20  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tInsideBoxControllerLeftRightSlider::ProcessInput},    /* @0x80010a28  ProcessInput__35tInsideBoxControllerLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010a30  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(int (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010a38  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))&tInsideBoxLeftRightSlider::Draw},    /* @0x80010a40  Draw__25tInsideBoxLeftRightSlideriiib */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010a48  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010a50  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010a58  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010a60  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tInsideBoxLeftRightSlider_vtable[11] = {   /* @0x80010bc8 */
  {0, 0, (int (*)(...))0},    /* @0x80010bc8  null */
  {0, 0, (int (*)(...))&_vtdtor_tInsideBoxLeftRightSlider},    /* @0x80010bd0  ~tInsideBoxLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010bd8  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::ProcessInput},    /* @0x80010be0  ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010be8  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(int (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010bf0  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))&tInsideBoxLeftRightSlider::Draw},    /* @0x80010bf8  Draw__25tInsideBoxLeftRightSlideriiib */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010c00  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010c08  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010c10  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010c18  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tInsideBoxMenu_vtable[12] = {   /* @0x80010ea8 */
  {0, 0, (int (*)(...))0},    /* @0x80010ea8  null */
  {0, 0, (int (*)(...))&_vtdtor_tInsideBoxMenu},    /* @0x80010eb0  ~tInsideBoxMenu */
  {0, 0, (int (*)(...))&tMenu::Initialize},    /* @0x80010eb8  Initialize__5tMenu */
  {0, 0, (int (*)(...))&tInsideBoxMenu::ProcessInput},    /* @0x80010ec0  ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenu::DebounceKeys},    /* @0x80010ec8  DebounceKeys__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOff},    /* @0x80010ed0  TransitionOff__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionOn},    /* @0x80010ed8  TransitionOn__5tMenu */
  {0, 0, (int (*)(...))&tMenu::TransitionIsFinished},    /* @0x80010ee0  TransitionIsFinished__5tMenu */
  {0, 0, (int (*)(...))&tMenu::IsSubMenu},    /* @0x80010ee8  IsSubMenu__5tMenu */
  {0, 0, (int (*)(...))&tMenu::Draw},    /* @0x80010ef0  Draw__5tMenu */
  {0, 0, (int (*)(...))&tMenu::UpdateTransition},    /* @0x80010ef8  UpdateTransition__5tMenu */
  {0, 0, (int (*)(...))&tInsideBoxMenu::Draw},    /* @0x80010f00  Draw__14tInsideBoxMenusssss */
};
__vtbl_ptr_type tInsideBoxSongMenu_vtable[13] = {   /* @0x80010c78 */
  {0, 0, (int (*)(...))0},    /* @0x80010c78  null */
  {0, 0, (int (*)(...))&_vtdtor_tInsideBoxSongMenu},    /* @0x80010c80  ~tInsideBoxSongMenu */
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
__vtbl_ptr_type tInsideBoxTwoWaySlider_vtable[11] = {   /* @0x80010b70 */
  {0, 0, (int (*)(...))0},    /* @0x80010b70  null */
  {0, 0, (int (*)(...))&_vtdtor_tInsideBoxTwoWaySlider},    /* @0x80010b78  ~tInsideBoxTwoWaySlider */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::DebounceKeys},    /* @0x80010b80  DebounceKeys__24tMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tInsideBoxTwoWaySlider::ProcessInput},    /* @0x80010b88  ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tMenuItemLeftRightSlider::Draw},    /* @0x80010b90  Draw__24tMenuItemLeftRightSliderb */
  {0, 0, (int (*)(...))(int (tMenuItem::*)(int, int, bool))&tMenuItem::Draw},    /* @0x80010b98  Draw__9tMenuItemiib [overload] */
  {0, 0, (int (*)(...))&tInsideBoxTwoWaySlider::Draw},    /* @0x80010ba0  Draw__22tInsideBoxTwoWaySlideriiib */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOff},    /* @0x80010ba8  TransitionOff__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionOn},    /* @0x80010bb0  TransitionOn__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::TransitionIsFinished},    /* @0x80010bb8  TransitionIsFinished__9tMenuItem */
  {0, 0, (int (*)(...))&tMenuItem::UpdateTransition},    /* @0x80010bc0  UpdateTransition__9tMenuItemb */
};
__vtbl_ptr_type tPListIteratorIndexed_vtable[6] = {   /* @0x80056304 */
  {0, 0, (int (*)(...))0},    /* @0x80056304  null */
  {0, 0, (int (*)(...))&_vtdtor_tPListIteratorIndexed},    /* @0x8005630c  ~tPListIteratorIndexed */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Value},    /* @0x80056314  Value__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::TextValue},    /* @0x8005631c  TextValue__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Increment},    /* @0x80056324  Increment__21tPListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tPListIteratorIndexed::Decrement},    /* @0x8005632c  Decrement__21tPListIteratorIndexed7tPlayer */
};
__vtbl_ptr_type tPListIterator_vtable[6] = {   /* @0x80056334 */
  {0, 0, (int (*)(...))0},    /* @0x80056334  null */
  {0, 0, (int (*)(...))&_vtdtor_tPListIterator},    /* @0x8005633c  ~tPListIterator */
  {0, 0, (int (*)(...))&tPListIterator::Value},    /* @0x80056344  Value__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::TextValue},    /* @0x8005634c  TextValue__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::Increment},    /* @0x80056354  Increment__14tPListIterator7tPlayer */
  {0, 0, (int (*)(...))&tPListIterator::Decrement},    /* @0x8005635c  Decrement__14tPListIterator7tPlayer */
};
__vtbl_ptr_type tPMenuItemCommandButton_vtable[7] = {   /* @0x80056144 */
  {0, 0, (int (*)(...))0},    /* @0x80056144  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemCommandButton},    /* @0x8005614c  ~tPMenuItemCommandButton */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x80056154  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x8005615c  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemCommandButton::ProcessInput},    /* @0x80056164  ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x8005616c  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x80056174  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemGoToMenuButton_vtable[7] = {   /* @0x8005617c */
  {0, 0, (int (*)(...))0},    /* @0x8005617c  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemGoToMenuButton},    /* @0x80056184  ~tPMenuItemGoToMenuButton */
  {0, 0, (int (*)(...))&tPMenuItemGoToMenuButton::NextMenu},    /* @0x8005618c  NextMenu__24tPMenuItemGoToMenuButton */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x80056194  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemGoToMenuButton::ProcessInput},    /* @0x8005619c  ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x800561a4  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x800561ac  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemInteractive_vtable[7] = {   /* @0x8005625c */
  {0, 0, (int (*)(...))0},    /* @0x8005625c  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemInteractive},    /* @0x80056264  ~tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x8005626c  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x80056274  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x8005627c  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x80056284  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::Draw},    /* @0x8005628c  Draw__21tPMenuItemInteractiveb */
};
__vtbl_ptr_type tPMenuItemLeftRightChoice_vtable[7] = {   /* @0x80056224 */
  {0, 0, (int (*)(...))0},    /* @0x80056224  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemLeftRightChoice},    /* @0x8005622c  ~tPMenuItemLeftRightChoice */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x80056234  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x8005623c  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightChoice::ProcessInput},    /* @0x80056244  ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x8005624c  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightChoice::Draw},    /* @0x80056254  Draw__25tPMenuItemLeftRightChoiceb */
};
__vtbl_ptr_type tPMenuItemLeftRightSliderIndexed_vtable[7] = {   /* @0x800561b4 */
  {0, 0, (int (*)(...))0},    /* @0x800561b4  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemLeftRightSliderIndexed},    /* @0x800561bc  ~tPMenuItemLeftRightSliderIndexed */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800561c4  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Debounce},    /* @0x800561cc  Debounce__25tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSliderIndexed::ProcessInput},    /* @0x800561d4  ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x800561dc  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSliderIndexed::Draw},    /* @0x800561e4  Draw__32tPMenuItemLeftRightSliderIndexedb */
};
__vtbl_ptr_type tPMenuItemLeftRightSlider_vtable[7] = {   /* @0x800561ec */
  {0, 0, (int (*)(...))0},    /* @0x800561ec  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemLeftRightSlider},    /* @0x800561f4  ~tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800561fc  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Debounce},    /* @0x80056204  Debounce__25tPMenuItemLeftRightSlider */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::ProcessInput},    /* @0x8005620c  ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemInteractive::IsNavigable},    /* @0x80056214  IsNavigable__21tPMenuItemInteractive */
  {0, 0, (int (*)(...))&tPMenuItemLeftRightSlider::Draw},    /* @0x8005621c  Draw__25tPMenuItemLeftRightSliderb */
};
__vtbl_ptr_type tPMenuItemNonInteractiveText_vtable[7] = {   /* @0x80056294 */
  {0, 0, (int (*)(...))0},    /* @0x80056294  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItemNonInteractiveText},    /* @0x8005629c  ~tPMenuItemNonInteractiveText */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800562a4  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x800562ac  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x800562b4  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenuItemNonInteractiveText::IsNavigable},    /* @0x800562bc  IsNavigable__28tPMenuItemNonInteractiveText */
  {0, 0, (int (*)(...))&tPMenuItemNonInteractiveText::Draw},    /* @0x800562c4  Draw__28tPMenuItemNonInteractiveTextb */
};
__vtbl_ptr_type tPMenuItem_vtable[7] = {   /* @0x800562cc */
  {0, 0, (int (*)(...))0},    /* @0x800562cc  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenuItem},    /* @0x800562d4  ~tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::NextMenu},    /* @0x800562dc  NextMenu__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::Debounce},    /* @0x800562e4  Debounce__10tPMenuItem */
  {0, 0, (int (*)(...))&tPMenuItem::ProcessInput},    /* @0x800562ec  ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800562f4  __pure_virtual */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800562fc  __pure_virtual */
};
__vtbl_ptr_type tPMenu_vtable[5] = {   /* @0x8005611c */
  {0, 0, (int (*)(...))0},    /* @0x8005611c  null */
  {0, 0, (int (*)(...))&_vtdtor_tPMenu},    /* @0x80056124  ~tPMenu */
  {0, 0, (int (*)(...))&tPMenu::Initialize},    /* @0x8005612c  Initialize__6tPMenu */
  {0, 0, (int (*)(...))&tPMenu::ProcessInput},    /* @0x80056134  ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand */
  {0, 0, (int (*)(...))&tPMenu::Draw},    /* @0x8005613c  Draw__6tPMenu */
};
