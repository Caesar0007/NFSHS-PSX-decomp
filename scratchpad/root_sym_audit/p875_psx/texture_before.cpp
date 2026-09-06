/* Frozen original recon/game/psx/texture.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Texture_InitPaletteSharing__Fv(void);   /* :64 */
void Texture_DeInitPaletteSharing__Fv(void);   /* :74 */
void Texture_ResetPaletteSharing__Fv(void);   /* :84 */
int Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi(int test, char *data, Draw_tPixMap *pmx, int bpp);   /* :90 */
void Texture_AddSharedPalette__FPcP12Draw_tPixMapi(char *ptr_to_data, Draw_tPixMap *ptr_to_pmx, int bpp);   /* :143 */
void Texture_InitClut__Fv(void);   /* :182 */
void Texture_GetClutId__FiPiT1(int bpp, int *xclut, int *yclut);   /* :221 */
void Texture_MenuReleaseClutId__Fs(short id);   /* :304 */
void Texture_ColorCarPalette__FPcT0i(char *from, char *to, int numentry);   /* :327 */
void Texture_CopyPalette__FPciii(char *data, int width, int x, int y);   /* :339 */
void Texture_ProcessPaletteCopy__FP15Texture_pal8bitii(Texture_pal8bit *palCopy, int palStart, int palNum);   /* :356 */
void Texture_LoadImage__FP4RECTPUl(RECT *imgrect, u_long *p);   /* :393 */
void Texture_Vramf__FP8shapetbliiii(shapetbl *shp, int x, int y, int clutx, int cluty);   /* :406 */
void Texture_Vramcf__FP8shapetbliiii(shapetbl *shp, int x, int y, int clutx, int cluty);   /* :468 */
int Texture_GetTranslucencyMode__FP8shapetbl(shapetbl *shp);   /* :514 */
void Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap(char *f, char *n, int ctrl, int rx, int ry, int cx, int cy, Draw_tPixMap *pmx);   /* :538 */
void Texture_CloneUVPmx__FP12Draw_tPixMapiT0(Draw_tPixMap *pmx, int mode, Draw_tPixMap *rpmx);   /* :672 */
void Texture_InitTrackTexture__Fv(void);   /* :726 */
void Texture_InitMenuClut__Fv(void);   /* :743 */
void Texture_InitMenuTexture__Fv(void);   /* :792 */
void Texture_CleanupMenuTexture__Fv(void);   /* :799 */
void Texture_LoadMenuTexture__Fv(void);   /* :811 */
void Texture_KillTrackTexture__Fv(void);   /* :847 */
void Texture_KillMenuTexture__Fv(void);   /* :855 */
void (*p875_probe_0)(void) = &Texture_InitPaletteSharing__Fv;
void (*p875_probe_1)(void) = &Texture_DeInitPaletteSharing__Fv;
void (*p875_probe_2)(void) = &Texture_ResetPaletteSharing__Fv;
int (*p875_probe_3)(int test, char *data, Draw_tPixMap *pmx, int bpp) = &Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi;
void (*p875_probe_4)(char *ptr_to_data, Draw_tPixMap *ptr_to_pmx, int bpp) = &Texture_AddSharedPalette__FPcP12Draw_tPixMapi;
void (*p875_probe_5)(void) = &Texture_InitClut__Fv;
void (*p875_probe_6)(int bpp, int *xclut, int *yclut) = &Texture_GetClutId__FiPiT1;
void (*p875_probe_7)(short id) = &Texture_MenuReleaseClutId__Fs;
void (*p875_probe_8)(char *from, char *to, int numentry) = &Texture_ColorCarPalette__FPcT0i;
void (*p875_probe_9)(char *data, int width, int x, int y) = &Texture_CopyPalette__FPciii;
void (*p875_probe_10)(Texture_pal8bit *palCopy, int palStart, int palNum) = &Texture_ProcessPaletteCopy__FP15Texture_pal8bitii;
void (*p875_probe_11)(RECT *imgrect, u_long *p) = &Texture_LoadImage__FP4RECTPUl;
void (*p875_probe_12)(shapetbl *shp, int x, int y, int clutx, int cluty) = &Texture_Vramf__FP8shapetbliiii;
void (*p875_probe_13)(shapetbl *shp, int x, int y, int clutx, int cluty) = &Texture_Vramcf__FP8shapetbliiii;
int (*p875_probe_14)(shapetbl *shp) = &Texture_GetTranslucencyMode__FP8shapetbl;
void (*p875_probe_15)(char *f, char *n, int ctrl, int rx, int ry, int cx, int cy, Draw_tPixMap *pmx) = &Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap;
void (*p875_probe_16)(Draw_tPixMap *pmx, int mode, Draw_tPixMap *rpmx) = &Texture_CloneUVPmx__FP12Draw_tPixMapiT0;
void (*p875_probe_17)(void) = &Texture_InitTrackTexture__Fv;
void (*p875_probe_18)(void) = &Texture_InitMenuClut__Fv;
void (*p875_probe_19)(void) = &Texture_InitMenuTexture__Fv;
void (*p875_probe_20)(void) = &Texture_CleanupMenuTexture__Fv;
void (*p875_probe_21)(void) = &Texture_LoadMenuTexture__Fv;
void (*p875_probe_22)(void) = &Texture_KillTrackTexture__Fv;
void (*p875_probe_23)(void) = &Texture_KillMenuTexture__Fv;
