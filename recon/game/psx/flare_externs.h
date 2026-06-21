/* flare_externs.h -- externs for game/psx/flare.cpp (NFS4 PSX lens-flare renderer).
   Sun/moon flares, halos, hex/oct light beams, 2D spikes, textured flare quads. */
#ifndef _GAME_PSX_FLARE_EXTERNS_H_
#define _GAME_PSX_FLARE_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- GTE pipeline (PsyQ libgte). Faithful symbolic intrinsics (no-op macros, sealed-module
   convention); the cop2 op sequence is shown explicitly per the disasm-proto decode. ---- */
extern void gte_rtps(void);
extern void gte_rtpt(void);
extern void gte_lwc2(int reg, int data);
extern void gte_swc2(int reg, void *ptr);
#define gte_SetRotMatrix(mp)    ((void)(mp))  /* ctc2 R -> cop2 ctrl 0..4  (5 ctc2)     */
#define gte_SetTransMatrix(mp)  ((void)(mp))  /* ctc2 TR -> cop2 ctrl 5..7 (3 ctc2)     */
#define gte_ldsv(p)             ((void)(p))   /* mtc2 short-vector -> IR1..3 (3 mtc2)   */
#define gte_stsv(p)             ((void)(p))   /* mfc2 IR1..3 -> short-vector (3 mfc2)   */
#define gte_stsxy(p)            ((void)(p))   /* mfc2 SXY2 -> DVECTOR (screen xy)       */
#define gte_stsz(p)             ((void)(p))   /* mfc2 SZ3  -> short   (projected depth) */
#define gte_rtir(args...)           ((void)0)   /* RotIR / mvmva (transform IR vector)     */
#define gte_ldtr(args...)           ((void)0)   /* load translation vector to cop2         */
#define gte_rtps_b(args...)         ((void)0)   /* RTPS variant (buffered)                 */
   /* PsyQ libgte RotMatrixZ */
typedef void (code)(void);
typedef long long undefined8;
typedef unsigned long long ulonglong;
static inline u_int   CONCAT22(u_short hi, u_short lo) { return ((u_int)hi << 16) | lo; }
static inline u_short CONCAT11(u_char hi, u_char lo)   { return (u_short)(((u_int)hi << 8) | lo); }
static inline u_short SUB42(u_int v, int n) { return (u_short)(v >> (n * 8)); }

/* ---- GPU packet cursors + matrices ---- */
extern char         *Render_gPacketPtr;
extern char         *Render_gPalettePtr;
extern char         *Render_gPacketEnd;
extern matrixtdef    gWorldMat;                 /* 0x8010ee40 (36 B = 9 ints, game matrix) */

/* ---- camera / view / draw ---- */
extern int           Draw_gViewOtSize;          /* 0x8013d7b0 */
extern short         DrawC_gReflectOffset;       /* 0x8013d814 */
extern int           R3DCar_InMenu;              /* 0x8013d324 */

/* ---- track / setup / sim ---- */
extern CTrackSpec    TrackSpec_gSpec;            /* 0x8012327c */
extern GameSetup_tData GameSetup_gData;          /* 0x801131ec */
extern Sim_tSimGlobalVar simGlobal;              /* 0x8011e0ac */

/* ---- flare geometry + colour tables ---- */
// [owned->defined in flare.cpp] extern Flare_tInfo      Flare_gType[34];          /* 0x8011ff68 (544 B) flare-type defs (chalo/cbeam/flags/scale) */
// [owned->defined in flare.cpp] extern FLARE_DEF        gFlare_LensFlare;         /* 0x80120278 (128 B) lens-flare state (pos/size/piece/oldpos/isDrawn) */
// [owned->defined in flare.cpp] extern FLARE_PIECE_DEF  Flare_SunFlarePieces[9];  /* 0x801201e8 (144 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gLensOct[8];         /* 0x801201a8 (64 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gOct[8];             /* 0x8011fe68 (64 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gSpikes[4];          /* 0x8011fe48 (32 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gHex[6];             /* 0x8011fee8 (48 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gReflectHex[6];      /* 0x8011ff18 (48 B) */
// [owned->defined in flare.cpp] extern SVECTOR          Flare_gQuad[4];            /* 0x8011ff48 (32 B) */
extern Draw_tPixMap    *gFlarePixmap[3];          /* 0x80112b88 */
// [owned->defined in flare.cpp] extern CVECTOR          gfrgb;                    /* 0x8013d86c (halo colour scratch)  */
// [owned->defined in flare.cpp] extern CVECTOR          gfrgb2;                   /* 0x8013d870 (beam colour scratch)  */
// [owned->defined in flare.cpp] extern int              gscale;                   /* 0x8013d874 */
// [owned->defined in flare.cpp] extern short            gfHexPt1[6], gfHexPt2[6];     /* 0x8011fe30/3c */
// [owned->defined in flare.cpp] extern short            gfOctPt1[8], gfOctPt2[8];     /* 0x8011fe10/20 */
// [owned->defined in flare.cpp] extern short            gfSpikePt1[8], gfSpikePt2[8]; /* 0x8011fdf0/fe00 */

/* ---- PsyQ libgpu / libgte + eaclib + helpers ---- */

#endif
