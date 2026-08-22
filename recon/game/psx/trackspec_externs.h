/* trackspec_externs.h -- externs referenced by trackspec.cpp (GAME/PSX/TRACKSPEC.CPP track-spec load) */
#ifndef TRACKSPEC_EXTERNS_H
#define TRACKSPEC_EXTERNS_H

/* GameSetup_tData is externally owned and absent from trackspec.obj's retail
 * type graph.  Retain the exact symbol and the three proven word offsets. */
extern int TrackSpec_GameSetupWords[] asm("GameSetup_gData");
extern CTrackSpec      TrackSpec_gSpec;          /* 0x8012327c */
extern int             TrackSpec_gPrevSpec;      /* 0x8013db90 */
extern int             TrackSpec_gCurrentSpec;   /* 0x8013db94 */
extern int             TrackSpec_gMaxSpec;       /* 0x8013db98 */
extern char           *Paths_Paths[50];          /* 0x80116468 */

extern "C" int sprintf(...);
extern "C" void *loadfileadr(...);
extern "C" int purgememadr(...);

/* track-spec selection table (weather*2+night -> spec index) @0x80056AD4: MATERIALIZED as the
 * local `int spec[4] = {0,1,2,3}` in TrackSpec_Load (rodata->stack aggregate copy; image-verified).
 * No extern needed -- this note kept only to explain where the .rodata blob went. */

#endif /* TRACKSPEC_EXTERNS_H */
