/* video.obj-owned records layered on the reduced frontend/PSX platform set. */
#ifndef NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_CORE_HOOK_BEFORE_CD "frontend/psx/video_before_cd.h"   /* retail video.obj: windowtbl before the CD stream */
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
