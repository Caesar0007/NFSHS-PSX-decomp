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

/* Packet bounds and transform work areas are fields of the fixed-address
   Draw_HorizonCache at 0x1F800000, not linked globals. */

/* ---- camera / view ---- */
extern long           Camera_gGeomScreen;
extern int            Draw_gViewOtSize;
extern int            Draw_gPlayer1View, Draw_gPlayer2View;

/* ---- track / setup ---- */
extern GameSetup_tData GameSetup_gData;
extern CTrackSpec TrackSpec_gSpec;
// [owned->defined in hrzsku.cpp] extern CHorizonSpec  *Hrz_gTrackSpec;            /* horizon spec (angle/height/frontColor/ringPMX) */
// [owned->defined in hrzsku.cpp] extern CSkySpec      *Sky_gTrackSpec;            /* sky spec (numStars/frontcolors/...) */
extern void           trap(int c);
// [owned->defined in hrzsku.cpp] static u_long        *starColors;        /* SYM PTR ULONG */
// [owned->defined in hrzsku.cpp] extern SVECTOR       *starPosInSky;
// [owned->defined in hrzsku.cpp] extern SVECTOR        sunPosInSky, moonPosInSky;   /* SVECTOR values */
// [owned->defined in hrzsku.cpp] extern int            gfxPmxHeightPercentage[];
// [owned->defined in hrzsku.cpp] extern Draw_tPixMap  *gpPmx;

/* ---- sky geometry + colours ---- */
// [owned->defined in hrzsku.cpp] extern SVECTOR        gSkyMesh[];
// [owned->defined in hrzsku.cpp] extern CVECTOR        gSkyColor[];
// [owned->defined in hrzsku.cpp] extern CVECTOR        gHrzRingColor[][5];
// [owned->defined in hrzsku.cpp] extern SVECTOR       *gRngCoordTop;        /* reservememadr'd */
// [owned->defined in hrzsku.cpp] extern CVECTOR        Hrz_gSaveCol[];
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
