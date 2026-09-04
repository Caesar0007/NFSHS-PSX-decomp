/* night_externs.h -- externs for game/psx/night.cpp (NFS4 PSX night-driving lighting/colour tables,
   headlights, cop strobes, lightning effects). */
#ifndef _GAME_PSX_NIGHT_EXTERNS_H_
#define _GAME_PSX_NIGHT_EXTERNS_H_

#include "night_types.h"

/* ---- module state globals ---- */
// [owned->defined in night.cpp] extern int            gNight_renderNight;      /* 0x8013da28 */
// [owned->defined in night.cpp] extern char          *nightfile;               /* 0x8013da98 */
// [owned->defined in night.cpp] extern char           lightningInit;           /* 0x0000001e (gp-rel) */
// [owned->defined in night.cpp] extern tCompRGB      *gTableCache;             /* 0x8013da94  light RGB working cache */
// [owned->defined in night.cpp] extern tNightInitCache *gNightInitCache;       /* 0x8013da90 */
// [owned->defined in night.cpp] extern int            Night_gTotalLights;      /* 0x8013da60 */
// [owned->defined in night.cpp] extern char          *Night_gNightTbl;         /* 0x8013da40 */

// [owned->defined in night.cpp] extern u_char       (*Night_gPlayerLightingTable)[256][16]; /* 0x8013d9e4 */
// [owned->defined in night.cpp] extern u_char       (*Night_gCopLightingTableRed)[256][8];  /* 0x8013d9e8 */
// [owned->defined in night.cpp] extern u_char       (*Night_gCopLightingTableBlue)[256][8]; /* 0x8013d9ec */
// [owned->defined in night.cpp] extern u_char       (*Night_gWeatherLightingTable[2])[256]; /* 0x8013d9f0 */
// [owned->defined in night.cpp] extern u_char       (*Night_gCurrentNightColor)[256][16];   /* 0x8013da48 */
// [owned->defined in night.cpp] extern u_char       (*Night_gCopColor[2])[256][8];          /* 0x8013da4c */
// [owned->defined in night.cpp] extern u_char         Night_gCopCarTypeColorIdx[];          /* gp-rel small array */

// [owned->defined in night.cpp] extern long           Night_gPlayerHeadLightColor[2]; /* 0x8013da80 (packed CVECTOR) */
// [owned->defined in night.cpp] extern long           Night_gWeatherColor[2];         /* 0x8013da88 */
// [owned->defined in night.cpp] extern CVECTOR        Night_gAdditiveHeadlightColor[16]; /* 0x80120dbc */

// [owned->defined in night.cpp] extern int            Night_gXDist, Night_gZNear, Night_gZDist;      /* 0x8013da2c.. */
// [owned->defined in night.cpp] extern int            Night_gXDistShift, Night_gZDistShift;          /* 0x8013da38.. */
// [owned->defined in night.cpp] extern int            Night_gLightningType;                          /* 0x8013da44 */
// [owned->defined in night.cpp] extern int            Night_gLightning, Night_gNextLightning, Night_gEndNextLightning;
// [owned->defined in night.cpp] extern int            Night_gNextFlicker, Night_gFlashAzimuth, Night_gFlashIntensity;
// [owned->defined in night.cpp] extern char           Night_gShowForks;          /* 0x8013da78 */
// [owned->defined in night.cpp] extern char           Night_gDrawLightning;      /* 0x8013d9e0 */

// [owned->defined in night.cpp] extern int            Night_gLightningPauseAreas[][2];   /* 0x80120d2c */
// [owned->defined in night.cpp] extern char           Night_gCopCountryLightTbl[][5][2]; /* 0x80120d18 */

/* ---- engine globals ---- */
/* Exact-symbol views use only records retained by night.obj.  Their offsets
 * are fixed by the linked SYM: GameSetup cops/Weather/Time at +20/+72/+84,
 * simGlobal gameTicks at +4, TrackSpec night/depth-cue at +236/+240, and
 * camera target/slicePos at +4/+140 with a 272-byte element stride. */
extern GameSetup_tData GameSetup_gData;
extern coorddef Night_SimView asm("simGlobal");
extern int Night_TrackSpecWords[] asm("TrackSpec_gSpec");
/* The retail load shape proves a 272-byte row with slicePos at +140.  This
 * codegen-only carrier is intentionally not part of night.obj's SYM graph;
 * the canonical audit excludes this one exact tag after validating its body. */
struct Night_CameraCodegenView {
    u_char anchorBytes[4];
    BO_tNewtonObj *target;
    u_char prefix[132];
    BWorldSm_Pos slicePos;
};
extern Night_CameraCodegenView Night_CameraView[] asm("Camera_gInfo");
#define NIGHT_GAME_TICKS          Night_SimView.y
#define NIGHT_TRACK_NIGHT               (*(CNightSpec *)&Night_TrackSpecWords[59])
#define NIGHT_TRACK_DEPTH_CUE_COLOR_WORD Night_TrackSpecWords[60]
#define NIGHT_TRACK_DEPTH_CUE_DISTANCE   Night_TrackSpecWords[61]
#define NIGHT_CAMERA_TARGET(p)   Night_CameraView[p].target
#define NIGHT_CAMERA_SLICEPOS(p) Night_CameraView[p].slicePos
#define NIGHT_CAMERA_SLICE(p)    Night_CameraView[p].slicePos.slice
extern char          *Paths_Paths[];             /* 0x80116468 */
extern CVECTOR       *Chunk_lightTable;          /* 0x8013c818  (was stale tCompRGB* -- 3-byte stride vs
                                                     the real 4-byte CVECTOR* owner def in chunk.cpp;
                                                     wrong-stride bug, this fn indexes Chunk_lightTable[i]) */
extern int            Chunk_numLight;            /* 0x8013d4ec */
extern int             Night_WeatherType asm("Weather_gType"); /* 0x8013dbec */
extern int             D_80113228[];             /* @0x80113228 == &GameSetup_gData.track; distinct
                                                     alias symbol the oracle addresses directly (unsized
                                                     array shape, §3.12#5) -- same global used this way
                                                     in aidatarecord.cpp */
extern int             D_8011E0B0[];             /* == &simGlobal.gameTicks; distinct alias symbol the
                                                     oracle addresses directly (unsized array, §3.12#5) --
                                                     same global used this way in aiphysic.cpp/aih_*.cpp */

/* ---- eaclib / syslib / sibling-module helpers ---- */
extern void  AudioCmn_PlayThunder(int intensity, int azimuth);
extern void  Hrz_LightningFlicker(int on);
extern void  Hrz_SetLightingPosInSky(DRender_tView *Vi);
extern void  Hrz_CalculateLightning(void);
extern bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *pos);
extern int   Camera_GetMode(int player);

extern "C" {
void blockmove(void *source, void *destination, int size);
int filesize(char *filename);
void *loadshapeadr(char *filename, void *destination);
void *locateshape(void *shapefile, int *namekey);
int purgememadr(void *ptr);
int random(void);
void *reservememadr(const char *name, int size, int flags);
int sprintf(char *buffer, const char *format, ...);
}

/* ---- this module (forward decls for intra-TU calls) ---- */
extern int   Night_FindClosestColor(CVECTOR colorMatch, int *bestIndex);
extern void  Night_CreateNightTableElement(int colorIndex, long colorH, int bright, u_char *colorval);
extern void  Night_CreateNightTable(int colorIndex, long colorH, int bright, u_char (*tbl)[256][16]);
extern void  Night_GenerateNextLightningEvent(void);
extern void  Night_PauseLightningEffect(int player);
extern void  Night_DoLightningEffect(DRender_tView *Vi);
extern void  Night_SetPlayerHeadLightColor(int player, int colorIndex, int bright);
extern void  Night_SetCopLightColors(int colorIndex, int brighten);
extern void  Night_SetWeatherColors(int colorIndex);
extern void  Night_InitPlayerHeadLightColor(int player);
extern void  Night_InitCopLightColors(void);
extern void  Night_InitWeatherTables(void);
extern void  Night_GenerateAllLightTables(void);

#endif
