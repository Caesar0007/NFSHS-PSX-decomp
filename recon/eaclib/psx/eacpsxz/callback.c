/* eaclib/psx/eacpsxz/callback.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\callback.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE424 .. 0x800FE480].  A tiny mutex pool (32 entries) used to guard callback re-entry.
 *   Ghidra nfs4-f.exe.c (callback) + IDA sigs (allocmutex returns the slot ptr; void return dropped it).
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "callback.h"

/* callback.obj .sdata 0x8013DD60 (owner proven by retail link order: the only cell between threads.obj and window.obj) */
int (*loadfilecallback)(void *dest, char *name, int memclass) = 0;   /* @0x8013DD60 */

/* allocmutex / freemutex / mutexbuf and the lockmutex diagnostics are NOT in this object: they are threads.obj's
 * (2026-09-21).  Retail pulls threads.obj for memstd.obj's `allocmutex` and only then callback.obj for nsync.obj's
 * `loadfilecallback`; the code is contiguous with iscurrentthread / yieldthread (0x800FE408..0x800FE488).  This object is
 * the loadfilecallback cell alone. */
