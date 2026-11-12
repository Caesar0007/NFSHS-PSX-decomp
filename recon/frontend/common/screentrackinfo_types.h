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
#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes (+ tMenu after them when keyed); no private copies (header-truth 4c) */































#undef NFS4_DRAW_LEAF_CORE_ONLY   /* ScreenAudio: draw_leaf phase 2 (PCOORD16 .. Draw_*) after the menu core */
#define NFS4_FELINES_KERNPAIR_LATE   /* retail: tTexture_ShapeInfo, tActiveLine, tShapeInformation, then kernpair */
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio keeps TV after the tournament records */
#include "felines_kern.h"
enum tTVState { tv_StateOff = 0, tv_StateOn = 1, tv_TransitionOn = 2, tv_TransitionOff = 3 };   /* retail: TV after kernpair, before the cars */
#include "shared/tTVConfig.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"   /* retail: tListIteratorTrack right after tTrackManager */
#else   /* ScreenAudio: retail AudioMus + tScreenAudio right after tShapeInformation/tActiveLine */
#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"
#include "screenaudio.h"
#include "felines_kern.h"   /* retail ScreenAudio: kernpair right after tScreenAudio */
#endif
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"   /* retail: tListIteratorCar/Color right after tCarManager */
#include "fe_core_cars.h"
#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* ScreenAudio: track/tournament records after its menu family (below) */
#define NFS4_FE_TRACK_NO_PLAYER   /* track/tournament records without an extra player surface */
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#endif









#ifndef NFS4_SCREENTRACKINFO_AUDIO_SURFACE
typedef struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65]; short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
#include "shared/tTournamentManager_inl.h"   /* retail in-class inline bodies (see file) */
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
} tTournamentManager;



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
NFS4_TD_tMenuItemGoToMenuNFS4Button struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemGoToMenuNFS4Button(unsigned int, tMenu *, void (*)(tMenuCommand &), int, int);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void Draw(bool) {}
#endif
} NFS4_TDN_tMenuItemGoToMenuNFS4Button;
struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemNFS4LeftRightChoice(unsigned int, tListIterator *, int, int);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};
struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tBlankMenuItemNFS4LeftRightChoice(unsigned int t, tListIterator *d, int ff, int nf)
        : tMenuItemNFS4LeftRightChoice(t, d, ff, nf) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};
struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d) {}
    void Draw(int, int, bool);
#endif
};
struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d)
    { fOnOffFade = 0x80; }
    void TransitionOn();
    void Draw(int, int, bool);
#endif
};
struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
};
NFS4_TD_tMenuNFS4TwoPlayer struct tMenuNFS4TwoPlayer : public tMenuNFS4 {} NFS4_TDN_tMenuNFS4TwoPlayer;   /* retail C-style typedef form (shared selector; FESCR2) */
struct tMenuNFS4Bottom : public tMenuNFS4 {};
NFS4_TD_tMenuBlank struct tMenuBlank : public tMenuNFS4 {} NFS4_TDN_tMenuBlank;   /* retail C-style typedef form (shared selector; FESCR2) */
struct tMenuOptions : public tMenuNFS4 {
    u_long fMenuEnterTicks;
    short fPlayer;
};
NFS4_TD_tMenuItemLeftRightFade struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    int flareextra;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);
#endif
} NFS4_TDN_tMenuItemLeftRightFade;
NFS4_TD_tOptionsMenu struct tOptionsMenu : public tMenu {
    bool fInMenuTransition;
    signed char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames; bool TransitionIsFinished();
    /* Same nonvirtual field accessor as the recovered display/user-name
       surface. Original inline spelling is not uniquely recorded by SYM. */
    int GetScreenFade() { return fScreenFade; }
    /* Inferred inline selector, following tPMenu's CurrentItem spelling. */
    short CurrentItem() { return (short)fCurrentItem; }
} NFS4_TDN_tOptionsMenu;

struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    tInsideBoxMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu,
                   void (*OnButtonPress)(tMenuCommand &), short title);   /* defined right after the class (screendisplay_types.h spelling) */
    virtual void Draw(short, short, short, short, short);
#endif
};
#ifdef NFS4_FE_MENUITEM_INLINES
inline tInsideBoxMenu::tInsideBoxMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu,
                                      void (*OnButtonPress)(tMenuCommand &), short title)
    : tMenu(flags, screenHandler, nextMenu, optionsMenu, OnButtonPress, title) {}
#endif

struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback; void SetMenu(bool, tInsideBoxMenu *);
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemSlidingMenu(unsigned int, short, short, short, short, bool);
    ~tMenuItemSlidingMenu();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    long DebounceKeys();
    void Draw(bool);
    virtual void UpdatefOpenHeight(bool);
    void Draw(int, int, bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
    /* ORIGINAL-NAME-UNRESOLVED: inferred field accessor for the retail activation pair. */
    bool IsActive() { return fActive; }
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemSlidingActivated(unsigned int a, short b, short c, short d, short e, bool f)
        : tMenuItemSlidingMenu(a, b, c, d, e, f) {
    }
    virtual void UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemDisplayLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
    void Draw(int, int, bool);
#endif
};

struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemOnOffLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
    void TransitionOn();
    void Draw(int, int, bool);
#endif
};

struct tMenuItemLeftRightAudioSlider : public tMenuItemLeftRightSlider {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    short fAudioArt;
    int flareextra;
    int Percentage();
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemLeftRightAudioSlider(unsigned int, tListIterator *, int);
    ~tMenuItemLeftRightAudioSlider();
    void Draw(int, int, bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

struct tInsideBoxSongMenu : public tInsideBoxMenu {
    short fOnOffFade[5], fSelFade[5];
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tInsideBoxSongMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxSongMenu();
    virtual void Draw(short, short, short, short, short);
    virtual void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemControllerLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
    void Draw(int, int, bool);
#endif
};
struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tInsideBoxLeftRightSlider(unsigned int, tListIterator *);
    ~tInsideBoxLeftRightSlider();
    void Draw(int, int, int, bool);
#endif
};

struct tInsideBoxTwoWaySlider : public tMenuItemLeftRightSlider {
    short fType;
    bool fActive;
};

NFS4_TD_tUserNameMenuItem struct tUserNameMenuItem : public tMenuItem {
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    bool fInTransition;
} NFS4_TDN_tUserNameMenuItem;

struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    signed short fEnableVal;
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMenuItemGoToMenuButtonFade(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButton(t, m, f) {}

    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tMemoryCardMenuItem(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButtonFade(t, m, f) {
    }
    void Draw(bool);
#endif
};
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tBlankMenuItemGoToMenuNFS4Button(unsigned int t, tMenu *m, void (*f)(tMenuCommand &), int ff, int nf)
        : tMenuItemGoToMenuNFS4Button(t, m, f, ff, nf) {}
    void Draw(bool) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};

struct tInsideBoxControllerLeftRightSlider : public tInsideBoxLeftRightSlider {
#ifdef NFS4_FE_MENUITEM_INLINES   /* retail: full member declarations + in-class bodies, as the shared family headers (FESCR2) */
    tInsideBoxControllerLeftRightSlider(unsigned int t, tListIterator *d)
        : tInsideBoxLeftRightSlider(t, d) {}
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

#ifdef NFS4_SCREENTRACKINFO_AUDIO_SURFACE   /* retail ScreenAudio: tracks + tournaments after the menu family (same text as above) */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
typedef struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65]; short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
#include "shared/tTournamentManager_inl.h"   /* retail in-class inline bodies (see file) */
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
} tTournamentManager;
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
