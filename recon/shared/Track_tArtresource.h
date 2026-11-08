/* Track_tArtresource -- the one definition of this type, shared by 17 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRACK_TARTRESOURCE_H
#define NFS4_SHARED_TRACK_TARTRESOURCE_H

typedef struct {
    int id;
    char *shapeFile;
    int shapeCount;
    Draw_tPixMap *pPmx;
    int pmxCount, basePmxCount;
} Track_tArtresource;
#endif
