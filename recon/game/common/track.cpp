/* game/psx/track.cpp -- RECONSTRUCTED (NFS4 PSX track load/resources/materials; C++ TU)
 *   29 fns: track init/deinit, art+texture resources, LoadShapesAndMakePmx, material linking,
 *   object bounding spheres, kill data, SaveSurface class. GTE-free. Full SYM-locals applied.
 */
#include "track_types.h"

/* Retail track.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* CC1PLPSX emission law: uninitialized globals are flushed at end-of-file in
 * FIRST-DECLARATION order (an extern declaration counts).  These forward
 * declarations pin retail track.obj's .sdata order 0x8013d4ac..0x8013d4f0
 * ahead of the alphabetical track_externs.h declarations. */
extern short (*Track_gInViewList)[32];
extern u_char *Track_gInViewCount;
extern TrackHeader *Track_header;
extern Chunk *Track_chunkList;
extern Group *gPersistObjDef;
extern Group *gPersistObjInst;
extern Group *gPersistMidgroundObjInst;
extern Group *gPersistObjDefBoundingSpheres;
extern SaveSurface *Track_gSaveSurface;
extern Track_tMaterial *Track_materials;
extern Trk_ObjectDef **Track_gObjDefs;
extern SimpleMem *Track_mem;
extern int gtrackNumber;
extern Group *gObjDefOffsetsGroup;
extern int Track_gControllerCount;
extern Track_tMaterialController *Track_gMatController;
extern int Chunk_numLight;
/* .data: retail Track.obj = gInitialArt @0x8011E158 then Track_gReflectionMaps @0x8011E170
 * (both zero-initialized, deferred); track_externs.h declares them the other way round. */
extern Track_tArtresource gInitialArt;
extern Draw_tPixMap Track_gReflectionMaps[4];

#include "track_externs.h"

/* Track.obj-owned aggregate data (SYM: contiguous 0x8011E158..0x8011E1B0). */
Track_tArtresource gInitialArt;
Draw_tPixMap Track_gReflectionMaps[4];

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


/* ---- Track_SetTrackNumber__Fi  [TRACK.CPP:95-96] full SLD attribution requires native comparison ---- */
#line 93 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_SetTrackNumber(int tracknum)

{
  gtrackNumber = tracknum & 0xf;
}

/* ---- Track_MakeTrackPathName__FPc  [TRACK.CPP:103-110] full SLD attribution requires native comparison ---- */
#line 101 "C:/nfs4/GAME/COMMON/TRACK.CPP"
char * Track_MakeTrackPathName(char *ext)

{

  static char strspc[64];   /* @0x8013e300 STAT (.bss) */


  sprintf(strspc,"%sTr%02d%s",Paths_Paths[6],gtrackNumber,ext);

  return strspc;
}

/* ---- Track_MakeTrackDataPathName__FPc  [TRACK.CPP:114-121] full SLD attribution requires native comparison ---- */
#line 112 "C:/nfs4/GAME/COMMON/TRACK.CPP"
char * Track_MakeTrackDataPathName(char *ext)

{
  static char strspc[64];   /* @0x8013e340 STAT (.bss) */



  sprintf(strspc,"%sTr%02d%s",Paths_Paths[8],gtrackNumber,ext);

  return strspc;
}

/* ---- AllocArtResource__FP18Track_tArtresourcei  [TRACK.CPP:142-151] full SLD attribution requires native comparison ---- */
#line 140 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void AllocArtResource(Track_tArtresource *artRes,int numPmx)

{
  artRes->id = -1;
  artRes->basePmxCount = 0;



  artRes->pPmx = (Draw_tPixMap *)BWAllocMem(numPmx << 4);

  artRes->shapeCount = 0;
  artRes->shapeFile = (char *)0x0;
}

/* ---- InitArtResources__Fv [TRACK.CPP:155-165] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied frame/local/block/absolute word-file/header/end
   contract verified at unchanged whole normal ELF/native CPE.
   No new object, fake use/scope, asm/volatile or output rewrite.
   Literal original source/comment text is not uniquely proved.
   Receipts: build/nc12/track_teardown_source_20261025. */
#line 153 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void InitArtResources(void)

{
  AllocArtResource(&gInitialArt,0x352);








  Track_materials = (Track_tMaterial *)BWAllocMem(0xd48); }

/* ---- DeInitArtResources__Fv [TRACK.CPP:176-192] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied frame/local/block/absolute word-file/header/end
   contract verified at unchanged whole normal ELF/native CPE.
   No new object, fake use/scope, asm/volatile or output rewrite.
   Literal original source/comment text is not uniquely proved.
   Receipts: build/nc12/track_teardown_source_20261025. */
#line 174 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void DeInitArtResources(void)

{



  gInitialArt.pPmx = (Draw_tPixMap *)0x0;











  Chunk_DeInit(); }

/* ---- LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii [TRACK.CPP:225-359] ----
 * All211 word/file tags,19 regions and header/end match retail; supplied
 * locals retain their complete owners. This is not a full declaration seal:
 * emptyPalNum remains one unsupported INT REG record. Direct literal stores
 * still exchange two constant loads at211/211, including after this source
 * order/layout correction. Failed ordinary loop/address/root controls are
 * isolated in build/nc12/track_palette_source_20261024, not adopted.
 * SourceRecoveryUnresolved: multiPalCount is the palette-entry count, advancing
 * only for ! shapes, independently of shape i and mipmapcounter. Its semantic
 * spelling and whether the original source used this named count, a pointer
 * or a macro-produced induction value are not supplied by optimized SYM.
 * No distinct original-object necessity is claimed from strength reduction.
 * emptyPalNum's original producer remains unresolved too, not exempted by the
 * failed literal controls. The SimpleMem literal/header type order is open.
 * Retail source initializes recolor_flag231 BEFORE cluttype235; stock still
 * schedules the clut load first. No new asm/volatile, fake use/scope or output
 * rewrite is introduced. Literal original macro/comment text is unproved. */
#line 223 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void LoadShapesAndMakePmx(char *shapefile,Draw_tPixMap *pmxList,int loadFlags,int x,int y)

{
  int i; shapetbl *shape; Draw_tPixMap *pPmx; int recolor_flag; int cluttype; int mipmapcounter; int multiPalCount;

  pPmx = pmxList;


  recolor_flag = 0;



  cluttype = -1;
  gTempMipMapInfo = (Track_MipMap *)0x0;

  if (TrackSpec_gSpec.fogstate != 0)
  {
    cluttype = -3;

    gTempMipMapInfo = reservememadr("mipmapinf",0x180,0x10);

    for (int cnt = 0; cnt < 0x20; cnt = cnt + 1) { *(int *)gTempMipMapInfo[cnt].code = -1; }
  }


  gTempMultiPalInfo = reservememadr("mpalinfo",0x400,0x10);
  { int pcnt; int emptyPalNum;
    emptyPalNum = -1; for (pcnt = 0x7f; pcnt >= 0; pcnt--) { gTempMultiPalInfo[pcnt].palnum = emptyPalNum; }
  }
  DrawSync(0);


  mipmapcounter = 0;



  multiPalCount = 0;
  for (i = 0; i < shapecount(shapefile); i++) {
    char name[4]; int tempclut;

    shape = (shapetbl *)shapepointer(shapefile,i);
    if (shape == (shapetbl *)0x0) continue;



    shapename(shapefile,i,name);


    tempclut = cluttype;
    if ((i < 0xc) || ((shape->type & 3) == 1) || (name[0] == '#')) {
      tempclut = -1;
    }
    Texture_LoadPmx((char *)0x0,(char *)shape,loadFlags | recolor_flag | 2,x,y,tempclut,tempclut,pPmx);


    if (name[0] == '!')
    {
      int palnum;

      gTempMultiPalInfo[multiPalCount].charcode[0] = name[1];
      gTempMultiPalInfo[multiPalCount].charcode[1] = name[2];

      palnum = atoi(name + 3);
      gTempMultiPalInfo[multiPalCount].palnum = palnum;



      gTempMultiPalInfo[multiPalCount].actualshapeindex = i;

      if (palnum != 0)
      {

        for (int j = 0; j < 0x80; j = j + 1) {


          if ((gTempMultiPalInfo[j].charcode[0] == (u_char)name[1]) && (gTempMultiPalInfo[j].charcode[1] == (u_char)name[2]) && (gTempMultiPalInfo[j].palnum == 0)) {


            gTempMultiPalInfo[multiPalCount].origshapeindex = gTempMultiPalInfo[j].origshapeindex;
            break;
          }
        }
      }
      else { gTempMultiPalInfo[multiPalCount].origshapeindex = i; }

      multiPalCount = multiPalCount + 1;
    }












    if ((TrackSpec_gSpec.fogstate != 0) && (name[0] == 'Z'))
    {
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
      else if (name[1] == 'Z')
      {

        for (int j = 0; j < 0x20; j = j + 1) {


          if ((icode[0] == gTempMipMapInfo[j].code[0]) && (icode[1] == gTempMipMapInfo[j].code[1])) {


            gTempMipMapInfo[j].mipMapIndex = i;
            break;
          }
        }
      } }

    pPmx = pPmx + 1;
  } }

/* ---- LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii [TRACK.CPP:375-394] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied frame/local/block/absolute word-file/header/end
   contract verified at unchanged whole normal ELF/native CPE. Env-map i initializes from0, not recolor_flag.
   No new object, fake use/scope, asm/volatile or output rewrite.
   Literal original source/comment text is not uniquely proved.
   Receipts: build/nc12/track_teardown_source_20261025. */
#line 373 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void LoadShapesAndMakePmx_EnvMap(char *shapefile,Draw_tPixMap *pmxList,int x,int y)

{
  int i;
  shapetbl *shape;
  Draw_tPixMap *pPmx = pmxList;


  int recolor_flag = 0;





  for (i = 0; i < (int)shapecount(shapefile); i++) {

    shape = (shapetbl *)shapepointer(shapefile,i);
    if (shape != (shapetbl *)0x0) {

      Texture_LoadPmx((char *)0x0,(char *)shape,recolor_flag | 0x42,x,y,-1,-1,pPmx);
      pPmx = pPmx + 1;
} } }

/* ---- TexturesLoadInitial__Fv [TRACK.CPP:405-465] supplied SYM/SLD contract exact; literal producer identity remains open ---- */
/* MATCH: retail SYM exposes only `success` ($v0) and the scoped `tmpShapes`
   ($s0); branch-local calls preserve the shared path-builder tail. */
/* 2026-10-25 coupled source recovery: success holds the actual shape-load
   result, not the filename. Real palette initialization/file acquisition in
   the shapecount argument replaces the synthetic zero-count loop and i.
   All107 word/file tags,10 block records,2 local owners and header405/end465
   match, with whole normal ELF/native CPE unchanged. No new object, guessed
   helper name, dummy use/test, asm, volatile or empty-region padding.
   SourceRecoveryUnresolved: the original inline/macro/header identity for
   this receiver-free argument-work producer is not supplied by anonymous
   retail regions. Its expanded spelling is not a unique-original-text claim.
   Receipts: build/nc12/track_textures_source_20261025. */
#line 403 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void TexturesLoadInitial(void)

{
  int success;



  if (GameSetup_gData.Time != 0) { if (GameSetup_gData.Weather != 0) {
      success = (int)(gInitialArt.shapeFile = (char *)loadshapeadr(Track_MakeTrackPathName("S0.psh"),(void *)0x0));
    } else {
      success = (int)(gInitialArt.shapeFile = (char *)loadshapeadr(Track_MakeTrackPathName("N0.psh"),(void *)0x0));
  } } else if (GameSetup_gData.Weather != 0) {
    success = (int)(gInitialArt.shapeFile = (char *)loadshapeadr(Track_MakeTrackPathName("W0.psh"),(void *)0x0));
  } else {
    success = (int)(gInitialArt.shapeFile = (char *)loadshapeadr(Track_MakeTrackPathName("0.psh"),(void *)0x0));
  }
  if (success)
  {
    gInitialArt.shapeCount = (int)shapecount((
    { Texture_ResetPaletteSharing();

      gInitialArt.shapeFile; }));

    LoadShapesAndMakePmx(gInitialArt.shapeFile,gInitialArt.pPmx,0x40,0x100,0);




    gInitialArt.pPmx[gInitialArt.shapeCount] = *gSpikeBeltPixmap;
    gInitialArt.shapeCount = gInitialArt.shapeCount + 1;



    gInitialArt.pmxCount = gInitialArt.shapeCount;
    gInitialArt.basePmxCount = gInitialArt.shapeCount;
    purgememadr(gInitialArt.shapeFile);
  }

  else {

    for (;;) { } }




  Hrz_GetHorizonPixMap(gInitialArt.pPmx);
  {
    char *tmpShapes;




    tmpShapes = (char *)loadshapeadr(Track_MakeTrackPathName("r.psh"),(void *)0x0); if (tmpShapes != (char *)0x0) {





      Texture_ResetPaletteSharing();

      LoadShapesAndMakePmx_EnvMap(tmpShapes,Track_gReflectionMaps,0x3e0,0);

      purgememadr(tmpShapes); } } }

/* ---- Track_AnimateTextures__Fv [TRACK.CPP:491-517] covered native/SYM/absolute SLD PASS; original offset spellings remain open ---- */
/* SourceRecoveryUnresolved: uvOffset/frameOffset are semantic names for the
 * real per-arm single-evaluation offsets. Optimized SYM does not supply their
 * original identifiers or primitive spelling; int/short frame stages both
 * reproduce the retail code. No generic carrier-necessity exemption applies.
 * The supplied controlPtr/controlCount/pmx and all covered native/SLD facts
 * agree. Five reconstruction pointer/constant captures and the goto are gone.
 * Receipts: build/nc12/track_animation_source_20261024. */
#line 489 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_AnimateTextures(void)

{
  Track_tMaterialController *controlPtr = Track_gMatController;
  int controlCount = Track_gControllerCount;

  while (--controlCount != -1) {

    if (controlPtr->type == 0x80)
    { Draw_tPixMap *pmx;
      char uvOffset = (char)((simGlobal.gameTicks / (int)controlPtr->interval) % (int)controlPtr->textureMax);
      pmx = gInitialArt.pPmx + controlPtr->matPtr->pmxIndex;

      pmx->v0 = controlPtr->uv0 + uvOffset;
      pmx->v1 = controlPtr->uv1 + uvOffset;
      pmx->v2 = controlPtr->uv2 + uvOffset;
      pmx->v3 = controlPtr->uv3 + uvOffset;
    }

    else { if (controlPtr->type == 4)
    {

      int frameOffset = (simGlobal.gameTicks / (int)controlPtr->interval) % (int)(u_char)controlPtr->textureCount;

      controlPtr->matPtr->pmxIndex = controlPtr->pmxIndex + frameOffset;
    } }


    controlPtr = controlPtr + 1; } return; }

/* ---- Track_GetProperMultiPalShapeIndex__Fii  [TRACK.CPP:525-532] full SLD attribution requires native comparison ---- */
#line 523 "C:/nfs4/GAME/COMMON/TRACK.CPP"
int Track_GetProperMultiPalShapeIndex(int shapeindex,int paletteindex)

{

  for (int t = 0; t < 0x80; t++) {

    if (gTempMultiPalInfo[t].origshapeindex == shapeindex && gTempMultiPalInfo[t].palnum == paletteindex) {
      return (int)gTempMultiPalInfo[t].actualshapeindex; }
  }
  return shapeindex;
}

/* ---- Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1 [TRACK.CPP:538-571] covered native/SYM/absolute SLD PASS; original text unproved ---- */
#line 536 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_ProcessFlipAndUVFlags(int uvFlag,Draw_tPixMap *inputPmx,Draw_tPixMap *outputPmx)

{

  int pmxProcessCount = 0;

  Draw_tPixMap newPmx [4];

  newPmx[0] = *inputPmx;

  if ((uvFlag & 0x10U) != 0) {

    Texture_CloneUVPmx(&newPmx[0],0,&newPmx[1]);
    pmxProcessCount = 1;
  }

  if ((uvFlag & 0x40U) != 0) {

    Texture_CloneUVPmx(&newPmx[pmxProcessCount],1,&newPmx[pmxProcessCount + 1]);
    pmxProcessCount = pmxProcessCount + 1;
  }

  if ((uvFlag & 0xeU) != 0) {


    if ((uvFlag & 2U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],2,&newPmx[pmxProcessCount + 1]); }
    else if ((uvFlag & 4U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],3,&newPmx[pmxProcessCount + 1]); }
    else if ((uvFlag & 8U) != 0) {
      Texture_CloneUVPmx(&newPmx[pmxProcessCount],4,&newPmx[pmxProcessCount + 1]); }
    pmxProcessCount = pmxProcessCount + 1;
  }


  *outputPmx = newPmx[pmxProcessCount]; return; }

/* ---- Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource [TRACK.CPP:577-626] covered native/SYM/absolute SLD PASS; original text unproved ---- */
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
   
   Matching toolchain: PsyQ SDK 4.3, CC1PLPSX GCC 2.8.0, ASPSX 2.77.
   Build date: 1999-02-22.
   See PROJECT_AUDIT_2026-05-05.md and SESSION_2026-05-07_SUMMARY.md.
   
   [Source review 2026-10-23] SYM supplies all three parameters and the actual animCount,
   originalPmx and two arm-local shapeIndex records. This binds one serialized material to
   its output entry/art resource. The loop processes at least one shape, using textureCount
   for further animation shapes. The UV arm copies an atlas pixmap into originalPmx, then
   processes it into art->pPmx[art->pmxCount] and advances that real destination count.
   The first frame supplies outputMat->pmxIndex; the plain arm uses the resolved shape index.
   Earlier animFrame/anim_iter/shapeData_p and rollback descriptions were unsupported;
   they are not supplied fields/locals or operations in this body. Original text remains open.
   
   [2026-09-28] Two real shapeIndex declarations belong to separate UV arms;
   originalPmx belongs only to the processing arm. Root animCount and the
   for binding now reproduce all six native scopes. No generic-name exemption;
   literal original source spelling remains unsealed; covered SLD is exact. */

#line 575 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_AssociateSingleMaterial(Trk_Material *inputMat,Track_tMaterial *outputMat,Track_tArtresource *art)

{
  int animCount;


  outputMat->flag = inputMat->flag;




  for (animCount = 0; animCount < 1 || animCount < (int)(u_int)(u_char)inputMat->textureCount; animCount++) {






    if ((inputMat->uvFlag & 0x5e) != 0)
    {
      Draw_tPixMap originalPmx;
      int shapeIndex;
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
      int shapeIndex; shapeIndex = (int)inputMat->shapeIndex;
      if ((inputMat->flag & 2) != 0) {

        shapeIndex = Track_GetProperMultiPalShapeIndex(shapeIndex,(u_int)inputMat->interval);
      }


      if (animCount == 0) {
        outputMat->pmxIndex = (short)shapeIndex;
      }
    } } return; }

/* ---- Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial [TRACK.CPP:688-848] covered native/SYM/absolute SLD PASS;241 words unchanged ---- */
/* Keep the supplied UCHAR flag/uvFlag fields and the original packed LHU read;
 * the exact original macro/cast spelling is not supplied. length/sizeof retains
 * the unsigned size arithmetic visible in retail's multiply-high division.
 * Source reset pairs707/710 and847/848 are not their scheduled store order.
 * All15 supplied owner tuples and21 regions agree; no source capture is added.
 * Receipts: build/nc12/track_link_material_sld_20261024. */
#line 686 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_LinkMaterials(SerializedGroup *group,int length,Track_tMaterial *matList)

{
  Trk_Material *mats;

  if (group != (SerializedGroup *)0x0) {
    int matCount; int i; int controlIndex;



    matCount = length / sizeof(Trk_Material);




    mats = (Trk_Material *)group->GetData();





    gInitialArt.pmxCount = gInitialArt.basePmxCount;


    Track_gControllerCount = 0;


    for (i = 0; i < matCount; i = i + 1) {

      if ((*(u_short *)&mats[i].flag & 0x84) != 0) {
        Track_gControllerCount = Track_gControllerCount + 1;
      } }





    if (Track_gControllerCount != 0) {




      Track_gMatController = (Track_tMaterialController *)BWAllocMem(Track_gControllerCount << 4);
    }



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

      else if ((mats[i].flag & 0x80) != 0)
      {
        Draw_tPixMap *pmx; int d;
        Track_gMatController[controlIndex].type = mats[i].flag;

        if (mats[i].interval == 0) { mats[i].interval = 1; }
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
        if (d < 0) { d = -d; }
        Track_gMatController[controlIndex].textureMax = d + 1;

        controlIndex = controlIndex + 1;

      }

      if (TrackSpec_gSpec.fogstate != 0)
      {

        for (int mm = 0; mm < 0x20; mm = mm + 1) {


          if (*(int *)gTempMipMapInfo[mm].code != -1)
          {
            int shapeIndex; shapeIndex = gTempMipMapInfo[mm].shapeParentIndex;
            if (shapeIndex == mats[i].shapeIndex)
            {
              int mipmap_offset; mipmap_offset = gTempMipMapInfo[mm].mipMapIndex;

              matList[i].flag = matList[i].flag | 8;
              mipmap_offset = mipmap_offset - shapeIndex;
              if (mats[i].shapeIndex != matList[i].pmxIndex)
              {
                Draw_tPixMap originalPmx; int shapeIndex;

                shapeIndex = mats[i].shapeIndex + mipmap_offset;

                originalPmx = gInitialArt.pPmx[shapeIndex];

                Track_ProcessFlipAndUVFlags(mats[i].uvFlag,&originalPmx,gInitialArt.pPmx + gInitialArt.pmxCount);

                gInitialArt.pmxCount = gInitialArt.pmxCount + 1;

                matList[i].mipmap_offset = 1;
              }
              else {
                matList[i].mipmap_offset = mipmap_offset; }
            }
          }


        }

      }
    }


    if (gTempMipMapInfo != (Track_MipMap *)0x0) {
      purgememadr(gTempMipMapInfo); }


    purgememadr(gTempMultiPalInfo);






    gInitialArt.pmxCount = gInitialArt.shapeCount;
    gInitialArt.shapeFile = (char *)0x0; } return; }

/* ---- ReduceObjectPrecision__FP5GroupT0i [TRACK.CPP:963-1004] covered native/SYM/absolute SLD PASS;40 words unchanged ---- */
/* SourceRecoveryUnresolved: x/y/z semantically name the actual shifted16-bit
 * component results. Their original identifiers/macro syntax are absent from
 * optimized SYM. Computed short stages match the three load/shift source lines;
 * int/long controls retain unprovided debug locals. No const/volatile hiding.
 * The inline receiver is the payload getter, not the count read; preserve
 * count968 before GetData969. All9 supplied tuples/eight regions agree.
 * Receipts: build/nc12/track_reduce_source_20261024. */
#line 961 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void ReduceObjectPrecision(Group *instGroup,Group *defGroup,int bits)

{
  int count; Trk_SimpleInst *inst;
  if (instGroup == (Group *)0x0) return;


  count = instGroup->m_num_elements;
  inst = (Trk_SimpleInst *)instGroup->GetData();

  while (--count != -1) {

    if (defGroup != (Group *)0x0)
    {

      Trk_ObjectDef *objDef = Track_gObjDefs[inst->pad];

      {
        int count; CCOORD16 *pts;



        pts = (CCOORD16 *)(objDef + 1);
        count = objDef->vertexCount;

        while (--count != -1) {



          short x = pts->x >> bits;
          short y = pts->y >> bits;
          short z = pts->z >> bits;

          pts->x = x;
          pts->y = y;
          pts->z = z;

          pts++; }
      }
    }

    inst = (Trk_SimpleInst *)((int)&inst->size + (int)inst->size);
  }
}

/* ---- InvalidatePersistentCollideBoomObjects__FP5GroupT0 [TRACK.CPP:1012-1026] covered native/SYM/absolute SLD PASS;27 words unchanged ---- */
/* Existing receiver evidence identifies a payload expansion after the actual
 * direct count read1017, not a uniquely named count accessor. Getter spelling
 * is not supplied. Receipts: build/nc12/track_sphere_sld_20261024. */
#line 1010 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void InvalidatePersistentCollideBoomObjects(Group *instGroup,Group *defGroup)

{
  int count; Trk_SimpleInst *inst;
  if ((instGroup == (Group *)0x0) || (defGroup == (Group *)0x0)) return;


  count = instGroup->m_num_elements;
  inst = (Trk_SimpleInst *)instGroup->GetData();

  while (--count != -1) {

    if (Track_gObjDefs[inst->pad]->id != -1) {
      inst->type = 0;
    } inst = (Trk_SimpleInst *)((int)inst + (int)inst->size); }

}

/* ---- CalcObjectBoundingSphere__FP5GroupT0 [TRACK.CPP:1064-1125] covered native/SYM/absolute SLD PASS;152 words unchanged ---- */
/* Source point/count setup1083/1084, count/radius1103/1104 and group-count/
 * output-pointer advance1123/1124 precede scheduling. Keep all supplied names,
 * the real centroid/radius work region and the single source diff expression;
 * no unique original macro text is claimed. No new source capture is needed.
 * Receipts: build/nc12/track_sphere_sld_20261024. */
#line 1062 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void CalcObjectBoundingSphere(Group *defGroup,Group *boundingSphereGroup)

{
  Trk_ObjectDef *objDef;
  tBoundingSphere *bSphere;
  int objCount;

  bSphere = (tBoundingSphere *)boundingSphereGroup->GetData();
  objCount = defGroup->GetNumElements();

  for (int i = 0; i < objCount; i = i + 1) {
    int ptCount;
    CCOORD16 *pts;
    coorddef cp;
    int radius;


    objDef = Track_gObjDefs[i];



    pts = (CCOORD16 *)(objDef + 1);
    ptCount = objDef->vertexCount;
    cp.x = cp.y = cp.z = 0;

    while (--ptCount != -1) {

      cp.x = cp.x + pts->x;
      cp.y = cp.y + pts->y;
      cp.z = cp.z + pts->z;

      pts = pts + 1; }

    { cp.x = cp.x / objDef->vertexCount;
      cp.y = cp.y / objDef->vertexCount;
      cp.z = cp.z / objDef->vertexCount;




      pts = (CCOORD16 *)(objDef + 1);
      ptCount = objDef->vertexCount;
      radius = 0;
      while (--ptCount != -1) {
        int diff;
        diff = (((cp.x - pts->x) >> 6) * ((cp.x - pts->x) >> 6)) + (((cp.y - pts->y) >> 6) * ((cp.y - pts->y) >> 6)) + (((cp.z - pts->z) >> 6) * ((cp.z - pts->z) >> 6));
        if (radius < diff) {
          radius = diff; }

        pts = pts + 1; }

    }


    bSphere->cp.x = (short)cp.x;
    bSphere->cp.y = (short)cp.y;
    bSphere->cp.z = (short)cp.z;
    bSphere->radius = (short)((u_int)fixedsqrt(radius << 10) >> 7);



    boundingSphereGroup->m_num_elements = boundingSphereGroup->m_num_elements + 1;
    bSphere = bSphere + 1;
  } return; }

/* ---- CalcObjDefPtrs__Fv [retail TRACK.CPP:1179-1188] ----
 * The single offset cursor, one-line loop close and separate final pointer
 * assignment reproduce all 25 relative SLD tags, native scopes/locals and
 * the retail function-end line delta. Literal local spellings remain inferred. */
#line 1177 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void CalcObjDefPtrs(void)

{
  /* One typed view of the offset payload replaces three repeated inline
   * GetData expansions in the loop. The semantic name is inferred; GCC
   * optimizes it away, matching retail's local and scope records. */
  int *offsets = (int *)gObjDefOffsetsGroup->GetData();
  offsets[0] = (int)gPersistObjDef->GetData();
  for (int i = 1; i < gPersistObjDef->GetNumElements(); i = i + 1) {
    offsets[i] = offsets[i - 1] + offsets[i]; }
  Trk_ObjectDef **objDefs = (Trk_ObjectDef **)gObjDefOffsetsGroup->GetData();
  Track_gObjDefs = objDefs; }

/* ---- Track_InitPersistentData__FP15SerializedGroup [TRACK.CPP:1212-1292] ----
 * Historical 2026-10-24 receipt; the diagnostics follow-up below supersedes
 * its seven-region/tail backlog, not its original-literal-text uncertainty.
 * The actual material-call case work owns the supplied inline receiver at
 * depth7/path[0,1,0,0,0,0,0], not the old depth6. All6 supplied complete local
 * tuples now agree, at unchanged119 words/whole ELF/native CPE. The case's
 * declaring block ends before its switch-level break.
 * Partial SLD/source recovery:109/119 word/file tags agree;15 native regions
 * versus22 supplied. Seven real source producers remain unidentified around
 * case8/default. Ten epilogue tags/end remain1290 versus1292. An explicit
 * final return matches tags but adds a NON-retail+436 cleanup region, so it
 * is rejected. Split call punctuation instead moves two real call tags wrong.
 * No fake scope/empty helper is inserted to conceal those missing producers.
 * No new object, asm/volatile, qualifier or output rewrite is introduced.
 * Receipts: build/nc12/track_persistent_source_20261024. Original macro/getter
 * text and the complete function source/SLD contract remain open. */
/* 2026-10-25 persistent diagnostics/control source recovery: mobile raw
   bytes confirm the two elements-count prints, actual Group count getter,
   format bytes, offsets-case break and final Done persist print. Disabled
   logging arguments recover the missing inline regions. The real case break
   and for-owned counter recover the final region/statement endpoint split.
   All119 word/file tags,44 block records,6 local-owner tuples and frame/
   header1212/end1292 agree, with normal ELF/native CPE unchanged. No dummy
   variable/test, invented helper, artificial return/scope, asm or volatile.
   SourceRecoveryUnresolved: original PSX disabled-print macro/header identity
   is not uniquely supplied. This function-local printf expansion records the
   release behavior, not a libc/SDK ABI change or unique original header text.
   Receipts: build/nc12/track_persistent_source_20261025. */
#define printf (void)
#line 1210 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_InitPersistentData(SerializedGroup *perGroup)

{
  SerializedGroup *persistentGroups[perGroup->m_num_elements]; int count;



  gObjDefOffsetsGroup = (Group *)0x0;
  { int i;

    for (i = 0; i < perGroup->m_num_elements; i = i + 1) {
      persistentGroups[i] = perGroup->LocateGroupNum(i); }
  }
  perGroup->LocateGroupType(8,0);
  count =
  perGroup->m_num_elements;



  for (int i = 0; i < count; i = i + 1)
  {
    switch (persistentGroups[i]->m_type)
    {

      case 2: {
        Track_LinkMaterials(persistentGroups[i],persistentGroups[i]->GetDataLength(),
        Track_materials);






      }
      break;


      case 0xf:
      BWorldSm_Init(persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem));


      break;


      case 0x24:
      gPersistMidgroundObjInst = persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);


      break;


      case 7:
      gPersistObjInst = persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);


      break;

      case 8:
      {
        gPersistObjDef = persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem); printf("gPersistObjDef(%x) elements(%d)\n",gPersistObjDef,gPersistObjDef->GetNumElements());

      }
      break;


      case 0x26: {
        gObjDefOffsetsGroup = persistentGroups[i]->CreateLiteGroup(persistentGroups[i],Track_mem);
        printf("gObjDefOffsetsGroup(%x) elements(%d)\n",gObjDefOffsetsGroup,gObjDefOffsetsGroup->GetNumElements());
      }
      break;
      default:
      printf("Unrecognized group!!!!!\n");

      break;
    }
  }

  if (gObjDefOffsetsGroup != (Group *)0x0) {


    CalcObjDefPtrs();
  } else printf("ERROR!!!!!! misssing object def offsets.\n");
  printf("Done persist\n");
}
#undef printf

/* ---- Track_Init__FPc [TRACK.CPP:1312-1475] covered native locals/regions/absolute SLD PASS; literal source spelling not certified ---- */
/* Real SimpleMem construction below owns the supplied inline size parameter.
     No this_00/loadBuf source alias or mirrored caller-size value is retained.
     Receipt: build/nc12/simplemem_ctor_restore_20261023. */
/* A real for-owned i plus the literal fill removes the old tu3 capture.
     The isolated counter change was two differences; repricing the mask on
     that basin preserves the entire normal ELF without a replacement object.
     Receipt: build/nc12/track_init_getters_20261023. */
/* Typed output indexing then removes the old header snapshot too. The
     earlier direct-read failure applied to a different counter/cursor shape;
     no replacement alias or instruction-level device is needed here.
     Receipt: build/nc12/track_init_getters_20261023. */
/* The real counter scopes make typed destination indexing byte-exact.
         Both old cursor declarations and the header snapshot are unnecessary.
         Receipt: build/nc12/track_init_getters_20261023. */
/* The staged payload lookup and standard copy follow retail1363/1365.
 * lightData is a semantic name for the optimizer-elided payload pointer; its
 * original identifier is not supplied by SYM. No const/fence or fake use is
 * added. Proof: build/nc12/track_init_layout_20261023. */
#line 1310 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_Init(char *tempName)

{
  char trackName [128]; SerializedGroup * trackGroup; SerializedGroup * chunkGroup;
  int trackFileSize; SerializedGroup *persistentGroup;

  Track_gSaveSurface = (SaveSurface *)0x0;
  Track_gObjDefs = (Trk_ObjectDef **)0x0;

  sprintf(trackName,"%s",tempName);
  trackFileSize = filesize(tempName);






  Chunk_lightTable = reservememadr("lighttbl",0x404,0);


  TextureProcess_Init();
  InitArtResources();
  TexturesLoadInitial();


  Track_mem = new SimpleMem(trackFileSize + 0x9080,"Track_mem");
  trackGroup = (SerializedGroup *)loadfileatadr(


      trackName,(void *)((int)Track_mem->FeignAlloc(trackFileSize) + 0x9080));









  Track_header = (TrackHeader *)trackGroup->LocateCreateGroupType(0x1f,Track_mem,0)->GetData();








  Chunk_chunkCenters =
      (coorddef *)trackGroup->LocateCreateGroupType(0x20,Track_mem,0)->GetData();



  char *lightData = (char *)trackGroup->LocateGroupType(0x23,0)->GetData();

  memcpy(Chunk_lightTable,lightData,sizeof(*Chunk_lightTable) * 0x100);
  Chunk_numLight =
      trackGroup->LocateGroupType(0x23,0)->GetDataLength() / sizeof(*Chunk_lightTable);









  Track_gInViewList = (short (*)[32])(Track_mem)->Alloc(Track_header->chunkCount * 0x48,0);
  Track_gInViewCount = (u_char *)(Track_mem)->Alloc(Track_header->chunkCount,0);


  Track_chunkList = (Track_mem)->Alloc(Track_header->chunkCount * 0x70,0);

  Chunk_Init();


  persistentGroup = trackGroup->LocateGroupType(0x21,0);




  chunkGroup = trackGroup->LocateGroupType(0x1d,0);


  for (int i = 0; i < Track_header->chunkCount; i = i + 1) {
    Chunk *chunkDat; SerializedGroup *nextChunkGroup; SerializedGroup *group; short *visList; int count;



    chunkDat = Track_chunkList + i;

    nextChunkGroup = (SerializedGroup *)0x0;
    if (i < Track_header->chunkCount + -1) {
      nextChunkGroup = chunkGroup->LocateNextGroupType(0x1d);
    }









    chunkDat->InstanceGroup(chunkGroup,Track_mem);






    group =
      chunkGroup->LocateGroupType(4,0);

    count = group->m_num_elements;
    visList = (short *)group->GetData();
    if (0x24 < count) {


      count = 0x24; } { int srcDataInd; int j;
    srcDataInd = 0;
    j = 0;



    if (0 < count) { do {


        if ((int)((u_short)visList[srcDataInd] & 0x3ff) < Track_header->chunkCount) {
          Track_gInViewList[i][j] = visList[srcDataInd]; j = j + 1; }
        srcDataInd = srcDataInd + 1; } while (srcDataInd < count); }

    *(u_char *)((char *)Track_gInViewCount + i) = (u_char)j;




    if (j < 0x24) { do {
        Track_gInViewList[i][j] = 0x3ff; j = j + 1; } while (j < 0x24); }
    }



    chunkGroup = nextChunkGroup;
  }


  Track_InitPersistentData(persistentGroup);

  (Track_mem)->ResizeToFit();
  Track_MakeTrackPathName(".grp");


  gPersistObjDefBoundingSpheres =
       reservememadr("bsphere",gPersistObjDef->GetNumElements() << 3 | 4,0);
  CalcObjectBoundingSphere(gPersistObjDef,gPersistObjDefBoundingSpheres);

  ReduceObjectPrecision(gPersistMidgroundObjInst,gPersistObjDef,2);

  InvalidatePersistentCollideBoomObjects(gPersistObjInst,gPersistObjDef);

  Track_gSaveSurface = new SaveSurface(0x30);



  Track_LoadObjectKillData(); return;
}

/* ---- Track_DeInit__Fv [TRACK.CPP:1492-1533] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied frame/local/block/absolute word-file/header/end
   contract verified at unchanged whole normal ELF/native CPE.
   No new object, fake use/scope, asm/volatile or output rewrite.
   Literal original source/comment text is not uniquely proved.
   Receipts: build/nc12/track_teardown_source_20261025. */
#line 1490 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_DeInit(void)

{
  delete Track_mem;


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
    purgememadr(gPersistObjDefBoundingSpheres); }
  gPersistObjDefBoundingSpheres = (Group *)0x0;

  gPersistMidgroundObjInst = (Group *)0x0;
  gPersistObjInst = (Group *)0x0;
  gPersistObjDef = (Group *)0x0; return; }

/* ---- Track_AnimateTrackLighting__Fv [TRACK.CPP:1537-1544] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied frame/local/block/absolute word-file/header/end
   contract verified at unchanged whole normal ELF/native CPE.
   No new object, fake use/scope, asm/volatile or output rewrite.
   Literal original source/comment text is not uniquely proved.
   Receipts: build/nc12/track_teardown_source_20261025. */
#line 1535 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_AnimateTrackLighting(void)

{






}

/* ---- KillFile_OpenRead__Fv  [TRACK.CPP:1720-1726] full SLD attribution requires native comparison ---- */
#line 1718 "C:/nfs4/GAME/COMMON/TRACK.CPP"
char * KillFile_OpenRead(void)

{
  char pathName [128];
  
  sprintf(pathName,"%s",Track_MakeTrackPathName(".kil"));


  return (char *)loadfileadrz(pathName,(void *)0x0);
}

/* ---- KillFile_ReadEntry__FPciRiT2  [TRACK.CPP:1732-1736] full SLD attribution requires native comparison ---- */
#line 1730 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void KillFile_ReadEntry(char *filePtr,int entryInd,int &chunkInd,int &objectInd)

{
  filePtr += entryInd * 8;
  chunkInd =
      *(int *)(filePtr + 4);
  objectInd = *(int *)(filePtr + 8);
}

/* ---- Track_LoadObjectKillData__Fv [retail TRACK.CPP:1742-1821; supplied SYM/SLD contract exact] ---- */
/* 2026-10-25 loader source/layout:86 absolute word/file tags,16 complete
   local-owner tuples,38 block records and header1742/end1821 match retail.
   The actual pointer advance precedes index increment; a real null-group
   else/continue preserves distinct arm/selection endpoints. No new object,
   asm, volatile, placeholder or artificial scope. Historical notes follow;
   literal original macro/comment text is not uniquely proved.
   Receipts: build/nc12/track_kill_source_20261025. */
/* Retail orders the depth6 GetData receiver before the depth7
         GetNumElements bounds-check receiver. The invalid-index continue
         avoids an extra owning if level for index/simGroup and descendants.
         All19 native scopes match; original text/full SLD remain open. */

/* SYM-INLINE-THIS: GetData
             * SYM-INLINE-THIS: GetNumElements
             * Retail SLD line 44 records both inline receivers together at
             * 0x800bae84, matching these two Group member calls. */
#line 1740 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void Track_LoadObjectKillData(void)

{
  char *filePtr; int chunkInd; int objInd;



  filePtr = KillFile_OpenRead();
  if (filePtr == (char *)0x0) return;




  for (int i = 0; i < *(int *)filePtr; i = i + 1) {
    Chunk *chunkDat; Group *group;
    KillFile_ReadEntry(filePtr,i,chunkInd,objInd);





    chunkDat = Track_chunkList + chunkInd;

    group = chunkDat->objInstanceBuf;

    if (group != (Group *)0x0)
    {
      Trk_SimpleInst *inst;
      inst = (Trk_SimpleInst *)group->GetData();
      if (objInd >= group->GetNumElements()) continue;
      { int index;





        index = 0;
        while (index < objInd) {

          inst = (Trk_SimpleInst *)((char *)inst + inst->size);
          index = index + 1;
      } }

      {
        Group *simGroup; simGroup = chunkDat->simObjBuf;
        if (simGroup != (Group *)0x0) {
          Trk_SimObject *simObjs; int numElements;

          simObjs = (Trk_SimObject *)simGroup->GetData(); numElements = simGroup->GetNumElements();

          { int j;

            j = 0;
            while (j < numElements) {

              if (Math_DistXZ((coorddef *)&simObjs[j], (coorddef *)&inst->x) < 0x1999) {


                simObjs[j].type = 0x10;
              }


              j = j + 1;
      } } } }






      inst->type = inst->type | 0x80;
    }


    else continue;


  }

  purgememadr(filePtr);
  return;
}

/* ---- Save [TRACK.CPP:1831-1850] supplied SYM/SLD contract exact ---- */
/* 2026-10-25: supplied fCount/fMaxCount/fStack and tSaveSurface members
   replace raw this-relative short/int/byte casts. Preserve retail's actual
   equality boundary: reject only fCount > fMaxCount, then test simQuad.
   All25 words, both local/parameter owners,2 block records and complete
   absolute SLD/header1831/end1850 agree; whole ELF/native CPE unchanged.
   Receipts: build/nc12/track_surface_source_20261025. */
#line 1829 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void SaveSurface::Save(Trk_NewSimQuad *simQuad)

{
  if (fCount > fMaxCount) return;







  if (simQuad != (Trk_NewSimQuad *)0x0) {

    fStack[fCount].fSimQuad = simQuad;
    fStack[fCount].fSurface = simQuad->surface;
    fCount = fCount + 1;
  }




}

/* ---- SaveSurface  [TRACK.CPP:1855-1858] full SLD attribution requires native comparison ---- */
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

#line 1853 "C:/nfs4/GAME/COMMON/TRACK.CPP"
SaveSurface::SaveSurface(int numEntries)

{
  fMaxCount = (short)numEntries;
  fCount = 0;
  fStack = (tSaveSurface *)reservememadr("Surface Save",numEntries << 3,0);
}

/* ---- ~SaveSurface  [TRACK.CPP:1864-1865] full SLD attribution requires native comparison ---- */
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

#line 1862 "C:/nfs4/GAME/COMMON/TRACK.CPP"
SaveSurface::~SaveSurface()

{
  purgememadr(fStack);
}

/* ---- RestoreAll [retail TRACK.CPP:1871-1879; supplied SYM/SLD contract exact] ---- */
/* 2026-10-25: real for-owned i ends before the final fCount clear.
   The delayed clear's instruction address alone did not prove lexical
   ownership. All27 words,2 supplied local/parameter tuples,4 block records
   and absolute SLD/header1871/end1879 agree; whole ELF/native CPE unchanged.
   No fake scope, new object, asm/volatile or output rewrite is introduced.
   Receipts: build/nc12/track_surface_source_20261025. */
#line 1869 "C:/nfs4/GAME/COMMON/TRACK.CPP"
void SaveSurface::RestoreAll()

{
  for (int i = 0; i < fCount; i = i + 1) {

    fStack[i].fSimQuad->surface = fStack[i].fSurface;
    fStack[i].fSimQuad = (Trk_NewSimQuad *)0x0;
    fStack[i].fSurface = '\0';
  }

  fCount = 0; }

/* end of track.cpp */
