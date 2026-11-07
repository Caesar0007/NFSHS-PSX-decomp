/* DRender_tView -- the one definition of this type, shared by 15 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRENDER_TVIEW_H
#define NFS4_SHARED_DRENDER_TVIEW_H

#ifdef NFS4_DRVIEW_STRUCT_ONLY   /* retail drawc/hud: plain struct (one TPDEF); elsewhere C-style typedef (two) */
struct DRender_tView {
#else
typedef struct DRender_tView {
#endif
    int id, player;
    DRender_tCalcView cview;
#ifdef NFS4_DRVIEW_STRUCT_ONLY
};
#else
} DRender_tView;
#endif
#endif
