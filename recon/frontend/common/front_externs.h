/* frontend/common/front_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FRONT_EXTERNS_H_
#define _FE_FRONT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern int          ticks;
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp[];
extern tGlobalMenuDefs *menuDefs[];
extern char        *Paths_Paths[];
extern tCarManager  carManager;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
extern tAllScreens *gAllScreens[];

/* ===== auto-generated stubs ===== */
int AddCarToIngameList(...);
int AdvanceToNextTrack(...);
int AudioMus_GetSongList(...);
int AudioMus_SysCleanUp(...);
int AudioMus_SysStartUp(...);
int AudioMus_Volume(...);
int Audio_FECleanUp(...);
int CarIO_CleanUpLicense(...);
int CarIO_CreateLicense(...);
int CheapestCarStockPrice(...);
int Controller_SetRamp(...);
int DeInit_Memcard(...);
int FECheat_IsCheatEnabled(...);
int FeAudio_DeInitCommentary(...);
int FeAudio_InitCommentary(...);
int FeTools_deinit(...);
int FindSimilarCar(...);
int GetCarFromID(...);
int GetClassList(...);
int GetGarageCar(...);
int GetLastTrackRaced(...);
int GetMissionStages(...);
int GetMissionToRace(...);
int GetNumOwnedCars(...);
int GetPinkSlipsCar(...);
int GetStockCar(...);
int GetTrack(...);
int GetTrackByID(...);
int GetTrackToRace(...);
int Init_Memcard(...);
int Init_PSX_FrontEnd(...);
int InitializeIngameCarList(...);
int InitializeSpinningCars(...);
int IsCarAnAddedModel(...);
int LoadDescription(...);
int LoadGame(...);
int MenuExtended_TransitionFromPostGameToMainMenu(...);
int PSXExitFrontend(...);
int Platform_ResetDCTBuffer(...);
int PlayerName(...);
int RunFrontEnd(...);
int RunPostGame(...);
int Setup(...);
int StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(...);
int Stattool_GetAllDefaultRecords(...);
int Stattool_ReturnRecordLapTime(...);
int TextSys_UnloadWords(...);
int TextSys_Word(...);
int UpdateAwardInformation(...);
int UpdateCarLineup(...);
int __builtin_new(...);
int s_lower(...);
tAllScreens *tAllScreens_ctor(...);
tAllScreens *tAllScreens_dtor(...);
tFEApplication *tFEApplication_ctor(...);
tFEApplication *tFEApplication_dtor(...);
tGlobalMenuDefs *tGlobalMenuDefs_ctor(...);
tGlobalMenuDefs *tGlobalMenuDefs_dtor(...);
tScreenAudio *tScreenAudio_ctor(...);
tScreenCarSelect *tScreenCarSelect_ctor(...);
tScreenCarSelect *tScreenCarSelect_dtor(...);
tScreenControllerConfig *tScreenControllerConfig_ctor(...);
tScreenMemcard *tScreenMemcard_ctor(...);
tScreenTournSelect *tScreenTournSelect_ctor(...);
tScreenTournSelect *tScreenTournSelect_dtor(...);
tScreenTournamentStandings *tScreenTournamentStandings_ctor(...);
tScreenTrophyRoom *tScreenTrophyRoom_ctor(...);
tScreenTrophyRoom *tScreenTrophyRoom_dtor(...);
tScreen *tScreen_ctor(...);
tScreen *tScreen_dtor(...);
extern Car_tStats Cars_gNewCarStatsList[];   /* was stale pointer; owner cars.cpp
                                     Car_tStats Cars_gNewCarStatsList[9] (array of value structs) --
                                     front.cpp indexes Cars_gNewCarStatsList[0].finalPosition; the
                                     pointer decl would load the array's own first bytes (real struct
                                     data) as a bogus pointer VALUE and dereference it */
extern int CountryMeasurement[16];
extern int CreditManager;
extern GameSetup_tData GameSetup_gData;
extern int MEMCARDFRONTENDISINITTED[];
extern int Stats_gTrackRecords;
extern int _7tScreen_fSuppressLoadingText;
extern int _i;
extern int _usePlayerUpgrades;
extern int colourChosen[8];
extern char gCalculateVictory;   /* was stale int (4B); owner nfs3.cpp defines it char (1B) packed
                                     tightly before gPlayerEnteredNameAlready[2] -- a wrong 4B `sw`
                                     here would clobber 3 adjacent bytes incl. that neighbor global */
extern int gFEBigHandle[];
extern int gLargestUnused;
extern int gMasterAmbientLevel;
extern int gMasterEngineLevel;
extern int gMasterFENarrationLevel;
extern int gMasterMusicLevel;
extern int gMasterSFXLevel;
extern int gPSXMemCardFull[];
extern tPadModuleState gPadinfo;
extern int gUseFrontend;
extern int mappings[3][13][3];
extern int memCardReadOK[];
extern int missionManager;
extern tCarModels regularCopModels[7][5];
extern tScreenAudio *screenAudio;
extern tScreenBeTheCopCongrats *screenBeTheCopCongrats;
extern tScreenCarSelect *screenCarSelect;
extern tScreenCarSelectDuel *screenCarSelectDuel;
extern tScreenCarSelectTwoPlayer *screenCarSelectPlayerTwo;
extern tScreenCarSelectTwoPlayer *screenCarSelectTwoPlayer;
extern tScreenControllerConfig *screenControllerConfig;
extern tScreenDisplay *screenDisplay;
extern tScreenMain *screenMain;
extern tScreenMemcard *screenMemcard;
extern tScreenPinkSlipCongrats *screenPinkSlipCongrats;
extern tScreenPinkSlipStandings *screenPinkSlipStandings;
extern tScreenPinkSlips *screenPinkSlips;
extern tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectPlayerTwo;
extern tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectTwoPlayer;
extern tScreenTournSelect *screenTournSelect;
extern tScreenTournamentCongrats *screenTournamentCongrats;
extern tScreenTournamentStandings *screenTournamentStandings;
extern tScreenTournamentStandings3item *screenTournamentStandings3item;
extern tScreenTournamentTrophy *screenTournamentTrophy;
extern tScreenTrackInfo *screenTrackInfo;
extern tScreenTrackRecords *screenTrackRecords;
extern tScreenTrackSelect *screenTrackSelect;
extern tScreenTrophyInfo *screenTrophyInfo;
extern tScreenTrophyRoom *screenTrophyRoom;
extern tScreenUserName *screenUserName;
extern tCarModels superCopModels[7][5];
/* SEVERE BUG FIXED (extern-audit): these 20 were `extern int X_vtable;` (SCALAR) vs the real
   owner def `__vtbl_ptr_type X_vtable[N]` (ARRAY, vtables_t*.cpp). front.cpp does
   `*(void**)&obj->_vf = (void*)X_vtable;` -- under the scalar decl this compiled to
   `lw v0,0(v0)` (LOAD the value stored at the vtable's FIRST ENTRY, i.e. garbage bits of a
   __nfs4_vtbl_ptr_t struct) instead of materializing the array's own address (the real vtable
   pointer). Every tAllScreens::tAllScreens()/tDialog* vptr-init through these was corrupted. */
extern __vtbl_ptr_type tDialogBackUpOnly_vtable[];
extern __vtbl_ptr_type tDialogBase_vtable[];
extern __vtbl_ptr_type tDialogMessageString_vtable[];
extern __vtbl_ptr_type tScreenBeTheCopCongrats_vtable[];
extern __vtbl_ptr_type tScreenCarSelectDuel_vtable[];
extern __vtbl_ptr_type tScreenCarSelectTwoPlayer_vtable[];
extern __vtbl_ptr_type tScreenDisplay_vtable[];
extern __vtbl_ptr_type tScreenMain_vtable[];
extern __vtbl_ptr_type tScreenPinkSlipCongrats_vtable[];
extern __vtbl_ptr_type tScreenPinkSlipStandings_vtable[];
extern __vtbl_ptr_type tScreenPinkSlipsCarSelect_vtable[];
extern __vtbl_ptr_type tScreenPinkSlips_vtable[];
extern __vtbl_ptr_type tScreenTournamentCongrats_vtable[];
extern __vtbl_ptr_type tScreenTournamentStandings3item_vtable[];
extern __vtbl_ptr_type tScreenTournamentTrophy_vtable[];
extern __vtbl_ptr_type tScreenTrackInfo_vtable[];
extern __vtbl_ptr_type tScreenTrackRecords_vtable[];
extern __vtbl_ptr_type tScreenTrackSelect_vtable[];
extern __vtbl_ptr_type tScreenTrophyInfo_vtable[];
extern __vtbl_ptr_type tScreenUserName_vtable[];
#endif
