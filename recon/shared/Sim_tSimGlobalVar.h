/* Sim_tSimGlobalVar -- the one definition of this type, shared by 26 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SIM_TSIMGLOBALVAR_H
#define NFS4_SHARED_SIM_TSIMGLOBALVAR_H

struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};
#endif
