#ifndef _SYNCFILE_H_
#define _SYNCFILE_H_

#include "eac_types.h"

struct SyncCtrl;

typedef struct SyncCtrl {
    int      cbarg;   /* +0  user callback arg (passed as the io fn's 5th param) */
    int      fd;      /* +4  file handle */
    int      buf;     /* +8  destination pointer (advances by bytes-done) */
    int      remain;  /* +12 bytes still to transfer */
    int      done;    /* +16 bytes transferred so far (syncblockio's return), advances */
    int      chunk;   /* +20 current chunk size (clamped to 0x2000) */
    int      offset;  /* +24 source offset (finalized on the last/short chunk) */
    int    (*iofn)(int fd, int buf, int offset, int chunk, int cbarg,
                   struct SyncCtrl *ctrl); /* +28 async io fn (only stored for multi-chunk transfers) */
    int      op;      /* +32 current async op handle */
} SyncCtrl;

extern void synccallback(int op, int type, SyncCtrl *ctrl);   /* @0x800EA6CC */
extern int  syncblockio(int fd, int buf, int offset, int len, int cbarg, int (*iofn)(int, int, int, int, int, struct SyncCtrl *));   /* @0x800EA7E8 */
/* NOTE: nsync.c calls the 3rd argument of the *sync family `retry`, nasync.c calls it `prio`.
 * Named `prio` here to match the async FILE_open/FILE_close it forwards to; the true meaning
 * is unconfirmed -- it reaches the oracle as plain $a2. */
extern int FILE_opensync(char *name, int mode, int prio, int *outHandle);   /* @0x800EA8A8 */
extern void FILE_readsync(int fd, int buf, int offset, int len, int cbarg);   /* @0x800EA920 */
extern int FILE_closesync(int handle, int prio);   /* @0x800EA950 */
extern int FILE_sizesync(int handle, int retry);   /* @0x800EA9A4 */
extern int FILE_addbigsync(char *name, int a2, int a3, int *out);   /* @0x800EA9F8 */
extern int FILE_delbigsync(int a0, int a1);   /* @0x800EAA70 */

#endif
