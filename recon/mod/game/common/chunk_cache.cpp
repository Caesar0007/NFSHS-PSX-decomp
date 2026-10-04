/* Memory-oriented replacement surface for recon/game/common/chunk.cpp.
 * It keeps retail Chunk::InstanceGroup as the binder and adds bounded residency.
 *
 * Route D (2026-10-04): the chunk storage is ONE pool block taken from the EA heap at init (HIGH end, so the
 * game's own allocations keep the low end contiguous), sub-allocated first-fit by address.  Per-chunk heap
 * blocks fragmented the heap: after a few hundred evictions the game's larger allocations (AI records,
 * replay, car data) could not find a hole even with 160 KB free, and the retail code never checks for NULL
 * (loadpackadrz then unpacks to address 0 and wipes the kernel).  Residency is least-recently-used by pump
 * generation; the heap-pressure hook shrinks the pool when the game itself runs out of memory.
 */
#include "chunk_stream.h"

extern "C" void *reservememadr(char *name, int size, int flags);
#ifndef TRACKMOD_HOST_TEST
extern "C" int purgememadr(void *address);
#endif
extern "C" int largestunused(void);
extern "C" int TrackMod_allocFailures;
int TrackMod_allocFailures;
extern "C" int TrackMod_loadedChunks;
extern "C" int TrackMod_loadedBytes;
extern "C" int TrackMod_arenaBytes;
extern "C" int TrackMod_allowArena;
extern void *gCurrContext;
int TrackMod_loadedChunks;
int TrackMod_loadedBytes;
int TrackMod_arenaBytes;
extern "C" int TrackMod_sizeFailures;
int TrackMod_sizeFailures;
extern "C" int TrackMod_loadingChunk;
extern "C" unsigned int TrackMod_loadingStorage;
extern "C" unsigned int TrackMod_loadingSize;
int TrackMod_loadingChunk = -1;
unsigned int TrackMod_loadingStorage;
unsigned int TrackMod_loadingSize;
extern "C" int TrackMod_evictedChunks;
int TrackMod_evictedChunks;
extern "C" int TrackMod_pressureEvictions;
int TrackMod_pressureEvictions;
extern "C" int TrackMod_poolShrinks;
int TrackMod_poolShrinks;
extern "C" int TrackMod_loadFail[8];   /* why TrackMod_LoadChunkSyncEx failed: 0 args, 1 meta index, 2 meta read, 3 chunk ptr, 4 pool, 5 size */
int TrackMod_loadFail[8];

#ifdef TRACKMOD_HOST_TEST
extern "C" int purgememadr(...);
#endif

#define TRACKMOD_POOL_RESERVE   0x3C000U   /* EA heap left to the rest of the race init when the pool is sized; the race only starts music when > 0xB000 is still free after Sim_StartUp (nfs3.cpp), and 0x30000 left ~38 KB */
#define TRACKMOD_POOL_SHRINK_PAD 0x4000U   /* extra heap left free after a pressure shrink */
#define TRACKMOD_POOL_MIN_SLOTS 12         /* below this many max-size chunks the pool is not worth keeping */
#define TRACKMOD_HIGH_END       0x10       /* reservememadr: allocate at the high end of the heap */

static void TrackMod_Zero(void *address, unsigned int bytes)
{
    unsigned char *p = (unsigned char *)address;
    while (bytes-- != 0)
        *p++ = 0;
}

extern "C" void TrackMod_ChunkUpdateSys(void *)
{
    if (gCurrContext != 0) {
        unsigned int currentChunk = *(unsigned int *)((char *)gCurrContext + 0x88);
        TrackMod_PrefetchNext(currentChunk);
    }
}

/* slot i holds chunk i (slotCount == chunkCount); a slot is resident when slot->chunk >= 0 */
static int TrackMod_FindSlot(TrackModChunkCache *cache, int chunk)
{
    if (chunk < 0 || chunk >= (int)cache->slotCount)
        return -1;
    return cache->slots[chunk].chunk == chunk ? chunk : -1;
}

extern "C" int TrackMod_IsChunkResident(
    const TrackModChunkCache *cache, unsigned int chunk)
{
    if (cache == 0 || cache->stream == 0 || cache->slots == 0
            || chunk >= cache->stream->index.header->chunkCount)
        return 0;
    return TrackMod_FindSlot((TrackModChunkCache *)cache, chunk) >= 0;
}

/* ---- pool sub-allocation: first fit by address over the resident slots ---- */
static void *TrackMod_PoolAlloc(TrackModChunkCache *cache, unsigned int bytes)
{
    char *base = (char *)cache->storage;
    char *end;
    char *cursor;
    if (base == 0 || bytes > cache->storageBytes)
        return 0;
    end = base + cache->storageBytes;
    cursor = base;
    for (;;) {
        /* the lowest resident block at or above the cursor */
        unsigned int i;
        char *nextStart = end;
        unsigned int nextSize = 0;
        for (i = 0; i < cache->slotCount; i++) {
            TrackModChunkSlot *slot = &cache->slots[i];
            if (slot->chunk < 0 || slot->storage == 0)
                continue;
            if ((char *)slot->storage >= cursor && (char *)slot->storage < nextStart) {
                nextStart = (char *)slot->storage;
                nextSize = slot->storageSize;
            }
        }
        if ((unsigned int)(nextStart - cursor) >= bytes)
            return cursor;
        if (nextStart == end)
            return 0;
        cursor = nextStart + ((nextSize + 3U) & ~3U);
    }
}

static void TrackMod_EvictSlot(TrackModChunkCache *cache, int slotIndex)
{
    TrackModChunkSlot *slot = &cache->slots[slotIndex];
    if (slot->chunk >= 0)
        TrackMod_Zero(&cache->chunks[slot->chunk], sizeof(Chunk));
    if (slot->storage != 0 && cache->storageUsed >= slot->storageSize)
        cache->storageUsed -= slot->storageSize;
    slot->chunk = -1;
    slot->generation = 0;
    slot->storage = 0;
    slot->storageSize = 0;
    TrackMod_evictedChunks++;
}

/* Least recently used first.  pass 0: chunks nobody asked for since the last pump generation (the ahead
 * row is stamped one generation back by the pump, so it goes before the in-view row); pass 1 (allowCurrent):
 * anything resident -- a sim load that fails is fatal for the caller, an in-view chunk merely gets reloaded
 * by the next pump. */
static int TrackMod_EvictOldest(TrackModChunkCache *cache, int allowCurrent)
{
    int i;
    int best = -1;
    unsigned int bestGen = 0;
    unsigned int pass;
    for (pass = 0; pass < (allowCurrent ? 2U : 1U) && best < 0; pass++) {
        for (i = 0; i < (int)cache->slotCount; i++) {
            TrackModChunkSlot *slot = &cache->slots[i];
            if (slot->chunk < 0)
                continue;
            if (pass == 0 && slot->generation >= cache->generation)
                continue;
            if (best < 0 || slot->generation < bestGen) {
                best = i;
                bestGen = slot->generation;
            }
        }
    }
    if (best < 0)
        return 0;
    TrackMod_EvictSlot(cache, best);
    return 1;
}

static void TrackMod_EvictAll(TrackModChunkCache *cache)
{
    unsigned int i;
    for (i = 0; i < cache->slotCount; i++)
        if (cache->slots[i].chunk >= 0)
            TrackMod_EvictSlot(cache, i);
    cache->storageUsed = 0;
}

static int TrackMod_ReservePool(TrackModChunkCache *cache, unsigned int bytes)
{
    unsigned int minimum = (cache->slotBytes + 0x20) * TRACKMOD_POOL_MIN_SLOTS;
    cache->storage = 0;
    cache->storageBytes = 0;
    cache->storageUsed = 0;
    while (bytes >= minimum) {
        cache->storage = reservememadr((char *)"TrkModPool", (int)bytes, TRACKMOD_HIGH_END);
        if (cache->storage != 0) {
            cache->storageBytes = bytes;
            return 1;
        }
        bytes -= bytes / 8;
    }
    return 0;
}

/* Heap pressure: the game's own reservememadr failed for `bytes`.  Give the pool back and take a smaller
 * one that leaves room for that allocation (plus a pad); every chunk is dropped and reloaded on demand by
 * the pump / the sim veneers.  Re-entrancy guard: the pool re-reservation goes through the same wrapper. */
static int TrackMod_inPressure;

extern "C" int TrackMod_EvictForHeap(TrackModChunkCache *cache, unsigned int bytes)
{
    unsigned int avail;
    unsigned int want;
    if (cache == 0 || cache->slots == 0 || cache->storage == 0 || TrackMod_inPressure)
        return 0;
    TrackMod_inPressure = 1;
    TrackMod_EvictAll(cache);
    purgememadr(cache->storage);
    cache->storage = 0;
    avail = (unsigned int)largestunused();
    want = bytes + 0x20U + TRACKMOD_POOL_SHRINK_PAD;
    TrackMod_pressureEvictions++;
    TrackMod_poolShrinks++;
    if (avail > want)
        TrackMod_ReservePool(cache, avail - want);
    else
        cache->storageBytes = 0;
    TrackMod_inPressure = 0;
    return 1;
}

extern "C" int TrackMod_InitChunkCache(
    TrackModChunkCache *cache, TrackModStreamState *stream, Chunk *chunks)
{
    unsigned int i;
    unsigned int total;
    unsigned int desired = 0;
    unsigned int available;
    if (cache == 0 || stream == 0 || stream->index.header == 0 || chunks == 0)
        return 0;
    TrackMod_Zero(cache, sizeof(*cache));
    cache->stream = stream;
    cache->chunks = chunks;
    cache->slotBytes = stream->index.header->maxResidentChunkBytes;
    cache->slotCount = stream->index.header->chunkCount;
    total = cache->slotCount * sizeof(TrackModChunkSlot);
    cache->slots = (TrackModChunkSlot *)reservememadr(
        (char *)"TrkModSlots", total, 0);
    if (cache->slots == 0)
        return 0;
    TrackMod_Zero(cache->slots, total);
    for (i = 0; i < cache->slotCount; i++) {
        cache->slots[i].chunk = -1;
        desired += TrackMod_GetChunkResidentBytes(&stream->index, i) + 0x20;
    }
    cache->storageRequired = desired;
    available = largestunused();
    if (available > TRACKMOD_POOL_RESERVE)
        available -= TRACKMOD_POOL_RESERVE;
    else
        available = 0;
    if (desired > available)
        desired = available;
    if (!TrackMod_ReservePool(cache, desired))
        return 0;
    cache->overflowStorage = 0;
    cache->overflowBytes = 0;
    return 1;
}

static int TrackMod_LoadChunkSyncEx(TrackModChunkCache *cache, unsigned int chunk, int allowCurrent)
{
    TrackModChunkSlot *slot;
    SerializedGroup *serialized;
    unsigned int used;
    unsigned int allocation;
    void *storage;
    int meta;
    if (cache == 0 || cache->stream == 0 || cache->slots == 0
            || chunk >= cache->stream->index.header->chunkCount) {
        TrackMod_loadFail[0]++;
        return 0;
    }
    slot = &cache->slots[chunk];
    if (slot->chunk == (int)chunk) {
        slot->generation = cache->generation;
        return 1;
    }
    meta = TrackMod_GetChunkMeta(&cache->stream->index, chunk);
    if (meta < 0) {
        TrackMod_loadFail[1]++;
        return 0;
    }
    if (cache->stream->loadedMeta != meta
            && !(allowCurrent ? TrackMod_LoadMetaBlocking(cache->stream, meta) : TrackMod_LoadMetaSync(cache->stream, meta))) {
        TrackMod_loadFail[2]++;
        return 0;
    }
    serialized = (SerializedGroup *)TrackMod_GetChunkFromLoadedMeta(cache->stream, chunk);
    if (serialized == 0) {
        TrackMod_loadFail[3]++;
        return 0;
    }
    allocation = TrackMod_GetChunkResidentBytes(&cache->stream->index, chunk) + 0x20;
    for (;;) {
        storage = TrackMod_PoolAlloc(cache, allocation);
        if (storage != 0)
            break;
        if (!TrackMod_EvictOldest(cache, allowCurrent)) {
            TrackMod_allocFailures++;
            TrackMod_loadFail[4]++;
            return 0;
        }
    }
    slot->storage = storage;
    slot->storageSize = allocation;
    slot->arenaStorage = 0;
    slot->memory.heap = storage;
    slot->memory.freeMem = storage;
    slot->memory.freeMemSize = (int)allocation;
    cache->storageUsed += allocation;
    TrackMod_Zero(&cache->chunks[chunk], sizeof(Chunk));
    TrackMod_loadingChunk = chunk;
    TrackMod_loadingStorage = (unsigned int)(unsigned long)storage;
    TrackMod_loadingSize = (unsigned int)allocation;
    cache->chunks[chunk].InstanceGroup(serialized, (SimpleMem *)&slot->memory);
    used = (unsigned int)((char *)slot->memory.freeMem - (char *)slot->memory.heap);
    if (used > allocation) {
        /* the chunk did not fit the size its index declares: its neighbour in the pool may be damaged */
        TrackMod_sizeFailures++;
        TrackMod_loadFail[5]++;
        TrackMod_Zero(&cache->chunks[chunk], sizeof(Chunk));
        cache->storageUsed -= allocation;
        slot->storage = 0;
        slot->storageSize = 0;
        slot->chunk = -1;
        TrackMod_loadingChunk = -1;
        return 0;
    }
    slot->chunk = chunk;
    slot->generation = cache->generation;
    TrackMod_loadedChunks++;
    TrackMod_loadedBytes += used;
    TrackMod_loadingChunk = -1;
    return 1;
}

/* sim veneers / init preload: may take in-view chunks as a last resort */
extern "C" int TrackMod_LoadChunkSync(TrackModChunkCache *cache, unsigned int chunk)
{
    return TrackMod_LoadChunkSyncEx(cache, chunk, 1);
}

/* Render pump: the current chunk's visibility row must be resident before the frame is drawn; the ahead
 * row is a prefetch and is stamped one generation back so it is the first to go.  Never evicts a chunk the
 * current frame asked for. */
/* owners[0..ownerCount-1]: the chunks whose visibility rows must be resident this frame (one per rendered
 * view: split screen draws two).  prefetch >= 0: one extra row (the chunk ahead) stamped a generation back.
 * bump: start a new pump generation (once per render frame, not once per view -- two views bumping in turn
 * made each view's row look stale to the other and the cache thrashed: 600 loads per 90 s on a split-screen
 * Lost Canyons run, 2026-10-05). */
extern "C" int TrackMod_EnsureVisibleMulti(
    TrackModChunkCache *cache,
    const unsigned int *owners,
    unsigned int ownerCount,
    int prefetch,
    const unsigned short *visibilityRows,
    int bump)
{
    unsigned short required[5 * 33];
    unsigned char rowOf[5 * 33];
    unsigned int count = 0;
    unsigned int row;
    unsigned int i;
    unsigned int j;
    unsigned int chunkCount;
    unsigned int candidates[5];
    unsigned int candidateCount = 0;
    int ok = 1;
    if (cache == 0 || cache->stream == 0 || visibilityRows == 0)
        return 0;
    chunkCount = cache->stream->index.header->chunkCount;
    for (i = 0; i < ownerCount && candidateCount < 4; i++)
        candidates[candidateCount++] = owners[i];
    if (prefetch >= 0)
        candidates[candidateCount++] = (unsigned int)prefetch;
    if (bump)
        cache->generation++;
    for (row = 0; row < candidateCount; row++) {
        unsigned int owner = candidates[row];
        unsigned int isPrefetch = (prefetch >= 0 && row == candidateCount - 1);
        if (owner >= chunkCount)
            continue;
        for (j = 0; j < count && required[j] != owner; j++) {}
        if (j == count) {
            rowOf[count] = (unsigned char)(isPrefetch ? 1 : 0);
            required[count++] = (unsigned short)owner;
        }
        for (i = 0; i < 32; i++) {
            unsigned int value = visibilityRows[owner * 32 + i] & 0x3FF;
            if (value >= chunkCount)
                continue;
            for (j = 0; j < count && required[j] != value; j++) {}
            if (j == count) {
                rowOf[count] = (unsigned char)(isPrefetch ? 1 : 0);
                required[count++] = (unsigned short)value;
            }
        }
    }
    /* Load by meta number to avoid re-reading the same meta for adjacent chunks; the view rows first. */
    for (row = 0; row < 2; row++) {
        for (i = 0; i < cache->stream->index.header->metaCount; i++) {
            for (j = 0; j < count; j++) {
                if (rowOf[j] != row)
                    continue;
                if ((unsigned int)TrackMod_GetChunkMeta(&cache->stream->index, required[j]) != i)
                    continue;
                if (!TrackMod_LoadChunkSyncEx(cache, required[j], 0)) {
                    if (row == 0)
                        ok = 0;
                    continue;
                }
                if (row == 1)
                    cache->slots[required[j]].generation = cache->generation - 1;   /* prefetch: first to go */
            }
        }
    }
    return ok;
}

extern "C" int TrackMod_EnsureVisibleSync(
    TrackModChunkCache *cache,
    unsigned int currentChunk,
    unsigned int nextChunk,
    const unsigned short *visibilityRows)
{
    unsigned int owner = currentChunk;
    return TrackMod_EnsureVisibleMulti(cache, &owner, 1, (int)nextChunk, visibilityRows, 1);
}

extern "C" void TrackMod_CloseChunkCache(TrackModChunkCache *cache)
{
    if (cache == 0)
        return;
    if (cache->slots != 0)
        purgememadr(cache->slots);
    if (cache->storage != 0)
        purgememadr(cache->storage);
    if (cache->overflowStorage != 0)
        purgememadr(cache->overflowStorage);
    TrackMod_Zero(cache, sizeof(*cache));
}

extern "C" void TrackMod_ReleaseChunkMetadata(TrackModChunkCache *cache)
{
    if (cache != 0 && cache->slots != 0) {
        purgememadr(cache->slots);
        cache->slots = 0;
        cache->slotCount = 0;
    }
}
