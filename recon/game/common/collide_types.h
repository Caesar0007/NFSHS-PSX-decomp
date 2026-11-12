/* collide.obj's exact source-visible delta over the shared color graph. */
#if !defined(NFS4_GAME_COMMON_COLLIDE_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_COLLIDE_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_HOOK_AFTER_BO "collide_types.h"   /* retail: anim/scene/object types right after the BO types (second pass below) */
#include "color_types.h"
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





