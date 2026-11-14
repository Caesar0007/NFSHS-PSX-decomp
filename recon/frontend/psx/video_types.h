/* video.obj-owned records layered on the reduced frontend/PSX platform set. */
#ifndef NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_TYPES_H   /* this object lists the root type graph itself (retail record order) */
#include "nfs4_core_0_kernel.h"
#include "nfs4_core_1_gpu.h"
#include "nfs4_core_2_shape.h"
#include "frontend/psx/video_before_cd.h"   /* own types at this point */
#include "nfs4_core_3_cd.h"
#include "nfs4_core_4_tail.h"
#include "nfs4_types.h"

/* struct windowtbl: frontend/psx/video_before_cd.h (included by nfs4_types.h before the CD stream) */








typedef struct windowtbl WINDOW;

#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"








#include "shared/SNDSYSVEC.h"



#include "shared/SNDPLAYOPTS.h"






#include "shared/SNDREQUESTSTATUS.h"



#include "shared/SNDSAMPLEFORMAT.h"




struct STREAMCHUNKHDR {
    long type, size;
};

enum VIDEOSTATE {
    VIDEOSTATE_IDLE = 0,
    VIDEOSTATE_SPOOLING = 1,
    VIDEOSTATE_READY = 2,
    VIDEOSTATE_PLAYING = 3
};

typedef struct {
    int    id, bufferwidth, bufferheight;
    char   *streambuffer;
    int    mdechandle;
    struct windowtbl *frame;
    long   videotap;
    enum VIDEOSTATE state;
    long   streamrequestid;
    int    reftime, displaytime, displaytimefrac, displaytimeincr;
    int    framewidth, frameheight, droppedframes;
} VIDEOSTRUCT;

typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;

#endif
