/* SNDSYSVEC -- the one definition of this type, shared by 13 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SNDSYSVEC_H
#define NFS4_SHARED_SNDSYSVEC_H

typedef struct {
    int (*issurfacelocked)(void);
} SNDSYSVEC;
#endif
