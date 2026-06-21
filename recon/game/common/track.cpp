/* game/psx/track.cpp -- RECONSTRUCTED (NFS4 PSX track load/resources/materials; C++ TU)
 *   29 fns: track init/deinit, art+texture resources, LoadShapesAndMakePmx, material linking,
 *   object bounding spheres, kill data, SaveSurface class. GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "track_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
Chunk *Track_chunkList;
Group *gObjDefOffsetsGroup;
Group *gPersistMidgroundObjInst;
Group *gPersistObjDef;
Group *gPersistObjDefBoundingSpheres;
Group *gPersistObjInst;
SaveSurface *Track_gSaveSurface;
SimpleMem *Track_mem;
TrackHeader *Track_header;
Track_tMaterial *Track_materials;
Track_tMaterialController *Track_gMatController;
Trk_ObjectDef **Track_gObjDefs;
int *Track_gInViewCount;
int Chunk_numLight;
int Track_gControllerCount;
int gtrackNumber;
short **Track_gInViewList;

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
Track_MipMap *gTempMipMapInfo; Track_MultiPalette *gTempMultiPalInfo;

/* track.obj car-dashboard shape/tach name-prefix tables @0x80055A54 (contiguous; 58 char*,
 *   't'=day shapes / 'n'=night, decoded byte-exact from nfs4-f.exe via IDA NFS4.EXE.i64).
 *   HudPmx_InitTextures copies these into stack buffers, using &Track_gShapeNamePtrs_end and
 *   gShapeNamePtrs_subList+3 as loop bounds -- so declaration order MUST stay contiguous. */
char *Track_gShapeNamePtrs[28] = {                 /* @0x80055A54 : [0..27] */
    "tslk","tbz3","thsv","tfor","tz28","ttra","tdb7","txkr","ttm5","tvet",
    "t550","t911","tf50","tdsv","tclk","tmcf","t911","thsv","tvet","tbon",
    "tbon","tbon","tcap","thsv","ttm5","tvet","t911","tdsv" };
char *Track_gShapeNamePtrs_end[1] = { "tbon" };    /* @0x80055AC4 : [28] (loop-bound marker) */
/* decompiler also references the value form _Track_gShapeNamePtrs_end -> same [28] datum.
 * gcc2.7.2/ccpsx has no __attribute__((alias)); keep the alias for the modern pre-gate, and
 * resolve the underscore-symbol bridge (hudpmx.cpp) in the deferred linkage/hygiene pass. */
#ifndef NFS4_PSYQ_HEADERS
/* _Track_gShapeNamePtrs_end removed: hudpmx.cpp now uses Track_gShapeNamePtrs_end directly. */
#endif
char *Track_gTachNamePtrs[25] = {                  /* @0x80055AC8 : [29..53] */
    "nslk","nbz3","nhsv","nfor","nz28","ntra","ndb7","nxkr","nnm5","nvet",
    "n550","n911","nf50","tdsv","tclk","nmcf","n911","nhsv","nvet","nbon",
    "nbon","nbon","ncap","nhsv","nnm5" };
char *gShapeNamePtrs_subList[4] = { "nvet","n911","tdsv","nbon" };  /* @0x80055B2C : [54..57] */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Track_SetTrackNumber(int tracknum);
char * Track_MakeTrackPathName(char *ext);
char * Track_MakeTrackDataPathName(char *ext);
void AllocArtResource(Track_tArtresource *artRes,int numPmx);
void InitArtResources(void);
void DeInitArtResources(void);
void LoadShapesAndMakePmx(char *shapefile,Draw_tPixMap *pmxList,int loadFlags,int x,int y);
void LoadShapesAndMakePmx_EnvMap(char *shapefile,Draw_tPixMap *pmxList,int x,int y);
void TexturesLoadInitial(void);
void Track_AnimateTextures(void);
int Track_GetProperMultiPalShapeIndex(int shapeindex,int paletteindex);
void Track_ProcessFlipAndUVFlags(int uvFlag,Draw_tPixMap *inputPmx,Draw_tPixMap *outputPmx);
void Track_AssociateSingleMaterial(Trk_Material *inputMat,Track_tMaterial *outputMat,Track_tArtresource *art);
void Track_LinkMaterials(SerializedGroup *group,int length,Track_tMaterial *matList);
void ReduceObjectPrecision(Group *instGroup,Group *defGroup,int bits);
void InvalidatePersistentCollideBoomObjects(Group *instGroup,Group *defGroup);
void CalcObjectBoundingSphere(Group *defGroup,Group *boundingSphereGroup);
void CalcObjDefPtrs(void);
void Track_InitPersistentData(SerializedGroup *perGroup);
void Track_Init(char *tempName);
void Track_DeInit(void);
void Track_AnimateTrackLighting(void);
char * KillFile_OpenRead(void);
void KillFile_ReadEntry(char *filePtr,int entryInd,int *chunkInd,int *objectInd);
void Track_LoadObjectKillData(void);
void Save(SaveSurface *pThis,Trk_NewSimQuad *simQuad);
void RestoreAll(SaveSurface *pThis);


/* ---- Track_SetTrackNumber__Fi  [TRACK.CPP:95-96] SLD-VERIFIED ---- */
void Track_SetTrackNumber(int tracknum)

{
  gtrackNumber = tracknum & 0xf;
  return;
}

/* ---- Track_MakeTrackPathName__FPc  [TRACK.CPP:103-110] SLD-VERIFIED ---- */
char * Track_MakeTrackPathName(char *ext)

{
  static char strspc[64];   /* @0x8013e300 STAT (.bss) */
  sprintf(strspc,"%sTr%02d%s",Paths_Paths[6],gtrackNumber,ext);
  return strspc;
}

/* ---- Track_MakeTrackDataPathName__FPc  [TRACK.CPP:114-121] SLD-VERIFIED ---- */
char * Track_MakeTrackDataPathName(char *ext)

{
  static char strspc[64];   /* @0x8013e340 STAT (.bss) */
  sprintf(strspc,"%sTr%02d%s",Paths_Paths[8],gtrackNumber,ext);
  return strspc;
}

/* ---- AllocArtResource__FP18Track_tArtresourcei  [TRACK.CPP:142-151] SLD-VERIFIED ---- */
void AllocArtResource(Track_tArtresource *artRes,int numPmx)

{
  Draw_tPixMap *pDVar1;
  
  artRes->id = -1;
  artRes->basePmxCount = 0;
  pDVar1 = (Draw_tPixMap *)BWAllocMem(numPmx << 4);
  artRes->pPmx = pDVar1;
  artRes->shapeCount = 0;
  artRes->shapeFile = (char *)0x0;
  return;
}

/* ---- InitArtResources__Fv  [TRACK.CPP:155-165] SLD-VERIFIED ---- */
void InitArtResources(void)

{
  AllocArtResource(&gInitialArt,0x352);
  Track_materials = (Track_tMaterial *)BWAllocMem(0xd48);
  return;
}

/* ---- DeInitArtResources__Fv  [TRACK.CPP:176-192] SLD-VERIFIED ---- */
void DeInitArtResources(void)

{
  gInitialArt.pPmx = (Draw_tPixMap *)0x0;
  Chunk_DeInit();
  return;
}

/* ---- LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii  [TRACK.CPP:225-359] SLD-VERIFIED ---- */
void LoadShapesAndMakePmx(char *shapefile,Draw_tPixMap *pmxList,int loadFlags,int x,int y)

{
  int palnum;
  Track_MultiPalette *pTVar1;
  void *pvVar2;
  u_char *n;
  int pcnt;
  int iVar3;
  Track_MipMap *pTVar4;
  int cnt;
  int iVar5;
  Track_MultiPalette *pTVar6;
  int j;
  int tempclut;
  int iVar7;
  int i;
  shapetbl *shape;
  int mipmapcounter;
  int iVar8;
  Draw_tPixMap *pPmx;
  int cluttype;
  int iVar9;
  int recolor_flag;
  char name [4];
  short icode [2];
  
  iVar9 = -1;
  gTempMipMapInfo = (Track_MipMap *)0x0;
  if (TrackSpec_gSpec.fogstate != 0) {
    iVar9 = -3;
    gTempMipMapInfo = reservememadr("mipmapinf",0x180,0x10);
    iVar5 = 0;
    iVar3 = 0;
    do {
      iVar5 = iVar5 + 1;
      *(u_int *)((int)gTempMipMapInfo->code + iVar3) = 0xffffffff;
      iVar3 = iVar3 + 0xc;
    } while (iVar5 < 0x20);
  }
  gTempMultiPalInfo = reservememadr("mpalinfo",0x400,0x10);
  iVar3 = 0x7f;
  pTVar1 = gTempMultiPalInfo + 0x7f;
  do {
    pTVar1->palnum = -1;
    iVar3 = iVar3 + -1;
    pTVar1 = pTVar1 + -1;
  } while (-1 < iVar3);
  DrawSync(0);
  iVar8 = 0;
  iVar3 = 0;
  iVar5 = 0;
  do {
    pvVar2 = shapecount(shapefile);
    if ((int)pvVar2 <= iVar3) {
      return;
    }
    n = shapepointer(shapefile,iVar3);
    if (n != (u_char *)0x0) {
      shapename(shapefile,iVar3,name);
      if (((iVar3 < 0xc) || ((*n & 3) == 1)) || (iVar7 = iVar9, name[0] == '#')) {
        iVar7 = -1;
      }
      Texture_LoadPmx((char *)0x0,(char *)n,loadFlags | 2,x,y,iVar7,iVar7,pmxList);
      if (name[0] == '!') {
        gTempMultiPalInfo->charcode[iVar5] = name[1];
        gTempMultiPalInfo->charcode[iVar5 + 1] = name[2];
        iVar7 = atoi(name + 3);
        pTVar1 = gTempMultiPalInfo;
        *(short *)(gTempMultiPalInfo->charcode + iVar5 + 2) = (short)iVar7;
        *(short *)(pTVar1->charcode + iVar5 + 6) = (short)iVar3;
        if (iVar7 == 0) {
          *(short *)(pTVar1->charcode + iVar5 + 4) = (short)iVar3;
        }
        else {
          iVar7 = 0;
          pTVar6 = pTVar1;
          do {
            if (((pTVar6->charcode[0] == name[1]) && (pTVar6->charcode[1] == name[2])) &&
               (pTVar6->palnum == 0)) {
              *(short *)(pTVar1->charcode + iVar5 + 4) = pTVar6->origshapeindex;
              break;
            }
            iVar7 = iVar7 + 1;
            pTVar6 = pTVar6 + 1;
          } while (iVar7 < 0x80);
        }
        iVar5 = iVar5 + 8;
      }
      if ((TrackSpec_gSpec.fogstate != 0) && (name[0] == 'Z')) {
        if ((name[1] == 'R') && ((*n & 3) == 1)) {
          pTVar4 = gTempMipMapInfo + iVar8;
          pTVar4->code[0] = (u_short)(u_char)name[2];
          iVar8 = iVar8 + 1;
          pTVar4->shapeParentIndex = iVar3;
          pTVar4->mipMapIndex = iVar3;
          pTVar4->code[1] = (u_short)(u_char)name[3];
        }
        else {
          iVar7 = 0;
          pTVar4 = gTempMipMapInfo;
          if (name[1] == 'Z') {
            do {
              if (((u_short)(u_char)name[2] == pTVar4->code[0]) &&
                 ((u_short)(u_char)name[3] == pTVar4->code[1])) {
                pTVar4->mipMapIndex = iVar3;
                break;
              }
              iVar7 = iVar7 + 1;
              pTVar4 = pTVar4 + 1;
            } while (iVar7 < 0x20);
          }
        }
      }
      pmxList = pmxList + 1;
    }
    iVar3 = iVar3 + 1;
  } while( true );
}

/* ---- LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii  [TRACK.CPP:375-394] SLD-VERIFIED ---- */
void LoadShapesAndMakePmx_EnvMap(char *shapefile,Draw_tPixMap *pmxList,int x,int y)

{
  shapetbl *shape;
  void *pvVar1;
  char *n;
  int i;
  int idx;
  Draw_tPixMap *pPmx;
  int recolor_flag;
  
  for (idx = 0; pvVar1 = shapecount(shapefile), idx < (int)pvVar1;
      idx = idx + 1) {
    n = shapepointer(shapefile,idx);
    if (n != (char *)0x0) {
      Texture_LoadPmx((char *)0x0,n,0x42,x,y,-1,-1,pmxList)
      ;
      pmxList = pmxList + 1;
    }
  }
  return;
}

/* ---- TexturesLoadInitial__Fv  [TRACK.CPP:405-465] SLD-VERIFIED ---- */
void TexturesLoadInitial(void)

{
  u_int *puVar1;
  u_char *puVar2;
  int success;
  int shape_path;
  Draw_tPixMap *pDVar3;
  char *pcVar4;
  int track_path;
  int reg_t0;
  u_int uVar5;
  int reg_t1;
  u_int uVar6;
  int reg_t2;
  u_int uVar7;
  int reg_t3;
  char *tmpShapes;
  int tu3;
  int tu4;
  void *tp1;
  void *tp3;
  int tu5;
  u_int tu6;
  int tp2;
  u_char *tp4;
  u_int tu7;
  u_int tu8;
  
  if (GameSetup_gData.Time == 0) {
    if (GameSetup_gData.Weather == 0) {
      track_path = (int)"0.psh";
    }
    else {
      track_path = (int)"W0.psh";
    }
  }
  else if (GameSetup_gData.Weather == 0) {
    track_path = (int)"N0.psh";
  }
  else {
    track_path = (int)wordFile_psh_snow;
  }
  shape_path = (int)Track_MakeTrackPathName((char *)track_path);
  gInitialArt.shapeFile =
       (char *)loadshapeadr((char *)shape_path,(void *)0x0);
  if (gInitialArt.shapeFile != (char *)0x0) {
    Texture_ResetPaletteSharing();
    gInitialArt.shapeCount = (int)shapecount(gInitialArt.shapeFile);
    LoadShapesAndMakePmx(gInitialArt.shapeFile,gInitialArt.pPmx,0x40,0x100,0);
    pDVar3 = gInitialArt.pPmx + gInitialArt.shapeCount;
    tp1 = (void *)((int)&gSpikeBeltPixmap->clut + 1);
    tu3 = (u_int)tp1 & 3;
    tu4 = (u_int)gSpikeBeltPixmap & 3;
    uVar5 = (*(int *)((int)tp1 - tu3) << (3 - tu3) * 8 | reg_t0 & 0xffffffffU >> (tu3 + 1) * 8) &
            -1 << (4 - tu4) * 8 | *(u_int *)((int)&gSpikeBeltPixmap - tu4) >> tu4 * 8;
    tp2 = (int)&gSpikeBeltPixmap->tpage + 1;
    tu5 = tp2 & 3;
    tu6 = (u_int)&gSpikeBeltPixmap->u1 & 3;
    uVar6 = (*(int *)(tp2 - tu5) << (3 - tu5) * 8 | reg_t1 & 0xffffffffU >> (tu5 + 1) * 8) &
            -1 << (4 - tu6) * 8 | *(u_int *)(&gSpikeBeltPixmap->u1 + -tu6) >> tu6 * 8;
    tp3 = (void *)((int)&gSpikeBeltPixmap->pad2 + 1);
    tu7 = (u_int)tp3 & 3;
    tu8 = (u_int)&gSpikeBeltPixmap->u2 & 3;
    uVar7 = (*(int *)((int)tp3 - tu7) << (3 - tu7) * 8 | reg_t2 & 0xffffffffU >> (tu7 + 1) * 8) &
            -1 << (4 - tu8) * 8 | *(u_int *)(&gSpikeBeltPixmap->u2 + -tu8) >> tu8 * 8;
    tp4 = (u_char *)((int)&gSpikeBeltPixmap->flag + 1);
    tu7 = (u_int)tp4 & 3;
    tu8 = (u_int)&gSpikeBeltPixmap->u3 & 3;
    tu8 = (*(int *)(tp4 + -tu7) << (3 - tu7) * 8 | reg_t3 & 0xffffffffU >> (tu7 + 1) * 8) &
          -1 << (4 - tu8) * 8 | *(u_int *)(&gSpikeBeltPixmap->u3 + -tu8) >> tu8 * 8;
    tp4 = (u_char *)((int)&pDVar3->clut + 1);
    tu7 = (u_int)tp4 & 3;
    puVar1 = (u_int *)(tp4 + -tu7);
    *puVar1 = *puVar1 & -1 << (tu7 + 1) * 8 | uVar5 >> (3 - tu7) * 8;
    tu7 = (u_int)pDVar3 & 3;
    *(u_int *)((int)pDVar3 - tu7) =
         *(u_int *)((int)pDVar3 - tu7) & 0xffffffffU >> (4 - tu7) * 8 | uVar5 << tu7 * 8;
    tp4 = (u_char *)((int)&pDVar3->tpage + 1);
    tu7 = (u_int)tp4 & 3;
    puVar1 = (u_int *)(tp4 + -tu7);
    *puVar1 = *puVar1 & -1 << (tu7 + 1) * 8 | uVar6 >> (3 - tu7) * 8;
    tu7 = (u_int)&pDVar3->u1 & 3;
    puVar2 = &pDVar3->u1 + -tu7;
    *(u_int *)puVar2 = *(u_int *)puVar2 & 0xffffffffU >> (4 - tu7) * 8 | uVar6 << tu7 * 8;
    tp4 = (u_char *)((int)&pDVar3->pad2 + 1);
    tu7 = (u_int)tp4 & 3;
    puVar1 = (u_int *)(tp4 + -tu7);
    *puVar1 = *puVar1 & -1 << (tu7 + 1) * 8 | uVar7 >> (3 - tu7) * 8;
    tu7 = (u_int)&pDVar3->u2 & 3;
    puVar2 = &pDVar3->u2 + -tu7;
    *(u_int *)puVar2 = *(u_int *)puVar2 & 0xffffffffU >> (4 - tu7) * 8 | uVar7 << tu7 * 8;
    tp4 = (u_char *)((int)&pDVar3->flag + 1);
    tu7 = (u_int)tp4 & 3;
    puVar1 = (u_int *)(tp4 + -tu7);
    *puVar1 = *puVar1 & -1 << (tu7 + 1) * 8 | tu8 >> (3 - tu7) * 8;
    tu7 = (u_int)&pDVar3->u3 & 3;
    puVar2 = &pDVar3->u3 + -tu7;
    *(u_int *)puVar2 = *(u_int *)puVar2 & 0xffffffffU >> (4 - tu7) * 8 | tu8 << tu7 * 8;
    gInitialArt.shapeCount = gInitialArt.shapeCount + 1;
    gInitialArt.pmxCount = gInitialArt.shapeCount;
    gInitialArt.basePmxCount = gInitialArt.shapeCount;
    purgememadr(gInitialArt.shapeFile);
    Hrz_GetHorizonPixMap(gInitialArt.pPmx);
    pcVar4 = Track_MakeTrackPathName("r.psh");
    pcVar4 = (char *)loadshapeadr(pcVar4,(void *)0x0);
    if (pcVar4 != (char *)0x0) {
      Texture_ResetPaletteSharing();
      LoadShapesAndMakePmx_EnvMap(pcVar4,Track_gReflectionMaps,0x3e0,0);
      purgememadr(pcVar4);
    }
    return;
  }
  do {
                    /* WARNING: Do nothing block with infinite loop */
  } while( true );
}

/* ---- Track_AnimateTextures__Fv  [TRACK.CPP:491-517] SLD-VERIFIED ---- */
void Track_AnimateTextures(void)

{
  short sVar1;
  char cVar2;
  Draw_tPixMap *pDVar3;
  u_int uVar4;
  u_int uVar5;
  Draw_tPixMap *pmx;
  short *psVar6;
  Track_tMaterialController *controlPtr;
  Track_tMaterialController *pTVar7;
  int controlCount;
  int iVar8;
  
  psVar6 = &Track_gMatController->pmxIndex;
  pTVar7 = Track_gMatController;
  iVar8 = Track_gControllerCount;
  while (pDVar3 = gInitialArt.pPmx, iVar8 = iVar8 + -1, iVar8 != -1) {
    if (pTVar7->type == 0x80) {
      uVar4 = (u_int)*(u_char *)((int)psVar6 + -1);
      if (uVar4 == 0) {
        trap(0x1c00);
      }
      if ((uVar4 == 0xffffffff) && (simGlobal.gameTicks == -0x80000000)) {
        trap(0x1800);
      }
      uVar5 = (u_int)*(u_char *)(psVar6 + -4);
      if (uVar5 == 0) {
        trap(0x1c00);
      }
      if ((uVar5 == 0xffffffff) && (simGlobal.gameTicks / (int)uVar4 == -0x80000000)) {
        trap(0x1800);
      }
      sVar1 = (*(Track_tMaterial **)(psVar6 + 1))->pmxIndex;
      cVar2 = (char)((simGlobal.gameTicks / (int)uVar4) % (int)uVar5);
      gInitialArt.pPmx[sVar1].v0 = *(u_char *)(psVar6 + -3) + cVar2;
      pDVar3[sVar1].v1 = *(u_char *)((int)psVar6 + -5) + cVar2;
      pDVar3[sVar1].v2 = *(u_char *)(psVar6 + -2) + cVar2;
      pDVar3[sVar1].v3 = *(u_char *)((int)psVar6 + -3) + cVar2;
    }
    else if (pTVar7->type == 4) {
      uVar4 = (u_int)*(u_char *)((int)psVar6 + -1);
      if (uVar4 == 0) {
        trap(0x1c00);
      }
      if ((uVar4 == 0xffffffff) && (simGlobal.gameTicks == -0x80000000)) {
        trap(0x1800);
      }
      uVar5 = (u_int)*(u_char *)(psVar6 + -1);
      if (uVar5 == 0) {
        trap(0x1c00);
      }
      if ((uVar5 == 0xffffffff) && (simGlobal.gameTicks / (int)uVar4 == -0x80000000)) {
        trap(0x1800);
      }
      (*(Track_tMaterial **)(psVar6 + 1))->pmxIndex =
           *psVar6 + (short)((simGlobal.gameTicks / (int)uVar4) % (int)uVar5);
    }
    psVar6 = psVar6 + 8;
    pTVar7 = pTVar7 + 1;
  }
  return;
}

/* ---- Track_GetProperMultiPalShapeIndex__Fii  [TRACK.CPP:525-532] SLD-VERIFIED ---- */
int Track_GetProperMultiPalShapeIndex(int shapeindex,int paletteindex)

{
  Track_MultiPalette *pTVar1;
  int iVar2;
  int t;
  
  iVar2 = 0;
  pTVar1 = gTempMultiPalInfo;
  while ((pTVar1->origshapeindex != shapeindex || (pTVar1->palnum != paletteindex))) {
    iVar2 = iVar2 + 1;
    pTVar1 = pTVar1 + 1;
    if (0x7f < iVar2) {
      return shapeindex;
    }
  }
  return (int)pTVar1->actualshapeindex;
}

/* ---- Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1  [TRACK.CPP:538-571] SLD-VERIFIED ---- */
void Track_ProcessFlipAndUVFlags(int uvFlag,Draw_tPixMap *inputPmx,Draw_tPixMap *outputPmx)

{
  int pmxProcessCount;
  Draw_tPixMap *pDVar1;
  int rotMode;
  int mode;
  int reg_a3;
  int u0_pack;
  int reg_t0;
  int u1_pack;
  int reg_t1;
  int v0_pack;
  int reg_t2;
  int v1_pack;
  int pmxCount;
  int result_pmx_p;
  Draw_tPixMap newPmx [4];
  int pbVar3;
  u_char bVar4;
  int tp2;
  int tp6;
  int tp5;
  int tp15;
  int tp16;
  int pbVar4;
  int tu5;
  void *tp3;
  int tu8;
  int tu14;
  int tu6;
  int tu7;
  void *tp1;
  u_char *pbVar5;
  u_int *tp17;
  u_char *tp19;
  u_int tu15;
  u_int tu16;
  u_int tu18;
  
  tp2 = (int)&inputPmx->clut + 1;
  tu5 = tp2 & 3;
  tu6 = (u_int)inputPmx & 3;
  u0_pack = (*(int *)(tp2 - tu5) << (3 - tu5) * 8 | reg_a3 & 0xffffffffU >> (tu5 + 1) * 8) &
            -1 << (4 - tu6) * 8 | *(u_int *)((int)inputPmx - tu6) >> tu6 * 8;
  tp3 = (void *)((int)&inputPmx->tpage + 1);
  tu15 = (u_int)tp3 & 3;
  tu16 = (u_int)&inputPmx->u1 & 3;
  u1_pack = (*(int *)((int)tp3 - tu15) << (3 - tu15) * 8 | reg_t0 & 0xffffffffU >> (tu15 + 1) * 8) &
            -1 << (4 - tu16) * 8 | *(u_int *)(&inputPmx->u1 + -tu16) >> tu16 * 8;
  pbVar5 = (u_char *)((int)&inputPmx->pad2 + 1);
  tu15 = (u_int)pbVar5 & 3;
  tu16 = (u_int)&inputPmx->u2 & 3;
  v0_pack = (*(int *)(pbVar5 + -tu15) << (3 - tu15) * 8 | reg_t1 & 0xffffffffU >> (tu15 + 1) * 8) &
            -1 << (4 - tu16) * 8 | *(u_int *)(&inputPmx->u2 + -tu16) >> tu16 * 8;
  pbVar5 = (u_char *)((int)&inputPmx->flag + 1);
  tu15 = (u_int)pbVar5 & 3;
  tu16 = (u_int)&inputPmx->u3 & 3;
  v1_pack = (*(int *)(pbVar5 + -tu15) << (3 - tu15) * 8 | reg_t2 & 0xffffffffU >> (tu15 + 1) * 8) &
            -1 << (4 - tu16) * 8 | *(u_int *)(&inputPmx->u3 + -tu16) >> tu16 * 8;
  tp1 = (void *)((int)&newPmx[0].clut + 1);
  tu15 = (u_int)tp1 & 3;
  *(u_int *)((int)tp1 - tu15) =
       *(u_int *)((int)tp1 - tu15) & -1 << (tu15 + 1) * 8 | (u_int)u0_pack >> (3 - tu15) * 8;
  newPmx[0].u0 = (char)u0_pack;
  newPmx[0].v0 = (char)((u_int)u0_pack >> 8);
  newPmx[0].clut = (short)((u_int)u0_pack >> 0x10);
  pbVar3 = (int)&newPmx[0].tpage + 1;
  tu15 = pbVar3 & 3;
  *(u_int *)(pbVar3 - tu15) =
       *(u_int *)(pbVar3 - tu15) & -1 << (tu15 + 1) * 8 | (u_int)u1_pack >> (3 - tu15) * 8;
  newPmx[0].u1 = (char)u1_pack;
  newPmx[0].v1 = (char)((u_int)u1_pack >> 8);
  newPmx[0].tpage = (short)((u_int)u1_pack >> 0x10);
  pbVar4 = (int)&newPmx[0].pad2 + 1;
  tu15 = pbVar4 & 3;
  *(u_int *)(pbVar4 - tu15) =
       *(u_int *)(pbVar4 - tu15) & -1 << (tu15 + 1) * 8 | (u_int)v0_pack >> (3 - tu15) * 8;
  newPmx[0].u2 = (char)v0_pack;
  newPmx[0].v2 = (char)((u_int)v0_pack >> 8);
  newPmx[0].pad2 = (short)((u_int)v0_pack >> 0x10);
  pbVar5 = (u_char *)((int)&newPmx[0].flag + 1);
  tu15 = (u_int)pbVar5 & 3;
  tp17 = (u_int *)(pbVar5 + -tu15);
  *tp17 = *tp17 & -1 << (tu15 + 1) * 8 | (u_int)v1_pack >> (3 - tu15) * 8;
  newPmx[0].u3 = (char)v1_pack;
  newPmx[0].v3 = (char)((u_int)v1_pack >> 8);
  newPmx[0].flag = (short)((u_int)v1_pack >> 0x10);
  bVar4 = (uvFlag & 0x10U) != 0;
  if ((bool)bVar4) {
    Texture_CloneUVPmx(newPmx,0,newPmx + 1);
  }
  result_pmx_p = (int)bVar4;
  if ((uvFlag & 0x40U) != 0) {
    Texture_CloneUVPmx(newPmx + result_pmx_p,1,newPmx + result_pmx_p + 1);
    result_pmx_p = result_pmx_p + 1;
  }
  if ((uvFlag & 0xeU) == 0) goto TrkProcessFlip_nextPmx;
  if ((uvFlag & 2U) == 0) {
    if ((uvFlag & 4U) != 0) {
      mode = 3;
      goto TrkProcessFlip_emitCloneUV;
    }
    mode = 4;
    if ((uvFlag & 8U) != 0) goto TrkProcessFlip_emitCloneUV;
  }
  else {
    mode = 2;
TrkProcessFlip_emitCloneUV:
    Texture_CloneUVPmx(newPmx + result_pmx_p,mode,newPmx + result_pmx_p + 1);
  }
  result_pmx_p = result_pmx_p + 1;
TrkProcessFlip_nextPmx:
  pDVar1 = newPmx + result_pmx_p;
  ((u_char *)&(tu15))[0] = pDVar1->u0;
  ((u_char *)&(tu15))[1] = pDVar1->v0;
  (*(u_short *)((u_char *)&(tu15) + 2)) = pDVar1->clut;
  pDVar1 = newPmx + result_pmx_p;
  ((u_char *)&(tu16))[0] = pDVar1->u1;
  ((u_char *)&(tu16))[1] = pDVar1->v1;
  (*(u_short *)((u_char *)&(tu16) + 2)) = pDVar1->tpage;
  pDVar1 = newPmx + result_pmx_p;
  ((u_char *)&(tu7))[0] = pDVar1->u2;
  ((u_char *)&(tu7))[1] = pDVar1->v2;
  (*(u_short *)((u_char *)&(tu7) + 2)) = pDVar1->pad2;
  pDVar1 = newPmx + result_pmx_p;
  ((u_char *)&(tu8))[0] = pDVar1->u3;
  ((u_char *)&(tu8))[1] = pDVar1->v3;
  (*(u_short *)((u_char *)&(tu8) + 2)) = pDVar1->flag;
  pbVar5 = (u_char *)((int)&outputPmx->clut + 1);
  tu14 = (u_int)pbVar5 & 3;
  tp5 = (int)pbVar5 - tu14;
  *(u_int *)tp5 = *(u_int *)tp5 & -1 << (tu14 + 1) * 8 | tu15 >> (3 - tu14) * 8;
  tu18 = (u_int)outputPmx & 3;
  *(u_int *)((int)outputPmx - tu18) =
       *(u_int *)((int)outputPmx - tu18) & 0xffffffffU >> (4 - tu18) * 8 | tu15 << tu18 * 8;
  pbVar5 = (u_char *)((int)&outputPmx->tpage + 1);
  tu15 = (u_int)pbVar5 & 3;
  tp15 = (int)pbVar5 - tu15;
  *(u_int *)tp15 = *(u_int *)tp15 & -1 << (tu15 + 1) * 8 | tu16 >> (3 - tu15) * 8;
  tu15 = (u_int)&outputPmx->u1 & 3;
  tp6 = (int)&outputPmx->u1 - tu15;
  *(u_int *)tp6 = *(u_int *)tp6 & 0xffffffffU >> (4 - tu15) * 8 | tu16 << tu15 * 8;
  pbVar5 = (u_char *)((int)&outputPmx->pad2 + 1);
  tu15 = (u_int)pbVar5 & 3;
  tp17 = (u_int *)(pbVar5 + -tu15);
  *tp17 = *tp17 & -1 << (tu15 + 1) * 8 | (u_int)tu7 >> (3 - tu15) * 8;
  tu15 = (u_int)&outputPmx->u2 & 3;
  tp16 = (int)&outputPmx->u2 - tu15;
  *(u_int *)tp16 = *(u_int *)tp16 & 0xffffffffU >> (4 - tu15) * 8 | tu7 << tu15 * 8;
  pbVar5 = (u_char *)((int)&outputPmx->flag + 1);
  tu15 = (u_int)pbVar5 & 3;
  tp17 = (u_int *)(pbVar5 + -tu15);
  *tp17 = *tp17 & -1 << (tu15 + 1) * 8 | (u_int)tu8 >> (3 - tu15) * 8;
  tu15 = (u_int)&outputPmx->u3 & 3;
  tp19 = &outputPmx->u3 + -tu15;
  *(u_int *)tp19 = *(u_int *)tp19 & 0xffffffffU >> (4 - tu15) * 8 | tu8 << tu15 * 8;
  return;
}

/* ---- Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource  [TRACK.CPP:577-626] SLD-VERIFIED ---- */
/* void 
   Track_AssociateSingleMaterial(Trk_Material
   * inputMat, Track_tMaterial * outputMat, Track_tArtresource * art)
   
   Track-system helper (track).
   
   Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.
   
   Provenance:
     VA=0x800B9D2C block=CODE size=364B
     Direct callers: 1
     SLD source: nfs4/GAME/COMMON/TRACK.CPP:577
     SYM data: 3 regparms / 0 args / 1 autos
     Sample callers: Track_LinkMaterials
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.
   Build date: 1999-02-22.
   See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Locals 2026-05-09] Locals renamed via deep-body inspection. Track_AssociateSingleMaterial - bind
   one Trk_Material to its Track_tMaterial entry + Track_tArtresource (364B). Walks the inputMat's
   animFrame[] entries (animCount loop, anim_iter index): for each anim frame, resolves shapeIndex
   via art lookup → shapeData_p (Draw_tPixMap from the art atlas); applies uvFlag via
   Track_ProcessFlipAndUVFlags into outputMat's per-frame pixmap slot. originalPmx (16B local)
   preserves the unflipped reference pixmap for rollback. Used during scene/track init to bake
   material bindings + UV permutation flags so render time has zero conditional branches per
   material.
   
   [Locals 2026-05-10 bulk] Bulk-renamed Ghidra SSA temps to type-hinted user-names (ti=int,
   tu=u_int, ts=short, tb=u_char, tstr=char*, tp=void*, etc.) for audit cleanliness. Generic but
   preserves type info; these are minor secondary-effect register temps that did not warrant
   individual semantic naming. */

void Track_AssociateSingleMaterial(Trk_Material *inputMat,Track_tMaterial *outputMat,Track_tArtresource *art)

{
  u_char *puVar1;
  u_int uVar2;
  u_int uVar3;
  u_int *puVar4;
  short uvFlag;
  int shapeData_p;
  int shapeIndex;
  int pmxW0;
  int pmxW1;
  int pmxW2;
  int pmxW3;
  int animCount;
  int anim_iter;
  Draw_tPixMap originalPmx;
  int tp2;
  int tu3;
  void *tp1;
  int tu4;
  int tp5;
  int iVar5;
  
  outputMat->flag = inputMat->flag;
  for (anim_iter = 0; (anim_iter < 1 || (anim_iter < (int)(u_int)(u_char)inputMat->textureCount));
      anim_iter = anim_iter + 1) {
    if ((inputMat->uvFlag & 0x5e) == 0) {
      uvFlag = inputMat->shapeIndex;
      if ((inputMat->flag & 2) != 0) {
        iVar5 = Track_GetProperMultiPalShapeIndex((int)uvFlag,(u_int)inputMat->interval);
        uvFlag = (short)iVar5;
      }
      if (anim_iter == 0) {
        outputMat->pmxIndex = uvFlag;
      }
    }
    else {
      shapeIndex = (int)inputMat->shapeIndex;
      if ((inputMat->flag & 2) != 0) {
        shapeIndex = Track_GetProperMultiPalShapeIndex(shapeIndex,(u_int)inputMat->interval);
      }
      shapeData_p = (int)(art->pPmx + shapeIndex + anim_iter);
      tp1 = (void *)(shapeData_p + 3);
      tu3 = (u_int)tp1 & 3;
      tu4 = shapeData_p & 3;
      pmxW0 = (*(int *)((int)tp1 - tu3) << (3 - tu3) * 8 | pmxW0 & 0xffffffffU >> (tu3 + 1) * 8) &
              -1 << (4 - tu4) * 8 | *(u_int *)(shapeData_p - tu4) >> tu4 * 8;
      tp2 = shapeData_p + 7;
      uVar2 = tp2 & 3;
      uVar3 = shapeData_p + 4U & 3;
      pmxW1 = (*(int *)(tp2 - uVar2) << (3 - uVar2) * 8 | pmxW1 & 0xffffffffU >> (uVar2 + 1) * 8) &
              -1 << (4 - uVar3) * 8 | *(u_int *)((shapeData_p + 4U) - uVar3) >> uVar3 * 8;
      uVar2 = shapeData_p + 0xbU & 3;
      uVar3 = shapeData_p + 8U & 3;
      pmxW2 = (*(int *)((shapeData_p + 0xbU) - uVar2) << (3 - uVar2) * 8 |
              pmxW2 & 0xffffffffU >> (uVar2 + 1) * 8) & -1 << (4 - uVar3) * 8 |
              *(u_int *)((shapeData_p + 8U) - uVar3) >> uVar3 * 8;
      uVar2 = shapeData_p + 0xfU & 3;
      uVar3 = shapeData_p + 0xcU & 3;
      pmxW3 = (*(int *)((shapeData_p + 0xfU) - uVar2) << (3 - uVar2) * 8 |
              pmxW3 & 0xffffffffU >> (uVar2 + 1) * 8) & -1 << (4 - uVar3) * 8 |
              *(u_int *)((shapeData_p + 0xcU) - uVar3) >> uVar3 * 8;
      puVar1 = (u_char *)((int)&originalPmx.clut + 1);
      uVar2 = (u_int)puVar1 & 3;
      tp5 = (int)puVar1 - uVar2;
      *(u_int *)tp5 = *(u_int *)tp5 & -1 << (uVar2 + 1) * 8 | (u_int)pmxW0 >> (3 - uVar2) * 8;
      puVar1 = (u_char *)((int)&originalPmx.tpage + 1);
      uVar2 = (u_int)puVar1 & 3;
      puVar4 = (u_int *)(puVar1 + -uVar2);
      *puVar4 = *puVar4 & -1 << (uVar2 + 1) * 8 | (u_int)pmxW1 >> (3 - uVar2) * 8;
      originalPmx.u1 = (char)pmxW1;
      originalPmx.v1 = (char)((u_int)pmxW1 >> 8);
      originalPmx.tpage = (short)((u_int)pmxW1 >> 0x10);
      puVar1 = (u_char *)((int)&originalPmx.pad2 + 1);
      uVar2 = (u_int)puVar1 & 3;
      puVar4 = (u_int *)(puVar1 + -uVar2);
      *puVar4 = *puVar4 & -1 << (uVar2 + 1) * 8 | (u_int)pmxW2 >> (3 - uVar2) * 8;
      originalPmx.u2 = (char)pmxW2;
      originalPmx.v2 = (char)((u_int)pmxW2 >> 8);
      originalPmx.pad2 = (short)((u_int)pmxW2 >> 0x10);
      puVar1 = (u_char *)((int)&originalPmx.flag + 1);
      uVar2 = (u_int)puVar1 & 3;
      puVar4 = (u_int *)(puVar1 + -uVar2);
      *puVar4 = *puVar4 & -1 << (uVar2 + 1) * 8 | (u_int)pmxW3 >> (3 - uVar2) * 8;
      (*(int *)&(originalPmx)) = pmxW0;
      (*(int *)((u_char *)&(originalPmx) + 12)) = pmxW3;
      Track_ProcessFlipAndUVFlags((u_int)inputMat->uvFlag,&originalPmx,art->pPmx + art->pmxCount);
      if (anim_iter == 0) {
        outputMat->pmxIndex = (short)art->pmxCount;
      }
      art->pmxCount = art->pmxCount + 1;
    }
  }
  return;
}

/* ---- Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial  [TRACK.CPP:688-848] SLD-VERIFIED ---- */
void Track_LinkMaterials(SerializedGroup *group,int length,Track_tMaterial *matList)

{
  Draw_tPixMap * pmx;
  u_char *puVar1;
  u_char bVar2;
  short sVar3;
  u_int uVar4;
  u_int uVar5;
  u_int *puVar6;
  int d;
  Track_tMaterialController *pTVar7;
  Draw_tPixMap *pDVar8;
  int mipmap_offset;
  SerializedGroup *pSVar9;
  int iVar10;
  SerializedGroup *pThis;
  int *piVar11;
  int iVar12;
  int shapeIndex;
  int iVar13;
  u_int uVar14;
  u_int uVar15;
  u_int pmxLnkW2;
  u_int uVar16;
  u_int pmxLnkW0;
  Trk_Material *mats;
  SerializedGroup *inputMat;
  int iVar17;
  int mm;
  int i;
  int iVar18;
  int iVar19;
  int controlIndex;
  int iVar20;
  Draw_tPixMap originalPmx;
  int matCount;
  
  if (group != (SerializedGroup *)0x0) {
    iVar18 = 0;
    inputMat = group + 1;
    Track_gControllerCount = 0;
    gInitialArt.pmxCount = gInitialArt.basePmxCount;
    uVar14 = (u_int)length / 10;
    pSVar9 = inputMat;
    if (uVar14 != 0) {
      do {
        if ((pSVar9->m_type & 0x840000) != 0) {
          Track_gControllerCount = Track_gControllerCount + 1;
        }
        iVar18 = iVar18 + 1;
        pSVar9 = (SerializedGroup *)((int)&pSVar9->dummy + 2);
        pmxLnkW2 = uVar14;
      } while (iVar18 < (int)uVar14);
    }
    uVar15 = uVar14;
    if (Track_gControllerCount != 0) {
      Track_gMatController =
           (Track_tMaterialController *)BWAllocMem(Track_gControllerCount << 4);
    }
    iVar19 = 0;
    iVar18 = iVar19;
    for (; iVar19 < (int)uVar14; iVar19 = iVar19 + 1) {
      uVar16 = uVar14;
      Track_AssociateSingleMaterial((Trk_Material *)inputMat,matList,&gInitialArt);
      bVar2 = *(u_char *)((int)&inputMat->m_type + 2);
      if ((bVar2 & 4) == 0) {
        iVar20 = iVar18;
        if ((bVar2 & 0x80) != 0) {
          Track_gMatController[iVar18].type = (u_short)*(u_char *)((int)&inputMat->m_type + 2);
          if ((char)inputMat->dummy == '\0') {
            *(u_char *)&inputMat->dummy = 1;
          }
          Track_gMatController[iVar18].interval = (u_char)inputMat->dummy;
          Track_gMatController[iVar18].textureCount = *(char *)((int)&inputMat->m_length + 3);
          pTVar7 = Track_gMatController;
          Track_gMatController[iVar18].pmxIndex = matList->pmxIndex;
          pTVar7[iVar18].matPtr = matList;
          pDVar8 = gInitialArt.pPmx;
          sVar3 = matList->pmxIndex;
          pTVar7[iVar18].uv0 = gInitialArt.pPmx[sVar3].v0;
          Track_gMatController[iVar18].uv1 = pDVar8[sVar3].v1;
          Track_gMatController[iVar18].uv2 = pDVar8[sVar3].v2;
          Track_gMatController[iVar18].uv3 = pDVar8[sVar3].v3;
          iVar17 = (u_int)pDVar8[sVar3].v3 - (u_int)pDVar8[sVar3].v0;
          if (iVar17 < 0) {
            iVar17 = -iVar17;
          }
          iVar20 = iVar18 + 1;
          Track_gMatController[iVar18].textureMax = (char)iVar17 + '\x01';
        }
      }
      else {
        pTVar7 = Track_gMatController + iVar18;
        pTVar7->type = (u_short)bVar2;
        pTVar7->interval = (u_char)inputMat->dummy;
        Track_gMatController[iVar18].textureCount = *(char *)((int)&inputMat->m_length + 3);
        pTVar7 = Track_gMatController;
        Track_gMatController[iVar18].pmxIndex = matList->pmxIndex;
        pTVar7[iVar18].matPtr = matList;
        iVar20 = iVar18 + 1;
      }
      iVar18 = 0;
      if (TrackSpec_gSpec.fogstate != 0) {
        iVar17 = 0;
        for (; iVar18 < 0x20; iVar18 = iVar18 + 1) {
          piVar11 = (int *)((int)gTempMipMapInfo->code + iVar17);
          if ((*piVar11 != -1) && (iVar13 = piVar11[1], iVar13 == (short)inputMat->m_type)) {
            iVar10 = piVar11[2];
            matList->flag = matList->flag | 8;
            iVar12 = (int)(short)inputMat->m_type;
            iVar10 = iVar10 - iVar13;
            if (iVar12 == matList->pmxIndex) {
              matList->mipmap_offset = (char)iVar10;
            }
            else {
              pDVar8 = gInitialArt.pPmx + iVar12 + iVar10;
              puVar1 = (u_char *)((int)&pDVar8->clut + 1);
              uVar4 = (u_int)puVar1 & 3;
              uVar5 = (u_int)pDVar8 & 3;
              pmxLnkW0 = (*(int *)(puVar1 + -uVar4) << (3 - uVar4) * 8 |
                      pmxLnkW0 & 0xffffffffU >> (uVar4 + 1) * 8) & -1 << (4 - uVar5) * 8 |
                      *(u_int *)((int)pDVar8 - uVar5) >> uVar5 * 8;
              puVar1 = (u_char *)((int)&pDVar8->tpage + 1);
              uVar4 = (u_int)puVar1 & 3;
              uVar5 = (u_int)&pDVar8->u1 & 3;
              uVar15 = (*(int *)(puVar1 + -uVar4) << (3 - uVar4) * 8 |
                       uVar15 & 0xffffffffU >> (uVar4 + 1) * 8) & -1 << (4 - uVar5) * 8 |
                       *(u_int *)(&pDVar8->u1 + -uVar5) >> uVar5 * 8;
              puVar1 = (u_char *)((int)&pDVar8->pad2 + 1);
              uVar4 = (u_int)puVar1 & 3;
              uVar5 = (u_int)&pDVar8->u2 & 3;
              pmxLnkW2 = (*(int *)(puVar1 + -uVar4) << (3 - uVar4) * 8 |
                      pmxLnkW2 & 0xffffffffU >> (uVar4 + 1) * 8) & -1 << (4 - uVar5) * 8 |
                      *(u_int *)(&pDVar8->u2 + -uVar5) >> uVar5 * 8;
              puVar1 = (u_char *)((int)&pDVar8->flag + 1);
              uVar4 = (u_int)puVar1 & 3;
              uVar5 = (u_int)&pDVar8->u3 & 3;
              uVar16 = (*(int *)(puVar1 + -uVar4) << (3 - uVar4) * 8 |
                       uVar16 & 0xffffffffU >> (uVar4 + 1) * 8) & -1 << (4 - uVar5) * 8 |
                       *(u_int *)(&pDVar8->u3 + -uVar5) >> uVar5 * 8;
              puVar1 = (u_char *)((int)&originalPmx.clut + 1);
              uVar4 = (u_int)puVar1 & 3;
              puVar6 = (u_int *)(puVar1 + -uVar4);
              *puVar6 = *puVar6 & -1 << (uVar4 + 1) * 8 | pmxLnkW0 >> (3 - uVar4) * 8;
              puVar1 = (u_char *)((int)&originalPmx.tpage + 1);
              uVar4 = (u_int)puVar1 & 3;
              puVar6 = (u_int *)(puVar1 + -uVar4);
              *puVar6 = *puVar6 & -1 << (uVar4 + 1) * 8 | uVar15 >> (3 - uVar4) * 8;
              originalPmx.u1 = (char)uVar15;
              originalPmx.v1 = (char)(uVar15 >> 8);
              originalPmx.tpage = (short)(uVar15 >> 0x10);
              puVar1 = (u_char *)((int)&originalPmx.pad2 + 1);
              uVar4 = (u_int)puVar1 & 3;
              puVar6 = (u_int *)(puVar1 + -uVar4);
              *puVar6 = *puVar6 & -1 << (uVar4 + 1) * 8 | pmxLnkW2 >> (3 - uVar4) * 8;
              originalPmx.u2 = (char)pmxLnkW2;
              originalPmx.v2 = (char)(pmxLnkW2 >> 8);
              originalPmx.pad2 = (short)(pmxLnkW2 >> 0x10);
              puVar1 = (u_char *)((int)&originalPmx.flag + 1);
              uVar4 = (u_int)puVar1 & 3;
              puVar6 = (u_int *)(puVar1 + -uVar4);
              *puVar6 = *puVar6 & -1 << (uVar4 + 1) * 8 | uVar16 >> (3 - uVar4) * 8;
              (*(int *)&(originalPmx)) = pmxLnkW0;
              (*(int *)((u_char *)&(originalPmx) + 12)) = uVar16;
              Track_ProcessFlipAndUVFlags((u_int)*(u_char *)((int)&inputMat->m_type + 3),&originalPmx,
                         gInitialArt.pPmx + gInitialArt.pmxCount);
              gInitialArt.pmxCount = gInitialArt.pmxCount + 1;
              matList->mipmap_offset = '\x01';
            }
          }
          iVar17 = iVar17 + 0xc;
        }
      }
      matList = matList + 1;
      inputMat = (SerializedGroup *)((int)&inputMat->dummy + 2);
      iVar18 = iVar20;
    }
    if (gTempMipMapInfo != (Track_MipMap *)0x0) {
      purgememadr(gTempMipMapInfo);
    }
    purgememadr(gTempMultiPalInfo);
    gInitialArt.shapeFile = (char *)0x0;
    gInitialArt.pmxCount = gInitialArt.shapeCount;
  }
  return;
}

/* ---- ReduceObjectPrecision__FP5GroupT0i  [TRACK.CPP:963-1004] SLD-VERIFIED ---- */
void ReduceObjectPrecision(Group *instGroup,Group *defGroup,int bits)

{
  short sVar1;
  short sVar2;
  Trk_ObjectDef **ppTVar3;
  Trk_ObjectDef *objDef;
  Trk_ObjectDef *pTVar4;
  short tu5;
  Group *pThis;
  Trk_ObjectDef *pTVar5;
  CCOORD16 *pts;
  Trk_ObjectDef *pTVar6;
  u_int uVar7;
  Trk_SimpleInst *inst;
  int count;
  int iVar8;
  
  ppTVar3 = Track_gObjDefs;
  inst = (Trk_SimpleInst *)(instGroup + 1);
  if (instGroup != (Group *)0x0) {
    iVar8 = instGroup->m_num_elements;
    while (iVar8 = iVar8 + -1, iVar8 != -1) {
      if (defGroup != (Group *)0x0) {
        pTVar4 = ppTVar3[inst->pad];
        pTVar6 = pTVar4 + 1;
        uVar7 = (u_int)pTVar4->vertexCount;
        while( true ) {
          pTVar5 = pTVar4 + 2;
          uVar7 = uVar7 - 1;
          if (uVar7 == 0xffffffff) break;
          ((u_char *)&(sVar1))[0] = pTVar4[1].vertexCount;
          ((u_char *)&(sVar1))[1] = pTVar4[1].quadCount;
          sVar2 = pTVar5->id;
          pTVar6->id = (short)((int)pTVar6->id >> (bits & 0x1fU));
          tu5 = (short)((int)sVar1 >> (bits & 0x1fU));
          ((u_char *)&(tu5))[0] = (u_char)tu5;
          ((u_char *)&(tu5))[1] = (u_char)((u_short)tu5 >> 8);
          pTVar4[1].vertexCount = (u_char)tu5;
          pTVar4[1].quadCount = ((u_char *)&(tu5))[1];
          pTVar5->id = (short)((int)sVar2 >> (bits & 0x1fU));
          pTVar6 = pTVar6 + 2;
          pTVar4 = pTVar5;
        }
      }
      inst = (Trk_SimpleInst *)((int)&inst->size + (int)inst->size);
    }
  }
  return;
}

/* ---- InvalidatePersistentCollideBoomObjects__FP5GroupT0  [TRACK.CPP:1012-1026] SLD-VERIFIED ---- */
void InvalidatePersistentCollideBoomObjects(Group *instGroup,Group *defGroup)

{
  Trk_SimpleInst * inst;
  Group *pGVar1;
  Group *pThis;
  int iVar2;
  int count;
  
  if ((instGroup != (Group *)0x0) && (defGroup != (Group *)0x0)) {
    iVar2 = instGroup->m_num_elements;
    pGVar1 = instGroup + 1;
    iVar2 = iVar2 + -1;
    while (iVar2 != -1) {
      if (Track_gObjDefs[*(short *)((int)&pGVar1[1].m_num_elements + 2)]->id != -1) {
        *(u_char *)((int)&pGVar1->m_num_elements + 2) = 0;
      }
      pGVar1 = (Group *)((int)&pGVar1->m_num_elements + (int)(short)pGVar1->m_num_elements);
      iVar2 = iVar2 + -1;
    }
  }
  return;
}

/* ---- CalcObjectBoundingSphere__FP5GroupT0  [TRACK.CPP:1064-1125] SLD-VERIFIED ---- */
void CalcObjectBoundingSphere(Group *defGroup,Group *boundingSphereGroup)

{
  Trk_ObjectDef * objDef;
  short sVar1;
  short sVar2;
  short *psVar3;
  u_int uVar4;
  u_int uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int diff;
  Trk_ObjectDef *pTVar9;
  int ptCount;
  u_int uVar10;
  u_int uVar11;
  CCOORD16 *pts;
  Trk_ObjectDef *pTVar12;
  Trk_ObjectDef *pTVar13;
  int radius;
  int iVar14;
  void *tp15;
  int i;
  int iVar15;
  tBoundingSphere *bSphere;
  Group *pGVar16;
  int objCount;
  int iVar17;
  coorddef cp;
  
  pGVar16 = boundingSphereGroup + 1;
  tp15 = (void *)((int)&boundingSphereGroup[2].m_num_elements + 2);
  iVar17 = defGroup->m_num_elements;
  for (iVar15 = 0; iVar15 < iVar17; iVar15 = iVar15 + 1) {
    pTVar9 = Track_gObjDefs[iVar15];
    uVar10 = (u_int)pTVar9->vertexCount;
    pTVar12 = pTVar9 + 1;
    cp.z = 0;
    cp.y = 0;
    cp.x = 0;
    pTVar13 = pTVar9;
    while (uVar10 = uVar10 - 1, uVar10 != 0xffffffff) {
      psVar3 = &pTVar12->id;
      pTVar12 = pTVar12 + 2;
      cp.x = cp.x + *psVar3;
      ((u_char *)&(sVar1))[0] = pTVar13[1].vertexCount;
      ((u_char *)&(sVar1))[1] = pTVar13[1].quadCount;
      cp.y = cp.y + sVar1;
      cp.z = cp.z + pTVar13[2].id;
      pTVar13 = pTVar13 + 2;
    }
    uVar10 = (u_int)pTVar9->vertexCount;
    if (uVar10 == 0) {
      trap(0x1c00);
    }
    if ((uVar10 == 0xffffffff) && (cp.x == -0x80000000)) {
      trap(0x1800);
    }
    uVar4 = (u_int)pTVar9->vertexCount;
    if (uVar4 == 0) {
      trap(0x1c00);
    }
    if ((uVar4 == 0xffffffff) && (cp.y == -0x80000000)) {
      trap(0x1800);
    }
    uVar5 = (u_int)pTVar9->vertexCount;
    if (uVar5 == 0) {
      trap(0x1c00);
    }
    if ((uVar5 == 0xffffffff) && (cp.z == -0x80000000)) {
      trap(0x1800);
    }
    pTVar13 = pTVar9 + 1;
    iVar14 = 0;
    uVar11 = (u_int)pTVar9->vertexCount;
    while( true ) {
      uVar11 = uVar11 - 1;
      if (uVar11 == 0xffffffff) break;
      iVar6 = cp.x / (int)uVar10 - (int)pTVar13->id >> 6;
      ((u_char *)&(sVar2))[0] = pTVar9[1].vertexCount;
      ((u_char *)&(sVar2))[1] = pTVar9[1].quadCount;
      iVar7 = cp.y / (int)uVar4 - (int)sVar2 >> 6;
      iVar8 = cp.z / (int)uVar5 - (int)pTVar9[2].id >> 6;
      iVar6 = iVar6 * iVar6 + iVar7 * iVar7 + iVar8 * iVar8;
      if (iVar14 < iVar6) {
        iVar14 = iVar6;
      }
      pTVar13 = pTVar13 + 2;
      pTVar9 = pTVar9 + 2;
    }
    (*(u_short *)&(cp.x)) = (u_short)(cp.x / (int)uVar10);
    *(u_short *)&pGVar16->m_num_elements = (u_short)cp.x;
    (*(u_short *)&(cp.y)) = (u_short)(cp.y / (int)uVar4);
    *(u_short *)((int)tp15 + -4) = (u_short)cp.y;
    (*(u_short *)&(cp.z)) = (u_short)(cp.z / (int)uVar5);
    pGVar16 = pGVar16 + 2;
    *(u_short *)((int)tp15 + -2) = (u_short)cp.z;
    uVar10 = fixedsqrt(iVar14 << 10);
    *(short *)tp15 = (short)(uVar10 >> 7);
    tp15 = (void *)((int)tp15 + 8);
    boundingSphereGroup->m_num_elements = boundingSphereGroup->m_num_elements + 1;
  }
  return;
}

/* ---- CalcObjDefPtrs__Fv  [TRACK.CPP:1179-1188] SLD-VERIFIED ---- */
void CalcObjDefPtrs(void)

{
  bool bVar1;
  Group *pGVar2;
  Group *pThis;
  Group *pGVar3;
  int iVar4;
  int i;
  
  pGVar2 = gPersistObjDef;
  iVar4 = 1;
  pGVar3 = gObjDefOffsetsGroup + 2;
  gObjDefOffsetsGroup[1].m_num_elements = (int)(gPersistObjDef + 1);
  while (bVar1 = iVar4 < pGVar2->m_num_elements, iVar4 = iVar4 + 1, bVar1) {
    pGVar3->m_num_elements = pGVar3[-1].m_num_elements + pGVar3->m_num_elements;
    pGVar3 = pGVar3 + 1;
  }
  Track_gObjDefs = (Trk_ObjectDef **)(gObjDefOffsetsGroup + 1);
  return;
}

/* ---- Track_InitPersistentData__FP15SerializedGroup  [TRACK.CPP:1212-1292] SLD-VERIFIED ---- */
void Track_InitPersistentData(SerializedGroup *perGroup)

{
  int count;
  SerializedGroup *pSVar1;
  Group *simGroup;
  SerializedGroup *pThis;
  int i;
  int iVar2;
  void *tp3;
  void *tp4;
  int iVar3;
  SerializedGroup___0_ *persistentGroups;
  
  iVar2 = 0;
  gObjDefOffsetsGroup = (Group *)0x0;
  tp3 = (char *)__builtin_alloca((((u_int)(perGroup->m_num_elements << 5) >> 3) + 7 & 0xfffffff8));
  tp4 = tp3;
  if (0 < perGroup->m_num_elements) {
    do {
      pSVar1 = LocateGroupNum(perGroup,iVar2);
      *(SerializedGroup **)tp4 = pSVar1;
      iVar2 = iVar2 + 1;
      tp4 = (void *)((int)tp4 + 4);
    } while (iVar2 < perGroup->m_num_elements);
  }
  LocateGroupType(perGroup,8,0);
  iVar3 = perGroup->m_num_elements;
  iVar2 = 0;
  do {
    if (iVar3 <= iVar2) {
      if (gObjDefOffsetsGroup != (Group *)0x0) {
        CalcObjDefPtrs();
      }
      return;
    }
    switch(**(u_int **)tp3) {
    case 2:
      Track_LinkMaterials(*(SerializedGroup **)tp3,(*(SerializedGroup **)tp3)->m_length + -0x10,
                 Track_materials);
      break;
    case 7:
      gPersistObjInst =
           CreateLiteGroup(*(SerializedGroup **)tp3,*(SerializedGroup **)tp3,Track_mem);
      break;
    case 8:
      gPersistObjDef =
           CreateLiteGroup(*(SerializedGroup **)tp3,*(SerializedGroup **)tp3,Track_mem);
      break;
    case 0xf:
      simGroup = CreateLiteGroup(*(SerializedGroup **)tp3,*(SerializedGroup **)tp3,Track_mem);
      BWorldSm_Init(simGroup);
      break;
    case 0x24:
      gPersistMidgroundObjInst =
           CreateLiteGroup(*(SerializedGroup **)tp3,*(SerializedGroup **)tp3,Track_mem);
      break;
    case 0x26:
      gObjDefOffsetsGroup =
           CreateLiteGroup(*(SerializedGroup **)tp3,*(SerializedGroup **)tp3,Track_mem);
    default: break;
    }
    tp3 = (void *)((int)tp3 + 4);
    iVar2 = iVar2 + 1;
  } while( true );
}

/* ---- Track_Init__FPc  [TRACK.CPP:1312-1475] SLD-VERIFIED ---- */
void Track_Init(char *tempName)

{
  SerializedGroup * trackGroup;
  SerializedGroup * chunkGroup;
  int trackFileSize;
  SerializedGroup * group;
  u_int uVar1;
  u_char *puVar2;
  u_int *puVar3;
  Group *pThis;
  int loadResult;
  SimpleMem *this_00;
  void *loadBuf;
  int scratchAlloc;
  int rootSerGroup;
  int groupBase;
  int subGroup;
  int geomSubGrp;
  int instSubGrp;
  int perGroup;
  SerializedGroup *pSVar4;
  int newChunk_p;
  short *visList;
  void *tp7;
  void *elemNext;
  CVECTOR *pCVar5;
  int j;
  u_int uVar6;
  int elemIdx;
  Group *size;
  int matCount;
  int elemPtr;
  int srcDataInd;
  int iVar43_field;
  int count;
  int iVar44_field;
  int reg_t3;
  int reg_t4;
  int tu9;
  int reg_t5;
  int tu10;
  int reg_t6;
  int tu11;
  Chunk *chunkDat;
  int chunkCount;
  int i;
  int groupOffset;
  int matOffset;
  SerializedGroup *nextChunkGroup;
  int matInfo_p;
  int chunkIdx;
  SerializedGroup *persistentGroup;
  char trackName [128];
  int tp5;
  int tp6;
  int tR7;
  int tp2;
  u_short tu3;
  int tu4;
  int tp4;
  TrackHeader *tT33;
  int tu1;
  int tu2;
  int tp3;
  u_char uVar7_00;
  u_char tu26;
  u_char tu27;
  u_char tu28;
  u_char tu29;
  u_char tu22;
  u_char tu23;
  u_char tu24;
  u_char tu25;
  u_char tu34;
  u_char tu35;
  u_char tu30;
  u_char tu31;
  u_char tu32;
  u_char tu33;
  void *tp1;
  
  Track_gSaveSurface = (SaveSurface *)0x0;
  Track_gObjDefs = (Trk_ObjectDef **)0x0;
  sprintf(trackName,"%s",tempName);
  loadResult = filesize(tempName);
  uVar6 = 0x404;
  Chunk_lightTable = reservememadr("lighttbl",0x404,0);
  TextureProcess_Init();
  chunkCount = loadResult + 0x9080;
  InitArtResources();
  TexturesLoadInitial();
  this_00 = __builtin_new(uVar6);
  loadBuf = reservememadr("Track_mem",chunkCount,0);
  this_00->heap = loadBuf;
  this_00->freeMem = loadBuf;
  if (loadBuf == (void *)0x0) {
    chunkCount = 0;
  }
  this_00->freeMemSize = chunkCount;
  Track_mem = this_00;
  scratchAlloc = (int)FeignAlloc(this_00,loadResult);
  rootSerGroup = loadfileatadr(trackName,(void *)(scratchAlloc + 0x9080));
  groupBase = (int)LocateCreateGroupType((SerializedGroup *)rootSerGroup,0x1f,Track_mem,0);
  Track_header = (TrackHeader *)(groupBase + 4);
  subGroup = (int)LocateCreateGroupType((SerializedGroup *)rootSerGroup,0x20,Track_mem,0);
  Chunk_chunkCenters = (coorddef *)(subGroup + 4);
  geomSubGrp = (int)LocateGroupType((SerializedGroup *)rootSerGroup,0x23,0);
  tp7 = (void *)(geomSubGrp + 0x10);
  pCVar5 = Chunk_lightTable;
  if ((((u_int)tp7 | (u_int)Chunk_lightTable) & 3) == 0) {
    do {
      ((u_char *)&(tu9))[0] = ((CVECTOR *)((int)tp7 + 4))->r;
      ((u_char *)&(tu9))[1] = ((CVECTOR *)((int)tp7 + 4))->g;
      ((u_char *)&(tu9))[2] = ((CVECTOR *)((int)tp7 + 4))->b;
      ((u_char *)&(tu9))[3] = ((CVECTOR *)((int)tp7 + 4))->cd;
      ((u_char *)&(tu10))[0] = ((CVECTOR *)((int)tp7 + 8))->r;
      ((u_char *)&(tu10))[1] = ((CVECTOR *)((int)tp7 + 8))->g;
      ((u_char *)&(tu10))[2] = ((CVECTOR *)((int)tp7 + 8))->b;
      ((u_char *)&(tu10))[3] = ((CVECTOR *)((int)tp7 + 8))->cd;
      ((u_char *)&(tu11))[0] = ((CVECTOR *)((int)tp7 + 0xc))->r;
      ((u_char *)&(tu11))[1] = ((CVECTOR *)((int)tp7 + 0xc))->g;
      ((u_char *)&(tu11))[2] = ((CVECTOR *)((int)tp7 + 0xc))->b;
      ((u_char *)&(tu11))[3] = ((CVECTOR *)((int)tp7 + 0xc))->cd;
      *pCVar5 = *(CVECTOR *)tp7;
      pCVar5[1].r = (u_char)tu9;
      pCVar5[1].g = (char)((u_int)tu9 >> 8);
      pCVar5[1].b = (char)((u_int)tu9 >> 0x10);
      pCVar5[1].cd = (char)((u_int)tu9 >> 0x18);
      pCVar5[2].r = (u_char)tu10;
      pCVar5[2].g = (char)((u_int)tu10 >> 8);
      pCVar5[2].b = (char)((u_int)tu10 >> 0x10);
      pCVar5[2].cd = (char)((u_int)tu10 >> 0x18);
      pCVar5[3].r = (u_char)tu11;
      pCVar5[3].g = (char)((u_int)tu11 >> 8);
      pCVar5[3].b = (char)((u_int)tu11 >> 0x10);
      pCVar5[3].cd = (char)((u_int)tu11 >> 0x18);
      tp7 = (void *)((int)tp7 + 0x10);
      pCVar5 = pCVar5 + 4;
    } while (tp7 != (CVECTOR *)(geomSubGrp + 0x410));
  }
  else {
    do {
      tp1 = &((CVECTOR *)tp7)->cd;
      tu1 = (u_int)tp1 & 3;
      tu4 = (u_int)tp7 & 3;
      reg_t3 = (*(int *)((int)tp1 - tu1) << (3 - tu1) * 8 | reg_t3 & 0xffffffffU >> (tu1 + 1) * 8) &
               -1 << (4 - tu4) * 8 | *(u_int *)((int)tp7 - tu4) >> tu4 * 8;
      tp2 = (int)&((CVECTOR *)((int)tp7 + 4))->cd;
      uVar6 = tp2 & 3;
      tu2 = (u_int)((int)tp7 + 4) & 3;
      reg_t4 = (*(int *)(tp2 - uVar6) << (3 - uVar6) * 8 | reg_t4 & 0xffffffffU >> (uVar6 + 1) * 8)
               & -1 << (4 - tu2) * 8 | *(u_int *)((int)((int)tp7 + 4) - tu2) >> tu2 * 8;
      uVar6 = (u_int)&((CVECTOR *)((int)tp7 + 8))->cd & 3;
      uVar1 = (u_int)((int)tp7 + 8) & 3;
      reg_t5 = (*(int *)(&((CVECTOR *)((int)tp7 + 8))->cd + -uVar6) << (3 - uVar6) * 8 |
               reg_t5 & 0xffffffffU >> (uVar6 + 1) * 8) & -1 << (4 - uVar1) * 8 |
               *(u_int *)((int)((int)tp7 + 8) - uVar1) >> uVar1 * 8;
      uVar6 = (u_int)&((CVECTOR *)((int)tp7 + 0xc))->cd & 3;
      uVar1 = (u_int)((int)tp7 + 0xc) & 3;
      reg_t6 = (*(int *)(&((CVECTOR *)((int)tp7 + 0xc))->cd + -uVar6) << (3 - uVar6) * 8 |
               reg_t6 & 0xffffffffU >> (uVar6 + 1) * 8) & -1 << (4 - uVar1) * 8 |
               *(u_int *)((int)((int)tp7 + 0xc) - uVar1) >> uVar1 * 8;
      uVar6 = (u_int)&pCVar5->cd & 3;
      tp5 = (int)&pCVar5->cd - uVar6;
      *(u_int *)tp5 = *(u_int *)tp5 & -1 << (uVar6 + 1) * 8 | (u_int)reg_t3 >> (3 - uVar6) * 8;
      uVar6 = (u_int)pCVar5 & 3;
      *(u_int *)((int)pCVar5 - uVar6) =
           *(u_int *)((int)pCVar5 - uVar6) & 0xffffffffU >> (4 - uVar6) * 8 | reg_t3 << uVar6 * 8;
      uVar6 = (u_int)&pCVar5[1].cd & 3;
      tp3 = (int)&pCVar5[1].cd - uVar6;
      *(u_int *)tp3 = *(u_int *)tp3 & -1 << (uVar6 + 1) * 8 | (u_int)reg_t4 >> (3 - uVar6) * 8;
      uVar6 = (u_int)(pCVar5 + 1) & 3;
      tp6 = (int)(pCVar5 + 1) - uVar6;
      *(u_int *)tp6 = *(u_int *)tp6 & 0xffffffffU >> (4 - uVar6) * 8 | reg_t4 << uVar6 * 8;
      uVar6 = (u_int)&pCVar5[2].cd & 3;
      puVar2 = &pCVar5[2].cd + -uVar6;
      *(u_int *)puVar2 = *(u_int *)puVar2 & -1 << (uVar6 + 1) * 8 | (u_int)reg_t5 >> (3 - uVar6) * 8;
      uVar6 = (u_int)(pCVar5 + 2) & 3;
      tp4 = (int)(pCVar5 + 2) - uVar6;
      *(u_int *)tp4 = *(u_int *)tp4 & 0xffffffffU >> (4 - uVar6) * 8 | reg_t5 << uVar6 * 8;
      uVar6 = (u_int)&pCVar5[3].cd & 3;
      puVar2 = &pCVar5[3].cd + -uVar6;
      *(u_int *)puVar2 = *(u_int *)puVar2 & -1 << (uVar6 + 1) * 8 | (u_int)reg_t6 >> (3 - uVar6) * 8;
      uVar6 = (u_int)(pCVar5 + 3) & 3;
      puVar3 = (u_int *)((int)(pCVar5 + 3) - uVar6);
      *puVar3 = *puVar3 & 0xffffffffU >> (4 - uVar6) * 8 | reg_t6 << uVar6 * 8;
      tp7 = (void *)((int)tp7 + 0x10);
      pCVar5 = pCVar5 + 4;
    } while (tp7 != (CVECTOR *)(geomSubGrp + 0x410));
  }
  instSubGrp = (int)LocateGroupType((SerializedGroup *)rootSerGroup,0x23,0);
  matOffset = 0;
  chunkIdx = 0;
  Chunk_numLight = *(int *)(instSubGrp + 4) - 0x10U >> 2;
  Track_gInViewList = Alloc(Track_mem,Track_header->chunkCount * 0x48,0);
  Track_gInViewCount = Alloc(Track_mem,Track_header->chunkCount,0);
  Track_chunkList = Alloc(Track_mem,Track_header->chunkCount * 0x70,0);
  Chunk_Init();
  perGroup = (int)LocateGroupType((SerializedGroup *)rootSerGroup,0x21,0);
  pSVar4 = LocateGroupType((SerializedGroup *)rootSerGroup,0x1d,0);
  for (groupOffset = 0; groupOffset < Track_header->chunkCount; groupOffset = groupOffset + 1) {
    tR7 = (int)Track_chunkList->boundPts;
    matInfo_p = 0;
    if (groupOffset < Track_header->chunkCount + -1) {
      matInfo_p = (int)LocateNextGroupType(pSVar4,0x1d);
    }
    InstanceGroup((Chunk *)(tR7 + chunkIdx),pSVar4,Track_mem);
    pSVar4 = LocateGroupType(pSVar4,4,0);
    tT33 = Track_header;
    iVar44_field = pSVar4->m_num_elements;
    pSVar4 = pSVar4 + 1;
    iVar43_field = 0;
    if (0x24 < iVar44_field) {
      iVar44_field = 0x24;
    }
    elemIdx = 0;
    if (0 < iVar44_field) {
      elemPtr = (int)*Track_gInViewList + matOffset;
      do {
        tu3 = (u_short)pSVar4->m_type;
        if ((int)(tu3 & 0x3ff) < tT33->chunkCount) {
          *(u_short *)elemPtr = tu3;
          elemPtr = elemPtr + 2;
          elemIdx = elemIdx + 1;
        }
        iVar43_field = iVar43_field + 1;
        pSVar4 = (SerializedGroup *)((int)&pSVar4->m_type + 2);
      } while (iVar43_field < iVar44_field);
    }
    Track_gInViewCount[groupOffset] = (u_char)elemIdx;
    if (elemIdx < 0x24) {
      elemNext = (void *)((int)*Track_gInViewList + elemIdx * 2 + matOffset);
      do {
        *(u_short *)elemNext = 0x3ff;
        elemIdx = elemIdx + 1;
        elemNext = (void *)((int)elemNext + 2);
      } while (elemIdx < 0x24);
    }
    matOffset = matOffset + 0x40;
    chunkIdx = chunkIdx + 0x70;
    pSVar4 = (SerializedGroup *)matInfo_p;
  }
  Track_InitPersistentData((SerializedGroup *)perGroup);
  ResizeToFit(Track_mem);
  Track_MakeTrackPathName(".grp");
  gPersistObjDefBoundingSpheres =
       reservememadr("bsphere",gPersistObjDef->m_num_elements << 3 | 4,0);
  CalcObjectBoundingSphere(gPersistObjDef,gPersistObjDefBoundingSpheres);
  ReduceObjectPrecision(gPersistMidgroundObjInst,gPersistObjDef,2);
  size = gPersistObjDef;
  InvalidatePersistentCollideBoomObjects(gPersistObjInst,gPersistObjDef);
  newChunk_p = (int)__builtin_new((u_int)size);
  Track_gSaveSurface = SaveSurface_ct((SaveSurface *)newChunk_p,0x30);
  Track_LoadObjectKillData();
  return;
}

/* ---- Track_DeInit__Fv  [TRACK.CPP:1492-1533] SLD-VERIFIED ---- */
void Track_DeInit(void)

{
  SimpleMem *deleteMe;
  
  deleteMe = Track_mem;
  if (Track_mem != (SimpleMem *)0x0) {
    purgememadr(Track_mem->heap);
    deleteMe->freeMem = (u_char *)0x0;
    __builtin_delete(deleteMe);
  }
  if (Track_gSaveSurface != (SaveSurface *)0x0) {
    SaveSurface_dt(Track_gSaveSurface,3);
    Track_gSaveSurface = (SaveSurface *)0x0;
  }
  if (gInitialArt.shapeFile != (char *)0x0) {
    gInitialArt.shapeFile = (char *)0x0;
  }
  BWorldSm_DeInit();
  DeInitArtResources();
  if (Chunk_lightTable != (CVECTOR *)0x0) {
    purgememadr(Chunk_lightTable);
    Chunk_lightTable = (CVECTOR *)0x0;
  }
  if (gPersistObjDefBoundingSpheres != (Group *)0x0) {
    purgememadr(gPersistObjDefBoundingSpheres);
  }
  gPersistObjDefBoundingSpheres = (Group *)0x0;
  gPersistMidgroundObjInst = (Group *)0x0;
  gPersistObjInst = (Group *)0x0;
  gPersistObjDef = (Group *)0x0;
  return;
}

/* ---- Track_AnimateTrackLighting__Fv  [TRACK.CPP:1537-1544] SLD-VERIFIED ---- */
void Track_AnimateTrackLighting(void)

{
  return;
}

/* ---- KillFile_OpenRead__Fv  [TRACK.CPP:1720-1726] SLD-VERIFIED ---- */
char * KillFile_OpenRead(void)

{
  char *pcVar1;
  char pathName [128];
  
  pcVar1 = Track_MakeTrackPathName(".kil");
  sprintf(pathName,"%s",pcVar1);
  pcVar1 = (char *)loadfileadrz(pathName,(void *)0x0);
  return pcVar1;
}

/* ---- KillFile_ReadEntry__FPciRiT2  [TRACK.CPP:1732-1736] SLD-VERIFIED ---- */
void KillFile_ReadEntry(char *filePtr,int entryInd,int *chunkInd,int *objectInd)

{
  *chunkInd = *(int *)(filePtr + entryInd * 8 + 4);
  *objectInd = *(int *)(filePtr + entryInd * 8 + 8);
  return;
}

/* ---- Track_LoadObjectKillData__Fv  [TRACK.CPP:1742-1821] SLD-VERIFIED ---- */
void Track_LoadObjectKillData(void)

{
  Group * group;
  Group *simGroup;
  int *filePtr_00;
  int iVar1;
  int index;
  int iVar2;
  Trk_SimObject *simObjs;
  Group *pThis;
  Group *pGVar3;
  Chunk *chunkDat;
  coorddef *a;
  int j;
  Trk_SimpleInst *inst;
  Group *pGVar4;
  int numElements;
  int iVar5;
  int i;
  int entryInd;
  char *filePtr;
  int chunkInd;
  int objInd;
  
  filePtr_00 = (int *)KillFile_OpenRead();
  entryInd = 0;
  if (filePtr_00 != (int *)0x0) {
    for (; entryInd < *filePtr_00; entryInd = entryInd + 1) {
      KillFile_ReadEntry((char *)filePtr_00,entryInd,&chunkInd,&objInd);
      pGVar3 = Track_chunkList[chunkInd].objInstanceBuf;
      if ((pGVar3 != (Group *)0x0) && (pGVar4 = pGVar3 + 1, objInd < pGVar3->m_num_elements)) {
        iVar2 = 0;
        if (0 < objInd) {
          do {
            iVar2 = iVar2 + 1;
            pGVar4 = (Group *)((int)&pGVar4->m_num_elements + (int)(short)pGVar4->m_num_elements);
          } while (iVar2 < objInd);
        }
        pGVar3 = Track_chunkList[chunkInd].simObjBuf;
        iVar2 = 0;
        if (pGVar3 != (Group *)0x0) {
          iVar5 = pGVar3->m_num_elements;
          a = (coorddef *)(pGVar3 + 1);
          if (0 < iVar5) {
            do {
              iVar1 = Math_DistXZ(a,(coorddef *)(pGVar4 + 2));
              if (iVar1 < 0x1999) {
                *(u_char *)((int)&a[1].y + 3) = 0x10;
              }
              iVar2 = iVar2 + 1;
              a = (coorddef *)&a[1].z;
            } while (iVar2 < iVar5);
          }
        }
        *(u_char *)((int)&pGVar4->m_num_elements + 2) =
             *(u_char *)((int)&pGVar4->m_num_elements + 2) | 0x80;
      }
    }
    purgememadr(filePtr_00);
  }
  return;
}

/* ---- Save  [TRACK.CPP:1831-1850] SLD-VERIFIED ---- */
void Save(SaveSurface *pThis,Trk_NewSimQuad *simQuad)

{
  
  if (((int)*((short *)pThis) <= (int)((short *)pThis)[1]) && (simQuad != (Trk_NewSimQuad *)0x0)) {
    *(Trk_NewSimQuad **)(*((short *)pThis) * 8 + *(int *)(((short *)pThis) + 2)) = simQuad;
    *(u_char *)(*((short *)pThis) * 8 + *(int *)(((short *)pThis) + 2) + 4) = simQuad->surface;
    *((short *)pThis) = *((short *)pThis) + 1;
  }
  return;
}

/* ---- SaveSurface  [TRACK.CPP:1855-1858] SLD-VERIFIED ---- */
/* SaveSurface * __11SaveSurfacei(SaveSurface * pThis, int numEntries)
   
   GCC compiler-emitted helper / runtime support (gcc-helper).
   Class: SaveSurface :: (ctor/dtor)
   
   Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.
   
   Provenance:
     VA=0x800BAF70 block=CODE size=68B
     Direct callers: 1
     SLD source: nfs4/GAME/COMMON/TRACK.CPP:1855
     SYM data: 2 regparms / 0 args / 0 autos
     Sample callers: Track_Init
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.
   Build date: 1999-02-22.
   See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

SaveSurface * SaveSurface_ct(SaveSurface *pThis,int numEntries)

{
  tSaveSurface *ptVar1;
  
  pThis->fMaxCount = (short)numEntries;
  pThis->fCount = 0;
  ptVar1 = reservememadr("Surface Save",numEntries << 3,0);
  pThis->fStack = ptVar1;
  return pThis;
}

/* ---- ~SaveSurface  [TRACK.CPP:1864-1865] SLD-VERIFIED ---- */
/* void _._11SaveSurface(SaveSurface * pThis, int __in_chrg)
   
   PsyQ-style internal helper (uncategorized) (psyq-internal).
   
   Phase F apply (2026-05-07): documentation-coverage closure for game-side undocumented fns.
   
   Provenance:
     VA=0x800BAFB4 block=CODE size=72B
     Direct callers: 1
     SLD source: nfs4/GAME/COMMON/TRACK.CPP:1864
     SYM data: 2 regparms / 0 args / 0 autos
     Sample callers: Track_DeInit
   
   Toolchain: PsyQ SDK 4.3 (May 1998), GCC 2.7.2, ASPSX 2.77, PSYLINK 2.73.
   Build date: 1999-02-22.
   See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md. */

void SaveSurface_dt(SaveSurface *pThis,int __in_chrg)

{
  
  purgememadr(pThis->fStack);
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}

/* ---- RestoreAll  [TRACK.CPP:1871-1879] SLD-VERIFIED ---- */
void RestoreAll(SaveSurface *pThis)

{
  int iVar1;
  int i;
  
  iVar1 = 0;
  if (0 < pThis->fCount) {
    do {
      (pThis->fStack[iVar1].fSimQuad)->surface = pThis->fStack[iVar1].fSurface;
      pThis->fStack[iVar1].fSimQuad = (Trk_NewSimQuad *)0x0;
      pThis->fStack[iVar1].fSurface = '\0';
      iVar1 = iVar1 + 1;
    } while (iVar1 < pThis->fCount);
  }
  pThis->fCount = 0;
  return;
}

/* end of track.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
int wordFile_psh_snow;
