/* game/common/vtables_aihigh.cpp -- #75 data-materialization: AIHigh-family vtables (14).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type (size=_vf[3]); pfn VAs symbolicated. @0xVA breadcrumbs.
 * NOT original layout (the obj owned each in its rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___10AIHigh_Cop(void *thisp);   /* ~AIHigh_Cop */
extern "C" void ___11AIHigh_Base(void *thisp);   /* ~AIHigh_Base */
extern "C" void ___12AIHigh_Human(void *thisp);   /* ~AIHigh_Human */
extern "C" void ___13AIHigh_Player(void *thisp);   /* ~AIHigh_Player */
extern "C" void ___14AIHigh_BTC_Cop(void *thisp);   /* ~AIHigh_BTC_Cop */
extern "C" void ___14AIHigh_Traffic(void *thisp);   /* ~AIHigh_Traffic */
extern "C" void ___15AIHigh_BTC_Perp(void *thisp);   /* ~AIHigh_BTC_Perp */
/* aih_btcperp.obj carries its own out-of-line copy of the header-inline
 * ~AIHigh_BTC_Perp (retail 0x80061348); its vtable points at THAT copy, not
 * aihigh.obj's (0x8005b438). */
extern "C" void ___15AIHigh_BTC_Perp_80061348(void *thisp);
extern "C" void ___15AIHigh_BasicCop(void *thisp);   /* ~AIHigh_BasicCop */
extern "C" void ___15AIHigh_Opponent(void *thisp);   /* ~AIHigh_Opponent */
extern "C" void ___16AIHigh_BasicPerp(void *thisp);   /* ~AIHigh_BasicPerp */
extern "C" void ___17AIHigh_BTC_AIPerp(void *thisp);   /* ~AIHigh_BTC_AIPerp */
extern "C" void ___18AIHigh_BTC_Wingman(void *thisp);   /* ~AIHigh_BTC_Wingman */
extern "C" void ___19AIHigh_BTC_HumanCop(void *thisp);   /* ~AIHigh_BTC_HumanCop */
extern "C" void ___20AIHigh_BTC_HumanPerp(void *thisp);   /* ~AIHigh_BTC_HumanPerp */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type AIHigh_BTC_Perp_vtable[3] = {   /* @0x80054fe0 */
  {0, 0, (int (*)(...))0},                           /* @0x80054fe0  null */
  {0, 0, (int (*)(...))&__pure_virtual},             /* @0x80054fe8  __pure_virtual */
  {0, 0, (int (*)(...))&___15AIHigh_BTC_Perp_80061348},    /* @0x80054ff0  ~AIHigh_BTC_Perp */
};
