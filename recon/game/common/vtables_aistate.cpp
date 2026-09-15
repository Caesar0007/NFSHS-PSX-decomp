/* game/common/vtables_aistate.cpp -- #75 data-materialization: AIHigh-family vtables (12).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type (size=_vf[4]); pfn VAs symbolicated. @0xVA breadcrumbs.
 * NOT original layout (the obj owned each in its rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
/* aistate.obj carries its OWN out-of-line copies of the header-inline
 * AIState_Base::TestForRelease / AIState_NonActive::Execute/~ (retail
 * 0x80072830/0x80072750/0x80072758; aihigh.obj and aih_btccop.obj have
 * their own).  The aistate vtables point at aistate's copies; only the
 * AIState_None table (which lives in aihigh.obj's .rdata) uses aihigh's. */
extern "C" int TestForRelease__12AIState_Base_80072830(...);
extern "C" int Execute__17AIState_NonActive_80072750(...);
extern "C" void ___17AIState_NonActive_80072758(void *thisp);
extern "C" void ___12AIState_Base_80072838(void *thisp);   /* ~AIState_Base */
/* SS3.23 real-deleting-dtor free fns (___<N><Class>(Class*,int __in_chrg), aistate.cpp) --
   these 10 are no longer C++ member dtors (a real member dtor for this non-polymorphic
   single-inheritance shape always compiles to gcc's simple base-forward, not the oracle's
   per-class deleting dtor), so the vtable dtor slot points at the free fn directly; the
   __in_chrg=2 convention here (matching the "sub-object being destroyed, don't delete" call
   from a further-derived class's own dtor) mirrors the raw dtor-slot ABI: index 2 in the
   vtable always holds a fn taking (self,__in_chrg) and deciding whether to __builtin_delete. */
extern "C" void ___13AIState_Chase(AIState_Chase*,int);
extern "C" void ___14AIState_Cruise(AIState_Cruise*,int);
extern "C" void ___14AIState_Donuts(AIState_Donuts*,int);
extern "C" void ___17AIState_GotoSlice(AIState_GotoSlice*,int);
extern "C" void ___12AIState_Idle(AIState_Idle*,int);
extern "C" void ___17AIState_NonActive(AIState_NonActive*,int);
extern "C" void ___12AIState_None(AIState_None*,int);
extern "C" void ___14AIState_Normal(AIState_Normal*,int);
extern "C" void ___15AIState_Offroad(AIState_Offroad*,int);
extern "C" void ___17AIState_Purgatory(AIState_Purgatory*,int);
extern "C" void ___21AIState_RovingTraffic(AIState_RovingTraffic*,int);

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
/* Retail addresses and entries prove these tables; SYM omits their `_vt.*`
   records while retaining the other AIState tables.
   SYM-GLOBAL-CARRIER: AIState_None_vtable
   SYM-GLOBAL-CARRIER: AIState_NonActive_vtable
   SYM-GLOBAL-CARRIER: AIState_Base_vtable */
__vtbl_ptr_type AIState_None_vtable[4] = {   /* @0x80054e1c */
  {0, 0, (int (*)(...))0},                           /* @0x80054e1c  null */
  {0, 0, (int (*)(...))&AIState_None::Execute},      /* @0x80054e24  Execute__12AIState_None */
  {0, 0, (int (*)(...))&___12AIState_None},       /* @0x80054e2c  ~AIState_None */
  {0, 0, (int (*)(...))&AIState_Base::TestForRelease}, /* @0x80054e34  TestForRelease__12AIState_Base */
};
