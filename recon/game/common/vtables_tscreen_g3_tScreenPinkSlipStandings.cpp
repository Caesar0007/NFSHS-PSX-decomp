/* vtables_tscreen.cpp -- #75 data-materialization: tScreen-family vtables (18).
 * Real nfs4-f.exe bytes; __vtbl_ptr_type; size = null-delimited rodata segment. @0xVA breadcrumbs.
 * NOT original layout (each obj owned its vtable in rodata); self-contained + faithful + links. */
#include "../../nfs4_types.h"
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */

/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___11tScreenMain(void *thisp);   /* ~tScreenMain */
extern "C" void ___14tScreenDisplay(void *thisp);   /* ~tScreenDisplay */
extern "C" void ___15tScreenUserName(void *thisp);   /* ~tScreenUserName */
extern "C" void ___16tScreenPinkSlips(void *thisp);   /* ~tScreenPinkSlips */
extern "C" void ___16tScreenTrackInfo(void *thisp);   /* ~tScreenTrackInfo */
extern "C" void ___17tScreenTrophyInfo(void *thisp);   /* ~tScreenTrophyInfo */
extern "C" void ___18tScreenTrackSelect(void *thisp);   /* ~tScreenTrackSelect */
extern "C" void ___19tScreenTrackRecords(void *thisp);   /* ~tScreenTrackRecords */
extern "C" void ___20tScreenCarSelectDuel(void *thisp);   /* ~tScreenCarSelectDuel */
extern "C" void ___23tScreenBeTheCopCongrats(void *thisp);   /* ~tScreenBeTheCopCongrats */
extern "C" void ___23tScreenPinkSlipCongrats(void *thisp);   /* ~tScreenPinkSlipCongrats */
extern "C" void ___23tScreenTournamentTrophy(void *thisp);   /* ~tScreenTournamentTrophy */
extern "C" void ___24tScreenPinkSlipStandings(void *thisp);   /* ~tScreenPinkSlipStandings */
extern "C" void ___25tScreenCarSelectTwoPlayer(void *thisp);   /* ~tScreenCarSelectTwoPlayer */
extern "C" void ___25tScreenPinkSlipsCarSelect(void *thisp);   /* ~tScreenPinkSlipsCarSelect */
extern "C" void ___25tScreenTournamentCongrats(void *thisp);   /* ~tScreenTournamentCongrats */
extern "C" void ___31tScreenTournamentStandings3item(void *thisp);   /* ~tScreenTournamentStandings3item */
extern "C" void ___7tScreen(void *thisp);   /* ~tScreen */

/* Blocks sorted by retail address (= g++ finish_file emission order, newest
 * class first) and SPLIT into contiguous retail runs, one TU per run, so each
 * run is placed/validated at its own retail base.  Do not merge or re-sort. */
__vtbl_ptr_type tScreenPinkSlipStandings_vtable[10] = {   /* @0x800119a8 */
  {0, 0, (int (*)(...))0},                           /* @0x800119a8  null */
  {0, 0, (int (*)(...))&tScreenTournamentStandings3item::GetShapeInfo}, /* @0x800119b0  GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenPinkSlipStandings::DrawBackground}, /* @0x800119b8  DrawBackground__24tScreenPinkSlipStandings */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800119c0  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___24tScreenPinkSlipStandings}, /* @0x800119c8  ~tScreenPinkSlipStandings */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800119d0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Initialize}, /* @0x800119d8  Initialize__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Cleanup}, /* @0x800119e0  Cleanup__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800119e8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenPinkSlipStandings::ProcessInput}, /* @0x800119f0  ProcessInput__24tScreenPinkSlipStandings7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
__vtbl_ptr_type tScreenTournamentStandings3item_vtable[10] = {   /* @0x800119f8 */
  {0, 0, (int (*)(...))0},                           /* @0x800119f8  null */
  {0, 0, (int (*)(...))&tScreenTournamentStandings3item::GetShapeInfo}, /* @0x80011a00  GetShapeInfo__31tScreenTournamentStandings3itemRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::DrawBackground}, /* @0x80011a08  DrawBackground__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80011a10  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___31tScreenTournamentStandings3item}, /* @0x80011a18  ~tScreenTournamentStandings3item */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80011a20  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Initialize}, /* @0x80011a28  Initialize__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::Cleanup}, /* @0x80011a30  Cleanup__26tScreenTournamentStandings */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80011a38  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentStandings::ProcessInput}, /* @0x80011a40  ProcessInput__26tScreenTournamentStandings7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
