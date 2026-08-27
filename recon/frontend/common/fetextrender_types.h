/* Owner-specific type surface for FETextRender.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETEXTRENDER_TYPES_H
#define NFS4_FRONTEND_COMMON_FETEXTRENDER_TYPES_H

#include "../../game/common/color_types.h"

#define NFS4_FE_CORE_NO_CAR_TYPES
#include "fe_core_types.h"
#undef NFS4_FE_CORE_NO_CAR_TYPES

#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

enum tMenuTextType {
    textType_Title = 0,
    textType_FlybyHelp = 1,
    textType_BorderInfo = 2,
    textType_FramedInfo = 3,
    textType_ScreenInfo = 4,
    textType_ScreenInfoHeader = 5,
    textType_Options = 6,
    textType_FramedMoney = 7,
    textType_PopUpText = 8,
    textType_PopUpTitle = 9,
    textType_PostGame = 10,
    textType_TrackRecords = 11,
    textType_UserNameMenu = 12,
    textType_VideoWall = 13,
    textType_NumTypes = 14,
    textType_Default = 14
};

enum tMenuTextState {
    textState_Unselected = 0,
    textState_Selected = 1,
    textState_Hilighted = 2,
    textState_NumStates = 3
};

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    bool fLoadCancelled;
};

struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    __vtbl_ptr_type (*_vf)[10];
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

struct tDialogBase : public tScreen {
    short specificPlayer, left, top, width, height, reservedheight;
    bool currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    bool fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
};

struct tDialogMessageString : public tDialogBase {
    char *string;
    bool Centerit;
};

struct tDialogInteractive : public tDialogMessageString {
    bool ReadyToReturnValue, fCurrentlyRunning;
};

struct tDialogYesNo : public tDialogInteractive {
    int yesnowords[2];
};

struct tDialogHelp : public tDialogBase {
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {};
struct tDialogNoInputMessage : public tDialogMessageString {};

struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];
};

#endif
