/* Memory-oriented replacement surface for recon/game/common/track.cpp.
 * The retail Track_Init remains untouched; this module owns the size gate and
 * will host the NFS3-style streamed route. */
#include "track_stream.h"

#ifndef TRACKMOD_TEST
#include "../../../game/common/track_types.h"
#include "../../../game/common/track_externs.h"
#include "chunk_stream.h"

extern void Track_LinkMaterials(SerializedGroup *, int, Track_tMaterial *);
extern void CalcObjDefPtrs(void);
extern void InitArtResources(void);
extern void TexturesLoadInitial(void);
extern void CalcObjectBoundingSphere(Group *, Group *);
extern void ReduceObjectPrecision(Group *, Group *, int);
extern void InvalidatePersistentCollideBoomObjects(Group *, Group *);
extern void Track_LoadObjectKillData(void);
extern char *Track_MakeTrackPathName(char *);
extern void Track_Init(char *);
extern void Track_DeInit(void);
extern "C" int largestunused(void);
extern int gFlip;   /* draw.cpp: toggles every rendered frame */
typedef int (*TrackModHeapHookFn)(int);
extern "C" TrackModHeapHookFn TrackMod_heapHook[4];   /* recon/mod/eaclib/psx/eacpsxz/memstd.c */
extern "C" int TrackMod_OnHeapPressure(int bytes);
extern "C" void systemtask(int);

#define TRACKMOD_RETAIL_GRP_LIMIT 0xA0000
#define TRACKMOD_POST_INIT_RESERVE 0x30000

static TrackModResidentState gTrackModResident;
static TrackModStreamState gTrackModStream;
static TrackModChunkCache gTrackModCache;
static int gTrackModActive;
extern "C" int TrackMod_forceStreaming;
int TrackMod_forceStreaming;
extern "C" int TrackMod_urgentFailures;
extern "C" int TrackMod_loadedChunks;
int TrackMod_urgentFailures;
extern "C" int TrackMod_partialResident;
int TrackMod_partialResident;
extern "C" int TrackMod_allResident;
int TrackMod_allResident;
extern "C" int TrackMod_allowArena;
int TrackMod_allowArena;

static void TrackMod_Copy(void *destination, const void *source, unsigned int bytes)
{
    unsigned char *d = (unsigned char *)destination;
    const unsigned char *s = (const unsigned char *)source;
    while (bytes-- != 0)
        *d++ = *s++;
}

static void TrackMod_Zero(void *destination, unsigned int bytes)
{
    unsigned char *d = (unsigned char *)destination;
    while (bytes-- != 0)
        *d++ = 0;
}

static Group *TrackMod_LoadLiteGroup(
    TrackModResidentState *state,
    unsigned int fileOffset,
    const TrackModSerializedHeader *header,
    SimpleMem *memory)
{
    Group *result;
    unsigned int payloadBytes;
    unsigned int allocationBytes;
    unsigned char *tail;
    if (header->length < (int)sizeof(*header))
        return 0;
    payloadBytes = header->length - sizeof(*header);
    /* Retail CreateLiteGroup writes one word beyond its nominal allocation.
     * The mod owns its layout, so reserve that word explicitly. */
    allocationBytes = payloadBytes + sizeof(int) + sizeof(int);
    result = (Group *)memory->Alloc(allocationBytes, 0);
    if (result == 0)
        return 0;
    result->m_num_elements = header->count;
    if (payloadBytes != 0 && !TrackMod_ReadResidentBytes(
            state, fileOffset + sizeof(*header), result->GetData(), payloadBytes))
        return 0;
    tail = (unsigned char *)result->GetData() + payloadBytes;
    *(unsigned int *)tail = 0;
    return result;
}

extern "C" int TrackMod_InitPersistentData(
    TrackModResidentState *state, SimpleMem *memory)
{
    TrackModSerializedHeader parent;
    TrackModSerializedHeader header;
    unsigned int offset;
    unsigned int child;
    if (state == 0 || memory == 0)
        return 0;
    if (!TrackMod_ReadResidentBytes(
            state, state->persistentOffset, &parent, sizeof(parent))
            || parent.type != 0x21 || parent.count < 1)
        return 0;
    gObjDefOffsetsGroup = 0;
    gPersistObjDef = 0;
    gPersistObjInst = 0;
    gPersistMidgroundObjInst = 0;
    for (child = 0; child < (unsigned int)parent.count; child++) {
        Group *group;
        if (!TrackMod_ReadPersistentHeader(state, child, &offset, &header))
            return 0;
        if (header.type == 2) {
            SerializedGroup *source = (SerializedGroup *)reservememadr(
                (char *)"TrkModMat", header.length, 0);
            if (source == 0 || !TrackMod_ReadResidentBytes(
                    state, offset, source, header.length))
                return 0;
            Track_LinkMaterials(source, header.length - sizeof(header), Track_materials);
            purgememadr(source);
            continue;
        }
        if (header.type != 0x0F && header.type != 0x24 && header.type != 7
                && header.type != 8 && header.type != 0x26)
            continue;
        group = TrackMod_LoadLiteGroup(state, offset, &header, memory);
        if (group == 0)
            return 0;
        switch (header.type) {
        case 0x0F:
            BWorldSm_Init(group);
            break;
        case 0x24:
            gPersistMidgroundObjInst = group;
            break;
        case 7:
            gPersistObjInst = group;
            break;
        case 8:
            gPersistObjDef = group;
            break;
        case 0x26:
            gObjDefOffsetsGroup = group;
            break;
        default:
            break;
        }
    }
    if (gObjDefOffsetsGroup != 0)
        CalcObjDefPtrs();
    return gPersistObjDef != 0;
}

extern "C" int TrackMod_InitStreamed(const char *grpName)
{
    TrackModSerializedHeader *light;
    unsigned int heapBytes;
    unsigned int i;
    unsigned int j;
    unsigned int lightBytes;
    void *heap;
    char trackName[128];

    if (grpName == 0 || gTrackModActive)
        return 0;
    for (i = 0; i + 1 < sizeof(trackName) && grpName[i] != 0; i++)
        trackName[i] = grpName[i];
    trackName[i] = 0;
    Track_gSaveSurface = 0;
    Track_gObjDefs = 0;
    Chunk_lightTable = (CVECTOR *)reservememadr((char *)"lighttbl", 0x404, 0);
    if (Chunk_lightTable == 0)
        return 0;
    TextureProcess_Init();
    InitArtResources();
    TexturesLoadInitial();
    if (!TrackMod_OpenResidentTrack(trackName, &gTrackModResident)
            || !TrackMod_OpenGeometryStream(trackName, &gTrackModStream)
            || gTrackModResident.header.chunkCount != gTrackModStream.index.header->chunkCount)
        return 0;

    /* This heap contains only final resident objects. Serialized geometry and
     * persistent input stay in bounded I/O buffers, never beside the heap. */
    heapBytes = gTrackModResident.header.persistentBytes
        + gTrackModResident.header.trackHeaderBytes
        + gTrackModResident.header.centerBytes
        + gTrackModResident.header.visibilityBytes
        + gTrackModResident.header.chunkCount * (sizeof(Chunk) + 1U)
        + 0x400U;
    Track_mem = (SimpleMem *)__builtin_new(sizeof(SimpleMem));
    heap = reservememadr((char *)"Track_mem", heapBytes, 0);
    if (Track_mem == 0 || heap == 0)
        return 0;
    Track_mem->heap = heap;
    Track_mem->freeMem = heap;
    Track_mem->freeMemSize = heapBytes;

    Track_header = (TrackHeader *)Track_mem->Alloc(
        gTrackModResident.header.trackHeaderBytes, 0);
    Chunk_chunkCenters = (coorddef *)Track_mem->Alloc(
        gTrackModResident.header.centerBytes, 0);
    Track_gInViewList = (short (*)[32])Track_mem->Alloc(
        gTrackModResident.header.visibilityBytes, 0);
    Track_gInViewCount = (u_char *)Track_mem->Alloc(
        gTrackModResident.header.chunkCount, 0);
    Track_chunkList = (Chunk *)Track_mem->Alloc(
        gTrackModResident.header.chunkCount * sizeof(Chunk), 0);
    if (Track_header == 0 || Chunk_chunkCenters == 0 || Track_gInViewList == 0
            || Track_gInViewCount == 0 || Track_chunkList == 0)
        return 0;
    TrackMod_Copy(Track_header, gTrackModResident.trackHeader,
        gTrackModResident.header.trackHeaderBytes);
    TrackMod_Copy(Chunk_chunkCenters, gTrackModResident.centers,
        gTrackModResident.header.centerBytes);
    TrackMod_Copy(Track_gInViewList, gTrackModResident.visibilityRows,
        gTrackModResident.header.visibilityBytes);
    TrackMod_Zero(Track_chunkList,
        gTrackModResident.header.chunkCount * sizeof(Chunk));
    for (i = 0; i < gTrackModResident.header.chunkCount; i++) {
        for (j = 0; j < 32 && (Track_gInViewList[i][j] & 0x3FF)
                < gTrackModResident.header.chunkCount; j++) {}
        Track_gInViewCount[i] = (u_char)j;
    }

    light = (TrackModSerializedHeader *)gTrackModResident.lightGroup;
    if (light->type != 0x23 || light->length < (int)sizeof(*light))
        return 0;
    lightBytes = light->length - sizeof(*light);
    if (lightBytes > 0x400U)
        return 0;
    TrackMod_Copy(Chunk_lightTable, light + 1, lightBytes);
    Chunk_numLight = lightBytes >> 2;

    Chunk_Init();
    if (!TrackMod_InitPersistentData(&gTrackModResident, Track_mem))
        return 0;
    Track_mem->ResizeToFit();
    TrackMod_CloseResidentTrack(&gTrackModResident);
    if (!TrackMod_InitChunkCache(&gTrackModCache, &gTrackModStream, Track_chunkList))
        return 0;
    /* Correctness-first streamed layout: discard serialized metas after
     * instancing, but keep every resulting chunk block stable. This removes
     * the whole-GRP allocation and proves the split format before introducing
     * reference-safe runtime eviction. */
    if (gTrackModCache.storageBytes < gTrackModCache.storageRequired) {
        if (!TrackMod_EnsureVisibleSync(&gTrackModCache, 0,
                gTrackModResident.header.chunkCount > 15 ? 15
                    : gTrackModResident.header.chunkCount - 1,
                (const unsigned short *)Track_gInViewList))
            return 0;
    }
    for (i = 0; i < gTrackModResident.header.chunkCount; i++) {
        if (gTrackModResident.header.chunkCount > 160
                && TrackMod_loadedChunks >= 82) {
            TrackMod_partialResident = 1;
            break;
        }
        if ((unsigned int)largestunused()
                < TrackMod_GetChunkResidentBytes(&gTrackModStream.index, i)
                    + 4U + TRACKMOD_POST_INIT_RESERVE) {
            TrackMod_partialResident = 1;
            break;
        }
        /* leave a quarter of the cache budget for the chunks the AI cars will ask for in the first frames */
        if (gTrackModCache.storageBytes < gTrackModCache.storageRequired
                && gTrackModCache.storageUsed + TrackMod_GetChunkResidentBytes(&gTrackModStream.index, i) + 0x20
                    > gTrackModCache.storageBytes - gTrackModCache.storageBytes / 4) {
            TrackMod_partialResident = 1;
            break;
        }
        if (!TrackMod_LoadChunkSync(&gTrackModCache, i)) {
            TrackMod_partialResident = 1;
            break;
        }
    }
    if (TrackMod_partialResident) {
        TrackMod_SetRuntimeStreaming(&gTrackModStream, 1);
    } else {
        TrackMod_FinishAllResident(&gTrackModStream);
        TrackMod_ReleaseChunkMetadata(&gTrackModCache);
        TrackMod_allResident = 1;
    }
    Track_MakeTrackPathName((char *)".grp");
    gPersistObjDefBoundingSpheres = (Group *)reservememadr(
        (char *)"bsphere", gPersistObjDef->m_num_elements << 3 | 4, 0);
    CalcObjectBoundingSphere(gPersistObjDef, gPersistObjDefBoundingSpheres);
    ReduceObjectPrecision(gPersistMidgroundObjInst, gPersistObjDef, 2);
    InvalidatePersistentCollideBoomObjects(gPersistObjInst, gPersistObjDef);
    Track_gSaveSurface = new SaveSurface(0x30);
    Track_LoadObjectKillData();
    gTrackModActive = 1;
    TrackMod_heapHook[0] = TrackMod_OnHeapPressure;
    return 1;
}

extern "C" int TrackMod_IsStreaming(void)
{
    return gTrackModActive;
}

extern "C" int TrackMod_EnsureChunks(unsigned int currentChunk, unsigned int nextChunk)
{
    if (!gTrackModActive)
        return 1;
    if (TrackMod_allResident)
        return 1;
    return TrackMod_EnsureVisibleSync(&gTrackModCache, currentChunk, nextChunk,
        (const unsigned short *)Track_gInViewList);
}

/* Called by the route D reservememadr override when an allocation failed: evict streamed chunks so the
 * game's own allocation can succeed (retail never checks for NULL -- loadpackadrz would unpack to 0). */

extern "C" int TrackMod_OnHeapPressure(int bytes)
{
    if (!gTrackModActive || TrackMod_allResident || bytes < 0)
        return 0;
    return TrackMod_EvictForHeap(&gTrackModCache, (unsigned int)bytes);
}

/* Sim veneers: make ONE chunk resident (the one a car stands in) without pulling its visibility rows and
 * without bumping the pump generation -- those are the render pump's business (TrackMod_PrefetchNext). */
extern "C" int TrackMod_EnsureSimChunkBlocking(unsigned int chunk)
{
    int attempts;
    if (!gTrackModActive)
        return 1;
    if (TrackMod_allResident)
        return 1;
    if (!TrackMod_allowArena && simGlobal.gameTicks != 0)
        TrackMod_allowArena = 1;
    for (attempts = 0; attempts < 256; attempts++) {
        if (TrackMod_LoadChunkSync(&gTrackModCache, chunk))
            return 1;
        systemtask(0);
    }
    TrackMod_urgentFailures++;
    return 0;
}

extern "C" int TrackMod_EnsureChunksBlocking(
    unsigned int currentChunk, unsigned int nextChunk)
{
    int attempts;
    if (!gTrackModActive)
        return 1;
    if (!TrackMod_allowArena && simGlobal.gameTicks != 0) {
        TrackMod_allowArena = 1;
    }
    for (attempts = 0; attempts < 4096; attempts++) {
        if (TrackMod_EnsureChunks(currentChunk, nextChunk))
            return 1;
        systemtask(0);
    }
    TrackMod_urgentFailures++;
    return 0;
}

extern "C" void TrackMod_PrefetchNext(unsigned int currentChunk)
{
    unsigned int count;
    if (!gTrackModActive)
        return;
    if (TrackMod_allResident)
        return;
    if (!TrackMod_allowArena) {
        TrackMod_allowArena = 1;
    }
    count = gTrackModStream.index.header->chunkCount;
    if (currentChunk < count) {
        /* Chunk_UpdateSys runs once per rendered view; collect the views' chunks of this render frame (gFlip
         * toggles per frame) and keep every view's row resident together.  The ahead-row prefetch is only
         * worth its memory in single player. */
        /* The engine may pump the two views in one frame or alternate them frame by frame, so an owner stays
         * active for two render frames after it was last seen. */
        static unsigned int owners[4];
        static unsigned int ownerSeen[4];
        static unsigned int ownerCount;
        static unsigned int frame;
        static int lastFlip = -1;
        unsigned int i, k;
        int bump = 0;
        int flip = gFlip & 1;
        int ahead = -1;
        if (flip != lastFlip) {
            lastFlip = flip;
            frame++;
            bump = 1;
            for (i = k = 0; i < ownerCount; i++)
                if (frame - ownerSeen[i] <= 2) {
                    owners[k] = owners[i]; ownerSeen[k] = ownerSeen[i]; k++;
                }
            ownerCount = k;
        }
        for (i = 0; i < ownerCount && owners[i] != currentChunk; i++) {}
        if (i < ownerCount)
            ownerSeen[i] = frame;
        else if (ownerCount < 4) {
            owners[ownerCount] = currentChunk; ownerSeen[ownerCount] = frame; ownerCount++;
        }
        if (ownerCount == 1) {
            ahead = (int)currentChunk + 4;
            if ((unsigned int)ahead >= count)
                ahead -= (int)count;
        }
        TrackMod_EnsureVisibleMulti(&gTrackModCache, owners, ownerCount, ahead,
            (const unsigned short *)Track_gInViewList, bump);
    }
}

extern "C" int TrackMod_IsResidentChunk(unsigned int chunk)
{
    if (!gTrackModActive)
        return 1;
    if (TrackMod_allResident)
        return 1;
    return TrackMod_IsChunkResident(&gTrackModCache, chunk);
}

extern "C" unsigned int TrackMod_ChunkCount(void)
{
    if (!gTrackModActive || gTrackModStream.index.header == 0)
        return 0;
    return gTrackModStream.index.header->chunkCount;
}

extern "C" void TrackMod_TrackInit(char *grpName)
{
    int grpSize = filesize(grpName);
    TrackModLoadDecision decision = TrackMod_SelectLoadRoute(
        grpSize, largestunused(), TRACKMOD_RETAIL_GRP_LIMIT, 0, 1, 1,
        TrackMod_forceStreaming);
    if (decision.route == TRACKMOD_LOAD_RETAIL) {
        Track_Init(grpName);
        return;
    }
    TrackMod_InitStreamed(grpName);
}

extern "C" void TrackMod_TrackDeInit(void)
{
    TrackMod_heapHook[0] = 0;
    if (gTrackModActive) {
        TrackMod_CloseChunkCache(&gTrackModCache);
        TrackMod_CloseGeometryStream(&gTrackModStream);
        gTrackModActive = 0;
    }
    Track_DeInit();
}
#endif

static unsigned int TrackMod_Align4(unsigned int value)
{
    return (value + 3U) & ~3U;
}

extern "C" TrackModLoadDecision TrackMod_SelectLoadRoute(
    int grpSize,
    int largestFreeBlock,
    int configuredLimit,
    int safetyReserve,
    int hasResidentHeader,
    int hasGeometryStream,
    int forceStreaming)
{
    TrackModLoadDecision result;
    unsigned int available;

    result.route = TRACKMOD_LOAD_ERROR;
    result.error = TRACKMOD_BAD_SIZE;
    result.grpSize = grpSize > 0 ? (unsigned int)grpSize : 0;
    result.requiredRetailBytes = 0;
    result.availableRetailBytes = 0;
    if (grpSize <= 0 || largestFreeBlock <= 0 || safetyReserve < 0)
        return result;

    available = (unsigned int)largestFreeBlock;
    if ((unsigned int)safetyReserve >= available)
        available = 0;
    else
        available -= (unsigned int)safetyReserve;
    if (configuredLimit > 0 && (unsigned int)configuredLimit < available)
        available = (unsigned int)configuredLimit;

    result.requiredRetailBytes = TrackMod_Align4((unsigned int)grpSize + 0x9080U);
    result.availableRetailBytes = available;
    result.error = TRACKMOD_OK;
    if (!forceStreaming && result.requiredRetailBytes <= available) {
        result.route = TRACKMOD_LOAD_RETAIL;
        return result;
    }
    if (hasResidentHeader && hasGeometryStream) {
        result.route = TRACKMOD_LOAD_STREAMED;
        return result;
    }
    result.error = TRACKMOD_TOO_LARGE_WITHOUT_STREAM;
    return result;
}

#ifdef TRACKMOD_TEST
#include <assert.h>
int main(void)
{
    TrackModLoadDecision d;
    d = TrackMod_SelectLoadRoute(422252, 700000, 0, 8192, 1, 1, 0);
    assert(d.route == TRACKMOD_LOAD_RETAIL && d.requiredRetailBytes == 459244);
    d = TrackMod_SelectLoadRoute(763324, 734452, 0, 0, 1, 1, 0);
    assert(d.route == TRACKMOD_LOAD_STREAMED && d.requiredRetailBytes == 800316);
    d = TrackMod_SelectLoadRoute(763324, 734452, 0, 0, 0, 0, 0);
    assert(d.route == TRACKMOD_LOAD_ERROR && d.error == TRACKMOD_TOO_LARGE_WITHOUT_STREAM);
    d = TrackMod_SelectLoadRoute(100000, 734452, 0, 0, 1, 1, 1);
    assert(d.route == TRACKMOD_LOAD_STREAMED);
    d = TrackMod_SelectLoadRoute(100000, 734452, 120000, 0, 1, 1, 0);
    assert(d.route == TRACKMOD_LOAD_STREAMED);
    return 0;
}
#endif
