/* flare_externs.h -- externs for game/psx/flare.cpp (NFS4 PSX lens-flare renderer).
   Sun/moon flares, halos, hex/oct light beams, 2D spikes, textured flare quads. */
#ifndef _GAME_PSX_FLARE_EXTERNS_H_
#define _GAME_PSX_FLARE_EXTERNS_H_

#include "flare_types.h"
#include "../../lib/psx_gte.h"   /* canonical PsyQ inline COP2/GTE macros (real cop2 words) */

/* ---- GPU packet cursors + matrices ---- */
extern matrixtdef    gWorldMat;                 /* 0x8010ee40 (36 B = 9 ints, game matrix) */

/* ---- camera / view / draw ---- */
extern int           Draw_gViewOtSize;          /* 0x8013d7b0 */
extern short         DrawC_gReflectOffset;       /* 0x8013d814 */
extern int           R3DCar_InMenu;              /* 0x8013d324 */

/* ---- track / setup / sim ---- */
/* Exact-symbol views use only records retained by flare.obj.  The field
 * offsets are GameSetup +12, TrackSpec +88, and simGlobal +4 respectively. */
extern GameSetup_tPerpData Flare_GameSetupView asm("GameSetup_gData");
extern BO_tNewtonCollisionInfo Flare_TrackSpecRows[] asm("TrackSpec_gSpec");
extern coorddef Flare_SimView asm("simGlobal");
#define FLARE_COMM_MODE  Flare_GameSetupView.HudColour
#define FLARE_TRACK_SKY  (*(CSkySpec *)((u_char *)Flare_TrackSpecRows + 88))
#define FLARE_GAME_TICKS Flare_SimView.y

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

extern "C" {
int random(void);
int fixedatan(int y, int x);
int isqrt(int value);
long VectorNormal(VECTOR *input, VECTOR *output);
MATRIX *RotMatrixZ(long angle, MATRIX *matrix);
void SetDrawMode(DR_MODE *packet, int dfe, int dtd, int tpage, RECT *window);
}

extern long           Camera_gGeomScreen;    /* 0x8013c7dc (owner: camera) */
#endif
