/* FE3d_zFacet -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_FE3D_ZFACET_H
#define NFS4_SHARED_FE3D_ZFACET_H

struct FE3d_zFacet {
    u_short vertexId0, vertexId1, vertexId2, uvId0, uvId1, uvId2;
    SVECTOR normal[3];
    CVECTOR color;
    u_char flag, pad1, pad2, pad3;
};
#endif
