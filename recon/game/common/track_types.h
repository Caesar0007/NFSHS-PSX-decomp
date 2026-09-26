/* Track.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_TRACK_TYPES_H
#define NFS4_GAME_COMMON_TRACK_TYPES_H

#define NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES
#include "chunk_types.h"
#undef NFS4_CHUNK_OMIT_TRACK_FOREIGN_TYPES

#include "shared/BW_tContext.h"






#include "shared/CHorizonSpec.h"




#include "shared/CSkySpec.h"











#include "shared/CNightSpec.h"
#include "shared/CWeatherSpec.h"
#include "shared/CFogSpec.h"
#include "shared/CDepthCueSpec.h"
#include "shared/CWorldColor.h"





typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"




#include "shared/Sched_tSchedule.h"




struct Trk_Material {
    short shapeIndex;
    u_char flag, uvFlag, r, g, b;
    char textureCount;
    u_char interval;
    char pad;
};
struct TrackHeader {
    int type, version, maxMetaChunkSize, maxGeomCollSize;
    int maxFullSize, maxSplitSize, metaChunkCount, chunkCount;
};
struct SaveSurface {
    short fCount, fMaxCount;
    tSaveSurface *fStack;
    SaveSurface(int numEntries);
    ~SaveSurface();
    void Save(Trk_NewSimQuad *simQuad);
    void RestoreAll();
};
#include "shared/tBoundingSphere.h"
struct Track_MipMap {
    u_short code[2];
    int shapeParentIndex, mipMapIndex;
};
struct Track_MultiPalette {
    u_char charcode[2];
    short palnum, origshapeindex, actualshapeindex;
};
struct Track_tMaterialController {
    short type;
    u_char textureMax;
    char pad;
    u_char uv0, uv1, uv2, uv3;
    char textureCount;
    u_char interval;
    short pmxIndex;
    Track_tMaterial *matPtr;
};

/* Canonical trackspec.obj aggregate used by this translation unit. */
#include "shared/CTrackSpec.h"










/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"















#include "shared/Sim_tSimGlobalVar.h"




#endif
