/* DR_AREA -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DR_AREA_H
#define NFS4_SHARED_DR_AREA_H

struct DR_AREA {
    u_long tag;
    u_long code[2];
};
#endif
