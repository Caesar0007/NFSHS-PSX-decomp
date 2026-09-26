/* souffle.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_GAME_COMMON_SOUFFLE_TYPES_H

#include "color_types.h"

#include "shared/DRender_tView.h"




#include "shared/Souffle_tISouffle.h"







#include "shared/Sched_tSchedule.h"




#include "shared/TCB.h"





#include "shared/EXEC.h"




struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#endif
