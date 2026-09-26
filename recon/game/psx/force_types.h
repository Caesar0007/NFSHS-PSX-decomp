/* force.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_FORCE_TYPES_H
#define NFS4_GAME_PSX_FORCE_TYPES_H

#include "../common/color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#include "shared/Sched_tSchedule.h"




#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Force_tGlobal.h"




#include "shared/TCB.h"
#include "shared/EXEC.h"



struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

typedef int Input_tDeviceCall();

#endif
