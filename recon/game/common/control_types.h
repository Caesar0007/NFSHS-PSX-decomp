/* control.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_CONTROL_TYPES_H
#define NFS4_GAME_COMMON_CONTROL_TYPES_H

#include "color_types.h"

#include "shared/Sched_tSchedule.h"




typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDSAMPLEFORMAT.h"




typedef int CarLogic_tObservations[1][3];
typedef int Input_tDeviceCall();

#endif
