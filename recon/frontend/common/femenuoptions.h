/* Canonical FEMENUOPTIONS.H definitions proven by retail destructor records.
 * The part selector is reconstruction-only include scaffolding: it preserves
 * the existing owner-specific type/declaration order while the surrounding
 * header dependency graph is still being restored. No #line directives.
 * Field layouts, declarations and inline bodies below are moved verbatim. */
#ifndef NFS4_FEMENUOPTIONS_TYPE_PART
#ifndef _FE_SCREENS_FEMENUOPTIONS_H_
#define _FE_SCREENS_FEMENUOPTIONS_H_
#include "femenuoptions_externs.h"
#endif
#else
#if NFS4_FEMENUOPTIONS_TYPE_PART == 1
struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    int flareextra;
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 2
struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemSlidingActivated(unsigned int a, short b, short c, short d, short e, bool f)
        : tMenuItemSlidingMenu(a, b, c, d, e, f) {
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    virtual void UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 3
struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemDisplayLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(int, int, bool);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 4
struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemOnOffLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void TransitionOn();
    void Draw(int, int, bool);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 5
struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMenuItemControllerLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(int, int, bool);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 6
struct tUserNameMenuItem : public tMenuItem {
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    bool fInTransition;
#ifdef NFS4_FEMENUDEFS_SURFACE
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
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 7
struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    signed short fEnableVal;
#ifdef NFS4_FEMENUDEFS_SURFACE
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
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 8
struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tMemoryCardMenuItem(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButtonFade(t, m, f) {
    }
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void Draw(bool);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 9
struct tInsideBoxControllerLeftRightSlider : public tInsideBoxLeftRightSlider {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tInsideBoxControllerLeftRightSlider(unsigned int t, tListIterator *d)
        : tInsideBoxLeftRightSlider(t, d) {}
#endif
#ifdef NFS4_FEMENUOPTIONS_SURFACE
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
};
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 10
/* Retail SLD names FEMENUOPTIONS.H for these inline bodies and implicit
 * destructor. Keep the definition in that real owner, not a type-surface
 * header. The part selector only preserves the existing declaration order. */
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
#ifdef NFS4_FEMENUDEFS_SURFACE
    tBlankMenuItemGoToMenuNFS4Button(unsigned int t, tMenu *m,
                                     void (*f)(tMenuCommand &), int ff, int nf)
        : tMenuItemGoToMenuNFS4Button(t, m, f, ff, nf) {}
    /* in-class inlines are emitted in REVERSE declaration order (retail: TIF, Draw(iib), Draw(b), then the dtor) */
    void Draw(bool) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
};
#else
#error Unknown FEMENUOPTIONS.H type part
#endif
#endif
