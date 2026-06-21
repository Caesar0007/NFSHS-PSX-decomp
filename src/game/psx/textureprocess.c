#include "common.h"

INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_TransColorCheck__FPci);
INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_ColorClut__FiiPciii);
INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_DepthColorCluts__FPci);
INCLUDE_ASM("asm/nonmatchings/main", Fog_CheckRange__FiP6FogKey);
INCLUDE_ASM("asm/nonmatchings/main", Fog_FindKey__FiP6FogKey);
INCLUDE_ASM("asm/nonmatchings/main", Fog_AllocKey__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Fog_AddKey__Fii);
INCLUDE_ASM("asm/nonmatchings/main", Fog_Update__Fi);
INCLUDE_ASM("asm/nonmatchings/main", Fog_MakeTrackPathName__FPc);
INCLUDE_ASM("asm/nonmatchings/main", Fog_ReadFogKeys__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Fog_InitFogTriggers__Fv);
INCLUDE_ASM("asm/nonmatchings/main", Fog_DeInitFogTriggers__Fv);
INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_Init__Fv);
INCLUDE_ASM("asm/nonmatchings/main", CV_ProcessWorldColors_FINAL__FiP7CVECTORs);
INCLUDE_ASM("asm/nonmatchings/main", CV_ColorTracks__Fiii);
INCLUDE_ASM("asm/nonmatchings/main", CV_InitColorVertices__Fv);
