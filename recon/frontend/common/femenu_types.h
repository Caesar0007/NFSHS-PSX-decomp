/* Owner-specific type surface for FEMenu.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENU_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENU_TYPES_H

#include "../../game/common/color_types.h"
#include "fe_input_enums.h"

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

#define NFS4_FE_CORE_FEMENU_METHODS
#include "fe_core_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
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

struct tListIteratorIndexed : public tListIterator {
    char *fIndex;
    tListIteratorIndexed() {}
    tListIteratorIndexed(short *, char *, char *);
    ~tListIteratorIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorDoubleIndexed : public tListIterator {
    char *fIndex1;
    int index1multiplier;
    char *fIndex2;
    ~tListIteratorDoubleIndexed();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorMultiPlayer : public tListIterator {
    ~tListIteratorMultiPlayer();
    char Value(tPlayer);
    short TextValue(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tListIteratorRangeIndexed : public tListIteratorRange {
    char *fIndex;
    tListIteratorRangeIndexed() {}
    tListIteratorRangeIndexed(char, char, char *, char *);
    ~tListIteratorRangeIndexed();
    char Value(tPlayer);
    void Increment(tPlayer);
    void Decrement(tPlayer);
};

struct tMenuItemLeftRightChoice : public tMenuItemInteractive {
    tListIterator *fData;
    tMenuItemLeftRightChoice() {}
    tMenuItemLeftRightChoice(unsigned int, tListIterator *);
    ~tMenuItemLeftRightChoice();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
};

struct tMenuItemLeftRightSlider : public tMenuItemInteractive {
    tListIterator *fData;
    short fX, fY, fWidth, fHeight;
    tMenuItemLeftRightSlider() {}
    tMenuItemLeftRightSlider(unsigned int, tListIterator *);
    ~tMenuItemLeftRightSlider();
    long DebounceKeys();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
    void Draw(bool);
    void SetDimensions(short, short, short, short);
};

struct tMenuItemGoToMenuButton : public tMenuItemInteractive {
    void (*fOnButtonPress)(tMenuCommand &);
    tMenuItemGoToMenuButton() {}
    tMenuItemGoToMenuButton(unsigned int, tMenu *,
                            void (*)(tMenuCommand &));
    ~tMenuItemGoToMenuButton();
    void ProcessInput(tPlayer, tInputKeyType &, tMenuCommand &);
};

struct tFEApplication;

/* FEMenu uses these enum values only as cross-TU arguments.  Its linked SYM
 * does not retain either foreign enum tag, so source-spelling macros plus the
 * exact linkage alias in femenu_externs.h preserve the call ABI without
 * inventing local type records. */
#define tMenuTextState int
#define tMenuTextType int
#define textType_Options 6

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

/* Canonical PsyQ 4.3 LIBGPU primitive tag and macro expansion. */
typedef struct {
    unsigned addr : 24;
    unsigned len : 8;
    u_char r0, g0, b0, code;
} P_TAG;
#define getaddr(p) ((u_long)(((P_TAG *)(p))->addr))
#define setaddr(p, value) (((P_TAG *)(p))->addr = (u_long)(value))
#define addPrim(ot, p) setaddr((p), getaddr(ot)), setaddr((ot), (p))

#endif
