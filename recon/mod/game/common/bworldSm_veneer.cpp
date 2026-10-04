/* Stream-aware veneers for the two retail road queries that can be the first
 * users of a geometry chunk. The production image redirects only these entry
 * points; the matching reconstruction under recon/game remains untouched. */
#include "../../../game/common/bworldSm_types.h"
#include "../../../game/common/bworldSm_externs.h"
#include "track_stream.h"

extern int FindClosestQuad(coorddef *, BWorldSm_Pos *);
extern int BWorldSm_FindClosestSlice(coorddef *, BWorldSm_Pos *);
extern int BWorldSm_slices;
extern int gNumSlices;
extern Trk_NewSimQuad GlobalSimQuad;

extern "C" void TrackMod_BWorldSetSimSlice(BWorldSm_Pos *slicePos)
{
    Trk_NewSimSlice *simSlices;
    int chunkSliceInd;
    unsigned int chunk = *(u_char *)(slicePos->slice * 0x20
        + (char *)BWorldSm_slices + 0x1c);
    int wasResident = TrackMod_IsResidentChunk(chunk);
    if (!TrackMod_EnsureSimChunkBlocking(chunk))
        return;
    if (!wasResident) {
        slicePos->simQuad = 0;
        slicePos->strip = 0;
    }
    slicePos->chunk = chunk;
    simSlices = (Trk_NewSimSlice *)
        ((char *)Track_chunkList[chunk].simSliceBuf + 4);
    chunkSliceInd = (int)slicePos->slice
        - (int)Track_chunkList[chunk].firstSimSliceInd;
    slicePos->simSlice = &simSlices[chunkSliceInd];
}

#define TRACKMOD_QUAD_PT_DIR(p1, p2, p3) \
  (fixedmult((p1).x - (p2).x,(p3).z - (p2).z) - \
   fixedmult((p3).x - (p2).x,(p1).z - (p2).z))
#define TRACKMOD_PT_IN_QUAD(q, p) \
  ((TRACKMOD_QUAD_PT_DIR((q)[1],(q)[2],(p)) <= 0 ? 1 : 0) && \
   TRACKMOD_QUAD_PT_DIR((q)[0],(q)[1],(p)) <= 0 && \
   TRACKMOD_QUAD_PT_DIR((q)[2],(q)[3],(p)) <= 0 && \
   (TRACKMOD_QUAD_PT_DIR((q)[3],(q)[0],(p)) <= 0 ? 1 : 0))

extern "C" int TrackMod_BWorldSmFindClosestQuadRez(
    coorddef *pt, BWorldSm_Pos *slicePos, int hiRezFlag)
{
    /* Streaming only: make the chunk this position refers to resident before the retail walkers touch its
     * buffers.  Nothing else may differ from retail -- an earlier version re-derived an invalid slice with
     * FindAbsClosestSliceCrude here and left the player at slice == gNumSlices (stuck at 0 km/h, route D
     * 2026-10-04).  When the position has no usable chunk yet the retail path below finds the slice and calls
     * BWorld_SetSimSlice, whose veneer loads the chunk it lands on. */
    unsigned int chunkCount = TrackMod_ChunkCount();
    if (chunkCount != 0) {
        unsigned int chunk = (unsigned int)(u_char)slicePos->chunk;
        if (chunk >= chunkCount) {
            int slice = slicePos->slice;
            if (slice >= 0 && slice < gNumSlices)
                chunk = *(u_char *)(slice * 0x20 + (char *)BWorldSm_slices + 0x1c);
        }
        if (chunk < chunkCount) {
            int wasResident = TrackMod_IsResidentChunk(chunk);
            if (!TrackMod_EnsureSimChunkBlocking(chunk))
                return 0;
            if (!wasResident) {
                slicePos->simSlice = 0;
                slicePos->simQuad = 0;
                slicePos->strip = 0;
            }
        }
    }
    slicePos->triangleFlag = 3;
    if (hiRezFlag != 0) {
        slicePos->lastRezRequested = 2;
        if (slicePos->simQuad != 0 && TRACKMOD_PT_IN_QUAD(slicePos->quadPts, *pt)) {
            slicePos->quadChanged = 0;
            slicePos->sliceChanged = 0;
            return 0;
        }
        return FindClosestQuad(pt, slicePos);
    }
    slicePos->lastRezRequested = 1;
    slicePos->rez = 1;
    slicePos->simSlice = 0;
    slicePos->simQuad = 0;
    *(signed char *)&slicePos->quad = -1;
    slicePos->triangleFlag = 0;
    return BWorldSm_FindClosestSlice(pt, slicePos);
}

#undef TRACKMOD_PT_IN_QUAD
#undef TRACKMOD_QUAD_PT_DIR
