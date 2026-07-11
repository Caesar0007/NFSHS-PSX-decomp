/* game/common/bworld_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_BWORLD_EXTERNS_H_
#define _GAME_COMMON_BWORLD_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

char *Platform_GetDCTBuffer(...); void Platform_ResetDCTBuffer();
extern CVECTOR * Chunk_lightTable;
extern Car_tObj           *Cars_gList[];             /* 0x8010f9dc */
extern Car_tObj           *Cars_gTrafficCarList[];
extern Car_tObj           *Cars_gCopCarList[];       /* 0x8010faB4 -- alias-adjacent to
                                                       * Cars_gTrafficCarList (same backing
                                                       * array, +0x24/9 elems later); oracle
                                                       * addresses this cluster via
                                                       * Cars_gCopCarList directly. */
extern Chunk              *Track_chunkList;
extern GameSetup_tData   GameSetup_gData;
extern Group              *Object_customSFXInst;     /* 0x8013d2d0 */
extern Group              *gPersistObjDef;           /* track.obj */
extern MATRIX     Render_gWorldMat, Render_gNightMat;
extern Trk_NewSlice  *BWorldSm_slices;
extern camera_info       Camera_gInfo[2];            /* camera.obj */
extern char * Track_MakeTrackDataPathName(char *ext);
extern char * Track_MakeTrackPathName(char *ext);
extern char Night_gDrawLightning;
extern coorddef * Chunk_chunkCenters;
extern int                 Cars_gNumCopCars;
extern int                 Object_customSliceNum;    /* 0x8013d2d4 */
extern int                 generic128HzClock, stackSpeedUpEnbabledFlag;
extern int               Replay_ReplayMode;          /* replay.obj */
extern int               screenheight, ticks, gFlip, gLargestUnused, Draw_gPlayer1View, Draw_gDoVSync, currentVideo;
extern int            Chunk_numLight;            /* 0x8013d4ec */
extern int            Draw_gPlayer1View, Draw_gPlayer2View;
extern int            gNumSlices;
extern int    Skid_gCtrlScratch_94, Skid_gCtrlScratch_98, Skid_gScratchPos1, Skid_gScratchPos2;
extern CTrackSpec     TrackSpec_gSpec;           /* 0x8012327c */
extern int   BWorldSm_FindClosestQuadRez(coorddef *c, BWorldSm_Pos *pos, int rez);
extern int  *Track_gInViewCount;     /* = Alloc(...), indexed */
extern int Loading_UpdateLoadingScreen(int);
extern int Night_gLightningType;
extern int Night_gXDistShift;
extern int Night_gZDistShift;
extern int Night_gZNear;
extern int gNight_renderNight;
extern short ** Track_gInViewList;
extern u_long              gWSavePtr;
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern void BWorldSm_Restart(void);
extern void Chunk_UpdateSys(DRender_tView *Vi);
extern void DrawW_BuildSpikeBelt(DRender_tView *Vi,int scale,Draw_DCache *sd);
extern void DrawW_DoLines(DRender_tView *Vi,tBuildEntry *buildList,Draw_DCache *sd);
extern void DrawW_DoObjects(DRender_tView *Vi,tBuildEntry *buildList);
extern void DrawW_DoTrough(DRender_tView *Vi,tBuildEntry *buildList);
extern void DrawW_WorldSetUpMatrix(matrixtdef *, MATRIX *);
extern void FindAbsClosestSliceCrude(coorddef *pt,BWorldSm_Pos *slicePos);
extern void Flare_Halo(DRender_tView *Vi,int scale,int type,coorddef *fpt,Draw_FlareCache *sd);
extern void Flare_Halo2(DRender_tView *, int, int, coorddef *, coorddef *, Draw_FlareCache *);
extern void Night_SetCopColor(GameSetup_tCarData *carinfo);
extern void Object_ClearCustomObjects(void);
extern void Object_InitCustomObjects(void);
extern void Object_InitIMassObjectInfo(void);
extern void Object_InitStatus(void);
extern void Object_KillStatus(void);
extern void Scene_Init(int numObjDefs);
extern void Scene_LoadSceneFile(int sceneFileIndex);
extern void Track_Init(char *tempName);
extern void Track_SetTrackNumber(int tracknum);
extern void TrgSfx_AddEnviroEffect(int obj,int type,coorddef *emitterpt,coorddef *vec);
extern void TrsProj_SetPsxTrans(coorddef *t);
extern void TrsProj_SetPsxTransZero(void);
extern void TrsProj_TransPt(coorddef *, coorddef *);
extern void TrsProj_TransPtN16(RelCoord16 *s,coorddef *d,int n);
int Anim_InitSystem(char *trackName);
void Anim_Restart(void);
void AudList_LoadAudioFile(int AudioFileIndex);

#endif /* _GAME_COMMON_BWORLD_EXTERNS_H_ */
