/* BW_tContext -- the one definition of this type, shared by 14 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_BW_TCONTEXT_H
#define NFS4_SHARED_BW_TCONTEXT_H

struct BW_tContext {
    int client;
    BWorldSm_Pos slicePos;
    int currentChunk, chunkFarZClipSq, polyFarZClipSq, lowDetailDistSq;
    int lineFarZClipSq;
};
#endif
