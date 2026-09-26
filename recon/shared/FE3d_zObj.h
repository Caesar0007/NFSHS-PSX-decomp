/* FE3d_zObj -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_FE3D_ZOBJ_H
#define NFS4_SHARED_FE3D_ZOBJ_H

struct FE3d_zObj {
    int numVertex, numUV, numFacet;
    u_char textureId, textureWidth, textureHeight, pad1;
    COORD16 *vertex;
    FE3d_zUV *uv;
    COORD16 *Nvertex;
    FE3d_zFacet *facet;
};
#endif
