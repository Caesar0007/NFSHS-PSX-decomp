/* game/psx/flare.h — reconstructed from game/psx/flare.cpp (27 fns) */
#ifndef _GAME_PSX_FLARE_H_
#define _GAME_PSX_FLARE_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Flare_Tri(long * cp,long * p1,long * p2,int otz);   /* SYM 402840 @0x800cbcb0 */
void Flare_SetMatrix(matrixtdef * m);   /* SYM 402860 @0x800cbd4c */
void Flare_IdentMatrix(MATRIX * mtx);   /* SYM 40288d @0x800cbdf8 */
void Flare_OctFlare(long * center,int otz);   /* SYM 4028b7 @0x800cbe14 */
void Flare_OctFlareSpikes(long * center,int otz);   /* SYM 4028d9 @0x800cc034 */
void Flare_Spikes(long * center,int otz);   /* SYM 402901 @0x800cc3b8 */
void Flare_HexFlare(long * center,int otz);   /* SYM 402921 @0x800cc694 */
void Flare_ReflectHexFlare(long * center,int otz);   /* SYM 402943 @0x800cc868 */
void Flare_QuadFlare(long * center,int otz);   /* SYM 40296c @0x800cca3c */
void Flare_CarShapedHalo(int type,COORD16 * ptCenter,COORD16 * pt1,COORD16 * pt2,short flag,int otz,Draw_FlareCache * sd);   /* SYM 40298f @0x800ccb58 */
void Flare_Halo2(DRender_tView * Vi,int scale,int type,coorddef * fpt,coorddef * fpt2,Draw_FlareCache *);   /* SYM 4029d4 @0x800cd530 */
void Flare_Halo(DRender_tView * Vi,int scale,int type,coorddef * fpt,Draw_FlareCache * sd);   /* SYM 402a20 @0x800cde9c */
void Flare_2DSpike(long * center,long * end,int otz);   /* SYM 402a69 @0x800cdec4 */
void Flare_2DHalo(int x,int y,int scalex,int scaley,int type);   /* SYM 402a8c @0x800cdf70 */
void Flare_PreCalcHexLightBeam(long * center,int otz);   /* SYM 402aae @0x800ce34c */
void Flare_Quad(long * pt,CVECTOR * color,int otz);   /* SYM 402adb @0x800ce420 */
void Flare_QuadNotTransparent(long * pt,CVECTOR * color,int otz);   /* SYM 402b02 @0x800ce4c4 */
void Flare_QuadRing(long * pt,CVECTOR * color,int otz);   /* SYM 402b37 @0x800ce568 */
void Flare_TextureQuad(long * pt,CVECTOR * color,char type,int otz);   /* SYM 402b62 @0x800ce61c */
void Flare_SingleColorTex(DVECTOR * xy,CVECTOR * color,int width,int height,char type,int otz);   /* SYM 402b91 @0x800ce6f8 */
void Flare_SingleColorHex(DVECTOR * xy,CVECTOR * color,int width,int height,int otz);   /* SYM 402bcc @0x800ce79c */
void Flare_SingleColorOct(DVECTOR * xy,CVECTOR * color,int width,int height,int otz);   /* SYM 402c06 @0x800ce8b0 */
void Flare_SingleColorOctRing(DVECTOR * xy,CVECTOR * color,int width,int height,int otz);   /* SYM 402c40 @0x800ce988 */
void Flare_InitLensFlare(void);   /* SYM 402c7e @0x800ceb44 */
void Flare_LensFlare(DVECTOR * screenPos,Draw_FlareCache * sd);   /* SYM 402ca3 @0x800ceb6c */
void Flare_Sun(SVECTOR * worldPos,Draw_FlareCache * sd);   /* SYM 402cde @0x800cf1d0 */
void Flare_Moon(SVECTOR * worldPos,Draw_FlareCache * sd);   /* SYM 402d13 @0x800cf4bc */

#endif /* _GAME_PSX_FLARE_H_ */
