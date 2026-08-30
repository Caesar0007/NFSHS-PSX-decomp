/* libcd.lib(C_002.obj): StClearRing @0x800F8968. */
#include "stream_internal.h"

extern void StClearRing(void)
{
    StRingIdx3    = 0;
    StRingIdx2    = 0;
    StRingIdx1    = 0;
    StFinalSector = 0;
    init_ring_status(0, (unsigned)StRingSize);
    StCdIntrFlag    = 0;
    Stsector_offset = 0;
    Stframe_no      = 0;
}
