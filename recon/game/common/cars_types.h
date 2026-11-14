#if !defined(NFS4_GAME_COMMON_CARS_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_CARS_TYPES_H   /* cars.obj's exact source-visible delta over the shared CopSpeak graph. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#define NFS4_AUDIOCLC_LATE_KERNEL   /* retail: TCB..Skidmark right after tfrontEnd (audiocmn_types.h) */
#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
/* camera_info + forceFocus_t: the copspeak path omits camera_info and views forceFocus_t as int; retail cars.obj records
   forceFocus_t as its LAST type (after Speaker) -> both are defined in the tail block below */
#define NFS4_COLOR_OMIT_UDFF_HANDLE
#define NFS4_AFTER_CAR_CARS   /* this object's own types come right after Car_tObj (audioclc_types.h lists the common graph) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "draw_leaf_core.h"
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H   /* this object lists the draw leaf itself (retail record order) */
#include "draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "cars_after_pads.h"   /* own types at this point */
#include "draw_leaf_b_pixmap.h"
#include "draw_leaf_c_cache.h"
#include "draw_leaf_d_carvertex.h"
#include "copspeak_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_CARS_EARLY_DONE
#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */



#include "shared/AIPhysic_ModelConfig_t.h"
#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */













#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */




#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */










#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_TAIL_DONE)   /* first pass, after copspeak_types.h */
#define NFS4_CARS_TAIL_DONE

#undef NFS4_COLOR_OMIT_UDFF_HANDLE


#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#undef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#include "shared/forceFocus_t.h"   /* retail cars.obj: forceFocus_t is the last type record, after Speaker */
#include "shared/camera_info.h"   /* its forceFocus field keeps the enum referenced (SLINK) */

typedef int CarLogic_tObservations[1][3];

#include "shared/Trk_ObjectDef.h"

#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/Trk_NewSlice.h"













#include "shared/Object_tIMassObjInfo.h"

typedef Udff_tInfo *Udff_tHandle;

#endif
