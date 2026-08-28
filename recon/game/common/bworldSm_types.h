/* bworldSm.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_COMMON_BWORLDSM_TYPES_H
#define NFS4_GAME_COMMON_BWORLDSM_TYPES_H

/* bworldSm.obj contains color.obj's complete 71-record game/platform graph. */
#include "color_types.h"

struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk;
    int chunkFarZClipSq;
    int polyFarZClipSq;
    int lowDetailDistSq;
    int lineFarZClipSq;
};

struct tNormalCacheEntry {
    short sliceInd;
    u_char triangleFlag;
    char quadInd;
    coorddef normal, forward;
    u_long accessTime;
};

#endif
