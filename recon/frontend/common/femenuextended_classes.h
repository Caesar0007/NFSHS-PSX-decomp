/* frontend/common/femenuextended_classes.h -- the FEMENUEXTENDED.H menu family (tMenuItemGoToMenuNFS4Button ..
 * tMenuOptions), one definition for every includer, members declared unconditionally (header-truth 4p/4q; retail line
 * anchors from the owner).  Members are defined in femenuextended.cpp. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_CLASSES_H
#define NFS4_FRONTEND_COMMON_FEMENUEXTENDED_CLASSES_H
#ifdef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H   /* FEMenuExtended.obj (key object) emits standalone copies of the in-class ctors; the retail link removed them */
#define NFS4_FEMENUEXTENDED_STRIP LINK_STRIPPED
#else
#define NFS4_FEMENUEXTENDED_STRIP
#endif
NFS4_TD_tMenuItemGoToMenuNFS4Button struct tMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuButton {
    int fOrdinalPos;
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
    tMenuItemGoToMenuNFS4Button(unsigned int, tMenu *, void (*)(tMenuCommand &), int, int);
    ~tMenuItemGoToMenuNFS4Button();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#line 46 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
    void Draw(bool) {}   /* in-class inline: see femenuextended.cpp tail */
#line 24 "recon/frontend/common/femenuextended_classes.h"
} NFS4_TDN_tMenuItemGoToMenuNFS4Button;

struct tMenuItemNFS4LeftRightChoice : public tMenuItemLeftRightChoice {
    short fOffset, fTransitionVal, fTransitionSpeed, fEnabledTransitionVal;
    tMenuItemNFS4LeftRightChoice(unsigned int, tListIterator *, int, int);
    ~tMenuItemNFS4LeftRightChoice();
    void Draw(int, int, bool);
    void TransitionOn();
    void TransitionOff();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
};

#define NFS4_FEMENUEXTENDED_TYPE_PART 1
#include "femenuextended.h"
#undef NFS4_FEMENUEXTENDED_TYPE_PART
struct tMenuItemOptionsLeftRightChoice : public tMenuItemLeftRightChoice {
#ifdef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H   /* key object: declared for the stripped standalone copy, defined right after the class */
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d) NFS4_FEMENUEXTENDED_STRIP;
#else   /* retail in-class body */
    tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d) {}
#endif
    void Draw(int, int, bool);
#line 99 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
};
#ifdef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
inline tMenuItemOptionsLeftRightChoice::tMenuItemOptionsLeftRightChoice(unsigned int t, tListIterator *d) : tMenuItemLeftRightChoice(t, d) {}
#endif
#line 54 "recon/frontend/common/femenuextended_classes.h"

struct tMenuItemOptionsTwoItemChoice : public tMenuItemLeftRightChoice {
    short fOnOffFade;
#ifdef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
    tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d) NFS4_FEMENUEXTENDED_STRIP;
#else   /* retail in-class body */
    tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightChoice(t, d)
    { fOnOffFade = 0x80; }
#endif
    void TransitionOn();
    void Draw(int, int, bool);
#line 110 "C:/nfs4/FRONTEND/COMMON/FEMENUEXTENDED.H"
};
#ifdef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
inline tMenuItemOptionsTwoItemChoice::tMenuItemOptionsTwoItemChoice(unsigned int t, tListIterator *d) : tMenuItemLeftRightChoice(t, d) { fOnOffFade = 0x80; }
#endif
#line 72 "recon/frontend/common/femenuextended_classes.h"

struct tMenuNFS4 : public tMenu {
    bool fInItemTransition, fInMenuTransition;
    short fTransitionVal;
    signed char fTransitionDirection;
    char fLastItem, fNumItems;
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
};

NFS4_TD_tMenuNFS4TwoPlayer struct tMenuNFS4TwoPlayer : public tMenuNFS4 {
    tMenuNFS4TwoPlayer(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4TwoPlayer();
    virtual void DrawItem(int);
} NFS4_TDN_tMenuNFS4TwoPlayer;
struct tMenuNFS4Bottom : public tMenuNFS4 {
    tMenuNFS4Bottom(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tMenuNFS4Bottom();
    void Draw();
};
NFS4_TD_tMenuBlank struct tMenuBlank : public tMenuNFS4 {
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
} NFS4_TDN_tMenuBlank;

struct tMenuOptions : public tMenuNFS4 {
    u_long fMenuEnterTicks;
    short fPlayer;
    tMenuOptions(unsigned int, tScreen *, tMenu *, tMenu *, void (*)(tMenuCommand &), short, short, tMenuItem *, ...);
    ~tMenuOptions();
    void Draw();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    bool IsSubMenu();
};
#endif
