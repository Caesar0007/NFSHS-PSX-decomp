/* eaclib/psx/eacpsxz/callback.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\callback.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE424 .. 0x800FE480].  A tiny mutex pool (32 entries) used to guard callback re-entry.
 *   Ghidra nfs4-f.exe.c (callback) + IDA sigs (allocmutex returns the slot ptr; void return dropped it).
 */
extern short mutexbuf[];   /* short[32*2] : 32 mutex slots (4 bytes each, first word = taken flag) */
/* W65-A6 DATA-MAT: `mutexbuf` was extern-only tree-wide (4 reloc-referenced undefined sites);
 * callback.obj is its sole referencer.  Retail: .bss @0x801477E0, size 128 (= sndgs
 * @0x80147860 - 0x801477E0) -- exactly the short[32*2] the decl documents.  VA >
 * t_addr+t_size (0x8013E000) => pure zero-init BSS.  DEVICE = file-scope asm .bss definition,
 * keeping the UNSIZED `extern short mutexbuf[]` the loop's index form depends on.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
__asm__("\t.globl\tmutexbuf\n\t.section\t.bss\n\t.align\t2\nmutexbuf:\n\t.space\t128\n\t.text");

extern short *allocmutex(void);            /* @0x800FE424 */
extern void   freemutex(void *mutex);      /* @0x800FE480 */

/* allocmutex @0x800FE424 : claim the first free mutex slot (mark taken); returns its pointer. */
extern short *allocmutex(void)
{
    /* The retail fn returns NULL when all 32 slots are taken (i == 0x20) and recomputes the
     * result from the INDEX (mutexbuf + i*2, sll 2 + addu).
     * MATCH (w33-a3, was 7 diffs / 24-vs-23 insns): the oracle's apparently redundant
     * `move a0,a1` at the loop head is NOT a retail-toolchain redundant copy -- it is a
     * GIV ANCHOR.  INDEX FORM with TWO references to the SAME element (the `== 0` load and
     * the `= 1` store) makes loop.c create two address givs; gcc 2.8 combines them onto the
     * last one in body order, so the second is derived with a +0 `move` and the walking giv
     * is advanced FROM the anchor (`addiu a1,a0,4`).  A pointer-walk spelling (cur/next
     * locals) cannot reach it: copy-prop collapses the pair (22 insns) or peels the copy out
     * of the loop (24).  The `extern short mutexbuf[]` UNSIZED-ARRAY decl supplies the
     * preheader's two-register address materialization (`lui v0` + `addiu a1,v0`); with a
     * sized/scalar decl gcc folds it into one register. */
    int    i = 0;
    while (i < 0x20) {
        if (mutexbuf[i * 2] == 0) {
            mutexbuf[i * 2] = 1;
            break;
        }
        i = i + 1;
    }
    if (i == 0x20)
        return 0;
    return mutexbuf + i * 2;
}

/* freemutex @0x800FE480 : release a mutex (clear its taken flag). */
extern void freemutex(void *mutex)
{
    *(int *)mutex = 0;
}
