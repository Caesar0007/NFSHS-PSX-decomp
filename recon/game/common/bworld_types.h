#if !defined(NFS4_GAME_COMMON_BWORLD_TYPES_H)   /* first pass; bworld.obj's exact source-visible type surface reconstructed from SYM */
#define NFS4_GAME_COMMON_BWORLD_TYPES_H
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_SFX   /* retail type order (game/common/color_types.h) */
/* DrawW.obj supplies the shared graph; its owner-only records are omitted here. */
#define NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#include "../psx/draww_types.h"
#undef NFS4_DRAWW_OMIT_BWORLD_FOREIGN_TYPES
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_BWORLD_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_BWORLD_EARLY_DONE
#include "shared/BW_tContext.h"
struct BW_tContextMgr {
    int initialized, count;
    BW_tContext contexts[2];
};
typedef struct { short chunkInd; char geomRez, enableBits; } tBuildEntry;




#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_BWORLD_TAIL_DONE)   /* first pass, after draww_types.h */
#define NFS4_BWORLD_TAIL_DONE
#include "shared/Trk_SFX.h"
/* Canonical bworldSm.obj aggregate used by this translation unit. */
#include "shared/Trk_NewSlice.h"

/* Canonical camera.obj aggregate used by this translation unit. */
#include "shared/camera_info.h"





























/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















/* Canonical trackspec.obj aggregate used by this translation unit. */
#include "shared/CTrackSpec.h"











#include "shared/Draw_FlareCache.h"

#include "shared/Draw_tGiveShelbyMoreCache.h"






















typedef int CarLogic_tObservations[1][3];
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2
#define RaceType_Id5 5
#endif
