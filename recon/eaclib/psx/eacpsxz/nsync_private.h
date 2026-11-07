/* nsync_private.h -- nsync.obj internals: the atomic-load argument block and its size probe (nsync.c only).
 * Game and frontend code include the public nsync.h only. */
#ifndef _NSYNC_PRIVATE_H_
#define _NSYNC_PRIVATE_H_

#include "nsync.h"

typedef struct LoadArgs {
    char *name;      /* +0x00  source filename                                   */
    int   dest;      /* +0x04  fixed destination (loadfileat* family)            */
    int   memclass;  /* +0x08  allocator class id (loadfile* / bigfile family)   */
    int   abortval;  /* +0x0C  abort flag snapshot (0 for the "z" variants)      */
} LoadArgs;

extern int filesizeatomic(int retry, LoadArgs *a);   /* @0x800E5608 */

#endif
