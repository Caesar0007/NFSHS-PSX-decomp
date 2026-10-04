#ifndef NFS4_GAME_MOD_CHUNK_STREAM_H
#define NFS4_GAME_MOD_CHUNK_STREAM_H

#include "track_stream.h"
#ifdef TRACKMOD_HOST_TEST
struct SimpleMem {
    void *heap;
    void *freeMem;
    int freeMemSize;
};
struct SerializedGroup {
    int m_type, m_length, dummy, m_num_elements;
};
struct Chunk {
    unsigned char opaque[0x70];
    void InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem);
};
#else
#include "../../../game/common/chunk_types.h"
#endif

#define TRACKMOD_CACHE_SLOTS 96

struct TrackModChunkSlot {
    int chunk;
    unsigned int generation;
    void *storage;
    unsigned int storageSize;
    int arenaStorage;
    struct {
        void *heap;
        void *freeMem;
        int freeMemSize;
    } memory;
};

struct TrackModChunkCache {
    TrackModStreamState *stream;
    Chunk *chunks;
    void *storage;
    unsigned int storageBytes;
    unsigned int storageUsed;
    unsigned int storageRequired;
    void *overflowStorage;
    unsigned int overflowBytes;
    unsigned int overflowUsed;
    unsigned int generation;
    unsigned int slotBytes;
    unsigned int slotCount;
    TrackModChunkSlot *slots;
};

extern "C" int TrackMod_InitChunkCache(
    TrackModChunkCache *cache, TrackModStreamState *stream, Chunk *chunks);
extern "C" int TrackMod_LoadChunkSync(TrackModChunkCache *cache, unsigned int chunk);
extern "C" int TrackMod_IsChunkResident(
    const TrackModChunkCache *cache, unsigned int chunk);
extern "C" int TrackMod_EnsureVisibleSync(
    TrackModChunkCache *cache,
    unsigned int currentChunk,
    unsigned int nextChunk,
    const unsigned short *visibilityRows);
extern "C" int TrackMod_EvictForHeap(TrackModChunkCache *cache, unsigned int bytes);
extern "C" int TrackMod_EnsureVisibleMulti(TrackModChunkCache *cache, const unsigned int *owners, unsigned int ownerCount, int prefetch, const unsigned short *visibilityRows, int bump);
extern "C" void TrackMod_CloseChunkCache(TrackModChunkCache *cache);
extern "C" void TrackMod_ReleaseChunkMetadata(TrackModChunkCache *cache);

#endif
