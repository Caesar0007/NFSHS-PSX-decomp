#if !defined(NFS4_GAME_COMMON_OBJECT_TYPES_H)   /* first pass; object.obj's exact source-visible type surface reconstructed from SYM */
#define NFS4_GAME_COMMON_OBJECT_TYPES_H
#define NFS4_CORE_DRVIEW   /* retail: DRender_tView right after DRender_tCalcView (draw_leaf_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CACHEHEADER "shared/Draw_DCache.h"   /* retail: Draw_DCache right after Draw_tCacheHeader (draw_leaf_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "object_after_carvertex.h"   /* retail: track object types right after Draw_CarVertex */
#define NFS4_COLOR_GROUP_LATE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_HOOK_GROUP_LATE_TRK "trk_sfx_simobject_late.h"   /* retail: Trk_SFX/Trk_SimObject after Trk_NewSimSlice */
#define NFS4_AIHIGH_TRAFFIC_AFTER_HUMANCOP   /* aihigh.h: AIHigh_Traffic right after BTC_HumanCop (retail object.obj, AIHIGH.H 527/584) */
#include "link_stripped.h"
#define NFS4_COLOR_HOOK_AFTER_BO "object_types.h"   /* retail: anim/object types right after the BO types (second pass below) */
#define NFS4_COLOR_HOOK_AFTER_RELCOORD "object_types.h"   /* retail: Chunk right after Group (pass below) */
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
