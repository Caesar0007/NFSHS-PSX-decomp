/* mmeffect.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H
#define NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H

#include "../../game/common/color_types.h"

/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

typedef struct __nfs4_vtbl_ptr_t {
    short delta;
    short index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

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

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};

struct tTexture_ShapeInfo {
    shapetbl *shpptr;
    long clutID;
    char depth;
    u_long type : 8;
    long next : 24;
    signed short width, height;
    short centerx, centery, shapex, shapey;
    u_short tpage, clut;
};

struct tListIterator {
    short *fSelectionList;
    char *fValue;
    char fMinValue, fMaxValue;
    __vtbl_ptr_type (*_vf)[6];
};

struct tListIteratorRange : public tListIterator {};

struct tMenu;
struct tScreen;
struct tMenuCommand;

struct tMenuItem {
    unsigned int fFlags, fTextDescription;
    short fSelFade;
    int fButtonImage, fNumFrames;
    tMenu *fNewMenu;
    __vtbl_ptr_type (*_vf)[11];
};

typedef tMenuItem *tItemList[16];

struct tMenu {
    unsigned int fFlags;
    short fTitle;
    int fCurrentItem;
    bool fNeverAnyEnabled;
    tItemList fItemList;
    tScreen *fScreen;
    tMenu *fNextMenu, *fChildMenu, *fOptionsMenu;
    void (*fOnButtonPress)(tMenuCommand &);
    short VertHelp;
    __vtbl_ptr_type (*_vf)[11];
};

struct tMenuItemInteractive : public tMenuItem {};

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

typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
