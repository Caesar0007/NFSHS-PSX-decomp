/* game/common/scene.h — reconstructed from game/common/scene.cpp (6 fns) */
#ifndef _GAME_COMMON_SCENE_H_
#define _GAME_COMMON_SCENE_H_
#include "../../nfs4_types.h"

void Scene_Init__Fi(int numObjDefs);   /* :1013 */
void Scene_DeInit__Fv(void);   /* :1029 */
void Scene_PurgeScene__Fv(void);   /* :1040 */
int Scene_BuildCustomSceneList__Fv(void);   /* :1059 */
void Scene_LoadSceneFile__Fi(int sceneFileIndex);   /* :1111 */
int GetPlaneY__FPC8coorddefN20(coorddef *norm, coorddef *pointOnPlane, coorddef *testPoint);   /* :1142 */

#endif /* _GAME_COMMON_SCENE_H_ */
