/* device.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_DEVICE_TYPES_H
#define NFS4_GAME_PSX_DEVICE_TYPES_H

/* device.obj shares gmesetup.obj's frontend surface but not the completed
 * GameSetup_tData or FEI_tList owner records. */
#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "../common/gmesetup_types.h"
#undef NFS4_GMESETUP_OMIT_OWNER_RECORDS

struct Input_tDeviceList {
    char *devicename;
    int (*devicefunc)(u_long);
    int (*startupfunc)(int);
};

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

#endif
