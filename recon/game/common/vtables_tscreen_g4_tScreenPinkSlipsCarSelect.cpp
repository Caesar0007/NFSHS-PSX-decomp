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
__vtbl_ptr_type tScreenPinkSlipsCarSelect_vtable[18] = {   /* @0x80011b60 */
  {0, 0, (int (*)(...))0},                           /* @0x80011b60  null */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::GetShapeInfo}, /* @0x80011b68  GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::DrawBackground}, /* @0x80011b70  DrawBackground__25tScreenPinkSlipsCarSelect */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::DrawForeground}, /* @0x80011b78  DrawForeground__25tScreenPinkSlipsCarSelect */
  {0, 0, (int (*)(...))&___25tScreenPinkSlipsCarSelect}, /* @0x80011b80  ~tScreenPinkSlipsCarSelect */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80011b88  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::Initialize}, /* @0x80011b90  Initialize__25tScreenPinkSlipsCarSelect */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::Cleanup}, /* @0x80011b98  Cleanup__25tScreenPinkSlipsCarSelect */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80011ba0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::ProcessInput}, /* @0x80011ba8  ProcessInput__25tScreenPinkSlipsCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::DrawVideoWall}, /* @0x80011bb0  DrawVideoWall__25tScreenCarSelectTwoPlayers */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::InitializeVideoWall}, /* @0x80011bb8  InitializeVideoWall__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::UpdateVideoWall}, /* @0x80011bc0  UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::GetCar}, /* @0x80011bc8  GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::AllocateAsyncBuffer}, /* @0x80011bd0  AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelect::FreeAsyncBuffer}, /* @0x80011bd8  FreeAsyncBuffer__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::TurnOffVideoWall}, /* @0x80011be0  TurnOffVideoWall__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenPinkSlipsCarSelect::SetDialog}, /* @0x80011be8  SetDialog__25tScreenPinkSlipsCarSelect */
};
__vtbl_ptr_type tScreenCarSelectTwoPlayer_vtable[18] = {   /* @0x80011bf0 */
  {0, 0, (int (*)(...))0},                           /* @0x80011bf0  null */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::GetShapeInfo}, /* @0x80011bf8  GetShapeInfo__25tScreenCarSelectTwoPlayerRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::DrawBackground}, /* @0x80011c00  DrawBackground__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::DrawForeground}, /* @0x80011c08  DrawForeground__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&___25tScreenCarSelectTwoPlayer}, /* @0x80011c10  ~tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreen::PreLoad},           /* @0x80011c18  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::Initialize}, /* @0x80011c20  Initialize__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::Cleanup}, /* @0x80011c28  Cleanup__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80011c30  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCarSelect::ProcessInput}, /* @0x80011c38  ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::DrawVideoWall}, /* @0x80011c40  DrawVideoWall__25tScreenCarSelectTwoPlayers */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::InitializeVideoWall}, /* @0x80011c48  InitializeVideoWall__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::UpdateVideoWall}, /* @0x80011c50  UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::GetCar}, /* @0x80011c58  GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::AllocateAsyncBuffer}, /* @0x80011c60  AllocateAsyncBuffer__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelect::FreeAsyncBuffer}, /* @0x80011c68  FreeAsyncBuffer__16tScreenCarSelect */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::TurnOffVideoWall}, /* @0x80011c70  TurnOffVideoWall__25tScreenCarSelectTwoPlayer */
  {0, 0, (int (*)(...))&tScreenCarSelectTwoPlayer::SetDialog}, /* @0x80011c78  SetDialog__25tScreenCarSelectTwoPlayer */
};
__vtbl_ptr_type tScreenCarSelectDuel_vtable[17] = {   /* @0x80011c80 */
  {0, 0, (int (*)(...))0},                           /* @0x80011c80  null */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::GetShapeInfo}, /* @0x80011c88  GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::DrawBackground}, /* @0x80011c90  DrawBackground__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::DrawForeground}, /* @0x80011c98  DrawForeground__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&___20tScreenCarSelectDuel}, /* @0x80011ca0  ~tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::PreLoad}, /* @0x80011ca8  PreLoad__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::Initialize}, /* @0x80011cb0  Initialize__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::Cleanup}, /* @0x80011cb8  Cleanup__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished}, /* @0x80011cc0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCarSelect::ProcessInput}, /* @0x80011cc8  ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::DrawVideoWall}, /* @0x80011cd0  DrawVideoWall__20tScreenCarSelectDuels */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::InitializeVideoWall}, /* @0x80011cd8  InitializeVideoWall__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::UpdateVideoWall}, /* @0x80011ce0  UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelect::GetCar},   /* @0x80011ce8  GetCar__16tScreenCarSelectR8tCarInfo */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::AllocateAsyncBuffer}, /* @0x80011cf0  AllocateAsyncBuffer__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::FreeAsyncBuffer}, /* @0x80011cf8  FreeAsyncBuffer__20tScreenCarSelectDuel */
  {0, 0, (int (*)(...))&tScreenCarSelectDuel::DrawOpponentVideoWall}, /* @0x80011d00  DrawOpponentVideoWall__20tScreenCarSelectDuels */
};
