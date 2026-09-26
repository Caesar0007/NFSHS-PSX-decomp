/* souffle.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_GAME_COMMON_SOUFFLE_TYPES_H

#include "color_types.h"

#include "shared/DRender_tView.h"




#include "shared/Souffle_tISouffle.h"







#include "shared/Sched_tSchedule.h"




#include "shared/TCB.h"





struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#endif
