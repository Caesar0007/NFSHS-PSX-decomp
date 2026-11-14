#ifndef NFS4_GAME_COMMON_CHUNK_TYPES_H
#define NFS4_GAME_COMMON_CHUNK_TYPES_H   /* chunk.obj source-visible types; full supplied type-copy/order audit remains open. */
#define NFS4_CORE_CCOORD16   /* CCOORD16 at its retail place (after COORD16, before the pads) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_GROUP_KERNEL_LATE
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
#include "shared/POLY_GT4.h"




#include "shared/CCOORD16.h"

#include "shared/DRender_tView.h"
#include "shared/Draw_SubdivStruct.h"
#include "shared/Trk_ObjectDef.h"




#include "shared/Trk_SimpleInst.h"






#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"
#define NFS4_CHUNK_SIGN_CTOR ObjectFinishedSignAnim() {}
#include "shared/Trk_Quad.h"
#include "shared/Trk_NewStrip.h"
#include "shared/Trk_NewSimQuad.h"
#include "shared/Trk_NewSimSlice.h"
#include "shared/Trk_SimObject.h"
#include "shared/RelCoord16.h"
#include "shared/Chunk.h"   /* one Chunk definition (header-truth 4o) */











#include "shared/Track_tArtresource.h"
#include "shared/Track_tMaterial.h"
#include "shared/tSaveSurface.h"
#include "gamesetup_leaf_types.h"   /* retail: GameSetup right after tSaveSurface (chunk.obj, track.obj) */

#include "shared/TCB.h"   /* retail chunk.obj: kernel types after GameSetup (group_types.h NFS4_GROUP_KERNEL_LATE) */
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/Skidmark_Segment.h"




#include "shared/Skidmark_Chunk.h"





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

















#include "chunk_types_d2.h"

#endif
