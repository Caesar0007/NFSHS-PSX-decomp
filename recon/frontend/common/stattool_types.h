/* Owner-specific type surface for Stattool.obj. */
#ifndef NFS4_FRONTEND_COMMON_STATTOOL_TYPES_H
#define NFS4_FRONTEND_COMMON_STATTOOL_TYPES_H

/* Statchk.obj's complete 89-record graph is a strict subset. */
#include "statchk_types.h"

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

#include "shared/CARD_FILE_HEADER.h"








#include "shared/Sched_tSchedule.h"





#include "shared/tTrackInformation.h"











struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];
};

#endif
