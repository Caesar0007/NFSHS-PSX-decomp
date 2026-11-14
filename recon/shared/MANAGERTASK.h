/* MANAGERTASK -- the one definition of this enum, shared by 2 headers (moved verbatim by enum_dedup; every
   former copy includes this file at the same place). */
#ifndef NFS4_SHARED_MANAGERTASK_H
#define NFS4_SHARED_MANAGERTASK_H

typedef enum MANAGERTASK {
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;
#endif
