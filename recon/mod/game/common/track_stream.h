#ifndef NFS4_GAME_MOD_TRACK_STREAM_H
#define NFS4_GAME_MOD_TRACK_STREAM_H

enum TrackModLoadRoute {
    TRACKMOD_LOAD_ERROR = -1,
    TRACKMOD_LOAD_RETAIL = 0,
    TRACKMOD_LOAD_STREAMED = 1
};

enum TrackModLoadError {
    TRACKMOD_OK = 0,
    TRACKMOD_BAD_SIZE = 1,
    TRACKMOD_TOO_LARGE_WITHOUT_STREAM = 2
};

struct TrackModLoadDecision {
    int route;
    int error;
    unsigned int grpSize;
    unsigned int requiredRetailBytes;
    unsigned int availableRetailBytes;
};

struct TrackModResidentHeader {
    char magic[4];
    unsigned int version;
    unsigned int chunkCount;
    unsigned int trackHeaderBytes;
    unsigned int centerBytes;
    unsigned int persistentBytes;
    unsigned int lightBytes;
    unsigned int visibilityBytes;
};

struct TrackModGeometryHeader {
    char magic[4];
    unsigned int version;
    unsigned int chunkCount;
    unsigned int metaCount;
    unsigned int maxMetaBytes;
    unsigned int maxResidentChunkBytes;
};

struct TrackModGeometryIndex {
    const TrackModGeometryHeader *header;
    const unsigned int *metaOffsets;
    const unsigned short *metaIndex;
    const unsigned int *residentChunkBytes;
    unsigned int indexBytes;
};

struct TrackModStreamState {
    int fileHandle;
    int loadedMeta;
    void *indexStorage;
    void *metaBuffer;
    void *prefetchBuffer;
    int prefetchMeta;
    unsigned int prefetchOp;
    int runtimeMode;
    TrackModGeometryIndex index;
};

struct TrackModSerializedHeader {
    int type;
    int length;
    unsigned int dummy;
    int count;
};

struct TrackModResidentState {
    int fileHandle;
    TrackModResidentHeader header;
    void *trackHeader;
    void *centers;
    void *lightGroup;
    unsigned short *visibilityRows;
    unsigned int persistentOffset;
};

extern "C" int TrackMod_ParseGeometryIndex(
    const void *data, unsigned int bytes, TrackModGeometryIndex *out);
extern "C" int TrackMod_GetChunkMeta(
    const TrackModGeometryIndex *index, unsigned int chunk);
extern "C" unsigned int TrackMod_GetMetaOffset(
    const TrackModGeometryIndex *index, unsigned int meta);
extern "C" unsigned int TrackMod_GetChunkResidentBytes(
    const TrackModGeometryIndex *index, unsigned int chunk);
extern "C" int TrackMod_MakeCompanionName(
    const char *grpName, char *output, unsigned int capacity, char finalLetter);
extern "C" int TrackMod_OpenGeometryStream(
    const char *grpName, TrackModStreamState *state);
extern "C" int TrackMod_LoadMetaBlocking(TrackModStreamState *state, unsigned int meta);
extern "C" int TrackMod_LoadMetaSync(
    TrackModStreamState *state, unsigned int meta);
extern "C" void TrackMod_SetRuntimeStreaming(
    TrackModStreamState *state, int enabled);
extern "C" void TrackMod_FinishAllResident(TrackModStreamState *state);
extern "C" void *TrackMod_GetChunkFromLoadedMeta(
    TrackModStreamState *state, unsigned int chunk);
extern "C" void TrackMod_CloseGeometryStream(TrackModStreamState *state);
extern "C" int TrackMod_OpenResidentTrack(
    const char *grpName, TrackModResidentState *state);
extern "C" int TrackMod_ReadPersistentHeader(
    TrackModResidentState *state,
    unsigned int childIndex,
    unsigned int *fileOffset,
    TrackModSerializedHeader *header);
extern "C" int TrackMod_ReadResidentBytes(
    TrackModResidentState *state,
    unsigned int fileOffset,
    void *destination,
    unsigned int bytes);
extern "C" void TrackMod_CloseResidentTrack(TrackModResidentState *state);
#ifndef TRACKMOD_TEST
struct SimpleMem;
extern "C" int TrackMod_InitPersistentData(
    TrackModResidentState *state, SimpleMem *memory);
#endif

extern "C" TrackModLoadDecision TrackMod_SelectLoadRoute(
    int grpSize,
    int largestFreeBlock,
    int configuredLimit,
    int safetyReserve,
    int hasResidentHeader,
    int hasGeometryStream,
    int forceStreaming);

#ifndef TRACKMOD_TEST
extern "C" int TrackMod_InitStreamed(const char *grpName);
extern "C" void TrackMod_TrackInit(char *grpName);
extern "C" void TrackMod_TrackDeInit(void);
extern "C" int TrackMod_IsStreaming(void);
extern "C" int TrackMod_EnsureChunks(unsigned int currentChunk, unsigned int nextChunk);
extern "C" int TrackMod_EnsureSimChunkBlocking(unsigned int chunk);
extern "C" int TrackMod_EnsureChunksBlocking(
    unsigned int currentChunk, unsigned int nextChunk);
extern "C" int TrackMod_IsResidentChunk(unsigned int chunk);
extern "C" unsigned int TrackMod_ChunkCount(void);
extern "C" void TrackMod_PrefetchNext(unsigned int currentChunk);
#endif

#endif
