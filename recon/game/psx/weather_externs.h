#include "../../lib/libfns.h"
/* weather_externs.h -- externs referenced by weather.cpp (GAME/PSX/WEATHER.CPP particle weather) */
#ifndef WEATHER_EXTERNS_H
#define WEATHER_EXTERNS_H

/* ---- canonical PsyQ libgte (COP2/GTE) inline macros: real cop2 asm under __mips__,
 *      host no-op stubs for the -m32 syntax-check seal gate (section 3.4). ---- */
#include "../../lib/psx_gte.h"

/* ---- Weather state globals (SYM Globals.jsonl) ---- */
extern int               Weather_gDensityTbl[4];               /* 0x80123384 */
extern int               Weather_gIntensityTbl[4];             /* 0x80123394 */
extern int               Weather_gTrackIntensityLimitTbl[16];  /* 0x801233a4 */
extern char              Weather_gRandomVelocityVectors[12][3];/* 0x801233e4 */
extern Weather_tSys      Weather_gSys;                         /* 0x80123408  main state struct */
extern char             *Weather_gWasDrawn;                    /* 0x8013dba4 */
extern SVECTOR          *Weather_gPos;                         /* 0x8013dba8 */
extern Weather_tSplatInfo *Weather_gSplatInfo;                 /* 0x8013dbac */
extern DVECTOR          *Weather_gPrevPos;                     /* 0x8013dbb0 */
extern CWeatherSpec     *Weather_gTrackSpec;                   /* 0x8013dbc4 */
/* The four per-player server arrays are SPLIT-STORAGE in the oracle: every CONSTANT-index
 * site reaches an element through its OWN %gp_rel symbol (Weather_gSplatInfoServer /
 * D_8013DBCC = +4, ...), while the runtime-index site (Weather_DoWeather) materializes an
 * absolute lui/addiu base.  weather.cpp OWNS them (only consumer in the tree), so their
 * storage is modeled there as per-element tentative defs + unsized asm-label array views.
 * Declared in recon/game/psx/weather.cpp, NOT here. */
extern long              Weather_gLastTimeProcessed;           /* 0x8013dbe8 */
extern Weather_tState    Weather_gType;                        /* 0x8013dbec */
extern int               Weather_gDensityGoalState;            /* 0x8013dbf0 */
extern int               Weather_gIntensityGoalState;          /* 0x8013dbf4 */
extern int               Weather_gDensityChangeFactor;         /* 0x8013dbf8 */
extern int               Weather_gIntensityChangeFactor;       /* 0x8013dbfc */
extern int               Weather_gDensityTimerGoal;            /* 0x8013dc00 */
extern int               Weather_gIntensityTimerGoal;          /* 0x8013dc04 */
extern int               Weather_gSnowTrack;                   /* 0x8013dc08 */
extern int               Weather_gTrackIntensityLimit;         /* 0x8013dc0c */
/* Weather_gLastProcessTime: SPLIT STORAGE, file-static (SYM class STAT) -- defined
 * per-element in weather.cpp with an asm()-label array view; no cross-TU extern. */

/* ---- shared game globals (SYM Globals.jsonl; declared in their owning TUs) ---- */
extern GameSetup_tData   GameSetup_gData;          /* 0x801131ec */
extern Sim_tSimGlobalVar simGlobal;                /* 0x8011e0ac */
extern CTrackSpec        TrackSpec_gSpec;          /* 0x8012327c */
extern camera_info       Camera_gInfo[2];          /* 0x8010f2ac */
extern coorddef          prevCamPos[2];            /* 0x8012342c */
extern matrixtdef        prevCamMat[2];            /* 0x80123444 */
extern int               gCurrentNumSplats;        /* 0x8013dba0 */

/* ---- external subsystems (eaclib + game-side; sigs from call sites) ---- */
                       /* eaclib EACPSXZ random  */
                      /* eaclib EACPSXZ memstd  */
 /* eaclib EACPSXZ memstd */
extern void  Math_NormalizeVector(coorddef *v);         /* game math (mangled __FP8coorddef) */
                   /* 16.16 fixed-point multiply */
extern void  Math_fasttransmult(matrixtdef *a, matrixtdef *b, matrixtdef *out);  /* __FP10matrixtdefN20 */
extern int   Camera_GetMode(int player);                /* __Fi */
extern bool BWorldSm_TunnelFlagSm(BWorldSm_Pos *slicePos) asm("BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos");
   /* PsyQ libgpu */

/* render packet/palette write cursors + per-player weather pixmaps + look-behind input */
extern Draw_tPixMap *gWeatherPixmap[3];            /* 0x80112b7c  snow/rain sprites */
extern int          Input_gLookBehind[2];          /* 0x8013d230 */
// [owned->file-static in weather.cpp] int timechange; /* 0x8013de4c */

#endif /* WEATHER_EXTERNS_H */
