/* r3dcar_externs.h -- extern decls for game/common/r3dcar.cpp (NFS4 PSX 3D car renderer).
 *   Types live in r3dcar_types.h; cross-TU declarations are collected here.
 *   This TU's owned state is defined with its SYM shapes in r3dcar.cpp.
 */
#ifndef R3DCAR_EXTERNS_H
#define R3DCAR_EXTERNS_H

/* Pruned C-linkage boundary declarations, without libfns.h's project-wide
 * type surface. sprintf below uses the canonical PsyQ4.3 STDIO.H signature;
 * do not treat the remaining reconstructed boundaries as verified prototypes. */
extern "C" long DrawSync(...);
extern "C" long VectorNormalS(...);
extern "C" void *SetSp(...);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/eac_mem.h"
#include "eaclib/psx/eacpsxz/eac_math.h"
#include "eaclib/psx/eacpsxz/eac_matrix.h"
#include "eaclib/psx/eacpsxz/eac_file.h"
#include "eaclib/psx/eacpsxz/systask.h"
}
extern "C" int sprintf(char *buffer, char *fmt, ...); /* PsyQ4.3 STDIO.H:35 */
extern "C" char *strcat(...);
extern "C" char *strcpy(...);

extern "C" void trap(int code);                  /* gcc MIPS div-by-zero/overflow break helper */

/* ---- cross-TU globals ---- */
extern AITune_tTrackInfo AITune_trackInfo[];
extern Sim_tSimGlobalVar simGlobal;
extern Sim_tSimSystemVar simVar;
extern tReplayInterface Replay_ReplayInterface;
extern int                Replay_ReplayMode;
extern camera_info Camera_gInfo[];
extern Car_tObj          *Cars_gList[];
extern int                Cars_gNumCars, Cars_gNumTrafficCars;
extern DrawC_tEnvMap *DrawC_gEnvMap, *DrawC_gShadow;
extern int                DrawC_gEnvMapMax, DrawC_gShadowMax, DrawC_gWetRoad;
extern MATRIX             DrawC_gScreenMat;
extern GameSetup_tData GameSetup_gData;
extern char               GameSetup_gCarNames[51][5];
extern char              *Paths_Paths[];
extern int                Texture_CarColor, Texture_palNum;
extern DRender_tView      gCView;
extern int                gFlip, gNight_renderNight;
/* generic128HzClock is the IRQ/VBlank-incremented 128Hz tick counter -> genuinely
   VOLATILE (same declaration fe3dmenu_externs.h already carries): the oracle
   RE-LOADS it inside the `if` body instead of reusing the value it just
   compared -- a plain int lets cse.c forward the compare's load. */
extern volatile int       generic128HzClock;
extern int                stackSpeedUpEnbabledFlag;
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
extern char *Platform_TempReserveMemory(int size, char *tag); /* retail PTR CHAR */
extern int   Risk_ReadNextValue(char **scan);
extern void  Texture_ProcessPaletteCopy(Texture_pal8bit *pal, int a, int b);
extern void  TrsProj_TransformProjectVertex(matrixtdef *m, coorddef *t, int n, coorddef *s, Draw_tVertex *v);

/* TU-owned definitions belong in r3dcar.cpp, not duplicated here. Historical
 * inferred array shapes and the removed fake facet-scratch/jump-table globals
 * are not declarations or recovery authorities; the source keeps their history. */

#endif
