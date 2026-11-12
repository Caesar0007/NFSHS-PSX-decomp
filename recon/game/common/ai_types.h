#ifndef NFS4_GAME_COMMON_AI_TYPES_H
#define NFS4_GAME_COMMON_AI_TYPES_H   /* AI.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#include "shared/Trk_NewSlice.h"







/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail ai.obj (GameSetup_gData is read through its word view) */
















#define RaceType_HotPursuit 1

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"

#include "shared/AIPhysic_BrakeInfo.h"   /* one AIPhysic_BrakeInfo definition (header-truth 4m) */
#include "shared/AI_tInfo.h"   /* retail ai.obj: BrakeInfo, AI_tInfo, ModelConfig ahead of the AIDataRecord family */
#include "shared/AIPhysic_ModelConfig_t.h"
#include "aidatarecord_classes.h"   /* the AIDATARECORD.H record-class family: no private copies (header-truth 4i) */










































#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





#include "shared/BW_tContext.h"





#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */



#include "shared/SceneElem.h"






#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */












typedef int CarLogic_tObservations[1][3];

#endif
