/* game/common/vtables_aidatarecord.cpp -- #75 data-materialization: AIDataRecord-family vtables (6).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type; size = null-delimited rodata segment. @0xVA breadcrumbs.
 * CarTracking_t has 4 slots (virtual Get); others 3. NOT original layout; self-contained + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___14AIDataRecord_t(void *thisp);   /* ~AIDataRecord_t */
extern "C" void ___23AIDataRecord_AccTable_t(void *thisp);   /* ~AIDataRecord_AccTable_t */
extern "C" void ___23AIDataRecord_BestLine_t(void *thisp);   /* ~AIDataRecord_BestLine_t */
extern "C" void ___25AIDataRecord_TrackCurve_t(void *thisp);   /* ~AIDataRecord_TrackCurve_t */
extern "C" void ___26AIDataRecord_CarTracking_t(void *thisp);   /* ~AIDataRecord_CarTracking_t */
extern "C" void ___30AIDataRecord_CurveSpeedTable_t(void *thisp);   /* ~AIDataRecord_CurveSpeedTable_t */

__vtbl_ptr_type AIDataRecord_CarTracking_t_vtable[4] = {   /* @0x8005542c */
  {0, 0, (int (*)(...))0},                           /* @0x8005542c  null */
  {0, 0, (int (*)(...))&___26AIDataRecord_CarTracking_t}, /* @0x80055434  ~AIDataRecord_CarTracking_t */
  {0, 0, (int (*)(...))&AIDataRecord_t::Setup},      /* @0x8005543c  Setup__14AIDataRecord_t */
  {0, 0, (int (*)(...))&AIDataRecord_CarTracking_t::Get}, /* @0x80055444  Get__26AIDataRecord_CarTracking_ti */
};
__vtbl_ptr_type AIDataRecord_CurveSpeedTable_t_vtable[3] = {   /* @0x8005544c */
  {0, 0, (int (*)(...))0},                           /* @0x8005544c  null */
  {0, 0, (int (*)(...))&___30AIDataRecord_CurveSpeedTable_t}, /* @0x80055454  ~AIDataRecord_CurveSpeedTable_t */
  {0, 0, (int (*)(...))&AIDataRecord_t::Setup},      /* @0x8005545c  Setup__14AIDataRecord_t */
};
__vtbl_ptr_type AIDataRecord_TrackCurve_t_vtable[3] = {   /* @0x80055464 */
  {0, 0, (int (*)(...))0},                           /* @0x80055464  null */
  {0, 0, (int (*)(...))&___25AIDataRecord_TrackCurve_t}, /* @0x8005546c  ~AIDataRecord_TrackCurve_t */
  {0, 0, (int (*)(...))&AIDataRecord_t::Setup},      /* @0x80055474  Setup__14AIDataRecord_t */
};
__vtbl_ptr_type AIDataRecord_BestLine_t_vtable[3] = {   /* @0x8005547c */
  {0, 0, (int (*)(...))0},                           /* @0x8005547c  null */
  {0, 0, (int (*)(...))&___23AIDataRecord_BestLine_t}, /* @0x80055484  ~AIDataRecord_BestLine_t */
  {0, 0, (int (*)(...))&AIDataRecord_t::Setup},      /* @0x8005548c  Setup__14AIDataRecord_t */
};
__vtbl_ptr_type AIDataRecord_AccTable_t_vtable[3] = {   /* @0x80055494 */
  {0, 0, (int (*)(...))0},                           /* @0x80055494  null */
  {0, 0, (int (*)(...))&___23AIDataRecord_AccTable_t}, /* @0x8005549c  ~AIDataRecord_AccTable_t */
  {0, 0, (int (*)(...))&AIDataRecord_AccTable_t::Setup}, /* @0x800554a4  Setup__23AIDataRecord_AccTable_t */
};
__vtbl_ptr_type AIDataRecord_t_vtable[3] = {   /* @0x800554ac */
  {0, 0, (int (*)(...))0},                           /* @0x800554ac  null */
  {0, 0, (int (*)(...))&___14AIDataRecord_t},     /* @0x800554b4  ~AIDataRecord_t */
  {0, 0, (int (*)(...))&AIDataRecord_t::Setup},      /* @0x800554bc  Setup__14AIDataRecord_t */
};
