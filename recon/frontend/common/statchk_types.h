/* Owner-specific type surface for Statchk.obj. */
#ifndef NFS4_FRONTEND_COMMON_STATCHK_TYPES_H
#define NFS4_FRONTEND_COMMON_STATCHK_TYPES_H

#define NFS4_FECNTL_NO_RECORD_CARRIER
#define NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#include "fecntl_types.h"
#undef NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#undef NFS4_FECNTL_NO_RECORD_CARRIER

/* Statchk.obj's sole canonical addition to the Fecntl graph. */
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];

#endif
