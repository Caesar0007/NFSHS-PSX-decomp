/* tDrawShapeExtended -- the one definition of this type, shared by 10 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TDRAWSHAPEEXTENDED_H
#define NFS4_SHARED_TDRAWSHAPEEXTENDED_H

struct tDrawShapeExtended {
    short flip_axis;
    int tint[4];
    tTexture_ShapeInfo *custom_shapes;
};
#endif
