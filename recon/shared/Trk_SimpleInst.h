/* Trk_SimpleInst -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_SIMPLEINST_H
#define NFS4_SHARED_TRK_SIMPLEINST_H

/* Retail supplies the completed-type typedef as well as the struct tag.
 * 2026-10-26: restore its shared producer; the old oi workaround in DRAWW
 * accidentally masked this missing copy. Layout/storage are unchanged.
 * Receipt: build/nc12/shared_simpleinst_type_20261026/final-proof.json. */
typedef struct Trk_SimpleInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
} Trk_SimpleInst;
#endif
