/* Trk_AnimateInst -- the one definition of this type, shared by 15 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_ANIMATEINST_H
#define NFS4_SHARED_TRK_ANIMATEINST_H

/* Retail supplies this completed-type typedef as well as the struct tag.
 * The header producer is restored together with GetStatus's unprovided pointer
 * snapshot removal; do not add local aliases just to manufacture type copies.
 * Receipt: build/nc12/shared_animate_type_20261026/final-proof.json. */
typedef struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
} Trk_AnimateInst;
#endif
