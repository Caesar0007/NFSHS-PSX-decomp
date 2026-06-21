/* eaclib/psx/eacpsxz/callback.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\callback.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE424 .. 0x800FE480].  A tiny mutex pool (32 entries) used to guard callback re-entry.
 *   Ghidra nfs4-f.exe.c (callback) + IDA sigs (allocmutex returns the slot ptr; void return dropped it).
 */
extern "C" short mutexbuf;   /* short[32*2] : 32 mutex slots (4 bytes each, first word = taken flag) */

extern "C" short *allocmutex(void);            /* @0x800FE424 */
extern "C" void   freemutex(void *mutex);      /* @0x800FE480 */

/* allocmutex @0x800FE424 : claim the first free mutex slot (mark taken); returns its pointer. */
extern "C" short *allocmutex(void)
{
    int    i = 0;
    short *p = &mutexbuf;
    do {
        if (*p == 0) {
            *p = 1;
            break;
        }
        i = i + 1;
        p = p + 2;
    } while (i < 0x20);
    return p;
}

/* freemutex @0x800FE480 : release a mutex (clear its taken flag). */
extern "C" void freemutex(void *mutex)
{
    *(int *)mutex = 0;
}
