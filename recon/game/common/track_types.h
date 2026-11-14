/* Track.obj source-visible types; full supplied type-copy/order audit remains open. */
#if !defined(NFS4_GAME_COMMON_TRACK_TYPES_H) && !defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_CHUNK_IN_HOOK)
#define NFS4_GAME_COMMON_TRACK_TYPES_H
#define NFS4_GROUP_KERNEL_LATE
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#define NFS4_PADS_IN_HOOK
#include "track_types.h"   /* this header again: its NFS4_PADS_IN_HOOK branch */
#undef NFS4_PADS_IN_HOOK
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "chunk_types.h"
#undef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES








#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"











#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/BW_tContext.h"





/* Sched_tFunctionPt/Sched_tFunctionSchedule/Sched_tSchedule: declared by chunk_types.h after GameSetup (retail order) */
#include "shared/Sched_tFunctionSchedule.h"




#include "shared/Sched_tSchedule.h"




struct Track_MipMap {
    u_short code[2];
    int shapeParentIndex, mipMapIndex;
};
struct Track_MultiPalette {
    u_char charcode[2];
    short palnum, origshapeindex, actualshapeindex;
};
struct Track_tMaterialController {
    short type;
    u_char textureMax;
    char pad;
    u_char uv0, uv1, uv2, uv3;
    char textureCount;
    u_char interval;
    short pmxIndex;
    Track_tMaterial *matPtr;
};

/* Canonical trackspec.obj aggregate used by this translation unit. */
#include "shared/CTrackSpec.h"










/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail track.obj (GameSetup_gData is read through its word view) */















#include "shared/Sim_tSimGlobalVar.h"




#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_TRACK_PADS_DONE)
#define NFS4_TRACK_PADS_DONE
#include "group_types.h"
#elif defined(NFS4_CHUNK_IN_HOOK) && NFS4_CHUNK_IN_HOOK == 1
typedef struct Trk_Material {
    short shapeIndex;
    u_char flag, uvFlag, r, g, b;
    char textureCount;
    u_char interval;
    char pad;
} Trk_Material;
#elif defined(NFS4_CHUNK_IN_HOOK) && NFS4_CHUNK_IN_HOOK == 2
struct TrackHeader {
    int type, version, maxMetaChunkSize, maxGeomCollSize;
    int maxFullSize, maxSplitSize, metaChunkCount, chunkCount;
};
#elif defined(NFS4_CHUNK_IN_HOOK) && NFS4_CHUNK_IN_HOOK == 3
#include "shared/SaveSurface.h"   /* one SaveSurface definition (header-truth 4w) */







#include "shared/tBoundingSphere.h"
#endif
