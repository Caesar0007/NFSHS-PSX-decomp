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
/* scene.obj's SYM omits the externally owned GameSetup body. */
struct GameSetup_tData;
extern GameSetup_tData GameSetup_gData;
/* Owner SYM: track INT@60; caller aggregate body remains opaque. */
#define SCENE_TRACK (*(int *)((char *)&GameSetup_gData + 60))

/* ---- eaclib EACPSXZ: memstd / syncfile / nsync / fixed-point ---- */

/* ---- syslib libc ---- */
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_math.h"
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/eac_file.h"
}
extern "C" int sprintf(...);

#endif
