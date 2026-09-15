/* vtables_tdialog.cpp -- #75 data-materialization: tDialog-family vtables (9).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type; size = null-delimited rodata segment. @0xVA breadcrumbs.
 * NOT original layout (each obj owned its vtable in rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds the destructor's OWN address (verified in
 * asm/data/rdata_80010000_r0*.rodata.s: `.word ___<len><Class>`), so the slots
 * below name the real `___<len><Class>` symbols directly.  The former fabricated
 * per-class wrappers `static int wrap(X *p){ p->~X(); return 0; }` are gone: they
 * were an artifact of C++ forbidding `&Class::~Class`.  Each symbol is a real fn
 * (w65-a3's extern-"C" dtor device / a real out-of-line member dtor renamed
 * `_._`->`___` by build.py), defined in fedialog/fecars/femenu/fetourn/fetracks. */
extern "C" void ___17tDialogBackUpOnly(void *thisp);   /* ~tDialogBackUpOnly */
extern "C" void ___11tDialogBase(void *thisp);   /* ~tDialogBase */
extern "C" void ___11tDialogHelp(void *thisp);   /* ~tDialogHelp */
extern "C" void ___18tDialogInteractive(void *thisp);   /* ~tDialogInteractive */
extern "C" void ___20tDialogMessageString(void *thisp);   /* ~tDialogMessageString */
extern "C" void ___31tDialogMessageStringWithTimeout(void *thisp);   /* ~tDialogMessageStringWithTimeout */
extern "C" void ___21tDialogNoInputMessage(void *thisp);   /* ~tDialogNoInputMessage */
extern "C" void ___12tDialogYesNo(void *thisp);   /* ~tDialogYesNo */
extern "C" void ___15tDialogYesNoMem(void *thisp);   /* ~tDialogYesNoMem */
extern "C" void ___15tDialogYesNoTri(void *thisp);   /* ~tDialogYesNoTri */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
/* tDialogMessageStringWithTimeout vtable @0x80010098 (M10): byte-identical to tDialogMessageString_vtable
 * EXCEPT slot 4 (dtor) = ~tDialogMessageStringWithTimeout (@0x80015760) vs ~tDialogMessageString. Verified
 * by per-slot fnptr compare against nfs4-f.exe @0x80010098 vs @0x800104F0 (11/12 identical). */
__vtbl_ptr_type tDialogMessageStringWithTimeout_vtable[12] = {   /* @0x80010098 */
  {0, 0, (int (*)(...))0},                           /* @0x80010098  null */
  {0, 0, (int (*)(...))&tScreen::GetShapeInfo},      /* @0x800100a0  GetShapeInfo__7tScreenRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreen::DrawBackground},    /* @0x800100a8  DrawBackground__7tScreen */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800100b0  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___31tDialogMessageStringWithTimeout}, /* @0x800100b8  ~tDialogMessageStringWithTimeout (@0x80015760) */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800100c0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Initialize},        /* @0x800100c8  Initialize__7tScreen */
  {0, 0, (int (*)(...))&tScreen::Cleanup},           /* @0x800100d0  Cleanup__7tScreen */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800100d8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tDialogBase::ProcessInput},  /* @0x800100e0  ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tDialogMessageString::CalculateDimensions}, /* @0x800100e8  CalculateDimensions__20tDialogMessageString */
  {0, 0, (int (*)(...))&tDialogMessageString::Draw}, /* @0x800100f0  Draw__20tDialogMessageString */
};
