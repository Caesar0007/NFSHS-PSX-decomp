#include "../../lib/libfns.h"
/* newton_externs.h -- cross-TU declarations for game/common/newton.cpp (Newton physics integrator).
 * Harvested from sealed sibling *_externs.h (compile-proven) + SYM Demangled/Globals.
 * newton's OWN file-statics (divTable/fudgeTable/swap/testSimRoadInfo/newtestSimRoadInfo/dummy_124/
 * dummy_133) are declared `static` inside newton.cpp, NOT here. */
#ifndef NEWTON_EXTERNS_H
#define NEWTON_EXTERNS_H

/* ---- eaclib EACPSXZ fixed-point + matrix math ---- */
extern void  trap(int c);

/* ---- Math (MathNfs.obj) ---- */
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern int   Math_BetterDist(int dx, int dz);
extern void  Math_NormalizeShortVector(coorddef *v);

/* ---- BWorld / BWorldSm slice geometry ---- */
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int   BWorldSm_FindClosestTriangleRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int   BWorldSm_FindEdgeOff(coorddef *c, BWorldSm_Pos *a, BWorldSm_Pos *b, int *edge);
extern void  BWorldSm_SetSlice(int slice, BWorldSm_Pos *pos);
extern void *BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern void *BWorldSm_UNormal(BWorldSm_Pos *pos);
extern void *BWorldSm_UForward(BWorldSm_Pos *pos);
extern int   BWorld_CheckChunkVisible(BWorldSm_Pos *a, BWorldSm_Pos *b);
extern Trk_NewSlice  *BWorldSm_slices;
extern int            gNumSlices;

/* ---- Collide ---- */
extern int   Collide_TestWithPlane(void *n, coorddef *normal, coorddef *pos);

/* ---- Physics (physics.obj) ---- */
extern int   Physics_AttenuateVelocity(Car_tObj *car, int impulse, matrixtdef *m);
extern void  Physics_CorrectPostCollisionYaw(Car_tObj *car, int impulse, coorddef vec);
extern int   Physics_DoBarrierCheck(Car_tObj *car);
extern void  Physics_FixEngineRpm(Car_tObj *car);
extern void  Physics_SetCurrentWallType(int type);

/* ---- AI ---- */
extern void  AIPhysic_ProcessBarrierCollision(Car_tObj *car);
extern AICop_spikeBelt_t AICop_spikeBelt;

/* ---- Cars ---- */
extern void  Cars_SetCarUpForHiRezSim(Car_tObj *car);
extern Car_tObj *Cars_gHumanRaceCarList[];
extern int       Cars_gNumHumanRaceCars;

/* ---- Force feedback ---- */
extern void  Force_HitWall(int impulse);
extern int   Force_IsForceOn(Car_tObj *car);

/* ---- Scheduler ---- */
extern int   Sched_ExecuteCheck(int a, int b, int c, int d, int *e, int *f, char *g, int h);

/* ---- globals ---- */
extern GameSetup_tData     GameSetup_gData;
extern Sim_tSimGlobalVar   simGlobal;
extern u_int               fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */
extern int                 generic128HzClock, stackSpeedUpEnbabledFlag;
extern u_long              gWSavePtr;

#endif /* NEWTON_EXTERNS_H */
