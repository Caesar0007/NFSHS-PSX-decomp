/* draww_externs.h -- extern decls for game/psx/draww.cpp (NFS4 PSX world-geometry draw). */
#ifndef DRAWW_EXTERNS_H
#define DRAWW_EXTERNS_H

/* ---- GTE intrinsics ---- */
/* Canonical PsyQ libgte inline COP2 macros (incl. the real gte_ldsxy3 = mtc2 SXY0/1/2)
 * are vendored in psx_gte.h. Kept here: the legacy gte_lwc2 value-form extern (call
 * sites pending conversion to gte_ldv forms per the GTE batch). */
#include "../../lib/psx_gte.h"
extern void gte_lwc2(int reg, int data);   /* value-form load (draww calls pending conversion to gte_ldv*) */

/* Narrow declarations formerly supplied by libfns.h.  Keeping them here
 * preserves DrawW.obj's own SYM type graph instead of importing unrelated SDK
 * and game declarations into the translation unit. */
extern "C" {
void SetTexWindow(void *, void *);
void *SetSp(void *);
void SetFarColor(int, int, int);
void SetFogNear(int, int);
void transform(void *, void *, void *);
int fixedatan(int, int);
int fixedmult(int, int);
void fixedxformy(matrixtdef *, int);
void xformy(matrixtdef *, int);
}

/* ---- PsyQ libgte / libgpu ---- */

/* ---- eaclib / math fixed-point + transform helpers ---- */

/* ---- auto-generated from SYM Globals + Demangled ---- */
/* DrawW.obj omits these foreign owners from its own debug graph.  Their
 * canonical owner records and exact linked declarations are retained here. */

extern Trk_AnimateInst * Anim_gInstanceFromIndex[8];
extern Car_tObj * BW_gCopCarObj;
extern Trk_NewSlice *BWorldSm_slices;
extern int BWorld_gChunkCount;
extern u_char CF_DVLC[49096];
extern camera_info Camera_gInfo[2];
extern Car_tObj * Cars_gHumanRaceCarList[9]; /* P915: native owner SYM1fea82, 36 bytes. */
extern Car_tObj * Cars_gList[9];             /* P915: native owner SYM1fea01, 36 bytes. */
extern int Cars_gNumHumanRaceCars;
extern coorddef * Chunk_chunkCenters;
extern CVECTOR * Chunk_lightTable;
extern int Draw_gMidGroundOtz;
extern int Draw_gViewOtSize;
extern GameSetup_tData GameSetup_gData;
extern u_char (* Night_gCopColor[2])[256][8];
extern u_char (* Night_gCurrentNightColor)[256][16];   /* matches owner def night.cpp @0x8013da48 (was stale u_char***) */
extern char * Night_gNightTbl;
/* P915: compatible incomplete outer array; native owner remains [2].
 * DrawW's original caller-bound spelling is absent from its SYM. This ordinary
 * interface preserves native address materialization without a false bound. */
extern u_char (* Night_gWeatherLightingTable[])[256];
extern Group * Object_customObjInst;
extern Group * Object_customSimObjs;
extern CTrackSpec TrackSpec_gSpec;
extern Chunk * Track_chunkList;
extern short ** Track_gInViewList;
extern Trk_ObjectDef ** Track_gObjDefs;
extern Track_tMaterial * Track_materials;
// [owned->defined in draww.cpp] extern int animation_timer[12];
// [owned->defined in draww.cpp] extern ChunkObjectInfo gChunkObjInfo;
extern short gClutDepth[256][16];   /* FIX: matches owner textureprocess.cpp def [256][16]; the stale [1][4096] gave an 8192-byte row stride (oracle: sll 5 = 32-byte rows) */
extern matrixtdef gCopMat;
extern BW_tContext * gCurrContext;
extern Draw_tPixMap * gDLPixmap[10];   /* FIX: matches owner genericpmx.cpp def [10] */
// [owned->defined in draww.cpp] extern Draw_SubdivStruct gDiv;
// [owned->defined in draww.cpp] extern MATRIX gIdentTemplate;
extern Track_tArtresource gInitialArt;
extern matrixtdef gNightMat;
extern int gNight_renderNight;
extern Group * gPersistMidgroundObjInst;
extern Group * gPersistObjDefBoundingSpheres;
extern Group * gPersistObjInst;
/* P915: native SYM27bf2f and genericpmx.cpp define two pointers, eight bytes.
 * The former [1] matching workaround was not a valid original array bound.
 * Historical W70 scores ([1]=274, [2]/[]=326) belonged to an older source/flag
 * basin. Native bounds plus compiler-default/G8 recovery now preserve 35 PASS
 * functions without the false declaration or an asm-labelled alias. */
extern Draw_tPixMap * gSkidMarkPixmap[2];
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
extern bool BWorld_IsSliceInBuildList(int);
extern void Flare_Halo2(DRender_tView *, int, int, coorddef *, coorddef *, struct Draw_FlareCache *);
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
