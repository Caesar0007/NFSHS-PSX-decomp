/* game/common/scene.h — reconstructed from game/common/scene.cpp (6 fns) */
#ifndef _GAME_COMMON_SCENE_H_
#define _GAME_COMMON_SCENE_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void Scene_Init(int numObjDefs);   /* :1013 */
void Scene_DeInit(void);   /* :1029 */
void Scene_PurgeScene(void);   /* :1040 */
int Scene_BuildCustomSceneList(void);   /* :1059 */
void Scene_LoadSceneFile(int sceneFileIndex);   /* :1111 */
int GetPlaneY(const coorddef *norm,const coorddef *pointOnPlane,const coorddef *testPoint);   /* :1142 */

#endif /* _GAME_COMMON_SCENE_H_ */
