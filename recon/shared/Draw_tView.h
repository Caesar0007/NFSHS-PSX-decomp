/* Draw_tView -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_TVIEW_H
#define NFS4_SHARED_DRAW_TVIEW_H

struct Draw_tView {
    int otsize, membudget;
    DRAWENV drawenv[2];
    u_long *ot[2];
};
#endif
