/* frontend/common/fe_core_tmenu.h -- the tMenu root class (real virtuals).  A separate piece of fe_core_types.h only so
 * that FEMenu's translation unit can declare it after tMenuItemGoToMenuButton: g++ 2.8 emits vtables in reverse
 * declaration order and FEMenu.obj has tMenu's table FIRST. */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H
#define NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H

typedef struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tItemList fItemList;
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    void (*fOnButtonPress)(tMenuCommand &);
#else
    void (*fOnButtonPress)(void *);
#endif
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
#ifndef NFS4_FE_CORE_TMENU_KEY_TU
    // Not in FEMenu.obj's surface: that TU defines tMenu's virtuals, so g++ 2.8 would
    // emit an out-of-line CurrentItem__5tMenu (absent from retail) and grow its .text.
    inline short CurrentItem() { return fCurrentItem; }
#endif
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // Inferred setter spelling: retail records child PTR tMenu in three
    // constructor inline pairs; the raw stores target fChildMenu.
    inline void SetChildMenu(tMenu *child) { fChildMenu = child; }
    // Inferred tail setter, tested against retail's receiver-free inline pairs.
    inline void SetVerticalHelp(short help) { VertHelp = help; }
#endif
#if defined(NFS4_FE_CORE_FEDIALOG_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
#ifndef NFS4_FE_CORE_FEMENU_METHODS
    short GetNumberEnabledItems();
#endif
    inline bool HasFlag(unsigned int flag) { return (fFlags & flag) != 0; }
#if defined(NFS4_FE_CORE_FEDIALOG_ITEM_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // ORIGINAL-NAME-UNRESOLVED: retail CalculateDimensions' second record-less pair in the item-loop test (45).
    inline tMenuItem *Item(int n) { return fItemList[n]; }
#endif
    inline bool CanContinue() {
        return fNextMenu != (tMenu *)0x0 ||
               (fFlags & 0x400) != 0 ||
               fOnButtonPress != 0x0;
    }
#endif
#if defined(NFS4_FE_CORE_FEAPP_METHODS) || defined(NFS4_FE_CORE_FEDIALOG_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // FEDialog: retail tDialogHelp::CalculateDimensions records this receiver-only inline pair (line 71).
    inline bool HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; }
#endif
#if defined(NFS4_FE_CORE_FEMENUOPTIONS_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // ORIGINAL-NAME-UNRESOLVED: retail tUserNameMenuItem::ProcessInput records this receiver-free menu inline pair
    // after CurrentMenu() at its 0x100 flag test (byte load lbu +1 / andi 1 = constant mask inside the inline).
    inline unsigned int ExitsWithBack() { return fFlags & 0x100; }
#endif
#if defined(NFS4_FE_CORE_FEAPP_METHODS) || defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    inline tScreen *GetScreen() { return fScreen; } // ORIGINAL-NAME-UNRESOLVED: supplied receiver/field producer; inferred accessor spelling.
    inline unsigned int GetMusic() { return fFlags & 0xf000; } /* ORIGINAL-NAME-UNRESOLVED: retail SetMenu records this menu-receiver inline pair at the music test. */ inline tMenuItem *CurrentMenuItem() { return fItemList[fCurrentItem]; } // ORIGINAL-NAME-UNRESOLVED: retail Redraw's record-less pair after CurrentMenu() (same line: later header lines unshifted).
#endif
#if defined(NFS4_FE_CORE_SCREENCARSELECT_METHODS) && !defined(NFS4_FE_CORE_FEAPP_METHODS) && !defined(NFS4_FE_CORE_TMENU_ALL_INLINES)
    // ScreenCarSelect DrawForeground: retail loads the item into a temp (s0) and copies it to currentItem
    // (s2) after GetCar -- the inline return value.  Same accessor as the FEAPP surface above.
    inline tMenuItem *CurrentMenuItem() { return fItemList[fCurrentItem]; }
#endif
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    void tMenuConstructor(tMenuItem *firstItem, void *ap); short GetNumberEnabledItems();
#endif
#if defined(NFS4_FE_CORE_FEMENU_METHODS) || defined(NFS4_FE_MENUITEM_INLINES)   /* FESCR: named by the tInsideBoxMenu inline ctor */
    tMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short);
#endif
#if defined(NFS4_FE_CORE_TMENU_ALL_INLINES) && !defined(NFS4_FE_CORE_TMENU_KEY_TU)
    /* INFERRED bodies: retail TPDEF tMenu x16 per object (2 inline bodies beyond the 12 spelled); builtin-only, never called */
    inline short TitleText() { return fTitle; } inline bool NeverAnyEnabled() { return fNeverAnyEnabled; }
#endif
} tMenu;

#endif
