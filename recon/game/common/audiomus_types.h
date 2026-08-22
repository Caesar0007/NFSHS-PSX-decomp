/* audiomus.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOMUS_TYPES_H
#define NFS4_GAME_COMMON_AUDIOMUS_TYPES_H

#include "color_types.h"

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct AudioMus_tCurrentSong {
    int newsong, index, remaining;
    AudioMus_tSongEntry info;
};

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax, inputvoicesmax,
           input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC { int (*issurfacelocked)(void); };

struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short elevation;
};

struct SNDREQUESTSTATUS { int state, currenttime, timetoend, timebuffered; };
struct SNDSTREAMSTATUS { int outstandingrequests, currentrequest, timebuffered; };
struct SNDSAMPLEFORMAT { u_short samplerate; u_char channels, samplerep; };

struct SNDLIMITS {
    int dmabuflen;
    u_char numdmabufs, numdmamsgs, nummicrotalkinstances, microtalkinstanceabort;
    short numrspcmds, pad;
    int audiostreambufsize, packetbufsize;
};

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct CdlLOC { u_char minute, second, sector, track; };
typedef void (*CdlCB)();

struct AudioMus_tMusicGlobals {
    int volume, totalsongs, availablesongs, requestsong, firstswitch, switchsong;
    int newswitch, failby, errorcode, fadetime, randomize;
    char *songname;
    char title64[64];
    char *streambuffer;
    int streamhandle, requesthandle, serveractive, driveractive, greedy, threshold;
    char *bigfileheader;
    SNDSTREAMSTATUS streamstatus;
    SNDREQUESTSTATUS requeststatus;
    char bigfilename[64];
    char playlist[32];
    AudioMus_tCurrentSong current;
};

#endif
