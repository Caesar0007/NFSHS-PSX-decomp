/* simqueue.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SIMQUEUE_TYPES_H
#define NFS4_GAME_COMMON_SIMQUEUE_TYPES_H

#include "color_types.h"

struct Input_tResults {
    char steering;
    u_char gas, brake, flags;
};

typedef enum VALIDITY {
    kINVALID = 0,
    kVALID = 1,
    kPREDICTED = 2,
    kRESIM = 3
} VALIDITY;

struct sim_queue {
    Input_tResults Buffer[2][32];
    VALIDITY Validity[2][32];
    int HeadTime;
    int TailTime[2];
};

typedef int Input_tDeviceCall(u_long value);
typedef sim_queue SIM_QUEUE;

#endif
