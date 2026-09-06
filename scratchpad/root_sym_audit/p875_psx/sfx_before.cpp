/* Frozen original recon/game/psx/sfx.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Sfx_Transform__FP8coorddefP7SVECTORT0(coorddef *worldpt, SVECTOR *campt, coorddef *t);   /* :40 */
void Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *cpixmap);   /* :106 */
void Sfx_ThickenXZ__FP7SVECTORP8coorddefN21(SVECTOR *d, coorddef *pt1, coorddef *pt2, coorddef *cp);   /* :163 */
void Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *t, Draw_tPixMap *c);   /* :290 */
void Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache(Draw_tPixMap *pmx, SVECTOR *pt, int mode, int offset, Sfx_tCache *sd);   /* :306 */
void Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle(DRender_tView *Vi, Souffle_tISouffle *is);   /* :367 */
void Sfx_Add__FP17Souffle_tISouffle(Souffle_tISouffle *is);   /* :534 */
void (*p875_probe_0)(coorddef *worldpt, SVECTOR *campt, coorddef *t) = &Sfx_Transform__FP8coorddefP7SVECTORT0;
void (*p875_probe_1)(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *cpixmap) = &Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap;
void (*p875_probe_2)(SVECTOR *d, coorddef *pt1, coorddef *pt2, coorddef *cp) = &Sfx_ThickenXZ__FP7SVECTORP8coorddefN21;
void (*p875_probe_3)(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *t, Draw_tPixMap *c) = &Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2;
void (*p875_probe_4)(Draw_tPixMap *pmx, SVECTOR *pt, int mode, int offset, Sfx_tCache *sd) = &Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache;
void (*p875_probe_5)(DRender_tView *Vi, Souffle_tISouffle *is) = &Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle;
void (*p875_probe_6)(Souffle_tISouffle *is) = &Sfx_Add__FP17Souffle_tISouffle;
