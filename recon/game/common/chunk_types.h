#ifndef NFS4_GAME_COMMON_CHUNK_TYPES_H
#define NFS4_GAME_COMMON_CHUNK_TYPES_H   /* chunk.obj source-visible types; full supplied type-copy/order audit remains open. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES   /* track.obj sees chunk without POLY_GT4 */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_GROUP_KERNEL_LATE
#endif
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#include "group_types.h"   /* own types at this point */
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_types.h"
#include "group_types.h"
#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/POLY_GT4.h"



#endif

#include "shared/CCOORD16.h"

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#endif
#ifdef NFS4_CHUNK_HOOK   /* track.obj: Trk_Material right after the draw leaf (owner second pass, 1..3) */
#define NFS4_CHUNK_IN_HOOK 1
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
#include "shared/Trk_ObjectDef.h"




#include "shared/Trk_SimpleInst.h"






#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"
#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES   /* SignAnim ctor body in both (INV-A3: with the Multi state body before it, track.obj no longer overshoots) */
#define NFS4_CHUNK_SIGN_CTOR ObjectFinishedSignAnim() {}
#else
#define NFS4_CHUNK_SIGN_CTOR ObjectFinishedSignAnim() {}
#endif
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/Trk_SimObject.h"
#include "shared/RelCoord16.h"
#ifdef NFS4_CHUNK_HOOK   /* track.obj: TrackHeader between RelCoord16 and Chunk */
#define NFS4_CHUNK_IN_HOOK 2
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
#include "shared/Chunk.h"   /* one Chunk definition (header-truth 4o) */











#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/tSaveSurface.h"
#ifdef NFS4_CHUNK_HOOK   /* track.obj: SaveSurface, tBoundingSphere right after tSaveSurface */
#define NFS4_CHUNK_IN_HOOK 3
#include NFS4_CHUNK_HOOK
#undef NFS4_CHUNK_IN_HOOK
#endif
#include "gamesetup_leaf_types.h"   /* retail: GameSetup right after tSaveSurface (chunk.obj, track.obj) */
#ifdef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES   /* retail track.obj: the scheduler types right after GameSetup */
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#endif

#ifndef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "shared/TCB.h"   /* retail chunk.obj: kernel types after GameSetup (group_types.h NFS4_GROUP_KERNEL_LATE) */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"




#include "shared/Skidmark_Chunk.h"




#endif

#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */




#include "shared/BWorldSm_Pos.h"













struct BO_tNewtonObj;
#include "shared/BO_tNewtonCollisionInfo.h"









#include "shared/BO_tNewtonObj.h"




























#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

/* __vtbl_ptr_type is GCC 2.7.2's built-in vtable-entry typedef. */
struct DRender_tView;
struct Draw_DCache;
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */

















typedef void Trk_Chunk;
typedef void *lpTrk_Chunk;
typedef short (*tPA32)[32];

#endif
