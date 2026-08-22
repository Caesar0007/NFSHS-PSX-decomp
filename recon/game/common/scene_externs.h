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
extern int GameSetup_gData[16];
#define SCENE_TRACK GameSetup_gData[15]

/* ---- eaclib EACPSXZ: memstd / syncfile / nsync / fixed-point ---- */

/* ---- syslib libc ---- */
extern "C" int purgememadr(...);
extern "C" int sprintf(...);
extern "C" int FILE_addbigsync(...);
extern "C" void FILE_delbigsync(...);
extern "C" void *loadfileadr(...);
extern "C" int fixedmult(...);
extern "C" int fixeddiv(...);

#endif
