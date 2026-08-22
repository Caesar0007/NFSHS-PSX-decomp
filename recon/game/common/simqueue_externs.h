/* simqueue_externs.h -- extern decls for game/psx/simqueue.cpp (NFS4 PSX sim input queue). */
#ifndef SIMQUEUE_EXTERNS_H
#define SIMQUEUE_EXTERNS_H

/* ---- harvested + SYM ---- */
/* simqueue.obj uses only words +0x0c and +0x3c8 of the external owner. */
extern int GameSetup_gData[243];
#define SIMQUEUE_COMMMODE GameSetup_gData[3]
#define SIMQUEUE_NUM_PLAYER_RACE_CARS GameSetup_gData[242]

extern int   gSimQueue_BlockOther;
extern int   gSimQueue_BlockSelf;
extern int   gSimQueue_Ticker;

#endif
