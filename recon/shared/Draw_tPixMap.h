/* Draw_tPixMap -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_TPIXMAP_H
#define NFS4_SHARED_DRAW_TPIXMAP_H

struct Draw_tPixMap {
    u_char u0, v0;
    u_short clut;
    u_char u1, v1;
    u_short tpage;
    u_char u2, v2;
    u_short pad2;
    u_char u3, v3;
    u_short flag;
};
#endif
