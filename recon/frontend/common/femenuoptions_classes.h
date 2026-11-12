/* frontend/common/femenuoptions_classes.h -- the FEMENUOPTIONS.H menu family (tMenuItemLeftRightFade .. tInsideBoxControllerLeftRightSlider),
 * one definition for every includer, members declared unconditionally in the order that matches (header-truth 4r; moved
 * from screendisplay_types.h; ten of the classes live in femenuoptions.h parts).  Members are defined in femenuoptions.cpp. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUOPTIONS_CLASSES_H
#define NFS4_FRONTEND_COMMON_FEMENUOPTIONS_CLASSES_H
#define NFS4_FEMENUOPTIONS_TYPE_PART 1
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
NFS4_TD_tOptionsMenu struct tOptionsMenu : public tMenu {
    bool fInMenuTransition;
    signed char fTransitionDirection;
    short fPrevItem;
    int fScreenFade, fFirstFrame, fNumFrames;
    /* W86-S4 SYM: tScreenUserName::DrawBackground's `8c` block carries a NESTED block whose only record is `REG this $2 v0 PTR STRUCT tag
       tOptionsMenu`, emitted at the function's first statement -- an INLINED tOptionsMenu accessor reading fScreenFade there (the SYM records the inlined `this`, not the method's name). */
#ifdef NFS4_FEMENUOPTIONS_OWNER   /* FeMenuOptions.obj emits standalone copies of these inline members; SLINK /strip removed them (P6 Route C 2026-11-07) */
#define NFS4_SCREENDISPLAY_STRIP LINK_STRIPPED
#else
#define NFS4_SCREENDISPLAY_STRIP
#endif
    int GetScreenFade() NFS4_SCREENDISPLAY_STRIP;
    tOptionsMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                 void (*)(tMenuCommand &), short, int, int,
                 tMenuItem *, ...);
    ~tOptionsMenu(); long DebounceKeys(); void TransitionOff(); void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(); void Draw(); void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);

} NFS4_TDN_tOptionsMenu;
inline int tOptionsMenu::GetScreenFade() { return fScreenFade; }
struct tInsideBoxMenu : public tMenu {
    short fPrevItem, fMoving, fMovingDir;
    tInsideBoxMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                   void (*)(tMenuCommand &), short, tMenuItem *, ...);
    /* non-variadic form for derived classes (tInsideBoxSongMenu): retail's SongMenu ctor calls the tMenu ctor directly and stores only its own table, i.e. this one is inline */
    /* Retail SongMenu's expanded constructor records these exact parameter names at depth1 in registers8/9; they are not caller locals o/fn.
       The other spellings follow the recorded variadic overload's argument roles; their literal inline spellings are absent from optimized SYM. */
    tInsideBoxMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu,
                   void (*OnButtonPress)(tMenuCommand &), short title) NFS4_SCREENDISPLAY_STRIP;   /* defined right after the class */
    ~tInsideBoxMenu();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    virtual void Draw(short, short, short, short, short);
};
inline tInsideBoxMenu::tInsideBoxMenu(unsigned int flags, tScreen *screenHandler, tMenu *nextMenu, tMenu *optionsMenu,
                                      void (*OnButtonPress)(tMenuCommand &), short title)
    : tMenu(flags, screenHandler, nextMenu, optionsMenu, OnButtonPress, title) {}
struct tMenuItemSlidingMenu : public tMenuItem {
    tInsideBoxMenu *currMenu, *nextMenu;
    short fWidth, fHeight, fOpenHeight, fSlideOffset, fFadeVal, fFadeDir;
    bool fInTransition, fTransitioningOut, fClosing;
    short fDiffX, fDiffY;
    bool fFillback; void SetMenu(bool, tInsideBoxMenu *);
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
    tMenuItemLeftRightAudioSlider(unsigned int, tListIterator *, int);
    ~tMenuItemLeftRightAudioSlider();
    void Draw(int, int, bool);
    int Percentage();
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
};

struct tInsideBoxSongMenu : public tInsideBoxMenu {
    short fOnOffFade[5], fSelFade[5];
    tInsideBoxSongMenu(unsigned int, tScreen *, tMenu *, tMenu *,
                       void (*)(tMenuCommand &), short, tMenuItem *, ...);
    ~tInsideBoxSongMenu();
    virtual void Draw(short, short, short, short, short);
    virtual void DrawOneSong(short, short, short, short, short, short);
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

#define NFS4_FEMENUOPTIONS_TYPE_PART 5
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
struct tInsideBoxLeftRightSlider : public tMenuItemLeftRightSlider {
    tInsideBoxLeftRightSlider(unsigned int, tListIterator *);
    ~tInsideBoxLeftRightSlider();
    void Draw(int, int, int, bool);
};

struct tInsideBoxTwoWaySlider : public tMenuItemLeftRightSlider {
    short fType;
    bool fActive;
    tInsideBoxTwoWaySlider(unsigned int, tListIterator *, int);
    ~tInsideBoxTwoWaySlider();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(int, int, int, bool);
    void Calibrate();
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
#define NFS4_FEMENUOPTIONS_TYPE_PART 10
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
#define NFS4_FEMENUOPTIONS_TYPE_PART 9
#include "femenuoptions.h"
#undef NFS4_FEMENUOPTIONS_TYPE_PART
#endif
