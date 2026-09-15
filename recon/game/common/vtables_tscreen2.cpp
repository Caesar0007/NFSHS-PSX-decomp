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
__vtbl_ptr_type tScreenTournamentStandings_vtable[10] = {   /* @0x80011a48 */
  {0, 0, (int (*)(...))0},    /* @0x80011a48  null */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::GetShapeInfo},    /* @0x80011a50  GetShapeInfo__26tScreenTournamentStandingsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::DrawBackground},    /* @0x80011a58  DrawBackground__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80011a60  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___26tScreenTournamentStandings},    /* @0x80011a68  ~tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80011a70  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Initialize},    /* @0x80011a78  Initialize__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Cleanup},    /* @0x80011a80  Cleanup__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80011a88  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::ProcessInput},    /* @0x80011a90  ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
