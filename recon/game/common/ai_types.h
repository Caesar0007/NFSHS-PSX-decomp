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

struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; /* the 5 retail AIPhysic_BrakeInfo inline bodies (aiphysic_types.h + aispeeds_types.h); retail 7 TPDEFs per includer */ inline void SetBrakeDistance(int speed, int distance) { int sIndex = speed / 0x10000; if (sIndex < 0) sIndex = -sIndex; if (!(sIndex < 0x80)) sIndex = 0x80; brakeTable_[sIndex] = (u_char)(distance / 0x20000); } AIPhysic_BrakeInfo(int deceleration) { int invDeceleration; deceleration_ = deceleration; invDeceleration = fixeddiv(0x10000, deceleration); for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) { int brakeDistanceMeters = fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2; SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters); } } inline int Deceleration() { return deceleration_; } int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); } };
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
