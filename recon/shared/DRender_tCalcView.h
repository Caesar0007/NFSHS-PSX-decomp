/* DRender_tCalcView -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRENDER_TCALCVIEW_H
#define NFS4_SHARED_DRENDER_TCALCVIEW_H

struct DRender_tCalcView {
    coorddef translation;
    matrixtdef mrotation;
    coorddef translationInv;
    matrixtdef mrotationInv, mrotationInvRaw;
};
#endif
