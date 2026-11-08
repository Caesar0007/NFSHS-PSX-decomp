/* shared/fe_menu_game_surface.h -- the frontend menu roots as the GAME objects see them (audiocmn, gmesetup,
 * pausemenu and their includers).  Retail records these classes in every game object with the full vtables
 * (tListIterator 6 slots, tMenuItem 11, tMenu 11), but none of those objects defines tPlayer, tInputKeyType,
 * tScreen or tMenuCommand.  The virtual lists therefore spell the two enums `int` here (the idiom of
 * frontend/common/felist_classes.h); the SYM records only the slot counts.  Nothing here is dispatched from game code. */
#ifndef NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#define NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#ifndef NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H   /* game owners: the tMenu/tMenuItem inline set of FRONTORD set 23 (retail TPDEF tMenu/tMenuItem 16) */
#define NFS4_FE_SURFACE_TMENU_INLINES
#endif
#include "shared/fe_menu_game_tmenucommand.h"   /* retail: tMenuCommand (tMenu forward copy) before tListIterator; opt-out NFS4_FE_SURFACE_NO_TMENUCOMMAND */
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
#ifdef NFS4_FE_SURFACE_TMENU_INLINES   /* = fe_core_types.h NFS4_FE_CORE_TMENU_ALL_INLINES (frontend/common, FRONTORD set 23) */
    inline unsigned int GetFlags() { return fFlags; }
    inline void SetFlags(unsigned int flags) { fFlags = flags; }
    inline void SetTextDescription(unsigned int text) { fTextDescription = text; }
    inline void Disable() { fFlags |= 1; }
    inline void Enable() { fFlags &= ~1; }
    inline bool IsEnabled() { return ((fFlags ^ 1) & 1) != 0; }
    inline unsigned int LeftRightFlag() { return fFlags & 0x400; }
#endif
#ifdef NFS4_FE_SURFACE_TMENU_INLINES
    /* INFERRED bodies: retail TPDEF tMenuItem x16 per object (7 inline bodies beyond the 7 spelled above); builtin-only, never called */
    inline unsigned int TextDescription() { return fTextDescription; } inline short SelFade() { return fSelFade; } inline void SetSelFade(short v) { fSelFade = v; }
    inline int NumFrames() { return fNumFrames; } inline void SetNumFrames(int v) { fNumFrames = v; } inline int ButtonImageIndex() { return fButtonImage; } inline void SetButtonImageIndex(int v) { fButtonImage = v; }
#endif
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
#ifdef NFS4_FE_SURFACE_TMENU_INLINES   /* = fe_core_tmenu.h with NFS4_FE_CORE_TMENU_ALL_INLINES */
    inline short CurrentItem() { return fCurrentItem; }
    inline void SetChildMenu(tMenu *child) { fChildMenu = child; }
    inline void SetVerticalHelp(short help) { VertHelp = help; }
    inline bool HasFlag(unsigned int flag) { return (fFlags & flag) != 0; }
    inline tMenuItem *Item(int n) { return fItemList[n]; }
    inline bool CanContinue() { return fNextMenu != (tMenu *)0x0 || (fFlags & 0x400) != 0 || fOnButtonPress != 0x0; }
    inline bool HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; }
    inline unsigned int ExitsWithBack() { return fFlags & 0x100; }
    inline tScreen *GetScreen() { return fScreen; }
    inline unsigned int GetMusic() { return fFlags & 0xf000; }
    inline tMenuItem *CurrentMenuItem() { return fItemList[fCurrentItem]; }
#endif
#ifdef NFS4_FE_SURFACE_TMENU_INLINES
    /* INFERRED bodies: retail TPDEF tMenu x16 per object (2 inline bodies beyond the 12 spelled); builtin-only, never called */
    inline short TitleText() { return fTitle; } inline bool NeverAnyEnabled() { return fNeverAnyEnabled; }
#endif
} tMenu;
struct tMenuItemInteractive : public tMenuItem {};
#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own types right after tMenuItemInteractive (nfs3.obj: tScreen) */
#include NFS4_FE_SURFACE_HOOK
#endif
#undef tPlayer
#undef tInputKeyType
#endif
