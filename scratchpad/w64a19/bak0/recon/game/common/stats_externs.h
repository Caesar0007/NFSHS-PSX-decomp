#include "../../lib/libfns.h"
/* stats_externs.h -- extern decls for game/psx/stats.cpp (NFS4 PSX race statistics). */
#ifndef STATS_EXTERNS_H
#define STATS_EXTERNS_H

extern void trap(int);  /* MIPS break (gcc div-guard) */

/* ---- libc + harvested + SYM ---- */
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * Cars_gHumanRaceCarList[2];
extern GameSetup_tData   GameSetup_gData;
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern Sim_tSimSystemVar simVar;
extern int                gNumSlices;            /* 0x8013c7c8 */
extern int               Cars_gNumRaceCars;
extern int Cars_gNumHumanRaceCars;
extern int Input_Interface(unsigned long, int);

extern Stats_tPosition Stats_racePosition[6];   /* [i].car/slice/sliceTime/isHuman */
extern Car_tObj *Cars_gAIRaceCarList[9];
extern int   Cars_gNumAIRaceCars;
extern int   Cars_topSpeedCap[22];              /* [carType] */
extern int   CopSpeak_gQueueHead;
extern int   CopSpeak_gQueuePlay;
extern int   CopSpeak_gSpchHandle;

#endif
