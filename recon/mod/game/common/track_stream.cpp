/* Format-independent accessors for the generated N4SH/N4SX streamed track files. */
#include "track_stream.h"

static int TrackMod_Magic(const char *value, char a, char b, char c, char d)
{
    return value[0] == a && value[1] == b && value[2] == c && value[3] == d;
}

extern "C" int TrackMod_ParseGeometryIndex(
    const void *data, unsigned int bytes, TrackModGeometryIndex *out)
{
    const TrackModGeometryHeader *header;
    unsigned int required;
    unsigned int metaBytes;
    unsigned int chunkMetaBytes;
    unsigned int chunkSizeBytes;
    unsigned int cursor;
    unsigned int i;

    if (data == 0 || out == 0 || bytes < sizeof(TrackModGeometryHeader))
        return 0;
    header = (const TrackModGeometryHeader *)data;
    if (!TrackMod_Magic(header->magic, 'N', '4', 'S', 'X') || header->version != 3)
        return 0;
    if (header->chunkCount == 0 || header->metaCount == 0
            || header->metaCount != (header->chunkCount + 7) / 8)
        return 0;
    metaBytes = header->metaCount * sizeof(unsigned int);
    chunkMetaBytes = header->chunkCount * sizeof(unsigned short);
    chunkSizeBytes = header->chunkCount * sizeof(unsigned int);
    required = sizeof(TrackModGeometryHeader) + metaBytes + chunkMetaBytes + chunkSizeBytes;
    required = (required + 3) & ~3U;
    if (required > bytes)
        return 0;

    out->header = header;
    cursor = sizeof(TrackModGeometryHeader);
    out->metaOffsets = (const unsigned int *)((const char *)data + cursor);
    cursor += metaBytes;
    out->metaIndex = (const unsigned short *)((const char *)data + cursor);
    cursor += chunkMetaBytes;
    out->residentChunkBytes = (const unsigned int *)((const char *)data + cursor);
    out->indexBytes = required;
    for (i = 0; i < header->metaCount; i++) {
        if (out->metaOffsets[i] < required)
            return 0;
        if (i != 0 && out->metaOffsets[i] <= out->metaOffsets[i - 1])
            return 0;
    }
    for (i = 0; i < header->chunkCount; i++) {
        if (out->metaIndex[i] >= header->metaCount
                || out->residentChunkBytes[i] > header->maxResidentChunkBytes)
            return 0;
    }
    return 1;
}

extern "C" int TrackMod_GetChunkMeta(
    const TrackModGeometryIndex *index, unsigned int chunk)
{
    if (index == 0 || index->header == 0 || chunk >= index->header->chunkCount)
        return -1;
    return index->metaIndex[chunk];
}

extern "C" unsigned int TrackMod_GetMetaOffset(
    const TrackModGeometryIndex *index, unsigned int meta)
{
    if (index == 0 || index->header == 0 || meta >= index->header->metaCount)
        return 0;
    return index->metaOffsets[meta];
}

extern "C" unsigned int TrackMod_GetChunkResidentBytes(
    const TrackModGeometryIndex *index, unsigned int chunk)
{
    if (index == 0 || index->header == 0 || chunk >= index->header->chunkCount)
        return 0;
    return index->residentChunkBytes[chunk];
}
