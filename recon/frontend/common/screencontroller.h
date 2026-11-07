#ifndef _FE_SCREENS_SCREENCONTROLLER_H_
#define _FE_SCREENS_SCREENCONTROLLER_H_   /* Canonical SCREENCONTROLLER.H type surface recovered from retail SYM. Actual definitions live here; foreign codegen views below remain unsealed. No compiler source-location directives or new declarations are introduced. */
#ifndef _FE_SCREENS_FEMENUOPTIONS_H_   /* ScreenController.obj only (FeMenuOptions reuses this graph) */
#define NFS4_SCREENDISPLAY_DIALOGS_EARLY   /* retail: dialogs before the car/track graph (screendisplay_types.h) */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS   /* color.obj graph after the dialogs, before the car/track graph */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* draw_leaf phase 1 only; screendisplay_types.h emits PCOORD16 .. Draw_* after tScreen */
#endif

#include "fe_player_types.h"   /* ScreenController retains tInputKeyType but not the foreign tPlayer enum. FeMenuOptions reuses this graph and retains both input enums. (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root's parameter types */
#define uchar unsigned char
struct tMenuCommand;
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

/* ScreenMemcard supplies the exact shared frontend graph.  Exclude its
 * memory-card, saved-game, and song records while retaining FE3d. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_CONTROLLER_SURFACE
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#define NFS4_SCREENDISPLAY_CONTROLLER_METHODS
#include "screenmemcard_types.h"
#undef NFS4_SCREENDISPLAY_CONTROLLER_METHODS
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_SCREENMEMCARD_CONTROLLER_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE

typedef short tArrowLocation[6];
typedef short tTextLocation[5];

#include "shared/FLARE_PIECE_DEF.h"
#include "shared/Force_tGlobal.h"

struct tScreenControllerConfig : public tScreen {
    /* overrides (retail vtable), declared on every owner surface */
    void GetShapeInfo(short &, short &, char **, char **);
    void DrawBackground();
    void DrawForeground();
    void Initialize();
    void Cleanup();
    Force_tGlobal fShaker;
    char fPrevConfig, fTextConfig, fTextController, fPrevController;
    short fFade[2], fFadeController[2];
    int fStartTick;
    short fGotTick, fAnim, fAnimFrame, fAnimStart, fAnimStop, fAnimStep;
    short fAnimController, fSwap, fAnimFade, fAnimFadeStart, fAnimFadeStop;
    short fAnimFadeFrame, fAnimFadeController, CurrentlyLoadedArt, negconChoice;
    bool fTransitionedIn, fTransitioningIn, fTransitioningOut;
    short fArrowFade, fArrowFadeDir, fTextTypeOn;
    bool fFadeTextOut;
    short mult;
    tDialogYesNo negconPopUp;
    int fTimeOutStartTick;
    bool SuperFastFadeOut, fPlayedInSound;
    short fShakingItem;
    bool fResetShakeTimeOut;
    char fCurrentController;
    int player;

#ifdef NFS4_SCREENCONTROLLER_RESETSHAKE_INLINE
    inline void ResetShakeTimeOut() { fResetShakeTimeOut = 1; }
#endif
    void ClearActuators();
    void SetActuators(int);
    void TurnOffShakers();
    void ShakeIt();
    short AnimKeyPoints(bool, bool);
    void CheckConfigs();
    void SwapInController();
    void SetCurrentController(bool);
    int CalcAnimFrame(int);
    void ActualDrawController(int, int, int, int, int);
    void DrawController();
    void HorzVertLine(short *, bool);
    void DrawArrow(short *);
    int GetHelpText();
    tScreenControllerConfig();
#line 177 "C:/nfs4/FRONTEND/COMMON/SCREENCONTROLLER.H"
};
#line 80 "recon/frontend/common/screencontroller.h"

/* Remaining foreign singleton views need owning-SYM source restoration. */
struct ScreenController_FEApplicationCodegenView {
    char _beforeInputPlayer[557];
    char fInputPlayer;
};
#define tFEApplication ScreenController_FEApplicationCodegenView

struct ScreenController_GlobalMenuDefsCodegenView {
    char _beforeItemControllerSettings[0x2b28];
    tMenuItemSlidingMenu itemControllerSettings;
    tOptionsMenu menuControllerConfig;
    char _beforeItemControllerSteeringRange1[0x2c78 - 0x2bec];
    tInsideBoxTwoWaySlider itemControllerSteeringRange1;
    char _beforeItemControllerDeadSpot1[0x2cbc - 0x2ca8];
    tInsideBoxTwoWaySlider itemControllerDeadSpot1;
    char _beforeItemControllerSteeringRange2[0x2d00 - 0x2cec];
    tInsideBoxTwoWaySlider itemControllerSteeringRange2;
    char _beforeItemControllerDeadSpot2[0x2d44 - 0x2d30];
    tInsideBoxTwoWaySlider itemControllerDeadSpot2;
    char _beforeItemControllerJoyRange[0x2d88 - 0x2d74];
    tInsideBoxTwoWaySlider itemControllerJoyRange;
    char _beforeItemControllerCenterPoint[0x2dcc - 0x2db8];
    tInsideBoxTwoWaySlider itemControllerCenterPoint;
    char _beforeControllerMenus[0x2e84 - 0x2dfc];
    tInsideBoxMenu menuControllerDualShock;
    tInsideBoxMenu menuControllerAnalog;
    tInsideBoxMenu menuControllerDualShockAnalog;
    tInsideBoxMenu menuControllerNegcon;
};
#define tGlobalMenuDefs ScreenController_GlobalMenuDefsCodegenView

#endif
