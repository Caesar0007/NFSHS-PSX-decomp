/* physics_externs.h -- extern decls for game/common/physics.cpp (NFS4 car physics engine).
 *   This declares cross-TU globals/functions + this TU's own
 *   physics.obj state (extern for syntax-check). Data tables are materialized in physics.cpp.
 */
#ifndef PHYSICS_EXTERNS_H
#define PHYSICS_EXTERNS_H

extern void trap(int code);   /* gcc MIPS div/overflow break helper */

/* ---- cross-TU globals ---- */
extern int                GameSetup_gData[247];
#define PHYSICS_RACE_TYPE GameSetup_gData[0]
#define PHYSICS_SGGE GameSetup_gData[14]
#define PHYSICS_TRACK GameSetup_gData[15]
#define PHYSICS_WEATHER GameSetup_gData[18]
/* Retail car rows are 180 bytes; N.damage[113] is an existing graph-visible
 * int component at aggregate offset 988, the real Transmission field. */
#define PHYSICS_CAR_ROW(index) \
    ((Car_tObj *)((char *)GameSetup_gData + (index) * 180))
#define PHYSICS_TRANSMISSION_AT(index) (PHYSICS_CAR_ROW(index)->N.damage[113])
extern int                simGlobal[2];
#define PHYSICS_GAME_TICKS simGlobal[1]
extern int                AITune_driveSide;
extern int                AIInit_forceHumanHandBrake;
/* Trk_NewSlice is externally owned and body-opaque in physics.obj. */
extern int              (*BWorldSm_slices)[8];
#define PHYSICS_SLICE_ADDR(index) (BWorldSm_slices + (index))
#define PHYSICS_SLICE_CENTER(index, axis) (BWorldSm_slices[(index)][axis])
#define PHYSICS_SLICE_RIGHT(index, axis) \
    (((signed char *)BWorldSm_slices[(index)])[18 + (axis)])
#define PHYSICS_SLICE_LEFT_DRIVE(index) (((short *)BWorldSm_slices[(index)])[12])
#define PHYSICS_SLICE_RIGHT_DRIVE(index) (((short *)BWorldSm_slices[(index)])[13])
#define PHYSICS_SLICE_WIDTH_LF(index) (((u_char *)BWorldSm_slices[(index)])[30])
#define PHYSICS_SLICE_WIDTH_RT(index) (((u_char *)BWorldSm_slices[(index)])[31])
extern int                gNumSlices;
extern Car_tObj          *Cars_gHumanRaceCarList[9];
extern int                Cars_gNumHumanRaceCars;
extern u_int              fastRandom, randSeed, randtemp;   /* fastrand.obj PRNG state */

/* ---- cross-TU functions ---- */
extern void  Math_NormalizeVector(coorddef *v);
extern void  Math_ResolveRotatedVector(int x, int z, int angle, int *outx, int *outz);
extern void  Collide_TestWithPlane(BO_tNewtonObj *n, coorddef *normal, coorddef *pos);
extern void  Force_HitWall(int impulse);
extern int   Force_IsForceOn(Car_tObj *car);
extern int   AIWorld_IsDriveableLane(int slice, int lane);
extern int   AIWorld_IsDriveableLaneInSliceRange(int slice, int lookAhead, int rsControl, int dir);
extern void  Cars_DoGravityEffectsOnAcc(Car_tObj *car, int n);
extern int   Udff_GetInt(Udff_tInfo *handle);
extern bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern "C" int fixedmult(int a, int b);
extern "C" int fixeddiv(int a, int b);

/* ---- physics.obj-owned state (SYM Globals) ---- */
extern int      roadSurfaceFrictionCoeff[10];
extern int      ReverseRoadSurfaceFrictionCoeff[10];
extern char     roadSurfaceIndex[3][20];
extern int      gripLossTable[3];
extern int      gripLossTableWet[3];
extern coorddef gravity_ch;
extern int      gBrakeRatio, gGasRatio, gSteerRatio;
extern int      exceedRedline;
extern int      roadMult, frontMult, rearMult, leftMult, rightMult;
extern int      slippery, steeringControl, powerControl;
/* blip/bblip init source tables @ 0x80056370/0x80056390 (materialized in physics.cpp; image-verified) */
extern int      physics_blipInit[8];
extern int      physics_bblipInit[8];

#endif
