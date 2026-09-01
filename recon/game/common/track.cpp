/* game/psx/track.cpp -- RECONSTRUCTED (NFS4 PSX track load/resources/materials; C++ TU)
 *   29 fns: track init/deinit, art+texture resources, LoadShapesAndMakePmx, material linking,
 *   object bounding spheres, kill data, SaveSurface class. GTE-free. Full SYM-locals applied.
 */
#include "track_types.h"
#include "track_externs.h"

/* Track.obj-owned aggregate data.  SYM gives the exact types and contiguous
 * 0x8011E158..0x8011E1B0 extent; both aggregates are zero-initialized.
 * Separate named sections keep this run apart from Track's already
 * reconstructed dashboard pointer tables in ordinary .data and let the
 * linker retain the SYM order despite gcc's tentative-object sorting. */
Track_tArtresource gInitialArt
    __attribute__((section(".data.track_initial_art")));
Draw_tPixMap Track_gReflectionMaps[4]
    __attribute__((section(".data.track_reflection_maps")));

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
u_char *Track_gInViewCount;
int Chunk_numLight;
int Track_gControllerCount;
int gtrackNumber;
short (*Track_gInViewList)[32];

/* ---- owning-TU file-statics (BSS; SYM STAT) ---- */
static Track_MipMap *gTempMipMapInfo;
static Track_MultiPalette *gTempMultiPalInfo;

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
void KillFile_ReadEntry(char *filePtr,int entryInd,int &chunkInd,int &objectInd);
void Track_LoadObjectKillData(void);
/* SaveSurface::Save / ::RestoreAll are members (struct SaveSurface) -> ss->Save(...) */


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
  artRes->id = -1;
  artRes->basePmxCount = 0;
  artRes->pPmx = (Draw_tPixMap *)BWAllocMem(numPmx << 4);
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
  int i;
  shapetbl *shape;
  Draw_tPixMap *pPmx;
  int recolor_flag;
  int cluttype;
  int mipmapcounter;
  int multiPalOffset;

  pPmx = pmxList;
  cluttype = -1;
  recolor_flag = 0;
  gTempMipMapInfo = (Track_MipMap *)0x0;
  if (TrackSpec_gSpec.fogstate != 0) {
    int cnt;

    cluttype = -3;
    gTempMipMapInfo = reservememadr("mipmapinf",0x180,0x10);
    for (cnt = 0; cnt < 0x20; cnt = cnt + 1) {
      *(int *)gTempMipMapInfo[cnt].code = -1;
    }
  }

  gTempMultiPalInfo = reservememadr("mpalinfo",0x400,0x10);
  {
    int pcnt;
    int emptyPalNum;

    emptyPalNum = -1;
    for (pcnt = 0x7f; 0 <= pcnt; pcnt = pcnt - 1) {
      gTempMultiPalInfo[pcnt].palnum = emptyPalNum;
    }
  }

  DrawSync(0);
  mipmapcounter = 0;
  i = 0;
  multiPalOffset = 0;

  while (i < shapecount(shapefile)) {
    char name[4];
    int tempclut;

    shape = (shapetbl *)shapepointer(shapefile,i);
    if (shape != (shapetbl *)0x0) {
      shapename(shapefile,i,name);
      tempclut = cluttype;
      if ((i < 0xc) || ((shape->type & 3) == 1) || (name[0] == '#')) {
        tempclut = -1;
      }

      Texture_LoadPmx((char *)0x0,(char *)shape,loadFlags | recolor_flag | 2,
                      x,y,tempclut,tempclut,pPmx);

      if (name[0] == '!') {
        int palnum;

        *(char *)(multiPalOffset + (int)gTempMultiPalInfo) = name[1];
        *(char *)(multiPalOffset + (int)gTempMultiPalInfo + 1) = name[2];
        palnum = atoi(name + 3);
        ((Track_MultiPalette *)
         (multiPalOffset + (int)gTempMultiPalInfo))->palnum = palnum;
        ((Track_MultiPalette *)
         (multiPalOffset + (int)gTempMultiPalInfo))->actualshapeindex = i;
        if (palnum != 0) {
          int j;

          for (j = 0; j < 0x80; j = j + 1) {
            if ((gTempMultiPalInfo[j].charcode[0] == (u_char)name[1]) &&
                (gTempMultiPalInfo[j].charcode[1] == (u_char)name[2]) &&
                (gTempMultiPalInfo[j].palnum == 0)) {
              ((Track_MultiPalette *)
               (multiPalOffset + (int)gTempMultiPalInfo))->origshapeindex =
                  gTempMultiPalInfo[j].origshapeindex;
              break;
            }
          }
        }
        else {
          ((Track_MultiPalette *)
           (multiPalOffset + (int)gTempMultiPalInfo))->origshapeindex = i;
        }
        multiPalOffset = multiPalOffset + sizeof(Track_MultiPalette);
      }

      if ((TrackSpec_gSpec.fogstate != 0) && (name[0] == 'Z')) {
        short icode[2];

        icode[0] = (u_char)name[2];
        icode[1] = (u_char)name[3];
        if ((name[1] == 'R') && ((shape->type & 3) == 1)) {
          gTempMipMapInfo[mipmapcounter].code[0] = icode[0];
          gTempMipMapInfo[mipmapcounter].code[1] = (u_char)name[3];
          gTempMipMapInfo[mipmapcounter].shapeParentIndex = i;
          gTempMipMapInfo[mipmapcounter].mipMapIndex = i;
          mipmapcounter = mipmapcounter + 1;
        }
        else if (name[1] == 'Z') {
          int j;

          for (j = 0; j < 0x20; j = j + 1) {
            if ((icode[0] == gTempMipMapInfo[j].code[0]) &&
                (icode[1] == gTempMipMapInfo[j].code[1])) {
              gTempMipMapInfo[j].mipMapIndex = i;
                break;
            }
          }
        }
      }
      pPmx = pPmx + 1;
    }
    i = i + 1;
  }
}

/* ---- LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii  [TRACK.CPP:375-394] SLD-VERIFIED ---- */
void LoadShapesAndMakePmx_EnvMap(char *shapefile,Draw_tPixMap *pmxList,int x,int y)

{
  shapetbl *shape;
  int i;
  Draw_tPixMap *pPmx;
  int recolor_flag;

  pPmx = pmxList;
  recolor_flag = 0;
  i = recolor_flag;
  for (; i < (int)shapecount(shapefile); i++) {
    shape = (shapetbl *)shapepointer(shapefile,i);
    if (shape != (shapetbl *)0x0) {
      Texture_LoadPmx((char *)0x0,(char *)shape,recolor_flag | 0x42,x,y,-1,-1,pPmx);
      pPmx = pPmx + 1;
    }
  }
  return;
}

/* ---- TexturesLoadInitial__Fv  [TRACK.CPP:405-465] SLD-VERIFIED ---- */
/* MATCH: retail SYM exposes only `success` ($v0) and the scoped `tmpShapes`
   ($s0); branch-local calls preserve the shared path-builder tail. */
void TexturesLoadInitial(void)

{
  int success;

  if (GameSetup_gData.Time != 0) {
    if (GameSetup_gData.Weather != 0) {
      success = (int)Track_MakeTrackPathName("S0.psh");
    }
    else {
      success = (int)Track_MakeTrackPathName("N0.psh");
    }
  }
  else if (GameSetup_gData.Weather != 0) {
    success = (int)Track_MakeTrackPathName("W0.psh");
  }
  else {
    success = (int)Track_MakeTrackPathName("0.psh");
  }
  if ((D_8011E15C[0] = (char *)loadshapeadr((char *)success,(void *)0x0)) !=
      (char *)0x0) {
    Texture_ResetPaletteSharing();
    gInitialArt.shapeCount = (int)shapecount(gInitialArt.shapeFile);
    LoadShapesAndMakePmx(gInitialArt.shapeFile,gInitialArt.pPmx,0x40,0x100,0);
    gInitialArt.pPmx[gInitialArt.shapeCount] = *gSpikeBeltPixmap;
    gInitialArt.shapeCount = gInitialArt.shapeCount + 1;
    gInitialArt.pmxCount = gInitialArt.shapeCount;
    gInitialArt.basePmxCount = gInitialArt.shapeCount;
    purgememadr(gInitialArt.shapeFile);
  }
  else {
    do {
                    /* WARNING: Do nothing block with infinite loop */
    } while( true );
  }
  Hrz_GetHorizonPixMap(gInitialArt.pPmx);
  {
    char *tmpShapes;

    tmpShapes = (char *)loadshapeadr(Track_MakeTrackPathName("r.psh"),(void *)0x0);
    if (tmpShapes != (char *)0x0) {
      Texture_ResetPaletteSharing();
      LoadShapesAndMakePmx_EnvMap(tmpShapes,Track_gReflectionMaps,0x3e0,0);
      purgememadr(tmpShapes);
    }
  }
  return;
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
  Track_SimGlobalCodegenView *simPtr;
  Track_tArtresource *artPtr;
  int negOne;
  int typeEnvMap;

  negOne = -1;
  typeEnvMap = 0x80;
  simPtr = &simGlobal;
  artPtr = &gInitialArt;
  pTVar7 = Track_gMatController;
  psVar6 = &pTVar7->pmxIndex;
  iVar8 = Track_gControllerCount;
TrkAnimTex_loopTest:
  iVar8 = iVar8 + -1;
  if (iVar8 != negOne) {
    if (pTVar7->type == typeEnvMap) {
      uVar4 = (u_int)*(u_char *)((int)psVar6 + -1);
      uVar5 = (u_int)*(u_char *)(psVar6 + -4);
      sVar1 = (*(Track_tMaterial **)(psVar6 + 1))->pmxIndex;
      cVar2 = (char)((simPtr->gameTicks / (int)uVar4) % (int)uVar5);
      pDVar3 = artPtr->pPmx + sVar1;
      pDVar3->v0 = *(u_char *)(psVar6 + -3) + cVar2;
      pDVar3->v1 = *(u_char *)((int)psVar6 + -5) + cVar2;
      pDVar3->v2 = *(u_char *)(psVar6 + -2) + cVar2;
      pDVar3->v3 = *(u_char *)((int)psVar6 + -3) + cVar2;
    }
    else if (pTVar7->type == 4) {
      uVar4 = (u_int)*(u_char *)((int)psVar6 + -1);
      uVar5 = (u_int)*(u_char *)(psVar6 + -1);
      (*(Track_tMaterial **)(psVar6 + 1))->pmxIndex =
           *psVar6 + (short)((simPtr->gameTicks / (int)uVar4) % (int)uVar5);
    }
    psVar6 = psVar6 + 8;
    pTVar7 = pTVar7 + 1;
    goto TrkAnimTex_loopTest;
  }
  return;
}

/* ---- Track_GetProperMultiPalShapeIndex__Fii  [TRACK.CPP:525-532] SLD-VERIFIED ---- */
int Track_GetProperMultiPalShapeIndex(int shapeindex,int paletteindex)

{
  int t;

  for (t = 0; t < 0x80; t++) {
    if (gTempMultiPalInfo[t].origshapeindex == shapeindex) {
      if (gTempMultiPalInfo[t].palnum == paletteindex) {
        return (int)gTempMultiPalInfo[t].actualshapeindex;
      }
    }
  }
  return shapeindex;
}

/* ---- Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1  [TRACK.CPP:538-571] SLD-VERIFIED ---- */
void Track_ProcessFlipAndUVFlags(int uvFlag,Draw_tPixMap *inputPmx,Draw_tPixMap *outputPmx)

{
  int pmxProcessCount;
  Draw_tPixMap newPmx [4];

  pmxProcessCount = 0;
  newPmx[0] = *inputPmx;
  if ((uvFlag & 0x10U) != 0) {
    Texture_CloneUVPmx(&newPmx[0],0,&newPmx[1]);
    pmxProcessCount = 1;
  }
  if ((uvFlag & 0x40U) != 0) {
    Texture_CloneUVPmx(&newPmx[pmxProcessCount],1,
                       &newPmx[pmxProcessCount + 1]);
    pmxProcessCount = pmxProcessCount + 1;
  }
  if ((uvFlag & 0xeU) != 0) {
    if ((uvFlag & 2U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],2,
                         &newPmx[pmxProcessCount + 1]);
    }
    else if ((uvFlag & 4U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],3,
                         &newPmx[pmxProcessCount + 1]);
    }
    else if ((uvFlag & 8U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],4,
                         &newPmx[pmxProcessCount + 1]);
    }
    pmxProcessCount = pmxProcessCount + 1;
  }
  *outputPmx = newPmx[pmxProcessCount];
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
  int shapeIndex;
  int animCount;
  Draw_tPixMap originalPmx;

  outputMat->flag = inputMat->flag;
  animCount = 0;
TrkAssoc_loopTest:
  if (animCount < 1 || (animCount < (int)(u_int)(u_char)inputMat->textureCount)) {
    if ((inputMat->uvFlag & 0x5e) != 0) {
      shapeIndex = (int)inputMat->shapeIndex;
      if ((inputMat->flag & 2) != 0) {
        shapeIndex = Track_GetProperMultiPalShapeIndex(shapeIndex,(u_int)inputMat->interval);
      }
      originalPmx = art->pPmx[shapeIndex + animCount];
      Track_ProcessFlipAndUVFlags((u_int)inputMat->uvFlag,&originalPmx,art->pPmx + art->pmxCount);
      if (animCount == 0) {
        outputMat->pmxIndex = (short)art->pmxCount;
      }
      art->pmxCount = art->pmxCount + 1;
    }
    else {
      shapeIndex = (int)inputMat->shapeIndex;
      if ((inputMat->flag & 2) != 0) {
        shapeIndex = Track_GetProperMultiPalShapeIndex(shapeIndex,(u_int)inputMat->interval);
      }
      if (animCount == 0) {
        outputMat->pmxIndex = (short)shapeIndex;
      }
    }
    animCount = animCount + 1;
    goto TrkAssoc_loopTest;
  }
  return;
}

/* ---- Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial  [TRACK.CPP:688-848] SLD-VERIFIED ---- */
void Track_LinkMaterials(SerializedGroup *group,int length,Track_tMaterial *matList)

{
  Trk_Material *mats;

  if (group != (SerializedGroup *)0x0) {
    int matCount;
    int i;
    int controlIndex;

    matCount = length / sizeof(Trk_Material);
    mats = (Trk_Material *)(group + 1);
    Track_gControllerCount = 0;
    gInitialArt.pmxCount = gInitialArt.basePmxCount;

    for (i = 0; i < matCount; i = i + 1) {
      if ((*(u_short *)&mats[i].flag & 0x84) != 0) {
        Track_gControllerCount = Track_gControllerCount + 1;
      }
    }

    if (Track_gControllerCount != 0) {
      Track_gMatController =
           (Track_tMaterialController *)BWAllocMem(Track_gControllerCount << 4);
    }

    /* MATCH: SLD has no input/output walker locals.  Indexed source lets loop.c
     * derive retail's +10/+4 walkers while preserving mats/matList identities. */
    for (i = 0, controlIndex = 0; i < matCount; i = i + 1) {
      Track_AssociateSingleMaterial(&mats[i],&matList[i],&gInitialArt);

      if ((mats[i].flag & 4) != 0) {
        Track_gMatController[controlIndex].type = mats[i].flag;
        Track_gMatController[controlIndex].interval = mats[i].interval;
        Track_gMatController[controlIndex].textureCount = mats[i].textureCount;
        Track_gMatController[controlIndex].pmxIndex = matList[i].pmxIndex;
        Track_gMatController[controlIndex].matPtr = &matList[i];
        controlIndex = controlIndex + 1;
      }
      else if ((mats[i].flag & 0x80) != 0) {
        Draw_tPixMap *pmx;
        int d;

        Track_gMatController[controlIndex].type = mats[i].flag;
        if (mats[i].interval == 0) {
          mats[i].interval = 1;
        }
        Track_gMatController[controlIndex].interval = mats[i].interval;
        Track_gMatController[controlIndex].textureCount = mats[i].textureCount;
        Track_gMatController[controlIndex].pmxIndex = matList[i].pmxIndex;
        Track_gMatController[controlIndex].matPtr = &matList[i];

        pmx = gInitialArt.pPmx + matList[i].pmxIndex;
        Track_gMatController[controlIndex].uv0 = pmx->v0;
        Track_gMatController[controlIndex].uv1 = pmx->v1;
        Track_gMatController[controlIndex].uv2 = pmx->v2;
        Track_gMatController[controlIndex].uv3 = pmx->v3;
        d = pmx->v3 - pmx->v0;
        if (d < 0) {
          d = -d;
        }
        Track_gMatController[controlIndex].textureMax = d + 1;
        controlIndex = controlIndex + 1;
      }

      if (TrackSpec_gSpec.fogstate != 0) {
        int mm;

        for (mm = 0; mm < 0x20; mm = mm + 1) {
          if (*(int *)gTempMipMapInfo[mm].code != -1) {
            int shapeIndex;

            shapeIndex = gTempMipMapInfo[mm].shapeParentIndex;
            if (shapeIndex == mats[i].shapeIndex) {
              int mipmap_offset;

              mipmap_offset = gTempMipMapInfo[mm].mipMapIndex;
              matList[i].flag = matList[i].flag | 8;
              mipmap_offset = mipmap_offset - shapeIndex;
              if (mats[i].shapeIndex != matList[i].pmxIndex) {
                Draw_tPixMap originalPmx;
                int shapeIndex;

                shapeIndex = mats[i].shapeIndex + mipmap_offset;
                originalPmx = gInitialArt.pPmx[shapeIndex];
                Track_ProcessFlipAndUVFlags(mats[i].uvFlag,&originalPmx,
                           gInitialArt.pPmx + gInitialArt.pmxCount);
                gInitialArt.pmxCount = gInitialArt.pmxCount + 1;
                matList[i].mipmap_offset = 1;
              }
              else {
                matList[i].mipmap_offset = mipmap_offset;
              }
            }
          }
        }
      }
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
  Trk_SimpleInst *inst;
  int count;

  if (instGroup != (Group *)0x0) {
    inst = (Trk_SimpleInst *)(instGroup + 1);
    count = instGroup->m_num_elements;
    while (--count != -1) {
      if (defGroup != (Group *)0x0) {
        Trk_ObjectDef *objDef = Track_gObjDefs[inst->pad];
        CCOORD16 *pts = (CCOORD16 *)(objDef + 1);
        int pointCount = objDef->vertexCount;

        while (--pointCount != -1) {
          int x = pts->x;
          int y = pts->y;
          int z = pts->z;
          x >>= bits;
          y >>= bits;
          z >>= bits;
          pts->x = x;
          pts->y = y;
          pts->z = z;
          pts++;
        }
      }
      inst = (Trk_SimpleInst *)((int)&inst->size + (int)inst->size);
    }
  }
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
  tBoundingSphere *bSphere;
  int objCount;

  bSphere = (tBoundingSphere *)(boundingSphereGroup + 1);
  objCount = defGroup->m_num_elements;

  for (int i = 0; i < objCount; i = i + 1) {
    int ptCount;
    CCOORD16 *pts;
    coorddef cp;
    int radius;

    objDef = Track_gObjDefs[i];
    ptCount = objDef->vertexCount;
    pts = (CCOORD16 *)(objDef + 1);
    cp.x = cp.y = cp.z = 0;
    while (--ptCount != -1) {
      cp.x = cp.x + pts->x;
      cp.y = cp.y + pts->y;
      cp.z = cp.z + pts->z;
      pts = pts + 1;
    }

    cp.x = cp.x / objDef->vertexCount;
    cp.y = cp.y / objDef->vertexCount;
    cp.z = cp.z / objDef->vertexCount;

    pts = (CCOORD16 *)(objDef + 1);
    radius = 0;
    ptCount = objDef->vertexCount;
    while (--ptCount != -1) {
      int diff;
      int dx = (cp.x - pts->x) >> 6;
      int dy = (cp.y - pts->y) >> 6;
      int dz = (cp.z - pts->z) >> 6;

      diff = dx * dx + dy * dy + dz * dz;
      if (radius < diff) {
        radius = diff;
      }
      pts = pts + 1;
    }

    bSphere->cp.x = (short)cp.x;
    bSphere->cp.y = (short)cp.y;
    bSphere->cp.z = (short)cp.z;
    bSphere->radius = (short)((u_int)fixedsqrt(radius << 10) >> 7);
    bSphere = bSphere + 1;
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

  iVar4 = 1;
  gObjDefOffsetsGroup[1].m_num_elements = (int)(gPersistObjDef + 1);
  pGVar2 = gPersistObjDef;
  pGVar3 = gObjDefOffsetsGroup + 2;
CalcObjDefPtrs_loopTest:
  if (iVar4 < pGVar2->m_num_elements) {
    iVar4 = iVar4 + 1;
    pGVar3->m_num_elements = pGVar3[-1].m_num_elements + pGVar3->m_num_elements;
    pGVar3 = pGVar3 + 1;
    goto CalcObjDefPtrs_loopTest;
  }
  Track_gObjDefs = (Trk_ObjectDef **)(gObjDefOffsetsGroup + 1);
  return;
}

/* ---- Track_InitPersistentData__FP15SerializedGroup  [TRACK.CPP:1212-1292] SLD-VERIFIED ---- */
void Track_InitPersistentData(SerializedGroup *perGroup)

{
  int count;
  Group *simGroup;
  SerializedGroup *persistentGroups[perGroup->m_num_elements];

  gObjDefOffsetsGroup = (Group *)0x0;

  {
    int i;

    for (i = 0; i < perGroup->m_num_elements; i = i + 1) {
      persistentGroups[i] = perGroup->LocateGroupNum(i);
    }
  }

  perGroup->LocateGroupType(8,0);
  count = perGroup->m_num_elements;

  {
    int i = 0;

    while (i < count) {
      switch (persistentGroups[i]->m_type) {
      case 2:
        Track_LinkMaterials(persistentGroups[i],persistentGroups[i]->m_length + -0x10,
                   Track_materials);
        break;
      case 0xf:
        simGroup = persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
        BWorldSm_Init(simGroup);
        break;
      case 0x24:
        gPersistMidgroundObjInst =
             persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
        break;
      case 7:
        gPersistObjInst =
             persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
        break;
      case 8:
        gPersistObjDef =
             persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
        break;
      case 0x26:
        gObjDefOffsetsGroup =
             persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
      default: break;
      }
      i = i + 1;
    }
  }

  if (gObjDefOffsetsGroup != (Group *)0x0) {
    CalcObjDefPtrs();
  }
  return;
}

/* ---- Track_Init__FPc  [TRACK.CPP:1312-1475] SLD-VERIFIED ---- */
void Track_Init(char *tempName)

{
  SerializedGroup * trackGroup;
  SerializedGroup * chunkGroup;
  int trackFileSize;
  int size;
  SerializedGroup * group;
  Group *pThis;
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
  short *visList;
  void *tp7;
  void *elemNext;
  CVECTOR *pCVar5;
  int j;
  u_int uVar6;
  int elemIdx;
  int matCount;
  int elemPtr;
  int srcDataInd;
  int iVar43_field;
  int count;
  int iVar44_field;
  Chunk *chunkDat;
  int i;
  int groupOffset;
  int matOffset;
  SerializedGroup *nextChunkGroup;
  int matInfo_p;
  int chunkIdx;
  SerializedGroup *persistentGroup;
  char trackName [128];
  int tR7;
  u_short tu3;
  int tp4;
  TrackHeader *tT33;
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

  Track_gSaveSurface = (SaveSurface *)0x0;
  Track_gObjDefs = (Trk_ObjectDef **)0x0;
  sprintf(trackName,"%s",tempName);
  trackFileSize = filesize(tempName);
  uVar6 = 0x404;
  Chunk_lightTable = reservememadr("lighttbl",0x404,0);
  TextureProcess_Init();
  size = trackFileSize + 0x9080;
  InitArtResources();
  TexturesLoadInitial();
  this_00 = __builtin_new(sizeof(SimpleMem));
  loadBuf = reservememadr("Track_mem",size,0);
  this_00->heap = loadBuf;
  this_00->freeMem = loadBuf;
  /* MATCH: retail re-READS the just-stored heap field; cse turns the load into a register
   * copy of the stored value (addu v1,v0,zero) and the freeMem store rides the branch slot. */
  if (this_00->heap == (void *)0x0) {
    size = 0;
  }
  this_00->freeMemSize = size;
  Track_mem = this_00;
  scratchAlloc = (int)(this_00)->FeignAlloc(trackFileSize);
  rootSerGroup = loadfileatadr(trackName,(void *)(scratchAlloc + 0x9080));
  groupBase = (int)((SerializedGroup *)rootSerGroup)->LocateCreateGroupType(0x1f,Track_mem,0);
  Track_header = (TrackHeader *)(groupBase + 4);
  subGroup = (int)((SerializedGroup *)rootSerGroup)->LocateCreateGroupType(0x20,Track_mem,0);
  Chunk_chunkCenters = (coorddef *)(subGroup + 4);
  geomSubGrp = (int)((SerializedGroup *)rootSerGroup)->LocateGroupType(0x23,0);
  {
    struct LightTableData {
      CVECTOR data[0x100];
    };

    *(LightTableData *)Chunk_lightTable = *(LightTableData *)(geomSubGrp + 0x10);
  }
  instSubGrp = (int)((SerializedGroup *)rootSerGroup)->LocateGroupType(0x23,0);
  Chunk_numLight = *(int *)(instSubGrp + 4) - 0x10U >> 2;
  Track_gInViewList = (short (*)[32])(Track_mem)->Alloc(Track_header->chunkCount * 0x48,0);
  Track_gInViewCount = (u_char *)(Track_mem)->Alloc(Track_header->chunkCount,0);
  Track_chunkList = (Track_mem)->Alloc(Track_header->chunkCount * 0x70,0);
  Chunk_Init();
  persistentGroup = ((SerializedGroup *)rootSerGroup)->LocateGroupType(0x21,0);
  chunkGroup = ((SerializedGroup *)rootSerGroup)->LocateGroupType(0x1d,0);
  i = 0;
  tu3 = 0x3ff;
  matOffset = 0;
  chunkIdx = 0;
  while (i < Track_header->chunkCount) {
    chunkDat = (Chunk *)((char *)Track_chunkList + chunkIdx);
    nextChunkGroup = (SerializedGroup *)0x0;
    if (i < Track_header->chunkCount + -1) {
      nextChunkGroup = chunkGroup->LocateNextGroupType(0x1d);
    }
    chunkDat->InstanceGroup(chunkGroup,Track_mem);
    group = chunkGroup->LocateGroupType(4,0);
    count = group->m_num_elements;
    visList = (short *)(group + 1);
    if (0x24 < count) {
      count = 0x24;
    }
    srcDataInd = 0;
    j = 0;
    if (0 < count) {
      short *src;
      short *dest;

      /* MATCH: the block-local header cache occupies $t2; this also shifts the
       * earlier LightTableData movstrsi scratch pool to retail's $t3-$t6. */
      tT33 = Track_header;
      src = visList;
      dest = (short *)(matOffset + (int)Track_gInViewList);

      do {
        u_short entry = (u_short)*src;

        if ((int)(entry & 0x3ff) < tT33->chunkCount) {
          *dest = entry;
          dest = dest + 1;
          j = j + 1;
        }
        srcDataInd = srcDataInd + 1;
        src = src + 1;
      } while (srcDataInd < count);
    }
    *(u_char *)((char *)Track_gInViewCount + i) = (u_char)j;
    if (j < 0x24) {
      short *dest = (short *)(j * 2 + (matOffset + (int)Track_gInViewList));

      do {
        *dest = tu3;
        j = j + 1;
        dest = dest + 1;
      } while (j < 0x24);
    }
    chunkGroup = nextChunkGroup;
    matOffset = matOffset + 0x40;
    chunkIdx = chunkIdx + 0x70;
    i = i + 1;
  }
  Track_InitPersistentData(persistentGroup);
  (Track_mem)->ResizeToFit();
  Track_MakeTrackPathName(".grp");
  gPersistObjDefBoundingSpheres =
       reservememadr("bsphere",gPersistObjDef->m_num_elements << 3 | 4,0);
  CalcObjectBoundingSphere(gPersistObjDef,gPersistObjDefBoundingSpheres);
  ReduceObjectPrecision(gPersistMidgroundObjInst,gPersistObjDef,2);
  InvalidatePersistentCollideBoomObjects(gPersistObjInst,gPersistObjDef);
  Track_gSaveSurface = new SaveSurface(0x30);
  Track_LoadObjectKillData();
  return;
}

/* ---- Track_DeInit__Fv  [TRACK.CPP:1492-1533] SLD-VERIFIED ---- */
void Track_DeInit(void)

{
  /* SYM-CODEGEN-CARRIER: deleteMe -- replacing this cached Track_mem value
   * with direct global expressions compiles to 50 instructions and 15 oracle
   * diffs.  The retained pointer produces retail's 53-instruction saved-
   * register lifetime across purgememadr and __builtin_delete. */
  SimpleMem *deleteMe;
  
  deleteMe = Track_mem;
  if (Track_mem != (SimpleMem *)0x0) {
    purgememadr(Track_mem->heap);
    deleteMe->freeMem = (u_char *)0x0;
    __builtin_delete(deleteMe);
  }
  if (Track_gSaveSurface != (SaveSurface *)0x0) {
    delete Track_gSaveSurface;
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
  char pathName [128];
  
  sprintf(pathName,"%s",Track_MakeTrackPathName(".kil"));
  return (char *)loadfileadrz(pathName,(void *)0x0);
}

/* ---- KillFile_ReadEntry__FPciRiT2  [TRACK.CPP:1732-1736] SLD-VERIFIED ---- */
void KillFile_ReadEntry(char *filePtr,int entryInd,int &chunkInd,int &objectInd)

{
  filePtr += entryInd * 8;
  chunkInd = *(int *)(filePtr + 4);
  objectInd = *(int *)(filePtr + 8);
  return;
}

/* ---- Track_LoadObjectKillData__Fv  [TRACK.CPP:1742-1821] SLD-VERIFIED ---- */
void Track_LoadObjectKillData(void)

{
  char *filePtr;
  int chunkInd;
  int objInd;

  filePtr = KillFile_OpenRead();
  if (filePtr != (char *)0x0) {
    int i;

    i = 0;
    while (i < *(int *)filePtr) {
      Chunk *chunkDat;
      Group *group;

      KillFile_ReadEntry(filePtr,i,chunkInd,objInd);
      chunkDat = Track_chunkList + chunkInd;
      group = chunkDat->objInstanceBuf;
      if (group != (Group *)0x0) {
        int groupElements;

        groupElements = group->m_num_elements;
        if (objInd < groupElements) {
          Trk_SimpleInst *inst;
          int index;

          inst = (Trk_SimpleInst *)(group + 1);
          index = 0;
          while (index < objInd) {
            index = index + 1;
            inst = (Trk_SimpleInst *)((char *)inst + inst->size);
          }

          {
            Group *simGroup;

            simGroup = chunkDat->simObjBuf;
            if (simGroup != (Group *)0x0) {
              Trk_SimObject *simObjs;
              int numElements;
              int j;

              j = 0;
              simObjs = (Trk_SimObject *)(simGroup + 1);
              numElements = simGroup->m_num_elements;
              while (j < numElements) {
                if (Math_DistXZ((coorddef *)&simObjs[j],
                                (coorddef *)&inst->x) < 0x1999) {
                  simObjs[j].type = 0x10;
                }
                j = j + 1;
              }
            }
          }
          inst->type = inst->type | 0x80;
        }
      }
      i = i + 1;
    }
    purgememadr(filePtr);
  }
  return;
}

/* ---- Save  [TRACK.CPP:1831-1850] SLD-VERIFIED ---- */
void SaveSurface::Save(Trk_NewSimQuad *simQuad)

{

  if (((int)*((short *)this) <= (int)((short *)this)[1]) && (simQuad != (Trk_NewSimQuad *)0x0)) {
    *(Trk_NewSimQuad **)(*((short *)this) * 8 + *(int *)(((short *)this) + 2)) = simQuad;
    *(u_char *)(*((short *)this) * 8 + *(int *)(((short *)this) + 2) + 4) = simQuad->surface;
    *((short *)this) = *((short *)this) + 1;
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

SaveSurface::SaveSurface(int numEntries)

{
  fMaxCount = (short)numEntries;
  fCount = 0;
  fStack = (tSaveSurface *)reservememadr("Surface Save",numEntries << 3,0);
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

SaveSurface::~SaveSurface()

{
  purgememadr(fStack);
}

/* ---- RestoreAll  [TRACK.CPP:1871-1879] SLD-VERIFIED ---- */
void SaveSurface::RestoreAll()

{
  int iVar1;
  int i;

  iVar1 = 0;
  if (0 < this->fCount) {
    do {
      (this->fStack[iVar1].fSimQuad)->surface = this->fStack[iVar1].fSurface;
      this->fStack[iVar1].fSimQuad = (Trk_NewSimQuad *)0x0;
      this->fStack[iVar1].fSurface = '\0';
      iVar1 = iVar1 + 1;
    } while (iVar1 < this->fCount);
  }
  this->fCount = 0;
  return;
}

/* end of track.cpp */
