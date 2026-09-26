/* PCOORD16 -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_PCOORD16_H
#define NFS4_SHARED_PCOORD16_H

struct PCOORD16 {
    short x, y, z, p;
};
#endif
