/* Bootstrap file I/O for the N4SX geometry stream. Initial loading is synchronous;
 * gameplay prefetch will use FILE_read + callbacks once chunk-slot binding lands. */
#include "track_stream.h"

extern "C" int FILE_opensync(char *name, int mode, int priority, int *outHandle);
extern "C" void FILE_readsync(int handle, int offset, void *destination, int length, int priority);
extern "C" int FILE_closesync(int handle, int priority);
extern "C" void systemtask(int);
extern "C" void *reservememadr(char *name, int size, int flags);
extern "C" void purgememadr(void *address);
extern "C" unsigned int FILE_read(
    void *handle, unsigned int offset, unsigned int destination,
    int length, unsigned int priority, unsigned int userData);
extern "C" int FILE_completeop(unsigned int op);
extern "C" void FILE_callbackop(
    unsigned int op, void (*callback)(unsigned int, int, int));
extern "C" int TrackMod_prefetchErrors;
int TrackMod_prefetchErrors;

static unsigned int TrackMod_Align4Io(unsigned int value)
{
    return (value + 3U) & ~3U;
}

extern "C" int TrackMod_MakeCompanionName(
    const char *grpName, char *output, unsigned int capacity, char finalLetter)
{
    unsigned int length = 0;
    unsigned int dot = 0xFFFFFFFFU;
    if (grpName == 0 || output == 0 || capacity < 5)
        return 0;
    while (grpName[length] != 0) {
        if (length + 1 >= capacity)
            return 0;
        output[length] = grpName[length];
        if (grpName[length] == '.')
            dot = length;
        length++;
    }
    if (dot == 0xFFFFFFFFU || dot + 4 != length)
        return 0;
    output[length] = 0;
    output[dot + 1] = 'G';
    output[dot + 2] = 'R';
    output[dot + 3] = finalLetter;
    return 1;
}

extern "C" int TrackMod_OpenGeometryStream(
    const char *grpName, TrackModStreamState *state)
{
    TrackModGeometryHeader header;
    char name[128];
    unsigned int indexBytes;
    if (state == 0 || !TrackMod_MakeCompanionName(grpName, name, sizeof(name), 'X'))
        return 0;
    state->fileHandle = 0;
    state->loadedMeta = -1;
    state->indexStorage = 0;
    state->metaBuffer = 0;
    state->prefetchBuffer = 0;
    state->prefetchMeta = -1;
    state->prefetchOp = 0;
    state->runtimeMode = 0;
    if (!FILE_opensync(name, 1, 100, &state->fileHandle))
        return 0;
    FILE_readsync(state->fileHandle, 0, &header, sizeof(header), 99);
    if (header.magic[0] != 'N' || header.magic[1] != '4'
            || header.magic[2] != 'S' || header.magic[3] != 'X'
            || header.version != 3 || header.chunkCount == 0 || header.metaCount == 0) {
        TrackMod_CloseGeometryStream(state);
        return 0;
    }
    indexBytes = sizeof(header)
        + header.metaCount * sizeof(unsigned int)
        + header.chunkCount * sizeof(unsigned short)
        + header.chunkCount * sizeof(unsigned int);
    indexBytes = TrackMod_Align4Io(indexBytes);
    state->indexStorage = reservememadr((char *)"TrkModIndex", indexBytes, 0);
    state->metaBuffer = reservememadr((char *)"TrkModMeta", header.maxMetaBytes, 0);
    if (state->indexStorage == 0 || state->metaBuffer == 0) {
        TrackMod_CloseGeometryStream(state);
        return 0;
    }
    FILE_readsync(state->fileHandle, 0, state->indexStorage, indexBytes, 99);
    if (!TrackMod_ParseGeometryIndex(state->indexStorage, indexBytes, &state->index)) {
        TrackMod_CloseGeometryStream(state);
        return 0;
    }
    return 1;
}

static void TrackMod_PrefetchCallback(
    unsigned int op, int status, int userData)
{
    int bytes;
    unsigned int declared;
    void *swap;
    TrackModStreamState *state = (TrackModStreamState *)userData;
    if (state == 0 || state->prefetchOp != op)
        return;
    bytes = FILE_completeop(op);
    state->prefetchOp = 0;
    if (status != 1 || bytes < 12) {
        TrackMod_prefetchErrors++;
        state->prefetchMeta = -1;
        return;
    }
    declared = *(unsigned int *)state->prefetchBuffer;
    if (declared < 12 || declared > (unsigned int)bytes
            || declared > state->index.header->maxMetaBytes) {
        TrackMod_prefetchErrors++;
        state->prefetchMeta = -1;
        return;
    }
    swap = state->metaBuffer;
    state->metaBuffer = state->prefetchBuffer;
    state->prefetchBuffer = swap;
    state->loadedMeta = state->prefetchMeta;
    state->prefetchMeta = -1;
}

extern "C" void TrackMod_SetRuntimeStreaming(
    TrackModStreamState *state, int enabled)
{
    if (state != 0) {
        if (enabled && state->prefetchBuffer == 0 && state->index.header != 0)
            state->prefetchBuffer = reservememadr(
                (char *)"TrkModAhead", state->index.header->maxMetaBytes, 0);
        state->runtimeMode = enabled != 0;
    }
}

extern "C" void TrackMod_FinishAllResident(TrackModStreamState *state)
{
    if (state == 0)
        return;
    if (state->fileHandle != 0)
        FILE_closesync(state->fileHandle, 99);
    if (state->metaBuffer != 0)
        purgememadr(state->metaBuffer);
    if (state->prefetchBuffer != 0)
        purgememadr(state->prefetchBuffer);
    state->fileHandle = 0;
    state->loadedMeta = -1;
    state->metaBuffer = 0;
    state->prefetchBuffer = 0;
    state->prefetchMeta = -1;
    state->prefetchOp = 0;
    state->runtimeMode = 0;
    if (state->indexStorage != 0)
        purgememadr(state->indexStorage);
    state->indexStorage = 0;
    state->index.header = 0;
}

extern "C" int TrackMod_LoadMetaSync(TrackModStreamState *state, unsigned int meta)
{
    unsigned int offset;
    unsigned int size;
    if (state == 0 || state->fileHandle == 0 || state->index.header == 0
            || meta >= state->index.header->metaCount)
        return 0;
    if (state->runtimeMode) {
        if (state->loadedMeta == (int)meta)
            return 1;
        if (state->prefetchOp != 0)
            return 0;
        offset = TrackMod_GetMetaOffset(&state->index, meta);
        state->prefetchMeta = meta;
        state->prefetchOp = FILE_read(
            (void *)state->fileHandle, offset,
            (unsigned int)state->prefetchBuffer,
            state->index.header->maxMetaBytes, 100, (unsigned int)state);
        if (state->prefetchOp == 0) {
            state->prefetchMeta = -1;
            return 0;
        }
        FILE_callbackop(state->prefetchOp, TrackMod_PrefetchCallback);
        return 0;
    }
    offset = TrackMod_GetMetaOffset(&state->index, meta);
    FILE_readsync(state->fileHandle, offset, state->metaBuffer, 12, 99);
    size = *(unsigned int *)state->metaBuffer;
    if (size < 16 || size > state->index.header->maxMetaBytes)
        return 0;
    FILE_readsync(state->fileHandle, offset, state->metaBuffer, size, 99);
    state->loadedMeta = meta;
    return 1;
}

/* Blocking variant for the sim veneers and the init preload: a sim load that fails is fatal (the retail
 * walkers read a NULL chunk record), so this waits for any prefetch in flight (the race restart moves every
 * car to the start chunks while a prefetch for the old position is pending: 547 urgent failures in the user
 * test, route D 2026-10-04) and then reads the meta synchronously into the spare buffer. */
extern "C" void systemtask(int);

extern "C" int TrackMod_LoadMetaBlocking(TrackModStreamState *state, unsigned int meta)
{
    unsigned int offset;
    unsigned int size;
    void *target;
    void *swap;
    int spins;
    if (state == 0 || state->fileHandle == 0 || state->index.header == 0
            || meta >= state->index.header->metaCount)
        return 0;
    if (state->loadedMeta == (int)meta)
        return 1;
    for (spins = 0; state->prefetchOp != 0 && spins < 2000000; spins++)
        systemtask(0);
    if (state->prefetchOp != 0)
        return 0;
    if (state->loadedMeta == (int)meta)
        return 1;
    target = (state->runtimeMode && state->prefetchBuffer != 0) ? state->prefetchBuffer : state->metaBuffer;
    offset = TrackMod_GetMetaOffset(&state->index, meta);
    FILE_readsync(state->fileHandle, offset, target, 12, 99);
    size = *(unsigned int *)target;
    if (size < 16 || size > state->index.header->maxMetaBytes)
        return 0;
    FILE_readsync(state->fileHandle, offset, target, size, 99);
    if (target != state->metaBuffer) {
        swap = state->metaBuffer;
        state->metaBuffer = target;
        state->prefetchBuffer = swap;
    }
    state->loadedMeta = meta;
    state->prefetchMeta = -1;
    return 1;
}

extern "C" void *TrackMod_GetChunkFromLoadedMeta(
    TrackModStreamState *state, unsigned int chunk)
{
    unsigned int meta;
    unsigned int first;
    unsigned int local;
    unsigned int size;
    unsigned int count;
    unsigned int offset;
    char *base;
    if (state == 0 || state->index.header == 0 || chunk >= state->index.header->chunkCount)
        return 0;
    meta = state->index.metaIndex[chunk];
    if ((int)meta != state->loadedMeta)
        return 0;
    base = (char *)state->metaBuffer;
    size = *(unsigned int *)(base + 0);
    count = *(unsigned int *)(base + 4);
    first = meta * 8;
    if (chunk < first)
        return 0;
    local = chunk - first;
    if (local >= count)
        return 0;
    offset = *(unsigned int *)(base + 12 + local * 4);
    if (offset + 16 > size)
        return 0;
    if (*(int *)(base + offset) != 0x1D)
        return 0;
    if (*(unsigned int *)(base + offset + 4) > size - offset)
        return 0;
    return base + offset;
}

extern "C" void TrackMod_CloseGeometryStream(TrackModStreamState *state)
{
    /* a prefetch still in flight when the race ends left the EA file engine with a dangling operation:
     * the post-replay loading (sound banks, front end) then waited forever in FILE_waitop (route D user
     * test 2026-10-04).  Let it land before the buffers and the handle go away. */
    if (state != 0) {
        int spins;
        for (spins = 0; state->prefetchOp != 0 && spins < 2000000; spins++)
            systemtask(0);
        if (state->prefetchOp != 0) {
            FILE_completeop(state->prefetchOp);
            state->prefetchOp = 0;
        }
    }
    if (state == 0)
        return;
    if (state->fileHandle != 0)
        FILE_closesync(state->fileHandle, 99);
    if (state->metaBuffer != 0)
        purgememadr(state->metaBuffer);
    if (state->prefetchBuffer != 0)
        purgememadr(state->prefetchBuffer);
    if (state->indexStorage != 0)
        purgememadr(state->indexStorage);
    state->fileHandle = 0;
    state->loadedMeta = -1;
    state->indexStorage = 0;
    state->metaBuffer = 0;
    state->prefetchBuffer = 0;
    state->prefetchMeta = -1;
    state->prefetchOp = 0;
    state->runtimeMode = 0;
    state->index.header = 0;
}
