/* libcd.lib(C_007.obj): StFreeRing. */
#include "stream_internal.h"

extern u_long StFreeRing(u_long *base)
{
    int slot;
    int i;
    short nsectors;
    u_short *frame;
    u_short *sector;

    slot = (base - (u_long *)(StRingAddr + (StRingSize << 5))) / 504;
    frame = (u_short *)(StRingAddr + (slot << 5));
    nsectors = frame[3];
    if (*(short *)frame != 4)
        return 1;
    i = 0;
    if (nsectors > 0) do {
        sector = (u_short *)(StRingAddr + ((i + slot) << 5));
        i++;
        *sector = 0;
    } while (i < nsectors);
    StRingIdx3 = i + slot;
    return 0;
}
