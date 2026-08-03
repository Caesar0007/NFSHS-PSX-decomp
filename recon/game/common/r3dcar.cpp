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
  src = locatebig(R3DCar_BigFile,infilename);   /* locatebig is 2-arg (locatbig.cpp:178); in_a2 was a bogus Ghidra incoming-reg artifact */
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
  int i;
  coorddef minp;
  coorddef maxp;

  minp.x = 0x630000;
  minp.y = 0x630000;
  minp.z = 0x630000;
  maxp.x = -0x630000;
  maxp.y = -0x630000;
  maxp.z = -0x630000;

  for (i = 0; i < 57; i++) {
  int j;
    Transformer_zObj *obj;

    obj = scene->obj[i];
    if (((signed char)R3DCar_ObjectInfo[i][3] == 1) && (obj->numVertex != 0)) {
      if ((i == 0) || (i > 46) || ((i == 2) && (carType == 28))) {
        for (j = 0; j < obj->numVertex; j++) {
          minp.x = obj->vertex[j].x + obj->translation.x / 256 >= minp.x ?
              minp.x : obj->vertex[j].x + obj->translation.x / 256;
          minp.y = obj->vertex[j].y + obj->translation.y / 256 >= minp.y ?
              minp.y : obj->vertex[j].y + obj->translation.y / 256;
          minp.z = obj->vertex[j].z + obj->translation.z / 256 >= minp.z ?
              minp.z : obj->vertex[j].z + obj->translation.z / 256;
          maxp.x = obj->vertex[j].x + obj->translation.x / 256 >= maxp.x ?
              obj->vertex[j].x + obj->translation.x / 256 : maxp.x;
          maxp.y = obj->vertex[j].y + obj->translation.y / 256 >= maxp.y ?
              obj->vertex[j].y + obj->translation.y / 256 : maxp.y;
          maxp.z = obj->vertex[j].z + obj->translation.z / 256 >= maxp.z ?
              obj->vertex[j].z + obj->translation.z / 256 : maxp.z;
        }
      }

      if (i > 46) {
        int minWheelX;
        int minWheelZ;
        int maxWheelX;
        int maxWheelZ;

        minWheelX = 0x630000;
        minWheelZ = 0x630000;
        maxWheelX = -0x630000;
        maxWheelZ = -0x630000;
        for (j = 0; j < obj->numVertex; j++) {
          minWheelX = __builtin_abs(obj->vertex[j].x + obj->translation.x / 256) >= minWheelX ?
              minWheelX : __builtin_abs(obj->vertex[j].x + obj->translation.x / 256);
          minWheelZ = __builtin_abs(obj->vertex[j].z + obj->translation.z / 256) >= minWheelZ ?
              minWheelZ : __builtin_abs(obj->vertex[j].z + obj->translation.z / 256);
          maxWheelX = __builtin_abs(obj->vertex[j].x + obj->translation.x / 256) >= maxWheelX ?
              __builtin_abs(obj->vertex[j].x + obj->translation.x / 256) : maxWheelX;
          maxWheelZ = __builtin_abs(obj->vertex[j].z + obj->translation.z / 256) >= maxWheelZ ?
              __builtin_abs(obj->vertex[j].z + obj->translation.z / 256) : maxWheelZ;
        }

        if (i >= 53) {
          carObj->N.wheelBackX = ((minWheelX + maxWheelX + 1) >> 1) << 8;
          carObj->N.wheelBackZ = ((minWheelZ + maxWheelZ + 1) >> 1) << 8;
          carObj->N.wheelWidthB = ((maxWheelX - minWheelX) << 8) + 0xccc;
        } else if (i >= 47) {
          carObj->N.wheelFrontX = ((minWheelX + maxWheelX + 1) >> 1) << 8;
          carObj->N.wheelFrontZ = ((minWheelZ + maxWheelZ + 1) >> 1) << 8;
          carObj->N.wheelWidthF = ((maxWheelX - minWheelX) << 8) + 0xccc;
        }
      }
    }
  }

  carObj->N.dimension.x = ((maxp.x - minp.x) / 2) << 8;
  carObj->N.dimension.y = ((maxp.y - minp.y) / 2) << 8;
  carObj->N.dimension.z = ((maxp.z - minp.z) / 2) << 8;
  if (carType == 28) {
    carObj->N.dimension.z >>= 1;
  }

  carObj->N.dimensionRadius =
      fixedsqrt((carObj->N.dimension.x / 256) * (carObj->N.dimension.x / 256) +
                (carObj->N.dimension.y / 256) * (carObj->N.dimension.y / 256));
  carObj->N.dimensionRadius =
      fixedsqrt((carObj->N.dimensionRadius / 256) * (carObj->N.dimensionRadius / 256) +
                (carObj->N.dimension.z / 256) * (carObj->N.dimension.z / 256));
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
  u_char bVar1;
  u_short uVar2;
  short sVar3;
  Transformer_zScene *pTVar4;
  char *pcVar5;
  GameSetup_tCarData *pGVar6;
  char *pcVar7;
  u_int uVar8;
  int iVar9;
  int iVar10;
  int carType;
  int carType_00;
  int reload;
  u_int uVar12;
  char filename [10];
  char workFile [10];
  char bigname [100];
  
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
    if (R3DCar_InMenu != 0) {
      (carObj->render).inside = 1;
    }
    else if (GameSetup_gData.commMode == 1) {
      (carObj->render).medOnly = '\x01';
    }
    else if ((carObj->carFlags & 4U) != 0) {
      (carObj->render).inside = 1;
    }
    else if (Cars_gNumCars - Cars_gNumTrafficCars < 3) {
      (carObj->render).inside = 1;
    }
    else {
      (carObj->render).medOnly = '\x01';
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
  (carObj->render).newCarType = (short)carType_00;
  (carObj->render).currentCarType = (short)carType_00;
  (carObj->render).palCopy = (char *)0x0;
  (carObj->render).currentCountry = (char)carObj->carInfo->Country;
  if (R3DCar_InMenu == 0) {
  R3DCar_GetCarName(filename,carType_00,carObj->carInfo->Country);
  strcpy(bigname,Paths_Paths[0x18]);
  strcat(bigname,filename);
  if (((carObj->render).inside & 1U) != 0) {
    strcat(bigname,"h");
  }
  else if (((carObj->render).medOnly != '\0') && (carType_00 < 0x1c)) {
    strcat(bigname,"s");
  }
  strcat(bigname,".viv");
  R3DCar_BigFile = R3DCar_LoadFileAdr(bigname);
  strcpy(workFile,filename);
  if (((carObj->render).inside & 1U) != 0) {
    strcat(workFile,"h");
  }
  else if (((carObj->render).medOnly != '\0') && (carType_00 < 0x1c)) {
    strcat(workFile,"s");
  }
  if (R3DCar_LoadedScenePointer[0][carType_00] == (Transformer_zScene *)0x0) {
    int index;
    int color;

    color = (short)(carObj->render).colorIndex;
    pTVar4 = R3DCar_ReadInCarData(workFile,carObj);
    index = color >> 3;
    uVar12 = 0;
    R3DCar_LoadedScenePointer[0][carType_00] = pTVar4;
    R3DCar_LoadedSceneCounter[0][carType_00] = R3DCar_LoadedSceneCounter[0][carType_00] + '\x01';
    R3DCar_LoadedSceneCountry[carType_00] = (carObj->render).currentCountry;
    R3DCar_LoadedSceneColor[index][carType_00] = color & 8;
  }
  else {
    bVar1 = (carObj->render).currentCountry;
    if ((int)R3DCar_LoadedSceneCountry[carType_00] != (u_int)bVar1) {
      (carObj->render).currentCountry = bVar1 | 0x80;
      pTVar4 = R3DCar_ReadInCarData(workFile,carObj);
      R3DCar_LoadedScenePointer[1][carType_00] = pTVar4;
      uVar12 = 0;
      R3DCar_LoadedSceneCounter[1][carType_00] = R3DCar_LoadedSceneCounter[1][carType_00] + '\x01';
    }
    else {
      R3DCar_LoadedSceneCounter[0][carType_00] = R3DCar_LoadedSceneCounter[0][carType_00] + '\x01';
      uVar8 = (u_int)(u_short)(carObj->render).colorIndex;
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
    int i;
    char infilenames[4][15];
    char *shpfiles[4];
    char **shpfile;
    int index;
    int duplicateLicense;

    duplicateLicense = uVar12 << 1;
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
    if (7 < (carObj->render).colorIndex) {
      R3DCar_GetFileName(infilenames[index],filename,"d");
    }
    else {
      R3DCar_GetFileName(infilenames[index],filename,"l");
    }
    index = index + 1;
    pcVar7 = "g";
    R3DCar_GetFileName(infilenames[index],filename,"g");
    index = index + 1;
    for (i = 0; i < index; i = i + 1) {
      shpfiles[i] = locatebig(R3DCar_BigFile,infilenames[i]);   /* locatebig is 2-arg (locatbig.cpp:178) */
    }
    index = 1;
    (carObj->render).textureOffsetV = 0;
    (carObj->render).textureOffsetU = 0;
    CarIO_CreateLicense(carObj->carInfo->license,carType_00,0);
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    CarIO_ReadInCarTextureData(shpfiles[0],carObj,uVar12 | duplicateLicense,0);
    shpfile = shpfiles;
    if (((carObj->render).inside & 1U) != 0) {
      CarIO_ReadInCarTextureData(shpfile[index],carObj,0x19,0);
      index = index + 1;
    }
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 1) * 8;
    CarIO_ReadInCarTextureData(shpfile[index],carObj,duplicateLicense | 0x91,0);
    CarIO_CleanUpLicense(0);
    (carObj->render).palNum = (short)Texture_palNum;
    Texture_CarColor =
         ((u_short)(carObj->render).colorIndex & 7) + ((u_char)(carObj->render).upgradeFlags & 2) * 4;
    index = index + 1;
    CarIO_UpdateCarTextureData(shpfile[index],carObj,0);
  }
  else {
    char infilename[15];

    strcpy(infilename,workFile);
    strcat(infilename,".psh");
    pcVar7 = locatebig(R3DCar_BigFile,infilename);   /* locatebig is 2-arg (locatbig.cpp:178) */
    Texture_CarColor = (u_short)(carObj->render).colorIndex & 7;
    CarIO_ReadInCarTextureData(pcVar7,carObj,uVar12 | 0x88,0);
    (carObj->render).palNum = (short)Texture_palNum;
  }
  if (uVar12 == 0) {
    int index;

    index = (short)(carObj->render).colorIndex >> 3;
    R3DCar_LoadedSceneVRam[index][carType_00][0] = (carObj->render).VRamX;
    R3DCar_LoadedSceneVRam[index][carType_00][1] = (carObj->render).VRamY;
  }
  pcVar7 = (carObj->render).palCopy;
  if (pcVar7 != (char *)0x0) {
    resizememadr(pcVar7,(carObj->render).palNum * 0x208);
  }
  R3DCar_BigFile = (char *)0x0;
  }
  else {
    sVar3 = (carObj->render).inside;
    (carObj->render).currentCarType = -1;
    uVar2 = (carObj->render).newCarType;
    carObj->async_handle = 0;
    (carObj->render).inside = sVar3 << 4;
    (carObj->render).newCarType = uVar2 | 0x80;
    (carObj->render).newCountry = (carObj->render).currentCountry;
    R3DCar_BigFile = (char *)0x0;
    R3DCar_aSyncLoading = -1;
  }
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
  int i;                 /* SYM fn REG s4 -- born at the first visibility loop */
  Transformer_zObj *obj; /* SYM fn REG a1 -- per-iteration scene object */
  coorddef parent;       /* SYM fn AUTO sp+0x18 -- base obj[0] translation cache */
  matrixtdef bodyMat;
  matrixtdef orientMat;
  matrixtdef insideMat;
  matrixtdef orientIMat;
  matrixtdef steerMat;
  int rideHeight;
  int detailIndex;       /* SYM fn REG fp */
  int carType;           /* SYM fn REG s7 */
  int countryFlag;
  int rightHandDrive;
  int cop_flag;          /* SYM fn REG s6 */

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
  {
  u_short headLight;
  headLight = (carObj->render).headLight;
  if (((headLight & 8) == 0) && (0x1e0000 < (carObj->N).damage[0])) {
    /* MATCH: plain dual stores -- oracle ori h|0xc / h|8 + ONE cross-jump-merged sh */
    if ((headLight & 0x44) == 0) {
      (carObj->render).headLight = headLight | 0xc;
    }
    else if ((headLight & 2) != 0) {
      (carObj->render).headLight = headLight | 8;
    }
    headLight = (carObj->render).headLight;
  }
  if (((headLight & 0x80) == 0) && (0x1e0000 < (carObj->N).damage[2])) {
    if ((headLight & 0x44) == 0) {
      (carObj->render).headLight = headLight | 0xc0;
    }
    else if ((headLight & 0x20) != 0) {
      (carObj->render).headLight = headLight | 0x80;
    }
  }
  }
  if (cop_flag) {
    /* MATCH: ON arm first (oracle VA order: AIFlags&2 != 0 falls through to TurnHeadLightOn) */
    if ((carObj->AIFlags & 2U) != 0) {
      if (((carObj->render).signalLight[0] & 0x80U) == 0) {
        (carObj->render).signalLight[0] = 0x80;
        (carObj->render).signalLight[1] = 0x88;
        if (((carObj->control).lights & 2U) == 0) {
          R3DCar_TurnHeadLightOn(carObj,1);
        }
      }
    }
    else if (((carObj->render).signalLight[0] & 0x80U) != 0) {
      (carObj->render).signalLight[0] = 0;
      (carObj->render).signalLight[1] = 0;
      if (((carObj->control).lights & 2U) == 0) {
        u_int lightOff;

        lightOff = (u_int)(carObj->control).lights & 4U;
        R3DCar_TurnHeadLightOff(carObj,lightOff == 0);
      }
    }
  }
  if (R3DCar_Clock != 0) {
    u_short signalLight;
    signalLight = (carObj->render).signalLight[0];
    if ((signalLight & 0x80) != 0) {
      (carObj->render).signalLight[0] = signalLight + 1 & 0x8f;
    }
    signalLight = (carObj->render).signalLight[1];
    if ((signalLight & 0x80) != 0) {
      (carObj->render).signalLight[1] = signalLight + 1 & 0x8f;
    }
  }
  if (0x1b < carType) {
    rideHeight = 0;
  }
  else if (((carObj->render).upgradeFlags & 2U) != 0) {
    rideHeight = (carObj->render).upgradeHeight;
  }
  if (((carObj->render).detail == 0) && ((0x1b < carType || ((carObj->render).medOnly != '\0')))) {
    (carObj->render).detail = 1;
  }
  if (((carObj->render).detail == 2) && (carType == 0x1c)) {
    (carObj->render).detail = 1;
  }
  {
  /* SYM blk 123 (line 123-134): car/pos coorddef scratch -- SYM-VERIFIED against nfs4-f-v3.txt
     ($800afbd0 block @ line=123): car@sp+0xf0 (12B), pos@sp+0x100 (12B). pos.y (sp+0x104) is
     genuinely never written by the oracle -- only pos.x/pos.z hold the two dot-product sums. */
  coorddef car;
  coorddef pos;
  detailIndex = (carObj->render).detail + 2;
  car.x = (carObj->N).position.x - *(int *)((int)Vi + 8);
  car.y = (carObj->N).position.y - *(int *)((int)Vi + 0xc);
  car.z = (carObj->N).position.z - *(int *)((int)Vi + 0x10);
  pos.x = car.x / 0x100 * ((carObj->N).orientMat.m[0] / 0x100) +
          car.y / 0x100 * ((carObj->N).orientMat.m[1] / 0x100) +
          car.z / 0x100 * ((carObj->N).orientMat.m[2] / 0x100);
  pos.z = car.x / 0x100 * ((carObj->N).orientMat.m[6] / 0x100) +
          car.y / 0x100 * ((carObj->N).orientMat.m[7] / 0x100) +
          car.z / 0x100 * ((carObj->N).orientMat.m[8] / 0x100);
  R3DCar_yawCam = 0x1000 - (fixedatan(pos.x,pos.z) >> 4);
  }
  /* SYM blk 134/142/152 (if-arm) vs blk 174 (else-arm): bodyIMat/matP are BLOCK-SCOPED to the
     if-arm only (sp+0x110/sp+0x138); the else-arm's matP is a SEPARATE local reusing the
     car/pos slot (sp+0xf0) -- SYM-VERIFIED, replaces the earlier tmpMat.m+8 pointer-math bug
     (m1 aliased into the 36-byte car/pos region, which the oracle never does: it uses a real
     36-byte bodyIMat local at sp+0x110). */
  if (carType < 0x1c) {
    matrixtdef bodyIMat; /* SYM blk 152 @sp+0x110 */
    matrixtdef matP;     /* SYM blk 152 @sp+0x138 */
    int roll;            /* SYM blk 152 REG s3 -- live across the bodyMat calls */
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,insideMat.m);
    if (rightHandDrive != 0) {
      insideMat.m[0] = -insideMat.m[0];
      insideMat.m[1] = -insideMat.m[1];
      insideMat.m[2] = -insideMat.m[2];
    }
    /* MATCH: stripped depth raises roll's GCC flow priority without runtime code. */
    do {
    do {
      roll = (carObj->render).bodyRoll;
      if (rightHandDrive != 0) {
        roll = -roll;
      }
    } while (0);
    } while (0);
    fixedxformz(&bodyMat,(carObj->render).bodyRoll);
    fixedxformx(&matP,(carObj->render).bodyPitch + 100);
    Math_fasttransmult(&bodyMat,&matP,&bodyMat);
    Math_fasttransmult(&bodyMat,&(carObj->N).orientMat,&bodyMat);
    fixedxformz(&bodyIMat,roll);
    Math_fasttransmult(&bodyIMat,&matP,&bodyIMat);
    /* MATCH: three stripped depth levels cross the matrix-base ref-step (14 refs),
       so it takes s4 before the long-lived car pointer and naturally leaves carObj in s5. */
    do {
    do {
    do {
      Math_fasttransmult(&bodyIMat,&insideMat,&insideMat);
      Math_fasttransmult(&bodyMat,(matrixtdef *)((int)Vi + 0x44),&orientMat);
      Math_fasttransmult(&insideMat,(matrixtdef *)((int)Vi + 0x44),&orientIMat);
    } while (0);
    } while (0);
    } while (0);
  }
  else {
    matrixtdef matP; /* SYM blk 174 @sp+0xf0 (reuses car/pos slot -- dead by this point) */
    fixedxformz(&bodyMat,(carObj->render).bodyRoll);
    fixedxformx(&matP,(carObj->render).bodyPitch);
    Math_fasttransmult(&bodyMat,&matP,&bodyMat);
    Math_fasttransmult(&bodyMat,&(carObj->N).orientMat,&bodyMat);
    Math_fasttransmult(&bodyMat,(matrixtdef *)((int)Vi + 0x44),&orientMat);
  }
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    if (carType == 0x1c) {
      int wheelRotation;
      wheelRotation = (carObj->N).wheelRot[1];
      (carObj->N).wheelRot[0] = (carObj->N).wheelRot[0] + 0x1800U & 0xffff;
      (carObj->N).wheelRot[1] = wheelRotation + 0x1800U & 0xffff;
    }
    else {
      int vel;    /* SYM blk 196 REG a0 -- clamped IN PLACE */
      int spin;   /* SYM blk 196 REG v0 -- abs(wheelSpin), hoisted guard */
      int rear;   /* SYM blk 196 REG a1 -- the 0..2 wheel loop counter */
      int replayMode;
      rear = 0;
      replayMode = Replay_ReplayMode;
      spin = carObj->wheelSpin;
      if (spin < 0) {
        spin = -spin;
      }
      while (1) {
        if (rear >= 2) break;
        if (replayMode != 2) {
          vel = (carObj->linearVel_ch).z >> 6;
        }
        else {
          vel = (carObj->linearVel_ch).z >> (8U - Replay_ReplayInterface.speed);
        }
        if (rear != 0) {
          if (spin - 1U < 2) goto R_ICFt_wheelspinRpmCalc;
        }
        else if (carObj->frontWheelSpin != 0) {
R_ICFt_wheelspinRpmCalc:
          if ((u_char)(carObj->control).gear != 1) {
            vel = (carObj->flywheelRpm << 0x10) /
                  carObj->specs->velToRpmRatio[
                      (u_char)(carObj->control).gear];
            if (replayMode != 2) {
              vel = vel << 9;
            }
            else {
              vel = vel << (Replay_ReplayInterface.speed + 7U);
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
        rear = rear + 1;
      }
    }
  }
  {
    int steeringAngle;   /* SYM blk 227 REG s0 (live across the fixed* calls) */
    steeringAngle = (carObj->control).steering;
    if (0x1e0000 < (carObj->linearVel_ch).z) {
      steeringAngle =
          fixeddiv(steeringAngle << 0x10,fixedmult((carObj->linearVel_ch).z,0x888)) / 0x10000;
    }
    fixedxformy(&steerMat,steeringAngle << 5);
  }
  {
    u_short brakeLight;
    if (((carObj->control).desiredBrakeLevel != '\0') &&
        ((carObj->control).hanno == 0)) {
      brakeLight = (carObj->render).brakeLight | 1;
    }
    else {
      brakeLight = (carObj->render).brakeLight & 0xfe;
    }
    (carObj->render).brakeLight = brakeLight;
  }
  i = 0;
  if (carType < 0x1c) {
    for (; i < 0x39; i = i + 1) {
      short code;   /* SYM blk 261 (loop1) / blk 389 (loop2) REG a1 -- sibling redecl */
      u_int uVar8;
      code = (signed char)R3DCar_ObjectInfo[i][detailIndex];
      switch((short)(code - 2)) {
      /* MATCH: case bodies in ORACLE VA order (jlabels 800B03F4..800B05B0):
         0/7, 1/2, 9, 10, 5, 6, 0x14, 0xc, 0xb, 3, 4, 0x10, 0x11, 0x12, 0x13, 0xd, 0xe
         + shared dmgCheck/visibility-join tail LAST (L800B05B8..L800B05D0) */
      case 0:
      case 7:
        if (((carObj->render).inside & 1U) != 0) {
          code = 0;
        }
        break;
      case 1:
      case 2:
        if ((carObj->render).inside == 0) {
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
        if (((carObj->render).upgradeFlags & 1U) != 0) {
          code = 0;
        }
        break;
      case 3:
        if (((carObj->render).damageParts & 1U) != 0) {
          code = 0;
        }
        break;
      case 4:
        if (((carObj->render).damageParts & 2U) != 0) {
          code = 0;
        }
        break;
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
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) == 0) {
          code = 0;
        }
        else if ((cop_flag != 0) && (((carObj->render).damageParts & 4U) != 0)) {
          code = 0;
        }
        break;
      case 0x13:
        if (cop_flag == 0) {
          if ((*(u_int *)(carObj->render).signalLight & 0x800080) != 0) break;
          if (R3DCar_SignalBrakeFlare[carType] == 0) goto switchD_800b03ec_caseD_f;   /* @0x800B055C lbu SignalBrakeFlare(carType) */
          if ((carObj->render).brakeLight == 0) {
            code = 0;
          }
          goto R_ICFt_postSwitchVis;
        }
        if ((*(u_int *)(carObj->render).signalLight & 0x800080) == 0) {
          code = 0;
        }
        else if (((carObj->render).damageParts & 4U) != 0) {
          code = 0;
        }
        break;
      case 0xd:
cfLbl1:   /* @0x800b0524  (-f-build goto label) */
        if (cop_flag == 0) break;
        goto R_ICFt_caseE_dmgCheck;
      default:
        goto switchD_800b03ec_caseD_8;
      case 0xf:
        goto switchD_800b03ec_caseD_f;
      case 0xe:
        if (cop_flag == 0) goto switchD_800b03ec_caseD_f;
R_ICFt_caseE_dmgCheck:
        if (((carObj->render).damageParts & 4U) != 0) {
switchD_800b03ec_caseD_f:
          code = 0;
switchD_800b03ec_caseD_8: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
        }
        break;
      }
R_ICFt_postSwitchVis:
      if (i - 6U < 6) {
        /* #148: restored to source-level switch(i). The compiler emitted a 6-entry jumptable
         * @0x80056470 for indices 6..11 -> {6,7:0x800b05f4(A) 8,9:0x800b0600(B) 10,11:0x800b0648(C)};
         * Ghidra rendered it as switch-on-target-VA against an (empty) recovered jt array, which broke
         * the dispatch. Index->body mapping read from nfs4-f.exe rodata. */
        switch (i) {
        case 6: case 7:
          if (((carObj->render).damageParts & 0x18U) != 0) {
            code = 0;
          }
          break;
        case 8: case 9:
          if (((carObj->render).damageParts & 4U) != 0) {
            int damage;   /* SYM blk 362 REG v0 -- DamageSpoiler byte read ONCE */
            damage = R3DCar_DamageSpoiler[carType];   /* @0x800B0620 lbu DamageSpoiler(carType) */
            if (((carObj->render).upgradeFlags & 4U) != 0) {
              code = damage & 1;
            }
            else {
              code = damage & 0x80;
            }
            if (code != 0) {
              code = 0xb;
            }
          }
          goto R_ICFt_postVisibility;
        case 10: case 11:
          if (((carObj->render).damageParts & 4U) != 0) {
            code = 0;
          }
          break;
        }
      }
R_ICFt_postVisibility:
      R3DCar_ObjectVisible[i] = code;
    }
  }
  else {
    for (i = 0; i < 0x39; i = i + 1) {
      short code;   /* SYM blk 261 (loop1) / blk 389 (loop2) REG a1 -- sibling redecl */
      u_int uVar8;
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
  parent.x = (obj->translation).x;
  parent.y = (obj->translation).y;
  parent.z = (obj->translation).z;
  {
  matrixtdef tmpMat;   /* SYM blk 428 @ff08 (sibling of region2/3 block -> slot merges) */
  coorddef translation;/* SYM blk 428 @ff30 */
  coorddef tmp;        /* SYM blk 428 @ff40 */
  for (i = 0; i < 0x39; i = i + 1) {
    int suspensionOffset;   /* SYM blk 428 REG a0 */
    obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[i];
    if ((obj->numFacet == 0) || (R3DCar_ObjectVisible[i] == '\0'))
    goto R_ICFt_matrixCopyDone;
    /* MATCH: arm order per oracle -- suspension arm INLINE, rideHeight arm out-of-line */
    if (0x2e < i) {
      int index;            /* SYM blk 437 REG v1 */
      int limit;
      index = R3DCar_Suspension[i + -0x2f];
      suspensionOffset = carObj->wheel[index].impactCompression;
      if (0 < suspensionOffset) {
        if (0x1eb8 < suspensionOffset) {
          suspensionOffset = 0x1eb8;
        }
      }
      else {
        limit = -0x1eb8;
        if (-0x1eb9 < suspensionOffset) {
          limit = suspensionOffset;
        }
        suspensionOffset = limit;
      }
    }
    else {
      suspensionOffset = rideHeight - (carObj->render).currentHeight;
    }
    tmp.x = (obj->translation).x - parent.x;
    tmp.y = ((obj->translation).y - parent.y) - suspensionOffset;
    tmp.z = (obj->translation).z - parent.z;
    if (i < 0x2f) {
      if ((carType < 0x1c) && (0x22 < i) && (i < 0x29)) {
        transform(&tmp.x,insideMat.m,&translation.x);
      }
      else {
        transform(&tmp.x,bodyMat.m,&translation.x);
      }
    }
    else {
      transform(&tmp.x,(carObj->N).orientMat.m,&translation.x);
    }
    tmp.x = ((carObj->N).position.x + translation.x) - *(int *)((int)Vi + 8);
    tmp.y = ((carObj->N).position.y + translation.y) - *(int *)((int)Vi + 0xc);
    tmp.z = ((carObj->N).position.z + translation.z) - *(int *)((int)Vi + 0x10);
    transform(&tmp.x,((matrixtdef *)((int)Vi + 0x44))->m,
              (int *)((int)R3DCar_position + i * 0xc));
    if (carType == 0x1c) {
      switch (i) {
      case 0x1f:
        fixedxformy(&tmpMat,(carObj->N).wheelRot[0]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                           (matrixtdef *)((int)R3DCar_orientMat + 0x45c));
        break;
      case 0x23:
        fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
        Math_fasttransmult(&tmpMat,&bodyMat,&tmpMat);
        Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                           (matrixtdef *)((int)R3DCar_orientMat + 0x4ec));
        break;
      default:
        goto switchD_800b0a34_caseD_29;
      }
      goto R_ICFt_matrixCopyDone;
    }
    /* MATCH: case bodies in ORACLE physical order (jlabels 800B0A3C..800B0BD0):
       0x2f, 0x30-34, 0x35, 0x36, 0x37, 0x38, 0x23/24, 0x25, 0x26, 0x27/28 + shared tails, default */
    switch(i) {
    case 0x2f:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[0]);
      Math_fasttransmult(&tmpMat,&steerMat,&tmpMat);
      Math_fasttransmult(&tmpMat,&(carObj->N).orientMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x30:
    case 0x31:
    case 0x32:
    case 0x33:
    case 0x34:
      R3DCar_MATRIX3DT_Copy(((matrixtdef *)((int)R3DCar_orientMat + 0x69c))->m,
                            (int *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x35:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
      Math_fasttransmult(&tmpMat,&(carObj->N).orientMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x36:
      R3DCar_MATRIX3DT_Copy(((matrixtdef *)((int)R3DCar_orientMat + 0x774))->m,
                            (int *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x37:
      fixedxformx(&tmpMat,(carObj->N).wheelRot[1]);
      Math_fasttransmult(&tmpMat,&(carObj->N).orientMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x38:
      R3DCar_MATRIX3DT_Copy(((matrixtdef *)((int)R3DCar_orientMat + 0x7bc))->m,
                            (int *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x23:
    case 0x24:
      R3DCar_MATRIX3DT_Copy(orientIMat.m,
                            (int *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    case 0x25: {
      int steeringAngle;      /* SYM blk 546 REG v0 */
      steeringAngle = (carObj->control).steering;
      if (rightHandDrive != 0) {
        steeringAngle = -steeringAngle;
      }
      fixedxformz(&tmpMat,steeringAngle * -0x38);
      Math_fasttransmult(&tmpMat,&insideMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    }
    case 0x26: {
      matrixtdef matR;         /* SYM blk 558 @ff60 -- block-scoped to THIS case only (sibling
                                   of blk 576's matX/matY; oracle reuses these stack slots) */
      matrixtdef matP;         /* SYM blk 558 @ff88 */
      int roll;               /* SYM blk 558 REG a1 */
      int pitch;              /* SYM blk 558 REG s1 */
      roll = (carObj->render).bodyRoll * 3 >> 1;
      pitch = (carObj->render).bodyPitch << 3;
      if (rightHandDrive != 0) {
        roll = -roll;
      }
      fixedxformz(&matR,roll);
      fixedxformx(&matP,pitch);
      Math_fasttransmult(&matR,&matP,&tmpMat);
      Math_fasttransmult(&tmpMat,&insideMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    }
    case 0x27:
    case 0x28: {
      matrixtdef matX;         /* SYM blk 576 @ff50 -- block-scoped to THIS case only */
      matrixtdef matY;         /* SYM blk 576 @ff78 */
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
      Math_fasttransmult(&matX,&matY,&tmpMat);
      Math_fasttransmult(&tmpMat,&insideMat,&tmpMat);
      Math_fasttransmult(&tmpMat,(matrixtdef *)((int)Vi + 0x44),
                         (matrixtdef *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    }
    default:
switchD_800b0a34_caseD_29:
      R3DCar_MATRIX3DT_Copy(orientMat.m,
                            (int *)((int)R3DCar_orientMat + i * 0x24));
      goto R_ICFt_matrixCopyDone;
    }
R_ICFt_matrixCopyDone: ;   /* empty stmt: gcc2.7.2 rejects label before '}' */
  }
  }
  TrsProj_TransformProjectVertex((matrixtdef *)((int)Vi + 0x44),(coorddef *)((int)Vi + 0x38),1,&(carObj->N).position,
             &R3DCar_center);
  if ((R3DCar_shadowColour.r != '\0') && ((carObj->N).simOptz == '\0')) {
    Newton_CalcRealShadowCoordinates(carObj,simGlobal.gameTicks);
    TrsProj_TransformProjectVertex((matrixtdef *)((int)Vi + 0x44),(coorddef *)((int)Vi + 0x38),4,(carObj->N).shadowCoord,
               R3DCar_shadowVertex);
    R3DCar_shadowFlag = 1;
  }
  else {
    R3DCar_shadowFlag = 0;
  }
  if ((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) {
    if (Replay_ReplayMode != 2) {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ + *(short *)((int)&(carObj->linearVel_ch).z + 2);
    }
    else {
      (carObj->N).positionXZ =
           (carObj->N).positionXZ +
           (short)((carObj->linearVel_ch).z >> (0x12U - Replay_ReplayInterface.speed));
    }
  }
  /* MATCH: gShadowMax read AT USE (oracle loads it after the envmap loop); walkers are
     compiler givs of the index form (SYM tail blocks have NO named pointer locals) */
  i = 0;
  for (; i < DrawC_gEnvMapMax; i = i + 1) {
    if ((carObj->N).simRoadInfo.slice < DrawC_gEnvMap[i].slice) {
      break;
    }
  }
  (carObj->N).eIndexEnvMap = (short)i;
  i = 0;
  for (; i < DrawC_gShadowMax; i = i + 1) {
    if ((carObj->N).simRoadInfo.slice < DrawC_gShadow[i].slice) {
      break;
    }
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
  u_char bVar2;
  short sVar3;
  u_short uVar7;
  int iVar8;
  int iVar9;
  Transformer_zScene *pTVar10;
  int iVar11;
  int iVar12;
  int iVar13;
  int iVar15;
  int iVar16;
  GameSetup_tCarData *pGVar14;
  u_int uVar20;
  u_long *(*subOtStart)[2];
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
  pGVar14 = carObj->carInfo;
  carType = pGVar14->carType;
  R3DCar_rightHandDrive = rightHandDrive;
  iVar8 = carType - 0x16;
  cop_flag = (u_int)iVar8 < 6;
  if (cop_flag == 0) {
    pGVar14->Country = 0;
  }
  subOtStart = R3DCar_subOtStart;
  uVar20 = R3DCar_InMenu & 0x80;
  iVar9 = uVar20 != 0;
  u_long **subOtRow = subOtStart[gFlip];
  iVar11 = ((carObj->N).objID & 0xfU) * 0x200;
  (carObj->render).sub_ot =
       subOtRow[iVar9] + iVar11;
  if (uVar20 != 0) goto R_ICFtMenu_sceneCounterJoin;
  (carObj->render).sub_otSize = 0x200;
  (carObj->render).sub_otOffset = 0x100;
  (carObj->render).sort_carObj = (u_char *)0x0;
  (carObj->render).sort_flag = 0;
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
  (carObj->render).detail = 0;
  if ((-1 < R3DCar_aSyncLoading) && (R3DCar_aSyncLoading != Vi->player))
    goto R_ICFtMenu_sceneCounterJoin;
  if (carObj->async_handle == 0) {
    if ((u_int)(u_char)(carObj->render).newCountry != carObj->carInfo->Country) {
      (carObj->render).newCarType = (carObj->render).newCarType | 0x80;
    }
    if (carObj->async_handle != 0) goto R_ICFtMenu_asyncHandleCheck;
    if ((carObj->render).newCarType != carType) {
      if (AudioMus_Buffered() >= AudioMus_Threshold()) {
        char filename [10];  /* SYM blk 221 @ff58 */
        char bigname [100];  /* SYM blk 221 @ff68 */
        if (0x1b < carType) {
          (carObj->render).inside = (carObj->render).inside & 0xef;
        }
        else {
          (carObj->render).inside = (carObj->render).inside | 0x10;
        }
        sprintf(filename,"zz%s",GameSetup_gCarNames[0] + carType * 5);
        if (cop_flag != 0) {
          int index;  /* SYM blk 247 REG a3 */
          index = (u_char)R3DCar_CopIndex[carType + -0x16][carObj->carInfo->Country];
          filename[2] = R3DCar_CopCountry[index];
        }
        strcpy(bigname,Paths_Paths[0x18]);
        strcat(bigname,filename);
        if (((carObj->render).inside & 0x10U) != 0) {
          strcat(bigname,"h");
        }
        strcat(bigname,".viv");
        iVar8 = asyncloadfile(bigname,(void *)0x10);
        carObj->async_handle = iVar8;
        R3DCar_aSyncLoading = Vi->player;
        (carObj->render).newCarType = (short)carType;
        (carObj->render).newCountry = (char)carObj->carInfo->Country;
      }
    }
    if (carObj->async_handle != 0) goto R_ICFtMenu_asyncHandleCheck;
  }
  else {
R_ICFtMenu_asyncHandleCheck:
    {
    int status;   /* SYM blk 273 REG s0 */
    status = getasyncreadstatus(carObj->async_handle);
    if ((0 < status) || (status == -1)) {
      if (((carObj->render).newCarType != carType) ||
          ((u_int)(u_char)(carObj->render).newCountry != carObj->carInfo->Country)) {
        char *cancelFile = getasyncreadadr(carObj->async_handle);
        if (cancelFile != (char *)0x0) {
          purgememadr(cancelFile);
          goto R_ICFtMenu_asyncAbort;
        }
      }
      else {
        char *bigFile;   /* SYM blk 281 REG v0 */
        bigFile = getasyncreadadr(carObj->async_handle);
        R3DCar_BigFile = bigFile;
        if (bigFile == (char *)0x0) {
          changeCar = 0;
          goto R_ICFtMenu_sceneCounterJoin;
        }
        carObj->async_handle = 0;
        if (status == -1) {
          purgememadr(bigFile);
          R3DCar_BigFile = (char *)0x0;
          (carObj->render).newCarType = (carObj->render).newCarType | 0x80;
          goto R_ICFtMenu_bigFileCheck;
        }
        R3DCar_aSyncLoading = -1;
        goto R_ICFtMenu_bigFileCheck;
      }
    }
    else if (status == -2) {
R_ICFtMenu_asyncAbort:
      carObj->async_handle = 0;
      (carObj->render).newCarType = (carObj->render).newCarType | 0x80;
    }
    }
  }
R_ICFtMenu_bigFileCheck:
  if (R3DCar_BigFile != (char *)0x0) {
    char filename [10];  /* SYM blk 321 @ff58 -- sibling redecl */
    char workFile [10];  /* SYM blk 321 @ff68 */
    int reload;          /* SYM blk 321 REG fp */
    int currentCarType;  /* SYM blk 321 REG s0 */
    currentCarType = (int)(carObj->render).currentCarType;
    reload = 0;
    if (-1 < currentCarType) {
      char cVar6;
      cVar6 = --R3DCar_LoadedSceneCounter[countryFlag][currentCarType];
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
    carType = (int)sVar3;
    if (Vi->player != 0) {
      (carObj->render).currentCountry = bVar2 | 0x80;
    }
    countryFlag = (int)((u_char)(carObj->render).currentCountry >> 7);
    (carObj->render).inside = (carObj->render).inside >> 4;
    sprintf(filename,"zz%s",GameSetup_gCarNames[0] + carType * 5);
    if (cop_flag != 0) {
      int index;  /* SYM blk 372 REG a3 */
      index = (u_char)R3DCar_CopIndex[carType + -0x16]
                                         [(u_char)(carObj->render).currentCountry & 0x7f];
      filename[2] = R3DCar_CopCountry[index];
    }
    strcpy(workFile,filename);
    if (((carObj->render).inside & 1U) != 0) {
      strcat(workFile,"h");
    }
    Transformer_zScene **loadedSceneBase = &R3DCar_LoadedScenePointer[0][0];
    ppTVar21 = loadedSceneBase + countryFlag * 50 + carType;
    if (*ppTVar21 != (Transformer_zScene *)0x0) {
      purgememadr(*ppTVar21);
      *ppTVar21 = (Transformer_zScene *)0x0;
    }
    pTVar10 = R3DCar_ReadInCarData(workFile,carObj);
    *ppTVar21 = pTVar10;
    R3DCar_LoadedSceneCounter[countryFlag][carType] =
         R3DCar_LoadedSceneCounter[countryFlag][carType] + '\x01';
    R3DCar_CalcCarDimensions(carObj,*ppTVar21,carType);
    R3DCar_ReadInCarTextureMenu(carObj,R3DCar_BigFile,reload,Vi->player);
    R3DCar_BigFile = (char *)0x0;
    changeCar = 1;
  }
  else {
    changeCar = 0;
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
      if (cop_flag != 0) {
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
      else {
        if (changeCar != 0) {
          (carObj->render).brakeLight = 0;
        }
      }
    }
    if (0x1b < carType) {
      rideHeight = 0;
    }
    else if (((carObj->render).upgradeFlags & 2U) != 0) {
      rideHeight = (carObj->render).upgradeHeight;
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
    pos.x = (car.x / 0x100) * ((carObj->N).orientMat.m[0] / 0x100) +
            (car.y / 0x100) * ((carObj->N).orientMat.m[1] / 0x100) +
            (car.z / 0x100) * ((carObj->N).orientMat.m[2] / 0x100);
    pos.z = (car.x / 0x100) * ((carObj->N).orientMat.m[6] / 0x100) +
            (car.y / 0x100) * ((carObj->N).orientMat.m[7] / 0x100) +
            (car.z / 0x100) * ((carObj->N).orientMat.m[8] / 0x100);
    R3DCar_yawCam = 0x1000 - fixedatan(pos.x,pos.z) / 0x10;
    }
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,bodyMat.m);
    R3DCar_MATRIX3DT_Copy((carObj->N).orientMat.m,insideMat.m);
    if ((R3DCar_InMenu & 0x80U) != 0) {
      bodyMat.m[3] = -bodyMat.m[3];
      bodyMat.m[4] = -bodyMat.m[4];
      bodyMat.m[5] = -bodyMat.m[5];
    }
    else if (rightHandDrive != 0) {
      insideMat.m[0] = -insideMat.m[0];
      insideMat.m[1] = -insideMat.m[1];
      insideMat.m[2] = -insideMat.m[2];
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
          if (((carObj->render).inside & 1U) != 0) {
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
          if (((carObj->render).upgradeFlags & 1U) != 0) {
            code = 0;
          }
          break;
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
        if (i == 0xf) goto R_ICFtMenu_suspensionZero;
        if (i < 0x2f) goto R_ICFtMenu_suspensionRide;
R_ICFtMenu_suspensionZero:
        suspensionOffset = 0;
        goto R_ICFtMenu_suspensionSelected;
R_ICFtMenu_suspensionRide:
        suspensionOffset = rideHeight;
R_ICFtMenu_suspensionSelected:
        tmp.x = (obj->translation).x - parent.x;
        tmp.y = ((obj->translation).y - parent.y) - suspensionOffset;
        tmp.z = (obj->translation).z - parent.z;
        if ((carType < 0x1c) && (0x22 < i) && (i < 0x29)) {
          transform(&tmp.x,insideMat.m,&translation.x);
        }
        else {
          transform(&tmp.x,bodyMat.m,&translation.x);
        }
        tmp.x = ((carObj->N).position.x + translation.x) - (Vi->cview).translation.x;
        tmp.y = ((carObj->N).position.y + translation.y) - (Vi->cview).translation.y;
        tmp.z = ((carObj->N).position.z + translation.z) - (Vi->cview).translation.z;
        transform(&tmp.x,(Vi->cview).mrotationInv.m,(int *)((int)R3DCar_position + i * 0xc))
        ;
        if ((carType < 0x1c) && (0x22 < i) && (i < 0x29)) {
          R3DCar_MATRIX3DT_Copy(orientIMat.m,
                               (int *)((int)R3DCar_orientMat + i * 0x24));
        }
        else {
          R3DCar_MATRIX3DT_Copy(orientMat.m,
                               (int *)((int)R3DCar_orientMat + i * 0x24));
        }
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
      dimension = (carObj->N).dimension;
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
        frontWidthVector.z = widthVector.z;
        frontWidthVector.x = widthVector.x;
        frontWidthVector.y = widthVector.y;
      }
      temp1 = (carObj->N).position;
      temp1.y = 0;
      temp2.x = temp1.x + lengthVector.x;
      temp2.y = temp1.y + lengthVector.y;
      temp2.z = temp1.z + lengthVector.z;
      (carObj->N).shadowCoord[0].x = temp2.x - frontWidthVector.x;
      (carObj->N).shadowCoord[0].y = temp2.y - frontWidthVector.y;
      (carObj->N).shadowCoord[0].z = temp2.z - frontWidthVector.z;
      (carObj->N).shadowCoord[1].x = temp2.x + frontWidthVector.x;
      (carObj->N).shadowCoord[1].y = temp2.y + frontWidthVector.y;
      (carObj->N).shadowCoord[1].z = temp2.z + frontWidthVector.z;
      temp2.x = temp1.x - lengthVector.x;
      temp2.y = temp1.y - lengthVector.y;
      temp2.z = temp1.z - lengthVector.z;
      (carObj->N).shadowCoord[2].x = temp2.x - widthVector.x;
      (carObj->N).shadowCoord[2].y = temp2.y - widthVector.y;
      (carObj->N).shadowCoord[2].z = temp2.z - widthVector.z;
      (carObj->N).shadowCoord[3].x = temp2.x + widthVector.x;
      (carObj->N).shadowCoord[3].y = temp2.y + widthVector.y;
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
  int i;
  int light;
  int lightR;
  int lightG;
  int lightB;
  int lightAvg;
  int worldZ;
  int carType;
  int countryFlag;
  int rightHandDrive;
  Transformer_zOverlay *overlay;
  Draw_CarCache *sd;
  int inAir;
  int cop_type;
  int index;
  int iVar6;
  int copIndex;
  int envmap;
  int clip;
  Transformer_zObj *obj;
  int type;
  int offset;
  int visible;
  int iVar11;
  int iVar12;
  int mirror;
  int reflect;
  int iStack_2c;
  
  rightHandDrive = R3DCar_rightHandDrive;
  reflect = 0;
  carType = (int)(carObj->render).currentCarType;
  countryFlag = (u_char)(carObj->render).currentCountry >> 7;
  overlay = R3DCar_LoadedScenePointer[countryFlag][carType]->overlay;
  inAir = carObj->wheel[0].wheelInAir | carObj->wheel[1].wheelInAir |
          carObj->wheel[2].wheelInAir | carObj->wheel[3].wheelInAir;
  if (inAir == 0) {
    if (GameSetup_gData.Time == 0) {
      reflect = (u_int)(DrawC_gWetRoad != 0);
    }
    else {
      if (GameSetup_gData.commMode == 1) {
        reflect = -1;
        if (DrawC_gWetRoad == 0) goto R_ICFtII_setQuadLight;
        inAir = 1;
      }
      else {
        inAir = -2;
        if (DrawC_gWetRoad == 0) goto R_ICFtII_setQuadLight;
      }
      reflect = inAir;
    }
  }
R_ICFtII_setQuadLight:
  light = BWorldSm_QuadLight(&(carObj->N).simRoadInfo);
  (carObj->render).light = light & 0xffffff;
  if (-1 < (carObj->render).detail) {
    if (gNight_renderNight != 0) {
      DrawC_NightHeadlight(carObj);
    }
    light = (carObj->render).light;
    lightR = light & 0xff;
    lightG = (light & 0xff00) >> 8;
    lightB = (light >> 0x10) & 0xff;
    lightAvg = (lightR + lightG + lightB) / 3;
    light = lightAvg * 0x10000;
    if (lightAvg < 0x18) {
      lightAvg = 0x18;
      light = 0x180000;
    }
    sd = (Draw_CarCache *)&Render_gPalettePtr;
    sd->color = light + lightAvg * 0x101;
    worldZ = DrawC_PrimStart(&R3DCar_center,carObj,lightAvg,sd);
    if (-1 < worldZ) {
      i = 0;
      iVar12 = i;
      iVar11 = i;
      iStack_2c = 0;
      for (; i < 0x39; i = i + 1) {
        obj = R3DCar_LoadedScenePointer[countryFlag][carType]->obj[i];
        visible = (u_char)R3DCar_ObjectVisible[i];
        if ((obj->numFacet != 0) && (visible != 0)) {
          envmap = (int)*(signed char *)&R3DCar_ObjectInfo[0][iStack_2c * 2 + 1];
          offset = (int)*(signed char *)&R3DCar_ObjectInfo[0][iStack_2c * 2];
          mirror = false;
          if ((carType < 0x1c) && ((i - 0x1cU < 2 && (R3DCar_RecessedLight[carType] != '\0')))) {
            offset = -offset;
          }
          if (((rightHandDrive != 0) && (0x22 < i)) && (i < 0x29)) {
            mirror = true;
            sd->head.mirror = sd->head.mirror ^ 1;
          }
          type = visible - 0x11;
          if (type >= 0) {
            index = -1;
            if (carType < 0x1c) {
              if (0x15 < carType) {
                copIndex = R3DCar_CopIndex[carType - 0x16]
                                             [(carObj->render).currentCountry & 0x7f];
                cop_type = R3DCar_FlareCopSirenType[copIndex][type];
                if (cop_type != 0) {
                  type = cop_type;
                }
              }
              else if ((type == 4) && (R3DCar_SignalBrakeFlare[carType] != 0)) {
                type = 0x41;
              }
              if ((((carObj->render).brakeLight & 2U) != 0) ||
                  ((0x15 < carType) && ((carObj->AIFlags & 2U) != 0))) {
                if ((type & 0xbf) == 1) {
                  type = type | 0x600;
                }
              }
              index = (int)R3DCar_FlareOverlayIndex[visible - 0x11];
            }
            sd->sub_otz = (carObj->render).sub_otz + offset;
            DrawC_PrimHalo((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                       (coorddef *)((int)R3DCar_position + iVar12),obj,
                       type,index,reflect,sd);
          }
          else {
            clip = 0x20;
            if (0x1b < carType) {
              clip = 0x40;
              envmap = 0x22;
              if ((carType == 0x1c) && (i == 0x23)) {
                offset = 4;
              }
            }
            else {
              if (R3DCar_eMapColour.r == '\0') {
                envmap = envmap & 0xfe;
              }
              if (((envmap & 0x10) != 0) && (0x15 < carType)) {
                offset = offset + 0xc;
              }
            }
            if ((carObj->render).detail == 3) {
              envmap = envmap | 0x20;
              offset = -offset;
              if (i - 0x27U < 2) {
                offset = offset + -0x10;
              }
            }
            sd->sub_otz = (carObj->render).sub_otz + offset;
            if (worldZ < clip) {
              DrawC_PrimClip((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj,overlay,envmap,
                         sd);
            }
            else {
              DrawC_Prim((matrixtdef *)((int)R3DCar_orientMat + iVar11),
                         (coorddef *)((int)R3DCar_position + iVar12),obj,overlay,envmap,
                         sd);
            }
          }
          if (mirror) {
            sd->head.mirror = sd->head.mirror ^ 1;
          }
        }
        iVar12 = iVar12 + 0xc;
        iVar11 = iVar11 + 0x24;
        iStack_2c = iStack_2c + 3;
      }
      DrawC_PrimStop(carObj,sd);
      if (R3DCar_shadowFlag != 0) {
        sd->color = ((int)(lightAvg * R3DCar_shadowColour.r) >> 8) +
                       ((int)(lightAvg * R3DCar_shadowColour.g) >> 8) * 0x100 +
                       ((int)(lightAvg * R3DCar_shadowColour.b) >> 8) * 0x10000;
        if (worldZ < 0x20) {
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
  int i;
  int sort;
  int sort_min[Cars_gNumCars];
  int sort_max[Cars_gNumCars];

  gWSavePtr = (u_long)SetSp(&gScratchLastWord);
  stackSpeedUpEnbabledFlag = 1;
  if (Vi->player == 0) {
    if (generic128HzClock > R3DCar_ClockLast) {
      R3DCar_Clock = 1;
      R3DCar_ClockLast = *(volatile int *)&generic128HzClock + 6;
    }
    else {
      R3DCar_Clock = 0;
    }
  }
  for (i = 0; i < Cars_gNumCars; i++) {
    Car_tObj *carObj = Cars_gList[i];

    R3DCar_PositionZ[i] = R3DCar_Visibilty(carObj, Vi);
    carObj->render.sort_carObj = (u_char *)0;
    carObj->render.sort_flag = 0;
    sort_min[i] = 0;
    if (carObj->render.currentCarType == 0x1c) {
      sort_max[i] = 0x1a0;
    } else {
      sort_max[i] = carObj->N.dimension.z >> 9;
    }
  }
  sort = 1;
  for (i = 0; i < Cars_gNumCars - 1; i++) {
    if (R3DCar_PositionZ[i] != -0x80000000) {
      Car_tObj *carObj = Cars_gList[i];
      int j;

      for (j = sort; j < Cars_gNumCars; j++) {
        Car_tObj *sort_carObj = Cars_gList[j];
        int diffZ = R3DCar_PositionZ[i] - R3DCar_PositionZ[j];
        int size = carObj->N.dimension.z + sort_carObj->N.dimension.z;

        if (carObj->render.sort_carObj == (u_char *)0 &&
            sort_carObj->render.sort_carObj == (u_char *)0 &&
            __builtin_abs(diffZ) < size) {
          sort_carObj->render.sort_carObj = (u_char *)carObj;
          carObj->render.sort_flag++;
          if (diffZ < 0) {
            sort_min[i] -= sort_carObj->N.dimension.z >> 9;
          } else {
            sort_max[i] += sort_carObj->N.dimension.z >> 9;
          }
        }
      }
    }
    sort++;
  }
  R3DCar_subOt = R3DCar_subOtStart[gFlip][gCView.player];
  for (i = 0; i < Cars_gNumCars; i++) {
    if (R3DCar_PositionZ[i] != -0x80000000) {
      Car_tObj *carObj = Cars_gList[i];

      sort_min[i] -= 0x30;
      sort_max[i] += 0x30;
      if (carObj->render.sort_carObj == (u_char *)0) {
        int sub_otSize = sort_max[i] - sort_min[i];

        carObj->render.sub_ot = R3DCar_subOt;
        R3DCar_subOt += sub_otSize;
        carObj->render.sub_otSize = sub_otSize;
        carObj->render.sub_otOffset = sort_max[i] - (carObj->N.dimension.z >> 10);
      } else {
        carObj->render.sub_ot = (u_long *)0;
        carObj->render.sub_otSize = 0;
        carObj->render.sub_otOffset = 0;
      }
    }
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
  stackSpeedUpEnbabledFlag = 0;
  for (i = 0; i < Cars_gNumCars; i++) {
    Car_tObj *carObj = Cars_gList[i];

    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    R3DCar_InsertCarFacetZ(carObj, Vi);
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    R3DCar_InsertCarFacetII(carObj);
  }
  return;
}

/* end of r3dcar.cpp */
