/* Trk_AnimateBoomInst -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_ANIMATEBOOMINST_H
#define NFS4_SHARED_TRK_ANIMATEBOOMINST_H

/* Retail ANIM and OBJECT both supply this completed-type typedef.
 * Keep the supplied alias with its header producer,not a dummy local use.
 * Receipt: build/nc12/shared_boom_type_20261026/final-proof.json. */
typedef struct Trk_AnimateBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
    u_char simIndex, boomIndex;
    short pad2;
} Trk_AnimateBoomInst;
#endif
