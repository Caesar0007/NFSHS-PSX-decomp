/* hrzsku_externs.h -- externs for game/psx/hrzsku.cpp (NFS4 PSX horizon + sky renderer).
   Sky ring/mesh/stars, lightning forks, GTE-projected horizon. */
#ifndef _GAME_PSX_HRZSKU_EXTERNS_H_
#define _GAME_PSX_HRZSKU_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
#include "../../lib/psx_gte.h"

/* Canonical PsyQ libgte inline COP2 macros (incl. the generic lone-store gte_swc2(reg,ptr))
   are vendored in psx_gte.h. Lone MAC3 / SZ1 / SZ2 stores here use that shared gte_swc2;
   all GTE loads use the canonical gte_ldv / gte_ldV macros (no gte_lwc2 value-form remains). */
/* Ghidra renders raw GTE COP2 ops as calls through a code-ptr to a HW address: (*(code*)0xADDR)().
   Typedef makes them compile; the faithful gte_ macros are applied in the per-fn BODY pass. */
typedef void (code)(void);
typedef long long undefined8;
typedef unsigned long long ulonglong;
/* Ghidra byte-concat / sub-word extract macros */
static inline u_int   CONCAT22(u_short hi, u_short lo) { return ((u_int)hi << 16) | lo; }
static inline u_short SUB42(u_int v, int n) { return (u_short)(v >> (n * 8)); }

/* ---- GPU packet cursors + matrices ---- */
extern char          *Render_gPacketEnd;
extern short          Render_gPacketLenLo, Render_gPacketLenHi;
extern MATRIX         Render_gWorldMat;
extern matrixtdef     Render_gCopMat;

/* ---- camera / view ---- */
extern long           Camera_gGeomScreen;
extern int            Draw_gViewOtSize;
extern int            Draw_gPlayer1View, Draw_gPlayer2View;

/* ---- track / setup ---- */
extern GameSetup_tData GameSetup_gData;          /* 0x801131ec */
extern CTrackSpec     TrackSpec_gSpec;           /* 0x8012327c */
// [owned->defined in hrzsku.cpp] extern CHorizonSpec  *Hrz_gTrackSpec;            /* horizon spec (angle/height/frontColor/ringPMX) */
// [owned->defined in hrzsku.cpp] extern CSkySpec      *Sky_gTrackSpec;            /* sky spec (numStars/frontcolors/...) */
extern void           trap(int c);
// [owned->defined in hrzsku.cpp] extern CVECTOR       *starColors;        /* reservememadr'd */
// [owned->defined in hrzsku.cpp] extern SVECTOR       *starPosInSky;
// [owned->defined in hrzsku.cpp] extern SVECTOR        sunPosInSky, moonPosInSky;   /* SVECTOR values */
// [owned->defined in hrzsku.cpp] extern int            gfxPmxHeightPercentage[];
// [owned->defined in hrzsku.cpp] extern Draw_tPixMap  *gpPmx;
extern int            Skid_gCtrlScratch_94;

/* ---- sky geometry + colours ---- */
// [owned->defined in hrzsku.cpp] extern SVECTOR        gSkyMesh[];
// [owned->defined in hrzsku.cpp] extern CVECTOR        gSkyColor[];
// [owned->defined in hrzsku.cpp] extern CVECTOR        gHrzRingColor[][5];
// [owned->defined in hrzsku.cpp] extern SVECTOR       *gRngCoordTop;        /* reservememadr'd */
/* Hrz_gSkyVtx_A0/A1/B0/B1 DEFINED in hrzsku.cpp (hrzsku-internal lost-symbol, not in SYM) */
// [owned->defined in hrzsku.cpp] extern CVECTOR        Hrz_gSaveCol[];
extern int            Hrz_gProjResultZ0;
extern int            Hrz_gProjScratch_9C;
// [owned->defined in hrzsku.cpp] extern SVECTOR        Hrz_gLightningPosInSky;
// [owned->defined in hrzsku.cpp] extern char           gSkyPixmapIndex[];
extern int            gSkyPixmapIndex_dummy;

/* ---- pixmaps ---- */
// [owned->defined in hrzsku.cpp] extern Draw_tPixMap   gHorizonPixmap[8];
// [owned->defined in hrzsku.cpp] extern Draw_tPixMap   gHorizonExtraSkyPixmaps;
extern Draw_tPixMap   gLightningPixmap[];

/* ---- lightning ---- */
extern int            Night_gLightning;
extern char           Night_gShowForks;
// [owned->defined in hrzsku.cpp] extern tHrz_Lightning gHrz_Lightning;       /* lightning fork buffer (104 B) */

/* ---- chunk vtx buffer ---- */
extern SVECTOR        DrawW_gChunkVtxBuf[];

/* ---- PsyQ libgpu / libgte helpers ---- */

/* ---- eaclib ---- */

/* ---- flare / texture / view ---- */
extern void  Flare_Sun(SVECTOR *v, Draw_FlareCache *fc);
extern void  Flare_Moon(SVECTOR *v, Draw_FlareCache *fc);
extern void  Flare_InitLensFlare(void);
extern void  Draw_SetViewColor(int view, int r, int g, int b);
extern void  Texture_CloneUVPmx(Draw_tPixMap *dst, int flag, Draw_tPixMap *src);

#endif
