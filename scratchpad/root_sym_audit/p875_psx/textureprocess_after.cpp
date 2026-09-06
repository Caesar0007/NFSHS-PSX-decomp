#include "C:/Temp/nfs4-decomp/recon/game/psx/textureprocess.h"
int (*p875_probe_0)(char * data,int numentry) = &TextureProcess_TransColorCheck;
void (*p875_probe_1)(int level,int maxlevel,char * data,int numentry,int cx,int cy) = &TextureProcess_ColorClut;
int (*p875_probe_2)(char * data,int numentry) = &TextureProcess_DepthColorCluts;
FogKey * (*p875_probe_3)(int currentslice,FogKey * fkey) = &Fog_CheckRange;
FogKey * (*p875_probe_4)(int currentslice,FogKey * fkey) = &Fog_FindKey;
FogKey * (*p875_probe_5)(void) = &Fog_AllocKey;
void (*p875_probe_6)(int slice,int distance) = &Fog_AddKey;
void (*p875_probe_7)(int player) = &Fog_Update;
char * (*p875_probe_8)(char * ext) = &Fog_MakeTrackPathName;
int (*p875_probe_9)(void) = &Fog_ReadFogKeys;
void (*p875_probe_10)(void) = &Fog_InitFogTriggers;
void (*p875_probe_11)(void) = &Fog_DeInitFogTriggers;
void (*p875_probe_12)(void) = &TextureProcess_Init;
void (*p875_probe_13)(int constrast,CVECTOR * color,short brightness) = &CV_ProcessWorldColors_FINAL;
void (*p875_probe_14)(int track,int weather,int night) = &CV_ColorTracks;
void (*p875_probe_15)(void) = &CV_InitColorVertices;
