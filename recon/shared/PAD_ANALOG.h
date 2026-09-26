/* PAD_ANALOG -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_PAD_ANALOG_H
#define NFS4_SHARED_PAD_ANALOG_H

struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
};
#endif
