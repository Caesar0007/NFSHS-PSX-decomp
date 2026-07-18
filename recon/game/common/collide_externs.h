/* game/common/collide_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_COLLIDE_EXTERNS_H_
#define _GAME_COMMON_COLLIDE_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals (cross-TU) ---- */
extern int            Cars_gNumCars;
extern Trk_NewSlice  *BWorldSm_slices;
extern BO_tNewtonObj  InfiniteMassNewton[5];   /* @0x801100e4 EXT BO_tNewtonObj[5] */
extern coorddef       D_80055A00;   /* @0x80055A00 rodata up-vector {0,0x10000,0} (DoObjectFixedObjectCollision upVec source; Ghidra const-folded it) */

/* ---- PsyQ / eaclib math ---- */

/* ---- MathNfs.obj ---- */
void Math_NormalizeShortVector(coorddef *v);
void Math_NormalizeVector(coorddef *v);
int  Math_DistXZ(coorddef *a, coorddef *b);
int  Math_VectorLength(coorddef *v);
int  Math_VectorLength2(coorddef *v);

/* ---- Newton.obj ---- */
void Newton_AddDamageZone(BO_tNewtonObj *newtonObj, int impulse, int zone, int type);
void Newton_DoPostBarrierCollisionHandling(BO_tNewtonObj *newtonObj, coorddef normal);
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj);

/* ---- Object.obj ---- */
void Object_InitCollisionCheckLoop(BWorldSm_Pos *slicePos, Object_tSimObjList *objList, int *numObj);
int  Object_GetRadiusCollisionData(Object_tSimObjList *objList, int objIndex, coorddef *pos, int *radius);
void Object_GetPointsCollisionData(Object_tSimObjList *objList, int objIndex, int *numPoints, coorddef *resultPoints);
void Object_GetIMassObjectMotion(int objIndex, coorddef *cpoint, matrixtdef *orientMat, coorddef *velocity);
int  Object_CheckCollisionResults(Object_tSimObjList *objList, int objIndex, BO_tNewtonObj *N);
int  Object_GetNumIMassObjects(void);

/* ---- Physics.obj / Force.obj / BWorldSm.obj ---- */
void Physics_TestForBarrierCollision(Car_tObj *carObj);
int  Force_IsForceOn(Car_tObj *car);
void Force_HitSign(Car_tObj *car);
int  BWorldSm_FindClosestSlice(coorddef *pt, BWorldSm_Pos *slicePos);

#endif /* _GAME_COMMON_COLLIDE_EXTERNS_H_ */
