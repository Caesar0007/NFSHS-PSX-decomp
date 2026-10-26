#ifndef _SNDPSXZ_SSYSINIT_H_
#define _SNDPSXZ_SSYSINIT_H_

typedef struct SNDSYSCAP {
    unsigned short outputratemin;
    unsigned short outputratemax;
    unsigned char outputchannelsmin;
    unsigned char outputchannelsmax;
    unsigned char inputvoicesmax;
    unsigned char input3dvoicesmax;
    unsigned char eax;
    unsigned char voicemanager;
    char pad[2];
} SNDSYSCAP;
typedef char SNDSYSCAP_size_check[(sizeof(SNDSYSCAP) == 0x0C) ? 1 : -1];

typedef struct SNDSYSSET {
    unsigned short maxbanks;
    unsigned short outputrate;
    unsigned char outputchannels;
    unsigned char inputvoices;
    unsigned char useeax;
    unsigned char use3dacceleration;
    unsigned char use3dmixing;
    char pad;
    unsigned short emulationsubtype;
    unsigned short spkrcfg3d[4][4];
} SNDSYSSET;
typedef char SNDSYSSET_size_check[(sizeof(SNDSYSSET) == 0x2C) ? 1 : -1];

typedef struct SNDSYSVEC {
    int (*issurfacelocked)(void);
} SNDSYSVEC;

typedef struct SNDSYSOPTS {
    SNDSYSCAP cap;
    SNDSYSSET set;
    SNDSYSVEC vec;
} SNDSYSOPTS;
typedef char SNDSYSOPTS_size_check[(sizeof(SNDSYSOPTS) == 0x3C) ? 1 : -1];

extern int SNDSYS_getopts(SNDSYSOPTS *opts); /* @0x800F1D58 */
extern int SNDSYS_setopts(SNDSYSOPTS *opts); /* @0x800F1E14 */
extern int SNDSYS_init(void *membase, int memsize); /* @0x800F1F10 */
extern int SNDSYS_restore(void); /* ssysinit exit handler; @0x800F204C */

extern int DAT_80134a68[]; /* output-caps flag; owned by snddata.c (unsized view preserves absolute addressing) */

#endif /* _SNDPSXZ_SSYSINIT_H_ */
