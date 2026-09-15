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
__vtbl_ptr_type tScreenMain_vtable[10] = {   /* @0x800118b0 */
  {0, 0, (int (*)(...))0},                           /* @0x800118b0  null */
  {0, 0, (int (*)(...))&tScreenMain::GetShapeInfo},  /* @0x800118b8  GetShapeInfo__11tScreenMainRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenMain::DrawBackground}, /* @0x800118c0  DrawBackground__11tScreenMain */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x800118c8  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___11tScreenMain},        /* @0x800118d0  ~tScreenMain */
  {0, 0, (int (*)(...))&tScreenMain::PreLoad},       /* @0x800118d8  PreLoad__11tScreenMain */
  {0, 0, (int (*)(...))&tScreenMain::Initialize},    /* @0x800118e0  Initialize__11tScreenMain */
  {0, 0, (int (*)(...))&tScreenMain::Cleanup},       /* @0x800118e8  Cleanup__11tScreenMain */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800118f0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenMain::ProcessInput},  /* @0x800118f8  ProcessInput__11tScreenMain7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
