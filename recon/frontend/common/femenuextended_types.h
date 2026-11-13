/* Owner-specific type surface for FEMenuExtended.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMENUEXTENDED_TYPES_H
#define NFS4_TU_FEMENUEXTENDED   /* owner identity (shared/tpdef_keys.h) */
#define NFS4_FE_CORE_FELINES_LATE   /* retail FEMenuExtended: frontend core before the MATRIX core */
#include "fe_player_types.h"
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
#include "shared/tMenuCommand.h"
#define NFS4_FE_CORE_CARS_LATE   /* retail FEMenuExtended: car tail after the color graph + tMenuNFS4 family */
#define NFS4_FE_CORE_FEMENU_METHODS
#define NFS4_FE_LIST_NO_INDEXED   /* FEMenuExtended.obj: tListIterator + Range only */
#define NFS4_FE_CORE_MENUITEM_ISENABLED   /* tMenuItem::IsEnabled() -- retail's tMenuItem `this` pair in the Draw bodies */
#include "fe_core_types.h"
#undef NFS4_FE_CORE_FEMENU_METHODS
#include "../../link_stripped.h"   /* LINK_STRIPPED ctor copies below (FESCR2).  color_types.h (retail: the complete physics/AI/car graph) is included after the tMenuNFS4 family below. */
#define NFS4_PRIM_DR_AREA   /* retail: DR_AREA right after DR_MODE (nfs4_types.h NFS4_PRIM_*) */
#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes; no private copies (header-truth 4e) */
















#include "shared/tActiveLine.h"   /* retail FEMenuExtended: tActiveLine right after the item classes (FRONTORD3) */

#include "felines_types.h"
#include "../../game/psx/psyq_prim_macros.h"
#include "shared/DR_AREA.h"

#include "shared/tDrawShapeExtended.h"

#include "femenuextended_classes.h"   /* the FEMENUEXTENDED.H menu family (one definition) */













































































































#ifndef NFS4_FE_COLOR_LATE   /* retail FEMenuExtended: color.obj graph after tMenuOptions */
#include "../../game/common/color_types.h"
#endif
#include "fe_core_cars.h"
#include "shared/tShapeInformation.h"
#include "fescreen_virtual_types.h"
#include "fescreen.h"
#include "shared/tActiveLine.h"
#include "fedialog.h"
#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */






















/* The linked owner retains this public array typedef while attributing the
 * already-seen element tag body elsewhere. */
#include "shared/tRecordBuffer.h"


typedef tRecordBuffer tSaveRecords[187];

/* These foreign enum tags are not retained by FEMenuExtended.obj.  Exact
 * linkage aliases in the extern header preserve their ABI spellings. */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */
#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */







#define MIN(a,b) (((a) > (b)) ? (b) : (a))
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct tGlobalMenuDefs;
struct charactertbl;

#endif
