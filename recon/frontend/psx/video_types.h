/* video.obj-owned records layered on the reduced frontend/PSX platform set. */
#ifndef NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_FRONTEND_PSX_VIDEO_TYPES_H

#include "nfs4_types.h"

struct windowtbl {
    long   id;
    int    x, y, width, height;
    u_char bpp, type, ram, unused;
    int    minx, miny, maxx, maxy;
    struct shapetbl *shape;
    struct DISPENV dispenv;
    struct DRAWENV drawenv;
};
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

struct VIDEOSTRUCT {
    int    id, bufferwidth, bufferheight;
    char   *streambuffer;
    int    mdechandle;
    struct windowtbl *frame;
    long   videotap;
    enum VIDEOSTATE state;
    long   streamrequestid;
    int    reftime, displaytime, displaytimefrac, displaytimeincr;
    int    framewidth, frameheight, droppedframes;
};

typedef long STREAMHANDLE;
typedef long STREAMREQUESTID;

#endif
