/* SNDSYSOPTS -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SNDSYSOPTS_H
#define NFS4_SHARED_SNDSYSOPTS_H

struct SNDSYSOPTS {
    SNDSYSCAP cap;
    SNDSYSSET set;
    SNDSYSVEC vec;
};
#endif
