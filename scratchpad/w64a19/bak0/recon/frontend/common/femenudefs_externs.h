/* frontend/common/femenudefs_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEMENUDEFS_EXTERNS_H_
#define _FE_FEMENUDEFS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern int          ticks;
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp;
extern tGlobalMenuDefs *menuDefs[];
extern char        *Paths_Paths[];
extern tCarManager  carManager;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
/* screen pointer globals */
extern tScreenMain     *screenMain[];
extern tScreenCarSelect *screenCarSelect[];
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
int AudioCmn_PlayFESFX(int);
int DeInit_Memcard(void);
int FECheat_IsTheUserACryBabyCheater(void);
int Init_Memcard(bool, bool);
int LoadGame(short, bool, bool);
int PlayerName(int);
int SaveGame(short);
int SavePinkSlipsCarsWithErrorDialogs(short, short, short);
int StatChk_ClearNewRecords(void);
int StatChk_IsRecordLapTime(Car_tStats *, short, short *);
int StatChk_IsTopTime(Car_tStats *, short);
int StatChk_SaveRecordLapTime(Car_tStats *, short, short);
int StatChk_SaveTopTime(Car_tStats *, short);
int TextSys_Word(int);
int __builtin_delete(...);
tDialogYesNo *tDialogYesNo_ctor(...);
extern "C" tInsideBoxLeftRightSlider *tInsideBoxLeftRightSlider_ctor(...) __asm__("__25tInsideBoxLeftRightSliderUiP13tListIterator");  /* real ctor symbol */
tInsideBoxLeftRightSlider *tInsideBoxLeftRightSlider_dtor(...);
tInsideBoxMenu *tInsideBoxMenu_ctor(...);
tInsideBoxMenu *tInsideBoxMenu_dtor(...);
tInsideBoxSongMenu *tInsideBoxSongMenu_ctor(...);
tInsideBoxSongMenu *tInsideBoxSongMenu_dtor(...);
tInsideBoxTwoWaySlider *tInsideBoxTwoWaySlider_ctor(...);
tInsideBoxTwoWaySlider *tInsideBoxTwoWaySlider_dtor(...);
extern "C" tListIteratorCarColor *tListIteratorCarColor_ctor(...) __asm__("__21tListIteratorCarColorPcN21iP11tCarManager");  /* real ctor symbol */
tListIteratorCarColor *tListIteratorCarColor_dtor(...);
extern "C" tListIteratorCar *tListIteratorCar_ctor(...) __asm__("__16tListIteratorCarPcP11tCarManager");  /* real ctor symbol */
tListIteratorCar *tListIteratorCar_dtor(...);
extern "C" tListIteratorIndexed *tListIteratorIndexed_ctor(...) __asm__("__20tListIteratorIndexedPsPcT2");  /* real ctor symbol */
tListIteratorIndexed *tListIteratorIndexed_dtor(...);
extern "C" tListIteratorRangeIndexed *tListIteratorRangeIndexed_ctor(...) __asm__("__25tListIteratorRangeIndexedccPcT3");  /* real ctor symbol */
tListIteratorRangeIndexed *tListIteratorRangeIndexed_dtor(...);
extern "C" tListIteratorRange *tListIteratorRange_ctor(...) __asm__("__18tListIteratorRangeccPc");  /* real ctor symbol */
tListIteratorRange *tListIteratorRange_dtor(...);
extern "C" tListIteratorTournament *tListIteratorTournament_ctor(...) __asm__("__23tListIteratorTournamentPcP18tTournamentManager");  /* real ctor symbol */
tListIteratorTournament *tListIteratorTournament_dtor(...);
extern "C" tListIteratorTrack *tListIteratorTrack_ctor(...) __asm__("__18tListIteratorTrackPcT1P13tTrackManager");  /* real ctor symbol */
tListIteratorTrack *tListIteratorTrack_dtor(...);
extern "C" tListIterator *tListIterator_ctor(...) __asm__("__13tListIteratorPsPc");  /* real ctor symbol */
tListIterator *tListIterator_dtor(...);
tMenuBlank *tMenuBlank_ctor(...);
tMenuBlank *tMenuBlank_dtor(...);
tMenuItemGoToMenuButton *tMenuItemGoToMenuButton_ctor(...);
tMenuItemGoToMenuButton *tMenuItemGoToMenuButton_dtor(...);
tMenuItemGoToMenuNFS4Button *tMenuItemGoToMenuNFS4Button_ctor(...);
tMenuItemGoToMenuNFS4Button *tMenuItemGoToMenuNFS4Button_dtor(...);
tMenuItemLeftRightAudioSlider *tMenuItemLeftRightAudioSlider_ctor(...);
tMenuItemLeftRightAudioSlider *tMenuItemLeftRightAudioSlider_dtor(...);
tMenuItemLeftRightChoice *tMenuItemLeftRightChoice_ctor(...);
tMenuItemLeftRightChoice *tMenuItemLeftRightChoice_dtor(...);
tMenuItemLeftRightFade *tMenuItemLeftRightFade_ctor(...);
tMenuItemNFS4LeftRightChoice *tMenuItemNFS4LeftRightChoice_ctor(...);
tMenuItemNFS4LeftRightChoice *tMenuItemNFS4LeftRightChoice_dtor(...);
tMenuItemSlidingMenu *tMenuItemSlidingMenu_ctor(...);
tMenuItemSlidingMenu *tMenuItemSlidingMenu_dtor(...);
tMenuItem *tMenuItem_dtor(...);
tMenuNFS4Bottom *tMenuNFS4Bottom_ctor(...);
tMenuNFS4Bottom *tMenuNFS4Bottom_dtor(...);
tMenuNFS4TwoPlayer *tMenuNFS4TwoPlayer_ctor(...);
tMenuNFS4TwoPlayer *tMenuNFS4TwoPlayer_dtor(...);
tMenuNFS4 *tMenuNFS4_ctor(...);
tMenuNFS4 *tMenuNFS4_dtor(...);
tMenuOptions *tMenuOptions_ctor(...);
tMenuOptions *tMenuOptions_dtor(...);
tOptionsMenu *tOptionsMenu_ctor(...);
tOptionsMenu *tOptionsMenu_dtor(...);
tScreen *tScreen_dtor(...);
tUserNameMenuItem *tUserNameMenuItem_ctor(...);
extern int CURRENTLYUSINGMEMCARD;
extern Car_tStats Cars_gNewCarStatsList[];   /* was stale scalar int; owner cars.cpp
                                     Car_tStats Cars_gNewCarStatsList[9] (array of value structs) --
                                     passed bare to StatChk_IsRecordLapTime/StatChk_SaveTopTime etc
                                     (Car_tStats* param); the scalar decl loaded the VALUE at that
                                     address instead of computing the array's own address */
extern int Cars_gNumRaceCars;
extern GameSetup_tData GameSetup_gData;
extern int MEMCARD_INITIALIZED;


extern int gCarActivation[6][5];
extern tPadModuleState gPadinfo;
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
extern __vtbl_ptr_type tBlankMenuItemGoToMenuNFS4Button_vtable[];   /* real def in game/common/vtables_tmenu.cpp */
extern __vtbl_ptr_type tBlankMenuItemNFS4LeftRightChoice_vtable[];   /* real def in game/common/vtables_tmenu.cpp */
/* SEVERE BUG FIXED (extern-audit): same class as front_externs.h -- these 9 were
   `extern int X_vtable;` (SCALAR) vs the real owner def `__vtbl_ptr_type X_vtable[N]`
   (ARRAY, vtables_t*.cpp), corrupting the vptr-init cast to `(void*)X_vtable`. */
extern __vtbl_ptr_type tDialogYesNoTri_vtable[];
extern __vtbl_ptr_type tInsideBoxControllerLeftRightSlider_vtable[];
extern __vtbl_ptr_type tMemoryCardMenuItem_vtable[];
extern __vtbl_ptr_type tMenuItemControllerLeftRightChoice_vtable[];
extern __vtbl_ptr_type tMenuItemDisplayLeftRightChoice_vtable[];
extern __vtbl_ptr_type tMenuItemOnOffLeftRightChoice_vtable[];
extern __vtbl_ptr_type tMenuItemOptionsLeftRightChoice_vtable[];
extern __vtbl_ptr_type tMenuItemOptionsTwoItemChoice_vtable[];
extern __vtbl_ptr_type tMenuItemSlidingActivated_vtable[];
#endif
