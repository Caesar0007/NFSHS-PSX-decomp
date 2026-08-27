/* Owner-specific type surface for ScreenController.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENCONTROLLER_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENCONTROLLER_TYPES_H

/* The retail owner retains tInputKeyType but not the foreign tPlayer enum. */
#define tPlayer int
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

struct FLARE_PIECE_DEF {
    int distance, size;
    CVECTOR color;
    char type;
};

struct Force_tGlobal {
    u_char active, high, low, jolt, time, fade;
    u_char actuator[2];
};

struct tScreenControllerConfig : public tScreen {
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
    void DrawBackground();
    void DrawForeground();
    void GetShapeInfo(short &, short &, char **, char **);
    void Initialize();
    void Cleanup();
    int GetHelpText();
    tScreenControllerConfig();
    ~tScreenControllerConfig() {}
};

/* These external singleton tags are absent from ScreenController.obj. */
struct ScreenController_FEApplicationCodegenView {
    char _beforeInputPlayer[557];
    char fInputPlayer;
};
#define tFEApplication ScreenController_FEApplicationCodegenView

struct ScreenController_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    char stateBytes[16];
};
#define tPadModuleState ScreenController_PadCodegenView

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
