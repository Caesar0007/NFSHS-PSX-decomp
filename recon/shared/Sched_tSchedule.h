/* Sched_tSchedule -- shared source type; the completed alias is supplied by retail SYM.
   Producer/consumer receipts: build/nc12/track_animation_source_20261024; original header text remains open. */
#ifndef NFS4_SHARED_SCHED_TSCHEDULE_H
#define NFS4_SHARED_SCHED_TSCHEDULE_H

typedef struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
} Sched_tSchedule;
#endif
