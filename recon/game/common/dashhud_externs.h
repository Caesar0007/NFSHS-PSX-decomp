/* dashhud_externs.h -- cross-TU decls for game/common/dashhud.cpp (NFS4 dash HUD). */
#ifndef DASHHUD_EXTERNS_H
#define DASHHUD_EXTERNS_H

extern void Cars_GetDashData(Car_tObj *car, int *out0, int *out1, int *out2);      /* cars.obj  (N21 = int* x2, 0-based back-ref; args 1-3 all -> &DashHUD_gInfo fields) */
extern void Cars_InitDashData(Car_tObj *car, int *a, int *b);                       /* cars.obj */
extern int  Stats_GetPosition(Car_tObj *car);                                       /* stats.obj */
extern int  Stats_GetNumOpponents(void);                                            /* stats.obj */
extern void HudPmx_InitTextures(void);                                              /* hudpmx.obj */
extern void Hud_Init0(void);                                                        /* hud.obj */
extern void Hud_Init(void);                                                         /* hud.obj */
extern void Hud_Kill(void);                                                         /* hud.obj */
extern void Hud_PositionMap(void);                                                  /* hud.obj */

/* ---- cross-TU globals ---- */
/* GameSetup_tData is absent from dashHUD.obj's retail type graph.  The exact
 * shared Car_tObj graph nevertheless provides a real int-array component at
 * +536; over-indexing N.damage to 139/140 gives the retail aggregate
 * 1092/1096 HudSpeed pair while preserving the 180-byte car-row induction. */
extern int               GameSetup_gData[274];       /* gmesetup.obj */
#define DASHHUD_RACE_TYPE GameSetup_gData[0]
#define DASHHUD_NUM_LAPS GameSetup_gData[1]
#define DASHHUD_COMMMODE GameSetup_gData[3]
#define DASHHUD_CHECKPOINT_TYPE GameSetup_gData[47]
#define DASHHUD_BEST_LAP GameSetup_gData[58]
#define DASHHUD_CAR_ROW(index) \
    ((Car_tObj *)((char *)GameSetup_gData + (index) * 180))
#define DASHHUD_HUD_SPEED(index) (DASHHUD_CAR_ROW(index)->N.damage[139])
#define DASHHUD_HUD_SPEED_MULT(index) (DASHHUD_CAR_ROW(index)->N.damage[140])
extern int               Replay_ReplayMode;          /* replay.obj */
extern int               Camera_gInfo[];             /* camera.obj */
#define DASHHUD_CAMERA_ANCHOR(player) \
    (*(BO_tNewtonObj **)((char *)Camera_gInfo + (player) * 272))
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern int               simGlobal[2];               /* sim.obj */
#define DASHHUD_GAME_TICKS simGlobal[1]

#endif /* DASHHUD_EXTERNS_H */
