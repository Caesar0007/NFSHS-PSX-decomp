/* game/psx/sfx.h — reconstructed from game/psx/sfx.cpp (7 fns) */
#ifndef _GAME_PSX_SFX_H_
#define _GAME_PSX_SFX_H_
#include "../../nfs4_types.h"

void Sfx_Transform__FP8coorddefP7SVECTORT0(coorddef *worldpt, SVECTOR *campt, coorddef *t);   /* :40 */
void Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *cpixmap);   /* :106 */
void Sfx_ThickenXZ__FP7SVECTORP8coorddefN21(SVECTOR *d, coorddef *pt1, coorddef *pt2, coorddef *cp);   /* :163 */
void Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2(Souffle_tISouffle *is, sfxsouffle *dSouffle, Draw_tPixMap *t, Draw_tPixMap *c);   /* :290 */
void Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache(Draw_tPixMap *pmx, SVECTOR *pt, int mode, int offset, Sfx_tCache *sd);   /* :306 */
void Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle(DRender_tView *Vi, Souffle_tISouffle *is);   /* :367 */
void Sfx_Add__FP17Souffle_tISouffle(Souffle_tISouffle *is);   /* :534 */

#endif /* _GAME_PSX_SFX_H_ */
