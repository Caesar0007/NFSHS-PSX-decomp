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
__vtbl_ptr_type tScreenTournamentCongrats_vtable[13] = {   /* @0x800122a8 */
  {0, 0, (int (*)(...))0},                           /* @0x800122a8  null */
  {0, 0, (int (*)(...))&tScreenCongrats::GetShapeInfo}, /* @0x800122b0  GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawBackground}, /* @0x800122b8  DrawBackground__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawForeground}, /* @0x800122c0  DrawForeground__15tScreenCongrats */
  {0, 0, (int (*)(...))&___25tScreenTournamentCongrats}, /* @0x800122c8  ~tScreenTournamentCongrats */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800122d0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::Initialize}, /* @0x800122d8  Initialize__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::Cleanup},   /* @0x800122e0  Cleanup__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800122e8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::ProcessInput}, /* @0x800122f0  ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenTournamentCongrats::CalculatePrizes}, /* @0x800122f8  CalculatePrizes__25tScreenTournamentCongrats */
  {0, 0, (int (*)(...))&tScreenTournamentCongrats::DrawCongratsMessage}, /* @0x80012300  DrawCongratsMessage__25tScreenTournamentCongrats */
  {0, 0, (int (*)(...))&tScreenTournamentCongrats::GetCar}, /* @0x80012308  GetCar__25tScreenTournamentCongratsR8tCarInfo */
};
__vtbl_ptr_type tScreenBeTheCopCongrats_vtable[13] = {   /* @0x80012310 */
  {0, 0, (int (*)(...))0},                           /* @0x80012310  null */
  {0, 0, (int (*)(...))&tScreenCongrats::GetShapeInfo}, /* @0x80012318  GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawBackground}, /* @0x80012320  DrawBackground__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawForeground}, /* @0x80012328  DrawForeground__15tScreenCongrats */
  {0, 0, (int (*)(...))&___23tScreenBeTheCopCongrats}, /* @0x80012330  ~tScreenBeTheCopCongrats */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80012338  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::Initialize}, /* @0x80012340  Initialize__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::Cleanup},   /* @0x80012348  Cleanup__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80012350  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::ProcessInput}, /* @0x80012358  ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenBeTheCopCongrats::CalculatePrizes}, /* @0x80012360  CalculatePrizes__23tScreenBeTheCopCongrats */
  {0, 0, (int (*)(...))&tScreenBeTheCopCongrats::DrawCongratsMessage}, /* @0x80012368  DrawCongratsMessage__23tScreenBeTheCopCongrats */
  {0, 0, (int (*)(...))&tScreenBeTheCopCongrats::GetCar}, /* @0x80012370  GetCar__23tScreenBeTheCopCongratsR8tCarInfo */
};
__vtbl_ptr_type tScreenPinkSlipCongrats_vtable[13] = {   /* @0x80012378 */
  {0, 0, (int (*)(...))0},                           /* @0x80012378  null */
  {0, 0, (int (*)(...))&tScreenCongrats::GetShapeInfo}, /* @0x80012380  GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawBackground}, /* @0x80012388  DrawBackground__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawForeground}, /* @0x80012390  DrawForeground__15tScreenCongrats */
  {0, 0, (int (*)(...))&___23tScreenPinkSlipCongrats}, /* @0x80012398  ~tScreenPinkSlipCongrats */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x800123a0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenPinkSlipCongrats::Initialize}, /* @0x800123a8  Initialize__23tScreenPinkSlipCongrats */
  {0, 0, (int (*)(...))&tScreenPinkSlipCongrats::Cleanup}, /* @0x800123b0  Cleanup__23tScreenPinkSlipCongrats */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x800123b8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::ProcessInput}, /* @0x800123c0  ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenPinkSlipCongrats::CalculatePrizes}, /* @0x800123c8  CalculatePrizes__23tScreenPinkSlipCongrats */
  {0, 0, (int (*)(...))&tScreenPinkSlipCongrats::DrawCongratsMessage}, /* @0x800123d0  DrawCongratsMessage__23tScreenPinkSlipCongrats */
  {0, 0, (int (*)(...))&tScreenPinkSlipCongrats::GetCar}, /* @0x800123d8  GetCar__23tScreenPinkSlipCongratsR8tCarInfo */
};
__vtbl_ptr_type tScreenTournamentTrophy_vtable[13] = {   /* @0x800123e0 */
  {0, 0, (int (*)(...))0},                           /* @0x800123e0  null */
  {0, 0, (int (*)(...))&tScreenCongrats::GetShapeInfo}, /* @0x800123e8  GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawBackground}, /* @0x800123f0  DrawBackground__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawForeground}, /* @0x800123f8  DrawForeground__15tScreenCongrats */
  {0, 0, (int (*)(...))&___23tScreenTournamentTrophy}, /* @0x80012400  ~tScreenTournamentTrophy */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80012408  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::Initialize}, /* @0x80012410  Initialize__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::Cleanup},   /* @0x80012418  Cleanup__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80012420  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournamentTrophy::ProcessInput}, /* @0x80012428  ProcessInput__23tScreenTournamentTrophy7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenTournamentTrophy::CalculatePrizes}, /* @0x80012430  CalculatePrizes__23tScreenTournamentTrophy */
  {0, 0, (int (*)(...))&tScreenTournamentTrophy::DrawCongratsMessage}, /* @0x80012438  DrawCongratsMessage__23tScreenTournamentTrophy */
  {0, 0, (int (*)(...))&tScreenTournamentTrophy::GetCar}, /* @0x80012440  GetCar__23tScreenTournamentTrophyR8tCarInfo */
};
