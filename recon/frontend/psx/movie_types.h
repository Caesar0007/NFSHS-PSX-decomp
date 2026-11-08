/* Movie.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_FRONTEND_PSX_MOVIE_TYPES_H
#define NFS4_FRONTEND_PSX_MOVIE_TYPES_H

#ifndef NFS4_FE_COLOR_LATE   /* Movie.obj contains color.obj's complete 71-record game/platform graph. */
#include "../../game/common/color_types.h"
#endif
#include "movie_cd_early.h"









#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
















#include "shared/kernpair.h"




typedef struct kernpair kernpair;
typedef struct kernpair KERN;

typedef struct {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
} SNDSYSCAP;

typedef struct {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax;
    u_char use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
} SNDSYSSET;

typedef struct {
    int (*issurfacelocked)(void);
} SNDSYSVEC;

typedef struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
} SNDSAMPLEFORMAT;


















typedef void (*CdlCB)(u_char intr, u_char *result); /* PsyQ 4.3 <libcd.h> */
typedef u_short DECDCTTAB[34816];
typedef void (*fontblit)(void);
typedef int (*getcode)(void);
typedef void (*fontblitbegin)(void);
typedef void (*fontblitend)(void);
typedef void (*adjustchar)(void);
typedef void (*CallbackFunc)(void);

#endif
