/* tShapeInformation -- the one definition of this type, shared by 12 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TSHAPEINFORMATION_H
#define NFS4_SHARED_TSHAPEINFORMATION_H

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    bool fLoadCancelled;
};
#endif
