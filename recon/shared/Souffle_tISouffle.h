/* Souffle_tISouffle -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SOUFFLE_TISOUFFLE_H
#define NFS4_SHARED_SOUFFLE_TISOUFFLE_H

struct Souffle_tISouffle {
    char type, id, wind, cycle;
    int aspeed, angle;
    coorddef source, motion, extramotion;
    SVECTOR trans;
    int rndpixmap, ground, colour;
};
#endif
