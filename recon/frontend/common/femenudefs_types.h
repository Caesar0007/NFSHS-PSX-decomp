/* Owner-specific type surface for FEMenuDefs.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUDEFS_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENUDEFS_TYPES_H

/* FEMenuDefs retains the input-key values but not the foreign tPlayer tag. */
#define tPlayer int
#define kPlayerBoth -1
#define kPlayerOne 0
#define kPlayerTwo 1
#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_PinkSlips 6
#define NFS4_FE_INPUT_NO_PLAYER
#define NFS4_EA_PSX_INCOMPLETE_PHYSADR
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FEMENUOPTIONS_SURFACE
#define NFS4_FEMENUDEFS_SURFACE
#define NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#define NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
#include "screencongrats_types.h"
#undef NFS4_SCREENCONGRATS_FEMENUDEFS_SURFACE
#undef NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#undef NFS4_FEMENUOPTIONS_SURFACE
#undef NFS4_FEMENUDEFS_SURFACE
#undef NFS4_FE_CORE_FEMENU_METHODS
#undef NFS4_EA_PSX_INCOMPLETE_PHYSADR
#undef NFS4_FE_INPUT_NO_PLAYER

/* These pointer-only foreign classes are used by the reconstructed extern
 * surface but have no completed records in FEMenuDefs.obj. */
struct FEMenuDefs_ScreenMainCodegenView {
    void SwapBackground(int)
        __asm__("SwapBackground__11tScreenMaini");
};
#define tScreenMain FEMenuDefs_ScreenMainCodegenView
struct tAllScreens;
struct tScreenAudio;
struct tScreenCarSelectDuel;
struct tScreenControllerConfig;
struct tScreenDisplay;
struct tScreenPinkSlipStandings;
struct tScreenPinkSlips;
struct tScreenPinkSlipsCarSelect;
struct tScreenTournSelect;
struct tScreenTrackInfo;
struct tScreenTrackRecords;
struct tScreenTrackSelect;
struct tScreenTrophyInfo;
struct FEMenuDefs_ScreenTrophyRoomCodegenView {
    char _beforeThisIsUseless[0xcc];
    char thisisuseless;
    char _beforeTrophyList[11];
    short fTrophyList[64];
};
#define tScreenTrophyRoom FEMenuDefs_ScreenTrophyRoomCodegenView

/* The linked owner uses these foreign aggregates only through the priced
 * fields below and does not retain their completed tags. */
struct FEMenuDefs_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
};
#define tPadModuleState FEMenuDefs_PadCodegenView

struct FEMenuDefs_GameSetupCodegenView {
    char _beforeNumPerps[0x1ac];
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
};
#define GameSetup_tData FEMenuDefs_GameSetupCodegenView

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};

typedef COORD16 FE3d_zVertex;
typedef CVECTOR FE3d_zColor;
typedef SVECTOR FE3d_zNormal;

struct FE3d_zUV { u_char u, v; };
struct FE3d_zFacet {
    u_short vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;
    SVECTOR normal[3];
    CVECTOR color;
    u_char flag, pad1, pad2, pad3;
};
struct FE3d_zObj {
    int numVertex, numUV, numFacet;
    u_char textureId, textureWidth, textureHeight, pad1;
    COORD16 *vertex;
    FE3d_zUV *uv;
    COORD16 *Nvertex;
    FE3d_zFacet *facet;
};

struct Force_tGlobal {
    u_char active, high, low, jolt, time, fade;
    u_char actuator[2];
};

struct tMissionTierInfo {
    u_char fNumMissions, fDescriptionID, fMissionOffset, fPad;
};
struct tMissionInfo {
    u_char fDescriptionID, fTrackNumber, fDirection, fMirrored;
    u_char fTimeOfDay, fWeather, fTraffic, fPad;
    u_short fStageOffset;
    u_char fNumStages;
    u_char fReserved[9];
};
struct tStageInfo {
    u_char fCarModel, fColor, fAIPersonality, fDirection;
    short fTimeLimit, fWingman, fSpikeBelt, fBlockadeCop;
    u_char fPlacement, fStyle;
    u_short fDistance;
    u_long fSpeed, fWeight, fGlue;
    u_char fSpeechColor;
    u_char fReserved[15];
};
struct tAcademyDefinition {
    tMissionTierInfo fTiers[8];
    tMissionInfo fMissions[64];
    tStageInfo fStages[256];
};

extern __vtbl_ptr_type tDialogYesNoTri_vtable[];
struct tDialogYesNoTri : public tDialogYesNo {
    inline tDialogYesNoTri() {
        _vf = (__typeof__(_vf))&tDialogYesNoTri_vtable;
    }
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

struct MCRDFILE_def {
    char *name, *title;
    int size, offset;
    unsigned int flags;
    void *pData;
    shapetbl *icon[3];
    u_char *numicons, *numblocks;
};
typedef MCRDFILE_def MCRDFILE;

typedef short tArrowLocation[6];
typedef short tTextLocation[5];

struct tScreenMemcard : public tScreen {
    int theNFS4icon, card;
    CARDINFO_def *pCI;
    char fMemTitle[15][32];
    char goticon[15];
    u_char numicon[15], numblock[15];
    MCRDFILE_def fMemFile[15];
    u_short fMemIconClutId[15];
    short fFadeIcon[15];
    bool fReadyToGetNewIcons, fInitedMemCard;
    char fMemCardMessage[40];
    int fMemCardMessageTextSys, message;
    short memcardanimframe, count, cursorPosition;
    int checkingstart;
    bool fSomePunkInQAPulledOutTheMemoryCardWhileLoadingIcons;
    int fScreenFadeReadyTick;
    short player;
    bool fGetNewIcons;
    inline void SetMessage(int newMessage) { message = newMessage; }
};

struct tScreenUserName : public tScreen {
    tOptionsMenu *callingMenu;
    short fTextFade;
    bool fInTransition;
    char fRowList[10][9];
    inline void SetCallingMenu(tOptionsMenu *m) { callingMenu = m; }
};

struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];
    inline tDialogMessageString *MessagePopup() { return &messagePopup; }
    inline tPlayer CurrentPlayer() { return fPlayer; }
    inline void DisplayMessage(int word);
    void Redraw();
};

struct tGlobalMenuDefs {
    tMenuItemGoToMenuNFS4Button itemMainOnePlayerRace, itemMainTwoPlayerRace, itemMainTrophyRoom, itemMainOptions;
    tMenuNFS4 menuMain;
    tMenuItemGoToMenuNFS4Button itemTournTrophyRoom, itemSETrophyRoom;
    tMenuNFS4 menuTrophyRoomSelect;
    tMenuBlank menuTrophyInfo;
    tMenuItemGoToMenuNFS4Button itemSkillBeginner, itemSkillIntermediate, itemSkillExpert;
    tMenuNFS4 menuSkillLevel;
    tMenuItemGoToMenuNFS4Button itemOnePlayerTestDrive, itemOnePlayerSingleRace, itemOnePlayerPursuit, itemOnePlayerTournament, itemOnePlayerSpecialEvents;
    tMenuNFS4 menuOnePlayer;
    tMenuItemGoToMenuNFS4Button itemSingleRaceSolo, itemSingleRaceDuel, itemSingleRaceFullGrid;
    tMenuNFS4 menuSingleRace;
    tMenuItemGoToMenuNFS4Button itemHotPursuitSolo, itemHotPursuitDuel;
    tMenuNFS4 menuHotPursuit;
    tListIteratorTournament iteratorTournament;
    tMenuItemGoToMenuNFS4Button itemTournamentContinue;
    tMenuItemNFS4LeftRightChoice itemTournamentSelect;
    tMenuNFS4 menuTournament;
    tListIteratorTournament iteratorSpecialEvent;
    tMenuItemGoToMenuNFS4Button itemSpecialEventContinue;
    tMenuItemNFS4LeftRightChoice itemSpecialEventSelect;
    tMenuNFS4 menuSpecialEvent;
    tMenuItemGoToMenuNFS4Button itemTwoPlayerTestDrive, itemTwoPlayerDuel, itemTwoPlayerHotPursuit, itemTwoPlayerPinkSlips;
    tMenuNFS4 menuTwoPlayer;
    tMenuItemGoToMenuNFS4Button itemBestOfOne, itemBestOfThree, itemBestOfFive;
    tMenuNFS4 menuPinkSlipSelect;
    tMenuItemGoToMenuNFS4Button itemPinkSlipsContinue;
    tMenuItemNFS4LeftRightChoice itemTrack1, itemTrack2, itemTrack3, itemTrack4, itemTrack5;
    tMenuNFS4 menuPinkSlipsBestOfThree, menuPinkSlipsBestOfFive;
    tListIteratorTrack iteratorTrack;
    tMenuItemGoToMenuNFS4Button itemTrackContinue;
    tMenuItemNFS4LeftRightChoice itemTrack;
    tMenuItemGoToMenuNFS4Button itemTrackRecords;
    tMenuNFS4 menuSingleTrackSelect, menuTestDriveTrackSelect;
    tListIteratorIndexed iteratorLaps, iteratorTrackDirection, iteratorTrackMirrored, iteratorTimeOfDay, iteratorWeather, iteratorTraffic;
    tListIterator iteratorLocalSpeech;
    tMenuItemOptionsLeftRightChoice itemLaps, itemTrackDirection;
    tMenuItemOptionsTwoItemChoice itemTrackMirrored, itemTimeOfDay, itemWeather, itemTraffic, itemLocalSpeech;
    tMenuOptions menuTrackOptions;
    tBlankMenuItemGoToMenuNFS4Button menuTrackRecordsItem;
    tOptionsMenu menuTrackRecords;
    tMenuItemGoToMenuNFS4Button itemTrackInfoContinue;
    tMenuNFS4 menuTrackInfo;
    tListIteratorCar iteratorCar1;
    tListIteratorCarColor iteratorColor;
    tMenuItemGoToMenuNFS4Button itemCarSelectRace;
    tMenuItemNFS4LeftRightChoice itemCar, itemColor;
    tMenuItemGoToMenuNFS4Button itemShowcase;
    tMenuNFS4 menuSingleCarSelect;
    tListIteratorCar iteratorGarageCar;
    tMenuItemNFS4LeftRightChoice itemGarageCar;
    tMenuItemGoToMenuNFS4Button itemCarDealer, itemUpgradeCar;
    tMenuNFS4 menuCarGarage, menuPostCarGarage;
    tListIteratorCar iteratorOpponentCar;
    tMenuItemGoToMenuNFS4Button itemDuelRace;
    tMenuItemNFS4LeftRightChoice itemCar2, itemColor2;
    tMenuItemGoToMenuNFS4Button itemGoToDuelBuyCar;
    tMenuItemNFS4LeftRightChoice itemOpponentCar;
    tMenuNFS4 menuDuelCarSelect, menuHPDuelCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerOneRace;
    tMenuItemNFS4LeftRightChoice itemCarP1, itemColorP1;
    tMenuNFS4TwoPlayer menuPlayerOneCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoRace;
    tMenuItemNFS4LeftRightChoice itemCarP2, itemColorP2;
    tMenuNFS4TwoPlayer menuPlayerTwoCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerOneGarageRace;
    tMenuItemNFS4LeftRightChoice itemGarageCarP1;
    tMenuNFS4TwoPlayer menuPlayerOneGarage;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoGarageRace;
    tMenuItemNFS4LeftRightChoice itemGarageCarP2;
    tMenuNFS4TwoPlayer menuPlayerTwoGarage;
    tListIteratorCar iteratorPinkSlipsCar;
    tMenuItemGoToMenuNFS4Button itemPlayerOnePinkSlipRace;
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP1;
    tMenuNFS4TwoPlayer menuPlayerOnePinkSlipCarSelect;
    tMenuItemGoToMenuNFS4Button itemPlayerTwoPinkSlipRace;
    tMenuItemNFS4LeftRightChoice itemPinkSlipCarP2;
    tMenuNFS4TwoPlayer menuPlayerTwoPinkSlipCarSelect;
    tMenuItemGoToMenuNFS4Button itemGoToBuyCar, itemGoToSellCar;
    tMenuNFS4 menuGoToCarDealer;
    tListIteratorCar iteratorDealerCar;
    tListIteratorCarColor iteratorDealerColor;
    tMenuItemNFS4LeftRightChoice itemDealerCar, itemDealerColor;
    tMenuItemGoToMenuNFS4Button itemBuyCar, itemDealerShowroom;
    tMenuNFS4 menuCarDealer;
    tListIteratorCar iteratorSellerCar;
    tMenuItemNFS4LeftRightChoice itemSellerCar;
    tMenuItemGoToMenuNFS4Button itemSellCar;
    tMenuNFS4 menuCarSeller;
    tMenuItemGoToMenuNFS4Button itemPurchaseUpgrade1, itemPurchaseUpgrade2, itemPurchaseUpgrade3;
    tMenuNFS4 menuCarUpgrades;
    tListIteratorIndexed iteratorTransmission, iteratorABS;
    tListIterator iteratorDamage, iteratorOpponentUpgrades;
    tMenuItemOptionsLeftRightChoice itemTransmission, itemABS, itemDamage, itemTransmission2, itemABS2, itemDamage2, itemOpponentUpgrades;
    tMenuOptions menuCarOptions, menuCarOptionsPlayerOne, menuCarOptionsPlayerTwo, menuPinkSlipCarOptionsPlayerOne, menuPinkSlipCarOptionsPlayerTwo;
    tMenuBlank menuShowroom;
    tMenuItemGoToMenuNFS4Button itemOptionsAudio, itemOptionsDisplay, itemOptionsControllers, itemOptionsMemoryCard, itemOptionsUsername, itemOptionsCredits;
    tMenuNFS4 menuOptions;
    tListIteratorRange iteratorMusicVolume, iteratorSoundEffectsVolume, iteratorEngineVolume, iteratorSpeechVolume, iteratorAmbientVolume;
    tListIterator iteratorAudioMode;
    tMenuItemLeftRightAudioSlider itemMusicVolume, itemSoundEffectsVolume, itemEngineVolume, itemSpeechVolume, itemAmbientVolume;
    tMenuItemDisplayLeftRightChoice itemAudioMode;
    tMenuItemSlidingActivated itemSlidingPlayList;
    tInsideBoxSongMenu menuPlayListMenu;
    tOptionsMenu menuAudio;
    tListIteratorIndexed iteratorDisplaySpeedometer, iteratorDisplayMap, iteratorDisplayOpponentID, iteratorDisplayTime, iteratorDisplayPosition, iteratorDisplayLapNumber;
    tListIterator iteratorDisplaySplitTime;
    tListIteratorIndexed iteratorDisplaySplitDisplay;
    tMenuItemDisplayLeftRightChoice itemDisplaySpeedometer, itemDisplayMap, itemDisplayOpponentID;
    tMenuItemOnOffLeftRightChoice itemDisplayTime, itemDisplayPosition, itemDisplayLapNumber;
    tMenuItemDisplayLeftRightChoice itemDisplaySplitTime, itemDisplaySplitDisplay;
    tOptionsMenu menuDisplayOptions;
    tListIteratorIndexed iteratorControllerConfigSelected;
    tMenuItemControllerLeftRightChoice itemControllerConfigSelected;
    tMenuItemSlidingMenu itemControllerSettings;
    tOptionsMenu menuControllerConfig;
    tListIteratorRangeIndexed iteratorControllerShockMode;
    tInsideBoxControllerLeftRightSlider itemControllerShockMode;
    tListIteratorRangeIndexed iteratorControllerShockImpact;
    tInsideBoxControllerLeftRightSlider itemControllerShockImpact;
    tListIteratorRangeIndexed iteratorControllerSteeringRange1;
    tInsideBoxTwoWaySlider itemControllerSteeringRange1;
    tListIteratorRangeIndexed iteratorControllerDeadSpot1;
    tInsideBoxTwoWaySlider itemControllerDeadSpot1;
    tListIteratorRangeIndexed iteratorControllerSteeringRange2;
    tInsideBoxTwoWaySlider itemControllerSteeringRange2;
    tListIteratorRangeIndexed iteratorControllerDeadSpot2;
    tInsideBoxTwoWaySlider itemControllerDeadSpot2;
    tListIteratorRangeIndexed iteratorControllerJoyRange;
    tInsideBoxTwoWaySlider itemControllerJoyRange;
    tListIteratorRangeIndexed iteratorControllerCenterPoint;
    tInsideBoxTwoWaySlider itemControllerCenterPoint;
    tListIteratorRangeIndexed iteratorControllerIMax;
    tInsideBoxTwoWaySlider itemControllerIMax;
    tListIteratorRangeIndexed iteratorControllerIIMax;
    tInsideBoxTwoWaySlider itemControllerIIMax;
    tInsideBoxMenu menuControllerDualShock, menuControllerAnalog, menuControllerDualShockAnalog, menuControllerNegcon;
    tMemoryCardMenuItem itemSaveGame, itemLoadGame;
    tOptionsMenu menuMemory;
    tUserNameMenuItem menuItemUserName, menuItemUserName1, menuItemUserName2;
    tOptionsMenu menuUserName;
    tListIterator iteratorChangeTrophy;
    tBlankMenuItemNFS4LeftRightChoice itemChangeTrophy;
    tMenuNFS4Bottom menuTrophyRoom;
    tMenuItemGoToMenuNFS4Button itemPinkSlipStandingsForward, itemPinkSlipStandingsExit;
    tMenuNFS4 menuPinkSlipStandings;
    tMenuItemGoToMenuNFS4Button itemTournStandingsForward, itemTournStandingsExit;
    tMenuNFS4 menuTournamentStandings;
    tMenuItemGoToMenuNFS4Button itemTournamentFinishedHome;
    tMenuNFS4 menuTournamentFinished;
    tMenuBlank menuTournamentTrophy;
    tOptionsMenu menuPostGamePlayer1Name, menuPostGamePlayer2Name;
    tBlankMenuItemGoToMenuNFS4Button itemPostGameTrackRecordsContinue;
    tOptionsMenu menuPostGameTrackRecords;
    tMenuBlank menuPinkSlipCongrats, menuBeTheCopCongrats, menuTierCompleteCongrats, menuCredits;
    tMemoryCardMenuItem itemMemContinue;
    tOptionsMenu menuPostGameSave;
    tGlobalMenuDefs();
    ~tGlobalMenuDefs();
};

#endif
