/* mcrd_managertask.h -- the memory-card MANAGERTASK enum, moved verbatim from screenmemcard_types.h. */
#ifndef NFS4_FRONTEND_COMMON_MCRD_MANAGERTASK_H
#define NFS4_FRONTEND_COMMON_MCRD_MANAGERTASK_H
typedef enum MANAGERTASK {
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;
#endif
