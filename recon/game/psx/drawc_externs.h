#include "drawc_types.h"
/* draww_externs.h -- extern decls for game/psx/drawc.cpp (NFS4 PSX world-geometry draw). */
#ifndef DRAWC_EXTERNS_H
#define DRAWC_EXTERNS_H

struct Draw_FlareCache;
struct Texture_pal8bit;

/* ---- Night.obj globals (defined in night.cpp) -- weather/lightning tint, DrawC_NightHeadlight (H46) ---- */
extern char Night_gDrawLightning;     /* @0x8013d9e0 (bss=0) */
extern int  Night_gLightningType;     /* @0x8013da44 (bss=0) */
/* UNSIZED in this TU's view: drawc.obj is -G8 and retail reaches these three 8-byte objects
 * with absolute lui/addiu (a declaration without a size is not gp-eligible). */
extern long Night_gWeatherColor[];   /* @0x8013da88 (bss=0) -- per-type RGB tint (bytes 0/1/2 = R/G/B) */

/* ---- GTE intrinsics: canonical PsyQ inline COP2 macros from ../../lib/psx_gte.h ----
 * (all gte_* loads/stores/compute live there now; the former local no-op stubs deleted). */

/* ---- PsyQ libgte / libgpu (seed; extend as compile demands) ---- */

/* ---- game externs (harvested from sealed modules + usage-typed; int=TODO refine) ---- */
extern bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern void CarIO_UpdateCarTextureData(char *, Car_tObj *, int);
extern Draw_tPixMap *CarIO_carPixMap;
extern Car_tObj * Cars_gHumanRaceCarList[];
extern Car_tObj * Cars_gList[];
extern int Cars_kSkidMarkSurface[16];
extern short DrawC_HeadLightFlash[16];
extern short DrawC_SirenFlash[16];
extern short DrawC_TailLightFlash[16];
extern DrawC_tEnvMap *DrawC_gEnvMap;
extern int DrawC_gEnvMapMax;  /* TODO type-refine */
extern short DrawC_gEnvMapOffset[4];
extern MATRIX DrawC_gMatA;
extern int DrawC_gMenuColor[2];
extern int DrawC_gMenuLightsDirection;  /* TODO type-refine */
extern short DrawC_gOverlay[51];
extern short         DrawC_gReflectOffset;       /* 0x8013d814 */
extern MATRIX DrawC_gScreenMat;
extern DrawC_tEnvMap *DrawC_gShadow;
extern int DrawC_gShadowMax;  /* TODO type-refine */
extern int DrawC_gWetRoad;  /* TODO type-refine */
extern void DrawW_WorldSetUpMatrix(matrixtdef *, MATRIX *);
extern void DrawW_WorldSetUpTranslation(coorddef *, MATRIX *);
extern DRAWENV *Draw_GetDRAWENV(int view, int buf);
extern int Draw_gViewOtSize;
extern COORD16  Fe3D_lightsVertex[64];   /* 0x80051334  ARY STRUCT COORD16 x64 */
extern COORD16  Fe3D_spotVertex[33];     /* 0x8005126c  ARY STRUCT COORD16 x33 */
extern void Flare_CarShapedHalo(int, COORD16 *, COORD16 *, COORD16 *, short, int, Draw_FlareCache *);
extern int GameSetup_gData[650]; /* word view (2600 bytes): retail drawc.obj records no GameSetup_tData */
extern DRender_tView gCView;
extern void Night_AdditiveNightCalc(VECTOR *, CVECTOR *);
extern char          *Paths_Paths[];           /* 0x80116468 */
extern void R3DCar_GetCarName(char *, int, int);
extern int      R3DCar_Clock, R3DCar_ClockLast, R3DCar_InMenu;
extern CVECTOR R3DCar_eMapColour;
extern char R3DCar_SignalBrakeFlare[28];   /* @0x8011680c -- per-carType signal/brake flare class (owned by r3dcar.cpp) */
extern short R3DCar_yawCam;
extern void R3DCcar_ReadTrackShadow(void);
extern void R3DCcar_ReadeMapData(void);
extern int Risk_ReadNextValue(char **);
extern int             Texture_CarColor;        /* 0x8013db08 */
extern void Texture_ProcessPaletteCopy(Texture_pal8bit *, int, int);
extern Draw_tPixMap Track_gReflectionMaps[4];
extern void TrsProj_ResetTransPrecision(void);
extern void TrsProj_SetTransPrecision(int);
extern int               TrsProj_precision;     /* 0x8013db9c */
extern int            gFlip;             /* 0x8013d7b4 */
extern Draw_tPixMap   *gMenuPixmap[8];          /* 0x80120fd0 */
extern matrixtdef gNightMat;
extern Draw_tPixMap *gShadowPixmap[2];
/* drawc.cpp reads gShadowPixmap[0] through the real [2] array (2026-11-07: the former
 * per-TU scalar asm-label view was removed; drawc.o is identical, the -g .s only changes
 * `.extern gShadowPixmap, 4` -> 8 = the retail size, SYM EXT ARY PTR STRUCT size 8). */







extern int gShowroomLights;  /* TODO type-refine */

/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/memstd.h"
#include "eaclib/psx/eacpsxz/nsync.h"
#include "eaclib/psx/eacpsxz/timer.h"
#include "eaclib/psx/eacpsxz/trnsfrm.h"
}
extern "C" {
u_long *ClearOTagR(u_long *ot, int n);
int DrawSync(int mode);
MATRIX *RotMatrix(SVECTOR *r, MATRIX *m);
void SetDrawMode(DR_MODE *p, int dfe, int dtd, int tpage, RECT *tw);
int sprintf(char *buffer, char *fmt, ...);
char *strcat(char *, char *);
char *strcpy(...);
}

#endif
