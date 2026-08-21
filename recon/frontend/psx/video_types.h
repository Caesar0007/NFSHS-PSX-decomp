/* video.obj-owned records layered on the reduced frontend/PSX platform set. */
#ifndef NFS4_FRONTEND_PSX_VIDEO_TYPES_H
#define NFS4_FRONTEND_PSX_VIDEO_TYPES_H

#include "ea_psx_types.h"

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

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char  outputchannelsmin, outputchannelsmax;
    u_char  inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char    pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char  outputchannels, inputvoices, useeax;
    u_char  use3dacceleration, use3dmixing;
    char    pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    int (*issurfacelocked)(void);
};

struct SNDPLAYOPTS {
    int     patnum;
    char    bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short   elevation;
};

struct SNDREQUESTSTATUS {
    int state, currenttime, timetoend, timebuffered;
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char  channels, samplerep;
};

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
