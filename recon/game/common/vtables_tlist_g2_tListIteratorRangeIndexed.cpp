/* vtables_tlist.cpp -- #75 data-materialization: tList-family vtables (10), faithful member-cast.
 * Real nfs4-f.exe bytes + REAL method addresses: (int(*)(...))&Class::method; overloaded methods
 * use a typed member-pointer cast (ret from header, params from mangle). @0xVA breadcrumbs. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds the destructor's OWN address (verified in
 * asm/data/rdata_80010000_r0*.rodata.s: `.word ___<len><Class>`), so the slots
 * below name the real `___<len><Class>` symbols directly.  The former fabricated
 * per-class wrappers `static int wrap(X *p){ p->~X(); return 0; }` are gone: they
 * were an artifact of C++ forbidding `&Class::~Class`.  Each symbol is a real fn
 * (w65-a3's extern-"C" dtor device / a real out-of-line member dtor renamed
 * `_._`->`___` by build.py), defined in fedialog/fecars/femenu/fetourn/fetracks. */
extern "C" void ___13tListIterator(void *thisp);   /* ~tListIterator */
extern "C" void ___16tListIteratorCar(void *thisp);   /* ~tListIteratorCar */
extern "C" void ___21tListIteratorCarColor(void *thisp);   /* ~tListIteratorCarColor */
extern "C" void ___26tListIteratorDoubleIndexed(void *thisp);   /* ~tListIteratorDoubleIndexed */
extern "C" void ___20tListIteratorIndexed(void *thisp);   /* ~tListIteratorIndexed */
extern "C" void ___24tListIteratorMultiPlayer(void *thisp);   /* ~tListIteratorMultiPlayer */
extern "C" void ___18tListIteratorRange(void *thisp);   /* ~tListIteratorRange */
extern "C" void ___25tListIteratorRangeIndexed(void *thisp);   /* ~tListIteratorRangeIndexed */
extern "C" void ___23tListIteratorTournament(void *thisp);   /* ~tListIteratorTournament */
extern "C" void ___18tListIteratorTrack(void *thisp);   /* ~tListIteratorTrack */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tListIteratorRangeIndexed_vtable[6] = {   /* @0x800112d8 */
  {0, 0, (int (*)(...))0},    /* @0x800112d8  null */
  {0, 0, (int (*)(...))&___25tListIteratorRangeIndexed},    /* @0x800112e0  ~tListIteratorRangeIndexed */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Value},    /* @0x800112e8  Value__25tListIteratorRangeIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::TextValue},    /* @0x800112f0  TextValue__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Increment},    /* @0x800112f8  Increment__25tListIteratorRangeIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRangeIndexed::Decrement},    /* @0x80011300  Decrement__25tListIteratorRangeIndexed7tPlayer */
};
__vtbl_ptr_type tListIteratorRange_vtable[6] = {   /* @0x80011308 */
  {0, 0, (int (*)(...))0},    /* @0x80011308  null */
  {0, 0, (int (*)(...))&___18tListIteratorRange},    /* @0x80011310  ~tListIteratorRange */
  {0, 0, (int (*)(...))&tListIteratorRange::Value},    /* @0x80011318  Value__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::TextValue},    /* @0x80011320  TextValue__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::Increment},    /* @0x80011328  Increment__18tListIteratorRange7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorRange::Decrement},    /* @0x80011330  Decrement__18tListIteratorRange7tPlayer */
};
__vtbl_ptr_type tListIteratorMultiPlayer_vtable[6] = {   /* @0x80011338 */
  {0, 0, (int (*)(...))0},    /* @0x80011338  null */
  {0, 0, (int (*)(...))&___24tListIteratorMultiPlayer},    /* @0x80011340  ~tListIteratorMultiPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Value},    /* @0x80011348  Value__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::TextValue},    /* @0x80011350  TextValue__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Increment},    /* @0x80011358  Increment__24tListIteratorMultiPlayer7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorMultiPlayer::Decrement},    /* @0x80011360  Decrement__24tListIteratorMultiPlayer7tPlayer */
};
__vtbl_ptr_type tListIteratorDoubleIndexed_vtable[6] = {   /* @0x80011368 */
  {0, 0, (int (*)(...))0},    /* @0x80011368  null */
  {0, 0, (int (*)(...))&___26tListIteratorDoubleIndexed},    /* @0x80011370  ~tListIteratorDoubleIndexed */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Value},    /* @0x80011378  Value__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::TextValue},    /* @0x80011380  TextValue__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Increment},    /* @0x80011388  Increment__26tListIteratorDoubleIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorDoubleIndexed::Decrement},    /* @0x80011390  Decrement__26tListIteratorDoubleIndexed7tPlayer */
};
__vtbl_ptr_type tListIteratorIndexed_vtable[6] = {   /* @0x80011398 */
  {0, 0, (int (*)(...))0},    /* @0x80011398  null */
  {0, 0, (int (*)(...))&___20tListIteratorIndexed},    /* @0x800113a0  ~tListIteratorIndexed */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Value},    /* @0x800113a8  Value__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::TextValue},    /* @0x800113b0  TextValue__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Increment},    /* @0x800113b8  Increment__20tListIteratorIndexed7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorIndexed::Decrement},    /* @0x800113c0  Decrement__20tListIteratorIndexed7tPlayer */
};
__vtbl_ptr_type tListIterator_vtable[6] = {   /* @0x800113c8 */
  {0, 0, (int (*)(...))0},    /* @0x800113c8  null */
  {0, 0, (int (*)(...))&___13tListIterator},    /* @0x800113d0  ~tListIterator */
  {0, 0, (int (*)(...))&tListIterator::Value},    /* @0x800113d8  Value__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::TextValue},    /* @0x800113e0  TextValue__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::Increment},    /* @0x800113e8  Increment__13tListIterator7tPlayer */
  {0, 0, (int (*)(...))&tListIterator::Decrement},    /* @0x800113f0  Decrement__13tListIterator7tPlayer */
};
