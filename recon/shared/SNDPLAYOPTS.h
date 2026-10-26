/* SNDPLAYOPTS -- canonical 20-byte play descriptor. The retail SYM records its three
   16-bit unsigned fields as USHORT; spell that type directly so the header is self-contained. */
#ifndef NFS4_SHARED_SNDPLAYOPTS_H
#define NFS4_SHARED_SNDPLAYOPTS_H

struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    unsigned short pitchmult, timemult, azimuth;
    short elevation;
};
#endif
