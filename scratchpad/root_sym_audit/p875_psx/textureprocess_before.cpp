/* Frozen original recon/game/psx/textureprocess.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
int TextureProcess_TransColorCheck__FPci(char *data, int numentry);   /* :47 */
void TextureProcess_ColorClut__FiiPciii(int level, int maxlevel, char *data, int numentry, int cx, int cy);   /* :356 */
int TextureProcess_DepthColorCluts__FPci(char *data, int numentry);   /* :422 */
void * Fog_CheckRange__FiP6FogKey(int currentslice, FogKey *fkey);   /* :639 */
void * Fog_FindKey__FiP6FogKey(int currentslice, FogKey *fkey);   /* :665 */
void * Fog_AllocKey__Fv(void);   /* :716 */
void Fog_AddKey__Fii(int slice, int distance);   /* :733 */
void Fog_Update__Fi(int player);   /* :840 */
char * Fog_MakeTrackPathName__FPc(char *ext);   /* :1015 */
int Fog_ReadFogKeys__Fv(void);   /* :1026 */
void Fog_InitFogTriggers__Fv(void);   /* :1082 */
void Fog_DeInitFogTriggers__Fv(void);   /* :1123 */
void TextureProcess_Init__Fv(void);   /* :1135 */
void CV_ProcessWorldColors_FINAL__FiP7CVECTORs(int constrast, CVECTOR *color, short brightness);   /* :1156 */
void CV_ColorTracks__Fiii(int track, int weather, int night);   /* :1183 */
void CV_InitColorVertices__Fv(void);   /* :1539 */
int (*p875_probe_0)(char *data, int numentry) = &TextureProcess_TransColorCheck__FPci;
void (*p875_probe_1)(int level, int maxlevel, char *data, int numentry, int cx, int cy) = &TextureProcess_ColorClut__FiiPciii;
int (*p875_probe_2)(char *data, int numentry) = &TextureProcess_DepthColorCluts__FPci;
void * (*p875_probe_3)(int currentslice, FogKey *fkey) = &Fog_CheckRange__FiP6FogKey;
void * (*p875_probe_4)(int currentslice, FogKey *fkey) = &Fog_FindKey__FiP6FogKey;
void * (*p875_probe_5)(void) = &Fog_AllocKey__Fv;
void (*p875_probe_6)(int slice, int distance) = &Fog_AddKey__Fii;
void (*p875_probe_7)(int player) = &Fog_Update__Fi;
char * (*p875_probe_8)(char *ext) = &Fog_MakeTrackPathName__FPc;
int (*p875_probe_9)(void) = &Fog_ReadFogKeys__Fv;
void (*p875_probe_10)(void) = &Fog_InitFogTriggers__Fv;
void (*p875_probe_11)(void) = &Fog_DeInitFogTriggers__Fv;
void (*p875_probe_12)(void) = &TextureProcess_Init__Fv;
void (*p875_probe_13)(int constrast, CVECTOR *color, short brightness) = &CV_ProcessWorldColors_FINAL__FiP7CVECTORs;
void (*p875_probe_14)(int track, int weather, int night) = &CV_ColorTracks__Fiii;
void (*p875_probe_15)(void) = &CV_InitColorVertices__Fv;
