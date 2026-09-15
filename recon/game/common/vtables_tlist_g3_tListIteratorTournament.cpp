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
__vtbl_ptr_type tListIteratorTournament_vtable[6] = {   /* @0x80011670 */
  {0, 0, (int (*)(...))0},    /* @0x80011670  null */
  {0, 0, (int (*)(...))&___23tListIteratorTournament},    /* @0x80011678  ~tListIteratorTournament */
  {0, 0, (int (*)(...))&tListIteratorTournament::Value},    /* @0x80011680  Value__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::TextValue},    /* @0x80011688  TextValue__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::Increment},    /* @0x80011690  Increment__23tListIteratorTournament7tPlayer */
  {0, 0, (int (*)(...))&tListIteratorTournament::Decrement},    /* @0x80011698  Decrement__23tListIteratorTournament7tPlayer */
};
