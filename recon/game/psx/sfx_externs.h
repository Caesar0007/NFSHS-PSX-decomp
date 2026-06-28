/* sfx_externs.h -- externs for game/psx/sfx.cpp (NFS4 PSX "souffle" smoke/dust/spark FX renderer) */
#ifndef _GAME_PSX_SFX_EXTERNS_H_
#define _GAME_PSX_SFX_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"
#include "../../lib/psx_gte.h"

/* ---- module / render globals ---- */
extern matrixtdef    gWorldMat;        /* 0x8010ee40  world->camera matrix (set per facet) */
extern Draw_tPixMap *gSMokePixmap[2];  /* 0x8013d1f4  smoke texture pixmaps (rnd 0/1) */
extern Draw_tPixMap *gSMokePalette;    /* 0x8013d1fc  smoke CLUT pixmap */
extern Draw_tPixMap *gSparkHPixmap[];  /* 0x80112b54  spark/dissolve frame pixmaps */
extern Draw_tPixMap *gDirtPalette;     /* 0x8013d200 */
extern Draw_tPixMap *gGravelPixmap[2]; /* 0x8013d204 */
extern Draw_tPixMap *gGravelPalette;   /* 0x8013d20c */
extern Draw_tPixMap *gGrassPalette;    /* 0x8013d210 */
extern Draw_tPixMap *gSnowPalette;     /* 0x8013d214 */
extern Draw_tPixMap *gLeafPixmap;      /* 0x8013d218 */
extern Sfx_tCache    Sfx_gCache;       /* scratchpad OT render cache (0x1f800000) */
extern int           Draw_gViewOtSize; /* 0x8013d7b0  ordering-table size */
extern u_char       *Render_gPacketPtr;   /* GPU packet write cursor (scratchpad) */
extern u_char       *Render_gPalettePtr;  /* OT palette cursor (scratchpad) */
extern GameSetup_tData GameSetup_gData;   /* 0x801131ec */

/* ---- eaclib / math / gpu helpers ---- */
extern void  TrsProj_SetPsxMatrix(matrixtdef *m, coorddef *trans);
extern void  Math_NormalizeVector(coorddef *v);
extern void  ChangeTPage(u_short *tpage, int abr);

/* ---- GTE (COP2) macros: the real canonical PsyQ inline-asm forms come from psx_gte.h
 *      (included above). The former no-op stubs here SHADOWED them and made every GTE
 *      stream a far-miss — removed so the cop2 instructions actually emit. ---- */

/* ---- this module (forward decls for intra-TU calls) ---- */
extern void Sfx_Transform(coorddef *worldpt, SVECTOR *campt, coorddef *t);
extern void Sfx_BuildSmokeFacet(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *cpixmap);
extern void Sfx_ThickenXZ(SVECTOR *d, coorddef *pt1, coorddef *pt2, coorddef *cp);
extern void Sfx_BuildFastDisolveFacet(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *t, Draw_tPixMap *c);
extern void Sfx_AdditivePrim(Draw_tPixMap *pmx, SVECTOR *pt, int mode, int offset, Sfx_tCache *sd);

#endif
