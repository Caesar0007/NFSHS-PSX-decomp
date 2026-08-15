/* game/psx/textureprocess.h — reconstructed from game/psx/textureprocess.cpp (16 fns) */
#ifndef _GAME_PSX_TEXTUREPROCESS_H_
#define _GAME_PSX_TEXTUREPROCESS_H_
#include "../../nfs4_types.h"

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

#endif /* _GAME_PSX_TEXTUREPROCESS_H_ */
