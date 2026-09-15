/* vtables_tscreen2.cpp -- #75 data-materialization: tScreen2-family vtables (8), faithful member-cast.
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
extern "C" void ___12tScreenAudio(void *thisp);   /* ~tScreenAudio */
extern "C" void ___14tScreenMemcard(void *thisp);   /* ~tScreenMemcard */
extern "C" void ___15tScreenCongrats(void *thisp);   /* ~tScreenCongrats */
extern "C" void ___16tScreenCarSelect(void *thisp);   /* ~tScreenCarSelect */
extern "C" void ___17tScreenTrophyRoom(void *thisp);   /* ~tScreenTrophyRoom */
extern "C" void ___18tScreenTournSelect(void *thisp);   /* ~tScreenTournSelect */
extern "C" void ___23tScreenControllerConfig(void *thisp);   /* ~tScreenControllerConfig */
extern "C" void ___26tScreenTournamentStandings(void *thisp);   /* ~tScreenTournamentStandings */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tScreenCarSelect_vtable[16] = {   /* @0x80011d08 */
  {0, 0, (int (*)(...))0},    /* @0x80011d08  null */
  {0, 0, (int (*)(...))&tScreenCarSelect::GetShapeInfo},    /* @0x80011d10  GetShapeInfo__16tScreenCarSelectRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCarSelect::DrawBackground},    /* @0x80011d18  DrawBackground__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelect::DrawForeground},    /* @0x80011d20  DrawForeground__16tScreenCarSelect */
  {0, 0, (int (*)(...))&___16tScreenCarSelect},    /* @0x80011d28  ~tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80011d30  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCarSelect::Initialize},    /* @0x80011d38  Initialize__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelect::Cleanup},    /* @0x80011d40  Cleanup__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80011d48  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCarSelect::ProcessInput},    /* @0x80011d50  ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenCarSelect::DrawVideoWall},    /* @0x80011d58  DrawVideoWall__16tScreenCarSelects */
  {0, 0, (int (*)(...))&tScreenCarSelect::InitializeVideoWall},    /* @0x80011d60  InitializeVideoWall__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelect::UpdateVideoWall},    /* @0x80011d68  UpdateVideoWall__16tScreenCarSelectR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelect::GetCar},    /* @0x80011d70  GetCar__16tScreenCarSelectR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelect::AllocateAsyncBuffer},    /* @0x80011d78  AllocateAsyncBuffer__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelect::FreeAsyncBuffer},    /* @0x80011d80  FreeAsyncBuffer__16tScreenCarSelect */
};
