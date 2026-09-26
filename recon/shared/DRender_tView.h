/* DRender_tView -- the one definition of this type, shared by 15 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRENDER_TVIEW_H
#define NFS4_SHARED_DRENDER_TVIEW_H

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};
#endif
