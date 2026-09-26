/* mmeffect.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H
#define NFS4_FRONTEND_PSX_MMEFFECT_TYPES_H

#include "../../game/common/color_types.h"

/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

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

#include "shared/kernpair.h"





#include "shared/tTexture_ShapeInfo.h"










struct tMenu;
struct tScreen;
struct tMenuCommand;

#include "shared/fe_menu_game_surface.h"

#include "shared/tShapeInformation.h"








struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
/* retail slot list (10 slots); MMEFFECT.obj defines neither tPlayer nor tInputKeyType */
#define tPlayer int
#define tInputKeyType int
#include "../common/fescreen_virtuals.inc"
#undef tPlayer
#undef tInputKeyType
};

#include "shared/tActiveLine.h"





typedef kernpair KERN;
typedef int (*getcode)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
