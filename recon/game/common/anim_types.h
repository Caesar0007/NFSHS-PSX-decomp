#if !defined(NFS4_GAME_COMMON_ANIM_TYPES_H) && !defined(NFS4_PADS_IN_HOOK)
#define NFS4_GAME_COMMON_ANIM_TYPES_H   /* anim.obj's exact source-visible type surface. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#define NFS4_PADS_IN_HOOK
#include "anim_types.h"   /* this header again: its NFS4_PADS_IN_HOOK branch */
#undef NFS4_PADS_IN_HOOK
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_types.h"
#endif
#if defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_ANIM_PADS_DONE)   /* second pass: game_common_pads_types.h */
#define NFS4_ANIM_PADS_DONE
#include "shared/tQuat.h"
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"




typedef struct tQuat Quatern_quat;

#include "shared/Group.h"   /* one Group definition (header-truth 4n) */




#endif
#if defined(NFS4_ANIM_PADS_DONE) && !defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_ANIM_B_DONE)
#define NFS4_ANIM_B_DONE
#include "shared/POLY_GT4.h"
#include "shared/CCOORD16.h"
#include "shared/Draw_SubdivStruct.h"

#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_AnimateBoomInst.h"







#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/RelCoord16.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"

#include "shared/tSaveSurface.h"




typedef struct {
    long x, y, z;
    short qx, qy, qz, qw;
} Anim_tFrame;

#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4g) */
















#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"



#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"
#include "gamesetup_leaf_types.h"   /* retail: GameSetup after the Skidmark types */
#include "shared/Sim_tSimGlobalVar.h"

typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];
#endif