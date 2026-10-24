/* Sched_tFunctionSchedule -- shared source type; the completed alias is supplied by retail SYM.
   Producer/consumer receipts: build/nc12/track_animation_source_20261024; original header text remains open. */
#ifndef NFS4_SHARED_SCHED_TFUNCTIONSCHEDULE_H
#define NFS4_SHARED_SCHED_TFUNCTIONSCHEDULE_H

typedef struct Sched_tFunctionSchedule {
    int priority;
    Sched_tFunctionPt function;
    void *var1, *var2;
} Sched_tFunctionSchedule;
#endif
