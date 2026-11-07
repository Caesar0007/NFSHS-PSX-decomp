/* fileroot_private.h -- fileroot.obj internals: the deferred host-read command (fileroot.c only).
 * Game and frontend code include the public fileroot.h only. */
#ifndef _FILEROOT_PRIVATE_H_
#define _FILEROOT_PRIVATE_H_

#include "fileroot.h"

/* the single-slot deferred PC-host read command (executed by readfile_systask).
 * @0x80140400 (.bss, 20B = 5 ints). The `extern` form below was only a DECLARATION
 * (a promise) -> the storage was never defined in any TU (surfaced by the link harness).
 * Defined here, its owning TU, since ReadCmd is a TU-local struct. Zero-init (BSS). */
struct ReadCmd {
    int pending;   /* +0x00 nonzero == a command is queued */
    int handle;    /* +0x04 dev descriptor (fs byte already masked off) */
    int dest;      /* +0x08 destination address */
    int offset;    /* +0x0C file offset */
    int len;       /* +0x10 byte count */
};
typedef struct ReadCmd ReadCmd;

#endif
