#if !defined(NFS4_GAME_COMMON_OBJECT_TYPES_H)   /* first pass; object.obj's exact source-visible type surface reconstructed from SYM */
#define NFS4_GAME_COMMON_OBJECT_TYPES_H
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_TRAFFIC_AFTER_HUMANCOP   /* aihigh.h: AIHigh_Traffic right after BTC_HumanCop (retail object.obj, AIHIGH.H 527/584) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "shared/Draw_DCache.h"   /* own types at this point */
#include "draw_leaf_d_carvertex.h"
#include "object_after_carvertex.h"   /* own types at this point */
#include "link_stripped.h"
#define NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#include "sim_types.h"
#undef NFS4_SIM_OMIT_OBJECT_FOREIGN_TYPES
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_OBJECT_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_OBJECT_EARLY_DONE
struct SerializedGroup; struct SimpleMem; struct AIHigh_Cop;
#include "shared/BW_tContext.h"
#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"
#include "shared/Trk_AnimateInst.h"
#include "shared/Trk_SimObject.h"
#include "shared/Trk_SimpleInst.h"
#include "shared/Trk_AnimateBoomInst.h"
#include "shared/Trk_SFX.h"
#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4g) */














#include "shared/tQuat.h"
#include "shared/SceneElem.h"
#include "shared/SceneSortedElem.h"












#include "shared/AnimDef.h"
#include "shared/DRender_tView.h"
#include "shared/Draw_DCache.h"

#endif
#if defined(NFS4_COLOR_IN_HOOK5) && !defined(NFS4_OBJECT_CHUNK_DONE)   /* pass from color_types.h (after Group) */
#define NFS4_OBJECT_CHUNK_DONE
struct SerializedGroup; struct SimpleMem;
#include "shared/Chunk.h"   /* one Chunk definition (header-truth 4o) */










#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_OBJECT_EARLY2_DONE)   /* second pass, continued */
#define NFS4_OBJECT_EARLY2_DONE




#include "object_anim_classes.h"   /* the OBJECT.H animation class family (shared with every includer) */





































































#include "shared/Object_tSimObjList.h"
#include "shared/Object_tIMassObjInfo.h"
typedef tQuat Quatern_quat;
#endif
#if !defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_COLOR_IN_HOOK5) && !defined(NFS4_OBJECT_TAIL_DONE)   /* first pass, after sim_types.h */
#define NFS4_OBJECT_TAIL_DONE
#include "shared/Trk_NewSlice.h"





#include "shared/Sim_tSimGlobalVar.h"




#include "shared/SaveSurface.h"   /* one SaveSurface definition (header-truth 4w) */






#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#endif
