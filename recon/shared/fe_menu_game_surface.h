/* shared/fe_menu_game_surface.h -- the frontend menu roots as the GAME objects see them (audiocmn, gmesetup,
 * pausemenu and their includers).  Retail records these classes in every game object with the full vtables
 * (tListIterator 6 slots, tMenuItem 11, tMenu 11), but none of those objects defines tPlayer, tInputKeyType,
 * tScreen or tMenuCommand.  The virtual lists therefore spell the two enums `int` here (the idiom of
 * frontend/common/felist_classes.h); the SYM records only the slot counts.  Nothing here is dispatched from game code. */
#ifndef NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#define NFS4_SHARED_FE_MENU_GAME_SURFACE_H

#define tPlayer int
#define tInputKeyType int

typedef struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    virtual ~tListIterator();
    virtual char Value(tPlayer);
    virtual short TextValue(tPlayer);
    virtual void Increment(tPlayer);
    virtual void Decrement(tPlayer);
    /* the four inline accessors (one tListIterator record each, as retail records 6 in these objects too) */
    int MinValue() { return (unsigned char)fMinValue; }
    int MaxValue() { return (unsigned char)fMaxValue; }
    int Range() { return (unsigned char)fMaxValue - (unsigned char)fMinValue; }
    short Selection(int i) { return fSelectionList[i]; }
} tListIterator;
#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own type right after tListIterator (nfs3.obj: tListIteratorIndexed) */
#include NFS4_FE_SURFACE_HOOK
#endif
struct tListIteratorRange : public tListIterator {};
typedef struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    virtual ~tMenuItem(); virtual long DebounceKeys();
    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &); virtual void Draw(bool);
    virtual void Draw(int, int, bool);
    virtual void Draw(int, int, int, bool);
    virtual void TransitionOff();
    virtual void TransitionOn();
    virtual bool TransitionIsFinished();
    virtual void UpdateTransition(bool);
} tMenuItem;
typedef tMenuItem *tItemList[16];
typedef struct tMenu {
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
} tMenu;
struct tMenuItemInteractive : public tMenuItem {};
#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own types right after tMenuItemInteractive (nfs3.obj: tScreen) */
#include NFS4_FE_SURFACE_HOOK
#endif
#undef tPlayer
#undef tInputKeyType
#endif
