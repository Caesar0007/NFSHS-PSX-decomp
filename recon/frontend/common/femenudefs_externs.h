/* frontend/common/femenudefs_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEMENUDEFS_EXTERNS_H_
#define _FE_FEMENUDEFS_EXTERNS_H_
#include "femenudefs_types.h"

extern "C" int sprintf(char *, const char *, ...);

extern int          ticks;
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp;
extern tGlobalMenuDefs *menuDefs;
extern char        *Paths_Paths[];
extern tCarManager  carManager;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
/* screen pointer globals */
extern tScreenMain     *screenMain;  /* P885: native605a62 scalar PTR, four-byte cell */
extern tScreenCarSelect *screenCarSelect;  /* SYM 64b0d0: scalar PTR, 4 B */
extern tScreenUserName *screenUserName;
extern tAllScreens     *gAllScreens;
/* menu-option select lists */
extern short SelectListNull[2], SelectListOffOn[3], SelectListTrackDirection[3], SelectListNormal[3];
extern short SelectListOpponentUpgrades[3], SelectListTransmission[3], SelectListDisplaySpeed[5];
extern short SelectListDisplayMap[4], SelectListDisplayOpponentID[4], SelectListSplitTime[4];
extern short SelectListSplitDisplay[3], SelectListUpgrades[4], SelectListControllerConfig[4], SelectListAudioMode[4];


/* ===== auto-generated stubs ===== */
/* W58-A1 (08A phantom fix): the entry points below were free `int f(...)` decls, which
 * mangle EVERY call site to `f__Fe` -- a symbol the link can never resolve.  They are
 * MEMBERS of tCarManager / tTournamentManager / tTrackManager / tScreenMain /
 * tScreenCarSelect / tDialogBase / tDialogInteractive / tFEApplication / tListIteratorCar /
 * tMenuItemLeftRightSlider (decls in nfs4_types.h); the call sites now use the
 * obj->Method(...) form.  Byte-neutral: `this` rides $a0 like the old explicit receiver.
 * Removed: AddToPinkSlipsList, AddUpgradesToPinkSlipsList, CalcUsedPrice,
 * CheapestCarStockPrice, Decrement, Display, GetAwardInformation, GetCarFromID,
 * GetGarageCar, GetNumOwnedCars, GetNumTourneyCars, GetPinkSlipsCar, GetStockCar,
 * GetTrack, Hide, Increment, IsTournamentFinished, PurchaseCar, PurchaseUpgrade,
 * Redraw, Run, SellCar, SetCarAvailable, SetDimensions, SetState, StartNewTournament,
 * SwapBackground. */
void AudioCmn_PlayFESFX(int);   /* SYM Def class EXT type FCN */
void DeInit_Memcard(void);   /* SYM Def class EXT type FCN */
bool FECheat_IsTheUserACryBabyCheater(void);   /* SYM: FCN bool */
void Init_Memcard(bool, bool);   /* SYM Def class EXT type FCN */
short LoadGame(short, bool, bool);
char *PlayerName(int);   /* SYM Def class EXT type FCN */
bool SaveGame(short);   /* SYM: Def class EXT type FCN bool @0x80034988 */
#include "shared/PinkSlipsErrorCode.h"
PinkSlipsErrorCode SavePinkSlipsCarsWithErrorDialogs(short, short, short);
void StatChk_ClearNewRecords(void);   /* SYM Def class EXT type FCN */
bool StatChk_IsRecordLapTime(Car_tStats *, short, short *);   /* SYM Def class EXT type FCN */
short StatChk_IsTopTime(Car_tStats *, short);   /* SYM Def class EXT type FCN */
void StatChk_SaveRecordLapTime(Car_tStats *, short, short);   /* SYM Def class EXT type FCN */
void StatChk_SaveTopTime(Car_tStats *, short);   /* SYM Def class EXT type FCN */
char *TextSys_Word(int);   /* SYM Def class EXT type FCN */
void __builtin_delete(void *deleteMe);   /* retail2b4db7 / NEW.CPP: void, PTR VOID */
/* Real C++ type-surface declarations supply all constructors/destructors.
   Removed 53 unused generated variadic stubs, including nine asm aliases;
   these were reconstruction artifacts, not retail source APIs. */

extern bool CURRENTLYUSINGMEMCARD;
extern Car_tStats Cars_gNewCarStatsList[];   /* was stale scalar int; owner cars.cpp
                                     Car_tStats Cars_gNewCarStatsList[9] (array of value structs) --
                                     passed bare to StatChk_IsRecordLapTime/StatChk_SaveTopTime etc
                                     (Car_tStats* param); the scalar decl loaded the VALUE at that
                                     address instead of computing the array's own address */
extern int Cars_gNumRaceCars;
extern GameSetup_tData GameSetup_gData;
extern bool MEMCARD_INITIALIZED;


#include "shared/pad_module_globals.h"
extern tScreenAudio *screenAudio;
extern tScreenBeTheCopCongrats *screenBeTheCopCongrats;
extern tScreenCarSelectDuel *screenCarSelectDuel;
extern tScreenCarSelectTwoPlayer *screenCarSelectPlayerTwo;
extern tScreenCarSelectTwoPlayer *screenCarSelectTwoPlayer;
extern tScreenControllerConfig *screenControllerConfig;
extern tScreenDisplay *screenDisplay;
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
/* SEVERE BUG FIXED (extern-audit): same class as front_externs.h -- these 9 were
   `extern int X_vtable;` (SCALAR) vs the real owner def `__vtbl_ptr_type X_vtable[N]`
   (ARRAY, vtables_t*.cpp), corrupting the vptr-init cast to `(void*)X_vtable`. */
#endif
