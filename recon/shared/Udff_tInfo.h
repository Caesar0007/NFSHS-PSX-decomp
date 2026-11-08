/* Udff_tInfo -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_UDFF_TINFO_H
#define NFS4_SHARED_UDFF_TINFO_H

struct Udff_tInfo {
    Udff_tAccessType type;
    int handle;
    char *memPtr;
};
#if defined(NFS4_TU_AIINIT) || defined(NFS4_TU_AISPEEDS)   /* owner object: retail records the C-style `typedef struct Udff_tInfo {..} Udff_tInfo;` form (TPDEF twice) */
typedef struct Udff_tInfo Udff_tInfo;
#endif
#endif
