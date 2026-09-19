/* libcd.lib(C_007.obj): StFreeRing. */
#include "stream_internal.h"

/* C_007.obj .data (retail 0x80136c9c, 16 bytes): this object's private CD register pointers (PsyQ 4.3 LIBCD, byte-exact). */
static volatile unsigned char *_cd_reg0 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801800;
static volatile unsigned char *_cd_reg1 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801801;
static volatile unsigned char *_cd_reg2 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801802;
static volatile unsigned char *_cd_reg3 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801803;

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
