/* shared/fe_menu_game_surface.h -- the frontend menu roots as the GAME objects see them (audiocmn, gmesetup,
 * pausemenu and their includers).  Retail records these classes in every game object with the full vtables
 * (tListIterator 6 slots, tMenuItem 11, tMenu 11), but none of those objects defines tPlayer, tInputKeyType,
 * tScreen or tMenuCommand.  The virtual lists therefore spell the two enums `int` here (the idiom of
 * frontend/common/felist_classes.h); the SYM records only the slot counts.  Nothing here is dispatched from game code. */
#ifndef NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#define NFS4_SHARED_FE_MENU_GAME_SURFACE_H

#define tPlayer int
#define tInputKeyType int

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    virtual ~tListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
};
struct tListIteratorRange : public tListIterator {};

struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    virtual ~tMenuItem();
    virtual long DebounceKeys();
    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    virtual void Draw(bool);
    virtual void Draw(int, int, bool);
    virtual void Draw(int, int, int, bool);
    virtual void TransitionOff();
    virtual void TransitionOn();
    virtual bool TransitionIsFinished();
    virtual void UpdateTransition(bool);
};
typedef tMenuItem *tItemList[16];

struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tMenuItem *fItemList[16];
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
    void (*fOnButtonPress)(tMenuCommand&);
    short VertHelp;
    virtual ~tMenu();
    virtual void Initialize();
    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    virtual long DebounceKeys();
    virtual void TransitionOff();
    virtual void TransitionOn();
    virtual bool TransitionIsFinished();
    virtual bool IsSubMenu();
    virtual void Draw();
    virtual void UpdateTransition();
};
struct tMenuItemInteractive : public tMenuItem {};

#undef tPlayer
#undef tInputKeyType

#endif
