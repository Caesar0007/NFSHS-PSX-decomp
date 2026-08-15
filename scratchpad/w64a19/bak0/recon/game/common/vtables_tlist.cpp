/* vtables_tlist.cpp -- #75 data-materialization: tList-family vtables (10), faithful member-cast.
 * Real nfs4-f.exe bytes + REAL method addresses: (int(*)(...))&Class::method; overloaded methods
 * use a typed member-pointer cast (ret from header, params from mangle). @0xVA breadcrumbs. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

static int _vtdtor_tListIterator(tListIterator *p){ p->~tListIterator(); return 0; }
static int _vtdtor_tListIteratorCar(tListIteratorCar *p){ p->~tListIteratorCar(); return 0; }
static int _vtdtor_tListIteratorCarColor(tListIteratorCarColor *p){ p->~tListIteratorCarColor(); return 0; }
static int _vtdtor_tListIteratorDoubleIndexed(tListIteratorDoubleIndexed *p){ p->~tListIteratorDoubleIndexed(); return 0; }
static int _vtdtor_tListIteratorIndexed(tListIteratorIndexed *p){ p->~tListIteratorIndexed(); return 0; }
static int _vtdtor_tListIteratorMultiPlayer(tListIteratorMultiPlayer *p){ p->~tListIteratorMultiPlayer(); return 0; }
static int _vtdtor_tListIteratorRange(tListIteratorRange *p){ p->~tListIteratorRange(); return 0; }
static int _vtdtor_tListIteratorRangeIndexed(tListIteratorRangeIndexed *p){ p->~tListIteratorRangeIndexed(); return 0; }
static int _vtdtor_tListIteratorTournament(tListIteratorTournament *p){ p->~tListIteratorTournament(); return 0; }
static int _vtdtor_tListIteratorTrack(tListIteratorTrack *p){ p->~tListIteratorTrack(); return 0; }

__vtbl_ptr_type tListIteratorCarColor_vtable[6] = {   /* @0x800101d8 */
  {0, 0, (int (*)(...))0},    /* @0x800101d8  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorCarColor},    /* @0x800101e0  ~tListIteratorCarColor */
  {0, 0, (int (*)(...))&tListIteratorCarColor::Value},    /* @0x800101e8  Value__21tListIteratorCarColor7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCarColor::TextValue},    /* @0x800101f0  TextValue__21tListIteratorCarColor7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCarColor::Increment},    /* @0x800101f8  Increment__21tListIteratorCarColor7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCarColor::Decrement},    /* @0x80010200  Decrement__21tListIteratorCarColor7tPlayer */
};
__vtbl_ptr_type tListIteratorCar_vtable[6] = {   /* @0x80010208 */
  {0, 0, (int (*)(...))0},    /* @0x80010208  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorCar},    /* @0x80010210  ~tListIteratorCar */
  {0, 0, (int (*)(...))&tListIteratorCar::Value},    /* @0x80010218  Value__16tListIteratorCar7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCar::TextValue},    /* @0x80010220  TextValue__16tListIteratorCar7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCar::Increment},    /* @0x80010228  Increment__16tListIteratorCar7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorCar::Decrement},    /* @0x80010230  Decrement__16tListIteratorCar7tPlayer */
};
__vtbl_ptr_type tListIteratorDoubleIndexed_vtable[6] = {   /* @0x80011368 */
  {0, 0, (int (*)(...))0},    /* @0x80011368  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorDoubleIndexed},    /* @0x80011370  ~tListIteratorDoubleIndexed */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Value},    /* @0x80011378  Value__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::TextValue},    /* @0x80011380  TextValue__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Increment},    /* @0x80011388  Increment__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Decrement},    /* @0x80011390  Decrement__26tListIteratorDoubleIndexed7tPlayer */
};
__vtbl_ptr_type tListIteratorIndexed_vtable[6] = {   /* @0x80011398 */
  {0, 0, (int (*)(...))0},    /* @0x80011398  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorIndexed},    /* @0x800113a0  ~tListIteratorIndexed */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Value},    /* @0x800113a8  Value__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::TextValue},    /* @0x800113b0  TextValue__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Increment},    /* @0x800113b8  Increment__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Decrement},    /* @0x800113c0  Decrement__20tListIteratorIndexed7tPlayer */
};
__vtbl_ptr_type tListIteratorMultiPlayer_vtable[6] = {   /* @0x80011338 */
  {0, 0, (int (*)(...))0},    /* @0x80011338  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorMultiPlayer},    /* @0x80011340  ~tListIteratorMultiPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Value},    /* @0x80011348  Value__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::TextValue},    /* @0x80011350  TextValue__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Increment},    /* @0x80011358  Increment__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Decrement},    /* @0x80011360  Decrement__24tListIteratorMultiPlayer7tPlayer */
};
__vtbl_ptr_type tListIteratorRangeIndexed_vtable[6] = {   /* @0x800112d8 */
  {0, 0, (int (*)(...))0},    /* @0x800112d8  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorRangeIndexed},    /* @0x800112e0  ~tListIteratorRangeIndexed */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Value},    /* @0x800112e8  Value__25tListIteratorRangeIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::TextValue},    /* @0x800112f0  TextValue__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Increment},    /* @0x800112f8  Increment__25tListIteratorRangeIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Decrement},    /* @0x80011300  Decrement__25tListIteratorRangeIndexed7tPlayer */
};
__vtbl_ptr_type tListIteratorRange_vtable[6] = {   /* @0x80011308 */
  {0, 0, (int (*)(...))0},    /* @0x80011308  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorRange},    /* @0x80011310  ~tListIteratorRange */
  {0, 0, (int (*)(...))&tListIteratorRange::Value},    /* @0x80011318  Value__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::TextValue},    /* @0x80011320  TextValue__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::Increment},    /* @0x80011328  Increment__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::Decrement},    /* @0x80011330  Decrement__18tListIteratorRange7tPlayer */
};
__vtbl_ptr_type tListIteratorTournament_vtable[6] = {   /* @0x80011670 */
  {0, 0, (int (*)(...))0},    /* @0x80011670  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorTournament},    /* @0x80011678  ~tListIteratorTournament */
  {0, 0, (int (*)(...))&tListIteratorTournament::Value},    /* @0x80011680  Value__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::TextValue},    /* @0x80011688  TextValue__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::Increment},    /* @0x80011690  Increment__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::Decrement},    /* @0x80011698  Decrement__23tListIteratorTournament7tPlayer */
};
__vtbl_ptr_type tListIteratorTrack_vtable[6] = {   /* @0x80010fe8 */
  {0, 0, (int (*)(...))0},    /* @0x80010fe8  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIteratorTrack},    /* @0x80010ff0  ~tListIteratorTrack */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Value},    /* @0x80010ff8  Value__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTrack::TextValue},    /* @0x80011000  TextValue__18tListIteratorTrack7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTrack::Increment},    /* @0x80011008  Increment__18tListIteratorTrack7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTrack::Decrement},    /* @0x80011010  Decrement__18tListIteratorTrack7tPlayer */
};
__vtbl_ptr_type tListIterator_vtable[6] = {   /* @0x800113c8 */
  {0, 0, (int (*)(...))0},    /* @0x800113c8  null */
  {0, 0, (int (*)(...))&_vtdtor_tListIterator},    /* @0x800113d0  ~tListIterator */
  {0, 0, (int (*)(...))&tListIterator::Value},    /* @0x800113d8  Value__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::TextValue},    /* @0x800113e0  TextValue__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::Increment},    /* @0x800113e8  Increment__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::Decrement},    /* @0x800113f0  Decrement__13tListIterator7tPlayer */
};
