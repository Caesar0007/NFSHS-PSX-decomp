/* eaclib/psx/eacpsxz/threads.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\threads.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col12 / SYM v3)
 *   2 fns @[0x800FE408 .. 0x800FE41C].  Minimal cooperative-thread stubs (the PSX build is single-threaded).
 *   Ghidra nfs4-f.exe.c (threads) + IDA sigs.
 */
#include "../eaclib_types.h"
#include "eac_types.h"
#include "threads.h"

/* Owning definition of g_currentthread (tentative def -> .sdata -> gp-rel; see note above). */
int g_currentthread = 0; /* @0x8013DD5C: threads.obj owning definition; retail has it in INITIALISED small data (.sdata), so the original wrote `= 0` (this compiler puts a zero-initialised global in data, not bss) */

/* iscurrentthread @0x800FE408 : 1 if `id` is the running thread. */
unsigned int iscurrentthread(int id)
{
    return (unsigned int)(g_currentthread == id);
}

/* yieldthread @0x800FE41C : no-op on the single-threaded PSX target. */
void yieldthread(void)
{
}

/* ---- the mutex pool: moved here from callback.c 2026-09-21 (see the note there) ---- */
/* P903 integration: freemutex clears a full word at each four-byte slot.
 * Preserve the former object's four-byte base alignment with C storage.
 * The explicit BSS section is needed: aligned(4) alone on COMMON was ignored
 * by this compiler/assembler route. No executable assembly is introduced. */
short mutexbuf[32 * 2] __attribute__((section(".bss"), aligned(4)));
/* W65-A6 DATA-MAT: `mutexbuf` was extern-only tree-wide (4 reloc-referenced undefined sites);
 * callback.obj is its sole referencer.  Retail: .bss @0x801477E0, size 128 (= sndgs
 * @0x80147860 - 0x801477E0) -- exactly the short[32*2] the decl documents.  VA >
 * t_addr+t_size (0x8013E000) => pure zero-init BSS. P903 keeps that128-byte object
 * and alignment in ordinary C, replacing the old assembly reservation. Native
 * final placement is still a separate linker obligation. Historical receipt:
 * scratchpad/w65a6/RECEIPTS.md. */

/* allocmutex @0x800FE424 : claim the first free mutex slot (mark taken); returns its pointer. */
short *allocmutex(void)
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
     * of the loop (24). The earlier unsized extern supplied the needed address
     * materialization. P903 rechecks the current complete64-short C definition:
     * it retains the exact23-word allocator and both entry points. */
    int i;
    for(i = 0; i < 0x20; i++) {
        if (mutexbuf[i * 2] == 0) {
            mutexbuf[i * 2] = 1;
            break;
        }
    }
    if (i == 0x20)
        return 0;
    return &mutexbuf[i * 2];
}

/* freemutex @0x800FE480 : release a mutex (clear its taken flag). */
void freemutex(void *mutex)
{
    *(int *)mutex = 0;
}

/* callback.obj .rodata (retail 0x800575B8, 80 bytes): the two diagnostics of lockmutex/unlockmutex.  Retail has no code
 * for either (only allocmutex/freemutex), so they are unused static inlines whose literals the compiler still emits. */
extern int printf(const char *, ...);
static __inline__ void lockmutex(short *mutex)
{
    if (*mutex != 0)
        printf("lockmutex - MUTEX IS ALREADY LOCKED.\n");
    *mutex = 1;
}
static __inline__ void unlockmutex(short *mutex)
{
    if (*mutex == 0)
        printf("unlockmutex - MUTEX WAS NOT LOCKED.\n");
    *mutex = 0;
}
