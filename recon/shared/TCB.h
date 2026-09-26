/* TCB -- the one definition of this type, shared by 31 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TCB_H
#define NFS4_SHARED_TCB_H

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};
#endif
