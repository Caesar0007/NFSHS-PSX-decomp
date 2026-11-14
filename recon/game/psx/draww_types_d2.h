/* draww_types_d2 -- moved verbatim out of draww_types.h so that header holds only its include list. */
#ifndef NFS4_DRAWW_TYPES_D2_H
#define NFS4_DRAWW_TYPES_D2_H
typedef kernpair KERN;
typedef struct {
    Trk_SimObject *simObjs;
    Group *objInstanceBuf;
    int doFrustumClip, zClipSq, offset;
    short *visList;
} ChunkObjectInfo;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef tQuat Quatern_quat;
#endif
