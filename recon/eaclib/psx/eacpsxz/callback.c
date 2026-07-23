/* eaclib/psx/eacpsxz/callback.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\callback.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE424 .. 0x800FE480].  A tiny mutex pool (32 entries) used to guard callback re-entry.
 *   Ghidra nfs4-f.exe.c (callback) + IDA sigs (allocmutex returns the slot ptr; void return dropped it).
 */
extern short mutexbuf;   /* short[32*2] : 32 mutex slots (4 bytes each, first word = taken flag) */

extern short *allocmutex(void);            /* @0x800FE424 */
extern void   freemutex(void *mutex);      /* @0x800FE480 */

/* allocmutex @0x800FE424 : claim the first free mutex slot (mark taken); returns its pointer. */
extern short *allocmutex(void)
{
    /* Semantic fix: the retail fn returns NULL when all 32 slots are taken
     * (i == 0x20) and recomputes the result from the INDEX (&mutexbuf + i*2, sll 2 +
     * addu) -- the old `return p` handed back a past-the-end pointer on exhaustion.
     * Keeping separate current/next pointers in the structured loop improves the remaining
     * allocation mismatch 12->7.  The retail schedule copies next->current at the loop head;
     * this compiler instead places that copy in the back-edge delay slot. */
    int    i = 0;
    short *p = &mutexbuf;
    short *q = p;
    while (i < 0x20) {
        if (*q == 0) {
            *p = 1;
            break;
        }
        i = i + 1;
        p = q + 2;
        q = p;
    }
    if (i == 0x20)
        return 0;
    return &mutexbuf + i * 2;
}

/* freemutex @0x800FE480 : release a mutex (clear its taken flag). */
extern void freemutex(void *mutex)
{
    *(int *)mutex = 0;
}
