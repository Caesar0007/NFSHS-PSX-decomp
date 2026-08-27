/* Owner-specific type surface for FEDialog.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H
#define NFS4_FRONTEND_COMMON_FEDIALOG_TYPES_H

#include "fe_input_enums.h"

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

struct tMenu;
struct tMenuCommand {
    tMenuCommandType type;
    tMenu *nextMenu;
};

#define NFS4_FE_CORE_FEDIALOG_METHODS
#define NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#define NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_FEDIALOG_SURFACE
#undef NFS4_SCREENDISPLAY_FEDIALOG_METHODS
#undef NFS4_FE_CORE_FEDIALOG_METHODS

struct helpKeyData {
    short text, button;
};

struct tHelpData {
    char autoGenerate;
    helpKeyData items[4];
};

struct tDialogBackUpOnly : public tDialogMessageString {
    tDialogBackUpOnly(int);
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

struct tDialogYesNoMem : public tDialogYesNo {
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

extern __vtbl_ptr_type tDialogYesNoTri_vtable[];
struct tDialogYesNoTri : public tDialogYesNo {
    inline tDialogYesNoTri() {
        _vf = (__typeof__(_vf))&tDialogYesNoTri_vtable;
    }
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

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

    inline tMenu *CurrentMenu(tPlayer player) { return fCurrentMenu[player]; }
    void Redraw();
};

/* pad.obj's completed aggregate tag is absent from FEDialog.obj. */
struct FEDialog_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    char stateBytes[16];
};
#define tPadModuleState FEDialog_PadCodegenView

struct tGlobalMenuDefs;
struct tDrawShapeExtended;
struct charactertbl;

/* FEDialog uses these enum values as literals, but its retail owner emits no
 * completed tMenuTextType/tMenuTextState records. */
#define textType_PopUpText 8
#define textType_PopUpTitle 9
#define textState_Selected 1

#endif
