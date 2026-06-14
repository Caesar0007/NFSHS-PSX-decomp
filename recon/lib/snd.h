/* lib/snd.h -- EA "SND" sound-runtime shared types & API (struct-first SND pass, 2026-06-10).
 *   Reconstructed from nfs4-f.exe (disasm-v3 field-access sweeps). NOT original source.
 *   Single source of truth for the SND objs (SNDPSXZ.LIB) so they stop re-deriving offsets.
 *   Structs are BYTE-EXACT in size; key fields named, gaps padded, full offset map in comments.
 *   Some voice fields are accessed as both int and (its high) short -> treat as union-ish; the
 *   .cpp files use offset casts where the asm overlaps.  Grow this header as objs are reconstructed.
 */
#ifndef LIB_SND_H
#define LIB_SND_H

#ifdef __cplusplus
extern "C" {
#endif

/* ---- one playing voice/channel : 0x64 (100) bytes, table at SndState.voices ---- */
typedef struct SndVoice {            /* offset map from the field-access sweep            */
    int   handle;        /* +0x00 voice handle/key (also read as u8/s8)                   */
    int   f04;           /* +0x04                                                          */
    char  _g08[2];       /* +0x08                                                          */
    signed char bank;    /* +0x0A owning sample bank                                       */
    signed char f0B;     /* +0x0B                                                          */
    unsigned char f0C;   /* +0x0C                                                          */
    char  _g0D[3];       /* +0x0D                                                          */
    int   f10;           /* +0x10                                                          */
    int   f14;           /* +0x14                                                          */
    int   f18;           /* +0x18                                                          */
    int   f1C;           /* +0x1C (high half also read as short @+0x1E)                    */
    int   f20;           /* +0x20                                                          */
    int   f24;           /* +0x24 (high half also read as short @+0x26)                    */
    int   f28;           /* +0x28                                                          */
    signed char f2C;     /* +0x2C                                                          */
    signed char vol_l;   /* +0x2D base volume (left)                                       */
    signed char pan;     /* +0x2E base pan                                                 */
    signed char f2F;     /* +0x2F                                                          */
    signed char f30;     /* +0x30                                                          */
    unsigned char f31;   /* +0x31                                                          */
    char  f32;           /* +0x32                                                          */
    signed char f33;     /* +0x33                                                          */
    signed char f34;     /* +0x34                                                          */
    signed char f35;     /* +0x35                                                          */
    char  f36;           /* +0x36                                                          */
    unsigned char f37;   /* +0x37                                                          */
    unsigned char f38;   /* +0x38                                                          */
    unsigned char f39;   /* +0x39                                                          */
    unsigned char f3A;   /* +0x3A                                                          */
    unsigned char f3B;   /* +0x3B                                                          */
    signed char f3C;     /* +0x3C                                                          */
    signed char pan_cur; /* +0x3D current pan                                              */
    char  _g3E[2];       /* +0x3E                                                          */
    int   f40;           /* +0x40                                                          */
    int   f44;           /* +0x44                                                          */
    int   pancurve;      /* +0x48 pointer to pan curve (or 0)                              */
    int   f4C;           /* +0x4C                                                          */
    int   f50;           /* +0x50                                                          */
    int   f54;           /* +0x54                                                          */
    char  _g58[2];       /* +0x58                                                          */
    short f5A;           /* +0x5A                                                          */
    short f5C;           /* +0x5C                                                          */
    short f5E;           /* +0x5E                                                          */
    unsigned short f60;  /* +0x60                                                          */
    unsigned short f62;  /* +0x62                                                          */
} SndVoice;              /* 0x64                                                           */

/* ---- one sample bank : 0x0C (12) bytes, table at SndState.banks ---- */
typedef struct SndBank {
    void *datablk;       /* +0x00 sample header / data block                              */
    void *platblk;       /* +0x04 platform (SPU) block                                    */
    unsigned char f08;   /* +0x08                                                          */
    unsigned char inuse; /* +0x09 platform block allocated                                */
    signed char  f0A;    /* +0x0A                                                          */
    char  f0B;           /* +0x0B                                                          */
} SndBank;               /* 0x0C                                                           */

/* ---- one reverb/effect bus : 0x10 (16) bytes, array at SndState.fxbus (SND+0x9C) ---- */
typedef struct SndFxBus {
    int type;            /* +0x00 fx type/mode (0 == off)                                 */
    int master;          /* +0x04 master level                                            */
    int depth;           /* +0x08                                                          */
    int delay;           /* +0x0C                                                          */
} SndFxBus;              /* 0x10                                                           */

/* ---- one-shot play descriptor : 0x14 (20) bytes (see SNDplaysetdef) ---- */
typedef struct SndPlayDef {
    int   handle;        /* +0x00 = -1                                                     */
    signed char f04;     /* +0x04 = -1                                                     */
    signed char decay;   /* +0x05 = 0x3C                                                   */
    signed char vol0;    /* +0x06 = 0x7F                                                   */
    signed char pan0;    /* +0x07 = 0x40                                                   */
    signed char vol1;    /* +0x08 = 0x7F                                                   */
    signed char pan1;    /* +0x09 = 0x40                                                   */
    signed char vol2;    /* +0x0A = 0x7F                                                   */
    signed char f0B;     /* +0x0B = 0                                                      */
    short pitch0;        /* +0x0C = 0x1000                                                 */
    short pitch1;        /* +0x0E = 0x1000                                                 */
    short f10;           /* +0x10 = 0                                                      */
    short f12;           /* +0x12 = 0                                                      */
} SndPlayDef;            /* 0x14                                                           */

/* ---- SND core state @0x80147860 : >= 0xB4 bytes ---- */
typedef struct SndState {
    char  _g00[2];       /* +0x00                                                          */
    short f02;           /* +0x02                                                          */
    char  f04, f05, f06, f07, f08, f09;  /* +0x04..0x09                                    */
    char  _g0A[2];       /* +0x0A                                                          */
    unsigned short bankcount;            /* +0x0C number of sample banks                   */
    short f0E;           /* +0x0E                                                          */
    char  f10;           /* +0x10                                                          */
    unsigned char patchcount;            /* +0x11 voices per bank scan                     */
    char  f12, f13, f14; /* +0x12..0x14                                                    */
    char  _g15[0x3C-0x15];               /* +0x15..0x3B                                    */
    signed char enabled; /* +0x3C sound system enabled                                     */
    signed char f3D;     /* +0x3D                                                          */
    unsigned char f3E, f3F, f40, f41;    /* +0x3E..0x41                                    */
    char  _g42[2];       /* +0x42                                                          */
    int   f44, f48, f4C; /* +0x44,+0x48,+0x4C                                              */
    char  _g50[0x7C-0x50];               /* +0x50..0x7B                                    */
    int   f7C, f80, f84, f88, f8C, f90;  /* +0x7C..0x90                                    */
    SndVoice *voices;    /* +0x94 voice table                                              */
    SndBank  *banks;     /* +0x98 bank table                                               */
    SndFxBus  fxbus[2];  /* +0x9C reverb/effect buses (stride 0x10)                        */
} SndState;              /* 0xBC                                                           */

extern unsigned char gSndState[];        /* @0x80147860 (data-materialization pass owns)   */
#define SND  ((SndState *)gSndState)

/* ---- SND runtime helpers shared across SNDPSXZ objs (permissive; real sigs in each .cpp) ---- */
int  iSNDvalidbank(int bank);             /* nonzero == invalid */
int  iSNDbankremovepat(int bank, int idx, void *scratch);
int  SNDstop(int handle);
void iSNDplatformfree(void *p);
int  SNDbankremove(int bank);
/* critical section + voice iteration + SPU pokes */
void iSNDenteraudio(void);                /* @0x800EA534 lock   */
void iSNDleaveaudio(void);                /* @0x800EA56C unlock */
int  iSNDgetchan(int handle);             /* @0x800EE9D4 channel index from handle (<0 if none) */
int  iSNDpatchkey(int chan, int *iter);   /* @0x800EF35C iterate voices of a chan; 0 when done  */
void iSNDplatform3dpos(int voice, int pan, int z);  /* @0x800EEE30 */
void iSNDcalcvol(int voice);              /* @0x800EF050 */
void iSNDvol(int voice, int vol);         /* @0x800F00F8 */
/* fx/reverb bus */
int  iSNDplatformfxinit(int bus, int type, int depth, int delay);  /* @0x800F0584 */
int  iSNDplatformfxmasterlevel(int bus, int level);                /* @0x800F05BC */
int  SNDfxlevel(int handle, int bus, int level);                   /* @0x800F05E8 */
int  SNDfxmasterlevel(int bus, int level);                         /* @0x800E6DD0 */

#ifdef __cplusplus
}
#endif
#endif /* LIB_SND_H */
