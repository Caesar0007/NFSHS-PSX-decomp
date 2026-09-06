#include "C:/Temp/nfs4-decomp/recon/game/psx/sfx.h"
void (*p875_probe_0)(coorddef * worldpt,SVECTOR * campt,coorddef * t) = &Sfx_Transform;
void (*p875_probe_1)(Souffle_tISouffle * is,sfxsouffle * dSouffle,Draw_tPixMap * cpixmap) = &Sfx_BuildSmokeFacet;
void (*p875_probe_2)(SVECTOR * d,coorddef * pt1,coorddef * pt2,coorddef * cp) = &Sfx_ThickenXZ;
void (*p875_probe_3)(Souffle_tISouffle * is,sfxsouffle * dSouffle,Draw_tPixMap * t,Draw_tPixMap * c) = &Sfx_BuildFastDisolveFacet;
void (*p875_probe_4)(Draw_tPixMap * pmx,SVECTOR * pt,int mode,int offset,Sfx_tCache * sd) = &Sfx_AdditivePrim;
void (*p875_probe_5)(DRender_tView * Vi,Souffle_tISouffle * is) = &Sfx_BuildSouffleFacet;
void (*p875_probe_6)(Souffle_tISouffle * is) = &Sfx_Add;
