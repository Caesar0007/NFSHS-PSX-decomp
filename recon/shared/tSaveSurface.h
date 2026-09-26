/* tSaveSurface -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TSAVESURFACE_H
#define NFS4_SHARED_TSAVESURFACE_H

struct tSaveSurface {
    Trk_NewSimQuad *fSimQuad;
    u_char fSurface;
};
#endif
