/* PAD_COMMON -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_PAD_COMMON_H
#define NFS4_SHARED_PAD_COMMON_H

struct PAD_COMMON {
    u_char nopad, ID;
    union {
        PAD_PSX standard;
        PAD_NEGCON negcon;
        PAD_MOUSE mouse;
        PAD_ANALOG analog;
    } data;
};
#endif
