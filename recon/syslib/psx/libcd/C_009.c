/* libcd.lib(C_009.obj): StGetNext. */
#include "stream_internal.h"

extern u_long StGetNext(u_long **addr, u_long **header)
{
    u_short *slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));

    if (slot[0] == 1) {
        StRingIdx3 = 0;
        if (StEndFrame != 0)
            slot[0] = 0;
        slot = (u_short *)(StRingAddr + (StRingIdx3 << 5));
    }
    /* DMA owns the ring status asynchronously.  This zero-insn compiler
     * memory barrier expresses that boundary and prevents reusing the entry
     * load made before the wrap path. */
    __asm__("" : : : "memory");
    {
        u_long r = 1;
        if (slot[0] != 2)
            return r;
    }
    slot[0] = 4;
    *addr = (u_long *)(StRingAddr + (StRingSize << 5) +
                       ((StRingIdx3 * 0x3F) << 5));
    *header = (u_long *)slot;
    return 0;
}
