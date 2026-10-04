/* Bounded resident-file loader. The large persistent container is scanned by
 * headers and copied child-by-child into final runtime allocations. */
#include "track_stream.h"

extern "C" int FILE_opensync(char *name, int mode, int priority, int *outHandle);
extern "C" void FILE_readsync(int handle, int offset, void *destination, int length, int priority);
extern "C" int FILE_closesync(int handle, int priority);
extern "C" void *reservememadr(char *name, int size, int flags);
extern "C" void purgememadr(void *address);

extern "C" int TrackMod_ReadResidentBytes(
    TrackModResidentState *state,
    unsigned int fileOffset,
    void *destination,
    unsigned int bytes)
{
    if (state == 0 || state->fileHandle == 0 || destination == 0 || bytes == 0)
        return 0;
    FILE_readsync(state->fileHandle, fileOffset, destination, bytes, 99);
    return 1;
}

extern "C" int TrackMod_OpenResidentTrack(
    const char *grpName, TrackModResidentState *state)
{
    char name[128];
    unsigned int cursor;
    if (state == 0 || !TrackMod_MakeCompanionName(grpName, name, sizeof(name), 'H'))
        return 0;
    state->fileHandle = 0;
    state->trackHeader = 0;
    state->centers = 0;
    state->lightGroup = 0;
    state->visibilityRows = 0;
    if (!FILE_opensync(name, 1, 100, &state->fileHandle))
        return 0;
    FILE_readsync(state->fileHandle, 0, &state->header, sizeof(state->header), 99);
    if (state->header.magic[0] != 'N' || state->header.magic[1] != '4'
            || state->header.magic[2] != 'S' || state->header.magic[3] != 'H'
            || state->header.version != 3 || state->header.chunkCount == 0
            || state->header.centerBytes != state->header.chunkCount * 12
            || state->header.visibilityBytes != state->header.chunkCount * 64) {
        TrackMod_CloseResidentTrack(state);
        return 0;
    }
    state->trackHeader = reservememadr((char *)"TrkModHead", state->header.trackHeaderBytes, 0);
    state->centers = reservememadr((char *)"TrkModCtr", state->header.centerBytes, 0);
    state->lightGroup = reservememadr((char *)"TrkModLight", state->header.lightBytes, 0);
    state->visibilityRows = (unsigned short *)reservememadr(
        (char *)"TrkModVis", state->header.visibilityBytes, 0);
    if (state->trackHeader == 0 || state->centers == 0
            || state->lightGroup == 0 || state->visibilityRows == 0) {
        TrackMod_CloseResidentTrack(state);
        return 0;
    }
    cursor = sizeof(state->header);
    FILE_readsync(state->fileHandle, cursor, state->trackHeader, state->header.trackHeaderBytes, 99);
    cursor += state->header.trackHeaderBytes;
    FILE_readsync(state->fileHandle, cursor, state->centers, state->header.centerBytes, 99);
    cursor += state->header.centerBytes;
    state->persistentOffset = cursor;
    cursor += state->header.persistentBytes;
    FILE_readsync(state->fileHandle, cursor, state->lightGroup, state->header.lightBytes, 99);
    cursor += state->header.lightBytes;
    FILE_readsync(state->fileHandle, cursor, state->visibilityRows, state->header.visibilityBytes, 99);
    return 1;
}

extern "C" int TrackMod_ReadPersistentHeader(
    TrackModResidentState *state,
    unsigned int childIndex,
    unsigned int *fileOffset,
    TrackModSerializedHeader *header)
{
    TrackModSerializedHeader parent;
    unsigned int cursor;
    unsigned int i;
    if (state == 0 || fileOffset == 0 || header == 0)
        return 0;
    FILE_readsync(state->fileHandle, state->persistentOffset, &parent, sizeof(parent), 99);
    if (parent.type != 0x21 || parent.length != (int)state->header.persistentBytes
            || childIndex >= (unsigned int)parent.count)
        return 0;
    cursor = state->persistentOffset + sizeof(parent);
    for (i = 0; i <= childIndex; i++) {
        FILE_readsync(state->fileHandle, cursor, header, sizeof(*header), 99);
        if (header->length < (int)sizeof(*header)
                || cursor + header->length > state->persistentOffset + state->header.persistentBytes)
            return 0;
        if (i == childIndex) {
            *fileOffset = cursor;
            return 1;
        }
        cursor += header->length;
    }
    return 0;
}

extern "C" void TrackMod_CloseResidentTrack(TrackModResidentState *state)
{
    if (state == 0)
        return;
    if (state->fileHandle != 0)
        FILE_closesync(state->fileHandle, 99);
    if (state->visibilityRows != 0)
        purgememadr(state->visibilityRows);
    if (state->lightGroup != 0)
        purgememadr(state->lightGroup);
    if (state->centers != 0)
        purgememadr(state->centers);
    if (state->trackHeader != 0)
        purgememadr(state->trackHeader);
    state->fileHandle = 0;
    state->trackHeader = 0;
    state->centers = 0;
    state->lightGroup = 0;
    state->visibilityRows = 0;
}
