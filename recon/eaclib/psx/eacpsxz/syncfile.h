#ifndef _SYNCFILE_H_
#define _SYNCFILE_H_

#include "eac_types.h"

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

/* NOTE: nsync.c calls the 3rd argument of the *sync family `retry`, nasync.c calls it `prio`.
 * Named `prio` here to match the async FILE_open/FILE_close it forwards to; the true meaning
 * is unconfirmed -- it reaches the oracle as plain $a2. */
extern int FILE_opensync(char *name, int mode, int prio, int *outHandle);   /* @0x800EA8A8 */
extern void FILE_readsync(int fd, int offset, void *buf, int len, int cbarg);   /* @0x800EA920 */
extern int FILE_closesync(int handle, int prio);   /* @0x800EA950 */
extern int FILE_sizesync(int handle, int retry);   /* @0x800EA9A4 */
extern int FILE_addbigsync(char *name, int a2, int a3, int *out);   /* @0x800EA9F8 */
extern int FILE_delbigsync(int a0, int a1);   /* @0x800EAA70 */

#endif
