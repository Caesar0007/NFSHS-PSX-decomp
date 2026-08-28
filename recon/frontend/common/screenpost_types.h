/* Owner-specific type surface for ScreenPost.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENPOST_TYPES_H

/* ScreenPost's SYM records the command before completing tMenu. */
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

#define NFS4_EA_PSX_INCOMPLETE_PHYSADR
#define NFS4_SCREENMEMCARD_SCREENPOST_SURFACE
#define NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#include "screentournselect_types.h"
#undef NFS4_SCREENTOURNSELECT_SCREENPOST_SURFACE
#undef NFS4_SCREENMEMCARD_SCREENPOST_SURFACE
#undef NFS4_EA_PSX_INCOMPLETE_PHYSADR

/* The linked SYM keeps the public array typedef but attributes the completed
 * element body elsewhere.  CC1PL requires the exact 20-byte body to form it. */
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];

#endif
