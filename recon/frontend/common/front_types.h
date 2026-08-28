/* Owner-specific type surface for Front.obj. */
#ifndef NFS4_FRONTEND_COMMON_FRONT_TYPES_H
#define NFS4_FRONTEND_COMMON_FRONT_TYPES_H

/* Front.obj retains the FEMenuDefs shared graph, but not FEMenuDefs' three
 * owner records or its pointer-only screen views. */
#define NFS4_FRONT_SURFACE
#define NFS4_FEMENUDEFS_NO_SCREENMAIN_VIEW
#define NFS4_FEMENUDEFS_NO_SCREENTROPHYROOM_VIEW
#define NFS4_FEMENUDEFS_NO_GAMESETUP_VIEW
#define NFS4_FEMENUDEFS_NO_DIALOGYESNOTRI
#define NFS4_FEMENUDEFS_NO_FEAPPLICATION
#define NFS4_FEMENUDEFS_NO_GLOBALMENUDEFS
#include "femenudefs_types.h"
#undef NFS4_FEMENUDEFS_NO_GLOBALMENUDEFS
#undef NFS4_FEMENUDEFS_NO_FEAPPLICATION
#undef NFS4_FEMENUDEFS_NO_DIALOGYESNOTRI
#undef NFS4_FEMENUDEFS_NO_GAMESETUP_VIEW
#undef NFS4_FEMENUDEFS_NO_SCREENTROPHYROOM_VIEW
#undef NFS4_FEMENUDEFS_NO_SCREENMAIN_VIEW

enum tFront_ProcessingType {
    kFront_InitialLoad = 0,
    kFront_QuitToGameSetup = 1,
    kFront_QuitToPostGame = 2
};

#define kApp_Command_StartRace 0

enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
};

struct copLevel_t {
    int copChasers[2];
    int numBlockaders;
    int copBlockaders[2];
    int spikeBelt;
    int copAggression[2];
    int copsPerLap, engagementLapFraction, warningTicks, beatingTicks;
    int numWarningsAdded;
};

struct copGame_t {
    int numLevels;
    copLevel_t *levels;
};

struct tScreenControllerConfig : public tScreen {
    Force_tGlobal fShaker;
    char fPrevConfig, fTextConfig, fTextController, fPrevController;
    short fFade[2], fFadeController[2];
    int fStartTick;
    short fGotTick, fAnim, fAnimFrame, fAnimStart, fAnimStop, fAnimStep;
    short fAnimController, fSwap, fAnimFade, fAnimFadeStart, fAnimFadeStop;
    short fAnimFadeFrame, fAnimFadeController, CurrentlyLoadedArt, negconChoice;
    bool fTransitionedIn, fTransitioningIn, fTransitioningOut;
    short fArrowFade, fArrowFadeDir, fTextTypeOn;
    bool fFadeTextOut;
    short mult;
    tDialogYesNo negconPopUp;
    int fTimeOutStartTick;
    bool SuperFastFadeOut, fPlayedInSound;
    short fShakingItem;
    bool fResetShakeTimeOut;
    char fCurrentController;
    int player;

    tScreenControllerConfig();
    ~tScreenControllerConfig() {}
};

struct tScreenMain : public tScreen {
    int hVideo, fFrame;
    u_long fStartTicks, fAnimTicks;
    short fAnimLocation;
    tScreenMainState fState;
    tTVConfig tvConfigs[16];
    tScreenMainState tvStates[16];
    tVideoTransition tvTransitions[16];
    bool fTVsInitialized;
    char fTransitionDirection;
    bool fAnimationUploaded;
    short fPreviousAnim, fWarningFade, fPreviousMovie, fCurrentMovie;
    bool bVideoAborted;
    u_long fMovieTicks;
    tShapeInformation fVideoShapes[2];
    int fCurrentSlot, fCurrentBG[2], fNumTVsInTransition;

    tScreenMain();
};

struct tScreenCarSelectDuel : public tScreenCarSelect {
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    tScreenCarSelectDuel();
};

struct tScreenPinkSlipsCarSelect : public tScreenCarSelectTwoPlayer {
    int waitfordialog;
    CARDINFO_def *pCI;
    int fStartCheckTick;
    bool fCardFailed, fExitingScreen;

    tScreenPinkSlipsCarSelect();
    ~tScreenPinkSlipsCarSelect() {}
};

struct tScreenTournSelect : public tScreen {
    int hVideo, fFrame;
    tTVConfig tvConfigs[8], trophyTV[4];
    short fPreviousMovie, fCurrentMovie;
    u_long fStartTicks, fTVTicks;
    short fTransitionDirection;
    char fPreviousTrophy;
    bool fTVsInitialized;
    int PreCalculatedTournamentY, fPrevi;

    tScreenTournSelect();
    ~tScreenTournSelect();
};

struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    tScreenPinkSlipStandings();
};

struct tScreenTrophyRoom : public tScreen {
    tShapeInformation fTrophyShapes;
    short fNumTrophies;
    int startTicks;
    short fShapeCount;
    bool fLoadingTrophy;
    char fPreviousTrophy, fDoUpdate;
    bool fClearScreen;
    char fBrightness;
    u_long fStartTicks;
    short fTextInfo[16];
    char thisisuseless;
    int tier;
    short fRealCurrentTourn[2], fTrophyList[64];

    tScreenTrophyRoom();
    ~tScreenTrophyRoom();
};

struct tScreenTrophyInfo : public tScreen {
    int BannerCol;
    tScreenTrophyInfo();
};

struct tScreenDisplay : public tScreen {
    tScreenDisplay();
};

struct tScreenAudio : public tScreen {
    short fShapeCount;
    char prevAudioMode;
    short audioTest;
    int audioTestHandle;
    short fPrevSelectedSong;
    char fCurrentAudioMode;
    short fSelectedSong;
    AudioMus_tSongList *songlist;

    tScreenAudio();
};

struct tScreenTournamentTrophy : public tScreenCongrats {
    short fShapeCount;
    char fDoUpdate;
    tScreenTournamentTrophy();
};

struct tScreenBeTheCopCongrats : public tScreenCongrats {
    tScreenBeTheCopCongrats();
};

struct tScreenTournamentCongrats : public tScreenCongrats {
    tScreenTournamentCongrats();
};

struct tScreenTrackRecords : public tScreen {
    tRecordBuffer *TrackRecords;
    int flare_intensity, flareextra;
    bool fReadNewData;
    tScreenTrackRecords();
};

struct tScreenTrackSelect : public tScreen {
    int hVideo, fFrame;
    short fPreviousTrack, fMovieTrack, fBrightness, fDestBrightness;
    short fStartBrightness;
    u_long fStartTicks;
    bool fTicksSet;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    bool fTVsInitialized;
    u_long fVideoTicks;
    tScreenTrackSelect();
};

struct tScreenTrackInfo : public tScreen {
    tTrackInfo fTrack;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall;
    tScreenTrackInfo();
};

struct tScreenPinkSlips : public tScreen {
    tMenu *fMenu;
    int hVideo, fFrame;
    short fPreviousTrack, fBrightness, fDestBrightness, fStartBrightness;
    u_long fStartTicks, fTVTicks;
    char fTransitionDirection;
    tTVConfig fTrackTVs[8], fImageTVs[4];
    bool fTVsInitialized;
    tScreenPinkSlips();
};

struct tAllScreens {
    tScreenMain screenMain;
    tScreenCarSelect screenCarSelect;
    tScreenCarSelectDuel screenCarSelectDuel;
    tScreenCarSelectTwoPlayer screenCarSelectTwoPlayer, screenCarSelectPlayerTwo;
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectTwoPlayer;
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectPlayerTwo;
    tScreenTrackRecords screenTrackRecords;
    tScreenTrackInfo screenTrackInfo;
    tScreenTrackSelect screenTrackSelect;
    tScreenTournSelect screenTournSelect;
    tScreenTournamentStandings screenTournamentStandings;
    tScreenTournamentTrophy screenTournamentTrophy;
    tScreenTrophyRoom screenTrophyRoom;
    tScreenTrophyInfo screenTrophyInfo;
    tScreenControllerConfig screenControllerConfig;
    tScreenDisplay screenDisplay;
    tScreenAudio screenAudio;
    tScreenMemcard screenMemcard;
    tScreenUserName screenUserName;
    tScreenPinkSlipCongrats screenPinkSlipCongrats;
    tScreenPinkSlipStandings screenPinkSlipStandings;
    tScreenTournamentStandings3item screenTournamentStandings3item;
    tScreenPinkSlips screenPinkSlips;
    tScreenBeTheCopCongrats screenBeTheCopCongrats;
    tScreenTournamentCongrats screenTournamentCongrats;
};

struct tPerpModelList {
    tCarModels carModel;
    char carColor;
};

struct tFEStream {
    short totalCars, totalModels, currentCar, numPlayers;
    tCarInfo playerCars[2];
    short numOpponents;
    tCarLineup carLineup[6];
    short numCops, numSuperCops;
    tCarModels copCars[6];
    short copCountry[6];
    short numTraffic;
    short trafficCars[6];
    short numPerpObjects, numPerps;
    tMissionInfo *pMission;
    tStageInfo *pStages;
    tPerpModelList perps[6];
    tTrackInformation trackInfo;
    tTrackInfo track;
};

struct tCarInLineup {
    char isPlayerCar, isAlive, AIPersonality, LineupPosition;
};

/* These foreign objects are complete at their allocation/use sites, but their
 * tags are not retained in Front.obj. Exact-size views preserve codegen while
 * keeping the owner graph honest. */
struct tFEApplication {
    char _storage[896];
    tFEApplication();
    ~tFEApplication();
    int RunFrontEnd();
    int RunPostGame();
};

struct tGlobalMenuDefs {
    char _storage[15128];
    tGlobalMenuDefs();
    ~tGlobalMenuDefs();
};

struct Front_MissionManagerCodegenView {
    char _storage[8];
    void LoadDescription(bool)
        __asm__("LoadDescription__15tMissionManagerb");
    void GetMissionToRace(tMissionInfo **)
        __asm__("GetMissionToRace__15tMissionManagerPP12tMissionInfo");
    short GetMissionStages(short, short, tStageInfo **)
        __asm__("GetMissionStages__15tMissionManagerssPP10tStageInfo");
};
#define tMissionManager Front_MissionManagerCodegenView

struct Front_GameSetupCodegenView {
    int _beforeReplayMode[9];
    int replayMode;
    int _beforeControllerData[14];
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit;
    char _tail[2600 - 188];
};
#define GameSetup_tData Front_GameSetupCodegenView

struct tCreditManager {
    char _storage[56];
    void Setup();
};

#undef NFS4_FRONT_SURFACE

#endif
