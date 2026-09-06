/* game/common/newton.h — reconstructed from game/common/newton.cpp (32 fns) */
#ifndef _GAME_COMMON_NEWTON_H_
#define _GAME_COMMON_NEWTON_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Newton_AddDamageZone(BO_tNewtonObj *newtonObj,int impulse,int zone,int type);   /* :50 */
void Newton_FindClosestQuad(BO_tNewtonObj *n);   /* :221 */
int Newton_CalculateSliceYaw(int slice);   /* :235 */
void Newton_UpdateRoadGeometry(BO_tNewtonObj *n);   /* :248 */
int Newton_FindGroundElevationGeneral(coorddef *point,coorddef *normal,coorddef *pointOnQuad);   /* :445 */
int Newton_FindGroundElevationRough(coorddef *point,coorddef *normal,coorddef *pointOnQuad);   /* :475 */
int Newton_FindGroundElevationAndNormalFast(BO_tNewtonObj *newtonObj, coorddef *normal) asm("Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef");   /* :515 */
int Newton_FindGroundElevationAndNormal(BO_tNewtonObj *newtonObj,coorddef *normal);   /* :610 */
void Newton_LimitCarsToDrivableDist(BO_tNewtonObj *newtonObj);   /* :1062 */
int Newton_CalcPerpenHeightOfLowestPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);   /* :1079 */
int Newton_CalcPerpenHeightOfCenterPointFromGround(BO_tNewtonObj *newtonObj,coorddef *normal,coorddef *samplePoint);   /* :1110 */
void Newton_CalcDistToClosestPlayerCar(BO_tNewtonObj *n);   /* :1123 */
void Newton_UpdateRoadInfo(BO_tNewtonObj *n);   /* :1227 */
void Newton_CopyRoadMatrixToOrientMat(BO_tNewtonObj *n,int backwards);   /* :1264 */
void Newton_CopyRoadMatrixToShadowMat(BO_tNewtonObj *n,int backwards);   /* :1285 */
void Newton_SetInitialSlicePositionOrientationEtc(BO_tNewtonObj *n,int slice,coorddef *offset,int direction);   /* :1307 */
void Newton_InitBaseNewtonObj(BO_tNewtonObj *newtonObj, int index, int mass, int moInertia, int dimX, int dimY, int dimZ) asm("Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii");   /* :1420 */
void Newton_QDUpdateVel(BO_tNewtonObj *newtonObj) asm("Newton_QDUpdateVel__FP13BO_tNewtonObj");   /* :1516 */
int Newton_OptzRotxform(matrixtdef *m, int ax, int ay, int az, int *reOrthoNeeded, int reOrthoLimit, int *cumulatedRot) asm("Newton_OptzRotxform__FP10matrixtdefiiiPiiT4");   /* :1569 */
void Newton_QDUpdateRot64Hz(BO_tNewtonObj *newtonObj) asm("Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj");   /* :1621 */
void Newton_QDUpdateRot32Hz(BO_tNewtonObj *newtonObj) asm("Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj");   /* :1670 */
void Newton_CalculateGroundShadowMatrix(BO_tNewtonObj *newtonObj, coorddef *normal, int orientToGround) asm("Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi");   /* :1730 */
void Newton_CalcRealShadowCoordinates(Car_tObj *carObj, int currentTick) asm("Newton_CalcRealShadowCoordinates__FP8Car_tObji");   /* :1830 */
void Newton_CheckForSpikeBelts(BO_tNewtonObj *newtonObj) asm("Newton_CheckForSpikeBelts__FP13BO_tNewtonObj");   /* :1885 */
void Newton_DoPostBarrierCollisionHandling(BO_tNewtonObj *newtonObj, coorddef normal) asm("Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef");   /* :1922 */
void Newton_GenerateVector(int type, coorddef *vector, BWorldSm_Pos *testSimRoadInfo) asm("Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos");   /* :2107 */
int Netwon_CheckForBadQuad(BO_tNewtonObj *newtonObj, BWorldSm_Pos *testSimRoadInfo, int wheel) asm("Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi");   /* :2144 */
void Newton_TestForUndrivableSurfaces(BO_tNewtonObj *newtonObj);   /* :2161 */
void Newton_LimitAngularVelocity(BO_tNewtonObj *newtonObj) asm("Newton_LimitAngularVelocity__FP13BO_tNewtonObj");   /* :2440 */
void Newton_ApplyTheLawOfGravity(BO_tNewtonObj *newtonObj) asm("Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj");   /* :2466 */
int Newton_CalculateRoadPositionFromSliceAndPosition(int slice,coorddef *position,matrixtdef *matrix);   /* :2736 */
int Newton_CalculateRoadPosition(BO_tNewtonObj *newtonObj);   /* :2762 */

#endif /* _GAME_COMMON_NEWTON_H_ */
