#include "../../lib/libfns.h"
/* scene_externs.h -- extern decls for game/psx/scene.cpp
 *   (NFS4 PSX scene loader: loads trNNVV.scn custom-object scenes from the scene.viv bigfile,
 *    builds the custom-object list, and a plane-Y geometry helper). */
#ifndef SCENE_EXTERNS_H
#define SCENE_EXTERNS_H

/* ---- module globals ---- */
extern CSceneList *gGameSceneList;          /* 0x8013d408 */
extern int         Object_customSliceNum;   /* 0x8013d2d4 */

/* ---- object pool (object.cpp) ---- */
extern void Object_ClearCustomObjects(void);
extern void Object_AddCustomObject(SceneElem *elem, int setupSimDataFlag);

/* ---- paths + setup ---- */
extern char           *Paths_Paths[];        /* 0x80116468 */
extern GameSetup_tData GameSetup_gData;

/* ---- eaclib EACPSXZ: memstd / syncfile / nsync / fixed-point ---- */

/* ---- syslib libc ---- */

#endif
