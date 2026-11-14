/* collide.obj's exact source-visible delta over the shared color graph. */
#if !defined(NFS4_GAME_COMMON_COLLIDE_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_COLLIDE_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_GAME_COMMON_COLOR_TYPES_H   /* this object lists the parts of the common type graph itself (retail record order) */
#include "color_p0_draw.h"
#include "color_p1_pregroup.h"
#include "color_p2_group_trk.h"
#include "color_p3_trkobj.h"
#include "color_p4_save.h"
#include "color_p5_bwsm.h"
#include "color_p6_bo.h"
#define NFS4_COLOR_IN_HOOK
#include "collide_types.h"   /* this header again: its NFS4_COLOR_IN_HOOK branch */
#undef NFS4_COLOR_IN_HOOK
#include "color_p7_sched.h"
#include "color_p8_car.h"
#include "color_p9_tail.h"
#include "shared/Sched_tSchedule.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK) && !defined(NFS4_COLLIDE_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_COLLIDE_EARLY_DONE
#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"




#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4g) */













#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */















#include "shared/Object_tSimObjList.h"

#endif





