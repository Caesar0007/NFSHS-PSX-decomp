/* Owner-specific type surface for ScreenCarSelect.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENCARSELECT_TYPES_H

/* These identifiers are source spellings/constants only in this owner: its
 * linked SYM emits no completed enum or typedef records for them. */
#define BOOL int
#define uchar unsigned char
#define tScreen_TransitionType int
#define kScreen_TransitionTypeScreen 2
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
#undef NFS4_FEDIALOG_SCREENCARSELECT_SURFACE
#undef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
#undef NFS4_FE_CORE_SCREENCARSELECT_METHODS

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct DR_AREA {
    u_long tag;
    u_long code[2];
};
#endif

struct DRender_tView;

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct ScreenCarSelect_GameSetupCodegenView {
    int _beforeTrack[15];
    int track;
};
#define GameSetup_tData ScreenCarSelect_GameSetupCodegenView
#endif

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};
#endif

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
enum tCarStatType {
    cst_Acceleration = 0,
    cst_Brake = 1,
    cst_Speed = 2,
    cst_Handling = 3,
    cst_Overall = 4
};

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
#endif

struct tVideoWall {
    tTVConfig *fTVs;
    short fFirstTVShape, fNumTVs;
    tTexture_ShapeInfo *fTVShapes;
    short *tvOrder;
    u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY;
    short fAvailableTextID, fAvailable, fAvailableBright, fValid;
    short fAvailableX, fAvailableY;
    tTexture_ShapeInfo *fIconShapes;
    short fIcon, fIconFrames, fIconX, fIconY;
    bool fUpdated;

    void Initialize(tTVConfig *, tTexture_ShapeInfo *, short, short, short *, short);
    void UpdateImages();
    void SetAvailableText(short, short, short);
    void SetAvailableIcon(short, short, short, short, tTexture_ShapeInfo *);
    void SetOffset(short, short);
    void SetAvailable(short);
    void SetValid(short);
    void UpdateTransition();
    void Draw();
    void TurnOff();
    void TurnOffInstant();
    void TurnOn();
};

struct tOverlay {
    RECT location[2];
    short transition, delta, direction, ID;
};

struct tScreenCarSelect : public tScreen {
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
    void Cleanup();
    void DrawOverlay(tOverlay *);
    void SetState(int);
    void CalcSplinePosition(int, int, int, int, u_long, int &, int &, int &, int &, int &);
    void GetShapeInfo(short &, short &, char **, char **);
    void UpdateVideoWall(tCarInfo &);
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void DrawVideoWall(short);
    bool GetCar(tCarInfo &);
    void SetBrightness(short, short);
    void UpdateBrightness(short);
    void DrawBackground();
    void DrawSliders(tCarInfo &, short, short);
    void DrawForeground();
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct tScreenCarSelectDuel : public tScreenCarSelect {
    short fPreviousOpponent;
    bool fOpponentTVsInitialized;
    tShapeInformation fOpponentShapes;

    tScreenCarSelectDuel();
    void PreLoad();
    void AllocateAsyncBuffer();
    void FreeAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    void Cleanup();
    void DrawVideoWall(short);
    void DrawOpponentVideoWall(short);
    void GetShapeInfo(short &, short &, char **, char **);
    void UpdateVideoWall(tCarInfo &);
    void UpdateOpponentVideoWall(tCarInfo &);
    void DrawBackground();
    void DrawForeground();
};
#endif

struct tScreenCarSelectTwoPlayer : public tScreenCarSelect {
    tDialogBackUpOnly CarDialog;

    tScreenCarSelectTwoPlayer();
    ~tScreenCarSelectTwoPlayer() {}
    bool GetCar(tCarInfo &);
    void DrawVideoWall(short);
    void GetShapeInfo(short &, short &, char **, char **);
    void UpdateVideoWall(tCarInfo &);
    void TurnOffVideoWall();
    void DrawBackground();
    void DrawForeground();
    void SetDialog();
    void AllocateAsyncBuffer();
    void InitializeVideoWall();
    void Initialize();
    void Cleanup();
};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
struct tScreenPinkSlipsCarSelect : public tScreenCarSelectTwoPlayer {
    int waitfordialog;
    CARDINFO_def *pCI;
    int fStartCheckTick;
    bool fCardFailed, fExitingScreen;

    tScreenPinkSlipsCarSelect();
    ~tScreenPinkSlipsCarSelect() {}
    bool GetCar(tCarInfo &);
    void DrawBackground();
    void DoMemCardStuff();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    void SetDialog();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void GetShapeInfo(short &, short &, char **, char **);
};
#endif

struct tScreenTournamentStandings : public tScreen {
    long moneyFinal, moneyAwarded, moneyDamage, moneyBonus;
    int starttick;
    bool gotmoney, gotbonus, gotbilled, fDrawMoney, fCountedDown;
    bool fStartCountdownNOW;
    int fCountSpeed;
};

struct tScreenTournamentStandings3item : public tScreenTournamentStandings {};

#ifndef NFS4_SCREENCARSELECT_SCREENCONGRATS_SURFACE
/* pad.obj's aggregate tag is absent from ScreenCarSelect.obj; only buf[0]
 * is required by this owner. */
struct ScreenCarSelect_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
};
#define tPadModuleState ScreenCarSelect_PadCodegenView

/* The foreign menu singleton is retained only through these member offsets. */
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

#endif
