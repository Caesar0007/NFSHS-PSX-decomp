/* tVideo -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TVIDEO_H
#define NFS4_SHARED_TVIDEO_H

struct tVideo {
    char x, y, width, height, tileWidth, tileHeight, deltaX, deltaY;
};
#endif
