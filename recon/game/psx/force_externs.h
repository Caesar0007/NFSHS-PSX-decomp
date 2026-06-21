#include "../../lib/libfns.h"
/* force_externs.h -- extern decls for game/psx/force.cpp (NFS4 PSX force-feedback / rumble).
 * Types from ../../nfs4_types.h (Force_tGlobal, Car_tObj, Sim_tSimGlobalVar, Sched_tSchedule, GameSetup_tData). */
#ifndef FORCE_EXTERNS_H
#define FORCE_EXTERNS_H

/* ---- force module state (SYM) ---- */
// [owned->defined in force.cpp] extern Force_tGlobal     Force_g[2];          /* 0x8011fd60  (16 bytes = 2 controllers) */
extern long              colourRGB[16];       /* 0x8011fd70  array-end sentinel for Force_g loops */
// [owned->defined in force.cpp] extern u_char            Force_rand_256[256]; /* 0x8011fc60  rumble noise/jitter LUT, idx (tick>>1)&0xff */
// [owned->defined in force.cpp] extern u_char            Force_gActAlign[6];  /* 0x8013d840 */
// [owned->defined in force.cpp] extern u_char            Force_gOffAlign[6];  /* 0x8013d848 */
// [owned->defined in force.cpp] extern u_short           Force_gTick;         /* 0x8013d84e */
// [owned->defined in force.cpp] extern long              Force_gVblHandle;    /* 0x8013d850 */

/* ---- shared game globals ---- */
extern Sim_tSimGlobalVar simGlobal;           /* 0x8011e0ac */
extern GameSetup_tData   GameSetup_gData;     /* 0x801131ec */
extern Car_tObj         *Cars_gHumanRaceCarList[9]; /* 0x8010fa48 (36 bytes) */
extern int               Replay_ReplayMode;   /* 0x8013d3f4 */

/* ---- PsyQ libpad (DualShock actuators) + libetc ---- */

/* ---- game scheduler + eaclib fixed-point ---- */
extern void  Sched_AddFunction(Sched_tSchedule *s, void (*fn)(void *), void *arg, int hz);

#endif
