/* Draw_tCtrlSkidmark -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_TCTRLSKIDMARK_H
#define NFS4_SHARED_DRAW_TCTRLSKIDMARK_H

struct Draw_tCtrlSkidmark {
    matrixtdef m;
    coorddef t;
    int count;
    Skidmark_Chunk *smp;
};
#endif
