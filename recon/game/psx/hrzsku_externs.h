/* hrzsku_externs.h -- externs for game/psx/hrzsku.cpp (NFS4 PSX horizon + sky renderer).
   Sky ring/mesh/stars, lightning forks, GTE-projected horizon. */
#ifndef _GAME_PSX_HRZSKU_EXTERNS_H_
#define _GAME_PSX_HRZSKU_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* GTE rotation/transform/perspective macros (PsyQ libgte). Reconstruction treats the GTE pipeline
   as intrinsics: SetRotMatrix/SetTransMatrix load the cop2 regs, gte_rtps/rtpt do the projection. */
extern void gte_rtps(void);   /* RotTransPers (1 vertex; results read from cop2 SXY/SZ) */
extern void gte_rtpt(void);   /* RotTransPers3 (3 vertices) */
extern void gte_lwc2(int reg, int data);   /* load word to cop2 data reg */
extern void gte_swc2(int reg, void *ptr);  /* store cop2 data reg to memory */
/* GTE control-reg matrix loads (ctc2). Faithful symbolic intrinsics (no-op placeholders, matching
   the convention in the sealed trsproj/weather modules) -- the matrix build is shown explicitly. */
#define gte_SetRotMatrix(mp)    ((void)(mp))   /* ctc2 R11R12..R33  (cop2 ctrl 0..5)  */
#define gte_SetTransMatrix(mp)  ((void)(mp))   /* ctc2 TRX/TRY/TRZ  (cop2 ctrl 5..7)  */
/* Ghidra renders raw GTE COP2 ops as calls through a code-ptr to a HW address: (*(code*)0xADDR)().
   Typedef makes them compile; the faithful gte_ macros are applied in the per-fn BODY pass. */
typedef void (code)(void);
typedef long long undefined8;
typedef unsigned long long ulonglong;
/* Ghidra byte-concat / sub-word extract macros */
static inline u_int   CONCAT22(u_short hi, u_short lo) { return ((u_int)hi << 16) | lo; }
static inline u_short SUB42(u_int v, int n) { return (u_short)(v >> (n * 8)); }

/* ---- GPU packet cursors + matrices ---- */
extern char          *Render_gPacketPtr;
extern char          *Render_gPalettePtr;
extern char          *Render_gPacketEnd;
extern short          Render_gPacketLenLo, Render_gPacketLenHi;
extern MATRIX         Render_gWorldMat;
extern MATRIX         Render_gCopMat;

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
