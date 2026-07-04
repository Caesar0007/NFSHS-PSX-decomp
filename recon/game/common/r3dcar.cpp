/* game/psx/r3dcar.cpp -- RECONSTRUCTED (NFS4 PSX 3D car renderer; C++ TU)
 *   6 fns: Scene_Init/DeInit/PurgeScene/BuildCustomSceneList/LoadSceneFile + GetPlaneY.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "r3dcar_externs.h"

/* ---- R3DCar.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
/* R3DCar_InsertCarFacet_jt: compiler switch-jumptable @0x80056470, eliminated by #148 (the inner
 * visibility switch restored to source-level switch(iVar16); see ~line 1650). Not a source object. */
char         R3DCar_ObjectInfo[57][6] = { 0, 73, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 32, 2, 1, 1, 0, 0, 48, 0, 1, 1, 0, 0, -8, 0, 0, 0, 1, 0, -16, 8, 10, 10, 0, 0, -32, 0, 12, 0, 0, 0, -32, 0, 0, 12, 0, 0, -20, -119, 11, 11, 0, 11, -16, -120, 11, 11, 0, 11, -20, -119, 12, 12, 0, 12, -16, -120, 12, 12, 0, 12, -24, 0, 1, 0, 0, 0, -24, 0, 0, 1, 0, 0, -44, 0, 17, 0, 0, 0, -44, 0, 17, 0, 0, 0, -31, 8, 1, 0, 0, 0, -31, 8, 0, 1, 0, 0, -44, 0, 18, 18, 18, 0, -30, 0, 1, 0, 0, 0, -30, 0, 0, 1, 0, 0, -44, 0, 19, 19, 19, 0, -30, 24, 15, 16, 0, 0, -30, 8, 0, 1, 0, 0, -44, 16, 20, 20, 20, 0, -30, 24, 15, 16, 0, 0, -30, 8, 0, 1, 0, 0, -44, 16, 21, 21, 21, 0, -24, 8, 1, 0, 0, 0, -24, 8, 0, 1, 0, 0, -44, 0, 22, 22, 22, 0, -40, 0, 1, 1, 0, 0, -12, 0, 13, 0, 0, 0, -12, 0, 14, 0, 0, 0, -44, 0, 17, 0, 0, 0, 48, 0, 2, 1, 0, 0, 40, 2, 3, 0, 0, 3, 40, 2, 3, 0, 0, 3, 38, 2, 4, 0, 0, 0, 36, 2, 4, 0, 0, 4, 36, 2, 4, 0, 0, 4, 0, 73, 1, 0, 0, 1, 0, 73, 1, 0, 0, 1, -16, -128, 5, 0, 0, 5, -16, -128, 6, 0, 0, 6, -24, -119, 7, 7, 0, 7, -24, -119, 8, 8, 0, 8, 31, 0, 1, 1, 0, 0, 31, 0, 1, 1, 0, 0, 32, 0, 1, 0, 0, 0, 32, 0, 1, 0, 0, 0, 32, 0, 9, 1, 0, 0, 32, 0, 9, 1, 0, 0, 32, 0, 1, 0, 0, 0, 32, 0, 1, 0, 0, 0, 32, 0, 9, 1, 0, 0, 32, 0, 9, 1, 0, 0 };   /* @0x801165e0 */
short        R3DCar_Suspension[10] = { 0, 1, 0, 1, 0, 1, 2, 3, 2, 3 };   /* @0x80116738 */
char         R3DCar_FlareOverlayIndex[6] = { -1, 24, 26, 27, 28, 29 };   /* @0x8011674c */
short        R3DCar_FlareCopSirenType[15][6] = { 0, 0, 0, 1801, 2311, 0, 0, 0, 0, 2311, 1801, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 1799, 1799, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 2311, 1801, 0, 0, 0, 0, 2311, 1801, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 1799, 1799, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 1799, 1799, 0, 0, 0, 0, 2313, 2313, 0, 0, 0, 0, 2311, 1801, 0, 0, 0, 0, 1801, 2311, 0 };   /* @0x80116758 */
char         R3DCar_SignalBrakeFlare[28] = { 0, 0, 0, 0, 0, 3, 0, 0, 0, 3, 1, 0, 1, 0, 0, 0, 0, 0, 3, 3, 2, 0, 0, 0, 0, 0, 0, 0 };   /* @0x8011680c */
char         R3DCar_RecessedLight[28] = { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* @0x80116828 */
char         R3DCar_ForceDriveSide[28] = { -1, -1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1 };   /* @0x80116844 */
char         R3DCar_DamageSpoiler[28] = { 0, 0, 0, 0, -128, -128, 0, 0, 0, 0, 0, -127, 0, 0, 0, 0, -127, 0, 0, 0, 0, 0, 0, 0, 0, 0, -127, 0 };   /* @0x80116860 */
char         R3DCar_CopIndex[6][5] = { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 3, 4, 5, 5, 6, 6, 6, 6, 6, 7, 8, 9, 9, 9, 10, 11, 12, 13, 14 };   /* @0x8011687c */
char         R3DCar_CopCountry[15] = { 99, 99, 98, 102, 103, 97, 99, 98, 102, 103, 98, 102, 103, 97, 117 };   /* @0x8011689c */
char         R3DCar_ObjectVisible[57];   /* @0x801168ac  (bss(zero)) */
Draw_tVertex R3DCar_shadowVertex[4];   /* @0x801168e8  (bss(zero)) */
Transformer_zScene *R3DCar_LoadedScenePointer[2][50];   /* @0x80116908  (bss(zero)) */
char         R3DCar_LoadedSceneCounter[2][50];   /* @0x80116a98  (bss(zero)) */
signed char  R3DCar_LoadedSceneCountry[50];   /* @0x80116afc  (bss(zero)) */
short        R3DCar_LoadedSceneColor[2][50];   /* @0x80116b30  (bss(zero)) */
short        R3DCar_LoadedSceneVRam[2][50][2];   /* @0x80116bf8  (bss(zero)) */
int          R3DCar_PositionZ[9];   /* @0x80116d88  (bss(zero)) */
u_long       *R3DCar_subOtStart[2][2];   /* @0x80116dac  (bss(zero)) */
R3DCar_tEnvMapInfo R3DCar_EnvMapInfo[28];   /* @0x80116dbc  (bss(zero)) */
int          R3DCar_InMenu;   /* @0x8013d324  (bss(zero)) */
int          R3DCar_aSyncLoading;   /* @0x8013d384  (bss(zero)) */
void         *R3DCar_orientMat;   /* @0x8013d388  (bss(zero)) */
void         *R3DCar_position;   /* @0x8013d38c  (bss(zero)) */
Draw_tVertex R3DCar_center;   /* @0x8013d390  (bss(zero)) */
int          R3DCar_shadowFlag;   /* @0x8013d398  (bss(zero)) */
CVECTOR      R3DCar_shadowColour;   /* @0x8013d39c  (bss(zero)) */
CVECTOR      R3DCar_eMapColour;   /* @0x8013d3a0  (bss(zero)) */
int          R3DCar_yawCam;   /* @0x8013d3a4  (bss(zero)) */
int          R3DCar_Clock;   /* @0x8013d3a8  (bss(zero)) */
int          R3DCar_ClockLast;   /* @0x8013d3ac  (bss(zero)) */
char         *R3DCar_BigFile;   /* @0x8013d3b0  (bss(zero)) */
char         *R3DCar_LicenseShapeFile;   /* @0x8013d3b4  (bss(zero)) */
u_long       *R3DCar_subOt;   /* @0x8013d3b8  (bss(zero)) */
int          R3DCar_rightHandDrive;   /* @0x8013d3bc  (bss(zero)) */
/* R3DCar-internal lost-symbol (NOT in SYM Globals; facet OTZ scratch). DEFINED here for
   self-containment (was extern-only). */
int R3DCar_gFacetScratch;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void R3DCar_ChangeTrafficColor(Car_tObj *carObj,int newColorIndex);
void R3DCar_StartUp(void);
void R3DCar_PostStartUp(void);
void R3DCar_Restart(void);
void R3DCar_CleanUp(void);
void R3DCcar_ReadeMapData(void);
void R3DCcar_ReadTrackShadow(void);
void R3DCar_CalcCarDimensions(Car_tObj *carObj,Transformer_zScene *scene,int carType);
void R3DCar_DeInstantiate3DCar(Car_tObj *carObj);
void R3DCar_DeInstantiate3DCarMenu(Car_tObj *carObj);
void R3DCar_GetFileName(char *infilename,char *filename,char *suffix);
char * R3DCar_LoadFileAdr(char *name);
void R3DCar_GetCarName(char *filename,int carType,int country);
void R3DCar_Instantiate3DCar(Car_tObj *carObj,int index);
int R3DCar_Visibilty(Car_tObj *carObj,DRender_tView *Vi);
void R3DCar_TurnHeadLightOn(Car_tObj *carObj,int tail);
void R3DCar_TurnHeadLightOff(Car_tObj *carObj,int head);
void R3DCar_MATRIX3DT_Copy(int *from,int *to);
void R3DCar_InsertCarFacet(Car_tObj *carObj,DRender_tView *Vi);
void R3DCar_ReadInCarTextureMenu(Car_tObj *carObj,char *bigfile,int reload,int player);
void R3DCar_InsertCarFacetMenu(Car_tObj *carObj,DRender_tView *Vi);
void R3DCar_InsertCarFacetII(Car_tObj *carObj);
void R3DCar_InsertCarFacetMenuII(Car_tObj *carObj,int light);
void R3DCar_Showroom(DRender_tView *Vi);
void R3DCar_InsertCarFacetZ(Car_tObj *carObj,DRender_tView *Vi);
void R3DCar_InsertAllListFacet(DRender_tView *Vi);


/* ---- R3DCar_ChangeTrafficColor__FP8Car_tObji  [R3DCAR.CPP:386-420] SLD-VERIFIED ---- */
void R3DCar_ChangeTrafficColor(Car_tObj *carObj,int newColorIndex)

{
  int iVar1;
  u_int uVar4;
  u_short uVar2;
  Texture_pal8bit *palCopy;
  int iVar5;

  if ((carObj->render).palCopy != (char *)0x0) {
    uVar4 = newColorIndex & 7;
    uVar2 = (carObj->render).colorIndex;
    iVar5 = (uVar2 & 8) + uVar4;
    if (iVar5 != (short)uVar2) {
      DrawSync(0);
      if ((carObj->render).currentCarType < 0x1c) {
        Texture_CarColor = uVar4 + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
        Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,1);
        palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
        iVar1 = (carObj->render).palNum;
        Texture_CarColor = uVar4 + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
        Texture_ProcessPaletteCopy(palCopy,1,iVar1);
      }
      else {
        palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
        iVar1 = (carObj->render).palNum;
        Texture_CarColor = uVar4;
        Texture_ProcessPaletteCopy(palCopy,0,iVar1);
      }
      (carObj->render).colorIndex = (short)iVar5;
    }
  }
  return;
}

/* ---- R3DCar_StartUp__Fv  [R3DCAR.CPP:424-461] SLD-VERIFIED ---- */
void R3DCar_StartUp(void)

{
  char *pcVar1;
  int iVar4;
  char name [100];

  iVar4 = 0;
  do {
    R3DCar_LoadedScenePointer[1][iVar4] = (Transformer_zScene *)0x0;
    R3DCar_LoadedScenePointer[0][iVar4] = (Transformer_zScene *)0x0;
    R3DCar_LoadedSceneCounter[1][iVar4] = '\0';
    R3DCar_LoadedSceneCounter[0][iVar4] = '\0';
    R3DCar_LoadedSceneCountry[iVar4] = -1;
    R3DCar_LoadedSceneColor[1][iVar4] = -1;
    R3DCar_LoadedSceneColor[0][iVar4] = -1;
    iVar4 = iVar4 + 1;
  } while (iVar4 < 0x32);
  R3DCar_orientMat = reservememadr("orientMat",0x804,0);
  R3DCar_position = reservememadr("position",0x2b8,0);
  sprintf(name,"%slicense.psh",Paths_Paths[0x19]);
  pcVar1 = (char *)loadfileadr(name,0);
  R3DCar_LicenseShapeFile = pcVar1;
  return;
}

/* ---- R3DCar_PostStartUp__Fv  [R3DCAR.CPP:466-489] SLD-VERIFIED ---- */
void R3DCar_PostStartUp(void)

{
  bool bVar1;
  int otSize;
  int iVar2;
  
  if (R3DCar_InMenu == 0) {
    iVar2 = Cars_gNumCars * 0x1c0;
    bVar1 = iVar2 < 0x400;
  }
  else {
    iVar2 = 0x400;
    bVar1 = false;
  }
  if (bVar1) {
    iVar2 = 0x400;
  }
  iVar2 = iVar2 << 2;
  R3DCar_subOtStart[0][0] = reservememadr("sub_ot0",iVar2,0);
  R3DCar_subOtStart[1][0] = reservememadr("sub_ot1",iVar2,0);
  if ((R3DCar_InMenu != 0) || (GameSetup_gData.commMode == 1)) {
    R3DCar_subOtStart[0][1] = reservememadr("sub_ot0m",iVar2,0);
    R3DCar_subOtStart[1][1] = reservememadr("sub_ot1m",iVar2,0);
  }
  return;
}

/* ---- R3DCar_Restart__Fv  [R3DCAR.CPP:495-514] SLD-VERIFIED ---- */
void R3DCar_Restart(void)

{
  int iVar4;
  int numCars;
  GameSetup_tData *gsData;
  short headOn;
  short brakeOn;
  Car_tObj **ppCVar3;
  Car_tObj *pCVar2;

  iVar4 = 0;
  numCars = Cars_gNumCars;
  gsData = &GameSetup_gData;
  headOn = 0x33;
  brakeOn = 2;
  ppCVar3 = Cars_gList;
R3DRestart_loopTop:
  if (iVar4 < numCars) {
    pCVar2 = *ppCVar3;
    (pCVar2->render).headLight = 0;
    (pCVar2->render).brakeLight = 0;
    if (gsData->Time != 0) {
      (pCVar2->render).headLight = headOn;
      (pCVar2->render).brakeLight = brakeOn;
    }
    ppCVar3 = ppCVar3 + 1;
    iVar4 = iVar4 + 1;
    (pCVar2->render).signalLight[0] = 0;
    (pCVar2->render).signalLight[1] = 0;
    (pCVar2->render).damageParts = 0;
    goto R3DRestart_loopTop;
  }
  return;
}

/* ---- R3DCar_CleanUp__Fv  [R3DCAR.CPP:518-571] SLD-VERIFIED ---- */
void R3DCar_CleanUp(void)

{
  int i_2;

  i_2 = 0;
  do {
    if (R3DCar_LoadedScenePointer[0][i_2] != (Transformer_zScene *)0x0) {
      purgememadr(R3DCar_LoadedScenePointer[0][i_2]);
      R3DCar_LoadedScenePointer[0][i_2] = (Transformer_zScene *)0x0;
      R3DCar_LoadedSceneCounter[0][i_2] = '\0';
    }
    if (R3DCar_LoadedScenePointer[1][i_2] != (Transformer_zScene *)0x0) {
      purgememadr(R3DCar_LoadedScenePointer[1][i_2]);
      R3DCar_LoadedScenePointer[1][i_2] = (Transformer_zScene *)0x0;
      R3DCar_LoadedSceneCounter[1][i_2] = '\0';
    }
    i_2 = i_2 + 1;
  } while (i_2 < 0x32);
  if (R3DCar_orientMat != (void *)0x0) {
    purgememadr(R3DCar_orientMat);
  }
  R3DCar_orientMat = (void *)0x0;
  if (R3DCar_position != (void *)0x0) {
    purgememadr(R3DCar_position);
  }
  R3DCar_position = (void *)0x0;
  if (R3DCar_LicenseShapeFile != (char *)0x0) {
    purgememadr(R3DCar_LicenseShapeFile);
  }
  R3DCar_LicenseShapeFile = (char *)0x0;
  if (R3DCar_subOtStart[0][0] != (u_long *)0x0) {
    purgememadr(R3DCar_subOtStart[0][0]);
  }
  if (R3DCar_subOtStart[1][0] != (u_long *)0x0) {
    purgememadr(R3DCar_subOtStart[1][0]);
  }
  R3DCar_subOtStart[1][0] = (u_long *)0x0;
  R3DCar_subOtStart[0][0] = (u_long *)0x0;
  if ((R3DCar_InMenu != 0) || (GameSetup_gData.commMode == 1)) {
    if (R3DCar_subOtStart[0][1] != (u_long *)0x0) {
      purgememadr(R3DCar_subOtStart[0][1]);
    }
    if (R3DCar_subOtStart[1][1] != (u_long *)0x0) {
      purgememadr(R3DCar_subOtStart[1][1]);
    }
    R3DCar_subOtStart[1][1] = (u_long *)0x0;
    R3DCar_subOtStart[0][1] = (u_long *)0x0;
  }
  return;
}

/* ---- R3DCar_ReadInCarData__FPcP8Car_tObj  [R3DCAR.CPP:580-881] SLD-VERIFIED ---- */
Transformer_zScene *
R3DCar_ReadInCarData(char *filename,Car_tObj *carObj)

{
  char * filestart;
  void *src;
  Transformer_zScene *dst;
  u_int uVar1;
  int iVar2;
  int iVar3;
  Transformer_zObj *pTVar4;
  int iVar5;
  short nm_vx;
  short sVar6;
  int in_a2;
  Transformer_zObj *Nobj;
  int iVar7;
  int offset;
  int iVar8;
  int j;
  int iVar9;
  int i;
  int iVar10;
  char *rawData;
  char (*pacVar11) [6];
  short tz;
  short ty;
  char infilename [15];
  VECTOR vt;
  SVECTOR nm;
  long filesize;
  Transformer_zScene *scene;
  int carType;
  int eScaleX;
  int eScaleY;
  short tx;
  VECTOR *pVStack_38;
  SVECTOR *pSStack_34;
  int iStack_30;
  
  strcpy(infilename,filename);
  strcat(infilename,".geo");
  iVar8 = 0x24c;
  pVStack_38 = &vt;
  pSStack_34 = &nm;
  iStack_30 = 0x7e07e07f;
  src = locatebig(R3DCar_BigFile,infilename,in_a2);
  locatebigentry(R3DCar_BigFile,infilename,0,(int *)0x0,(int)&filesize);
  dst = reservememadr(infilename,filesize,0);
  scene = dst;
  blockmove(src,dst,filesize);
  carType = (int)(carObj->render).currentCarType;
  eScaleX = R3DCar_EnvMapInfo[carType].eScaleX;
  eScaleY = R3DCar_EnvMapInfo[carType].eScaleY;
  (carObj->render).rideHeight = R3DCar_EnvMapInfo[carType].rideHeight << 7;
  pacVar11 = R3DCar_ObjectInfo;
  (carObj->render).upgradeHeight = R3DCar_EnvMapInfo[carType].upgradeHeight << 7;
  for (iVar10 = 0; iVar10 < 0x39; iVar10 = iVar10 + 1) {
    pTVar4 = (Transformer_zObj *)((int)dst->obj + iVar8);
    iVar8 = iVar8 + 0x1c;
    scene->obj[iVar10] = pTVar4;
    if (iVar10 == 0x27) {
      (pTVar4->translation).x = (pTVar4->translation).x + -0x7ae;
    }
    if (iVar10 == 0x28) {
      (pTVar4->translation).x = (pTVar4->translation).x + 0x7ae;
    }
    uVar1 = (u_int)pTVar4->numVertex;
    if (uVar1 != 0) {
      pTVar4->vertex = (COORD16 *)((int)dst->obj + iVar8);
      iVar8 = iVar8 + uVar1 * 6;
      if ((pTVar4->numVertex & 1) != 0) {
        iVar8 = iVar8 + 2;
      }
      if (((uVar1 != 0) && (((*pacVar11)[1] & 1U) != 0)) && (carType < 0x1c)) {
        pTVar4->Nvertex = (COORD16 *)((int)dst->obj + iVar8);
        iVar8 = iVar8 + (u_int)pTVar4->numVertex * 6;
        if ((pTVar4->numVertex & 1) != 0) {
          iVar8 = iVar8 + 2;
        }
        tx = (short)((u_int)(pTVar4->translation).x >> 8);
        iVar2 = (pTVar4->translation).y;
        iVar5 = (pTVar4->translation).z;
        iVar7 = 0;
        for (iVar9 = 0; iVar9 < (int)(u_int)pTVar4->numVertex; iVar9 = iVar9 + 1) {
          vt.vx = (int)*(short *)((int)&pTVar4->vertex->x + iVar7) + (int)tx;
          vt.vy = (int)*(short *)((int)&pTVar4->vertex->y + iVar7) + (int)(short)((u_int)iVar2 >> 8);
          vt.vz = (int)*(short *)((int)&pTVar4->vertex->z + iVar7) + (int)(short)((u_int)iVar5 >> 8)
                  >> 2;
          VectorNormalS(pVStack_38,pSStack_34);
          if (((*pacVar11)[1] & 0x40U) != 0) {
            vt.vx = (int)*(short *)((int)&pTVar4->Nvertex->x + iVar7) + (int)nm.vx;
            vt.vy = (int)*(short *)((int)&pTVar4->Nvertex->y + iVar7) + (int)nm.vy;
            vt.vz = (int)*(short *)((int)&pTVar4->Nvertex->z + iVar7) + (int)nm.vz;
            VectorNormalS(pVStack_38,pSStack_34);
          }
          iVar3 = (int)((u_int)(u_short)nm.vx << 0x10) >> 0x10;
          sVar6 = (short)(iVar3 / eScaleX);
          iVar3 = (int)((long long)iVar3 * (long long)iStack_30 >> 0x25) -
                  ((int)((u_int)(u_short)nm.vx << 0x10) >> 0x1f);
          uVar1 = ((int)nm.vy / eScaleY) * iVar3;
          nm.vx = (short)iVar3;
          nm.vz = (short)(int)((long long)(int)nm.vz * (long long)iStack_30 >> 0x25) - (nm.vz >> 0xf);
          nm.vy = (short)uVar1;
          if (((int)(uVar1 * 0x10000) < 0) && ((uVar1 & 0xff) != 0)) {
            nm.vy = nm.vy + 0x100;
          }
          uVar1 = (u_int)(u_short)nm.vy;
          nm.vy = (short)(char)((u_short)nm.vy >> 8);
          if (sVar6 < -0x3f) {
            sVar6 = -0x3f;
          }
          if (0x3f < sVar6) {
            sVar6 = 0x3f;
          }
          if ((int)(uVar1 << 0x10) >> 0x18 < -0x3f) {
            nm.vy = -0x3f;
          }
          if (0x3f < nm.vy) {
            nm.vy = 0x3f;
          }
          nm.vy = sVar6 - nm.vy;
          *(short *)((int)&pTVar4->Nvertex->x + iVar7) = nm.vx;
          *(short *)((int)&pTVar4->Nvertex->y + iVar7) = nm.vy;
          *(short *)((int)&pTVar4->Nvertex->z + iVar7) = nm.vz;
          iVar7 = iVar7 + 6;
        }
      }
    }
    if (pTVar4->numFacet != 0) {
      pTVar4->facet = (Transformer_zFacet *)((int)dst->obj + iVar8);
      iVar8 = iVar8 + (u_int)pTVar4->numFacet * 0xc;
    }
    pacVar11 = pacVar11 + 1;
  }
  return scene;
}

/* ---- R3DCcar_ReadeMapData__Fv  [R3DCAR.CPP:886-911] SLD-VERIFIED ---- */
void R3DCcar_ReadeMapData(void)

{
  char *addr;
  int iVar1;
  R3DCar_tEnvMapInfo *pRVar2;
  int i;
  int iVar3;
  char *RenderingFileData;
  char name [256];
  char *ScaneData;
  
  sprintf(name,"%scarmap.dat",Paths_Paths[0x19]);
  iVar3 = 0;
  addr = (char *)loadfileadr(name,0x10);
  ScaneData = addr;
  do {
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_EnvMapInfo[iVar3].eScaleX = iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_EnvMapInfo[iVar3].eScaleY = iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_EnvMapInfo[iVar3].rideHeight = iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_EnvMapInfo[iVar3].upgradeHeight = iVar1;
    iVar3 = iVar3 + 1;
  } while (iVar3 < 0x1c);
  purgememadr(addr);
  return;
}

/* ---- R3DCcar_ReadTrackShadow__Fv  [R3DCAR.CPP:917-944] SLD-VERIFIED ---- */
void R3DCcar_ReadTrackShadow(void)

{
  char *addr;
  int iVar1;
  int i;
  int iVar2;
  char *RenderingFileData;
  char name [256];
  char *ScaneData;
  
  sprintf(name,"%strack.dat",Paths_Paths[0x19]);
  addr = (char *)loadfileadr(name,0x10);
  ScaneData = addr;
  for (iVar2 = GameSetup_gData.track * 4 + GameSetup_gData.Weather + GameSetup_gData.Time * 2;
      iVar2 != -1; iVar2 = iVar2 + -1) {
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_shadowColour.r = (u_char)iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_shadowColour.g = (u_char)iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_shadowColour.b = (u_char)iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_eMapColour.r = (u_char)iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_eMapColour.g = (u_char)iVar1;
    iVar1 = Risk_ReadNextValue(&ScaneData);
    R3DCar_eMapColour.b = (u_char)iVar1;
  }
  purgememadr(addr);
  return;
}

/* ---- R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei  [R3DCAR.CPP:958-1041] SLD-VERIFIED ---- */
void R3DCar_CalcCarDimensions(Car_tObj *carObj,Transformer_zScene *scene,int carType)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  short *psVar7;
  Transformer_zObj *obj;
  Transformer_zObj *pTVar8;
  int minWheelX;
  int maxWheelX;
  int iVar9;
  int iVar10;
  int j;
  int iVar11;
  int minWheelZ;
  int maxWheelZ;
  int iVar12;
  COORD16 *pCVar13;
  int i;
  int iVar14;
  char (*pacVar15) [6];
  coorddef minp;
  coorddef maxp;
  
  pacVar15 = R3DCar_ObjectInfo;
  minp.x = 0x630000;
  minp.y = 0x630000;
  minp.z = 0x630000;
  maxp.x = -0x630000;
  maxp.y = -0x630000;
  maxp.z = -0x630000;
  for (iVar14 = 0; iVar14 < 0x39; iVar14 = iVar14 + 1) {
    pTVar8 = scene->obj[iVar14];
    if (((*pacVar15)[3] == '\x01') && (pTVar8->numVertex != 0)) {
      if ((((iVar14 == 0) || (0x2e < iVar14)) || ((iVar14 == 2 && (carType == 0x1c)))) &&
         (iVar11 = 0, pTVar8->numVertex != 0)) {
        iVar9 = 0;
        do {
          iVar4 = (pTVar8->translation).x;
          if (iVar4 < 0) {
            iVar4 = iVar4 + 0xff;
          }
          iVar4 = (int)*(short *)((int)&pTVar8->vertex->x + iVar9) + (iVar4 >> 8);
          if (minp.x <= iVar4) {
            iVar4 = minp.x;
          }
          iVar5 = (pTVar8->translation).y;
          if (iVar5 < 0) {
            iVar5 = iVar5 + 0xff;
          }
          iVar5 = (int)*(short *)((int)&pTVar8->vertex->y + iVar9) + (iVar5 >> 8);
          if (minp.y <= iVar5) {
            iVar5 = minp.y;
          }
          iVar6 = (pTVar8->translation).z;
          if (iVar6 < 0) {
            iVar6 = iVar6 + 0xff;
          }
          iVar6 = (int)*(short *)((int)&pTVar8->vertex->z + iVar9) + (iVar6 >> 8);
          if (minp.z <= iVar6) {
            iVar6 = minp.z;
          }
          iVar1 = (pTVar8->translation).x;
          if (iVar1 < 0) {
            iVar1 = iVar1 + 0xff;
          }
          iVar1 = (int)*(short *)((int)&pTVar8->vertex->x + iVar9) + (iVar1 >> 8);
          if (iVar1 < maxp.x) {
            iVar1 = maxp.x;
          }
          iVar2 = (pTVar8->translation).y;
          if (iVar2 < 0) {
            iVar2 = iVar2 + 0xff;
          }
          iVar2 = (int)*(short *)((int)&pTVar8->vertex->y + iVar9) + (iVar2 >> 8);
          if (iVar2 < maxp.y) {
            iVar2 = maxp.y;
          }
          iVar3 = (pTVar8->translation).z;
          if (iVar3 < 0) {
            iVar3 = iVar3 + 0xff;
          }
          iVar3 = (int)*(short *)((int)&pTVar8->vertex->z + iVar9) + (iVar3 >> 8);
          if (iVar3 < maxp.z) {
            iVar3 = maxp.z;
          }
          iVar11 = iVar11 + 1;
          iVar9 = iVar9 + 6;
          minp.x = iVar4;
          minp.y = iVar5;
          minp.z = iVar6;
          maxp.x = iVar1;
          maxp.y = iVar2;
          maxp.z = iVar3;
        } while (iVar11 < (int)(u_int)pTVar8->numVertex);
      }
      iVar11 = 0x630000;
      if (0x2e < iVar14) {
        iVar9 = 0x630000;
        iVar4 = -0x630000;
        iVar5 = -0x630000;
        iVar6 = 0;
        if (pTVar8->numVertex != 0) {
          iVar10 = 0;
          pCVar13 = pTVar8->vertex;
          iVar1 = iVar11;
          iVar2 = iVar4;
          iVar3 = iVar9;
          iVar12 = iVar5;
          do {
            iVar11 = (pTVar8->translation).x;
            if (iVar11 < 0) {
              iVar11 = iVar11 + 0xff;
            }
            iVar11 = (int)pCVar13->x + (iVar11 >> 8);
            if (iVar11 < 0) {
              iVar11 = -iVar11;
            }
            if (iVar1 <= iVar11) {
              iVar11 = iVar1;
            }
            iVar9 = (pTVar8->translation).z;
            if (iVar9 < 0) {
              iVar9 = iVar9 + 0xff;
            }
            iVar9 = (int)*(short *)((int)&pTVar8->vertex->z + iVar10) + (iVar9 >> 8);
            if (iVar9 < 0) {
              iVar9 = -iVar9;
            }
            if (iVar3 <= iVar9) {
              iVar9 = iVar3;
            }
            iVar4 = (pTVar8->translation).x;
            psVar7 = (short *)((int)&pTVar8->vertex->x + iVar10);
            if (iVar4 < 0) {
              iVar4 = iVar4 + 0xff;
            }
            iVar4 = (int)*psVar7 + (iVar4 >> 8);
            if (iVar4 < 0) {
              iVar4 = -iVar4;
            }
            if (iVar4 < iVar2) {
              iVar4 = iVar2;
            }
            iVar5 = (pTVar8->translation).z;
            if (iVar5 < 0) {
              iVar5 = iVar5 + 0xff;
            }
            iVar5 = (int)psVar7[2] + (iVar5 >> 8);
            if (iVar5 < 0) {
              iVar5 = -iVar5;
            }
            if (iVar5 < iVar12) {
              iVar5 = iVar12;
            }
            iVar10 = iVar10 + 6;
            iVar6 = iVar6 + 1;
            pCVar13 = pCVar13 + 1;
            iVar1 = iVar11;
            iVar2 = iVar4;
            iVar3 = iVar9;
            iVar12 = iVar5;
          } while (iVar6 < (int)(u_int)pTVar8->numVertex);
        }
        if (iVar14 < 0x35) {
          if (0x2e < iVar14) {
            (carObj->N).wheelFrontX = (iVar11 + iVar4 + 1 >> 1) << 8;
            (carObj->N).wheelFrontZ = (iVar9 + iVar5 + 1 >> 1) << 8;
            (carObj->N).wheelWidthF = (iVar4 - iVar11) * 0x100 + 0xccc;
          }
        }
        else {
          (carObj->N).wheelBackX = (iVar11 + iVar4 + 1 >> 1) << 8;
          (carObj->N).wheelBackZ = (iVar9 + iVar5 + 1 >> 1) << 8;
          (carObj->N).wheelWidthB = (iVar4 - iVar11) * 0x100 + 0xccc;
        }
      }
    }
    pacVar15 = pacVar15 + 1;
  }
  (carObj->N).dimension.x = (maxp.x - minp.x) / 2 << 8;
  (carObj->N).dimension.y = (maxp.y - minp.y) / 2 << 8;
  iVar14 = (maxp.z - minp.z) / 2 << 8;
  (carObj->N).dimension.z = iVar14;
  if (carType == 0x1c) {
    (carObj->N).dimension.z = iVar14 >> 1;
  }
  iVar14 = (carObj->N).dimension.x;
  if (iVar14 < 0) {
    iVar14 = iVar14 + 0xff;
  }
  iVar11 = (carObj->N).dimension.y;
  if (iVar11 < 0) {
    iVar11 = iVar11 + 0xff;
  }
  iVar14 = fixedsqrt((iVar14 >> 8) * (iVar14 >> 8) + (iVar11 >> 8) * (iVar11 >> 8));
  (carObj->N).dimensionRadius = iVar14;
  if (iVar14 < 0) {
    iVar14 = iVar14 + 0xff;
  }
  iVar11 = (carObj->N).dimension.z;
  if (iVar11 < 0) {
    iVar11 = iVar11 + 0xff;
  }
  iVar14 = fixedsqrt((iVar14 >> 8) * (iVar14 >> 8) + (iVar11 >> 8) * (iVar11 >> 8));
  (carObj->N).dimensionRadius = iVar14;
  return;
}

/* ---- R3DCar_DeInstantiate3DCar__FP8Car_tObj  [R3DCAR.CPP:1046-1048] SLD-VERIFIED ---- */
void R3DCar_DeInstantiate3DCar(Car_tObj *carObj)

{
  char *addr;
  
  addr = (carObj->render).palCopy;
  if (addr != (char *)0x0) {
    purgememadr(addr);
  }
  (carObj->render).palCopy = (char *)0x0;
  return;
}

/* ---- R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj  [R3DCAR.CPP:1054-1113] SLD-VERIFIED ---- */
void R3DCar_DeInstantiate3DCarMenu(Car_tObj *carObj)

{
  int countryFlag;
  char cVar1;
  char *bigFile;
  void *addr;
  int status;
  u_int uVar2;
  char *addr_00;
  int currentCarType;
  int iVar3;

  iVar3 = (int)(carObj->render).currentCarType;
  if (-1 < iVar3) {
    uVar2 = (u_int)((u_char)(carObj->render).currentCountry >> 7);
    cVar1 = R3DCar_LoadedSceneCounter[uVar2][iVar3] - 1;
    R3DCar_LoadedSceneCounter[uVar2][iVar3] = cVar1;
    if (cVar1 == '\0') {
      purgememadr(R3DCar_LoadedScenePointer[uVar2][iVar3]);
      R3DCar_LoadedScenePointer[uVar2][iVar3] = (Transformer_zScene *)0x0;
    }
    CarIO_ReleaseCarCluts(carObj);
  }
  (carObj->render).currentCarType = -1;
  (carObj->render).newCarType = (carObj->render).newCarType | 0x80;
  if (carObj->async_handle != 0) {
    while (status = getasyncreadstatus(carObj->async_handle), status == 0) {
      systemtask(0);
    }
    if (((0 < status) || (status == -1)) &&
       (addr = getasyncreadadr(carObj->async_handle),
       addr != (void *)0x0)) {
      purgememadr(addr);
    }
    carObj->async_handle = 0;
    R3DCar_aSyncLoading = -1;
  }
  addr_00 = (carObj->render).palCopy;
  if (addr_00 != (char *)0x0) {
    purgememadr(addr_00);
  }
  (carObj->render).palCopy = (char *)0x0;
  return;
}

/* ---- R3DCar_GetFileName__FPcN20  [R3DCAR.CPP:1118-1125] SLD-VERIFIED ---- */
void R3DCar_GetFileName(char *infilename,char *filename,char *suffix)

{
  char workFile [10];
  
  strcpy(workFile,filename);
  strcat(workFile,suffix);
  strcpy(infilename,workFile);
  strcat(infilename,".psh");
  return;
}

/* ---- R3DCar_LoadFileAdr__FPc  [R3DCAR.CPP:1133-1141] SLD-VERIFIED ---- */
char * R3DCar_LoadFileAdr(char *name)

{
  char * buf;
  int size;
  char *loadAddr;
  
  size = filesize(name);
  loadAddr = Platform_TempReserveMemory(size,"bigfile");
  loadfileatadr(name,loadAddr);
  return loadAddr;
}

/* ---- R3DCar_GetCarName__FPcii  [R3DCAR.CPP:1145-1154] SLD-VERIFIED ---- */
void R3DCar_GetCarName(char *filename,int carType,int country)

{
  u_int copIdx;
  u_char copLetterIdx;

  copIdx = carType - 0x16U;
  sprintf(filename,"zz%s",GameSetup_gCarNames[0] + carType * 5);
  if (copIdx < 6) {
    copLetterIdx = R3DCar_CopIndex[copIdx][country];
    filename[2] = R3DCar_CopCountry[copLetterIdx];
  }
  return;
}

/* ---- R3DCar_Instantiate3DCar__FP8Car_tObji  [R3DCAR.CPP:1159-1399] SLD-VERIFIED ---- */
void R3DCar_Instantiate3DCar(Car_tObj *carObj,int index)

{
  int infilenames;
  u_char bVar1;
  u_short uVar2;
  short sVar3;
  Transformer_zScene *pTVar4;
  char *pcVar5;
  int color;
  GameSetup_tCarData *pGVar6;
  char *pcVar7;
  u_int uVar8;
  int iVar9;
  int i;
  int iVar10;
  char *bigfile;
  char **ppcVar11;
  int carType;
  int carType_00;
  int reload;
  u_int uVar12;
  int duplicateLicense;
  char filename [10];
  char workFile [10];
  char bigname [100];
  char infilename [15];
  char acStack_69 [49];
  char *shpfiles [4];
  
  carType_00 = carObj->carInfo->carType;
  if (5 < carType_00 - 0x16U) {
    carObj->carInfo->Country = 0;
  }
  if (R3DCar_InMenu == 0) {
    pGVar6 = carObj->carInfo;
    (carObj->render).colorIndex = (u_short)GameSetup_gData.carInfo[index].Colour & 0xf;
    (carObj->render).upgradeFlags =
         (char)pGVar6->EngineMods + (char)pGVar6->WeightTransfer * '\x02' +
         (char)pGVar6->GroundEffects * '\x04';
    if (carType_00 - 0x10U < 3) {
      (carObj->render).upgradeFlags = '\a';
    }
  }
  (carObj->render).inside = 0;
  (carObj->render).medOnly = '\0';
  if (carType_00 < 0x1c) {
    if (R3DCar_InMenu == 0) {
      if (GameSetup_gData.commMode == 1) {
        (carObj->render).medOnly = '\x01';
      }
      else if (((carObj->carFlags & 4U) == 0) && (2 < Cars_gNumCars - Cars_gNumTrafficCars)) {
        (carObj->render).medOnly = '\x01';
      }
      else {
        (carObj->render).inside = 1;
      }
    }
    else {
      (carObj->render).inside = 1;
    }
  }
  iVar9 = R3DCar_InMenu;
  (carObj->render).headLight = 0;
  (carObj->render).brakeLight = 0;
  if (iVar9 == 0) {
    if (GameSetup_gData.Time != 0) {
      (carObj->render).headLight = 0x33;
      (carObj->render).brakeLight = 2;
    }
  }
  else {
    (carObj->render).headLight = 0x33;
  }
  pGVar6 = carObj->carInfo;
  (carObj->render).newCarType = (short)carType_00;
  (carObj->render).currentCarType = (short)carType_00;
  (carObj->render).palCopy = (char *)0x0;
  (carObj->render).currentCountry = (char)pGVar6->Country;
  if (R3DCar_InMenu != 0) {
    sVar3 = (carObj->render).inside;
    (carObj->render).currentCarType = -1;
    uVar2 = (carObj->render).newCarType;
    carObj->async_handle = 0;
    (carObj->render).inside = sVar3 << 4;
    (carObj->render).newCarType = uVar2 | 0x80;
    (carObj->render).newCountry = (carObj->render).currentCountry;
    R3DCar_aSyncLoading = -1;
    R3DCar_BigFile = (char *)0x0;
    return;
  }
  R3DCar_GetCarName(filename,carType_00,carObj->carInfo->Country);
  strcpy(bigname,Paths_Paths[0x18]);
  strcat(bigname,filename);
  if (((carObj->render).inside & 1U) == 0) {
    if (((carObj->render).medOnly != '\0') && (carType_00 < 0x1c)) {
      pcVar7 = "s";
      goto R3DInst_strcatSuffix;
    }
  }
  else {
    pcVar7 = "h";
R3DInst_strcatSuffix:
    strcat(bigname,pcVar7);
  }
  strcat(bigname,".viv");
  R3DCar_BigFile = R3DCar_LoadFileAdr(bigname);
  strcpy(workFile,filename);
  if (((carObj->render).inside & 1U) == 0) {
    if (((carObj->render).medOnly == '\0') || (0x1b < carType_00)) goto R3DInst_readSceneData;
    pcVar7 = "s";
  }
  else {
    pcVar7 = "h";
  }
  strcat(workFile,pcVar7);
R3DInst_readSceneData:
  if (R3DCar_LoadedScenePointer[0][carType_00] == (Transformer_zScene *)0x0) {
    uVar2 = (carObj->render).colorIndex;
    pTVar4 = R3DCar_ReadInCarData(workFile,carObj);
    uVar12 = 0;
    R3DCar_LoadedScenePointer[0][carType_00] = pTVar4;
    R3DCar_LoadedSceneCounter[0][carType_00] = R3DCar_LoadedSceneCounter[0][carType_00] + '\x01';
    R3DCar_LoadedSceneCountry[carType_00] = (carObj->render).currentCountry;
    R3DCar_LoadedSceneColor[(int)((u_int)uVar2 << 0x10) >> 0x13][carType_00] = uVar2 & 8;
  }
  else {
    bVar1 = (carObj->render).currentCountry;
    if ((int)R3DCar_LoadedSceneCountry[carType_00] == (u_int)bVar1) {
      uVar8 = (u_int)(u_short)(carObj->render).colorIndex;
      R3DCar_LoadedSceneCounter[0][carType_00] = R3DCar_LoadedSceneCounter[0][carType_00] + '\x01';
      iVar9 = (int)(uVar8 << 0x10) >> 0x13;
      uVar8 = uVar8 & 8;
      uVar12 = 0;
      if ((int)R3DCar_LoadedSceneColor[iVar9][carType_00] == uVar8) {
        (carObj->render).VRamX = R3DCar_LoadedSceneVRam[iVar9][carType_00][0];
        uVar12 = 1;
        (carObj->render).VRamY = R3DCar_LoadedSceneVRam[iVar9][carType_00][1];
      }
      else {
        R3DCar_LoadedSceneColor[iVar9][carType_00] = (short)uVar8;
      }
    }
    else {
      (carObj->render).currentCountry = bVar1 | 0x80;
      pTVar4 = R3DCar_ReadInCarData(workFile,carObj);
      R3DCar_LoadedScenePointer[1][carType_00] = pTVar4;
      uVar12 = 0;
      R3DCar_LoadedSceneCounter[1][carType_00] = R3DCar_LoadedSceneCounter[1][carType_00] + '\x01';
    }
  }
  iVar9 = carType_00;
  R3DCar_CalcCarDimensions(carObj,R3DCar_LoadedScenePointer[(u_char)(carObj->render).currentCountry >> 7]
                    [carType_00],carType_00);
  if (carObj->carInfo->ColourChange != 0) {
    iVar9 = 0;
    pcVar7 = reservememadr("palCopy",0x28a0,0);
    (carObj->render).palCopy = pcVar7;
  }
  Texture_palNum = 0;
  if (carType_00 < 0x1c) {
    if (((carObj->render).inside & 1U) == 0) {
      pcVar7 = "";
    }
    else {
      pcVar7 = "h";
    }
    iVar9 = 1;
    R3DCar_GetFileName(infilename,filename,pcVar7);
    if (((carObj->render).inside & 1U) != 0) {
      R3DCar_GetFileName(acStack_69,filename,"i");
      iVar9 = 2;
    }
    if ((carObj->render).colorIndex < 8) {
      pcVar7 = "l";
    }
    else {
      pcVar7 = "d";
    }
    R3DCar_GetFileName(infilename + iVar9 * 0xf,filename,pcVar7);
    pcVar7 = "g";
    R3DCar_GetFileName(infilename + (iVar9 + 1) * 0xf,filename,"g");
    iVar10 = 0;
    if (iVar9 != -2) {
      ppcVar11 = shpfiles;
      bigfile = infilename;
      do {
        iVar10 = iVar10 + 1;
        pcVar5 = locatebig(R3DCar_BigFile,bigfile,(int)pcVar7);
        *ppcVar11 = pcVar5;
        ppcVar11 = ppcVar11 + 1;
        bigfile = bigfile + 0xf;
      } while (iVar10 < iVar9 + 2);
    }
    pGVar6 = carObj->carInfo;
    iVar9 = 1;
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    CarIO_CreateLicense(pGVar6->license,carType_00,0);
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    CarIO_ReadInCarTextureData(shpfiles[0],carObj,uVar12 | uVar12 << 1,0);
    if (((carObj->render).inside & 1U) != 0) {
      iVar9 = 2;
      CarIO_ReadInCarTextureData(shpfiles[1],carObj,0x19,0);
    }
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    CarIO_ReadInCarTextureData(shpfiles[iVar9],carObj,uVar12 << 1 | 0x91,0);
    CarIO_CleanUpLicense(0);
    (carObj->render).palNum = (short)Texture_palNum;
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    CarIO_UpdateCarTextureData(shpfiles[iVar9 + 1],carObj,0);
  }
  else {
    strcpy(infilename,workFile);
    strcat(infilename,".psh");
    pcVar7 = locatebig(R3DCar_BigFile,infilename,iVar9);
    Texture_CarColor = (u_short)(carObj->render).colorIndex & 7;
    CarIO_ReadInCarTextureData(pcVar7,carObj,uVar12 | 0x88,0);
    (carObj->render).palNum = (short)Texture_palNum;
  }
  if (uVar12 == 0) {
    iVar9 = (int)((u_int)(u_short)(carObj->render).colorIndex << 0x10) >> 0x13;
    R3DCar_LoadedSceneVRam[iVar9][carType_00][0] = (carObj->render).VRamX;
    R3DCar_LoadedSceneVRam[iVar9][carType_00][1] = (carObj->render).VRamY;
  }
  pcVar7 = (carObj->render).palCopy;
  if (pcVar7 != (char *)0x0) {
    resizememadr(pcVar7,(carObj->render).palNum * 0x208);
  }
  R3DCar_BigFile = (char *)0x0;
  return;
}

/* ---- R3DCar_Visibilty__FP8Car_tObjP13DRender_tView  [R3DCAR.CPP:1405-1511] SLD-VERIFIED ---- */
int R3DCar_Visibilty(Car_tObj *carObj,DRender_tView *Vi)

{
  bool bVar1;
  bool bVar2;
  Car_tObj *camCarObj;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  int z;
  int iVar10;
  int carZ;
  int maxMax;
  int zoom;
  u_int uVar11;
  int maxMid;
  int iVar12;
  int inCarCam;
  coorddef carPos [4];
  coorddef car;
  
  iVar8 = Vi->player;
  bVar2 = false;
  uVar11 = Camera_gInfo[iVar8].zooming;
  if ((((((Car_tObj *)Camera_gInfo[iVar8].anchor != carObj) || ((carObj->carFlags & 4U) == 0)) ||
       (Camera_gInfo[iVar8].inCar == 0)) ||
      ((iVar8 = Camera_GetMode(iVar8), iVar8 != 0 &&
       (((Camera_gInfo[Vi->player].inCar == 0 ||
         (iVar8 = Camera_GetMode(Vi->player), iVar8 != 1)) ||
        (bVar2 = true, ((carObj->render).inside & 1U) != 0)))))) &&
     (iVar8 = 0xc0000, (carObj->N).active != '\0')) {
    iVar12 = 0x3c0000;
    bVar1 = Replay_ReplayMode == 2;
    (carObj->render).detail = 0;
    if ((bVar1) || (iVar3 = Camera_GetMode(Vi->player), iVar3 == 0xe)) {
      iVar8 = 0x240000;
      iVar12 = 0x780000;
    }
    if (uVar11 != 0) {
      iVar8 = iVar8 * uVar11 * 3;
      iVar12 = iVar12 * uVar11 * 2;
    }
    iVar9 = (carObj->N).position.x - (Vi->cview).translation.x;
    iVar10 = (carObj->N).position.y - (Vi->cview).translation.y;
    iVar3 = (carObj->N).position.z - (Vi->cview).translation.z;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xff;
    }
    iVar4 = (Vi->cview).mrotation.m[0];
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    if (iVar10 < 0) {
      iVar10 = iVar10 + 0xff;
    }
    iVar5 = (Vi->cview).mrotation.m[1];
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar7 = iVar3;
    if (iVar3 < 0) {
      iVar7 = iVar3 + 0xff;
    }
    iVar6 = (Vi->cview).mrotation.m[2];
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    iVar4 = (iVar9 >> 8) * (iVar4 >> 8) + (iVar10 >> 8) * (iVar5 >> 8) + (iVar7 >> 8) * (iVar6 >> 8)
    ;
    iVar5 = (Vi->cview).mrotation.m[6];
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar7 = (Vi->cview).mrotation.m[7];
    if (iVar7 < 0) {
      iVar7 = iVar7 + 0xff;
    }
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar6 = (Vi->cview).mrotation.m[8];
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    iVar3 = (iVar9 >> 8) * (iVar5 >> 8) + (iVar10 >> 8) * (iVar7 >> 8) + (iVar3 >> 8) * (iVar6 >> 8)
    ;
    if (iVar3 + 0x30000U < 0xcb0001) {
      if (iVar8 < iVar3) {
        (carObj->render).detail = 1;
      }
      if (iVar12 < iVar3) {
        (carObj->render).detail = 2;
      }
      iVar9 = (carObj->N).dimension.x;
      iVar12 = (carObj->N).dimension.z;
      iVar8 = iVar4 - iVar9;
      iVar10 = iVar3 + iVar12;
      iVar4 = iVar4 + iVar9;
      iVar12 = iVar3 - iVar12;
      if (iVar8 < 0) {
        iVar8 = -iVar8;
      }
      if (iVar10 < iVar8) {
        if (iVar4 < 0) {
          iVar4 = -iVar4;
        }
        if (((iVar10 < iVar4) && (iVar12 < iVar8)) && (iVar12 < iVar4))
        goto R3DVis_setNoDetailReturn;
      }
      if (!bVar2) {
        return iVar3;
      }
      (carObj->render).detail = 3;
      return iVar3;
    }
  }
R3DVis_setNoDetailReturn:
  (carObj->render).detail = -1;
  return -0x80000000;
}

/* ---- R3DCar_TurnHeadLightOn__FP8Car_tObji  [R3DCAR.CPP:1516-1521] SLD-VERIFIED ---- */
void R3DCar_TurnHeadLightOn(Car_tObj *carObj,int tail)

{
  u_short uVar1;

  (carObj->render).headLight = (carObj->render).headLight | 0x11;
  if (tail != 0) {
    (carObj->render).brakeLight = (carObj->render).brakeLight | 2;
  }
  uVar1 = (carObj->render).headLight;
  if ((uVar1 & 8) == 0) {
    (carObj->render).headLight = uVar1 | 2;
  }
  uVar1 = (carObj->render).headLight;
  if ((uVar1 & 0x80) == 0) {
    (carObj->render).headLight = uVar1 | 0x20;
  }
  return;
}

/* ---- R3DCar_TurnHeadLightOff__FP8Car_tObji  [R3DCAR.CPP:1525-1532] SLD-VERIFIED ---- */
void R3DCar_TurnHeadLightOff(Car_tObj *carObj,int head)

{
  u_short uVar1;
  
  (carObj->render).brakeLight = (carObj->render).brakeLight & 0xfd;
  if (head != 0) {
    uVar1 = (carObj->render).headLight;
    (carObj->render).headLight = uVar1 & 0xee;
    if ((uVar1 & 8) == 0) {
      (carObj->render).headLight = uVar1 & 0xec;
    }
    uVar1 = (carObj->render).headLight;
    if ((uVar1 & 0x80) == 0) {
      (carObj->render).headLight = uVar1 & 0xdf;
    }
  }
  return;
}

/* ---- R3DCar_MATRIX3DT_Copy__FPiT0  [R3DCAR.CPP:1538-1541] SLD-VERIFIED ---- */
void R3DCar_MATRIX3DT_Copy(int *from,int *to)

{
  int iVar1;
  int i;
  
  i = 8;
  do {
    iVar1 = *from;
    from = from + 1;
    i = i + -1;
    *to = iVar1;
    to = to + 1;
  } while (i != -1);
  return;
}

/* ---- R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView  [R3DCAR.CPP:1546-2181] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacet(Car_tObj *carObj,DRender_tView *Vi)

{
  Transformer_zObj*obj;
  coorddef car;
  coorddef pos;
  matrixtdef bodyIMat;
  matrixtdef matP;
  int vel;
  int spin;
  int rear;
  matrixtdef matR;
  int pitch;
  bool bVar1;
  bool bVar2;
  u_short uVar3;
  u_short uVar4;
  int damage;
  int iVar5;
  int iVar6;
  int iVar7;
  u_int uVar8;
  int index;
  int iVar9;
  DrawC_tEnvMap *pDVar10;
  int suspensionOffset;
  int iVar11;
  matrixtdef *pmVar12;
  matrixtdef *pmVar13;
  u_char bVar14;
  char cVar15;
  short code;
  int in_a1;
  int iVar16;
  Transformer_zObj *pTVar17;
  Car_tObj *pCVar18;
  int steeringAngle;
  int *m1;
  int maxAngleFactor;
  int roll;
  int i;
  int cop_flag;
  int carType;
  int iVar19;
  int detailIndex;
  int iVar20;
  int angle;
  coorddef parent;
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  matrixtdef steerMat;
  matrixtdef tmpMat;
  coorddef translation;
  coorddef tmp;
  matrixtdef matX;
  matrixtdef matY;
  matrixtdef mStack_60;
  int rideHeight;
  int countryFlag;
  int rightHandDrive;
  matrixtdef *pmStack_2c;
  
  rightHandDrive = 0;
  rideHeight = (carObj->render).rideHeight;
  iVar19 = (int)(carObj->render).currentCarType;
  countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
  if ((iVar19 < 0x1c) && (rightHandDrive = (int)R3DCar_ForceDriveSide[iVar19], rightHandDrive < 0))
  {
    rightHandDrive = AITune_trackInfo[GameSetup_gData.track].driveSide + 1 >> 1 ^ 1;
  }
  if (GameSetup_gData.mirrorTrack != 0) {
    rightHandDrive = rightHandDrive ^ 1;
  }
  R3DCar_rightHandDrive = rightHandDrive;
  bVar1 = iVar19 - 0x16U < 6;
  if ((carObj->render).detail < 0) {
    return;
  }
  uVar4 = (carObj->render).headLight;
  if (((uVar4 & 8) == 0) && (0x1e0000 < (carObj->N).damage[0])) {
    if ((uVar4 & 0x44) == 0) {
      uVar3 = 0xc;
R_ICFt_headlight1_retryDmg:
      (carObj->render).headLight = uVar4 | uVar3;
    }
    else {
      uVar3 = 8;
      if ((uVar4 & 2) != 0) goto R_ICFt_headlight1_retryDmg;
    }
    uVar4 = (carObj->render).headLight;
  }
  if (((uVar4 & 0x80) == 0) && (0x1e0000 < (carObj->N).damage[2])) {
    if ((uVar4 & 0x44) == 0) {
      uVar3 = uVar4 | 0xc0;
    }
    else {
      uVar3 = uVar4 | 0x80;
      if ((uVar4 & 0x20) == 0) goto R_ICFt_headlight2_retryDmg;
    }
    (carObj->render).headLight = uVar3;
  }
R_ICFt_headlight2_retryDmg:
  if (bVar1) {
    if ((carObj->AIFlags & 2U) == 0) {
      if (((carObj->render).signalLight[0] & 0x80U) != 0) {
        bVar14 = (carObj->control).lights;
        (carObj->render).signalLight[0] = 0;
        (carObj->render).signalLight[1] = 0;
        if ((bVar14 & 2) == 0) {
          R3DCar_TurnHeadLightOff(carObj,(u_int)((bVar14 & 4) == 0));
        }
      }
    }
    else if (((carObj->render).signalLight[0] & 0x80U) == 0) {
      (carObj->render).signalLight[0] = 0x80;
      bVar14 = (carObj->control).lights;
      (carObj->render).signalLight[1] = 0x88;
      if ((bVar14 & 2) == 0) {
        R3DCar_TurnHeadLightOn(carObj,1);
      }
    }
  }
  if (R3DCar_Clock != 0) {
    uVar4 = (carObj->render).signalLight[0];
    if ((uVar4 & 0x80) != 0) {
      (carObj->render).signalLight[0] = uVar4 + 1 & 0x8f;
    }
    uVar4 = (carObj->render).signalLight[1];
    if ((uVar4 & 0x80) != 0) {
      (carObj->render).signalLight[1] = uVar4 + 1 & 0x8f;
    }
  }
  if (iVar19 < 0x1c) {
    if (((carObj->render).upgradeFlags & 2U) != 0) {
      rideHeight = (carObj->render).upgradeHeight;
    }
  }
  else {
    rideHeight = 0;
  }
  if (((carObj->render).detail == 0) && ((0x1b < iVar19 || ((carObj->render).medOnly != '\0')))) {
    (carObj->render).detail = 1;
  }
  if (((carObj->render).detail == 2) && (iVar19 == 0x1c)) {
    (carObj->render).detail = 1;
  }
  tmpMat.m[0] = (carObj->N).position.x - *(int *)(in_a1 + 8);
  iVar20 = (carObj->render).detail + 2;
  tmpMat.m[1] = (carObj->N).position.y - *(int *)(in_a1 + 0xc);
  tmpMat.m[2] = (carObj->N).position.z - *(int *)(in_a1 + 0x10);
  iVar16 = tmpMat.m[0];
  if (tmpMat.m[0] < 0) {
    iVar16 = tmpMat.m[0] + 0xff;
  }
  iVar5 = (carObj->N).orientMat.m[0];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar11 = tmpMat.m[1];
  if (tmpMat.m[1] < 0) {
    iVar11 = tmpMat.m[1] + 0xff;
  }
  iVar6 = (carObj->N).orientMat.m[1];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar9 = tmpMat.m[2];
  if (tmpMat.m[2] < 0) {
    iVar9 = tmpMat.m[2] + 0xff;
  }
  iVar7 = (carObj->N).orientMat.m[2];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  tmpMat.m[4] = (iVar16 >> 8) * (iVar5 >> 8) + (iVar11 >> 8) * (iVar6 >> 8) +
                (iVar9 >> 8) * (iVar7 >> 8);
  iVar5 = (carObj->N).orientMat.m[6];
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar6 = (carObj->N).orientMat.m[7];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar9 = tmpMat.m[2];
  if (tmpMat.m[2] < 0) {
    iVar9 = tmpMat.m[2] + 0xff;
  }
  iVar7 = (carObj->N).orientMat.m[8];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  tmpMat.m[6] = (iVar16 >> 8) * (iVar5 >> 8) + (iVar11 >> 8) * (iVar6 >> 8) +
                (iVar9 >> 8) * (iVar7 >> 8);
  iVar16 = fixedatan(tmpMat.m[4],tmpMat.m[6]);
  R3DCar_yawCam = 0x1000 - (short)(iVar16 >> 4);
  pmVar13 = &(carObj->N).orientMat;
  if (iVar19 < 0x1c) {
    pmVar12 = &insideMat;
    R3DCar_MATRIX3DT_Copy(pmVar13->m,pmVar12->m);
    if (rightHandDrive != 0) {
      insideMat.m[0] = -insideMat.m[0];
      insideMat.m[2] = -insideMat.m[2];
      insideMat.m[1] = -insideMat.m[1];
    }
    iVar16 = (carObj->render).bodyRoll;
    if (rightHandDrive != 0) {
      iVar16 = -iVar16;
    }
    fixedxformz(&bodyMat,(carObj->render).bodyRoll);
    fixedxformx(&matX,(carObj->render).bodyPitch + 100);
    Math_fasttransmult(&bodyMat,&matX,&bodyMat);
    Math_fasttransmult(&bodyMat,pmVar13,&bodyMat);
    m1 = tmpMat.m + 8;
    fixedxformz(m1,iVar16);
    Math_fasttransmult((matrixtdef *)m1,&matX,(matrixtdef *)m1);
    Math_fasttransmult((matrixtdef *)m1,pmVar12,pmVar12);
    Math_fasttransmult(&bodyMat,(matrixtdef *)(in_a1 + 0x44),&orientMat)
    ;
    pmVar13 = &orientIMat;
  }
  else {
    pmVar12 = &bodyMat;
    fixedxformz(pmVar12,(carObj->render).bodyRoll);
    fixedxformx(&tmpMat,(carObj->render).bodyPitch);
    Math_fasttransmult(pmVar12,&tmpMat,pmVar12);
    Math_fasttransmult(pmVar12,&(carObj->N).orientMat,pmVar12);
    pmVar13 = &orientMat;
  }
  Math_fasttransmult(pmVar12,(matrixtdef *)(in_a1 + 0x44),pmVar13);
  iVar16 = Replay_ReplayMode;
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    iVar5 = 0;
    if (iVar19 == 0x1c) {
      iVar16 = (carObj->N).wheelRot[1];
      (carObj->N).wheelRot[0] = (carObj->N).wheelRot[0] + 0x1800U & 0xffff;
      (carObj->N).wheelRot[1] = iVar16 + 0x1800U & 0xffff;
    }
    else {
      iVar11 = carObj->wheelSpin;
      if (iVar11 < 0) {
        iVar11 = -iVar11;
      }
      pCVar18 = carObj;
      for (; iVar5 < 2; iVar5 = iVar5 + 1) {
        if (iVar16 == 2) {
          iVar6 = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed & 0x1f);
        }
        else {
          iVar6 = (carObj->linearVel_ch).z >> 6;
        }
        if (iVar5 == 0) {
          if (carObj->frontWheelSpin != 0) goto R_ICFt_wheelspinRpmCalc;
        }
        else if (iVar11 - 1U < 2) {
R_ICFt_wheelspinRpmCalc:
          uVar8 = (u_int)(u_char)(carObj->control).gear;
          if (uVar8 != 1) {
            iVar7 = carObj->specs->velToRpmRatio[uVar8];
            iVar9 = carObj->flywheelRpm << 0x10;
            iVar6 = iVar9 / iVar7;
            if (iVar16 == 2) {
              iVar6 = iVar6 << (Replay_ReplayInterface.speed + 7U & 0x1f);
            }
            else {
              iVar6 = iVar6 << 9;
            }
          }
        }
        if ((carObj->wheelLock != 0) && ((carObj->wheelLock & iVar5 + 1U) != 0)) {
          iVar6 = 0;
        }
        iVar9 = iVar6;
        if (iVar6 < -0x1800) {
          iVar9 = -0x1800;
        }
        if (0x1800 < iVar6) {
          iVar9 = 0x1800;
        }
        (pCVar18->N).wheelRot[0] = (pCVar18->N).wheelRot[0] + iVar9 & 0xffff;
        pCVar18 = (Car_tObj *)&(pCVar18->N).oldSlice;
      }
    }
  }
  iVar16 = (carObj->linearVel_ch).z;
  iVar5 = (carObj->control).steering;
  if (0x1e0000 < iVar16) {
    iVar16 = fixedmult(iVar16,0x888);
    iVar16 = fixeddiv(iVar5 << 0x10,iVar16);
    iVar5 = iVar16 >> 0x10;
    if (iVar16 < 0) {
      iVar5 = iVar16 + 0xffff >> 0x10;
    }
  }
  fixedxformy(&steerMat,iVar5 << 5);
  if (((carObj->control).desiredBrakeLevel == '\0') || ((carObj->control).hanno != 0)) {
    uVar4 = (carObj->render).brakeLight & 0xfe;
  }
  else {
    uVar4 = (carObj->render).brakeLight | 1;
  }
  (carObj->render).brakeLight = uVar4;
  iVar16 = 0;
  if (iVar19 < 0x1c) {
    for (; iVar16 < 0x39; iVar16 = iVar16 + 1) {
      cVar15 = R3DCar_ObjectInfo[0][iVar20];
      switch((cVar15 + -2) * 0x10000 >> 0x10) {
      case 0:
      case 7:
        uVar4 = (carObj->render).inside & 1;
        goto R_ICFt_partVisibilityJoin;
      case 1:
      case 2:
        if ((carObj->render).inside == 0) {
          cVar15 = '\0';
        }
        break;
      case 3:
        uVar4 = (carObj->render).damageParts & 1;
        goto R_ICFt_partVisibilityJoin;
      case 4:
        uVar4 = (carObj->render).damageParts & 2;
        goto R_ICFt_partVisibilityJoin;
      case 5:
        uVar8 = (u_int)(u_short)(carObj->render).headLight;
R_ICFt_brakeAIBranch:
        if ((uVar8 & 2) == 0) {
          cVar15 = '\0';
        }
        break;
      case 6:
        if (((carObj->render).headLight & 0x20U) == 0) {
          cVar15 = '\0';
        }
        break;
      default:
        goto switchD_800b03ec_caseD_8;
      case 9:
        uVar4 = (u_char)(carObj->render).upgradeFlags & 4;
        goto R_ICFt_partVisibilityJoin;
      case 10:
        if (((carObj->render).upgradeFlags & 4U) == 0) {
          cVar15 = '\0';
        }
        break;
      case 0xb:
        uVar4 = (u_char)(carObj->render).upgradeFlags & 1;
R_ICFt_partVisibilityJoin:
        if (uVar4 != 0) {
switchD_800b03ec_caseD_f:
          cVar15 = '\0';
switchD_800b03ec_caseD_8: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
        }
        break;
      case 0xc:
        if (((carObj->render).upgradeFlags & 1U) == 0) {
          cVar15 = '\0';
        }
        break;
      case 0xd:
cfLbl1:   /* @0x800b0524  (-f-build goto label) */
        if (bVar1) {
R_ICFt_caseE_dmgCheck:
          uVar4 = (carObj->render).damageParts & 4;
          goto R_ICFt_partVisibilityJoin;
        }
        break;
      case 0xe:
        if (bVar1) goto R_ICFt_caseE_dmgCheck;
      case 0xf:
        goto switchD_800b03ec_caseD_f;
      case 0x10:
        if ((carObj->render).brakeLight == 0) {
R_ICFt_brakeLightCheck:
          if (bVar1) {
            uVar8 = carObj->AIFlags;
            goto R_ICFt_brakeAIBranch;
          }
          goto switchD_800b03ec_caseD_f;
        }
        break;
      case 0x11:
        if ((carObj->control).gear != '\0') goto R_ICFt_brakeLightCheck;
        break;
      case 0x12:
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) goto cfLbl1;
        goto switchD_800b03ec_caseD_f;
      case 0x13:
        if (bVar1) {
          if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) goto R_ICFt_caseE_dmgCheck;
          goto switchD_800b03ec_caseD_f;
        }
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) break;
        if (""[iVar19] == '\0') goto switchD_800b03ec_caseD_f;
        bVar2 = iVar16 - 6U < 6;
        if ((carObj->render).brakeLight == 0) {
          cVar15 = '\0';
        }
        goto R_ICFt_postSwitchVis;
      case 0x14:
        if (((carObj->render).headLight & 0x11U) == 0) {
          cVar15 = '\0';
        }
      }
      bVar2 = iVar16 - 6U < 6;
R_ICFt_postSwitchVis:
      if (bVar2) {
        /* #148: restored to source-level switch(iVar16). The compiler emitted a 6-entry jumptable
         * @0x80056470 for indices 6..11 -> {6,7:0x800b05f4(A) 8,9:0x800b0600(B) 10,11:0x800b0648(C)};
         * Ghidra rendered it as switch-on-target-VA against an (empty) recovered jt array, which broke
         * the dispatch. Index->body mapping read from nfs4-f.exe rodata. */
        switch (iVar16) {
        case 6: case 7:
          uVar4 = (carObj->render).damageParts & 0x18;
          break;
        case 8: case 9:
          if (((carObj->render).damageParts & 4U) != 0) {
            bVar14 = ""[iVar19] & 1;
            if (((carObj->render).upgradeFlags & 4U) == 0) {
              bVar14 = ""[iVar19] & 0x80;
            }
            cVar15 = '\0';
            if (bVar14 != 0) {
              cVar15 = '\v';
            }
          }
          goto R_ICFt_postVisibility;
        case 10: case 11:
          uVar4 = (carObj->render).damageParts & 4;
        }
        if (uVar4 != 0) {
          cVar15 = '\0';
        }
      }
R_ICFt_postVisibility:
      R3DCar_ObjectVisible[iVar16] = cVar15;
      iVar20 = iVar20 + 6;
    }
  }
  else {
    for (; iVar16 < 0x39; iVar16 = iVar16 + 1) {
      cVar15 = R3DCar_ObjectInfo[0][iVar20];
      if (cVar15 == '\x12') {
        uVar8 = (u_int)(carObj->render).brakeLight;
cfLbl2:   /* @0x800b06f4  (-f-build goto label) */
        if (uVar8 == 0) {
R_ICFt_brakeLightVis:
          cVar15 = '\0';
        }
      }
      else {
        if ('\x12' < cVar15) {
          if (cVar15 == '\x16') {
            uVar8 = (u_short)(carObj->render).headLight & 0x11;
            goto cfLbl2;
          }
          goto R_ICFt_brakeLightVis;
        }
        if (cVar15 != '\x01') {
          cVar15 = '\0';
        }
      }
      if ((iVar19 == 0x1c) && (iVar16 == 0x20)) {
        cVar15 = '\x01';
      }
      R3DCar_ObjectVisible[iVar16] = cVar15;
      iVar20 = iVar20 + 6;
    }
  }
  pTVar17 = R3DCar_LoadedScenePointer[countryFlag][iVar19]->obj[0];
  pmStack_2c = (matrixtdef *)(in_a1 + 0x44);
  iVar16 = (pTVar17->translation).x;
  iVar20 = (pTVar17->translation).y;
  iVar5 = (pTVar17->translation).z;
  iVar6 = 0;
  for (iVar11 = 0; iVar11 < 0x39; iVar11 = iVar11 + 1) {
    pTVar17 = R3DCar_LoadedScenePointer[countryFlag][iVar19]->obj[iVar11];
    if ((pTVar17->numFacet == 0) || (R3DCar_ObjectVisible[iVar11] == '\0'))
    goto R_ICFt_matrixCopyDone;
    if (iVar11 < 0x2f) {
      iVar9 = rideHeight - (carObj->render).currentHeight;
    }
    else {
      iVar7 = carObj->wheel[R3DCar_Suspension[iVar11 + -0x2f]].impactCompression;
      if (iVar7 < 1) {
        iVar9 = -0x1eb8;
        if (-0x1eb9 < iVar7) {
          iVar9 = iVar7;
        }
      }
      else {
        iVar9 = iVar7;
        if (0x1eb8 < iVar7) {
          iVar9 = 0x1eb8;
        }
      }
    }
    tmp.x = (pTVar17->translation).x - iVar16;
    tmp.y = ((pTVar17->translation).y - iVar20) - iVar9;
    tmp.z = (pTVar17->translation).z - iVar5;
    if (iVar11 < 0x2f) {
      if (((0x1b < iVar19) || (iVar11 < 0x23)) || (pmVar13 = &insideMat, 0x28 < iVar11)) {
        pmVar13 = &bodyMat;
      }
    }
    else {
      pmVar13 = &(carObj->N).orientMat;
    }
    transform(&tmp.x,pmVar13->m,&translation.x);
    tmp.x = ((carObj->N).position.x + translation.x) - *(int *)(in_a1 + 8);
    tmp.y = ((carObj->N).position.y + translation.y) - *(int *)(in_a1 + 0xc);
    tmp.z = ((carObj->N).position.z + translation.z) - *(int *)(in_a1 + 0x10);
    transform(&tmp.x,pmStack_2c->m,(int *)((int)R3DCar_position + iVar11 * 0xc));
    if (iVar19 == 0x1c) {
      if (iVar11 == 0x1f) {
        fixedxformy(&tmpMat,(carObj->N).wheelRot[0]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,pmStack_2c,(matrixtdef *)((int)R3DCar_orientMat + 0x45c));
      }
      else {
        if (iVar11 != 0x23) goto switchD_800b0a34_caseD_29;
        fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,pmStack_2c,(matrixtdef *)((int)R3DCar_orientMat + 0x4ec));
      }
      goto R_ICFt_matrixCopyDone;
    }
    switch(iVar11) {
    case 0x23:
    case 0x24:
      pmVar13 = &orientIMat;
      break;
    case 0x25:
      iVar9 = (carObj->control).steering;
      if (rightHandDrive != 0) {
        iVar9 = -iVar9;
      }
      fixedxformz(&tmpMat,iVar9 * -0x38);
      goto R_ICFt_setInsideMat;
    case 0x26:
      iVar7 = (carObj->render).bodyPitch;
      iVar9 = (carObj->render).bodyRoll * 3 >> 1;
      if (rightHandDrive != 0) {
        iVar9 = -iVar9;
      }
      fixedxformz(&matY,iVar9);
      pmVar12 = &mStack_60;
      fixedxformx(pmVar12,iVar7 << 3);
      pmVar13 = &matY;
      goto R_ICFt_matrixPrepY;
    case 0x27:
    case 0x28:
      iVar9 = (carObj->control).steering;
      iVar7 = -0xc;
      if (rightHandDrive != 0) {
        iVar9 = -iVar9;
      }
      angle = iVar9 * -0xc;
      if (iVar11 == 0x27) {
        iVar7 = 0xc;
        angle = iVar9 * 0xc;
      }
      fixedxformx(&matX,angle);
      if (0 < iVar9) {
        iVar9 = -iVar9;
      }
      fixedxformy(&matY,iVar9 * (iVar7 >> 1));
      pmVar13 = &matX;
      pmVar12 = &matY;
R_ICFt_matrixPrepY:
      Math_fasttransmult(pmVar13,pmVar12,&tmpMat);
R_ICFt_setInsideMat:
      pmVar13 = &insideMat;
      goto R_ICFt_matrixSetJoin;
    default:
switchD_800b0a34_caseD_29:
      pmVar13 = &orientMat;
      break;
    case 0x2f:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[0]);
      Math_fasttransmult(&tmpMat,&steerMat,&tmpMat);
      pmVar13 = &(carObj->N).orientMat;
      goto R_ICFt_matrixSetJoin;
    case 0x30:
    case 0x31:
    case 0x32:
    case 0x33:
    case 0x34:
      pmVar13 = (matrixtdef *)((int)R3DCar_orientMat + 0x69c);
      break;
    case 0x35:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
      pmVar13 = &(carObj->N).orientMat;
      goto R_ICFt_matrixSetJoin;
    case 0x36:
      pmVar13 = (matrixtdef *)((int)R3DCar_orientMat + 0x774);
      break;
    case 0x37:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
      pmVar13 = &(carObj->N).orientMat;
R_ICFt_matrixSetJoin:
      Math_fasttransmult(&tmpMat,pmVar13,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)(in_a1 + 0x44),(matrixtdef *)((int)R3DCar_orientMat + iVar6))
      ;
      goto R_ICFt_matrixCopyDone;
    case 0x38:
      pmVar13 = (matrixtdef *)((int)R3DCar_orientMat + 0x7bc);
    }
    R3DCar_MATRIX3DT_Copy(pmVar13->m,(int *)((int)R3DCar_orientMat + iVar6));
R_ICFt_matrixCopyDone:
    iVar6 = iVar6 + 0x24;
  }
  TrsProj_TransformProjectVertex((matrixtdef *)(in_a1 + 0x44),(coorddef *)(in_a1 + 0x38),1,&(carObj->N).position,
             &R3DCar_center);
  if ((R3DCar_shadowColour.r == '\0') || ((carObj->N).simOptz != '\0')) {
    R3DCar_shadowFlag = 0;
  }
  else {
    Newton_CalcRealShadowCoordinates(carObj,simGlobal.gameTicks);
    TrsProj_TransformProjectVertex((matrixtdef *)(in_a1 + 0x44),(coorddef *)(in_a1 + 0x38),4,(carObj->N).shadowCoord,
               R3DCar_shadowVertex);
    R3DCar_shadowFlag = 1;
  }
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    if (Replay_ReplayMode == 2) {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ +
           (short)((carObj->linearVel_ch).z >> (0x12U - Replay_ReplayInterface.speed & 0x1f));
    }
    else {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ + *(short *)((int)&(carObj->linearVel_ch).z + 2);
    }
  }
  iVar19 = DrawC_gShadowMax;
  iVar16 = 0;
  if (0 < DrawC_gEnvMapMax) {
    pDVar10 = DrawC_gEnvMap;
    do {
      if ((carObj->N).simRoadInfo.slice < pDVar10->slice) break;
      iVar16 = iVar16 + 1;
      pDVar10 = pDVar10 + 1;
    } while (iVar16 < DrawC_gEnvMapMax);
  }
  (carObj->N).eIndexEnvMap = (short)iVar16;
  iVar16 = 0;
  if (0 < iVar19) {
    pDVar10 = DrawC_gShadow;
    do {
      if ((carObj->N).simRoadInfo.slice < pDVar10->slice) break;
      iVar16 = iVar16 + 1;
      pDVar10 = pDVar10 + 1;
    } while (iVar16 < iVar19);
  }
  (carObj->N).eIndexShadow = (short)iVar16;
  return;
}

/* ---- R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii  [R3DCAR.CPP:2185-2342] SLD-VERIFIED ---- */
void R3DCar_ReadInCarTextureMenu(Car_tObj *carObj,char *bigfile,int reload,int player)

{
  int carType;
  int infilenames;
  short sVar1;
  char *shpfile;
  char *pcVar2;
  char *pcVar3;
  Texture_pal8bit *palCopy;
  int iVar4;
  int i;
  int iVar5;
  char *bigfile_00;
  char **ppcVar6;
  int index;
  char filename [10];
  char infilename [15];
  char acStack_59 [33];
  char *shpfiles [3];
  
  iVar5 = (int)(carObj->render).currentCarType;
  iVar4 = carObj->carInfo->Country;
  R3DCar_GetCarName(filename,iVar5,iVar4);
  if (reload != 0) {
    CarIO_ReleaseCarCluts(carObj);
  }
  if ((carObj->render).palCopy == (char *)0x0) {
    iVar4 = 0;
    pcVar2 = reservememadr("palCopy",0x28a0,0);
    (carObj->render).palCopy = pcVar2;
  }
  DrawSync(0);
  Texture_palNum = 0;
  if (iVar5 < 0x1c) {
    if (((carObj->render).inside & 1U) == 0) {
      pcVar2 = "";
    }
    else {
      pcVar2 = "h";
    }
    iVar4 = 1;
    R3DCar_GetFileName(infilename,filename,pcVar2);
    if (((carObj->render).inside & 1U) != 0) {
      R3DCar_GetFileName(acStack_59,filename,"i");
      iVar4 = 2;
    }
    if ((carObj->render).colorIndex < 8) {
      pcVar2 = "l";
    }
    else {
      pcVar2 = "d";
    }
    R3DCar_GetFileName(infilename + iVar4 * 0xf,filename,pcVar2);
    iVar5 = 0;
    if (iVar4 != -1) {
      ppcVar6 = shpfiles;
      bigfile_00 = infilename;
      do {
        pcVar3 = locatebig(bigfile,bigfile_00,(int)pcVar2);
        *ppcVar6 = pcVar3;
        ppcVar6 = ppcVar6 + 1;
        iVar5 = iVar5 + 1;
        bigfile_00 = bigfile_00 + 0xf;
      } while (iVar5 < iVar4 + 1);
    }
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    iVar4 = 0;
    if (reload != 0) {
      iVar4 = 0x11;
    }
    iVar5 = 1;
    CarIO_ReadInCarTextureData(shpfiles[0],carObj,iVar4,player);
    if (((carObj->render).inside & 1U) != 0) {
      iVar5 = 2;
      CarIO_ReadInCarTextureData(shpfiles[1],carObj,0x19,player);
    }
    if (iVar4 == 0) {
      iVar4 = 0x91;
    }
    CarIO_ReadInCarTextureData(shpfiles[iVar5],carObj,iVar4,player);
    (carObj->render).palNum = (short)Texture_palNum;
    DrawSync(0);
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,1);
    palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
    sVar1 = (carObj->render).palNum;
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    Texture_ProcessPaletteCopy(palCopy,1,(int)sVar1);
  }
  else {
    strcpy(infilename,filename);
    strcat(infilename,".psh");
    pcVar2 = locatebig(bigfile,infilename,iVar4);
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    if (reload == 0) {
      iVar4 = 0x80;
    }
    else {
      iVar4 = 0x11;
    }
    CarIO_ReadInCarTextureData(pcVar2,carObj,iVar4,0);
    (carObj->render).palNum = (short)Texture_palNum;
    DrawSync(0);
    palCopy = (Texture_pal8bit *)(carObj->render).palCopy;
    sVar1 = (carObj->render).palNum;
    Texture_CarColor = (u_short)(carObj->render).colorIndex & 7;
    Texture_ProcessPaletteCopy(palCopy,0,(int)sVar1);
  }
  purgememadr(bigfile);
  return;
}

/* ---- R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView  [R3DCAR.CPP:2351-3084] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetMenu(Car_tObj *carObj,DRender_tView *Vi)

{
  Transformer_zObj*obj;
  int currentCarType;
  coorddef translation;
  int i;
  int filename;
  int bigname;
  int status;
  int workFile;
  coorddef car;
  coorddef pos;
  coorddef tmp;
  bool bVar1;
  u_char bVar2;
  short sVar3;
  bool bVar4;
  bool bVar5;
  short code;
  char cVar6;
  u_short uVar7;
  char *bigFile;
  int iVar8;
  int iVar9;
  char *addr;
  Transformer_zScene *pTVar10;
  int iVar11;
  int iVar12;
  int iVar13;
  int index;
  GameSetup_tCarData *pGVar14;
  int iVar15;
  int iVar16;
  int suspensionOffset;
  matrixtdef *pmVar17;
  void *pvVar18;
  Transformer_zObj *pTVar19;
  u_int uVar20;
  int changeCar;
  int front;
  Transformer_zScene **ppTVar21;
  int detailIndex;
  int carType;
  int iVar22;
  int cop_flag;
  int countryFlag;
  int reload;
  coorddef parent;
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  coorddef lengthVector;
  coorddef widthVector;
  coorddef frontWidthVector;
  coorddef temp1;
  coorddef temp2;
  coorddef dimension;
  int rideHeight;
  int rightHandDrive;
  
  rightHandDrive = 0;
  rideHeight = (carObj->render).rideHeight;
  iVar22 = (int)(carObj->render).currentCarType;
  bVar2 = (u_char)(carObj->render).currentCountry >> 7;
  bVar5 = false;
  if ((iVar22 < 0x1c) && (rightHandDrive = (int)R3DCar_ForceDriveSide[iVar22], rightHandDrive < 0))
  {
    rightHandDrive = AITune_trackInfo[GameSetup_gData.track].driveSide + 1 >> 1 ^ 1;
  }
  iVar22 = carObj->carInfo->carType;
  R3DCar_rightHandDrive = rightHandDrive;
  bVar4 = 5 < iVar22 - 0x16U;
  if (bVar4) {
    carObj->carInfo->Country = 0;
  }
  uVar20 = R3DCar_InMenu & 0x80;
  (carObj->render).sub_ot =
       R3DCar_subOtStart[gFlip][uVar20 != 0] + ((carObj->N).objID & 0xfU) * 0x200;
  if (uVar20 != 0) goto R_ICFtMenu_sceneCounterJoin;
  (carObj->render).sub_otSize = 0x200;
  (carObj->render).sub_otOffset = 0x100;
  (carObj->render).sort_carObj = (u_char *)0x0;
  (carObj->render).sort_flag = 0;
  pvVar18 = (void *)R3DCar_aSyncLoading;
  DrawC_gScreenMat.m[0][0] = 0x1000;
  DrawC_gScreenMat.m[1][0] = 0;
  DrawC_gScreenMat.m[2][0] = 0;
  DrawC_gScreenMat.m[0][1] = 0;
  DrawC_gScreenMat.m[1][1] = -0x1000;
  DrawC_gScreenMat.m[2][1] = 0;
  DrawC_gScreenMat.m[0][2] = 0;
  DrawC_gScreenMat.m[1][2] = 0;
  DrawC_gScreenMat.m[2][2] = 0x1000;
  DrawC_gScreenMat.t[0] = 0;
  DrawC_gScreenMat.t[1] = 0;
  DrawC_gScreenMat.t[2] = 0;
  bVar1 = -1 < R3DCar_aSyncLoading;
  (carObj->render).detail = 0;
  if ((bVar1) && (pvVar18 != (void *)Vi->player)) goto R_ICFtMenu_sceneCounterJoin;
  if (carObj->async_handle == 0) {
    if ((u_int)(u_char)(carObj->render).newCountry != carObj->carInfo->Country) {
      (carObj->render).newCarType = (carObj->render).newCarType | 0x80;
    }
    if (carObj->async_handle != 0) goto R_ICFtMenu_asyncHandleCheck;
    if ((carObj->render).newCarType != iVar22) {
      iVar8 = AudioMus_Buffered();
      iVar9 = AudioMus_Threshold();
      if (iVar9 <= iVar8) {
        if (iVar22 < 0x1c) {
          uVar7 = (carObj->render).inside | 0x10;
        }
        else {
          uVar7 = (carObj->render).inside & 0xef;
        }
        (carObj->render).inside = uVar7;
        sprintf((char *)&lengthVector,"zz%s",GameSetup_gCarNames[0] + iVar22 * 5);
        if (!bVar4) {
          ((char *)&lengthVector)[2] =
               R3DCar_CopCountry[(u_char)R3DCar_CopIndex[iVar22 + -0x16][carObj->carInfo->Country]];
        }
        strcpy((char *)&widthVector,Paths_Paths[0x18]);
        strcat((char *)&widthVector,(char *)&lengthVector);
        if (((carObj->render).inside & 0x10U) != 0) {
          strcat((char *)&widthVector,"h");
        }
        strcat((char *)&widthVector,".viv");
        pvVar18 = (void *)0x10;
        iVar8 = asyncloadfile((char *)&widthVector,(void *)0x10);
        carObj->async_handle = iVar8;
        R3DCar_aSyncLoading = Vi->player;
        pGVar14 = carObj->carInfo;
        (carObj->render).newCarType = (short)iVar22;
        (carObj->render).newCountry = (char)pGVar14->Country;
      }
    }
    if (carObj->async_handle != 0) goto R_ICFtMenu_asyncHandleCheck;
  }
  else {
R_ICFtMenu_asyncHandleCheck:
    iVar8 = getasyncreadstatus(carObj->async_handle);
    if ((iVar8 < 1) && (iVar8 != -1)) {
      if (iVar8 == -2) {
R_ICFtMenu_asyncAbort:
        uVar7 = (carObj->render).newCarType;
        carObj->async_handle = 0;
R_ICFtMenu_markNewCarType:
        (carObj->render).newCarType = uVar7 | 0x80;
      }
    }
    else {
      if (((carObj->render).newCarType == iVar22) &&
         ((u_int)(u_char)(carObj->render).newCountry == carObj->carInfo->Country)) {
        addr = getasyncreadadr(carObj->async_handle,pvVar18);
        R3DCar_BigFile = addr;
        if (addr == (char *)0x0) {
          bVar5 = false;
          goto R_ICFtMenu_sceneCounterJoin;
        }
        carObj->async_handle = 0;
        if (iVar8 != -1) {
          R3DCar_aSyncLoading = -1;
          goto R_ICFtMenu_bigFileCheck;
        }
        purgememadr(addr);
        uVar7 = (carObj->render).newCarType;
        R3DCar_BigFile = (char *)0x0;
        goto R_ICFtMenu_markNewCarType;
      }
      pvVar18 = getasyncreadadr(carObj->async_handle,pvVar18);
      if (pvVar18 != (void *)0x0) {
        purgememadr(pvVar18);
        goto R_ICFtMenu_asyncAbort;
      }
    }
  }
R_ICFtMenu_bigFileCheck:
  bVar5 = false;
  if (R3DCar_BigFile != (char *)0x0) {
    iVar22 = (int)(carObj->render).currentCarType;
    iVar8 = 0;
    if (-1 < iVar22) {
      cVar6 = R3DCar_LoadedSceneCounter[bVar2][iVar22] + -1;
      R3DCar_LoadedSceneCounter[bVar2][iVar22] = cVar6;
      iVar8 = 1;
      if (cVar6 == '\0') {
        purgememadr(R3DCar_LoadedScenePointer[bVar2][iVar22]);
        R3DCar_LoadedScenePointer[bVar2][iVar22] = (Transformer_zScene *)0x0;
      }
    }
    sVar3 = (carObj->render).newCarType;
    bVar2 = (carObj->render).newCountry;
    (carObj->render).currentCarType = sVar3;
    (carObj->render).currentCountry = bVar2;
    iVar22 = (int)sVar3;
    if (Vi->player != 0) {
      (carObj->render).currentCountry = bVar2 | 0x80;
    }
    bVar2 = (u_char)(carObj->render).currentCountry >> 7;
    (carObj->render).inside = (carObj->render).inside >> 4;
    sprintf((char *)&lengthVector,"zz%s",GameSetup_gCarNames[0] + iVar22 * 5);
    if (!bVar4) {
      ((char *)&lengthVector)[2] =
           R3DCar_CopCountry[(u_char)R3DCar_CopIndex[iVar22 + -0x16]
                           [(u_char)(carObj->render).currentCountry & 0x7f]];
    }
    strcpy((char *)&widthVector,(char *)&lengthVector);
    if (((carObj->render).inside & 1U) != 0) {
      strcat((char *)&widthVector,"h");
    }
    ppTVar21 = R3DCar_LoadedScenePointer[bVar2] + iVar22;
    if (*ppTVar21 != (Transformer_zScene *)0x0) {
      purgememadr(*ppTVar21);
      *ppTVar21 = (Transformer_zScene *)0x0;
    }
    pTVar10 = R3DCar_ReadInCarData((char *)&widthVector,carObj);
    *ppTVar21 = pTVar10;
    R3DCar_LoadedSceneCounter[bVar2][iVar22] = R3DCar_LoadedSceneCounter[bVar2][iVar22] + '\x01';
    R3DCar_CalcCarDimensions(carObj,*ppTVar21,iVar22);
    R3DCar_ReadInCarTextureMenu(carObj,R3DCar_BigFile,iVar8,Vi->player);
    R3DCar_BigFile = (char *)0x0;
    bVar5 = true;
  }
R_ICFtMenu_sceneCounterJoin:
  iVar22 = (int)(carObj->render).currentCarType;
  bVar2 = (u_char)(carObj->render).currentCountry >> 7;
  bVar4 = 5 < iVar22 - 0x16U;
  if (((R3DCar_InMenu & 0x80U) == 0) && (iVar22 < 0)) {
    (carObj->render).detail = -1;
  }
  if (-1 < (carObj->render).detail) {
    if ((R3DCar_InMenu & 0x80U) == 0) {
      if (bVar4) {
        if (bVar5) {
          (carObj->render).brakeLight = 0;
        }
      }
      else {
        if (((carObj->render).signalLight[0] & 0x80U) == 0) {
          (carObj->render).signalLight[0] = 0x80;
          (carObj->render).signalLight[1] = 0x88;
        }
        if (R3DCar_Clock != 0) {
          uVar7 = (carObj->render).signalLight[0];
          if ((uVar7 & 0x80) != 0) {
            (carObj->render).signalLight[0] = uVar7 + 1 & 0x8f;
          }
          uVar7 = (carObj->render).signalLight[1];
          if ((uVar7 & 0x80) != 0) {
            (carObj->render).signalLight[1] = uVar7 + 1 & 0x8f;
          }
        }
        if (bVar5) {
          (carObj->render).headLight = 0x33;
          (carObj->render).brakeLight = 2;
        }
      }
    }
    if (iVar22 < 0x1c) {
      if (((carObj->render).upgradeFlags & 2U) != 0) {
        rideHeight = (carObj->render).upgradeHeight;
      }
    }
    else {
      rideHeight = 0;
    }
    if (((carObj->render).detail == 0) && (0x1b < iVar22)) {
      (carObj->render).detail = 1;
    }
    iVar8 = (int)(carObj->render).detail;
    if ((iVar8 == 2) && (iVar22 == 0x1c)) {
      (carObj->render).detail = 1;
      iVar8 = (int)(carObj->render).detail;
    }
    iVar8 = iVar8 + 2;
    if ((R3DCar_InMenu & 0x80U) == 0) {
      (carObj->N).position.y = (carObj->N).position.y + (carObj->N).dimension.y;
    }
    else {
      (carObj->N).position.y = (carObj->N).position.y + (carObj->N).dimension.y * -2;
    }
    lengthVector.x = (carObj->N).position.x - (Vi->cview).translation.x;
    lengthVector.y = (carObj->N).position.y - (Vi->cview).translation.y;
    lengthVector.z = (carObj->N).position.z - (Vi->cview).translation.z;
    iVar9 = lengthVector.x;
    if (lengthVector.x < 0) {
      iVar9 = lengthVector.x + 0xff;
    }
    iVar11 = (carObj->N).orientMat.m[0];
    if (iVar11 < 0) {
      iVar11 = iVar11 + 0xff;
    }
    iVar16 = lengthVector.y;
    if (lengthVector.y < 0) {
      iVar16 = lengthVector.y + 0xff;
    }
    iVar12 = (carObj->N).orientMat.m[1];
    if (iVar12 < 0) {
      iVar12 = iVar12 + 0xff;
    }
    iVar15 = lengthVector.z;
    if (lengthVector.z < 0) {
      iVar15 = lengthVector.z + 0xff;
    }
    iVar13 = (carObj->N).orientMat.m[2];
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    widthVector.x =
         (iVar9 >> 8) * (iVar11 >> 8) + (iVar16 >> 8) * (iVar12 >> 8) +
         (iVar15 >> 8) * (iVar13 >> 8);
    iVar11 = (carObj->N).orientMat.m[6];
    if (iVar11 < 0) {
      iVar11 = iVar11 + 0xff;
    }
    iVar12 = (carObj->N).orientMat.m[7];
    if (iVar12 < 0) {
      iVar12 = iVar12 + 0xff;
    }
    iVar15 = lengthVector.z;
    if (lengthVector.z < 0) {
      iVar15 = lengthVector.z + 0xff;
    }
    iVar13 = (carObj->N).orientMat.m[8];
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    widthVector.z =
         (iVar9 >> 8) * (iVar11 >> 8) + (iVar16 >> 8) * (iVar12 >> 8) +
         (iVar15 >> 8) * (iVar13 >> 8);
    iVar9 = fixedatan(widthVector.x,widthVector.z);
    pmVar17 = &(carObj->N).orientMat;
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xf;
    }
    R3DCar_yawCam = 0x1000 - (short)(iVar9 >> 4);
    R3DCar_MATRIX3DT_Copy(pmVar17->m,bodyMat.m);
    R3DCar_MATRIX3DT_Copy(pmVar17->m,insideMat.m);
    if ((R3DCar_InMenu & 0x80U) == 0) {
      if (rightHandDrive != 0) {
        insideMat.m[0] = -insideMat.m[0];
        insideMat.m[2] = -insideMat.m[2];
        insideMat.m[1] = -insideMat.m[1];
      }
    }
    else {
      bodyMat.m[3] = -bodyMat.m[3];
      bodyMat.m[5] = -bodyMat.m[5];
      bodyMat.m[4] = -bodyMat.m[4];
    }
    pmVar17 = &(Vi->cview).mrotationInv;
    Math_fasttransmult(&bodyMat,pmVar17,&orientMat);
    Math_fasttransmult(&insideMat,pmVar17,&orientIMat);
    iVar9 = 0;
    if (iVar22 < 0x1c) {
      for (; iVar9 < 0x39; iVar9 = iVar9 + 1) {
        cVar6 = R3DCar_ObjectInfo[0][iVar8];
        switch((cVar6 + -2) * 0x10000 >> 0x10) {
        case 0:
          if (((carObj->render).inside & 1U) != 0) goto R_ICFtMenu_clearVisibility;
        case 1:
          if ((R3DCar_InMenu & 0x80U) != 0) {
            cVar6 = '\0';
          }
          break;
        case 2:
        case 8:
R_ICFtMenu_clearVisibility:
          cVar6 = '\0';
        default:
          break;
        case 5:
          if (((carObj->render).headLight & 2U) == 0) {
            cVar6 = '\0';
          }
          break;
        case 6:
          if (((carObj->render).headLight & 0x20U) == 0) {
            cVar6 = '\0';
          }
          break;
        case 7:
          uVar7 = (carObj->render).inside;
          goto R_ICFtMenu_caseB_upgrade;
        case 9:
          if (((carObj->render).upgradeFlags & 4U) != 0) {
            cVar6 = '\0';
          }
          break;
        case 10:
          if (((carObj->render).upgradeFlags & 4U) == 0) {
            cVar6 = '\0';
          }
          break;
        case 0xb:
          uVar7 = (u_short)(u_char)(carObj->render).upgradeFlags;
R_ICFtMenu_caseB_upgrade:
          if ((uVar7 & 1) != 0) {
            cVar6 = '\0';
          }
          break;
        case 0xc:
          if (((carObj->render).upgradeFlags & 1U) == 0) {
            cVar6 = '\0';
          }
          break;
        case 0xe:
        case 0x11:
          if (bVar4) goto R_ICFtMenu_clearVisibility;
          break;
        case 0x14:
          if (((carObj->render).headLight & 0x11U) == 0) {
            cVar6 = '\0';
          }
        }
        R3DCar_ObjectVisible[iVar9] = cVar6;
        iVar8 = iVar8 + 6;
      }
    }
    else {
      for (; iVar9 < 0x39; iVar9 = iVar9 + 1) {
        cVar6 = R3DCar_ObjectInfo[0][iVar8];
        if (cVar6 != '\x12') {
          if (cVar6 < '\x13') {
            if (cVar6 != '\x01') {
              cVar6 = '\0';
            }
          }
          else if (cVar6 != '\x16') {
            cVar6 = '\0';
          }
        }
        if ((iVar22 == 0x1c) && (iVar9 == 0x20)) {
          cVar6 = '\x01';
        }
        R3DCar_ObjectVisible[iVar9] = cVar6;
        iVar8 = iVar8 + 6;
      }
    }
    pTVar19 = R3DCar_LoadedScenePointer[bVar2][iVar22]->obj[0];
    iVar8 = (pTVar19->translation).x;
    iVar9 = (pTVar19->translation).y;
    iVar12 = 0;
    iVar11 = (pTVar19->translation).z;
    iVar15 = 0;
    for (iVar16 = 0; iVar16 < 0x39; iVar16 = iVar16 + 1) {
      pTVar19 = R3DCar_LoadedScenePointer[bVar2][iVar22]->obj[iVar16];
      if ((pTVar19->numFacet != 0) && (R3DCar_ObjectVisible[iVar16] != '\0')) {
        if ((iVar16 == 0xf) || (suspensionOffset = rideHeight, 0x2e < iVar16)) {
          suspensionOffset = 0;
        }
        widthVector.x = (pTVar19->translation).x - iVar8;
        widthVector.y = ((pTVar19->translation).y - iVar9) - suspensionOffset;
        widthVector.z = (pTVar19->translation).z - iVar11;
        if (((0x1b < iVar22) || (iVar16 < 0x23)) || (pmVar17 = &insideMat, 0x28 < iVar16)) {
          pmVar17 = &bodyMat;
        }
        transform(&widthVector.x,pmVar17->m,&lengthVector.x);
        widthVector.x = ((carObj->N).position.x + lengthVector.x) - (Vi->cview).translation.x;
        widthVector.y = ((carObj->N).position.y + lengthVector.y) - (Vi->cview).translation.y;
        widthVector.z = ((carObj->N).position.z + lengthVector.z) - (Vi->cview).translation.z;
        transform(&widthVector.x,(Vi->cview).mrotationInv.m,(int *)((int)R3DCar_position + iVar15))
        ;
        if (((0x1b < iVar22) || (iVar16 < 0x23)) || (pmVar17 = &orientIMat, 0x28 < iVar16)) {
          pmVar17 = &orientMat;
        }
        R3DCar_MATRIX3DT_Copy(pmVar17->m,(int *)((int)R3DCar_orientMat + iVar12));
      }
      iVar12 = iVar12 + 0x24;
      iVar15 = iVar15 + 0xc;
    }
    TrsProj_TransformProjectVertex(&(Vi->cview).mrotationInv,&(Vi->cview).translationInv,1,&(carObj->N).position,
               &R3DCar_center);
    if ((R3DCar_InMenu & 0x80U) == 0) {
      iVar8 = (carObj->N).dimension.x;
      iVar22 = (carObj->N).dimension.z;
      lengthVector.x = fixedmult(iVar22,(carObj->N).orientMat.m[6]);
      lengthVector.y = fixedmult(iVar22,(carObj->N).orientMat.m[7]);
      lengthVector.z = fixedmult(iVar22,(carObj->N).orientMat.m[8]);
      widthVector.x = fixedmult(iVar8,(carObj->N).orientMat.m[0]);
      widthVector.y = fixedmult(iVar8,(carObj->N).orientMat.m[1]);
      widthVector.z = fixedmult(iVar8,(carObj->N).orientMat.m[2]);
      if ((carObj->render).currentCarType == 0x14) {
        iVar22 = iVar8 * 0xc0 >> 8;
        frontWidthVector.x = fixedmult(iVar22,(carObj->N).orientMat.m[0])
        ;
        frontWidthVector.y = fixedmult(iVar22,(carObj->N).orientMat.m[1])
        ;
        frontWidthVector.z = fixedmult(iVar22,(carObj->N).orientMat.m[2])
        ;
      }
      else {
        frontWidthVector.x = widthVector.x;
        frontWidthVector.y = widthVector.y;
        frontWidthVector.z = widthVector.z;
      }
      iVar11 = (carObj->N).position.x;
      iVar8 = (carObj->N).position.z;
      iVar9 = iVar11 + lengthVector.x;
      iVar22 = iVar8 + lengthVector.z;
      (carObj->N).shadowCoord[0].x = iVar9 - frontWidthVector.x;
      (carObj->N).shadowCoord[0].y = lengthVector.y - frontWidthVector.y;
      (carObj->N).shadowCoord[0].z = iVar22 - frontWidthVector.z;
      (carObj->N).shadowCoord[1].x = iVar9 + frontWidthVector.x;
      (carObj->N).shadowCoord[1].y = lengthVector.y + frontWidthVector.y;
      (carObj->N).shadowCoord[1].z = iVar22 + frontWidthVector.z;
      iVar11 = iVar11 - lengthVector.x;
      iVar8 = iVar8 - lengthVector.z;
      (carObj->N).shadowCoord[2].x = iVar11 - widthVector.x;
      (carObj->N).shadowCoord[2].y = -lengthVector.y - widthVector.y;
      (carObj->N).shadowCoord[2].z = iVar8 - widthVector.z;
      (carObj->N).shadowCoord[3].x = iVar11 + widthVector.x;
      (carObj->N).shadowCoord[3].y = -lengthVector.y + widthVector.y;
      (carObj->N).shadowCoord[3].z = iVar8 + widthVector.z;
      TrsProj_TransformProjectVertex(&(Vi->cview).mrotationInv,&(Vi->cview).translationInv,4,(carObj->N).shadowCoord,
                 R3DCar_shadowVertex);
    }
  }
  return;
}

/* ---- R3DCar_InsertCarFacetII__FP8Car_tObj  [R3DCAR.CPP:3091-3270] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetII(Car_tObj *carObj)

{
  int light;
  int lightR;
  int lightG;
  int lightB;
  int inAir;
  u_char bVar1;
  bool bVar2;
  int iVar3;
  int cop_type;
  u_int uVar4;
  int iVar5;
  int index;
  int iVar6;
  int copIndex;
  Transformer_zOverlay *overlay_00;
  u_int uVar7;
  u_int envmap;
  int clip;
  Transformer_zObj *obj;
  Transformer_zObj *obj_00;
  int type;
  int offset;
  int iVar8;
  Draw_CarCache *in_t1;
  int visible;
  int i;
  int iVar9;
  int carType;
  int iVar10;
  Draw_CarCache *sd;
  int iVar11;
  int iVar12;
  int lightAvg;
  int countryFlag;
  int mirror;
  Transformer_zObj *in_stack_ffffffa8;
  int in_stack_ffffffac;
  int worldZ;
  int rightHandDrive;
  Transformer_zOverlay *overlay;
  int reflect;
  int iStack_2c;
  
  iVar3 = R3DCar_rightHandDrive;
  reflect = 0;
  iVar10 = (int)(carObj->render).currentCarType;
  bVar1 = (u_char)(carObj->render).currentCountry >> 7;
  overlay_00 = R3DCar_LoadedScenePointer[bVar1][iVar10]->overlay;
  if (((carObj->wheel[0].wheelInAir == 0 && carObj->wheel[1].wheelInAir == 0) &&
      carObj->wheel[2].wheelInAir == 0) && carObj->wheel[3].wheelInAir == 0) {
    if (GameSetup_gData.Time == 0) {
      reflect = (u_int)(DrawC_gWetRoad != 0);
    }
    else {
      if (GameSetup_gData.commMode == 1) {
        reflect = -1;
        if (DrawC_gWetRoad == 0) goto R_ICFtII_setQuadLight;
        iVar5 = 1;
      }
      else {
        iVar5 = -2;
        if (DrawC_gWetRoad == 0) goto R_ICFtII_setQuadLight;
      }
      reflect = iVar5;
    }
  }
R_ICFtII_setQuadLight:
  uVar4 = BWorldSm_QuadLight(&(carObj->N).simRoadInfo);
  (carObj->render).light = uVar4 & 0xffffff;
  if (-1 < (carObj->render).detail) {
    if (gNight_renderNight != 0) {
      DrawC_NightHeadlight(carObj);
    }
    uVar4 = (carObj->render).light;
    uVar4 = ((uVar4 & 0xff) + ((int)(uVar4 & 0xff00) >> 8) + (uVar4 >> 0x10 & 0xff)) / 3;
    iVar5 = uVar4 * 0x10000;
    if (uVar4 < 0x18) {
      uVar4 = 0x18;
      iVar5 = 0x180000;
    }
    INT_1f80008c = iVar5 + uVar4 * 0x101;
    iVar5 = DrawC_PrimStart(&R3DCar_center,carObj,uVar4,(Draw_CarCache *)&Render_gPalettePtr);
    if (-1 < iVar5) {
      iVar12 = 0;
      iVar11 = 0;
      iStack_2c = 0;
      for (iVar9 = 0; iVar9 < 0x39; iVar9 = iVar9 + 1) {
        obj_00 = R3DCar_LoadedScenePointer[bVar1][iVar10]->obj[iVar9];
        in_t1 = (Draw_CarCache *)(u_int)(u_char)R3DCar_ObjectVisible[iVar9];
        if ((obj_00->numFacet != 0) && (in_t1 != (Draw_CarCache *)0x0)) {
          uVar7 = (u_int)R3DCar_ObjectInfo[0][iStack_2c * 2 + 1];
          iVar8 = (int)R3DCar_ObjectInfo[0][iStack_2c * 2];
          bVar2 = false;
          if ((iVar10 < 0x1c) && ((iVar9 - 0x1cU < 2 && (""[iVar10] != '\0')))) {
            iVar8 = -iVar8;
          }
          if (((iVar3 != 0) && (0x22 < iVar9)) && (iVar9 < 0x29)) {
            bVar2 = true;
            Render_gMenuRenderFlag = Render_gMenuRenderFlag ^ 1;
          }
          in_t1 = (Draw_CarCache *)&in_t1[-1].offsetV0;
          if ((int)in_t1 < 0) {
            iVar6 = 0x20;
            if (iVar10 < 0x1c) {
              envmap = uVar7;
              if (R3DCar_eMapColour.r == '\0') {
                envmap = uVar7 & 0xfe;
              }
              if (((uVar7 & 0x10) != 0) && (0x15 < iVar10)) {
                iVar8 = iVar8 + 0xc;
              }
            }
            else {
              iVar6 = 0x40;
              envmap = 0x22;
              if ((iVar10 == 0x1c) && (iVar9 == 0x23)) {
                iVar8 = 4;
              }
            }
            if ((carObj->render).detail == 3) {
              envmap = envmap | 0x20;
              iVar8 = -iVar8;
              if (iVar9 - 0x27U < 2) {
                iVar8 = iVar8 + -0x10;
              }
            }
            R3DCar_gFacetScratch = (carObj->render).sub_otz + iVar8;
            if (iVar5 < iVar6) {
              DrawC_PrimClip((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj_00,overlay_00,envmap,
                         (Draw_CarCache *)&Render_gPalettePtr);
            }
            else {
              DrawC_Prim((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj_00,overlay_00,envmap,
                         (Draw_CarCache *)&Render_gPalettePtr);
            }
          }
          else {
            iVar6 = -1;
            if (iVar10 < 0x1c) {
              iVar6 = (int)R3DCar_FlareOverlayIndex[(int)in_t1];
            }
            R3DCar_gFacetScratch = (carObj->render).sub_otz + iVar8;
            DrawC_PrimHalo((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                       (coorddef *)((int)R3DCar_position + iVar12),in_stack_ffffffa8,
                       in_stack_ffffffac,iVar6,reflect,(Draw_CarCache *)&Render_gPalettePtr);
          }
          if (bVar2) {
            Render_gMenuRenderFlag = Render_gMenuRenderFlag ^ 1;
          }
        }
        iVar12 = iVar12 + 0xc;
        iVar11 = iVar11 + 0x24;
        iStack_2c = iStack_2c + 3;
      }
      DrawC_PrimStop(carObj,in_t1);
      if (R3DCar_shadowFlag != 0) {
        INT_1f80008c = ((int)(uVar4 * R3DCar_shadowColour.b) >> 8) * 0x10000 +
                       ((int)(uVar4 * R3DCar_shadowColour.g) >> 8) * 0x100 +
                       ((int)(uVar4 * R3DCar_shadowColour.r) >> 8);
        if (iVar5 < 0x20) {
          DrawC_ShadowPrimClip(R3DCar_shadowVertex,(Draw_CarCache *)&Render_gPalettePtr);
        }
        else {
          DrawC_ShadowPrim(R3DCar_shadowVertex,(Draw_CarCache *)&Render_gPalettePtr);
        }
      }
    }
  }
  return;
}

/* ---- R3DCar_InsertCarFacetMenuII__FP8Car_tObji  [R3DCAR.CPP:3273-3395] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetMenuII(Car_tObj *carObj,int light)

{
  int lightAvg;
  u_char bVar1;
  bool bVar2;
  int iVar3;
  int cop_type;
  Transformer_zScene *pTVar4;
  int iVar5;
  int index;
  int index_00;
  int copIndex;
  Transformer_zObj *obj;
  Transformer_zObj *obj_00;
  int type;
  int offset;
  int iVar6;
  Draw_CarCache *in_t1;
  int visible;
  int envmap;
  u_int envmap_00;
  u_int uVar7;
  int i;
  int iVar8;
  int carType;
  int iVar9;
  Draw_CarCache *sd;
  char (*pacVar10) [6];
  int iVar11;
  int countryFlag;
  int mirror;
  Transformer_zObj *in_stack_ffffffb0;
  int in_stack_ffffffb4;
  int rightHandDrive;
  Transformer_zOverlay *overlay;
  
  iVar3 = R3DCar_rightHandDrive;
  iVar9 = (int)(carObj->render).currentCarType;
  bVar1 = (u_char)(carObj->render).currentCountry >> 7;
  pTVar4 = R3DCar_LoadedScenePointer[bVar1][iVar9];
  if ((R3DCar_InMenu & 0x80U) != 0) {
    light = light >> 1;
  }
  INT_1f80008c = light * 0x10101;
  if (-1 < (carObj->render).detail) {
    iVar5 = DrawC_PrimStart(&R3DCar_center,carObj,light,(Draw_CarCache *)&Render_gPalettePtr);
    iVar8 = 0;
    if (-1 < iVar5) {
      iVar11 = 0;
      iVar5 = 0;
      pacVar10 = R3DCar_ObjectInfo;
      for (; iVar8 < 0x39; iVar8 = iVar8 + 1) {
        obj_00 = R3DCar_LoadedScenePointer[bVar1][iVar9]->obj[iVar8];
        in_t1 = (Draw_CarCache *)(u_int)(u_char)R3DCar_ObjectVisible[iVar8];
        if ((obj_00->numFacet != 0) && (in_t1 != (Draw_CarCache *)0x0)) {
          envmap_00 = (u_int)(*pacVar10)[1];
          iVar6 = (int)(*pacVar10)[0];
          bVar2 = false;
          if ((iVar9 < 0x1c) && ((iVar8 - 0x1cU < 2 && (""[iVar9] != '\0')))) {
            iVar6 = -iVar6;
          }
          if (((iVar3 != 0) && (0x22 < iVar8)) && (iVar8 < 0x29)) {
            bVar2 = true;
            Render_gMenuRenderFlag = Render_gMenuRenderFlag ^ 1;
          }
          in_t1 = (Draw_CarCache *)&in_t1[-1].offsetV0;
          if ((int)in_t1 < 0) {
            if (iVar9 < 0x1c) {
              if ((envmap_00 & 0x10) != 0) {
                uVar7 = envmap_00 & 0x80;
                if (iVar9 < 0x16) goto R_ICFtMenuII_emitPrimMenu;
                iVar6 = iVar6 + 0xc;
                if ((R3DCar_InMenu & 0x80U) != 0) {
                  iVar6 = -iVar6;
                }
              }
R_ICFtMenuII_envmap80Mask:
              uVar7 = envmap_00 & 0x80;
            }
            else {
              uVar7 = envmap_00 & 0x80;
              envmap_00 = uVar7;
              if (iVar9 != 0x1c) goto R_ICFtMenuII_envmap80Mask;
              if (iVar8 == 0x23) {
                iVar6 = 4;
              }
            }
R_ICFtMenuII_emitPrimMenu:
            if ((uVar7 != 0) && ((R3DCar_InMenu & 0x80U) != 0)) {
              iVar6 = -iVar6;
            }
            R3DCar_gFacetScratch = (carObj->render).sub_otz + iVar6;
            DrawC_PrimMenu((matrixtdef *)((int)R3DCar_orientMat + iVar5),
                       (coorddef *)((int)R3DCar_position + iVar11),obj_00,pTVar4->overlay,envmap_00,
                       (Draw_CarCache *)&Render_gPalettePtr);
          }
          else {
            index_00 = -1;
            if ((iVar9 < 0x1c) && (0x15 < iVar9)) {
              if (((envmap_00 & 0x10) != 0) && ((R3DCar_InMenu & 0x80U) != 0)) {
                iVar6 = 0;
              }
              index_00 = (int)R3DCar_FlareOverlayIndex[(int)in_t1];
            }
            R3DCar_gFacetScratch = (carObj->render).sub_otz + iVar6;
            DrawC_PrimHalo((matrixtdef *)((int)R3DCar_orientMat + iVar5),
                       (coorddef *)((int)R3DCar_position + iVar11),in_stack_ffffffb0,
                       in_stack_ffffffb4,index_00,0,(Draw_CarCache *)&Render_gPalettePtr);
          }
          if (bVar2) {
            Render_gMenuRenderFlag = Render_gMenuRenderFlag ^ 1;
          }
        }
        iVar11 = iVar11 + 0xc;
        iVar5 = iVar5 + 0x24;
        pacVar10 = pacVar10 + 1;
      }
      DrawC_PrimStop(carObj,in_t1);
      if ((R3DCar_InMenu & 0x80U) == 0) {
        DrawC_ShadowPrimClip(R3DCar_shadowVertex,(Draw_CarCache *)&Render_gPalettePtr);
      }
    }
  }
  return;
}

/* ---- R3DCar_Showroom__FP13DRender_tView  [R3DCAR.CPP:3399-3406] SLD-VERIFIED ---- */
void R3DCar_Showroom(DRender_tView *Vi)

{
  coorddef *t;
  matrixtdef *m;
  
  m = &(Vi->cview).mrotationInv;
  t = &(Vi->cview).translationInv;
  DrawC_ShowroomPrims(m,t,(Draw_CarCache *)0x1f800000);
  DrawC_SpotPrims(m,t,(Draw_CarCache *)0x1f800000);
  return;
}

/* ---- R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView  [R3DCAR.CPP:3411-3412] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetZ(Car_tObj *carObj,DRender_tView *Vi)

{
  DRender_tView *in_stack_ffffffec;
  
  R3DCar_InsertCarFacet(carObj,in_stack_ffffffec);
  return;
}

/* ---- R3DCar_InsertAllListFacet__FP13DRender_tView  [R3DCAR.CPP:3416-3551] SLD-VERIFIED ---- */
void R3DCar_InsertAllListFacet(DRender_tView *Vi)

{
  int size;
  int cop_type;
  int iVar1;
  int iVar2;
  int lightB;
  int sub_otSize;
  Car_tObj *sort_carObj;
  Car_tObj *pCVar3;
  int diffZ;
  int iVar4;
  int type;
  int *piVar5;
  int carZ;
  Car_tObj **ppCVar6;
  int *piVar7;
  int visible;
  int *piVar8;
  int *piVar9;
  int j;
  int iVar10;
  int minWheelZ;
  int sort;
  int iVar11;
  Car_tObj *carObj;
  Car_tObj *pCVar12;
  int maxAngleFactor;
  int i;
  int iVar13;
  int roll;
  Car_tObj **ppCVar14;
  int *piVar15;
  int maxMid;
  int *piVar16;
  int inCarCam;
  int *sort_max;
  int *sort_min;
  coorddef parent;
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  matrixtdef steerMat;
  matrixtdef tmpMat;
  coorddef translation;
  coorddef tmp;
  coorddef lengthVector;
  coorddef widthVector;
  coorddef frontWidthVector;
  coorddef temp1;
  coorddef temp2;
  coorddef dimension;
  int worldZ;
  int reflect;
  int rightHandDrive;
  char workFile [10];
  
  iVar13 = -(((u_int)(Cars_gNumCars << 5) >> 3) + 7 & 0xfffffff8);
  piVar5 = (int *)((int)&rightHandDrive + iVar13);
  piVar7 = (int *)((int)&rightHandDrive +
                  (iVar13 - (((u_int)(Cars_gNumCars << 5) >> 3) + 7 & 0xfffffff8)));
  gWSavePtr = (u_long)SetSp(&gScratchLastWord);
  stackSpeedUpEnbabledFlag = 1;
  iVar13 = 0;
  if (Vi->player == 0) {
    if (R3DCar_ClockLast < generic128HzClock) {
      R3DCar_Clock = 1;
      R3DCar_ClockLast = generic128HzClock + 6;
    }
    else {
      R3DCar_Clock = 0;
    }
  }
  piVar16 = R3DCar_PositionZ;
  ppCVar14 = Cars_gList;
  piVar9 = piVar7;
  piVar15 = piVar5;
  for (; iVar1 = Cars_gNumCars, iVar11 = 1, iVar13 < Cars_gNumCars; iVar13 = iVar13 + 1) {
    pCVar12 = *ppCVar14;
    iVar1 = R3DCar_Visibilty(pCVar12,Vi);
    *piVar16 = iVar1;
    (pCVar12->render).sort_carObj = (u_char *)0x0;
    (pCVar12->render).sort_flag = 0;
    *piVar15 = 0;
    iVar1 = 0x1a0;
    if ((pCVar12->render).currentCarType != 0x1c) {
      iVar1 = (pCVar12->N).dimension.z >> 9;
    }
    *piVar9 = iVar1;
    piVar9 = piVar9 + 1;
    piVar15 = piVar15 + 1;
    piVar16 = piVar16 + 1;
    ppCVar14 = ppCVar14 + 1;
  }
  piVar16 = R3DCar_PositionZ;
  ppCVar14 = Cars_gList;
  rightHandDrive = Cars_gNumCars + -1;
  piVar9 = piVar5;
  piVar15 = piVar7;
  for (iVar13 = 0; iVar10 = Cars_gNumCars, iVar13 < rightHandDrive; iVar13 = iVar13 + 1) {
    if (*piVar16 != -0x80000000) {
      pCVar12 = *ppCVar14;
      piVar8 = R3DCar_PositionZ + iVar11;
      ppCVar6 = Cars_gList + iVar11;
      for (iVar10 = iVar11; iVar10 < iVar1; iVar10 = iVar10 + 1) {
        pCVar3 = *ppCVar6;
        iVar4 = *piVar16 - *piVar8;
        if (((pCVar12->render).sort_carObj == (u_char *)0x0) &&
           ((pCVar3->render).sort_carObj == (u_char *)0x0)) {
          iVar2 = iVar4;
          if (iVar4 < 0) {
            iVar2 = -iVar4;
          }
          if (iVar2 < (pCVar12->N).dimension.z + (pCVar3->N).dimension.z) {
            (pCVar3->render).sort_carObj = (u_char *)pCVar12;
            (pCVar12->render).sort_flag = (pCVar12->render).sort_flag + 1;
            if (iVar4 < 0) {
              *piVar9 = *piVar9 - ((pCVar3->N).dimension.z >> 9);
            }
            else {
              *piVar15 = *piVar15 + ((pCVar3->N).dimension.z >> 9);
            }
          }
        }
        piVar8 = piVar8 + 1;
        ppCVar6 = ppCVar6 + 1;
      }
    }
    iVar11 = iVar11 + 1;
    piVar15 = piVar15 + 1;
    piVar9 = piVar9 + 1;
    piVar16 = piVar16 + 1;
    ppCVar14 = ppCVar14 + 1;
  }
  ppCVar14 = Cars_gList;
  R3DCar_subOt = R3DCar_subOtStart[gFlip][gCView.player];
  piVar9 = R3DCar_PositionZ;
  for (iVar13 = 0; iVar13 < iVar10; iVar13 = iVar13 + 1) {
    if (*piVar9 != -0x80000000) {
      pCVar12 = *ppCVar14;
      *piVar5 = *piVar5 + -0x30;
      iVar1 = *piVar7;
      *piVar7 = iVar1 + 0x30;
      if ((pCVar12->render).sort_carObj == (u_char *)0x0) {
        iVar11 = (iVar1 + 0x30) - *piVar5;
        (pCVar12->render).sub_ot = R3DCar_subOt;
        R3DCar_subOt = R3DCar_subOt + iVar11;
        iVar1 = (pCVar12->N).dimension.z;
        (pCVar12->render).sub_otSize = iVar11;
        (pCVar12->render).sub_otOffset = *piVar7 - (iVar1 >> 10);
      }
      else {
        (pCVar12->render).sub_ot = (u_long *)0x0;
        (pCVar12->render).sub_otSize = 0;
        (pCVar12->render).sub_otOffset = 0;
      }
    }
    piVar7 = piVar7 + 1;
    piVar5 = piVar5 + 1;
    ppCVar14 = ppCVar14 + 1;
    piVar9 = piVar9 + 1;
  }
  DrawC_gScreenMat.m[0][0] = 0x1000;
  DrawC_gScreenMat.m[1][0] = 0;
  DrawC_gScreenMat.m[2][0] = 0;
  DrawC_gScreenMat.m[0][1] = 0;
  DrawC_gScreenMat.m[1][1] = -0x1000;
  DrawC_gScreenMat.m[2][1] = 0;
  DrawC_gScreenMat.m[0][2] = 0;
  DrawC_gScreenMat.m[1][2] = 0;
  DrawC_gScreenMat.m[2][2] = 0x1000;
  DrawC_gScreenMat.t[0] = 0;
  DrawC_gScreenMat.t[1] = 0;
  DrawC_gScreenMat.t[2] = 0;
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  ppCVar14 = Cars_gList;
  stackSpeedUpEnbabledFlag = 0;
  for (iVar13 = 0; iVar13 < Cars_gNumCars; iVar13 = iVar13 + 1) {
    pCVar12 = *ppCVar14;
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    ppCVar14 = ppCVar14 + 1;
    stackSpeedUpEnbabledFlag = 1;
    R3DCar_InsertCarFacetZ(pCVar12,Vi);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    R3DCar_InsertCarFacetII(pCVar12);
  }
  return;
}

/* end of r3dcar.cpp */
