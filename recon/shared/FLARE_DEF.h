/* FLARE_DEF -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_FLARE_DEF_H
#define NFS4_SHARED_FLARE_DEF_H

struct FLARE_DEF {
    DVECTOR pos[2], oldpos[2];
    u_short screenData[2][5][5];
    int size;
    FLARE_PIECE_DEF *piece;
    char isDrawn[2];
};
#endif
