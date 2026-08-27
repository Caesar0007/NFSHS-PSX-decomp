/* Owner-specific type tail for FEScreen.obj. */
#ifndef NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H
#define NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H

struct tMenu;

#define NFS4_TMENUCOMMANDTYPE_DEFINED
enum tMenuCommandType {
    kMenu_Command_None = 0,
    kMenu_Command_GoToMenu = 1,
    kMenu_Command_GoToMenuOneWay = 2,
    kMenu_Command_GoToMenuTwoPlayer = 3,
    kMenu_Command_BackupMenu = 4,
    kMenu_Command_StartRace = 5,
    kMenu_Command_Start2PlayerRace = 6,
    kMenu_Command_ReStartRace = 7,
    kMenu_Command_StartReplay = 8,
    kMenu_Command_ClearRecords = 9
};

struct tMenuCommand {
    tMenuCommandType type;
    tMenu *nextMenu;
};

#include "fe_core_types.h"
#include "fe_input_enums.h"

typedef enum tScreen_TransitionType {
    kScreen_TransitionTypeItem = 0,
    kScreen_TransitionTypeMenu = 1,
    kScreen_TransitionTypeScreen = 2
} tScreen_TransitionType;

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

    tScreen();
    ~tScreen();
    static void DisplayLoadingText();
    static void GoNonInterlaced();
    void DrawBackgroundImage(int startShape, int numShapes,
                             tTexture_ShapeInfo *shapes, int flip_axis);
    void AsyncLoadPermanentShapeFile(char *fileName);
    void AsyncLoadSwapShapeFile(char *fileName);
    bool IsShapeFileLoaded(tShapeInformation &shapes);
    void UploadPermanentShapes(int numPermanentShapes);
    void UploadSwapShapes(int numSwapShapes);
    void GetShapeInfo(short &numPermShapes, short &numSwapShapes,
                      char **permFileName, char **swapFileName);
    void Initialize();
    void Cleanup();
    void Draw(bool drawBackground);
    void AsyncLoadShapeFile(char *name, tShapeInformation &data);
    void CancelAsyncLoad(tShapeInformation &data);
    void InitializeShapes(tShapeInformation &data, unsigned int numShapes);
    void FreeShapes(tShapeInformation &data);
    void UploadShapes(tShapeInformation &data, short x, short y,
                      short numShapes, short index);
    void PreLoad();
    void TransitionOff(tScreen_TransitionType type, tMenu *menu);
    void TransitionOn(tScreen_TransitionType type, tMenu *menu);
    void UpdateTransition();
    bool TransitionIsFinished();
    void ProcessInput(tPlayer fromPlayer, tInputKeyType &keyval,
                      tMenuCommand &command);
    void DrawForeground();
    void DrawBackground();
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

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};

struct tDialogHelp : public tDialogBase {
    short variant;
    char *text[7];
    int cont[7];
    short numItems, helpcontrollers, lefttext;
};

struct tDialogMessageStringWithTimeout : public tDialogMessageString {};
struct tDialogNoInputMessage : public tDialogMessageString {};

#endif
