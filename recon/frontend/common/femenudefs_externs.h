/* frontend/common/femenudefs_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_FEMENUDEFS_EXTERNS_H_
#define _FE_FEMENUDEFS_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern int          ticks;
extern tfrontEnd    frontEnd;
extern tFEApplication *FEApp;
extern tGlobalMenuDefs *menuDefs;
extern char        *Paths_Paths[];
extern tCarManager  carManager;
extern tTournamentManager tournamentManager;
extern tTrackManager trackManager;
/* screen pointer globals */
extern tScreenMain     *screenMain;
extern tScreenCarSelect *screenCarSelect;
extern tScreenUserName *screenUserName;
extern tAllScreens     *gAllScreens;
/* menu-option select lists */
extern short SelectListNull[2], SelectListOffOn[3], SelectListTrackDirection[3], SelectListNormal[3];
extern short SelectListOpponentUpgrades[3], SelectListTransmission[3], SelectListDisplaySpeed[5];
extern short SelectListDisplayMap[4], SelectListDisplayOpponentID[4], SelectListSplitTime[4];
extern short SelectListSplitDisplay[3], SelectListUpgrades[4], SelectListControllerConfig[4], SelectListAudioMode[4];


/* ===== auto-generated stubs ===== */
int AddToPinkSlipsList(...);
int AddUpgradesToPinkSlipsList(...);
int AudioCmn_PlayFESFX(...);
int CalcUsedPrice(...);
int CheapestCarStockPrice(...);
int DeInit_Memcard(...);
int Decrement(...);
int Display(...);
int FECheat_IsTheUserACryBabyCheater(...);
int GetAwardInformation(...);
int GetCarFromID(...);
int GetGarageCar(...);
int GetNumOwnedCars(...);
int GetNumTourneyCars(...);
int GetPinkSlipsCar(...);
int GetStockCar(...);
int GetTrack(...);
int Hide(...);
int Increment(...);
int Init_Memcard(...);
int IsTournamentFinished(...);
int LoadGame(...);
int PlayerName(...);
int PurchaseCar(...);
int PurchaseUpgrade(...);
int Redraw(...);
int Run(...);
int SaveGame(...);
int SavePinkSlipsCarsWithErrorDialogs(...);
int SellCar(...);
int SetCarAvailable(...);
int SetDimensions(...);
int SetState(...);
int StartNewTournament(...);
int StatChk_ClearNewRecords(...);
int StatChk_IsRecordLapTime(...);
int StatChk_IsTopTime(...);
int StatChk_SaveRecordLapTime(...);
int StatChk_SaveTopTime(...);
int SwapBackground(...);
int TextSys_Word(...);
int __builtin_delete(...);
tDialogYesNo *tDialogYesNo_ctor(...);
tInsideBoxLeftRightSlider *tInsideBoxLeftRightSlider_ctor(...);
tInsideBoxLeftRightSlider *tInsideBoxLeftRightSlider_dtor(...);
tInsideBoxMenu *tInsideBoxMenu_ctor(...);
tInsideBoxMenu *tInsideBoxMenu_dtor(...);
tInsideBoxSongMenu *tInsideBoxSongMenu_ctor(...);
tInsideBoxSongMenu *tInsideBoxSongMenu_dtor(...);
tInsideBoxTwoWaySlider *tInsideBoxTwoWaySlider_ctor(...);
tInsideBoxTwoWaySlider *tInsideBoxTwoWaySlider_dtor(...);
tListIteratorCarColor *tListIteratorCarColor_ctor(...);
tListIteratorCarColor *tListIteratorCarColor_dtor(...);
tListIteratorCar *tListIteratorCar_ctor(...);
tListIteratorCar *tListIteratorCar_dtor(...);
tListIteratorIndexed *tListIteratorIndexed_ctor(...);
tListIteratorIndexed *tListIteratorIndexed_dtor(...);
tListIteratorRangeIndexed *tListIteratorRangeIndexed_ctor(...);
tListIteratorRangeIndexed *tListIteratorRangeIndexed_dtor(...);
tListIteratorRange *tListIteratorRange_ctor(...);
tListIteratorRange *tListIteratorRange_dtor(...);
tListIteratorTournament *tListIteratorTournament_ctor(...);
tListIteratorTournament *tListIteratorTournament_dtor(...);
tListIteratorTrack *tListIteratorTrack_ctor(...);
tListIteratorTrack *tListIteratorTrack_dtor(...);
tListIterator *tListIterator_ctor(...);
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
extern int Cars_gNewCarStatsList;
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
extern int tDialogYesNoTri_vtable;
extern int tInsideBoxControllerLeftRightSlider_vtable;
extern int tMemoryCardMenuItem_vtable;
extern int tMenuItemControllerLeftRightChoice_vtable;
extern int tMenuItemDisplayLeftRightChoice_vtable;
extern int tMenuItemOnOffLeftRightChoice_vtable;
extern int tMenuItemOptionsLeftRightChoice_vtable;
extern int tMenuItemOptionsTwoItemChoice_vtable;
extern int tMenuItemSlidingActivated_vtable;
#endif
