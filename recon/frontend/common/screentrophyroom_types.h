/* Owner-specific type surface for ScreenTrophyRoom.obj. */
#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYROOM_TYPES_H
#define NFS4_CORE_CCOORD16   /* retail: MATRIX core first, then input enums, tMenuCommand*, the FE menu core */
#define NFS4_DRAW_LEAF_CORE_ONLY
#include "../../game/common/draw_leaf_types.h"
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
#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_FELINES_LATE
#define NFS4_FE_CORE_CARS_LATE
#include "fe_core_types.h"
#undef NFS4_DRAW_LEAF_CORE_ONLY
#include "../../game/common/draw_leaf_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#define NFS4_FE_COLOR_LATE
#define NFS4_SCREENDISPLAY_COLOR_BEFORE_CARS
#define tTrophySize int
#define ts_Small 0
#define ts_Medium 1
#define tMenuTextState int
#define textState_Hilighted 2
#define tMenuTextType int
#define textType_ScreenInfo 4

#include "fescreen.h"
#include "screentrophyroom.h"
#include "shared/tDrawShapeExtended.h"
/* Reuse the exact shared graph while excluding memory-card, saved-game,
 * FE3d, and dialog-only records.  AudioMus_tSongEntry remains present. */
#define NFS4_SCREENMEMCARD_FEAPP_SURFACE
#define NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#include "screenmemcard_types.h"
#undef NFS4_SCREENMEMCARD_TROPHYROOM_SURFACE
#undef NFS4_SCREENMEMCARD_FEAPP_SURFACE
/* Foreign enum tags absent from this owner remain source constants. */
/* Remaining foreign menu view needs owning-SYM source restoration. */
struct tGlobalMenuDefs;   /* incomplete here: owner object records it; members reached by offset */
#endif