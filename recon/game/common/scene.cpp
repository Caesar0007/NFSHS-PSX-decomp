/* game/psx/scene.cpp -- RECONSTRUCTED (NFS4 PSX scene/custom-object loader; C++ TU)
 *   6 fns: Scene_Init/DeInit/PurgeScene/BuildCustomSceneList/LoadSceneFile + GetPlaneY.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "scene_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
CSceneList *gGameSceneList;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Scene_Init(int numObjDefs);
void Scene_DeInit(void);
void Scene_PurgeScene(void);
int Scene_BuildCustomSceneList(void);
void Scene_LoadSceneFile(int sceneFileIndex);
int GetPlaneY(const coorddef *norm,const coorddef *pointOnPlane,const coorddef *testPoint);


/* ---- Scene_Init__Fi  [SCENE.CPP:1013-1015] SLD-VERIFIED ---- */
void Scene_Init(int numObjDefs)

{
  if (0 < numObjDefs) {
    gGameSceneList = (CSceneList *)0x0;
  }
  return;
}

/* ---- Scene_DeInit__Fv  [SCENE.CPP:1029-1030] SLD-VERIFIED ---- */
void Scene_DeInit(void)

{
  Scene_PurgeScene();
  return;
}

/* ---- Scene_PurgeScene__Fv  [SCENE.CPP:1040-1055] SLD-VERIFIED ---- */
void Scene_PurgeScene(void)

{
  if (gGameSceneList != (CSceneList *)0x0) {
    purgememadr(gGameSceneList);
    gGameSceneList = (CSceneList *)0x0;
  }
  Object_ClearCustomObjects();
  return;
}

/* ---- Scene_BuildCustomSceneList__Fv  [SCENE.CPP:1059-1107] SLD-VERIFIED ---- */
int Scene_BuildCustomSceneList(void)

{
  SceneElem *se;
  int i;
  int slice;
  
  Object_ClearCustomObjects();
  slice = -1;
  if (gGameSceneList != (CSceneList *)0x0) {
    se = (SceneElem *)(gGameSceneList + 1);
    slice = gGameSceneList->slice_;
    Object_customSliceNum = slice;
    for (i = 0; i < gGameSceneList->numElements_; se++, i++) {
      if (se->type < 3) {
        if (-1 < se->type) {
          Object_AddCustomObject(se,1);
        }
      }
    }
  }
  return slice;
}

/* ---- Scene_LoadSceneFile__Fi  [SCENE.CPP:1111-1137] SLD-VERIFIED ---- */
void Scene_LoadSceneFile(int sceneFileIndex)

{
  char fname [128];
  int bigFile;
  
  Object_ClearCustomObjects();
  bigFile = 0;
  sprintf(fname,"%sscene.viv",Paths_Paths[6]);
  FILE_addbigsync(fname,(void *)0x10,100,&bigFile);
  sprintf(fname,"tr%02d%02d.scn",GameSetup_gData.track,sceneFileIndex);
  gGameSceneList = (CSceneList *)0x0;
  gGameSceneList = (CSceneList *)loadfileadr(fname,0);
  FILE_delbigsync((char *)bigFile,(void *)0x64);
  return;
}

/* ---- GetPlaneY__FPC8coorddefN20  [SCENE.CPP:1142-1153] SLD-VERIFIED ---- */
int GetPlaneY(const coorddef *norm,const coorddef *pointOnPlane,const coorddef *testPoint)

{
  int D;

  D = -(fixedmult(norm->x,pointOnPlane->x) +
        fixedmult(norm->y,pointOnPlane->y) +
        fixedmult(norm->z,pointOnPlane->z));
  return fixeddiv(-(fixedmult(norm->x,testPoint->x) +
                    fixedmult(norm->z,testPoint->z) + D),norm->y);
}

/* end of scene.cpp */
