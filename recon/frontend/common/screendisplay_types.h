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
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorRangeIndexed() {}
    tListIteratorRangeIndexed(char, char, char *, char *);
    ~tListIteratorRangeIndexed();
    char Value(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
#endif
};

struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightChoice() {}
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
    tMenuItemLeftRightSlider() {}
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
    tMenuItemGoToMenuButton() {}
    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
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

#if defined(NFS4_SCREENDISPLAY_SCREENMEMCARD_METHODS) || \
    defined(NFS4_SCREENDISPLAY_FEDIALOG_METHODS) || \
    defined(NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS)
    tScreen();
    ~tScreen();
#endif
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    void UploadSwapShapes(int);
    void UploadShapes(tShapeInformation &, short, short, short, short);
    void TransitionOff(tScreen_TransitionType, tMenu *)
        __asm__("TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu");
    void TransitionOn(tScreen_TransitionType, tMenu *)
        __asm__("TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu");
#endif
#ifdef NFS4_SCREENDISPLAY_FEAPP_METHODS
    static void DisplayLoadingText();
    void Draw(bool);
    void TransitionOff(int, tMenu *)
        __asm__("TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu");
    void TransitionOn(int, tMenu *)
        __asm__("TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu");
    void UpdateTransition();
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
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    short TextValue(tPlayer);
    void Increment(tPlayer)
        __asm__("Increment__16tListIteratorCar7tPlayer");
    void Decrement(tPlayer)
        __asm__("Decrement__16tListIteratorCar7tPlayer");
#endif
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCar() {}
    tListIteratorCar(char *, tCarManager *);
    ~tListIteratorCar();
    char Value(tPlayer);
    void AdjustPosition(tPlayer, short);
    bool ValidCar(tPlayer, char);
#endif
};

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tListIteratorCarColor() {}
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
    void GetAwardInformation(tAwardInformation &);
    bool IsTournamentFinished();
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
    tListIteratorTrack() {}
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
    tListIteratorTournament() {}
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
    tMenuItemGoToMenuNFS4Button() {}
    tMenuItemGoToMenuNFS4Button(unsigned int, tMenu *, void (*)(tMenuCommand &), int, int);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void Draw(bool);
#endif
};

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemNFS4LeftRightChoice() {}
    tMenuItemNFS4LeftRightChoice(unsigned int, tListIterator *, int, int);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

extern __vtbl_ptr_type tBlankMenuItemNFS4LeftRightChoice_vtable[];
struct tBlankMenuItemNFS4LeftRightChoice : public tMenuItemNFS4LeftRightChoice {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemNFS4LeftRightChoice() {}
    tBlankMenuItemNFS4LeftRightChoice(unsigned int t, tListIterator *d, int ff, int nf)
        : tMenuItemNFS4LeftRightChoice(t, d, ff, nf) {
        _vf = (__typeof__(_vf))&tBlankMenuItemNFS4LeftRightChoice_vtable;
    }
    bool TransitionIsFinished();
    void Draw(int, int, bool);
#endif
};
extern __vtbl_ptr_type tMenuItemOptionsLeftRightChoice_vtable[];
struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemOptionsLeftRightChoice() {}
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d) {
        _vf = (__typeof__(_vf))&tMenuItemOptionsLeftRightChoice_vtable;
    }
    void Draw(int, int, bool);
#endif
};

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemOptionsTwoItemChoice() {}
    tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d) {
        extern __vtbl_ptr_type tMenuItemOptionsTwoItemChoice_vtable[];
        _vf = (__typeof__(_vf))&tMenuItemOptionsTwoItemChoice_vtable;
        fOnOffFade = 0x80;
    }
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
    tMenuNFS4() {}
    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    tMenuNFS4(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short);
    ~tMenuNFS4();
    void Initialize();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition();
    void DrawItem(int);
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
    tMenuNFS4TwoPlayer() {}
    tMenuNFS4TwoPlayer(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4TwoPlayer();
    void DrawItem(int);
#endif
};
struct tMenuNFS4Bottom : public tMenuNFS4 {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuNFS4Bottom() {}
    tMenuNFS4Bottom(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4Bottom();
    void Draw();
#endif
};
struct tMenuBlank : public tMenuNFS4 {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuBlank() {}
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
    tMenuOptions() {}
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

struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    int flareextra;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightFade() {}
    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);
#endif
};

struct tOptionsMenu : public tMenu {
    bool fInMenuTransition;
    signed char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames;
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
    tInsideBoxMenu() {}
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                   void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(short, short, short, short, short);
#endif
};

struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemSlidingMenu() {}
    tMenuItemSlidingMenu(unsigned int, short, short, int, int, bool)
        asm("__20tMenuItemSlidingMenuUissssb");
    ~tMenuItemSlidingMenu();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    long DebounceKeys();
    void Draw(bool);
    void UpdatefOpenHeight(bool);
    void Draw(int, int, bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void SetMenu(bool, tInsideBoxMenu *);
#endif
};

struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemSlidingActivated() {}
    tMenuItemSlidingActivated(unsigned int a, short b, short c, short d, short e, bool f)
        : tMenuItemSlidingMenu(a, b, c, d, e, f) {
        extern __vtbl_ptr_type tMenuItemSlidingActivated_vtable[];
        _vf = (__typeof__(_vf))&tMenuItemSlidingActivated_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemDisplayLeftRightChoice() {}
    tMenuItemDisplayLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {
        extern __vtbl_ptr_type tMenuItemDisplayLeftRightChoice_vtable[];
        _vf = (__typeof__(_vf))&tMenuItemDisplayLeftRightChoice_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(int, int, bool);
#endif
};

struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemOnOffLeftRightChoice() {}
    tMenuItemOnOffLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {
        extern __vtbl_ptr_type tMenuItemOnOffLeftRightChoice_vtable[];
        _vf = (__typeof__(_vf))&tMenuItemOnOffLeftRightChoice_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void TransitionOn();
    void Draw(int, int, bool);
#endif
};

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
    void Draw(short, short, short, short, short);
    void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};

struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemControllerLeftRightChoice() {}
    tMenuItemControllerLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {
        extern __vtbl_ptr_type tMenuItemControllerLeftRightChoice_vtable[];
        _vf = (__typeof__(_vf))&tMenuItemControllerLeftRightChoice_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(int, int, bool);
#endif
};
struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tInsideBoxLeftRightSlider() {}
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

struct tUserNameMenuItem : public tMenuItem {
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    bool fInTransition;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tUserNameMenuItem() {}
    inline void SetUserNameData(short player, char *data) {
        fPlayer = player;
        fMaxStringLength = 7;
        fCurrentRow = 0;
        fCurrentColumn = 0;
        fData = data;
    }
    inline void SetPostGameNameData(short player, char *data) {
        fPlayer = player;
        fData = data;
        fMaxStringLength = 7;
        fCurrentRow = 0;
        fCurrentColumn = 0;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tUserNameMenuItem(unsigned int);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    signed short fEnableVal;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemGoToMenuButtonFade() {}
    tMenuItemGoToMenuButtonFade(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButton(t, m, f) {}
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
};

struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMemoryCardMenuItem() {}
    tMemoryCardMenuItem(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButtonFade(t, m, f) {
        extern __vtbl_ptr_type tMemoryCardMenuItem_vtable[];
        _vf = (__typeof__(_vf))&tMemoryCardMenuItem_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(bool);
#endif
};
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemGoToMenuNFS4Button() {}
    tBlankMenuItemGoToMenuNFS4Button(unsigned int t, tMenu *m,
                                     void (*f)(tMenuCommand &), int ff, int nf)
        : tMenuItemGoToMenuNFS4Button(t, m, f, ff, nf) {
        extern __vtbl_ptr_type tBlankMenuItemGoToMenuNFS4Button_vtable[];
        _vf = (__typeof__(_vf))&tBlankMenuItemGoToMenuNFS4Button_vtable;
    }
    bool TransitionIsFinished();
    void Draw(int, int, bool);
    void Draw(bool);
#endif
};

struct tInsideBoxControllerLeftRightSlider {
    tInsideBoxLeftRightSlider _base_tInsideBoxLeftRightSlider;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tInsideBoxControllerLeftRightSlider() {}
    tInsideBoxControllerLeftRightSlider(unsigned int t, tListIterator *d)
        : _base_tInsideBoxLeftRightSlider(t, d) {
        extern __vtbl_ptr_type tInsideBoxControllerLeftRightSlider_vtable[];
        _base_tInsideBoxLeftRightSlider._vf =
            (__typeof__(_base_tInsideBoxLeftRightSlider._vf))&tInsideBoxControllerLeftRightSlider_vtable;
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
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
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
    tDialogBase();
    short ShouldTimeOut();
    void InitializeClass();
    static void DrawAllDialogs();
    void HideAllDialogs();
    static tDialogBase *GetTopMostDialog();
    void Display();
    void Hide();
    inline bool IsVisible() { return currentlyOn != 0; }
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
#ifdef NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS
    inline tDialogBase *SetPosition(short, short, tPlayer);
#endif
};

struct tDialogMessageString : public tDialogBase {
    char *string;
    bool Centerit;
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
    tDialogMessageString();
    void CalculateDimensions();
    void Draw();
#endif
#if defined(NFS4_SCREENDISPLAY_SCREENCARSELECT_METHODS) || \
    defined(NFS4_SCREENDISPLAY_FEAPP_METHODS) || \
    defined(NFS4_SCREENDISPLAY_CONTROLLER_METHODS)
    inline tDialogMessageString *SetString(char *text) {
        string = text;
        return this;
    }
#endif
};

struct tDialogInteractive : public tDialogMessageString {
    bool ReadyToReturnValue, fCurrentlyRunning;
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
    inline void CalculateDimensionsVirtual() {
        __vtbl_ptr_type (*vf)[10] = _vf;
        (*vf[1][0].pfn)((char *)this + vf[1][0].delta);
    }
    inline void ProcessInputVirtual(tPlayer player, tInputKeyType &key,
                                    tMenuCommand &command) {
        __vtbl_ptr_type (*vf)[10] = _vf;
        (*(*vf)[9].pfn)((char *)this + (*vf)[9].delta,
                        player, &key, &command);
    }
    short Run();
#endif
};

struct tDialogYesNo : public tDialogInteractive {
    int yesnowords[2];
#ifdef NFS4_FEMENUDEFS_SURFACE
    inline tDialogYesNo *SetChoices(int yesWord, int noWord, short defaultValue) {
        yesnowords[0] = yesWord;
        yesnowords[1] = noWord;
        fDefault = defaultValue;
        return this;
    }
#endif
#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
    tDialogYesNo();
    void CalculateDimensions();
    void Draw();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
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
