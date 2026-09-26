/* tVideoTransition -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TVIDEOTRANSITION_H
#define NFS4_SHARED_TVIDEOTRANSITION_H

struct tVideoTransition {
    tScreenMainState state;
    u_short flags;
    u_char u, v, uw, vh;
    u_short clut, tpage;
    unsigned int tint;
    short bright;
};
#endif
