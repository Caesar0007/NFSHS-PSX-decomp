/* syncfile_private.h -- syncfile.obj internals: the synchronous-transfer control block (syncfile.c only).
 * Game and frontend code include the public syncfile.h only. */
#ifndef _SYNCFILE_PRIVATE_H_
#define _SYNCFILE_PRIVATE_H_

#include "syncfile.h"

struct SyncCtrl;

typedef struct SyncCtrl {
    int      cbarg;   /* +0  user callback arg (passed as the io fn's 5th param) */
    int      fd;      /* +4  file handle */
    int      buf;     /* +8  file offset passed to FILE_read (advances by bytes-done) */
    int      remain;  /* +12 bytes still to transfer */
    int      done;    /* +16 bytes transferred so far (syncblockio's return), advances */
    int      chunk;   /* +20 current chunk size (clamped to 0x2000) */
    int      offset;  /* +24 destination address (raw 32-bit pointer; advances by bytes-done) */
    unsigned int (*iofn)(void *handle, unsigned int offset, unsigned int dest, int chunk,
                         unsigned int cbarg, unsigned int syncCtrl); /* +28 FILE_read-compatible async I/O */
    int      op;      /* +32 current async op handle */
} SyncCtrl;

#endif
