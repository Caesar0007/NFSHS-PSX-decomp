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


struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightChoice(unsigned int, tListIterator *);
    ~tMenuItemLeftRightChoice();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
#endif
};

struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightSlider(unsigned int, tListIterator *);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void SetDimensions(short, short, short, short);
#endif
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(void *);
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tDrawShapeExtended;

#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"
#include "shared/tActiveLine.h"

#ifndef NFS4_SCREENDISPLAY_NO_OWNER_RECORDS
#include "screendisplay.h"
#endif

struct tCarManager;
struct tListIteratorCar : public tListIterator {
    int fCarListFilter;
    tCarManager *fCarManager;
    tCarNameLength fNameLength;
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    short TextValue(tPlayer);
    void Increment(tPlayer)
        __asm__("Increment__16tListIteratorCar7tPlayer");
    void Decrement(tPlayer)
        __asm__("Decrement__16tListIteratorCar7tPlayer");
#endif
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCar(char *, tCarManager *);
    ~tListIteratorCar();
    char Value(tPlayer);
    void AdjustPosition(tPlayer, short);
    bool ValidCar(tPlayer, char);
    inline void SetFilter(int filter) { fCarListFilter = filter; }
#endif
};

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCarColor(char *, char *, char *, int, tCarManager *);
    ~tListIteratorCarColor();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
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
#ifdef NFS4_TSCREENCONGRATS_OWNER
    /* Real nonvirtual methods/signatures from the FETourn SYM and owner. */
    short PlayerRanking(short);
    void GetAwardInformation(tAwardInformation &);
    /* ORIGINAL-NAME-UNRESOLVED: same reconstructed CurrentTourney accessor
       used by FETourn; retail's inline pair does not retain its spelling. */
    tTourneyInfo *CurrentTourney() {
        return &fDefinition->fTournaments[fDefinition->fTiers[fTier].fTournOffset + fTournament];
    }
    /* ORIGINAL-NAME-UNRESOLVED: inferred accessor spelling for the racer-count
       field; retail's inline pair does not record the original method name. */
    int NumRacers() { return fNumRacers; }
    /* ORIGINAL-NAME-UNRESOLVED: inferred getter for the previous-placement
       read pairs. Preserve the signed byte value seen in the retail loads. */
    int PreviousPlacement() { return (signed char)fPrevBestPlacement; }
#endif
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    void GetTrackToRace(tTrackInfo &);
#endif
#ifdef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
    void CalcTrackFinishDamageBill(bool, long &, long &);
    void GetAwardInformation(tAwardInformation &);
    short TournPointTotal(short *);
    short PlayerRanking(short);
#endif
#ifdef NFS4_FEMENUDEFS_SURFACE
    void StartNewTournament(unsigned char, unsigned char);
    /* Inferred overload/signature/parameter spellings of the known query:
       explicit frontend selection, not the manager's cached selection.
       Retail inline records verify the operation, not its literal name. */
    inline tTourneyInfo *CurrentTourney(unsigned char tier, unsigned char tournament) {
        return &fDefinition->fTournaments[fDefinition->fTiers[tier].fTournOffset + tournament];
    }
    /* Inferred getter spelling; the retail initial money-read inline pair
       retains no method name. No storage or virtual slot is added. */
    inline long GetMoney() { return fMoney; }
    /* Original inline name/signature not uniquely recovered. Mutator spelling
       follows the track-info reconstruction; retail here records LONG amount
       in the parameter scope. No storage or virtual slot is added. */
    inline void SubtractMoney(long amount) {
        (u_long &)fMoney -= (u_long)amount;
    }
    void GetAwardInformation(tAwardInformation &);
    short IsTournamentFinished(); /* retail EXT5c91d6: FCN SHORT */
#endif
#ifdef NFS4_FRONT_SURFACE
    short AdvanceToNextTrack();
    short GetLastTrackRaced();
    void UpdateCarLineup();
    void UpdateAwardInformation();
#endif
};

struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorTrack(char *, char *, tTrackManager *);
    ~tListIteratorTrack();
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
    bool ValidTrack(char);
#endif
};

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorTournament(char *, tTournamentManager *);
    ~tListIteratorTournament();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
    bool ValidTournament(char);
#endif
};

struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemGoToMenuNFS4Button(unsigned int, tMenu *, void (*)(tMenuCommand &), int, int);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void Draw(bool) {}   /* in-class inline: see femenuextended.cpp tail */
#endif
};

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
#ifdef NFS4_FEMENUDEFS_SURFACE
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
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemNFS4LeftRightChoice(unsigned int t, tListIterator *d, int ff, int nf)
        : tMenuItemNFS4LeftRightChoice(t, d, ff, nf) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};
struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d) {}
    void Draw(int, int, bool);
#endif
};

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;
#ifdef NFS4_FEMENUDEFS_SURFACE
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
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short);
    ~tMenuNFS4();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
    virtual void DrawItem(int);
    void Draw();
#endif
#ifdef NFS4_SCREENDISPLAY_FEAPP_METHODS
    /* FEApp's menuMain calls the derived override.  The tPlayer record is
     * absent from this owner graph, so retain its retail symbol explicitly. */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &)
        asm("ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand");
#endif
};

struct tMenuNFS4TwoPlayer : public tMenuNFS4 {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuNFS4TwoPlayer(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4TwoPlayer();
    virtual void DrawItem(int);
#endif
};
struct tMenuNFS4Bottom : public tMenuNFS4 {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuNFS4Bottom(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4Bottom();
    void Draw();
#endif
};
struct tMenuBlank : public tMenuNFS4 {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuBlank(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short);
    ~tMenuBlank();
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Initialize();
    long DebounceKeys();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
#endif
};

struct tMenuOptions : public tMenuNFS4 {
    u_long fMenuEnterTicks;
    short fPlayer;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuOptions(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, short, tMenuItem *, ...);
    ~tMenuOptions();
    void Draw();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    bool IsSubMenu();
#endif
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 1
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

struct tOptionsMenu : public tMenu {
    bool fInMenuTransition;
    signed char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames;
    /* W86-S4 SYM: tScreenUserName::DrawBackground's `8c` block carries a NESTED
       block whose only record is `REG this $2 v0 PTR STRUCT tag tOptionsMenu`,
       emitted at the function's first statement -- an INLINED tOptionsMenu
       accessor reading fScreenFade there (the SYM records the inlined `this`,
       not the method's name). */
    int GetScreenFade() { return fScreenFade; }
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tOptionsMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                 void (*)(tMenuCommand &), short, int, int,
                 tMenuItem *, ...);
    ~tOptionsMenu();
    long DebounceKeys();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                   void (*)(tMenuCommand &), short, tMenuItem *, ...);
    /* non-variadic form for derived classes (tInsideBoxSongMenu): retail's SongMenu ctor calls the tMenu ctor
     * directly and stores only its own table, i.e. this one is inline */
    /* Retail SongMenu's expanded constructor records these exact parameter
       names at depth1 in registers8/9; they are not caller locals o/fn.
       The other spellings follow the recorded variadic overload's argument
       roles; their literal inline spellings are absent from optimized SYM. */
    tInsideBoxMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu,
                   void (*OnButtonPress)(tMenuCommand &), short title)
        : tMenu(flags, screenHandler, nextMenu, optionsMenu, OnButtonPress, title) {}
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    virtual void Draw(short, short, short, short, short);
#endif
};

struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
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
    void SetMenu(bool, tInsideBoxMenu *);
#endif
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 2
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

#define NFS4_FEMENUOPTIONS_TYPE_PART 3
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

#define NFS4_FEMENUOPTIONS_TYPE_PART 4
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

struct tMenuItemLeftRightAudioSlider : public tMenuItemLeftRightSlider {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    short fAudioArt;
    int flareextra;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightAudioSlider(unsigned int, tListIterator *, int);
    ~tMenuItemLeftRightAudioSlider();
    void Draw(int, int, bool);
    int Percentage();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

struct tInsideBoxSongMenu : public tInsideBoxMenu {
    short fOnOffFade[5], fSelFade[5];
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tInsideBoxSongMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                       void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxSongMenu();
    virtual void Draw(short, short, short, short, short);
    virtual void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 5
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tInsideBoxLeftRightSlider(unsigned int, tListIterator *);
    ~tInsideBoxLeftRightSlider();
    void Draw(int, int, int, bool);
#endif
};

struct tInsideBoxTwoWaySlider : public tMenuItemLeftRightSlider {
    short fType;
    bool fActive;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tInsideBoxTwoWaySlider(unsigned int, tListIterator *, int);
    ~tInsideBoxTwoWaySlider();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(int, int, int, bool);
    void Calibrate();
#endif
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 6
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

#define NFS4_FEMENUOPTIONS_TYPE_PART 7
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

#define NFS4_FEMENUOPTIONS_TYPE_PART 8
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemGoToMenuNFS4Button(unsigned int t, tMenu *m,
                                     void (*f)(tMenuCommand &), int ff, int nf)
        : tMenuItemGoToMenuNFS4Button(t, m, f, ff, nf) {}
    /* in-class inlines are emitted in REVERSE declaration order (retail: TIF, Draw(iib), Draw(b), then the dtor) */
    void Draw(bool) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 9
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART

typedef enum tTVState {
    tv_StateOff = 0,
    tv_StateOn = 1,
    tv_TransitionOn = 2,
    tv_TransitionOff = 3
} tTVState;

#include "shared/tTVConfig.h"










#include "fedialog.h"

#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* FEDialog.obj: retail order is Base, Help, MessageString, ... */
#endif


#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* ..., MessageString, BackUpOnly, NoInputMessage, Interactive, ... */
#endif




#include "shared/tCredit.h"






typedef enum tScreenMainState {
    kScreenMain_Off = 0,
    kScreenMain_StaticImage = 1,
    kScreenMain_DynamicImage = 2,
    kScreenMain_WarningImage = 3,
    kScreenMain_Credits = 4
} tScreenMainState;

#include "shared/tVideoTransition.h"








#include "shared/tVideo.h"



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
