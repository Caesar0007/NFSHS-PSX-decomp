/* kernpair -- the one definition of this type, shared by 27 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_KERNPAIR_H
#define NFS4_SHARED_KERNPAIR_H

struct kernpair {
    unsigned short previouscode, code;
    char kernvalue;
    char pad[3];
};
#endif
