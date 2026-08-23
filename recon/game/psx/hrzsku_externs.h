/* hrzsku_externs.h -- externs for game/psx/hrzsku.cpp (NFS4 PSX horizon + sky renderer).
   Sky ring/mesh/stars, lightning forks, GTE-projected horizon. */
#ifndef _GAME_PSX_HRZSKU_EXTERNS_H_
#define _GAME_PSX_HRZSKU_EXTERNS_H_

#include "../../lib/psx_gte.h"

/* Canonical PsyQ libgte inline COP2 macros (incl. the generic lone-store gte_swc2(reg,ptr))
   are vendored in psx_gte.h. Lone MAC3 / SZ1 / SZ2 stores here use that shared gte_swc2;
   all GTE loads use the canonical gte_ldv / gte_ldV macros (no gte_lwc2 value-form remains). */
/* Earlier Ghidra code-pointer artifacts are gone; the faithful gte_ macros are
   applied directly in the reconstructed function bodies. */

/* ---- GPU packet cursors + matrices ----
 * 🔴 DEAD IN hrzsku.cpp AND DELIBERATELY SO -- DO NOT REACH FOR THESE.  All four are
 * SCRATCHPAD-RESIDENT (methodology 3.6b), not linked globals: Render_gPacketLenLo/Hi are
 * the two shorts at 0x1F800010/0x1F800012 and Render_gWorldMat/gCopMat are scratchpad
 * matrices the GTE reads back -- writing the .bss symbol leaves the scratchpad copy STALE
 * (a RUNTIME bug the byte-match hides; independently re-proven in draww by w39-a2 for
 * Render_gWorldMat @0x1F800014, and by w38-a9 for Render_gMenuRenderFlag @0x1F80000C).
 * hrzsku.cpp reaches every one of them through the `hsd = (Draw_HorizonCache *)0x1f800000`
 * struct view instead; w39-a8 verified 0 code references here and 0 symbol-%hi-vs-
 * `lui 0x1F80`-literal diffs across all 22 hrzsku oracles.  Kept only because
 * game/common/camera.cpp also includes this header. */
extern char          *Render_gPacketEnd;
extern short          Render_gPacketLenLo, Render_gPacketLenHi;
extern MATRIX         Render_gWorldMat;
extern matrixtdef     Render_gCopMat;

/* ---- camera / view ---- */
extern long           Camera_gGeomScreen;
extern int            Draw_gViewOtSize;
extern int            Draw_gPlayer1View, Draw_gPlayer2View;

/* ---- track / setup ---- */
/* Exact-symbol views through records already emitted by hrzsku.obj.  The
   selected fields land at GameSetup +12 and TrackSpec +40/+88 respectively,
   preserving the retail aggregate-base MEM shapes without importing either
   foreign owner body. */
extern GameSetup_tPerpData Hrz_GameSetupView asm("GameSetup_gData");
extern BO_tNewtonCollisionInfo Hrz_TrackSpecRows[] asm("TrackSpec_gSpec");
extern BO_tNewtonCollisionInfo Hrz_TrackSpecHorizon asm("D_801232A4");
static inline u_char *Hrz_TrackAddressAt(int offset, BO_tNewtonCollisionInfo *base)
{ return (u_char *)base + offset; }
static inline int Hrz_TrackIntAt(int offset, BO_tNewtonCollisionInfo *base)
{ return *(int *)Hrz_TrackAddressAt(offset, base); }
static inline short Hrz_TrackShortAt(int offset, BO_tNewtonCollisionInfo *base)
{ return *(short *)Hrz_TrackAddressAt(offset, base); }
static inline u_short Hrz_TrackUShortAt(int offset, BO_tNewtonCollisionInfo *base)
{ return *(u_short *)Hrz_TrackAddressAt(offset, base); }
#define HRZ_GAMESETUP_COMM_MODE Hrz_GameSetupView.HudColour
#define HRZ_TRACK_HORIZON_STATE Hrz_TrackShortAt(4, Hrz_TrackSpecRows)
#define HRZ_TRACK_SKY_STATE     Hrz_TrackShortAt(6, Hrz_TrackSpecRows)
#define HRZ_TRACK_HORIZON_PTR   ((CHorizonSpec *)&Hrz_TrackSpecHorizon)
#define HRZ_TRACK_SKY_PTR       ((CSkySpec *)((u_char *)&Hrz_TrackSpecHorizon + 48))
#define HRZ_TRACK_INIT_SKY_FLAGS (*(int *)((u_char *)&Hrz_TrackSpecHorizon + 52))
#define HRZ_TRACK_SKY_FLAGS     Hrz_TrackIntAt(92, Hrz_TrackSpecRows)
#define HRZ_TRACK_SUN_HEIGHT    Hrz_TrackUShortAt(144, Hrz_TrackSpecRows)
#define HRZ_TRACK_MOON_HEIGHT   Hrz_TrackUShortAt(152, Hrz_TrackSpecRows)
#define HRZ_TRACK_SKY_YOFFSET   Hrz_TrackUShortAt(192, Hrz_TrackSpecRows)
// [owned->defined in hrzsku.cpp] extern CHorizonSpec  *Hrz_gTrackSpec;            /* horizon spec (angle/height/frontColor/ringPMX) */
// [owned->defined in hrzsku.cpp] extern CSkySpec      *Sky_gTrackSpec;            /* sky spec (numStars/frontcolors/...) */
extern void           trap(int c);
// [owned->defined in hrzsku.cpp] static u_long        *starColors;        /* SYM PTR ULONG */
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
extern Draw_tPixMap  *gLightningPixmap[];        /* was stale array-of-VALUE shape (missing the pointer
                                                     level); owner (genericpmx.cpp) defines it as
                                                     Draw_tPixMap *gLightningPixmap[16] (array of
                                                     POINTERS). The one live consumer in hrzsku.cpp
                                                     already worked around this via an explicit
                                                     (Draw_tPixMap**) cast -- fixing the decl removes
                                                     the need for that workaround but the cast is left
                                                     in place (byte-matched fn, don't disturb its form) */

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

extern "C" {
int random(void);
void seedrandom(int seed);
void *reservememadr(const char *name, int size, int flags);
int purgememadr(void *p);
int fixedsin(int angle);
int fixedcos(int angle);
int fixedmult(int a, int b);
void *memset(void *dst, int value, int size);
void SetDrawMode(DR_MODE *p, int dfe, int dtd, int tpage, RECT *tw);
void SetGeomScreen(int h);
void SetPolyGT4(POLY_GT4 *p);
}

#endif
