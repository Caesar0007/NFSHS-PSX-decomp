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
short        R3DCar_FlareOverlayIndex[6] = { -1, 24, 26, 27, 28, 29 };   /* @0x8011674c (CORRECTED: SYM/oracle shows `lh` (halfword) indexing at this VA -- the 6-byte gap between the char[6] literal size and the next symbol @0x80116758 is exactly the missing 6 bytes of a short[6]; raw EXE bytes at 0x8011674C confirm ff ff 18 00 1a 00 1b 00 1c 00 1d 00 == the same {-1,24,26,27,28,29} values re-typed short) */
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
short        R3DCar_yawCam;   /* @0x8013d3a4  (bss(zero); oracle stores sh -- short, matches drawc_externs.h) */
int          R3DCar_Clock;   /* @0x8013d3a8  (bss(zero)) */
int          R3DCar_ClockLast;   /* @0x8013d3ac  (bss(zero)) */
char         *R3DCar_BigFile;   /* @0x8013d3b0  (bss(zero)) */
char         *R3DCar_LicenseShapeFile;   /* @0x8013d3b4  (bss(zero)) */
u_long       *R3DCar_subOt;   /* @0x8013d3b8  (bss(zero)) */
int          R3DCar_rightHandDrive;   /* @0x8013d3bc  (bss(zero)) */
/* R3DCar_gFacetScratch REMOVED (2026-07-11 quartet fix): it was never a real global -- both
   consumers (InsertCarFacetII/InsertCarFacetMenuII) actually write the PSX scratchpad's
   Draw_CarCache::sub_otz field (0x1F800000+0x40) through the `sd` cache pointer, same family
   as Render_gPalettePtr/INT_1f80008c/Render_gMenuRenderFlag -- see sd->sub_otz call sites. */

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

  uVar4 = newColorIndex;
  if ((carObj->render).palCopy != (char *)0x0) {
    uVar4 = uVar4 & 7;
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
  int otSize;
  int otBytes;

  if (R3DCar_InMenu == 0) {
    /* MATCH: in-place multiply on the constant-seeded var defeats expand-time synth_mult
       (oracle addiu a1,0x1C0; mult v0,a1; mflo a1 -- product reuses the multiplier reg) */
    otSize = 0x1c0;
    otSize = otSize * Cars_gNumCars;
  }
  else {
    otSize = 0x400;
  }
  if (otSize < 0x400) {
    otSize = 0x400;
  }
  otBytes = otSize << 2; /* MATCH: split temp -- pre-shift otSize dies into $a1, shifted byte count lives in $s0 across the calls */
  R3DCar_subOtStart[0][0] = reservememadr("sub_ot0",otBytes,0);
  R3DCar_subOtStart[1][0] = reservememadr("sub_ot1",otBytes,0);
  if ((R3DCar_InMenu != 0) || (GameSetup_gData.commMode == 1)) {
    R3DCar_subOtStart[0][1] = reservememadr("sub_ot0m",otBytes,0);
    R3DCar_subOtStart[1][1] = reservememadr("sub_ot1m",otBytes,0);
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
  iVar2 = GameSetup_gData.track * 4 + GameSetup_gData.Weather + GameSetup_gData.Time * 2;
  while (iVar2 != -1) {
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
    iVar2 = iVar2 + -1;
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
  /* MATCH: SYM-shaped body -- named locals per SYM 8c block (carZ=t0, camCarObj=v0, zoom=s2,
     inCarCam=s5, maxMax=s0, maxMid=s4; block locals x=a1,z=a2); carPos[4]/car are REAL AUTO
     structs the oracle stores to (Ghidra dead-store-eliminated them, sec.3.2c). */
  coorddef carPos [4];
  coorddef car;
  int carZ;
  Car_tObj *camCarObj;
  int zoom;
  int inCarCam;
  int maxMax;
  int maxMid;

  inCarCam = 0;
  zoom = Camera_gInfo[Vi->player].zooming;
  camCarObj = (Car_tObj *)Camera_gInfo[Vi->player].anchor;
  /* MATCH: nested-if + goto shape (Ghidra flattened it into one giant || condition, which
     materializes a phantom bool flag; the oracle is pure control flow) */
  if (((camCarObj == carObj) && ((carObj->carFlags & 4U) != 0)) &&
      (Camera_gInfo[Vi->player].inCar != 0)) {
    if (Camera_GetMode(Vi->player) == 0) goto R3DVis_setNoDetailReturn;
    if ((Camera_gInfo[Vi->player].inCar != 0) && (Camera_GetMode(Vi->player) == 1)) {
      inCarCam = 1;
      if (((carObj->render).inside & 1U) == 0) goto R3DVis_setNoDetailReturn;
    }
  }
  if ((carObj->N).active == '\0') goto R3DVis_setNoDetailReturn;
  maxMax = 0xc0000;
  maxMid = 0x3c0000;
  (carObj->render).detail = 0;
  if ((Replay_ReplayMode == 2) || (Camera_GetMode(Vi->player) == 0xe)) {
    maxMax = 0x240000;
    maxMid = 0x780000;
  }
  if (zoom != 0) {
    /* MATCH: in-place multiplies -- mflo lands straight in maxMax/maxMid regs */
    maxMax = maxMax * zoom;
    maxMax = maxMax * 3;
    maxMid = maxMid * zoom;
    maxMid = maxMid * 2;
  }
  car.x = (carObj->N).position.x - (Vi->cview).translation.x;
  car.y = (carObj->N).position.y - (Vi->cview).translation.y;
  car.z = (carObj->N).position.z - (Vi->cview).translation.z;
  carPos[0].x = (car.x / 256) * ((Vi->cview).mrotation.m[0] / 256) +
                (car.y / 256) * ((Vi->cview).mrotation.m[1] / 256) +
                (car.z / 256) * ((Vi->cview).mrotation.m[2] / 256);
  carPos[0].z = (car.x / 256) * ((Vi->cview).mrotation.m[6] / 256) +
                (car.y / 256) * ((Vi->cview).mrotation.m[7] / 256) +
                (car.z / 256) * ((Vi->cview).mrotation.m[8] / 256);
  /* MATCH: guard tests the field; carZ copy AFTER the guard (oracle sinks the sw into the bnez delay slot) */
  if (0xcb0000U < carPos[0].z + 0x30000U) goto R3DVis_setNoDetailReturn;
  carZ = carPos[0].z;
  if (maxMax < carZ) {
    (carObj->render).detail = 1;
  }
  if (maxMid < carPos[0].z) {
    (carObj->render).detail = 2;
  }
  {
    int x;
    int z;

    carPos[3].x = carPos[0].x;
    carPos[2].x = carPos[0].x;
    carPos[1].x = carPos[0].x;
    carPos[3].z = carPos[0].z;
    carPos[2].z = carPos[0].z;
    carPos[1].z = carPos[0].z;
    x = (carObj->N).dimension.x;
    z = (carObj->N).dimension.z;
    carPos[0].x -= x;
    carPos[0].z += z;
    carPos[1].x += x;
    carPos[2].x -= x;
    carPos[1].z += z;
    carPos[2].z -= z;
    carPos[3].x += x;
    carPos[3].z -= z;
    if (((carPos[0].z < __builtin_abs(carPos[0].x)) &&
         (carPos[1].z < __builtin_abs(carPos[1].x))) &&
        ((carPos[2].z < __builtin_abs(carPos[2].x)) &&
         (carPos[3].z < __builtin_abs(carPos[3].x)))) {
      /* MATCH: noDetail block INLINE as the corner-test fall-through; all other
         paths goto INTO it (oracle block order: tests -> noDetail -> visible tail) */
R3DVis_setNoDetailReturn:
      (carObj->render).detail = -1;
      return -0x80000000;
    }
  }
  carObj++; carObj--; /* net-zero pair: raises carObj allocno refs (catalog A; best position found, s4->s0) */
  if (inCarCam != 0) {
    (carObj->render).detail = 3;
  }
  return carZ;
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
  int i;                 /* SYM fn REG s4 -- ALL loop counters (fused; PrimMenu precedent) */
  Transformer_zObj *obj; /* SYM fn REG a1 -- per-iteration scene object */
  u_short uVar4;
  u_int uVar8;
  u_char bVar14;
  int iVar16;
  int cop_flag;          /* SYM fn REG s6 */
  int carType;           /* SYM fn REG s7 */
  int detailIndex;       /* SYM fn REG fp */
  coorddef parent;       /* SYM fn AUTO sp+0x18 -- base obj[0] translation cache */
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  matrixtdef steerMat;
  int rideHeight;
  int countryFlag;
  int rightHandDrive;
  matrixtdef *pmStack_2c;

  rightHandDrive = 0;
  rideHeight = (carObj->render).rideHeight;
  carType = (int)(carObj->render).currentCarType;
  countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
  /* CORRECTNESS + MATCH: ForceDriveSide holds -1s -- must read SIGNED (lb); plain char is
     unsigned on this build, so the <0 test (and the whole AITune driveSide path) was being
     dead-code-eliminated (catalog wave-4 Replay_Decompress class) */
  if ((carType < 0x1c) &&
      (rightHandDrive = (int)*(signed char *)&R3DCar_ForceDriveSide[carType], rightHandDrive < 0))
  {
    rightHandDrive = AITune_trackInfo[GameSetup_gData.track].driveSide + 1 >> 1 ^ 1;
  }
  if (GameSetup_gData.mirrorTrack != 0) {
    rightHandDrive = rightHandDrive ^ 1;
  }
  R3DCar_rightHandDrive = rightHandDrive;
  cop_flag = carType - 0x16U < 6; /* SYM: cop_flag REG s6 (int, not a spilled bool) */
  if ((carObj->render).detail < 0) {
    return;
  }
  uVar4 = (carObj->render).headLight;
  if (((uVar4 & 8) == 0) && (0x1e0000 < (carObj->N).damage[0])) {
    /* MATCH: plain dual stores -- oracle ori h|0xc / h|8 + ONE cross-jump-merged sh */
    if ((uVar4 & 0x44) == 0) {
      (carObj->render).headLight = uVar4 | 0xc;
    }
    else if ((uVar4 & 2) != 0) {
      (carObj->render).headLight = uVar4 | 8;
    }
    uVar4 = (carObj->render).headLight;
  }
  if (((uVar4 & 0x80) == 0) && (0x1e0000 < (carObj->N).damage[2])) {
    if ((uVar4 & 0x44) == 0) {
      (carObj->render).headLight = uVar4 | 0xc0;
    }
    else if ((uVar4 & 0x20) != 0) {
      (carObj->render).headLight = uVar4 | 0x80;
    }
  }
  if (cop_flag) {
    /* MATCH: ON arm first (oracle VA order: AIFlags&2 != 0 falls through to TurnHeadLightOn) */
    if ((carObj->AIFlags & 2U) != 0) {
      if (((carObj->render).signalLight[0] & 0x80U) == 0) {
        (carObj->render).signalLight[0] = 0x80;
        bVar14 = (carObj->control).lights;
        (carObj->render).signalLight[1] = 0x88;
        if ((bVar14 & 2) == 0) {
          R3DCar_TurnHeadLightOn(carObj,1);
        }
      }
    }
    else if (((carObj->render).signalLight[0] & 0x80U) != 0) {
      bVar14 = (carObj->control).lights;
      (carObj->render).signalLight[0] = 0;
      (carObj->render).signalLight[1] = 0;
      if ((bVar14 & 2) == 0) {
        R3DCar_TurnHeadLightOff(carObj,(u_int)((bVar14 & 4) == 0));
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
  if (carType < 0x1c) {
    if (((carObj->render).upgradeFlags & 2U) != 0) {
      rideHeight = (carObj->render).upgradeHeight;
    }
  }
  else {
    rideHeight = 0;
  }
  if (((carObj->render).detail == 0) && ((0x1b < carType || ((carObj->render).medOnly != '\0')))) {
    (carObj->render).detail = 1;
  }
  if (((carObj->render).detail == 2) && (carType == 0x1c)) {
    (carObj->render).detail = 1;
  }
  {
  matrixtdef tmpMat;   /* SYM car/pos @ff08 + matP @ff08/ff50 (sibling of loop block) */
  matrixtdef matX;     /* SYM matP @ff50 */
  matrixtdef *pmVar12; /* block-local: head-region funnel (fn-scope pseudo spanned into the
                          matrix loop and stole a saved reg -> carType spilled) */
  matrixtdef *pmVar13;
  int *m1;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar9;
  int iVar11;
  tmpMat.m[0] = (carObj->N).position.x - *(int *)((int)Vi + 8);
  detailIndex = (carObj->render).detail + 2;
  tmpMat.m[1] = (carObj->N).position.y - *(int *)((int)Vi + 0xc);
  tmpMat.m[2] = (carObj->N).position.z - *(int *)((int)Vi + 0x10);
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
  tmpMat.m[4] = (iVar16 >> 8) * (iVar5 >> 8);
  tmpMat.m[4] = tmpMat.m[4] + (iVar11 >> 8) * (iVar6 >> 8);
  tmpMat.m[4] = tmpMat.m[4] + (iVar9 >> 8) * (iVar7 >> 8);
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
  tmpMat.m[6] = (iVar16 >> 8) * (iVar5 >> 8);
  tmpMat.m[6] = tmpMat.m[6] + (iVar11 >> 8) * (iVar6 >> 8);
  tmpMat.m[6] = tmpMat.m[6] + (iVar9 >> 8) * (iVar7 >> 8);
  iVar16 = fixedatan(tmpMat.m[4],tmpMat.m[6]);
  R3DCar_yawCam = 0x1000 - (iVar16 >> 4);
  /* MATCH: per-arm INLINE tail calls (oracle keeps both fasttransmult tails un-merged;
     the pmVar12/pmVar13 funnel pseudos were extra saved-reg contenders -> detailIndex spill) */
  if (carType < 0x1c) {
    int roll;   /* SYM blk 152 REG s3 -- live across the bodyMat calls */
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,insideMat.m);
    if (rightHandDrive != 0) {
      insideMat.m[0] = -insideMat.m[0];
      insideMat.m[2] = -insideMat.m[2];
      insideMat.m[1] = -insideMat.m[1];
    }
    roll = (carObj->render).bodyRoll;
    if (rightHandDrive != 0) {
      roll = -roll;
    }
    fixedxformz(&bodyMat,(carObj->render).bodyRoll);
    fixedxformx(&matX,(carObj->render).bodyPitch + 100);
    Math_fasttransmult(&bodyMat,&matX,&bodyMat);
    Math_fasttransmult(&bodyMat,&(carObj->N).orientMat,&bodyMat);
    m1 = tmpMat.m + 8;
    fixedxformz(m1,roll);
    Math_fasttransmult((matrixtdef *)m1,&matX,(matrixtdef *)m1);
    Math_fasttransmult((matrixtdef *)m1,&insideMat,&insideMat);
    Math_fasttransmult(&bodyMat,(matrixtdef *)((int)Vi + 0x44),&orientMat)
    ;
    Math_fasttransmult(&insideMat,(matrixtdef *)((int)Vi + 0x44),&orientIMat);
  }
  else {
    fixedxformz(&bodyMat,(carObj->render).bodyRoll);
    fixedxformx(&tmpMat,(carObj->render).bodyPitch);
    Math_fasttransmult(&bodyMat,&tmpMat,&bodyMat);
    Math_fasttransmult(&bodyMat,&(carObj->N).orientMat,&bodyMat);
    Math_fasttransmult(&bodyMat,(matrixtdef *)((int)Vi + 0x44),&orientMat);
  }
  }
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    if (carType == 0x1c) {
      iVar16 = (carObj->N).wheelRot[1];
      (carObj->N).wheelRot[0] = (carObj->N).wheelRot[0] + 0x1800U & 0xffff;
      (carObj->N).wheelRot[1] = iVar16 + 0x1800U & 0xffff;
    }
    else {
      int vel;    /* SYM blk 196 REG a0 -- clamped IN PLACE */
      int spin;   /* SYM blk 196 REG v0 -- abs(wheelSpin), hoisted guard */
      int rear;   /* SYM blk 196 REG a1 -- the 0..2 wheel loop counter */
      spin = carObj->wheelSpin;
      if (spin < 0) {
        spin = -spin;
      }
      for (rear = 0; rear < 2; rear = rear + 1) {
        if (Replay_ReplayMode == 2) {
          vel = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed);
        }
        else {
          vel = (carObj->linearVel_ch).z >> 6;
        }
        if (rear == 0) {
          if (carObj->frontWheelSpin != 0) goto R_ICFt_wheelspinRpmCalc;
        }
        else if (spin - 1U < 2) {
R_ICFt_wheelspinRpmCalc:
          uVar8 = (u_int)(u_char)(carObj->control).gear;
          if (uVar8 != 1) {
            vel = (carObj->flywheelRpm << 0x10) / carObj->specs->velToRpmRatio[uVar8];
            if (Replay_ReplayMode == 2) {
              vel = vel << (Replay_ReplayInterface.speed + 7U);
            }
            else {
              vel = vel << 9;
            }
          }
        }
        if ((carObj->wheelLock != 0) && ((carObj->wheelLock & rear + 1U) != 0)) {
          vel = 0;
        }
        if (vel < -0x1800) {
          vel = -0x1800;
        }
        if (0x1800 < vel) {
          vel = 0x1800;
        }
        /* MATCH: index form -- oracle walker a2 is the strength-reduced giv of wheelRot[rear] */
        (carObj->N).wheelRot[rear] = (carObj->N).wheelRot[rear] + vel & 0xffff;
      }
    }
  }
  {
    int steeringAngle;   /* SYM blk 227 REG s0 (live across the fixed* calls) */
    iVar16 = (carObj->linearVel_ch).z;
    steeringAngle = (carObj->control).steering;
    if (0x1e0000 < iVar16) {
      iVar16 = fixeddiv(steeringAngle << 0x10,fixedmult(iVar16,0x888));
      steeringAngle = iVar16 >> 0x10;
      if (iVar16 < 0) {
        steeringAngle = iVar16 + 0xffff >> 0x10;
      }
    }
    fixedxformy(&steerMat,steeringAngle << 5);
  }
  if (((carObj->control).desiredBrakeLevel == '\0') || ((carObj->control).hanno != 0)) {
    uVar4 = (carObj->render).brakeLight & 0xfe;
  }
  else {
    uVar4 = (carObj->render).brakeLight | 1;
  }
  (carObj->render).brakeLight = uVar4;
  if (carType < 0x1c) {
    for (i = 0; i < 0x39; i = i + 1) {
      short code;   /* SYM blk 261 (loop1) / blk 389 (loop2) REG a1 -- sibling redecl */
      bool bVar2;
      code = (signed char)R3DCar_ObjectInfo[i][detailIndex];
      switch((short)(code - 2)) {
      /* MATCH: case bodies in ORACLE VA order (jlabels 800B03F4..800B05B0):
         0/7, 1/2, 9, 10, 5, 6, 0x14, 0xc, 0xb, 3, 4, 0x10, 0x11, 0x12, 0x13, 0xd, 0xe
         + shared dmgCheck/visibility-join tail LAST (L800B05B8..L800B05D0) */
      case 0:
      case 7:
        uVar4 = (carObj->render).inside & 1;
        goto R_ICFt_partVisibilityJoin;
      case 1:
      case 2:
        if ((carObj->render).inside == 0) {
          code = 0;
        }
        break;
      case 9:
        uVar4 = (u_char)(carObj->render).upgradeFlags & 4;
        goto R_ICFt_partVisibilityJoin;
      case 10:
        if (((carObj->render).upgradeFlags & 4U) == 0) {
          code = 0;
        }
        break;
      case 5:
        uVar8 = (u_int)(u_short)(carObj->render).headLight;
        goto R_ICFt_brakeAIBranch;   /* shared test lives at L800B0500 (0x10/0x11 region) */
      case 6:
        if (((carObj->render).headLight & 0x20U) == 0) {
          code = 0;
        }
        break;
      case 0x14:
        if (((carObj->render).headLight & 0x11U) == 0) {
          code = 0;
        }
        break;
      case 0xc:
        if (((carObj->render).upgradeFlags & 1U) == 0) {
          code = 0;
        }
        break;
      case 0xb:
        uVar4 = (u_char)(carObj->render).upgradeFlags & 1;
        goto R_ICFt_partVisibilityJoin;
      case 3:
        uVar4 = (carObj->render).damageParts & 1;
        goto R_ICFt_partVisibilityJoin;
      case 4:
        uVar4 = (carObj->render).damageParts & 2;
        goto R_ICFt_partVisibilityJoin;
      case 0x10:
        if ((carObj->render).brakeLight != 0) break;
        goto R_ICFt_brakeLightCheck;
      case 0x11:
        if ((carObj->control).gear == 0) break;
R_ICFt_brakeLightCheck:
        if (cop_flag == 0) goto switchD_800b03ec_caseD_f;
        uVar8 = carObj->AIFlags;
R_ICFt_brakeAIBranch:
        if ((uVar8 & 2) == 0) {
          code = 0;
        }
        break;
      case 0x12:
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) goto cfLbl1;
        goto switchD_800b03ec_caseD_f;
      case 0x13:
        if (cop_flag) {
          if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) goto R_ICFt_caseE_dmgCheck;
          goto switchD_800b03ec_caseD_f;
        }
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) break;
        if (R3DCar_SignalBrakeFlare[carType] == 0) goto switchD_800b03ec_caseD_f;   /* @0x800B055C lbu SignalBrakeFlare(carType) */
        bVar2 = i - 6U < 6;
        if ((carObj->render).brakeLight == 0) {
          code = 0;
        }
        goto R_ICFt_postSwitchVis;
      case 0xd:
cfLbl1:   /* @0x800b0524  (-f-build goto label) */
        if (cop_flag) goto R_ICFt_caseE_dmgCheck;
        break;
      default:
        goto switchD_800b03ec_caseD_8;
      case 0xf:
        goto switchD_800b03ec_caseD_f;
      case 0xe:
        if (cop_flag == 0) goto switchD_800b03ec_caseD_f;
R_ICFt_caseE_dmgCheck:
        uVar4 = (carObj->render).damageParts & 4;
R_ICFt_partVisibilityJoin:
        if (uVar4 != 0) {
switchD_800b03ec_caseD_f:
          code = 0;
switchD_800b03ec_caseD_8: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
        }
        break;
      }
      bVar2 = i - 6U < 6;
R_ICFt_postSwitchVis:
      if (bVar2) {
        /* #148: restored to source-level switch(i). The compiler emitted a 6-entry jumptable
         * @0x80056470 for indices 6..11 -> {6,7:0x800b05f4(A) 8,9:0x800b0600(B) 10,11:0x800b0648(C)};
         * Ghidra rendered it as switch-on-target-VA against an (empty) recovered jt array, which broke
         * the dispatch. Index->body mapping read from nfs4-f.exe rodata. */
        switch (i) {
        case 6: case 7:
          uVar4 = (carObj->render).damageParts & 0x18;
          break;
        case 8: case 9:
          if (((carObj->render).damageParts & 4U) != 0) {
            int damage;   /* SYM blk 362 REG v0 -- DamageSpoiler byte read ONCE */
            damage = R3DCar_DamageSpoiler[carType];   /* @0x800B0620 lbu DamageSpoiler(carType) */
            code = damage & 1;
            if (((carObj->render).upgradeFlags & 4U) == 0) {
              code = damage & 0x80;
            }
            if (code != 0) {
              code = 0xb;
            }
          }
          goto R_ICFt_postVisibility;
        case 10: case 11:
          uVar4 = (carObj->render).damageParts & 4;
        }
        if (uVar4 != 0) {
          code = 0;
        }
      }
R_ICFt_postVisibility:
      R3DCar_ObjectVisible[i] = code;
    }
  }
  else {
    for (i = 0; i < 0x39; i = i + 1) {
      short code;   /* SYM blk 261 (loop1) / blk 389 (loop2) REG a1 -- sibling redecl */
      code = (signed char)R3DCar_ObjectInfo[i][detailIndex];
      /* MATCH: oracle layout L800B06B8..L800B0700 -- 0x12 arm OUT-OF-LINE at end,
         <0x13 / 0x16 arms inline, ONE shared zero-test funnel */
      if (code == 0x12) goto R_ICFt_loop2Brake;
      if (code < 0x13) {
        if (code != 1) {
          code = 0;
        }
      }
      else if (code == 0x16) {
        uVar8 = (u_short)(carObj->render).headLight & 0x11;
        goto cfLbl2;
      }
      else {
        code = 0;
      }
      goto R_ICFt_loop2Post;
R_ICFt_loop2Brake:
      uVar8 = (u_int)(carObj->render).brakeLight;
cfLbl2:   /* @0x800b06f4  (-f-build goto label) */
      if (uVar8 == 0) {
        code = 0;
      }
R_ICFt_loop2Post:
      if ((carType == 0x1c) && (i == 0x20)) {
        code = 1;
      }
      R3DCar_ObjectVisible[i] = code;
    }
  }
  obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[0];
  pmStack_2c = (matrixtdef *)((int)Vi + 0x44);
  parent.x = (obj->translation).x;
  parent.y = (obj->translation).y;
  parent.z = (obj->translation).z;
  {
  matrixtdef tmpMat;   /* SYM blk 428 @ff08 (sibling of region2/3 block -> slot merges) */
  coorddef translation;/* SYM blk 428 @ff30 */
  coorddef tmp;        /* SYM blk 428 @ff40 */
  matrixtdef matX;     /* SYM blk 576 @ff50 */
  matrixtdef matY;     /* SYM blk 576 @ff78 */
  matrixtdef mStack_60;/* SYM blk 558 @ffa0 */
  for (i = 0; i < 0x39; i = i + 1) {
    int suspensionOffset;   /* SYM blk 428 REG a0 */
    matrixtdef *pmVar12;    /* sibling redecl -- fresh pseudos per region */
    matrixtdef *pmVar13;
    obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[i];
    if ((obj->numFacet == 0) || (R3DCar_ObjectVisible[i] == '\0'))
    goto R_ICFt_matrixCopyDone;
    /* MATCH: arm order per oracle -- suspension arm INLINE, rideHeight arm out-of-line */
    if (0x2e < i) {
      int index;            /* SYM blk 437 REG v1 */
      index = R3DCar_Suspension[i + -0x2f];
      suspensionOffset = carObj->wheel[index].impactCompression;
      if (suspensionOffset < 1) {
        iVar16 = -0x1eb8;
        if (-0x1eb9 < suspensionOffset) {
          iVar16 = suspensionOffset;
        }
        suspensionOffset = iVar16;
      }
      else if (0x1eb8 < suspensionOffset) {
        suspensionOffset = 0x1eb8;
      }
    }
    else {
      suspensionOffset = rideHeight - (carObj->render).currentHeight;
    }
    tmp.x = (obj->translation).x - parent.x;
    tmp.y = ((obj->translation).y - parent.y) - suspensionOffset;
    tmp.z = (obj->translation).z - parent.z;
    if (i < 0x2f) {
      if (((0x1b < carType) || (i < 0x23)) || (pmVar13 = &insideMat, 0x28 < i)) {
        pmVar13 = &bodyMat;
      }
    }
    else {
      pmVar13 = &(carObj->N).orientMat;
    }
    transform(&tmp.x,pmVar13->m,&translation.x);
    tmp.x = ((carObj->N).position.x + translation.x) - *(int *)((int)Vi + 8);
    tmp.y = ((carObj->N).position.y + translation.y) - *(int *)((int)Vi + 0xc);
    tmp.z = ((carObj->N).position.z + translation.z) - *(int *)((int)Vi + 0x10);
    transform(&tmp.x,pmStack_2c->m,(int *)((int)R3DCar_position + i * 0xc));
    if (carType == 0x1c) {
      if (i == 0x1f) {
        fixedxformy(&tmpMat,(carObj->N).wheelRot[0]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,pmStack_2c,(matrixtdef *)((int)R3DCar_orientMat + 0x45c));
      }
      else {
        if (i != 0x23) goto switchD_800b0a34_caseD_29;
        fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,pmStack_2c,(matrixtdef *)((int)R3DCar_orientMat + 0x4ec));
      }
      goto R_ICFt_matrixCopyDone;
    }
    /* MATCH: case bodies in ORACLE physical order (jlabels 800B0A3C..800B0BD0):
       0x2f, 0x30-34, 0x35, 0x36, 0x37, 0x38, 0x23/24, 0x25, 0x26, 0x27/28 + shared tails, default */
    switch(i) {
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
      goto R_ICFt_matrixSetJoin;
    case 0x38:
      pmVar13 = (matrixtdef *)((int)R3DCar_orientMat + 0x7bc);
      break;
    case 0x23:
    case 0x24:
      pmVar13 = &orientIMat;
      break;
    case 0x25: {
      int steeringAngle;      /* SYM blk 546 REG v0 */
      steeringAngle = (carObj->control).steering;
      if (rightHandDrive != 0) {
        steeringAngle = -steeringAngle;
      }
      fixedxformz(&tmpMat,steeringAngle * -0x38);
      goto R_ICFt_setInsideMat;
    }
    case 0x26: {
      int roll;               /* SYM blk 558 REG a1 */
      int pitch;              /* SYM blk 558 REG s1 */
      roll = (carObj->render).bodyRoll * 3 >> 1;
      pitch = (carObj->render).bodyPitch << 3;
      if (rightHandDrive != 0) {
        roll = -roll;
      }
      fixedxformz(&matY,roll);
      pmVar12 = &mStack_60;
      fixedxformx(pmVar12,pitch);
      pmVar13 = &matY;
      goto R_ICFt_matrixPrepY;
    }
    case 0x27:
    case 0x28: {
      int maxAngleFactor;     /* SYM blk 576 REG s1 */
      int steeringAngle;      /* SYM blk 576 REG s0 */
      steeringAngle = (carObj->control).steering;
      maxAngleFactor = -0xc;
      if (rightHandDrive != 0) {
        steeringAngle = -steeringAngle;
      }
      if (i == 0x27) {
        maxAngleFactor = 0xc;
      }
      fixedxformx(&matX,steeringAngle * maxAngleFactor);
      if (0 < steeringAngle) {
        steeringAngle = -steeringAngle;
      }
      fixedxformy(&matY,steeringAngle * (maxAngleFactor >> 1));
      pmVar13 = &matX;
      pmVar12 = &matY;
    }
R_ICFt_matrixPrepY:
      Math_fasttransmult(pmVar13,pmVar12,&tmpMat);
R_ICFt_setInsideMat:
      pmVar13 = &insideMat;
R_ICFt_matrixSetJoin:
      Math_fasttransmult(&tmpMat,pmVar13,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),(matrixtdef *)((int)R3DCar_orientMat + i * 0x24))
      ;
      goto R_ICFt_matrixCopyDone;
    default:
switchD_800b0a34_caseD_29:
      pmVar13 = &orientMat;
      break;
    }
    R3DCar_MATRIX3DT_Copy(pmVar13->m,(int *)((int)R3DCar_orientMat + i * 0x24));
R_ICFt_matrixCopyDone: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
  }
  }
  TrsProj_TransformProjectVertex((matrixtdef *)((int)Vi + 0x44),(coorddef *)((int)Vi + 0x38),1,&(carObj->N).position,
             &R3DCar_center);
  if ((R3DCar_shadowColour.r == '\0') || ((carObj->N).simOptz != '\0')) {
    R3DCar_shadowFlag = 0;
  }
  else {
    Newton_CalcRealShadowCoordinates(carObj,simGlobal.gameTicks);
    TrsProj_TransformProjectVertex((matrixtdef *)((int)Vi + 0x44),(coorddef *)((int)Vi + 0x38),4,(carObj->N).shadowCoord,
               R3DCar_shadowVertex);
    R3DCar_shadowFlag = 1;
  }
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    if (Replay_ReplayMode == 2) {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ +
           (short)((carObj->linearVel_ch).z >> (0x12U - Replay_ReplayInterface.speed));
    }
    else {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ + *(short *)((int)&(carObj->linearVel_ch).z + 2);
    }
  }
  /* MATCH: gShadowMax read AT USE (oracle loads it after the envmap loop); walkers are
     compiler givs of the index form (SYM tail blocks have NO named pointer locals) */
  i = 0;
  if (0 < DrawC_gEnvMapMax) {
    do {
      if ((carObj->N).simRoadInfo.slice < DrawC_gEnvMap[i].slice) break;
      i = i + 1;
    } while (i < DrawC_gEnvMapMax);
  }
  (carObj->N).eIndexEnvMap = (short)i;
  i = 0;
  if (0 < DrawC_gShadowMax) {
    do {
      if ((carObj->N).simRoadInfo.slice < DrawC_gShadow[i].slice) break;
      i = i + 1;
    } while (i < DrawC_gShadowMax);
  }
  (carObj->N).eIndexShadow = (short)i;
  return;
}

/* ---- R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii  [R3DCAR.CPP:2185-2342] SLD-VERIFIED ---- */
void R3DCar_ReadInCarTextureMenu(Car_tObj *carObj,char *bigfile,int reload,int player)

{
  int carType;
  char filename [10];

  carType = (int)(carObj->render).currentCarType;
  R3DCar_GetCarName(filename,carType,carObj->carInfo->Country);
  if (reload != 0) {
    CarIO_ReleaseCarCluts(carObj);
  }
  if ((carObj->render).palCopy == (char *)0x0) {
    (carObj->render).palCopy = reservememadr("palCopy",0x28a0,0);
  }
  DrawSync(0);
  Texture_palNum = 0;
  if (carType < 0x1c) {
    int i;
    char infilenames [3][15];
    char *shpfiles [3];
    int index;
    char **sfBase;

    index = 0;
    if (((carObj->render).inside & 1U) != 0) {
      R3DCar_GetFileName(infilenames[index],filename,"h");
    }
    else {
      R3DCar_GetFileName(infilenames[index],filename,"");
    }
    index = index + 1;
    if (((carObj->render).inside & 1U) != 0) {
      R3DCar_GetFileName(infilenames[index],filename,"i");
      index = index + 1;
    }
    if ((carObj->render).colorIndex >= 8) {
      R3DCar_GetFileName(infilenames[index],filename,"d");
    }
    else {
      R3DCar_GetFileName(infilenames[index],filename,"l");
    }
    index = index + 1;
    for (i = 0; i < index; i = i + 1) {
      shpfiles[i] = locatebig(bigfile,infilenames[i]);
    }
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    if (reload != 0) {
      reload = 0x11;
    }
    CarIO_ReadInCarTextureData(shpfiles[0],carObj,reload,player);
    index = 1;
    sfBase = shpfiles;
    if (((carObj->render).inside & 1U) != 0) {
      CarIO_ReadInCarTextureData(shpfiles[1],carObj,0x19,player);
      index = 2;
    }
    if (reload == 0) {
      reload = 0x91;
    }
    {
      char **sfp = sfBase + index; /* MATCH: base-first addu (oracle addu v0,s0,v0) */
      CarIO_ReadInCarTextureData(*sfp,carObj,reload,player);
    }
    (carObj->render).palNum = (short)Texture_palNum;
    DrawSync(0);
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,1);
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,1,(carObj->render).palNum);
  }
  else {
    char infilename [15];
    char *shpfile;

    strcpy(infilename,filename);
    strcat(infilename,".psh");
    shpfile = locatebig(bigfile,infilename);
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    if (reload != 0) {
      reload = 0x11;
    }
    else {
      reload = 0x80;
    }
    CarIO_ReadInCarTextureData(shpfile,carObj,reload,0);
    (carObj->render).palNum = (short)Texture_palNum;
    DrawSync(0);
    Texture_CarColor = (u_short)(carObj->render).colorIndex & 7;
    Texture_ProcessPaletteCopy((Texture_pal8bit *)(carObj->render).palCopy,0,(carObj->render).palNum);
  }
  purgememadr(bigfile);
  return;
}

/* ---- R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView  [R3DCAR.CPP:2351-3084] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetMenu(Car_tObj *carObj,DRender_tView *Vi)

{
  int i;                 /* SYM fn REG s0 -- all loop counters */
  Transformer_zObj *obj; /* SYM fn REG a1 */
  int detailIndex;       /* SYM fn REG s2 */
  int carType;           /* SYM fn REG s3 -- reassigned in place (render then carInfo) */
  int changeCar;         /* SYM fn REG a3 -- "new car loaded" flag */
  int countryFlag;       /* SYM fn REG s5 */
  int cop_flag;          /* SYM fn REG s4 */
  bool bVar1;
  u_char bVar2;
  short sVar3;
  u_short uVar7;
  int iVar8;
  int iVar9;
  char *addr;
  Transformer_zScene *pTVar10;
  int iVar11;
  int iVar12;
  int iVar13;
  int iVar15;
  int iVar16;
  GameSetup_tCarData *pGVar14;
  matrixtdef *pmVar17;
  void *pvVar18;
  u_int uVar20;
  Transformer_zScene **ppTVar21;
  coorddef parent;       /* SYM fn AUTO sp+0x18 */
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  int rideHeight;
  int rightHandDrive;

  rightHandDrive = 0;
  rideHeight = (carObj->render).rideHeight;
  carType = (int)(carObj->render).currentCarType;
  countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
  changeCar = 0;
  /* CORRECTNESS + MATCH: signed read of ForceDriveSide (see InsertCarFacet twin) */
  if ((carType < 0x1c) &&
      (rightHandDrive = (int)*(signed char *)&R3DCar_ForceDriveSide[carType], rightHandDrive < 0))
  {
    rightHandDrive = AITune_trackInfo[GameSetup_gData.track].driveSide + 1 >> 1 ^ 1;
  }
  carType = carObj->carInfo->carType;
  R3DCar_rightHandDrive = rightHandDrive;
  cop_flag = carType - 0x16U < 6;
  if (cop_flag == 0) {
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
    if ((carObj->render).newCarType != carType) {
      iVar8 = AudioMus_Buffered();
      iVar9 = AudioMus_Threshold();
      if (iVar9 <= iVar8) {
        char filename [10];  /* SYM blk 221 @ff58 */
        char bigname [100];  /* SYM blk 221 @ff68 */
        if (carType < 0x1c) {
          uVar7 = (carObj->render).inside | 0x10;
        }
        else {
          uVar7 = (carObj->render).inside & 0xef;
        }
        (carObj->render).inside = uVar7;
        sprintf(filename,"zz%s",GameSetup_gCarNames[0] + carType * 5);
        if (cop_flag != 0) {
          filename[2] =
               R3DCar_CopCountry[(u_char)R3DCar_CopIndex[carType + -0x16][carObj->carInfo->Country]];
        }
        strcpy(bigname,Paths_Paths[0x18]);
        strcat(bigname,filename);
        if (((carObj->render).inside & 0x10U) != 0) {
          strcat(bigname,"h");
        }
        strcat(bigname,".viv");
        pvVar18 = (void *)0x10;
        iVar8 = asyncloadfile(bigname,(void *)0x10);
        carObj->async_handle = iVar8;
        R3DCar_aSyncLoading = Vi->player;
        pGVar14 = carObj->carInfo;
        (carObj->render).newCarType = (short)carType;
        (carObj->render).newCountry = (char)pGVar14->Country;
      }
    }
    if (carObj->async_handle != 0) goto R_ICFtMenu_asyncHandleCheck;
  }
  else {
R_ICFtMenu_asyncHandleCheck:
    {
    int status;   /* SYM blk 273 REG s0 */
    status = getasyncreadstatus(carObj->async_handle);
    if ((status < 1) && (status != -1)) {
      if (status == -2) {
R_ICFtMenu_asyncAbort:
        uVar7 = (carObj->render).newCarType;
        carObj->async_handle = 0;
R_ICFtMenu_markNewCarType:
        (carObj->render).newCarType = uVar7 | 0x80;
      }
    }
    else {
      if (((carObj->render).newCarType == carType) &&
         ((u_int)(u_char)(carObj->render).newCountry == carObj->carInfo->Country)) {
        char *bigFile;   /* SYM blk 281 REG v0 */
        bigFile = getasyncreadadr(carObj->async_handle,pvVar18);
        R3DCar_BigFile = bigFile;
        if (bigFile == (char *)0x0) {
          changeCar = 0;
          goto R_ICFtMenu_sceneCounterJoin;
        }
        carObj->async_handle = 0;
        if (status != -1) {
          R3DCar_aSyncLoading = -1;
          goto R_ICFtMenu_bigFileCheck;
        }
        purgememadr(bigFile);
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
  }
R_ICFtMenu_bigFileCheck:
  changeCar = 0;
  if (R3DCar_BigFile != (char *)0x0) {
    char filename [10];  /* SYM blk 321 @ff58 -- sibling redecl */
    char workFile [10];  /* SYM blk 321 @ff68 */
    int reload;          /* SYM blk 321 REG fp */
    int currentCarType;  /* SYM blk 321 REG s0 */
    currentCarType = (int)(carObj->render).currentCarType;
    reload = 0;
    if (-1 < currentCarType) {
      char cVar6;
      cVar6 = R3DCar_LoadedSceneCounter[countryFlag][currentCarType] + -1;
      R3DCar_LoadedSceneCounter[countryFlag][currentCarType] = cVar6;
      reload = 1;
      if (cVar6 == '\0') {
        purgememadr(R3DCar_LoadedScenePointer[countryFlag][currentCarType]);
        R3DCar_LoadedScenePointer[countryFlag][currentCarType] = (Transformer_zScene *)0x0;
      }
    }
    sVar3 = (carObj->render).newCarType;
    bVar2 = (carObj->render).newCountry;
    (carObj->render).currentCarType = sVar3;
    (carObj->render).currentCountry = bVar2;
    currentCarType = (int)sVar3;
    if (Vi->player != 0) {
      (carObj->render).currentCountry = bVar2 | 0x80;
    }
    countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
    (carObj->render).inside = (carObj->render).inside >> 4;
    sprintf(filename,"zz%s",GameSetup_gCarNames[0] + currentCarType * 5);
    if (cop_flag != 0) {
      filename[2] =
           R3DCar_CopCountry[(u_char)R3DCar_CopIndex[currentCarType + -0x16]
                           [(u_char)(carObj->render).currentCountry & 0x7f]];
    }
    strcpy(workFile,filename);
    if (((carObj->render).inside & 1U) != 0) {
      strcat(workFile,"h");
    }
    ppTVar21 = R3DCar_LoadedScenePointer[countryFlag] + currentCarType;
    if (*ppTVar21 != (Transformer_zScene *)0x0) {
      purgememadr(*ppTVar21);
      *ppTVar21 = (Transformer_zScene *)0x0;
    }
    pTVar10 = R3DCar_ReadInCarData(workFile,carObj);
    *ppTVar21 = pTVar10;
    R3DCar_LoadedSceneCounter[countryFlag][currentCarType] =
         R3DCar_LoadedSceneCounter[countryFlag][currentCarType] + '\x01';
    R3DCar_CalcCarDimensions(carObj,*ppTVar21,currentCarType);
    R3DCar_ReadInCarTextureMenu(carObj,R3DCar_BigFile,reload,Vi->player);
    R3DCar_BigFile = (char *)0x0;
    changeCar = 1;
  }
R_ICFtMenu_sceneCounterJoin:
  carType = (int)(carObj->render).currentCarType;
  countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
  cop_flag = carType - 0x16U < 6;
  if (((R3DCar_InMenu & 0x80U) == 0) && (carType < 0)) {
    (carObj->render).detail = -1;
  }
  if (-1 < (carObj->render).detail) {
    if ((R3DCar_InMenu & 0x80U) == 0) {
      if (cop_flag == 0) {
        if (changeCar != 0) {
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
        if (changeCar != 0) {
          (carObj->render).headLight = 0x33;
          (carObj->render).brakeLight = 2;
        }
      }
    }
    if (carType < 0x1c) {
      if (((carObj->render).upgradeFlags & 2U) != 0) {
        rideHeight = (carObj->render).upgradeHeight;
      }
    }
    else {
      rideHeight = 0;
    }
    if (((carObj->render).detail == 0) && (0x1b < carType)) {
      (carObj->render).detail = 1;
    }
    if (((carObj->render).detail == 2) && (carType == 0x1c)) {
      (carObj->render).detail = 1;
    }
    /* MATCH: ONE detail re-read AFTER the join (oracle lh+addiu; a folded re-read
       inside the if propagated the constant 1) + InMenu!=0 arm INLINE first */
    detailIndex = (carObj->render).detail + 2;
    if ((R3DCar_InMenu & 0x80U) != 0) {
      (carObj->N).position.y = (carObj->N).position.y - (carObj->N).dimension.y * 2;
    }
    else {
      (carObj->N).position.y = (carObj->N).position.y + (carObj->N).dimension.y;
    }
    {
    coorddef car;   /* SYM blk 461 @ff58 */
    coorddef pos;   /* SYM blk 461 @ff68 */
    car.x = (carObj->N).position.x - (Vi->cview).translation.x;
    car.y = (carObj->N).position.y - (Vi->cview).translation.y;
    car.z = (carObj->N).position.z - (Vi->cview).translation.z;
    iVar9 = car.x;
    if (car.x < 0) {
      iVar9 = car.x + 0xff;
    }
    iVar11 = (carObj->N).orientMat.m[0];
    if (iVar11 < 0) {
      iVar11 = iVar11 + 0xff;
    }
    iVar16 = car.y;
    if (car.y < 0) {
      iVar16 = car.y + 0xff;
    }
    iVar12 = (carObj->N).orientMat.m[1];
    if (iVar12 < 0) {
      iVar12 = iVar12 + 0xff;
    }
    iVar15 = car.z;
    if (car.z < 0) {
      iVar15 = car.z + 0xff;
    }
    iVar13 = (carObj->N).orientMat.m[2];
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    /* MATCH: += accumulation (oracle adds each product into the named var; a single
       sum-expression serializes all three mults through anonymous temps) */
    pos.x = (iVar9 >> 8) * (iVar11 >> 8);
    pos.x = pos.x + (iVar16 >> 8) * (iVar12 >> 8);
    pos.x = pos.x + (iVar15 >> 8) * (iVar13 >> 8);
    iVar11 = (carObj->N).orientMat.m[6];
    if (iVar11 < 0) {
      iVar11 = iVar11 + 0xff;
    }
    iVar12 = (carObj->N).orientMat.m[7];
    if (iVar12 < 0) {
      iVar12 = iVar12 + 0xff;
    }
    iVar15 = car.z;
    if (car.z < 0) {
      iVar15 = car.z + 0xff;
    }
    iVar13 = (carObj->N).orientMat.m[8];
    if (iVar13 < 0) {
      iVar13 = iVar13 + 0xff;
    }
    pos.z = (iVar9 >> 8) * (iVar11 >> 8);
    pos.z = pos.z + (iVar16 >> 8) * (iVar12 >> 8);
    pos.z = pos.z + (iVar15 >> 8) * (iVar13 >> 8);
    iVar9 = fixedatan(pos.x,pos.z);
    if (iVar9 < 0) {
      iVar9 = iVar9 + 0xf;
    }
    R3DCar_yawCam = 0x1000 - (iVar9 >> 4);
    }
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,bodyMat.m);
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,insideMat.m);
    if ((R3DCar_InMenu & 0x80U) != 0) {
      bodyMat.m[3] = -bodyMat.m[3];
      bodyMat.m[5] = -bodyMat.m[5];
      bodyMat.m[4] = -bodyMat.m[4];
    }
    else if (rightHandDrive != 0) {
      insideMat.m[0] = -insideMat.m[0];
      insideMat.m[2] = -insideMat.m[2];
      insideMat.m[1] = -insideMat.m[1];
    }
    Math_fasttransmult(&bodyMat,&(Vi->cview).mrotationInv,&orientMat);
    Math_fasttransmult(&insideMat,&(Vi->cview).mrotationInv,&orientIMat);
    if (carType < 0x1c) {
      for (i = 0; i < 0x39; i = i + 1) {
        short code;   /* SYM blk 502 REG a1 -- sibling redecl (blk 630 = loop2) */
        code = (signed char)R3DCar_ObjectInfo[i][detailIndex];
        switch((short)(code - 2)) {
        /* MATCH: case bodies in ORACLE VA order (jtbl_800564E0):
           0, 1, 7, 9, 10, 5, 6, 0x14, 0xc, 0xb, 0xe/0x11, 2/8+clearVis tail */
        case 0:
          if (((carObj->render).inside & 1U) != 0) goto R_ICFtMenu_clearVisibility;
        case 1:
          if ((R3DCar_InMenu & 0x80U) != 0) {
            code = 0;
          }
          break;
        case 7:
          uVar7 = (carObj->render).inside;
R_ICFtMenu_caseB_upgrade:
          if ((uVar7 & 1) != 0) {
            code = 0;
          }
          break;
        case 9:
          if (((carObj->render).upgradeFlags & 4U) != 0) {
            code = 0;
          }
          break;
        case 10:
          if (((carObj->render).upgradeFlags & 4U) == 0) {
            code = 0;
          }
          break;
        case 5:
          if (((carObj->render).headLight & 2U) == 0) {
            code = 0;
          }
          break;
        case 6:
          if (((carObj->render).headLight & 0x20U) == 0) {
            code = 0;
          }
          break;
        case 0x14:
          if (((carObj->render).headLight & 0x11U) == 0) {
            code = 0;
          }
          break;
        case 0xc:
          if (((carObj->render).upgradeFlags & 1U) == 0) {
            code = 0;
          }
          break;
        case 0xb:
          uVar7 = (u_short)(u_char)(carObj->render).upgradeFlags;
          goto R_ICFtMenu_caseB_upgrade;
        case 0xe:
        case 0x11:
          if (cop_flag != 0) break;
        case 2:
        case 8:
R_ICFtMenu_clearVisibility:
          code = 0;
        default:
          break;
        }
        R3DCar_ObjectVisible[i] = code;
      }
    }
    else {
      for (i = 0; i < 0x39; i = i + 1) {
        short code;   /* SYM blk 630 REG a1 -- sibling redecl */
        code = (signed char)R3DCar_ObjectInfo[i][detailIndex];
        if (code != 0x12) {
          if (code < 0x13) {
            if (code != 1) {
              code = 0;
            }
          }
          else if (code != 0x16) {
            code = 0;
          }
        }
        if ((carType == 0x1c) && (i == 0x20)) {
          code = 1;
        }
        R3DCar_ObjectVisible[i] = code;
      }
    }
    obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[0];
    parent.x = (obj->translation).x;
    parent.y = (obj->translation).y;
    parent.z = (obj->translation).z;
    for (i = 0; i < 0x39; i = i + 1) {
      coorddef translation;  /* SYM blk 663 @ff58 -- sibling redecl */
      coorddef tmp;          /* SYM blk 663 @ff68 */
      int suspensionOffset;  /* SYM blk 663 REG a0 */
      obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[i];
      if ((obj->numFacet != 0) && (R3DCar_ObjectVisible[i] != '\0')) {
        if ((i == 0xf) || (suspensionOffset = rideHeight, 0x2e < i)) {
          suspensionOffset = 0;
        }
        tmp.x = (obj->translation).x - parent.x;
        tmp.y = ((obj->translation).y - parent.y) - suspensionOffset;
        tmp.z = (obj->translation).z - parent.z;
        if (((0x1b < carType) || (i < 0x23)) || (pmVar17 = &insideMat, 0x28 < i)) {
          pmVar17 = &bodyMat;
        }
        transform(&tmp.x,pmVar17->m,&translation.x);
        tmp.x = ((carObj->N).position.x + translation.x) - (Vi->cview).translation.x;
        tmp.y = ((carObj->N).position.y + translation.y) - (Vi->cview).translation.y;
        tmp.z = ((carObj->N).position.z + translation.z) - (Vi->cview).translation.z;
        transform(&tmp.x,(Vi->cview).mrotationInv.m,(int *)((int)R3DCar_position + i * 0xc))
        ;
        if (((0x1b < carType) || (i < 0x23)) || (pmVar17 = &orientIMat, 0x28 < i)) {
          pmVar17 = &orientMat;
        }
        R3DCar_MATRIX3DT_Copy(pmVar17->m,(int *)((int)R3DCar_orientMat + i * 0x24));
      }
    }
    TrsProj_TransformProjectVertex(&(Vi->cview).mrotationInv,&(Vi->cview).translationInv,1,&(carObj->N).position,
               &R3DCar_center);
    if ((R3DCar_InMenu & 0x80U) == 0) {
      coorddef lengthVector;     /* SYM blk 703 @ff58 -- sibling redecl */
      coorddef widthVector;      /* SYM blk 703 @ff68 */
      coorddef frontWidthVector; /* SYM blk 703 @ff78 */
      coorddef temp1;            /* SYM blk 703 @ff88 */
      coorddef temp2;            /* SYM blk 703 @ff98 */
      coorddef dimension;        /* SYM blk 703 @ffa8 */
      dimension.x = (carObj->N).dimension.x;
      dimension.z = (carObj->N).dimension.z;
      lengthVector.x = fixedmult(dimension.z,(carObj->N).orientMat.m[6]);
      lengthVector.y = fixedmult(dimension.z,(carObj->N).orientMat.m[7]);
      lengthVector.z = fixedmult(dimension.z,(carObj->N).orientMat.m[8]);
      widthVector.x = fixedmult(dimension.x,(carObj->N).orientMat.m[0]);
      widthVector.y = fixedmult(dimension.x,(carObj->N).orientMat.m[1]);
      widthVector.z = fixedmult(dimension.x,(carObj->N).orientMat.m[2]);
      if ((carObj->render).currentCarType == 0x14) {
        int front;   /* SYM blk 714 REG s0 */
        front = dimension.x * 0xc0 >> 8;
        frontWidthVector.x = fixedmult(front,(carObj->N).orientMat.m[0])
        ;
        frontWidthVector.y = fixedmult(front,(carObj->N).orientMat.m[1])
        ;
        frontWidthVector.z = fixedmult(front,(carObj->N).orientMat.m[2])
        ;
      }
      else {
        frontWidthVector.x = widthVector.x;
        frontWidthVector.y = widthVector.y;
        frontWidthVector.z = widthVector.z;
      }
      temp1.x = (carObj->N).position.x + lengthVector.x;
      temp1.z = (carObj->N).position.z + lengthVector.z;
      (carObj->N).shadowCoord[0].x = temp1.x - frontWidthVector.x;
      (carObj->N).shadowCoord[0].y = lengthVector.y - frontWidthVector.y;
      (carObj->N).shadowCoord[0].z = temp1.z - frontWidthVector.z;
      (carObj->N).shadowCoord[1].x = temp1.x + frontWidthVector.x;
      (carObj->N).shadowCoord[1].y = lengthVector.y + frontWidthVector.y;
      (carObj->N).shadowCoord[1].z = temp1.z + frontWidthVector.z;
      temp2.x = (carObj->N).position.x - lengthVector.x;
      temp2.z = (carObj->N).position.z - lengthVector.z;
      (carObj->N).shadowCoord[2].x = temp2.x - widthVector.x;
      (carObj->N).shadowCoord[2].y = -lengthVector.y - widthVector.y;
      (carObj->N).shadowCoord[2].z = temp2.z - widthVector.z;
      (carObj->N).shadowCoord[3].x = temp2.x + widthVector.x;
      (carObj->N).shadowCoord[3].y = -lengthVector.y + widthVector.y;
      (carObj->N).shadowCoord[3].z = temp2.z + widthVector.z;
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
  Draw_CarCache *visScratch;
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
    sd = (Draw_CarCache *)&Render_gPalettePtr;
    sd->color = iVar5 + uVar4 * 0x101;
    iVar5 = DrawC_PrimStart(&R3DCar_center,carObj,uVar4,sd);
    if (-1 < iVar5) {
      iVar12 = 0;
      iVar11 = 0;
      iStack_2c = 0;
      for (iVar9 = 0; iVar9 < 0x39; iVar9 = iVar9 + 1) {
        obj_00 = R3DCar_LoadedScenePointer[bVar1][iVar10]->obj[iVar9];
        visScratch = (Draw_CarCache *)(u_int)(u_char)R3DCar_ObjectVisible[iVar9];
        if ((obj_00->numFacet != 0) && (visScratch != (Draw_CarCache *)0x0)) {
          uVar7 = (u_int)R3DCar_ObjectInfo[0][iStack_2c * 2 + 1];
          iVar8 = (int)R3DCar_ObjectInfo[0][iStack_2c * 2];
          bVar2 = false;
          if ((iVar10 < 0x1c) && ((iVar9 - 0x1cU < 2 && (R3DCar_RecessedLight[iVar10] != '\0')))) {
            iVar8 = -iVar8;
          }
          if (((iVar3 != 0) && (0x22 < iVar9)) && (iVar9 < 0x29)) {
            bVar2 = true;
            sd->head.mirror = sd->head.mirror ^ 1;
          }
          visScratch = (Draw_CarCache *)&visScratch[-1].offsetV0;
          if ((int)visScratch < 0) {
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
            sd->sub_otz = (carObj->render).sub_otz + iVar8;
            if (iVar5 < iVar6) {
              DrawC_PrimClip((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj_00,overlay_00,envmap,
                         sd);
            }
            else {
              DrawC_Prim((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj_00,overlay_00,envmap,
                         sd);
            }
          }
          else {
            iVar6 = -1;
            if (iVar10 < 0x1c) {
              iVar6 = (int)R3DCar_FlareOverlayIndex[(int)visScratch];
            }
            sd->sub_otz = (carObj->render).sub_otz + iVar8;
            DrawC_PrimHalo((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                       (coorddef *)((int)R3DCar_position + iVar12),obj_00,
                       iVar8,iVar6,reflect,sd);
          }
          if (bVar2) {
            sd->head.mirror = sd->head.mirror ^ 1;
          }
        }
        iVar12 = iVar12 + 0xc;
        iVar11 = iVar11 + 0x24;
        iStack_2c = iStack_2c + 3;
      }
      DrawC_PrimStop(carObj,sd);
      if (R3DCar_shadowFlag != 0) {
        sd->color = ((int)(uVar4 * R3DCar_shadowColour.b) >> 8) * 0x10000 +
                       ((int)(uVar4 * R3DCar_shadowColour.g) >> 8) * 0x100 +
                       ((int)(uVar4 * R3DCar_shadowColour.r) >> 8);
        if (iVar5 < 0x20) {
          DrawC_ShadowPrimClip(R3DCar_shadowVertex,sd);
        }
        else {
          DrawC_ShadowPrim(R3DCar_shadowVertex,sd);
        }
      }
    }
  }
  return;
}

/* ---- R3DCar_InsertCarFacetMenuII__FP8Car_tObji  [R3DCAR.CPP:3273-3395] SLD-VERIFIED ---- */
void R3DCar_InsertCarFacetMenuII(Car_tObj *carObj,int light)

{
  int i;
  int lightAvg;
  int carType;
  int countryFlag;
  int rightHandDrive;
  Transformer_zOverlay *overlay;
  Draw_CarCache *sd;

  carType = (int)(carObj->render).currentCarType;
  countryFlag = (u_char)(carObj->render).currentCountry >> 7;
  overlay = &R3DCar_LoadedScenePointer[countryFlag][carType]->overlay[0];
  rightHandDrive = R3DCar_rightHandDrive;
  lightAvg = light;
  if ((R3DCar_InMenu & 0x80U) != 0) {
    lightAvg = lightAvg >> 1;
  }
  sd = (Draw_CarCache *)&Render_gPalettePtr;
  sd->color = lightAvg * 0x10101;
  if (-1 < (carObj->render).detail) {
    if (-1 < DrawC_PrimStart(&R3DCar_center,carObj,lightAvg,sd)) {
      int posOff;
      int matOff;
      char (*pacVar10) [6];

      matOff = 0;
      posOff = 0;
      pacVar10 = R3DCar_ObjectInfo;
      for (i = 0; i < 0x39; i = i + 1) {
        Transformer_zObj *obj;
        int visible;

        obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[i];
        visible = (u_char)R3DCar_ObjectVisible[i];
        if ((obj->numFacet != 0) && (visible != 0)) {
          int mirror;
          u_int envmap;
          int type;
          int index;
          int copIndex;
          int cop_type;
          bool mirrorFlip;

          envmap = (u_int)(*pacVar10)[1];
          mirror = (int)(*pacVar10)[0];
          mirrorFlip = false;
          if ((carType < 0x1c) && ((i - 0x1cU < 2 && (R3DCar_RecessedLight[carType] != 0)))) {
            mirror = -mirror;
          }
          if (((rightHandDrive != 0) && (0x22 < i)) && (i < 0x29)) {
            mirrorFlip = true;
            sd->head.mirror = sd->head.mirror ^ 1;
          }
          type = visible - 0x11;
          if (type >= 0) {
            /* headlamp / cop-siren facet */
            bool nearCar;

            index = -1;
            if (carType < 0x1c) {
              if (carType >= 0x16) {
                copIndex = R3DCar_CopIndex[carType - 0x16][(carObj->render).currentCountry & 0x7f];
                cop_type = R3DCar_FlareCopSirenType[copIndex][type];
                if (cop_type != 0) {
                  type = cop_type;
                }
                if (((envmap & 0x10) != 0) && ((R3DCar_InMenu & 0x80U) != 0)) {
                  mirror = 0;
                }
                index = R3DCar_FlareOverlayIndex[visible - 0x11];
                nearCar = false;
              }
              else {
                nearCar = true;
                if ((type == 4) && (R3DCar_SignalBrakeFlare[carType] != 0)) {
                  type = 1;
                }
              }
              if ((!nearCar) && (type == 1)) {
                type = 0x601;
              }
            }
            if ((R3DCar_InMenu & 0x80U) != 0) {
              type |= 0x8080;
            }
            sd->sub_otz = (carObj->render).sub_otz + mirror;
            DrawC_PrimHalo((matrixtdef *)((int)R3DCar_orientMat + matOff),
                       (coorddef *)((int)R3DCar_position + posOff),obj,
                       type,index,0,sd);
          }
          else {
            /* envmap-masked menu facet (mirror overlay) */
            u_int maskFlag;

            if (carType >= 0x1c) {
              envmap &= 0x80;
              if (carType == 0x1c) {
                maskFlag = envmap & 0x80;
                if (i == 0x23) {
                  mirror = 4;
                }
              }
              else {
                goto R_ICFtMenuII_block43;
              }
            }
            else if ((envmap & 0x10) != 0) {
              maskFlag = envmap & 0x80;
              if (carType >= 0x16) {
                mirror = mirror + 0xc;
                if ((R3DCar_InMenu & 0x80U) != 0) {
                  mirror = -mirror;
                }
                goto R_ICFtMenuII_block43;
              }
            }
            else {
R_ICFtMenuII_block43:
              maskFlag = envmap & 0x80;
            }
            if ((maskFlag != 0) && ((R3DCar_InMenu & 0x80U) != 0)) {
              mirror = -mirror;
            }
            sd->sub_otz = (carObj->render).sub_otz + mirror;
            DrawC_PrimMenu((matrixtdef *)((int)R3DCar_orientMat + matOff),
                       (coorddef *)((int)R3DCar_position + posOff),obj,overlay,envmap,
                       sd);
          }
          if (mirrorFlip) {
            sd->head.mirror = sd->head.mirror ^ 1;
          }
        }
        posOff = posOff + 0xc;
        matOff = matOff + 0x24;
        pacVar10 = pacVar10 + 1;
      }
      DrawC_PrimStop(carObj,sd);
      if ((R3DCar_InMenu & 0x80U) == 0) {
        DrawC_ShadowPrimClip(R3DCar_shadowVertex,sd);
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
  R3DCar_InsertCarFacet(carObj,Vi);
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
