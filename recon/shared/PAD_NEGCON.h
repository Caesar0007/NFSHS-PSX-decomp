/* PAD_NEGCON -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_PAD_NEGCON_H
#define NFS4_SHARED_PAD_NEGCON_H

struct PAD_NEGCON {
    u_char state : 4;
    u_char start : 4;
    u_char buttonAB : 4;
    u_char rightshift : 4;
    u_char twist, buttonI, buttonII, leftshift;
};
#endif
