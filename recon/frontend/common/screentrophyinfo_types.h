#ifndef NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENTROPHYINFO_TYPES_H   /* Owner-specific type surface for ScreenTrophyInfo.obj. */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType after tOwnedCarInfo (INV-B fe_core_cars hook) */
#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: the full tMenu inline-member set (TPDEF tMenu x16 in every frontend object) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup after tPersonalities (INV-B fe_core_cars hook) */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_FE_LIST_NO_RANGE_INDEXED   /* retail ScreenTrophyInfo object: tListIterator, Indexed, Range */
#define NFS4_FE_CORE_FELINES_LATE   /* retail: menu core (tMenuCommandType..tScreen) BEFORE the MATRIX core */
#define NFS4_FE_CORE_CARS_LATE    /* cars after the screen records, then tracks, then color */
#define NFS4_FE_TRACK_NO_PLAYER
#define NFS4_CORE_CCOORD16   /* retail: CCOORD16 right after COORD16 */
#define NFS4_FELINES_KERNPAIR_LATE   /* retail: kernpair right after tScreenTrophyInfo */
#define NFS4_FE_CORE_TMENUCOMMAND_EARLY   /* retail: tMenu forward copy right after tMenuCommandType (fe_core_types.h) */
#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* retail: tMenu (+ tScreen forward copy) after tMenuItemGoToMenuButton */
#include "fe_core_types.h"
#include "screendisplay_menuitems.h"   /* the shared FEMENU.H menu-item classes (+ tMenu after them when keyed); no private copies (header-truth 4b) */









#include "felines_types.h"
#include "shared/tActiveLine.h"
#include "shared/tShapeInformation.h"
struct tMenu;
#include "fescreen.h"
#include "screentrophyinfo.h"
#include "felines_kern.h"
#include "shared/tDrawShapeExtended.h"
#include "fe_core_cars.h"
/* ScreenTrophyInfo retains the tournament/track layouts, but not the foreign tPlayer method surface carried by FETracks. */
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
/* Source spellings/constants that do not create records in this owner. */
#define byte unsigned char
#define uint unsigned int

#include "shared/tMenuTextType.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "shared/tMenuTextState.h"   /* the real enum (was constant macros; header-truth 4-C.2) */
#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */


















#ifndef NFS4_FE_COLOR_LATE   /* The retail owner contains color.obj's complete 71-record graph (after the tracks). */
#include "../../game/common/color_types.h"
#endif
/* These menu records are retained by the original screen header even though this implementation does not instantiate them directly. */
#include "femenuextended_classes.h"   /* the FEMENUEXTENDED.H menu family: no private copies (header-truth 4p) */














/* ScreenTrophyRoom is only an external pointer here; the two fields this owner reads are `tier` and `fRealCurrentTourn`,
 * at the offsets the retail SYM records for the class (size 344). */
#include "screentrophyroom.h"
#endif
