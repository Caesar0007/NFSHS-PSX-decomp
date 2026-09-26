/* audiomus.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOMUS_TYPES_H
#define NFS4_GAME_COMMON_AUDIOMUS_TYPES_H

#include "color_types.h"

#include "shared/AudioMus_tSongEntry.h"





#include "shared/AudioMus_tCurrentSong.h"




#include "shared/AudioMus_tSongList.h"




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

#include "shared/SNDSYSVEC.h"

#include "shared/SNDPLAYOPTS.h"






#include "shared/SNDREQUESTSTATUS.h"
#include "shared/SNDSTREAMSTATUS.h"
#include "shared/SNDSAMPLEFORMAT.h"

struct SNDLIMITS {
    int dmabuflen;
    u_char numdmabufs, numdmamsgs, nummicrotalkinstances, microtalkinstanceabort;
    short numrspcmds, pad;
    int audiostreambufsize, packetbufsize;
};

#include "shared/TCB.h"
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

#include "shared/CdlLOC.h"
typedef void (*CdlCB)(u_char intr, u_char *result); /* PsyQ 4.3 <libcd.h> */

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
