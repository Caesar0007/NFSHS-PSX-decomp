/* Sched_tFunctionSchedule -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SCHED_TFUNCTIONSCHEDULE_H
#define NFS4_SHARED_SCHED_TFUNCTIONSCHEDULE_H

struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
};
#endif
