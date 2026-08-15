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

__vtbl_ptr_type tScreenAudio_vtable[10] = {   /* @0x80012158 */
  {0, 0, (int (*)(...))0},    /* @0x80012158  null */
  {0, 0, (int (*)(...))&tScreenAudio::GetShapeInfo},    /* @0x80012160  GetShapeInfo__12tScreenAudioRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenAudio::DrawBackground},    /* @0x80012168  DrawBackground__12tScreenAudio */
  {0, 0, (int (*)(...))&tScreenAudio::DrawForeground},    /* @0x80012170  DrawForeground__12tScreenAudio */
  {0, 0, (int (*)(...))&___12tScreenAudio},    /* @0x80012178  ~tScreenAudio */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80012180  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenAudio::Initialize},    /* @0x80012188  Initialize__12tScreenAudio */
  {0, 0, (int (*)(...))&tScreenAudio::Cleanup},    /* @0x80012190  Cleanup__12tScreenAudio */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80012198  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreen::ProcessInput},    /* @0x800121a0  ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
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
__vtbl_ptr_type tScreenCongrats_vtable[13] = {   /* @0x80012448 */
  {0, 0, (int (*)(...))0},    /* @0x80012448  null */
  {0, 0, (int (*)(...))&tScreenCongrats::GetShapeInfo},    /* @0x80012450  GetShapeInfo__15tScreenCongratsRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawBackground},    /* @0x80012458  DrawBackground__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::DrawForeground},    /* @0x80012460  DrawForeground__15tScreenCongrats */
  {0, 0, (int (*)(...))&___15tScreenCongrats},    /* @0x80012468  ~tScreenCongrats */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80012470  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::Initialize},    /* @0x80012478  Initialize__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreenCongrats::Cleanup},    /* @0x80012480  Cleanup__15tScreenCongrats */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80012488  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenCongrats::ProcessInput},    /* @0x80012490  ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand */
  {0, 0, (int (*)(...))&tScreenCongrats::CalculatePrizes},    /* @0x80012498  CalculatePrizes__15tScreenCongrats */
  {0, 0, (int (*)(...))&__pure_virtual},    /* @0x800124a0  __pure_virtual */
  {0, 0, (int (*)(...))&tScreenCongrats::GetCar},    /* @0x800124a8  GetCar__15tScreenCongratsR8tCarInfo */
};
__vtbl_ptr_type tScreenControllerConfig_vtable[10] = {   /* @0x80012078 */
  {0, 0, (int (*)(...))0},    /* @0x80012078  null */
  {0, 0, (int (*)(...))&tScreenControllerConfig::GetShapeInfo},    /* @0x80012080  GetShapeInfo__23tScreenControllerConfigRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenControllerConfig::DrawBackground},    /* @0x80012088  DrawBackground__23tScreenControllerConfig */
  {0, 0, (int (*)(...))&tScreenControllerConfig::DrawForeground},    /* @0x80012090  DrawForeground__23tScreenControllerConfig */
  {0, 0, (int (*)(...))&___23tScreenControllerConfig},    /* @0x80012098  ~tScreenControllerConfig */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x800120a0  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenControllerConfig::Initialize},    /* @0x800120a8  Initialize__23tScreenControllerConfig */
  {0, 0, (int (*)(...))&tScreenControllerConfig::Cleanup},    /* @0x800120b0  Cleanup__23tScreenControllerConfig */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x800120b8  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreen::ProcessInput},    /* @0x800120c0  ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
__vtbl_ptr_type tScreenMemcard_vtable[10] = {   /* @0x80012228 */
  {0, 0, (int (*)(...))0},    /* @0x80012228  null */
  {0, 0, (int (*)(...))&tScreenMemcard::GetShapeInfo},    /* @0x80012230  GetShapeInfo__14tScreenMemcardRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenMemcard::DrawBackground},    /* @0x80012238  DrawBackground__14tScreenMemcard */
  {0, 0, (int (*)(...))&tScreenMemcard::DrawForeground},    /* @0x80012240  DrawForeground__14tScreenMemcard */
  {0, 0, (int (*)(...))&___14tScreenMemcard},    /* @0x80012248  ~tScreenMemcard */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80012250  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenMemcard::Initialize},    /* @0x80012258  Initialize__14tScreenMemcard */
  {0, 0, (int (*)(...))&tScreenMemcard::Cleanup},    /* @0x80012260  Cleanup__14tScreenMemcard */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80012268  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreen::ProcessInput},    /* @0x80012270  ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
__vtbl_ptr_type tScreenTournSelect_vtable[10] = {   /* @0x80011db0 */
  {0, 0, (int (*)(...))0},    /* @0x80011db0  null */
  {0, 0, (int (*)(...))&tScreenTournSelect::GetShapeInfo},    /* @0x80011db8  GetShapeInfo__18tScreenTournSelectRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenTournSelect::DrawBackground},    /* @0x80011dc0  DrawBackground__18tScreenTournSelect */
  {0, 0, (int (*)(...))&tScreenTournSelect::DrawForeground},    /* @0x80011dc8  DrawForeground__18tScreenTournSelect */
  {0, 0, (int (*)(...))&___18tScreenTournSelect},    /* @0x80011dd0  ~tScreenTournSelect */
  {0, 0, (int (*)(...))&tScreen::PreLoad},    /* @0x80011dd8  PreLoad__7tScreen */
  {0, 0, (int (*)(...))&tScreenTournSelect::Initialize},    /* @0x80011de0  Initialize__18tScreenTournSelect */
  {0, 0, (int (*)(...))&tScreenTournSelect::Cleanup},    /* @0x80011de8  Cleanup__18tScreenTournSelect */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80011df0  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreen::ProcessInput},    /* @0x80011df8  ProcessInput__7tScreen7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
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
__vtbl_ptr_type tScreenTrophyRoom_vtable[10] = {   /* @0x80011e28 */
  {0, 0, (int (*)(...))0},    /* @0x80011e28  null */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::GetShapeInfo},    /* @0x80011e30  GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3 */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::DrawBackground},    /* @0x80011e38  DrawBackground__17tScreenTrophyRoom */
  {0, 0, (int (*)(...))&tScreen::DrawForeground},    /* @0x80011e40  DrawForeground__7tScreen */
  {0, 0, (int (*)(...))&___17tScreenTrophyRoom},    /* @0x80011e48  ~tScreenTrophyRoom */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::PreLoad},    /* @0x80011e50  PreLoad__17tScreenTrophyRoom */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::Initialize},    /* @0x80011e58  Initialize__17tScreenTrophyRoom */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::Cleanup},    /* @0x80011e60  Cleanup__17tScreenTrophyRoom */
  {0, 0, (int (*)(...))&tScreen::TransitionIsFinished},    /* @0x80011e68  TransitionIsFinished__7tScreen */
  {0, 0, (int (*)(...))&tScreenTrophyRoom::ProcessInput},    /* @0x80011e70  ProcessInput__17tScreenTrophyRoom7tPlayerR13tInputKeyTypeR12tMenuCommand */
};
