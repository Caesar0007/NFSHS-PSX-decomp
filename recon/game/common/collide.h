/* game/common/collide.h — reconstructed from game/common/collide.cpp (14 fns) */
#ifndef _GAME_COMMON_COLLIDE_H_
#define _GAME_COMMON_COLLIDE_H_
#include "../../nfs4_types.h"

/* P874: source names; C++ supplies the native GCC-v2 linkage mangling. */

int CHECK_CENTER_VERTEX_WITH_DIRS(int X_DIR, int Y_DIR, int Z_DIR);   /* :100 */
int CHECK_CENTER_VERTEX_WITH_DIRS_OTHER(int X_DIR, int Y_DIR, int Z_DIR);   /* :131 */
int CHECK_VERTEX_WITH_DIRS(int X_DIR, int Y_DIR, int Z_DIR);   /* :161 */
int CHECK_VERTEX_WITH_DIRS_OTHER(int X_DIR, int Y_DIR, int Z_DIR);   /* :187 */
void Collide_DoObjectFixedObjectCollision(BO_tNewtonObj *o, coorddef *p, coorddef *v, coorddef *n);   /* :230 */
void Collide_LimitAngularVel(BO_tNewtonObj *o);   /* :394 */
void Collide_TestWithPlane(BO_tNewtonObj *o, coorddef *normal, coorddef *samplePoint);   /* :418 */
int Collide_DoObjectObjectCollision(BO_tNewtonObj *o0, BO_tNewtonObj *o1, coorddef *p, coorddef *normal);   /* :554 */
int Collide_DoActualObjectCollisionCheck(BO_tNewtonObj *o0, BO_tNewtonObj *o1, coorddef *p, coorddef *normal);   /* :762 */
int Collide_TestObjectVertices(BO_tNewtonObj *o0, BO_tNewtonObj *o1, coorddef *p, coorddef *normal);   /* :1039 */
int Collide_CheckForCollisionBetween(BO_tNewtonObj *o0, BO_tNewtonObj *o1);   /* :1365 */
void Collide_ClearCollisionRegistry(void);   /* :1424 */
int Collide_CheckAccuratePointRadiusCollision(BO_tNewtonObj *newObj, coorddef *point, int radius);   /* :1478 */
void Collide_CheckMeForCollisions(BO_tNewtonObj *newObj);   /* :1501 */

#endif /* _GAME_COMMON_COLLIDE_H_ */
