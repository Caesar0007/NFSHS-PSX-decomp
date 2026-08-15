/* game/common/object.h — reconstructed from game/common/object.cpp, game/common/object.h (37 fns) */
#ifndef _GAME_COMMON_OBJECT_H_
#define _GAME_COMMON_OBJECT_H_
#include "../../nfs4_types.h"

int CalcObjYawAngle__FP8CCOORD16(CCOORD16 *pts);   /* :69 */
void CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat(coorddef *cp, CCOORD16 *pts, coorddef *resultPts, tQuat *quat);   /* :78 */
void BuildObjCollisionMatrix__FiiiP10matrixtdef(int weight, int objAngle, int impactAngle, matrixtdef *mat);   /* :121 */
void * FindObjInstanceFromSerialNum__FP5Groupi(Group *group, int index);   /* :144 */
void Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi(BWorldSm_Pos *slicePos, Object_tSimObjList *objList, int *numObj);   /* :190 */
void * GetSimObj__FiP18Object_tSimObjListPi(int objIndex, Object_tSimObjList *objList, int *chunk);   /* :256 */
int Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi(Object_tSimObjList *objList, int objIndex, coorddef *pos, int *radius);   /* :304 */
void Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef(Object_tSimObjList *objList, int objIndex, int *numPoints, coorddef *resultPoints);   /* :336 */
void Object_InitStatus__Fv(void);   /* :398 */
void Object_KillStatus__Fv(void);   /* :408 */
void * Object_GetAnim__FP13Trk_SimObject(Trk_SimObject *simObj);   /* :427 */
int Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj(Object_tSimObjList *objList, int objIndex, BO_tNewtonObj *N);   /* :455 */
void Object_InitCustomObjects__Fv(void);   /* :581 */
void Object_DeInitCustomObjects__Fv(void);   /* :600 */
void Object_ClearCustomObjects__Fv(void);   /* :616 */
void SetCautionSurface__FP8coorddefP12BWorldSm_Pos(coorddef *pt, BWorldSm_Pos *slicePos);   /* :648 */
int Object_AddCustomSimObject__FP9SceneElemii(SceneElem *objectData, int serialNum, int instIndex);   /* :668 */
int Object_GetObjDefID__Fi(int index);   /* :785 */
int Object_FindDefWithThisID__Fi(int ID);   /* :794 */
void Object_AddCustomObject__FP9SceneElemi(SceneElem *objectData, int setupSimDataFlag);   /* :808 */
void GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef(Trk_ObjectDef **pObjDefs, Trk_SimpleInst *objInstance, coorddef *dimensions);   /* :1011 */
void Object_InitIMassObjectInfo__Fv(void);   /* :1055 */
void Object_DeInitIMassObjectInfo__Fv(void);   /* :1093 */
int Object_GetNumIMassObjects__Fv(void);   /* :1101 */
void Object_GetIMassObjectDimensions__FiP8coorddef(int objIndex, coorddef *dimensions);   /* :1108 */
void Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1(int objIndex, coorddef *cpoint, matrixtdef *orientMat, coorddef *velocity);   /* :1117 */
int Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei(ObjectFinishedMultiAnim *self, DRender_tView *Vi, Draw_DCache *sd, int offset);   /* :1160 */
void * __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim(ObjectMultiAnim *self, coorddef *impactVel, AnimDef *def, Trk_CollideBoomInst *objCollideInstance, Trk_ObjectDef *objDef, Trk_SimObject *simObj, ObjectFinishedMultiAnim *finishedAnim);   /* :1165 */
int Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei(ObjectMultiAnim *self, DRender_tView *Vi, Draw_DCache *sd, int offset);   /* :1188 */
int Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei(ObjectFinishedSignAnim *self, DRender_tView *Vi, Draw_DCache *sd, int offset);   /* :1302 */
void * __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim(ObjectSignAnim *self, coorddef *impactVel, int impactAngle, AnimDef *def, Trk_CollideBoomInst *objCollideInstance, Trk_ObjectDef *objDef, Trk_SimObject *simObj, coorddef *roadNormal, ObjectFinishedSignAnim *finishedAnim);   /* :1308 */
int Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei(ObjectSignAnim *self, DRender_tView *Vi, Draw_DCache *sd, int offset);   /* :1360 */

/* ---- header-defined (inline / class) functions ---- */
void ___10ObjectAnim(ObjectAnim *self, int __in_chrg);   /* :53 */
extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim *self, int __in_chrg);   /* :61 */
extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim *self, int __in_chrg);   /* :84 */
extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim *self, int __in_chrg);   /* :101 */
extern "C" void ___14ObjectSignAnim(ObjectSignAnim *self, int __in_chrg);   /* :124 */

#endif /* _GAME_COMMON_OBJECT_H_ */
