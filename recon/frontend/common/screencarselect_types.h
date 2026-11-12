/* Owner-specific type surface for ScreenCarSelect.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H

/* These identifiers are source spellings/constants only in this owner: its
 * linked SYM emits no completed enum or typedef records for them. */
#define BOOL int
#define uchar unsigned char
#define tMenuTextType int
#define tMenuTextState int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define textType_FramedInfo 3
#define textType_ScreenInfo 4
#define textType_PopUpText 8
#define textType_Default 14
#define tCheatCode int
#define cheat_FinishedTournament 25
#define RaceType_Tournament 2

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
typedef int FEVECTOR[4];
typedef int FEMATRIX[4][4];
#endif

#define NFS4_FE_CORE_SCREENCARSELECT_METHODS
#define NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
#define NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#include "fedialog_types.h"
#ifdef NFS4_SCREENMEMCARD_MANAGERTASK_EXTERNAL   /* retail: MANAGERTASK in the memcard graph (after CARDINFO_def; nearest owner site) */
#include "mcrd_managertask.h"
#endif
#undef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#undef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
#undef NFS4_FE_CORE_SCREENCARSELECT_METHODS

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "shared/DR_AREA.h"
#endif

struct DRender_tView;

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct GameSetup_tData;   /* incomplete here: owner object records it; members reached by offset */




#endif

#if !defined(NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE) && !defined(NFS4_SCREENCARSELECT_TAIL_LATE)   /* TAIL_LATE: screencarselect_tail.h */
#include "shared/AudioMus_tSongEntry.h"
#endif

#ifndef NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
#include "shared/tDrawShapeExtended.h"
#else
struct tDrawShapeExtended;
#endif

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
#include "screencarselect_carstat.h"   /* enum tCarStatType (own guarded header: NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER places it for the owner) */






#endif

#include "shared/tVideoWall.h"   /* one tVideoWall definition (header-truth 4t) */






























struct tOverlay {
    RECT location[2];
    short transition, delta, direction, ID;
};

struct tScreenCarSelect : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void DrawVideoWall(short);
    virtual void InitializeVideoWall();
    virtual void UpdateVideoWall(tCarInfo &);
    virtual bool GetCar(tCarInfo &);
    virtual void AllocateAsyncBuffer();
    virtual void FreeAsyncBuffer();
    tOverlay fOverlays[7];
    tOverlay *fCurrentOverlays[4];
    short fState, fPreviousCar, fPreviousCarID, fPreviousCountry;
    tTVConfig tvConfigs[10];
    tVideoWall fVideoWall[2];
    short fBrightness[2], fDestBrightness[2];
    long fFadeTicks[2];
    bool fTVsInitialized, fInShowroom;
    u_long fShowroomTicks, fSpeechTicks;
    bool fSpeechPlayed;
    int fSplineInterval;
    u_long fCameraRotation;

    tScreenCarSelect();
    ~tScreenCarSelect();
    void DrawOverlay(tOverlay *);
    void SetState(int);
    void CalcSplinePosition(int, int, int, int, u_long, int &, int &, int &, int &, int &);
    void SetBrightness(short, short);
    void UpdateBrightness(short);
    void DrawSliders(tCarInfo &, short, short);
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
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
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void DrawOpponentVideoWall(short);
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    /* implicit ctor (retail declares none: no body block in SYM) */
    void UpdateOpponentVideoWall(tCarInfo &);
#line 285 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#endif
#ifdef NFS4_SCREENCARSELECT_HOOK_AFTER_DUEL   /* owner records right after tScreenCarSelect(Duel), before tScreenCarSelectTwoPlayer (Front: tScreenCarSelectDuel) */
#include NFS4_SCREENCARSELECT_HOOK_AFTER_DUEL
#endif
#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE   /* closed by the #endif after the anchor */
#line 178 "recon/frontend/common/screencarselect_types.h"
#endif

struct tScreenCarSelectTwoPlayer : public tScreenCarSelect {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short);
    void InitializeVideoWall();
    void UpdateVideoWall(tCarInfo &);
    bool GetCar(tCarInfo &);
    void AllocateAsyncBuffer();
    /* virtuals introduced by this class, in retail slot order (real virtuals since 2026-09-20) */
    virtual void TurnOffVideoWall();
    virtual void SetDialog();
    tDialogBackUpOnly CarDialog;

    /* implicit ctor (retail declares none: no body block in SYM) */
#line 313 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#line 199 "recon/frontend/common/screencarselect_types.h"

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
enum PinkSlipsCarSelectState {
    NoCardInserted = 0,
    CardFailed = 1,
    CardFailedNotFound = 2,
    CardFailedUnformatted = 3,
    NotEnoughCars = 4,
    TooManyCars = 5,
    CardLoadedFine = 6,
    WhoCaresWeBeExiting = 7,
    CardCurrentlyLoading = 8
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

    /* implicit ctor (retail declares none: no body block in SYM) */
    void DoMemCardStuff();
#line 348 "C:/nfs4/FRONTEND/COMMON/SCREENCARSELECT.H"
};
#line 219 "recon/frontend/common/screencarselect_types.h"
#endif
#include "screencarselect_tail.h"   /* color.obj graph after the car-select screens (+ AudioMus for ScreenCarSelect) */
struct tScreenTournamentStandings : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void Initialize();
    void Cleanup();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney, fCountedDown;
    bool fStartCountdownNOW;
    int fCountSpeed;
#ifdef NFS4_SCREENCARSELECT_FEMENUDEFS_SURFACE
    inline void SetDrawMoney() { fDrawMoney = 1; }
#endif
#ifdef NFS4_FRONT_SURFACE
    tScreenTournamentStandings();
#endif
};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
#ifdef NFS4_FRONT_SURFACE
    /* implicit ctor (retail declares none: no body block in SYM) */
#endif
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
/* Remaining foreign menu view needs owning-SYM source restoration. */
struct ScreenCarSelect_GlobalMenuDefsCodegenView {
    char _beforeIteratorCar1[0x116c];
    tListIteratorCar iteratorCar1;
    char _beforeItemCar[0x4c];
    tMenuItemNFS4LeftRightChoice itemCar, itemColor;
    tMenuItemGoToMenuNFS4Button itemShowcase;
    char _beforeIteratorGarageCar[0x7c];
    tListIteratorCar iteratorGarageCar;
    tMenuItemNFS4LeftRightChoice itemGarageCar;
    tMenuItemGoToMenuNFS4Button itemCarDealer, itemUpgradeCar;
    char _beforeIteratorOpponentCar[0xf8];
    tListIteratorCar iteratorOpponentCar;
    char _beforeItemColorP1[0x21c];
    tMenuItemNFS4LeftRightChoice itemColorP1;
    char _beforeItemColorP2[0xd0];
    tMenuItemNFS4LeftRightChoice itemColorP2;
    char _beforeIteratorPinkSlipsCar[0x21c];
    tListIteratorCar iteratorPinkSlipsCar;
    char _beforeItemDealerCar[0x2b0];
    tMenuItemNFS4LeftRightChoice itemDealerCar;
    char _beforeItemSellerCar[0x118];
    tMenuItemNFS4LeftRightChoice itemSellerCar;
    tMenuItemGoToMenuNFS4Button itemSellCar;
    char _beforeMenuCarUpgrades[0x100];
    tMenuNFS4 menuCarUpgrades;
    char _beforeItemTransmission[0x48];
    tMenuItemOptionsLeftRightChoice itemTransmission, itemABS, itemDamage;
    tMenuItemOptionsLeftRightChoice itemTransmission2, itemABS2, itemDamage2;
    tMenuItemOptionsLeftRightChoice itemOpponentUpgrades;
};
#define tGlobalMenuDefs ScreenCarSelect_GlobalMenuDefsCodegenView
#endif

#ifdef NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS   /* owner records right after tScreenTournamentStandings3item (FEMenuDefs: femenudefs_tail.h) */
#include NFS4_SCREENCARSELECT_HOOK_AFTER_STANDINGS
#endif
#endif
