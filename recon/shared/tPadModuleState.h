/* tPadModuleState -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TPADMODULESTATE_H
#define NFS4_SHARED_TPADMODULESTATE_H

struct tPadModuleState {
    int initialized;
    PAD_COMMON buf[8];
    struct {
        char bActive, time;
    } state[8];
};
#endif
