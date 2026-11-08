#ifndef NFS4_GAME_COMMON_AILIFE_TYPES_H
#define NFS4_GAME_COMMON_AILIFE_TYPES_H   /* ailife.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_CORE_SUBDIV_TRKART   /* retail: Draw_SubdivStruct after Draw_SVertex, Track_tArt/Material after RelCoord16 */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#include "shared/POLY_GT4.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"




#include "shared/Sched_tSchedule.h"




struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_; /* the 5 retail AIPhysic_BrakeInfo inline bodies (aiphysic_types.h + aispeeds_types.h); retail 7 TPDEFs per includer */ inline void SetBrakeDistance(int speed, int distance) { int sIndex = speed / 0x10000; if (sIndex < 0) sIndex = -sIndex; if (!(sIndex < 0x80)) sIndex = 0x80; brakeTable_[sIndex] = (u_char)(distance / 0x20000); } AIPhysic_BrakeInfo(int deceleration) { int invDeceleration; deceleration_ = deceleration; invDeceleration = fixeddiv(0x10000, deceleration); for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) { int brakeDistanceMeters = fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2; SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters); } } inline int Deceleration() { return deceleration_; } int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); }
};

#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"





typedef int CarLogic_tObservations[1][3];

#endif
