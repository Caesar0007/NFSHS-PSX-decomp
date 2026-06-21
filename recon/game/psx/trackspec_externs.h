#include "../../lib/libfns.h"
/* trackspec_externs.h -- externs referenced by trackspec.cpp (GAME/PSX/TRACKSPEC.CPP track-spec load) */
#ifndef TRACKSPEC_EXTERNS_H
#define TRACKSPEC_EXTERNS_H

extern GameSetup_tData GameSetup_gData;          /* 0x801131ec */
extern CTrackSpec      TrackSpec_gSpec;          /* 0x8012327c */
extern int             TrackSpec_gPrevSpec;      /* 0x8013db90 */
extern int             TrackSpec_gCurrentSpec;   /* 0x8013db94 */
extern int             TrackSpec_gMaxSpec;       /* 0x8013db98 */
extern char           *Paths_Paths[50];          /* 0x80116468 */

   /* syslib libc */
          /* eaclib EACPSXZ nsync */
                       /* eaclib EACPSXZ memstd */

/* track-spec selection table (weather*2+night -> spec index); .rodata blob, carried as extern
 * pending the global _DAT_ materialization pass (task #75) */

#endif /* TRACKSPEC_EXTERNS_H */
