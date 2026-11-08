#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* Owner-specific type surface for ScreenTrackInfo.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTRACKINFO_TYPES_H
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "fe_input_enums.h"

#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0, kMenu_Command_GoToMenu = 1, kMenu_Command_GoToMenuOneWay = 2, kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4, kMenu_Command_StartRace = 5, kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7, kMenu_Command_StartReplay = 8, kMenu_Command_ClearRecords = 9
};

struct tMenu;
#include "shared/tMenuCommand.h"
#endif

#define NFS4_FE_CORE_FELINES_LATE   /* retail ScreenTrackInfo: frontend core + menu items before the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE   /* retail: car/track/tournament records after tShapeInformation/tActiveLine */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo (fe_core_cars.h) */
#include "fe_core_types.h"
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd (fe_core_cars.h) */
#define tMenuTextState int
#define tMenuTextType int
#define textState_Unselected 0
#define textState_Selected 1
#define textState_Hilighted 2
#define textType_ScreenInfo 4
#define textType_TrackRecords 11
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
#undef NFS4_DRAW_LEAF_CORE_ONLY   /* ScreenAudio: draw_leaf phase 2 (PCOORD16 .. Draw_*) after the menu core */
#include "felines_types.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "shared/tActiveLine.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio keeps TV after the tournament records */
enum tTVState { tv_StateOff = 0, tv_StateOn = 1, tv_TransitionOn = 2, tv_TransitionOff = 3 };   /* retail: TV after kernpair, before the cars */
#include "shared/tTVConfig.h"
#else   /* ScreenAudio: retail AudioMus + tScreenAudio right after tShapeInformation/tActiveLine */
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"
#include "screenaudio.h"
#endif


#include "fe_core_cars.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio: track/tournament records after its menu family (below) */
#define NFS4_FE_TRACK_NO_PLAYER   /* track/tournament records without an extra player surface */
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
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
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
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
    short *GetTrackList(short tier, short tournament);
    void GetTrackToRace(tTrackInfo &track);
    /* ORIGINAL-NAME-UNRESOLVED: inline read of the current-track field. */
    int CurrentTrack() { return fCurrentTrack; }
    /* ORIGINAL-NAME-UNRESOLVED: inline money mutator and amount parameter.
       Unsigned access through the corresponding signed/unsigned type keeps
       the target's word-width arithmetic defined without another source local. */
    void SubtractMoney(u_long amount) { (u_long &)fMoney -= amount; }
    /* ORIGINAL-NAME-UNRESOLVED: same typed accessor used by the tournament owner. */
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
};
struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
};
struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
};
#endif

#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* retail: tVideoWall + tScreenTrackInfo before the tMenuNFS4 family */
struct tVideoWall {
    tTVConfig *fTVs; short fFirstTVShape, fNumTVs; tTexture_ShapeInfo *fTVShapes; short *tvOrder; u_long fTVTicks;
    short fTransitionDirection, fFlipAxis, fOffsetX, fOffsetY; short fAvailableTextID, fAvailable, fAvailableBright, fValid;
    short fAvailableX, fAvailableY; tTexture_ShapeInfo *fIconShapes; short fIcon, fIconFrames, fIconX, fIconY;
    bool fUpdated; void Initialize(tTVConfig *, tTexture_ShapeInfo *, short, short, short *, short); void UpdateImages(); void UpdateTransition(); void Draw(); void TurnOffInstant(); void TurnOn();
};
#include "screentrackinfo.h"
#endif
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
    int fScreenFade, fFirstFrame, fNumFrames; bool TransitionIsFinished();
    /* Same nonvirtual field accessor as the recovered display/user-name
       surface. Original inline spelling is not uniquely recorded by SYM. */
    int GetScreenFade() { return fScreenFade; }
    /* Inferred inline selector, following tPMenu's CurrentItem spelling. */
    short CurrentItem() { return (short)fCurrentItem; }
};

struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;
};

struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback; void SetMenu(bool, tInsideBoxMenu *);
};

struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
    /* ORIGINAL-NAME-UNRESOLVED: inferred field accessor for the retail activation pair. */
    bool IsActive() { return fActive; }
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
    int Percentage();
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

struct tInsideBoxControllerLeftRightSlider : public tInsideBoxLeftRightSlider {
};

#ifdef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* retail ScreenAudio: tracks + tournaments after the menu family (same text as above) */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
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
    short *GetTrackList(short tier, short tournament);
    void GetTrackToRace(tTrackInfo &track);
    /* ORIGINAL-NAME-UNRESOLVED: inline read of the current-track field. */
    int CurrentTrack() { return fCurrentTrack; }
    /* ORIGINAL-NAME-UNRESOLVED: inline money mutator and amount parameter.
       Unsigned access through the corresponding signed/unsigned type keeps
       the target's word-width arithmetic defined without another source local. */
    void SubtractMoney(u_long amount) { (u_long &)fMoney -= amount; }
    /* ORIGINAL-NAME-UNRESOLVED: same typed accessor used by the tournament owner. */
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
};
struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
};
struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
};
#endif

#ifdef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
enum tTVState { tv_StateOff = 0, tv_StateOn = 1, tv_TransitionOn = 2, tv_TransitionOff = 3 };
#include "shared/tTVConfig.h"
#endif



#include "fedialog.h"
#include "shared/tCredit.h"

enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
};

#include "shared/tVideoTransition.h"
#include "shared/tVideo.h"

#endif
