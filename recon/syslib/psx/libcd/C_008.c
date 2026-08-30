/* libcd.lib(C_008.obj): init_ring_status. */
#include "stream_internal.h"

extern void init_ring_status(int base, unsigned count)
{
    unsigned i = 0;

    if (count == 0)
        return;
loop:
    *(int *)(StRingAddr + ((i + base) << 5)) = 0;
    i++;
    if (i < count)
        goto loop;
}
