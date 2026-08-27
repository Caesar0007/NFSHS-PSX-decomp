/* Owner-specific type surface for ScreenDisplay.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENDISPLAY_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENDISPLAY_TYPES_H

#include "fe_core_types.h"

/* Track/tournament records are retained without the foreign tPlayer enum or
 * their member-method surfaces in this owner.  The track surface also owns
 * the retail tListIteratorIndexed record used below. */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

struct tListIteratorRangeIndexed : public tListIteratorRange {
    char *fIndex;
};

struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
};

struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
};

struct tDrawShapeExtended;

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    bool fLoadCancelled;
};

struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    __vtbl_ptr_type (*_vf)[10];

#ifdef NFS4_SCREENDISPLAY_SCREENMEMCARD_METHODS
    tScreen();
    ~tScreen();
#endif
    void PreLoad();
    void Initialize();
    void Cleanup();
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

#ifndef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
struct tScreenDisplay : public tScreen {
    void DrawBackground();
    void GetShapeInfo(short &, short &, char **, char **);
};
#endif

struct tCarManager;
struct tListIteratorCar : public tListIterator {
    int fCarListFilter;
    tCarManager *fCarManager;
    tCarNameLength fNameLength;
};

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;
};

struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65];
    short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
};

struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
};

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
};

struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
};

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
};

struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {};
struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {};

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;
};

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
};

struct tMenuNFS4TwoPlayer : public tMenuNFS4 {};
struct tMenuNFS4Bottom : public tMenuNFS4 {};
struct tMenuBlank : public tMenuNFS4 {};

struct tMenuOptions : public tMenuNFS4 {
    u_long fMenuEnterTicks;
    short fPlayer;
};

struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    int flareextra;
};

struct tOptionsMenu : public tMenu {
    bool fInMenuTransition;
    signed char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames;
};

struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;
};

struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback;
};

struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
};

struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {};

struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;
};

struct tMenuItemLeftRightAudioSlider : public tMenuItemLeftRightSlider {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    short fAudioArt;
    int flareextra;
};

struct tInsideBoxSongMenu : public tInsideBoxMenu {
    short fOnOffFade[5], fSelFade[5];
};

struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {};
struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {};

struct tInsideBoxTwoWaySlider : public tMenuItemLeftRightSlider {
    short fType;
    bool fActive;
};

struct tUserNameMenuItem : public tMenuItem {
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    bool fInTransition;
};

struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    signed short fEnableVal;
};

struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {};
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {};

struct tInsideBoxControllerLeftRightSlider {
    tInsideBoxLeftRightSlider _base_tInsideBoxLeftRightSlider;
};

typedef enum tTVState {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
} tTVState;

struct tTVConfig {
    tTVState state;
    short transition;
    u_short destBrightness, flags;
    short fxWide, fxThin;
    int tint;
    short x, y, w, h;
    u_char u, v, uw, vh, shapeType;
    u_short clut, tpage, shapex, shapey, clutID, flip_axis;
};

struct tDialogBase : public tScreen {
    short specificPlayer, left, top, width, height, reservedheight;
    bool currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    bool fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
};

struct tDialogMessageString : public tDialogBase {
    char *string;
    bool Centerit;
};

struct tDialogInteractive : public tDialogMessageString {
    bool ReadyToReturnValue, fCurrentlyRunning;
};

struct tDialogYesNo : public tDialogInteractive {
    int yesnowords[2];
};

struct tCredit {
    short titleTextID, subTitleTextID, titleX, titleY, titleJustify, titleWidth;
    short subTitleX, subTitleY, subTitleJustify, subTitleWidth;
    short textX, textY, textJustify, creditType, bgNumber, pad;
    char text[292];
};

typedef enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
} tScreenMainState;

struct tVideoTransition {
    tScreenMainState state;
    u_short flags;
    u_char u, v, uw, vh;
    u_short clut, tpage;
    unsigned int tint;
    short bright;
};

struct tVideo {
    char x, y, width, height, tileWidth, tileHeight, deltaX, deltaY;
};

#ifndef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
/* Only this offset is used by ScreenDisplay.  The real aggregate owner is
 * reconstructed in FEMenuDefs; keep this compiler-boundary view explicit. */
struct ScreenDisplay_GlobalMenuDefsCodegenView {
    char _beforeMenuDisplayOptions[0x2a68];
    tOptionsMenu menuDisplayOptions;
};
#define tGlobalMenuDefs ScreenDisplay_GlobalMenuDefsCodegenView
#endif

struct SndBnk_t;
struct SPEECHINFO;

#endif
