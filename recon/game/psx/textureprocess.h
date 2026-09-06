/* game/psx/textureprocess.h — reconstructed from game/psx/textureprocess.cpp (16 fns) */
#ifndef _GAME_PSX_TEXTUREPROCESS_H_
#define _GAME_PSX_TEXTUREPROCESS_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

int TextureProcess_TransColorCheck(char * data,int numentry);   /* SYM 475dcf @0x800e0884 */
void TextureProcess_ColorClut(int level,int maxlevel,char * data,int numentry,int cx,int cy);   /* SYM 475e01 @0x800e08b8 */
int TextureProcess_DepthColorCluts(char * data,int numentry);   /* SYM 475e31 @0x800e0ac0 */
FogKey * Fog_CheckRange(int currentslice,FogKey * fkey);   /* SYM 475e63 @0x800e0b98 */
FogKey * Fog_FindKey(int currentslice,FogKey * fkey);   /* SYM 475e94 @0x800e0bec */
FogKey * Fog_AllocKey(void);   /* SYM 475ec2 @0x800e0c80 */
void Fog_AddKey(int slice,int distance);   /* SYM 475ee9 @0x800e0ccc */
void Fog_Update(int player);   /* SYM 475f06 @0x800e0d80 */
char * Fog_MakeTrackPathName(char * ext);   /* SYM 475f22 @0x800e0ec4 */
int Fog_ReadFogKeys(void);   /* SYM 475f4a @0x800e0f14 */
void Fog_InitFogTriggers(void);   /* SYM 475f6b @0x800e102c */
void Fog_DeInitFogTriggers(void);   /* SYM 475f90 @0x800e1110 */
void TextureProcess_Init(void);   /* SYM 475fb7 @0x800e1134 */
void CV_ProcessWorldColors_FINAL(int constrast,CVECTOR * color,short brightness);   /* SYM 475fdc @0x800e1148 */
void CV_ColorTracks(int track,int weather,int night);   /* SYM 476013 @0x800e1308 */
void CV_InitColorVertices(void);   /* SYM 476035 @0x800e1510 */

#endif /* _GAME_PSX_TEXTUREPROCESS_H_ */
