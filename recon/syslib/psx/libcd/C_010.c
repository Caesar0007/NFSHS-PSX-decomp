/* libcd.lib(C_010.obj): StSetMask. */
#include "stream_internal.h"

/* C_010.obj .data @0x8013C280: the stream group's four static CD register pointers (same block C_003.obj carries at
 * 0x80136C48; unreferenced here).  Owned since 2026-09-19 -- retail link order DRV, C_008, C_004, C_010. */
static volatile unsigned char *_cd_reg0 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801800;
static volatile unsigned char *_cd_reg1 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801801;
static volatile unsigned char *_cd_reg2 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801802;
static volatile unsigned char *_cd_reg3 __attribute__((section(".data"))) = (volatile unsigned char *)0x1F801803;

extern void StSetMask(u_long mask, u_long start_frame, u_long end_frame)
{
    StSTART_FLAG = (int)mask;
    StStartFrame = (int)start_frame;
    StEndFrame = (int)end_frame;
}
