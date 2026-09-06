/* game/common/object.h — reconstructed from game/common/object.cpp, game/common/object.h (37 fns) */
#ifndef _GAME_COMMON_OBJECT_H_
#define _GAME_COMMON_OBJECT_H_
#include "object_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

int CalcObjYawAngle(CCOORD16 *pts);   /* :69 */
void CalcObjExtentPoints(coorddef *cp,CCOORD16 *pts,coorddef *resultPts,tQuat *quat);   /* :78 */
void BuildObjCollisionMatrix(int weight,int objAngle,int impactAngle,matrixtdef *mat);   /* :121 */
Trk_SimpleInst * FindObjInstanceFromSerialNum(Group *group,int index);   /* :144 */
void Object_InitCollisionCheckLoop(BWorldSm_Pos *slicePos,Object_tSimObjList *objList,int *numObj);   /* :190 */
Trk_SimObject * GetSimObj(int objIndex,Object_tSimObjList *objList,int *chunk);   /* :256 */
int Object_GetRadiusCollisionData(Object_tSimObjList *objList,int objIndex,coorddef *pos,int *radius);   /* :304 */
void Object_GetPointsCollisionData(Object_tSimObjList *objList,int objIndex,int *numPoints,coorddef *resultPoints);   /* :336 */
void Object_InitStatus(void);   /* :398 */
void Object_KillStatus(void);   /* :408 */
ObjectAnim * Object_GetAnim(Trk_SimObject *simObj);   /* :427 */
int Object_CheckCollisionResults(Object_tSimObjList *objList,int objIndex,BO_tNewtonObj *N);   /* :455 */
void Object_InitCustomObjects(void);   /* :581 */
void Object_DeInitCustomObjects(void);   /* :600 */
void Object_ClearCustomObjects(void);   /* :616 */
void SetCautionSurface(coorddef *pt,BWorldSm_Pos *slicePos);   /* :648 */
int Object_AddCustomSimObject(SceneElem *objectData,int serialNum,int instIndex);   /* :668 */
int Object_GetObjDefID(int index);   /* :785 */
int Object_FindDefWithThisID(int ID);   /* :794 */
void Object_AddCustomObject(SceneElem *objectData,int setupSimDataFlag);   /* :808 */
void GetObjMaxDimensions(Trk_ObjectDef **pObjDefs,Trk_SimpleInst *objInstance,coorddef *dimensions);   /* :1011 */
void Object_InitIMassObjectInfo(void);   /* :1055 */
void Object_DeInitIMassObjectInfo(void);   /* :1093 */
int Object_GetNumIMassObjects(void);   /* :1101 */
void Object_GetIMassObjectDimensions(int objIndex,coorddef *dimensions);   /* :1108 */
void Object_GetIMassObjectMotion(int objIndex,coorddef *cpoint,matrixtdef *orientMat,coorddef *velocity);   /* :1117 */

/* ---- header-defined (inline / class) functions ---- */
void ___10ObjectAnim(ObjectAnim *self, int __in_chrg);   /* :53 */
extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim *self, int __in_chrg);   /* :61 */
extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim *self, int __in_chrg);   /* :84 */
extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim *self, int __in_chrg);   /* :101 */
extern "C" void ___14ObjectSignAnim(ObjectSignAnim *self, int __in_chrg);   /* :124 */

#endif /* _GAME_COMMON_OBJECT_H_ */
