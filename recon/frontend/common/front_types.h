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

#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"

struct tScreenControllerConfig : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
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
};

#include "screenmain.h"

struct tScreenCarSelectDuel : public tScreenCarSelect {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void PreLoad();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short);
    void InitializeVideoWall();
    void UpdateVideoWall(tCarInfo &);
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    tScreenCarSelectDuel();
    void DrawOpponentVideoWall(short);   /* declared on every surface: see fevirt_tscreen7.py */
};

struct tScreenPinkSlipsCarSelect : public tScreenCarSelectTwoPlayer {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    bool GetCar(tCarInfo &);
    void SetDialog();
    int waitfordialog;
    CARDINFO_def *pCI;
    int fStartCheckTick;
    bool fCardFailed, fExitingScreen;

    tScreenPinkSlipsCarSelect();
};

#include "screentournselect.h"

struct tScreenPinkSlipStandings : public tScreenTournamentStandings3item {
    /* overrides (retail vtable), declared on every owner surface */
    void DrawBackground();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tScreenPinkSlipStandings();
};

#include "screentrophyroom.h"

#include "screentrophyinfo.h"

#include "screendisplay.h"

#include "screenaudio.h"

struct tScreenTournamentTrophy : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    short fShapeCount;
    char fDoUpdate;
    tScreenTournamentTrophy();
};

struct tScreenBeTheCopCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    tScreenBeTheCopCongrats();
};

struct tScreenTournamentCongrats : public tScreenCongrats {
    /* overrides (retail vtable), declared on every owner surface */
    void CalculatePrizes();
    void DrawCongratsMessage();
    bool GetCar(tCarInfo &);
    tScreenTournamentCongrats();
};

#include "screentrackrecords.h"

#include "screentracks.h"

#include "screentrackinfo.h"

#include "screenpinkslips.h"

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
