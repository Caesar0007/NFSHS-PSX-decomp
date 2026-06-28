#include "../../lib/libfns.h"
/* draww_externs.h -- extern decls for game/psx/draww.cpp (NFS4 PSX world-geometry draw). */
#ifndef DRAWW_EXTERNS_H
#define DRAWW_EXTERNS_H

/* ---- GTE intrinsics ---- */
/* Canonical PsyQ libgte inline COP2 macros are vendored in psx_gte.h (real cop2 asm).
 * Kept here: the legacy gte_lwc2/gte_swc2 value-form externs (call sites pending
 * conversion to gte_ldv / gte_st forms per the GTE batch) + gte_ldsxy3 (not yet vendored). */
#include "../../lib/psx_gte.h"
extern void gte_lwc2(int reg, int data);   /* value-form load (draww calls pending conversion to gte_ldv*) */
#define gte_ldsxy3(a,b,c)       ((void)0)

extern char *Render_gPacketPtr;
extern char *Render_gPalettePtr;
extern char *Render_gPacketEnd;

/* ---- world/cop/night transform matrices (Ghidra-named; matrixtdef like SYM gWorldMat) ---- */
extern MATRIX     Render_gWorldMat, Render_gNightMat;
extern matrixtdef Render_gCopMat;

/* ---- PsyQ libgte / libgpu ---- */

/* ---- eaclib / math fixed-point + transform helpers ---- */

/* ---- draww module scratch / state globals (Ghidra-named, not in SYM) ---- */
extern int    DrawW_gChunkGeomRez, DrawW_gChunkInd, DrawW_gChunkObjFlag, DrawW_gChunkQuadCount;
extern int    DrawW_gChunkRelX, DrawW_gChunkRelY, DrawW_gChunkRelZ;
extern int    DrawW_gFog_init, DrawW_gGroupCount, DrawW_gMatID_tmp, DrawW_gNightFlags, DrawW_gNightTmpFlag;
extern int   *DrawW_gChunkStripBuf;
extern Group *DrawW_gChunkVtxBuf, *DrawW_gGroupPtr;
extern Track_tArtresource *DrawW_gInitialArtPtr;
extern Track_tMaterial    *DrawW_gMaterialLUT;
extern int    DrawW_gObjScratch_148, DrawWTrough_scratchVec[3];
extern int    Skid_gCtrlPoint_0, Skid_gCtrlPoint_1, Skid_gCtrlPoint_2, Skid_gCtrlPoint_3;
extern int    Skid_gCtrlPoint_4, Skid_gCtrlPoint_5, Skid_gCtrlPoint_6;
extern int    Skid_gCtrlScratch_94, Skid_gCtrlScratch_98, Skid_gScratchPos1, Skid_gScratchPos2, gScratchLastWord;
extern int    INT_1f800084, INT_1f800088, INT_1f80008c, INT_1f800090;

/* ---- auto-generated from SYM Globals + Demangled ---- */
extern Trk_AnimateInst * Anim_gInstanceFromIndex[8];
extern Car_tObj * BW_gCopCarObj;
extern Trk_NewSlice * BWorldSm_slices;
extern int BWorld_gChunkCount;
extern u_char CF_DVLC[49096];
extern camera_info Camera_gInfo[136];
extern Car_tObj * Cars_gHumanRaceCarList[2];
extern Car_tObj * Cars_gList[2];
extern int Cars_gNumHumanRaceCars;
extern coorddef * Chunk_chunkCenters;
extern CVECTOR * Chunk_lightTable;
extern int Draw_gMidGroundOtz;
extern int Draw_gViewOtSize;
extern GameSetup_tData GameSetup_gData;
extern u_char (* Night_gCopColor[2])[256][8];
extern u_char *** Night_gCurrentNightColor;
extern char * Night_gNightTbl;
extern u_char (* Night_gWeatherLightingTable[2])[256];
extern Group * Object_customObjInst;
extern Group * Object_customSimObjs;
extern CTrackSpec TrackSpec_gSpec;
extern Chunk * Track_chunkList;
extern short ** Track_gInViewList;
extern Trk_ObjectDef ** Track_gObjDefs;
extern Track_tMaterial * Track_materials;
// [owned->defined in draww.cpp] extern int animation_timer[12];
// [owned->defined in draww.cpp] extern ChunkObjectInfo gChunkObjInfo;
extern short gClutDepth[1][4096];
extern matrixtdef gCopMat;
extern BW_tContext * gCurrContext;
extern Draw_tPixMap * gDLPixmap[2];
// [owned->defined in draww.cpp] extern Draw_SubdivStruct gDiv;
// [owned->defined in draww.cpp] extern MATRIX gIdentTemplate;
extern Track_tArtresource gInitialArt;
extern matrixtdef gNightMat;
extern int gNight_renderNight;
extern Group * gPersistMidgroundObjInst;
extern Group * gPersistObjDefBoundingSpheres;
extern Group * gPersistObjInst;
extern Draw_tPixMap * gSkidMarkPixmap[1];
extern int gSpikeBeltSlice;
extern int gSpikeBeltX;
// [owned->defined in draww.cpp] extern CCOORD16 gVertex3d[320];
// [owned->defined in draww.cpp] extern DRender_tView * gVi;
// [owned->defined in draww.cpp] extern u_long gWSavePtr;
extern matrixtdef gWorldMat;
// [owned->defined in draww.cpp] extern char goffsets[8];
// [owned->defined in draww.cpp] extern char offsets[8];
extern Sim_tSimGlobalVar simGlobal;
// [owned->defined in draww.cpp] extern int stackSpeedUpEnbabledFlag;
// [owned->defined in draww.cpp] extern int trk0[9][2];
// [owned->defined in draww.cpp] extern int trk4[10][2];
extern void Anim_GetRotPos(Trk_AnimateInst *, int, int, coorddef *, matrixtdef *);
extern int  BWorld_IsSliceInBuildList(int);
extern void Flare_Halo2(DRender_tView *, int, int, coorddef *, coorddef *, Draw_FlareCache *);
extern void Math_fasttransmult(matrixtdef *, matrixtdef *, matrixtdef *);
extern ObjectAnim *Object_GetAnim(Trk_SimObject *);
extern void Quatern_QuatToMat(tQuat *, matrixtdef *);
extern void TrsProj_SetPsxTransZero(void);
extern void TrsProj_TransPt(coorddef *, coorddef *);
extern int  xzsquaredist32(coorddef *, coorddef *);
/* forward decl missed by proto-emitter (defined later in draww.cpp, called earlier) */
extern int DrawObjectTransform(DRender_tView *Vi, Draw_DCache *sd, matrixtdef *matrix,
                               Trk_ObjectDef *objDef, coorddef *pCp, int offset, short light);

#endif
