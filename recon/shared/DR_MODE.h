/* DR_MODE -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DR_MODE_H
#define NFS4_SHARED_DR_MODE_H

struct DR_MODE {
    u_long tag;
    u_long code[2];
};
#endif
