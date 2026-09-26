/* Camera_tCamSlot -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CAMERA_TCAMSLOT_H
#define NFS4_SHARED_CAMERA_TCAMSLOT_H

struct Camera_tCamSlot {
    char mode;
    char track : 1;
    char zoom : 2;
    char splineMode : 3;
    short fov;
    coorddef pos;
    int height, splineOffset;
    COORD16 euler;
    short slice;
};
#endif
