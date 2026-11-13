#define NFS4_FE_CORE_TMENU_ALL_INLINES   /* retail: full tMenu/tMenuItem inline-member sets */
#ifndef NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H
#define NFS4_FRONTEND_COMMON_SCREENAUDIO_TYPES_H   /* Owner-specific type surface for ScreenAudio.obj. */
#define NFS4_FE_COLOR_LATE   /* retail type order: frontend graph before color.obj's graph */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail core place (color_types.h does the same) */
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup before tfrontEnd */
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo (fe_core_cars.h) */
#define NFS4_DRAW_LEAF_CORE_ONLY   /* retail ScreenAudio: frontend menu core before PCOORD16/pads/Draw_* */
#include "../../game/common/draw_leaf_types.h"
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */

/* ScreenAudio retains the deep car/physics graph plus the common frontend graph used by ScreenTrackInfo, */
#ifndef NFS4_FE_COLOR_LATE   /* but none of that owner's input/screen/video records. */
#include "../../game/common/color_types.h"
#endif
#define NFS4_SCREENTRACKINFO_AUDIO_SURFACE
#include "screentrackinfo_types.h"
#undef NFS4_SCREENTRACKINFO_AUDIO_SURFACE

/* These source spellings are not completed enum tags in ScreenAudio.obj. */
#include "shared/tMenuTextState.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */



#include "shared/tMenuTextType.h"   /* the real enum (was a macro fake; header-truth 4-C.1) */

/* Retail tMenuTextType enumerator; retain the owner surface's existing form. */


#include "shared/AudioMus_tSongEntry.h"
#include "shared/AudioMus_tSongList.h"

struct tDrawShapeExtended;

#include "screenaudio.h"

#include "../../game/common/color_types.h"   /* NFS4_FE_COLOR_LATE: color.obj graph after the frontend graph */
#include "shared/SNDSYSCAP.h"
#include "shared/SNDSYSSET.h"
#include "shared/SNDSYSVEC.h"
#include "shared/SNDSYSOPTS.h"
#include "shared/SNDSAMPLEFORMAT.h"
#include "shared/SndBnk_t.h"
#include "shared/SPEECHINFO.h"

/* FEMenuDefs.obj owns the complete aggregate.  ScreenAudio reads this exact
 * contiguous member slice only. */
#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no codegen view; header-truth 4-B.2) */













#endif
