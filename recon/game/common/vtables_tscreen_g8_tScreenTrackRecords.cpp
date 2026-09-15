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
__vtbl_ptr_type tScreenTrackRecords_vtable[10] = {   /* @0x80011ff0 */
  {0, 0, (int (*)(...))0},                           /* @0x80011ff0  null */
  {0, 0, (int (*)(...))&tScreenTrackRecords::GetShapeInfo}, /* @0x80011ff8  GetShapeInfo__19tScreenTrackRecordsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenTrackRecords::DrawBackground}, /* @0x80012000  DrawBackground__19tScreenTrackRecords */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80012008  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___19tScreenTrackRecords}, /* @0x80012010  ~tScreenTrackRecords */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80012018  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenTrackRecords::Initialize}, /* @0x80012020  Initialize__19tScreenTrackRecords */
  {0, 0, (int (*)(...))&tScreenTrackRecords::Cleanup}, /* @0x80012028  Cleanup__19tScreenTrackRecords */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80012030  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreen::ProcessInput},      /* @0x80012038  ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
