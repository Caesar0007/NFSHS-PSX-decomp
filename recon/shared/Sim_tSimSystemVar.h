/* Sim_tSimSystemVar -- the one definition of this type, shared by 9 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SIM_TSIMSYSTEMVAR_H
#define NFS4_SHARED_SIM_TSIMSYSTEMVAR_H

struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};
#if defined(NFS4_TU_SIM)   /* owner object: retail records the C-style `typedef struct Sim_tSimSystemVar {..} Sim_tSimSystemVar;` form (TPDEF twice) */
typedef struct Sim_tSimSystemVar Sim_tSimSystemVar;
#endif
#endif
