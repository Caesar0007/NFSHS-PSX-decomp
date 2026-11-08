#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* Owner-specific type tail for FEScreen.obj. */
#ifndef NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H
#define NFS4_FRONTEND_COMMON_FESCREEN_TYPES_H
#define NFS4_FE_LIST_NO_INDEXED   /* retail FEScreen object: tListIterator + Range only */

struct tMenu;

#include "fe_input_enums.h"   /* retail: tPlayer, tInputKeyType first */
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
#define NFS4_FE_CORE_FELINES_LATE   /* retail FEScreen: frontend core before the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE   /* retail: car tail after the dialogs */
#include "fe_core_types.h"
#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "shared/tDrawShapeExtended.h"
#include "fedialog.h"
#include "fe_core_cars.h"

#endif
