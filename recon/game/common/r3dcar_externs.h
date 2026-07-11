#include "../../lib/libfns.h"
/* r3dcar_externs.h -- extern decls for game/psx/r3dcar.cpp (NFS4 PSX 3D car renderer).
 *   Types live in nfs4_types.h; this header declares the cross-TU globals/functions
 *   referenced by r3dcar.cpp plus this TU's own R3DCar_* state (extern for syntax-check).
 */
#ifndef R3DCAR_EXTERNS_H
#define R3DCAR_EXTERNS_H

/* ---- Ghidra-ism helpers (faithful value-level shims) ---- */
#define INT_1f80008c (*(volatile int *)0x1f80008c)   /* scratchpad word Ghidra named by abs-addr */
extern void trap(int code);                          /* gcc MIPS div-by-zero/overflow break helper */

/* ---- cross-TU globals ---- */
extern AITune_tTrackInfo  AITune_trackInfo[];
extern Sim_tSimGlobalVar  simGlobal;
extern Sim_tSimSystemVar  simVar;
extern tReplayInterface   Replay_ReplayInterface;
extern int                Replay_ReplayMode;
extern camera_info        Camera_gInfo[];
extern Car_tObj          *Cars_gList[];
extern int                Cars_gNumCars, Cars_gNumTrafficCars;
extern DrawC_tEnvMap     *DrawC_gEnvMap, *DrawC_gShadow;
extern int                DrawC_gEnvMapMax, DrawC_gShadowMax, DrawC_gWetRoad;
extern MATRIX             DrawC_gScreenMat;
extern GameSetup_tData    GameSetup_gData;
extern char               GameSetup_gCarNames[51][5];
extern char              *Paths_Paths[];
extern int                Render_gMenuRenderFlag;
extern int                Texture_CarColor, Texture_palNum;
extern DRender_tView      gCView;
extern int                gFlip, gNight_renderNight;
extern int                generic128HzClock, stackSpeedUpEnbabledFlag;
extern u_long             gWSavePtr;

/* ---- cross-TU functions ---- */
extern int   AudioMus_Buffered(void);
extern int   AudioMus_Threshold(void);
extern u_int BWorldSm_QuadLight(BWorldSm_Pos *roadInfo);
extern int   Camera_GetMode(int player);
extern void  CarIO_CleanUpLicense(int player);
extern void  CarIO_CreateLicense(char *text, int carType, int player);
extern void  CarIO_ReadInCarTextureData(char *shpfile, Car_tObj *carObj, int reload, int player);
extern void  CarIO_ReleaseCarCluts(Car_tObj *carObj);
extern void  CarIO_UpdateCarTextureData(char *shpfile, Car_tObj *carObj, int reload);
extern void  DrawC_NightHeadlight(Car_tObj *carObj);
extern void  DrawC_Prim(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);
extern void  DrawC_PrimClip(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);
extern void  DrawC_PrimMenu(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);
extern void  DrawC_PrimHalo(matrixtdef *m, coorddef *t, Transformer_zObj *obj, int type, int index, int reflect, Draw_CarCache *sd);
extern int   DrawC_PrimStart(Draw_tVertex *center, Car_tObj *carObj, int lightAvg, Draw_CarCache *sd);
extern void  DrawC_PrimStop(Car_tObj *carObj, Draw_CarCache *sd);
extern void  DrawC_ShadowPrim(Draw_tVertex *shadowVT, Draw_CarCache *sd);
extern void  DrawC_ShadowPrimClip(Draw_tVertex *shadowVT, Draw_CarCache *sd);
extern void  DrawC_ShowroomPrims(matrixtdef *m, coorddef *t, Draw_CarCache *sd);
extern void  DrawC_SpotPrims(matrixtdef *m, coorddef *t, Draw_CarCache *sd);
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);
extern void  Newton_CalcRealShadowCoordinates(Car_tObj *carObj, int gameTicks);
extern void *Platform_TempReserveMemory(int size, char *tag);
extern int   Risk_ReadNextValue(char **scan);
extern void  Texture_ProcessPaletteCopy(Texture_pal8bit *pal, int a, int b);
extern void  TrsProj_TransformProjectVertex(matrixtdef *m, coorddef *t, int n, coorddef *s, Draw_tVertex *v);

/* ---- R3DCar_* TU-owned state (sizes from SYM Globals; types inferred from access) ---- */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_ObjectInfo[58][6];          /* 344B: per-obj [type,flags,...] rows */
// [owned->defined in r3dcar.cpp] extern short              R3DCar_Suspension[10];             /* 20B: wheel index per suspended obj */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_FlareOverlayIndex[12];      /* 12B */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_ForceDriveSide[28];         /* 28B: -1 = auto from track */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_CopIndex[16][2];            /* 32B: [carType-0x16][country] -> letter idx */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_ObjectVisible[60];          /* 60B: 0x39 obj visibility flags */
// [owned->defined in r3dcar.cpp] extern Draw_tVertex       R3DCar_center;                     /* 8B */
// [owned->defined in r3dcar.cpp] extern Draw_tVertex       R3DCar_shadowVertex[4];            /* 32B */
// [owned->defined in r3dcar.cpp] extern Transformer_zScene *R3DCar_LoadedScenePointer[2][50]; /* 400B */
// [owned->defined in r3dcar.cpp] extern char               R3DCar_LoadedSceneCounter[2][50];  /* 100B */
// [owned->defined in r3dcar.cpp] extern signed char        R3DCar_LoadedSceneCountry[52];     /* 52B: signed sentinel -1 (§3.12 #9 char-unsigned-default) */
// [owned->defined in r3dcar.cpp] extern short              R3DCar_LoadedSceneColor[2][50];    /* 200B */
// [owned->defined in r3dcar.cpp] extern short              R3DCar_LoadedSceneVRam[2][50][2];  /* 400B: [color][carType][x,y] */
// [owned->defined in r3dcar.cpp] extern int                R3DCar_PositionZ[9];               /* 36B */
// [owned->defined in r3dcar.cpp] extern u_long            *R3DCar_subOtStart[2][2];           /* 16B: [flip][menu] */
// [owned->defined in r3dcar.cpp] extern R3DCar_tEnvMapInfo  R3DCar_EnvMapInfo[28];            /* 448B */
// [owned->defined in r3dcar.cpp] extern void              *R3DCar_InsertCarFacet_jt[];        /* visibility-switch jump table */
// [owned->defined in r3dcar.cpp] extern int                R3DCar_InMenu;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_aSyncLoading;
// [owned->defined in r3dcar.cpp] extern void              *R3DCar_orientMat;
// [owned->defined in r3dcar.cpp] extern void              *R3DCar_position;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_shadowFlag;
// [owned->defined in r3dcar.cpp] extern CVECTOR            R3DCar_shadowColour;
// [owned->defined in r3dcar.cpp] extern CVECTOR            R3DCar_eMapColour;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_yawCam;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_Clock;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_ClockLast;
// [owned->defined in r3dcar.cpp] extern char              *R3DCar_BigFile;
// [owned->defined in r3dcar.cpp] extern char              *R3DCar_LicenseShapeFile;
// [owned->defined in r3dcar.cpp] extern u_long            *R3DCar_subOt;
// [owned->defined in r3dcar.cpp] extern int                R3DCar_rightHandDrive;
/* R3DCar_gFacetScratch DEFINED in r3dcar.cpp (lost-symbol, not in SYM) */

#endif
