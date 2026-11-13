/* shared/fe_menu_game_surface.h -- the frontend menu roots as the GAME objects see them (audiocmn, gmesetup,
 * pausemenu and their includers).  Retail records these classes in every game object with the full vtables
 * (tListIterator 6 slots, tMenuItem 11, tMenu 11), but none of those objects defines tPlayer, tInputKeyType,
 * tScreen or tMenuCommand.  The virtual lists therefore spell the two enums `int` here (the idiom of
 * frontend/common/felist_classes.h); the SYM records only the slot counts.  Nothing here is dispatched from game code. */
#ifndef NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#define NFS4_SHARED_FE_MENU_GAME_SURFACE_H
#ifndef NFS4_FE_SURFACE_NO_TMENU_INLINES   /* every includer (game owners + MMEffect since FESCR2): the tMenu/tMenuItem inline set of FRONTORD set 23 (retail TPDEF tMenu/tMenuItem 16) */
#define NFS4_FE_SURFACE_TMENU_INLINES
#endif
#include "shared/fe_menu_game_tmenucommand.h"   /* retail: tMenuCommand (tMenu forward copy) before tListIterator; opt-out NFS4_FE_SURFACE_NO_TMENUCOMMAND */
#include "frontend/common/fe_player_types.h"
#include "frontend/common/fe_input_enums.h"   /* the real tPlayer / tInputKeyType enums (were `#define ... int`; header-truth 4-C.3) */

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




} tMenu;
struct tMenuItemInteractive : public tMenuItem {};
#ifdef NFS4_FE_SURFACE_HOOK   /* an owner's own types right after tMenuItemInteractive (nfs3.obj: tScreen) */
#include NFS4_FE_SURFACE_HOOK
#endif


#endif
