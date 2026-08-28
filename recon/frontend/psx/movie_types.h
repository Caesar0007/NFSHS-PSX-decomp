/* Movie.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_FRONTEND_PSX_MOVIE_TYPES_H
#define NFS4_FRONTEND_PSX_MOVIE_TYPES_H

/* Movie.obj contains color.obj's complete 71-record game/platform graph. */
#include "../../game/common/color_types.h"

typedef struct CdlLOC {
    u_char minute, second, sector, track;
} CdlLOC;

typedef struct CdlFILE {
    CdlLOC pos;
    u_long size;
    char name[16];
} CdlFILE;

typedef struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
} TCB;

typedef struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size;
    u_long b_addr, b_size, s_addr, s_size, sp, fp, gp, ret, base;
} EXEC;

typedef struct DIRENTRY {
    char name[20];
    long attr, size;
    struct DIRENTRY *next;
    long head;
    char system[4];
} DIRENTRY;

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair kernpair;
typedef struct kernpair KERN;

typedef struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
} SNDSYSCAP;

typedef struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax;
    u_char use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
} SNDSYSSET;

typedef struct SNDSYSVEC {
    int (*issurfacelocked)(void);
} SNDSYSVEC;

typedef struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
} SNDSAMPLEFORMAT;

typedef struct DECENV {
    u_long *vlcbuf[2];
    int vlcid;
    u_short *imgbuf;
    RECT rect[2];
    int rectid;
    RECT slice;
    int isdone;
} DECENV;

typedef struct CDSECTOR {
    u_short id, type, secCount, nSectors;
    u_long frameCount, frameSize;
    u_short width, height;
    u_long headm, headv;
} CDSECTOR;

typedef void (*CdlCB)(void);
typedef u_short DECDCTTAB[34816];
typedef void (*fontblit)(void);
typedef int (*getcode)(void);
typedef void (*fontblitbegin)(void);
typedef void (*fontblitend)(void);
typedef void (*adjustchar)(void);
typedef void (*CallbackFunc)(void);

#endif
