/* frontend/common/front_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FRONT_EXTERNS_H_
#define _FE_FRONT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
extern int          ticks[];
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp[];
extern tGlobalMenuDefs *menuDefs[];
extern char        *Paths_Paths[];
extern tCarManager  carManager;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;

/* 🔴 DO NOT RE-SORT the next five (17B EXTERN-ORDER LAW).  They are TU-owned
   TENTATIVE definitions in front.cpp and therefore emit in the order their
   identifiers are FIRST DECLARED -- these lines -- after every INITIALISED
   object.  Retail run (SYM Front.obj block), base 0x800517e8:
     +0x000 overRide (=0)            +0x004 ComingIntoTheFrontEndTheVeryFirstTime (=0)
     +0x008 regularCopModels         +0x094 superCopModels        [initialised]
     +0x120 gFE_Cheats  +0x128 gPSXMemCardFull  +0x12c colourChosen
     +0x14c gAllScreens +0x150 memCardReadOK    +0x154 CarLineup  +0x178 picked
   (gFE_Cheats/CarLineup/picked keep their front.cpp definition order, which is
   already retail's.) */
extern char         gFE_Cheats[];
extern int          gPSXMemCardFull[];
extern int          colourChosen[8];
extern tAllScreens *gAllScreens[];
extern BOOL         memCardReadOK[];

/* ===== auto-generated stubs ===== */
/* W58-A1 (08A phantom fix): the entry points below were free `Type f(...)` decls,
 * which mangle EVERY call site to `f__Fe` -- a symbol that never links.  They are
 * MEMBERS of tCarManager / tTournamentManager / tTrackManager / tMissionManager /
 * tFEApplication / tCreditManager (member decls live in nfs4_types.h); the call
 * sites now use obj.Method(...) / obj->Method(...).  Byte-neutral: `this` rides $a0
 * exactly like the old explicit receiver pointer.  Removed: AddCarToIngameList,
 * AdvanceToNextTrack, CheapestCarStockPrice, FindSimilarCar, GetCarFromID,
 * GetClassList, GetGarageCar, GetLastTrackRaced, GetMissionStages, GetMissionToRace,
 * GetNumOwnedCars, GetPinkSlipsCar, GetStockCar, GetTrack, GetTrackByID,
 * GetTrackToRace, InitializeIngameCarList, IsCarAnAddedModel, LoadDescription,
 * RunFrontEnd, RunPostGame, Setup, UpdateAwardInformation, UpdateCarLineup. */
int AudioMus_GetSongList(char *, int);
int AudioMus_SysCleanUp(void);
int AudioMus_SysStartUp(int, int, char *);
int AudioMus_Volume(int);
int Audio_FECleanUp(void);
int CarIO_CleanUpLicense(int);
int CarIO_CreateLicense(char *, int, int);
int Controller_SetRamp(void);
int DeInit_Memcard(void);
int FECheat_IsCheatEnabled(tCheatCode);   /* W58-A1: FECheat_IsCheatEnabled__F10tCheatCode (was `(...)` -> __Fe phantom) */
int FeAudio_DeInitCommentary(void);
int FeAudio_InitCommentary(int, int);
int FeTools_deinit(void);
int Init_Memcard(bool, bool);
int Init_PSX_FrontEnd(void);
int InitializeSpinningCars(void);
/* Retail SYM type is short; keep the narrow declaration consistent with the
   definition and all frontend callers. */
short LoadGame(short, bool, bool);
void MenuExtended_TransitionFromPostGameToMainMenu(tMenuCommand &);  /* W58-A1: ..__FR12tMenuCommand (was `(...)` -> __Fe phantom); SYM `Def class EXT type FCN VOID` @0x8002c494 -> void, matching the femenudefs.cpp definition */
int PSXExitFrontend(void);
int Platform_ResetDCTBuffer(void);
char * PlayerName(int);
int StatTool_UpperCaseItKeepingInMindThoseBloodySpecialCharacters(char *);
int Stattool_GetAllDefaultRecords(tRecordBuffer *, bool);
int Stattool_ReturnRecordLapTime(short);
int TextSys_UnloadWords(void);
int TextSys_Word(int);
int __builtin_new(...);
int s_lower(char *);
extern "C" tFEApplication *tFEApplication_ctor(...) __asm__("__14tFEApplication");  /* real ctor symbol */
extern "C" tFEApplication *tFEApplication_dtor(...) __asm__("___14tFEApplication"); /* real dtor symbol */
extern "C" tGlobalMenuDefs *tGlobalMenuDefs_ctor(...) __asm__("__15tGlobalMenuDefs");  /* real ctor symbol */
extern "C" tGlobalMenuDefs *tGlobalMenuDefs_dtor(...) __asm__("___15tGlobalMenuDefs"); /* real dtor symbol */
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
extern tCreditManager CreditManager;   /* W58-A1: real type -- Setup__14tCreditManager */
extern GameSetup_tData GameSetup_gData;
extern int MEMCARDFRONTENDISINITTED[];
/* TRUE TYPE = the array object (was a bare `int`; W62-A17).  Owner def:
   game/common/nfs3.cpp `tRecordBuffer Stats_gTrackRecords[187];` @0x80114d94; every
   oracle reference is an ADDRESS materialization (`addiu`), never a load. */
extern tRecordBuffer Stats_gTrackRecords[187];
extern int _7tScreen_fSuppressLoadingText;
/* _usePlayerUpgrades removed W66-A5 (dead: 0 references, 0 SYM records). */
extern int colourChosen[8];
extern char gCalculateVictory;   /* was stale int (4B); owner nfs3.cpp defines it char (1B) packed
                                     tightly before gPlayerEnteredNameAlready[2] -- a wrong 4B `sw`
                                     here would clobber 3 adjacent bytes incl. that neighbor global */
extern int gFEBigHandle[];
extern u_long gLargestUnused[];
extern int gMasterAmbientLevel[];
extern int gMasterEngineLevel[];
extern int gMasterFENarrationLevel[];
extern int gMasterMusicLevel[];
extern int gMasterSFXLevel[];
extern int gPSXMemCardFull[];
extern tPadModuleState gPadinfo;
extern int gUseFrontend;
extern int mappings[3][13][3];
extern BOOL memCardReadOK[];
extern tMissionManager missionManager;   /* W58-A1: real type -- ..__15tMissionManager */
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
