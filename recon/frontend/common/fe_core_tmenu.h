/* frontend/common/fe_core_tmenu.h -- the tMenu root class (real virtuals).  A separate piece of fe_core_types.h only so
 * that FEMenu's translation unit can declare it after tMenuItemGoToMenuButton: g++ 2.8 emits vtables in reverse
 * declaration order and FEMenu.obj has tMenu's table FIRST. */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H
#define NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H

/* tMenu's key object (FEMenu) emits a standalone copy of every inline member; SLINK /strip removes them
   (linkers/link_stripped.json). Everywhere else the attribute is empty. */
#ifdef NFS4_TU_FEMENU
#define TMENU_KEY_STRIP LINK_STRIPPED
#else
#define TMENU_KEY_STRIP
#endif
typedef struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tItemList fItemList;
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
    void (*fOnButtonPress)(tMenuCommand &);   /* one type for every includer (was void* outside FEMenu) */




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
    tMenu(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short);
    void tMenuConstructor(tMenuItem *firstItem, void *ap);
    short GetNumberEnabledItems();
    /* Inline members: one set for every includer, defined right after the class. Spellings are inferred (retail
       records the bodies, not their names). */
    inline short CurrentItem() TMENU_KEY_STRIP;
    inline void SetChildMenu(tMenu *child) TMENU_KEY_STRIP;
    inline void SetVerticalHelp(short help) TMENU_KEY_STRIP;
    inline bool HasFlag(unsigned int flag) TMENU_KEY_STRIP;
    inline tMenuItem *Item(int n) TMENU_KEY_STRIP;
    inline bool CanContinue() TMENU_KEY_STRIP;
    inline bool HasOptionsMenu() TMENU_KEY_STRIP;
    inline unsigned int ExitsWithBack() TMENU_KEY_STRIP;
    inline tScreen *GetScreen() TMENU_KEY_STRIP;
    inline unsigned int GetMusic() TMENU_KEY_STRIP;
    inline tMenuItem *CurrentMenuItem() TMENU_KEY_STRIP;
} tMenu;
inline short tMenu::CurrentItem() { return fCurrentItem; }
inline void tMenu::SetChildMenu(tMenu *child) { fChildMenu = child; }
inline void tMenu::SetVerticalHelp(short help) { VertHelp = help; }
inline bool tMenu::HasFlag(unsigned int flag) { return (fFlags & flag) != 0; }
inline tMenuItem *tMenu::Item(int n) { return fItemList[n]; }
inline bool tMenu::CanContinue() { return fNextMenu != (tMenu *)0x0 || (fFlags & 0x400) != 0 || fOnButtonPress != 0x0; }
inline bool tMenu::HasOptionsMenu() { return fOptionsMenu != (tMenu *)0x0; }
inline unsigned int tMenu::ExitsWithBack() { return fFlags & 0x100; }
inline tScreen *tMenu::GetScreen() { return fScreen; }
inline unsigned int tMenu::GetMusic() { return fFlags & 0xf000; }
inline tMenuItem *tMenu::CurrentMenuItem() { return fItemList[fCurrentItem]; }
#endif
