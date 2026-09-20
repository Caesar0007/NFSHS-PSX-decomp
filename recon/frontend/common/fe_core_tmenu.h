/* frontend/common/fe_core_tmenu.h -- the tMenu root class (real virtuals).  A separate piece of fe_core_types.h only so
 * that FEMenu's translation unit can declare it after tMenuItemGoToMenuButton: g++ 2.8 emits vtables in reverse
 * declaration order and FEMenu.obj has tMenu's table FIRST. */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H
#define NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H

struct tMenu {
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
#if defined(NFS4_FE_CORE_FEMENU_METHODS) || defined(NFS4_FE_CORE_FEDIALOG_METHODS)
    virtual void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#else
    virtual void ProcessInput(int, void *, void *);   /* layout-only: this owner surface has no tInputKeyType/tMenuCommand */
#endif
    virtual long DebounceKeys();
    virtual void TransitionOff();
    virtual void TransitionOn();
    virtual bool TransitionIsFinished();
    virtual bool IsSubMenu();
    virtual void Draw();
    virtual void UpdateTransition();
#ifdef NFS4_FE_CORE_FEDIALOG_METHODS
#ifndef NFS4_FE_CORE_FEMENU_METHODS
    short GetNumberEnabledItems();
#endif
    inline bool HasFlag(unsigned int flag) { return (fFlags & flag) != 0; }
    inline bool CanContinue() {
        return fNextMenu != (tMenu *)0x0 ||
               (fFlags & 0x400) != 0 ||
               fOnButtonPress != 0x0;
    }
#endif
#ifdef NFS4_FE_CORE_FEAPP_METHODS
    inline bool HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; }
#endif
#ifdef NFS4_FE_CORE_FEMENU_METHODS
    void tMenuConstructor(tMenuItem *firstItem, void *ap);
    tMenu(unsigned int, tScreen *, tMenu *, tMenu *,
          void (*)(tMenuCommand &), short);
    short GetNumberEnabledItems();
#endif
};

#endif
