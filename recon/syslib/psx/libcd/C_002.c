/* libcd.lib(C_002.obj): StClearRing @0x800F8968. */
#include "stream_internal.h"

/* C_002.obj .data (retail 0x80136ae8, 16 bytes): this object's private CD register pointers (PsyQ 4.3 LIBCD, byte-exact). */
static volatile unsigned char *_cd_reg0 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801800;
static volatile unsigned char *_cd_reg1 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801801;
static volatile unsigned char *_cd_reg2 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801802;
static volatile unsigned char *_cd_reg3 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801803;

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
