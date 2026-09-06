/* game/psx/texture.h — reconstructed from game/psx/texture.cpp (24 fns) */
#ifndef _GAME_PSX_TEXTURE_H_
#define _GAME_PSX_TEXTURE_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Texture_InitPaletteSharing(void);   /* SYM 46ae2c @0x800df5b4 */
void Texture_DeInitPaletteSharing(void);   /* SYM 46ae58 @0x800df630 */
void Texture_ResetPaletteSharing(void);   /* SYM 46ae86 @0x800df678 */
int Texture_CheckForSharedPalette(int test,char * data,Draw_tPixMap * pmx,int bpp);   /* SYM 46aeb3 @0x800df688 */
void Texture_AddSharedPalette(char * ptr_to_data,Draw_tPixMap * ptr_to_pmx,int bpp);   /* SYM 46aef4 @0x800df7bc */
void Texture_InitClut(void);   /* SYM 46af2f @0x800df834 */
void Texture_GetClutId(int bpp,int * xclut,int * yclut);   /* SYM 46af51 @0x800df938 */
void Texture_MenuReleaseClutId(short id);   /* SYM 46af78 @0x800df9a4 */
void Texture_ColorCarPalette(char * from,char * to,int numentry);   /* SYM 46afa3 @0x800dfa04 */
void Texture_CopyPalette(char * data,int width,int x,int y);   /* SYM 46afd0 @0x800dfa3c */
void Texture_ProcessPaletteCopy(Texture_pal8bit * palCopy,int palStart,int palNum);   /* SYM 46aff9 @0x800dfa9c */
void Texture_LoadImage(RECT * imgrect,u_long * p);   /* SYM 46b038 @0x800dfb48 */
void Texture_Vramf(shapetbl * shp,int x,int y,int clutx,int cluty);   /* SYM 46b063 @0x800dfb8c */
void Texture_Vramcf(shapetbl * shp,int x,int y,int clutx,int cluty);   /* SYM 46b08f @0x800dfd38 */
int Texture_GetTranslucencyMode(shapetbl * shp);   /* SYM 46b0bc @0x800dfea0 */
void Texture_LoadPmx(char * f,char * n,int ctrl,int rx,int ry,int cx,int cy,Draw_tPixMap * pmx);   /* SYM 46b0f2 @0x800dff18 */
void Texture_CloneUVPmx(Draw_tPixMap * pmx,int mode,Draw_tPixMap * rpmx);   /* SYM 46b12a @0x800e0358 */
void Texture_InitTrackTexture(void);   /* SYM 46b15f @0x800e04b8 */
void Texture_InitMenuClut(void);   /* SYM 46b189 @0x800e0510 */
void Texture_InitMenuTexture(void);   /* SYM 46b1af @0x800e0610 */
void Texture_CleanupMenuTexture(void);   /* SYM 46b1d8 @0x800e0638 */
void Texture_LoadMenuTexture(void);   /* SYM 46b204 @0x800e0698 */
void Texture_KillTrackTexture(void);   /* SYM 46b22d @0x800e084c */
void Texture_KillMenuTexture(void);   /* SYM 46b257 @0x800e0854 */

#endif /* _GAME_PSX_TEXTURE_H_ */
