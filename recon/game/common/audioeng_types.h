/* audioeng.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AUDIOENG_TYPES_H
#define NFS4_GAME_COMMON_AUDIOENG_TYPES_H

#include "color_types.h"

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
    u_char r3, g3, b3, p3; short x3, y3; u_char u3, v3; u_short pad3;
};
struct Draw_SubdivStruct { Draw_SVertex v[15]; };
struct Track_tArtresource {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
};
struct Track_tMaterial { char flag, mipmap_offset; short pmxIndex; };

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
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
struct SNDSAMPLEFORMAT { u_short samplerate; u_char channels, samplerep; };
struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short elevation;
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

struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};
struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};

struct AudioEng_tEvent {
    char use, patnum, pad1, pad2;
    short delta, max;
    int attackdelta, decaydelta;
};
struct AudioEng_tTable { char xlate[512]; };
struct AudioEng_tDef {
    int id;
    char ver, resolved, startevent, controllerpercent;
    short lowrandomtargetlevel, lowrandomtargetrange;
    int lowrandomattacktime, lowrandomattackrange;
    short highrandomtargetlevel, highrandomtargetrange;
    int highrandomattacktime, highrandomattackrange;
    char patchnum[8];
    AudioEng_tEvent event[16];
    AudioEng_tTable *pvoltable[8], *pbendtable[8];
};
struct AudioEng_tChanAttr {
    short min, max;
    char *xlate;
    char patchnum;
};
struct AudioEng_tAdjustments {
    u_char inCarBoost, inCarExhaust, outCarExhaust, fwdEngBoost;
    u_char rwdExhBoost, outCarBoost, pitchScale, timbreScale;
};
struct AudioEng_tVoiceAttr {
    char vol;
    u_short pitch, azim;
    int handle;
};
struct AudioEng_tState {
    u_short vol, dop, azi, sep, esp;
    u_char exh, gas;
};
struct AudioEng_t {
    AudioEng_tAdjustments adjust;
    int tick;
    int vol[16];
    int azi, sep, dop;
    char bhandle, pad;
    AudioEng_tState queue[16];
    char setpos, plypos;
    AudioEng_tChanAttr chan[16];
    AudioEng_tVoiceAttr left[16], right[16];
    char delay[16];
    char *tables;
};

#endif
