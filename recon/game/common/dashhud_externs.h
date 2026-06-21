/* dashhud_externs.h -- cross-TU decls for game/common/dashhud.cpp (NFS4 dash HUD).
 *   Types (Car_tObj, dashhud_info) live in nfs4_types.h. dashhud OWNS resethud + DashHUD_gInfo (.cpp). */
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
extern GameSetup_tData   GameSetup_gData;            /* gmesetup.obj */
extern int               Replay_ReplayMode;          /* replay.obj */
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern Car_tObj         *Cars_gHumanRaceCarList[9];  /* cars.obj */
extern Sim_tSimGlobalVar simGlobal;                  /* sim.obj */

#endif /* DASHHUD_EXTERNS_H */
