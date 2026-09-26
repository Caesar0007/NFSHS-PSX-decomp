/* ailife.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AILIFE_TYPES_H
#define NFS4_GAME_COMMON_AILIFE_TYPES_H

#include "color_types.h"

#include "shared/POLY_GT4.h"







#include "shared/Draw_SubdivStruct.h"

#include "shared/Track_tArtresource.h"







#include "shared/Track_tMaterial.h"




#include "shared/Sched_tSchedule.h"




struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
};

#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/TCB.h"
#include "shared/EXEC.h"



struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#include "shared/Skidmark_Segment.h"






#include "shared/Skidmark_Chunk.h"





typedef int CarLogic_tObservations[1][3];

#endif
