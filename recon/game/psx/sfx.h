/* game/psx/sfx.h — reconstructed from game/psx/sfx.cpp (7 fns) */
#ifndef _GAME_PSX_SFX_H_
#define _GAME_PSX_SFX_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Sfx_Transform(coorddef * worldpt,SVECTOR * campt,coorddef * t);   /* SYM 45b502 @0x800dd050 */
void Sfx_BuildSmokeFacet(Souffle_tISouffle * is,sfxsouffle * dSouffle,Draw_tPixMap * cpixmap);   /* SYM 45b535 @0x800dd1a4 */
void Sfx_ThickenXZ(SVECTOR * d,coorddef * pt1,coorddef * pt2,coorddef * cp);   /* SYM 45b589 @0x800dd370 */
void Sfx_BuildFastDisolveFacet(Souffle_tISouffle * is,sfxsouffle * dSouffle,Draw_tPixMap * t,Draw_tPixMap * c);   /* SYM 45b5bd @0x800dd528 */
void Sfx_AdditivePrim(Draw_tPixMap * pmx,SVECTOR * pt,int mode,int offset,Sfx_tCache * sd);   /* SYM 45b619 @0x800dd598 */
void Sfx_BuildSouffleFacet(DRender_tView * Vi,Souffle_tISouffle * is);   /* SYM 45b661 @0x800dd790 */
void Sfx_Add(Souffle_tISouffle * is);   /* SYM 45b6ab @0x800de638 */

#endif /* _GAME_PSX_SFX_H_ */
