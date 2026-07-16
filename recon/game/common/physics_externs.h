#include "../../lib/libfns.h"
/* physics_externs.h -- extern decls for game/common/physics.cpp (NFS4 car physics engine).
 *   Types live in nfs4_types.h. This declares cross-TU globals/functions + this TU's own
 *   physics.obj state (extern for syntax-check). Data tables are materialized in physics.cpp.
 */
#ifndef PHYSICS_EXTERNS_H
#define PHYSICS_EXTERNS_H

extern void trap(int code);   /* gcc MIPS div/overflow break helper */

/* ---- cross-TU globals ---- */
extern GameSetup_tData    GameSetup_gData;
extern Sim_tSimGlobalVar  simGlobal;
extern int                AITune_driveSide;
extern int                AIInit_forceHumanHandBrake;
extern Trk_NewSlice      *BWorldSm_slices;
extern int                gNumSlices;
extern Car_tObj          *Cars_gHumanRaceCarList[9];
extern int                Cars_gNumHumanRaceCars;
extern u_int              fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */

/* ---- cross-TU functions ---- */
extern void  Math_NormalizeVector(coorddef *v);
extern void  Math_ResolveRotatedVector(int x, int z, int angle, int *outx, int *outz);
extern int   Collide_TestWithPlane(void *n, coorddef *normal, coorddef *pos);
extern void  Force_HitWall(int impulse);
extern int   Force_IsForceOn(Car_tObj *car);
extern int   AIWorld_IsDriveableLane(int slice, int lane);
extern int   AIWorld_IsDriveableLaneInSliceRange(int slice, int lookAhead, int rsControl, int dir);
extern void  Cars_DoGravityEffectsOnAcc(Car_tObj *car, int n);
extern int   Udff_GetInt(Udff_tInfo *handle);
extern void *BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);

/* ---- physics.obj-owned state (SYM Globals) ---- */
extern int      roadSurfaceFrictionCoeff[10];
extern int      ReverseRoadSurfaceFrictionCoeff[10];
extern char     roadSurfaceIndex[3][20];
extern int      gripLossTable[3];
extern int      gripLossTableWet[3];
extern coorddef gravity_ch;
extern int      gBrakeRatio, gGasRatio, gSteerRatio;
extern int      currentWallType, exceedRedline;
extern int      roadMult, frontMult, rearMult, leftMult, rightMult;
extern int      slippery, steeringControl, powerControl;
/* blip/bblip init source tables @ 0x80056370/0x80056390 (materialized in physics.cpp; image-verified) */
extern int      physics_blipInit[8];
extern int      physics_bblipInit[8];

#endif
