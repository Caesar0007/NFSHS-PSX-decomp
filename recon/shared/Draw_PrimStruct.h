/* Draw_PrimStruct -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_PRIMSTRUCT_H
#define NFS4_SHARED_DRAW_PRIMSTRUCT_H

struct Draw_PrimStruct {
    u_long *LastPrim;
    char *PrimPtr, *MPrimPtr;
};
#endif
