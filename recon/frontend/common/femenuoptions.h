/* Canonical FEMENUOPTIONS.H definitions proven by retail destructor records.  The part selector is reconstruction-only include scaffolding: it preserves the existing owner-specific type/declaration order while the surrounding header dependency graph is still being restored. No #line directives. Field layouts, declarations and inline bodies below are moved verbatim. */
#ifndef NFS4_FEMENUOPTIONS_TYPE_PART
#ifndef _FE_SCREENS_FEMENUOPTIONS_H_
#define _FE_SCREENS_FEMENUOPTIONS_H_
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_CARS_AFTER_MENUS   /* retail FeMenuOptions: menu family, cars, color.obj graph, dialogs, tFEApplication, tracks, TV */
#define NFS4_SCREENDISPLAY_COLOR_AFTER_MENUCARS   /* color.obj graph after the late car block (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_TV_LATE   /* track/tournament part + TV after the dialogs (screendisplay_types.h) */
#define NFS4_SCREENDISPLAY_OWNER_AFTER_ACTIVELINE "shared/tDrawShapeExtended.h"   /* retail: tDrawShapeExtended right after kernpair/tActiveLine */
#define NFS4_SCREENDISPLAY_CARBLOCK_NO_ITERS   /* list iterators right after their managers (set 18 route) */
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "screendisplay_carblock_iters.h"
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup right after tPersonalities */
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 right after COORD16 */
#define NFS4_PRIM_POLY_G4   /* retail: libgpu POLY_G4 / DR_AREA at their core place (nfs4_types.h) */
#define NFS4_PRIM_DR_AREA
#define NFS4_SCREENDISPLAY_AUDIOMUS_AFTER_VIDEO   /* retail: AudioMus song records right after tVideo */
#define NFS4_CORE_PADS_EARLY   /* retail: controller pads before linedef (nfs4_types.h) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_MENUITEMS "shared/tActiveLine.h"   /* retail: tActiveLine right after the menu items, before the core */
#define NFS4_SCREENDISPLAY_FELINES_AFTER_LEAF   /* retail: tTexture_ShapeInfo/kernpair right after Draw_CarVertex */
#define NFS4_SCREENDISPLAY_SCREEN_AFTER_TOURNAMENT   /* early tShapeInformation/fescreen sites skipped (retail: forward tScreen copy only) */
#define NFS4_COLOR_HOOK_AFTER_CAR "../../frontend/common/fe_screen_late.h"   /* retail FeMenuOptions: tShapeInformation + tScreen right after Car_tObj */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton (tpdef_keys.h is read before this guard exists) */
#include "femenuoptions_externs.h"
#endif
#else
#if NFS4_FEMENUOPTIONS_TYPE_PART == 1
#ifdef NFS4_SCREENDISPLAY_HOOK_BEFORE_OPTIONS   /* owner records between tMenuOptions and the options family (FEDialog: car graph) */
#include NFS4_SCREENDISPLAY_HOOK_BEFORE_OPTIONS
#endif
#line 13
NFS4_TD_tMenuItemLeftRightFade struct tMenuItemLeftRightFade : public tMenuItemLeftRightChoice {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    int flareextra;
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    tMenuItemLeftRightFade(unsigned int, tListIterator *);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void MyLeftRightDraw(int, int);
#endif
#line 46 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
} NFS4_TDN_tMenuItemLeftRightFade;
#line 26 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 2
#line 27
struct tMenuItemSlidingActivated : public tMenuItemSlidingMenu {
    bool fActive;
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMenuItemSlidingActivated(unsigned int a, short b, short c, short d, short e, bool f)
        : tMenuItemSlidingMenu(a, b, c, d, e, f) {
    }
    bool IsActive() { return fActive; }   /* INFERRED body: retail TPDEF tMenuItemSlidingActivated x4 (x5 FEMenuDefs) per object (FESCR); never called */
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    virtual void UpdatefOpenHeight(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
#line 193 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 43 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 3
#line 44
struct tMenuItemDisplayLeftRightChoice : public tMenuItemLeftRightFade {
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMenuItemDisplayLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void Draw(int, int, bool);
#endif
#line 206 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 53 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 4
#line 54
struct tMenuItemOnOffLeftRightChoice : public tMenuItemLeftRightFade {
    short fOnFade;
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMenuItemOnOffLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void TransitionOn();
    void Draw(int, int, bool);
#endif
#line 217 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 65 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 5
#line 66
struct tMenuItemControllerLeftRightChoice : public tMenuItemLeftRightFade {
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMenuItemControllerLeftRightChoice(unsigned int t, tListIterator *d)
        : tMenuItemLeftRightFade(t, d) {}
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void Draw(int, int, bool);
#endif
#line 290 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 75 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 6
#line 76
NFS4_TD_tUserNameMenuItem struct tUserNameMenuItem : public tMenuItem {
    char *fData;
    short fMaxStringLength, fCurrentColumn, fCurrentRow;
    char fRowList[10][9];
    short fPlayer, fFadeVal, fFadeDir;
    bool fInTransition;
#ifdef NFS4_FEAPP_USERNAME_SETUP  /* feapp RunPostGame only: retail inline pair (this $3, no param records); ORIGINAL-NAME-UNRESOLVED */
    inline void SetUpP(short player, char *data) { fPlayer = player; fData = data; fMaxStringLength = 7; fCurrentRow = 0; fCurrentColumn = 0; }
#endif
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
    /* full member declarations for every includer (Draw(bool) is pure in tMenuItem) */
    tUserNameMenuItem(unsigned int);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
    /* */
#line 375 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
} NFS4_TDN_tUserNameMenuItem;
#line 108 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 7
#line 109
struct tMenuItemGoToMenuButtonFade : public tMenuItemGoToMenuButton {
    short fFadeVal, fFadeDir;
    bool fInTransition;
    signed short fEnableVal;
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMenuItemGoToMenuButtonFade(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButton(t, m, f) {}

#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void TransitionOff();
    void TransitionOn();
    bool TransitionIsFinished();
    void UpdateTransition(bool);
#endif
#line 396 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 124 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 8
#line 125
struct tMemoryCardMenuItem : public tMenuItemGoToMenuButtonFade {
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tMemoryCardMenuItem(unsigned int t, tMenu *m, void (*f)(tMenuCommand &))
        : tMenuItemGoToMenuButtonFade(t, m, f) {
    }
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void Draw(bool);
#endif
#line 407 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 135 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 9
#line 136
struct tInsideBoxControllerLeftRightSlider : public tInsideBoxLeftRightSlider {
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tInsideBoxControllerLeftRightSlider(unsigned int t, tListIterator *d)
        : tInsideBoxLeftRightSlider(t, d) {}
#endif
#if defined(NFS4_FEMENUOPTIONS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* retail: full member declarations in every includer (FESCR) */
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
#endif
#line 428 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 145 "recon/frontend/common/femenuoptions.h"
#elif NFS4_FEMENUOPTIONS_TYPE_PART == 10
#line 146
/* Retail SLD names FEMENUOPTIONS.H for these inline bodies and implicit
 * destructor. Keep the definition in that real owner, not a type-surface
 * header. The part selector only preserves the existing declaration order. */
struct tBlankMenuItemGoToMenuNFS4Button : public tMenuItemGoToMenuNFS4Button {
#if defined(NFS4_FEMENUDEFS_SURFACE) || defined(NFS4_FE_MENUITEM_INLINES)   /* in-class ctors/bodies (called from femenudefs; names forced by the classes) */
    tBlankMenuItemGoToMenuNFS4Button(unsigned int t, tMenu *m,
                                     void (*f)(tMenuCommand &), int ff, int nf)
        : tMenuItemGoToMenuNFS4Button(t, m, f, ff, nf) {}
    /* in-class inlines are emitted in REVERSE declaration order (retail: TIF, Draw(iib), Draw(b), then the dtor) */
#line 415 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
    void Draw(bool) {}
    void Draw(int, int, bool) {}
    bool TransitionIsFinished() { return true; }
#endif
#line 418 "C:/nfs4/FRONTEND/COMMON/FEMENUOPTIONS.H"
};
#line 160 "recon/frontend/common/femenuoptions.h"
#else
#error Unknown FEMENUOPTIONS.H type part
#endif
#endif
