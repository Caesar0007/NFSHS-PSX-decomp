/* stats_externs.h -- extern decls for game/common/stats.cpp (NFS4 PSX race statistics). */
#ifndef STATS_EXTERNS_H
#define STATS_EXTERNS_H

extern void trap(int);  /* MIPS break (gcc div-guard) */
extern "C" int rand(void);

/* ---- libc + harvested + SYM ---- */
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj * Cars_gHumanRaceCarList[9]; /* retail EXT: 36 bytes, dims 1 9 */
extern int GameSetup_gData[]; /* external owner word view; no guessed extent */
#define STATS_RACE_TYPE GameSetup_gData[0]
#define STATS_NUM_LAPS GameSetup_gData[1]
#define STATS_COMMMODE GameSetup_gData[3]
#define STATS_LOCAL_CAR GameSetup_gData[7]
#define STATS_CATCHUP_LOGIC GameSetup_gData[8]
#define STATS_REVERSE_TRACK GameSetup_gData[12]
#define STATS_CHECKPOINT_TYPE GameSetup_gData[47]
/* SOURCE-REVIEW-UNRESOLVED: owner sim.obj records Sim_tSimGlobalVar size24,
 * with INT gameTicks at +4. The canonical opaque declaration/reference
 * trial changes TrackEndGame by 74 differences at232/232 (2026-10-13),
 * for unsized/six-word signed and unsized unsigned reference views alike.
 * This preserved legacy view is not a claim of a two-word original object.
 * Recover its address/allocation graph before replacing the declaration. */
extern int simGlobal[2];
#define STATS_GAME_TICKS simGlobal[1]
/* Retail sim.obj records simVar as Sim_tSimSystemVar size28, with INT
 * endSimGame at +4; stats.obj emits no body for that type. An opaque
 * declaration plus word reference preserves both reads and writes and all
 * seven function bodies. Macro/cast spelling remains reconstruction
 * compatibility pending recovery of the original consumer header. */
struct Sim_tSimSystemVar;
extern Sim_tSimSystemVar simVar;
#define STATS_END_SIM_GAME ((int (&)[])simVar)[1]
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
