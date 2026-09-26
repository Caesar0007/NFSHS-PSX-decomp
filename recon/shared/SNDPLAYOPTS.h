/* SNDPLAYOPTS -- the one definition of this type, shared by 5 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SNDPLAYOPTS_H
#define NFS4_SHARED_SNDPLAYOPTS_H

struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short elevation;
};
#endif
