/* eaclib/psx/sndpsxz/slimits.c -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj slimits.obj @[0x800E9F84..0x800E9FD4] */

/* slimits.obj .data 0x801234D4 (link-order owner, 2026-09-20; was five scalars in the non-module snddata.c): the SPU
 * memory / voice limit block; [4] = default SPU context size. */
#include "sdata.h"
#include "sndserverpriv.h"
#include "slimits.h"

int sndpsxlimits[5] = { 0, 0, 0, 0, 0x2000 };
struct LimitsBlock { int value[5]; };

/* SNDgetlimits : read the SPU memory/voice limit block into opts[0..4]. */
int SNDgetlimits(void *opts)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -0xe;
    /* MATCH: the library copies this contiguous 20-byte option block as one aggregate. */
    *(struct LimitsBlock *)opts = *(struct LimitsBlock *)sndpsxlimits;
    return 0;
}
/* SNDsetlimits : apply opts[0..4] (SPU ctx size opts[4] rounded down to 0x2000). */
int SNDsetlimits(void *opts)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;
    if (((int *)opts)[4] < 0x2000) return -1;
    *(struct LimitsBlock *)sndpsxlimits = *(struct LimitsBlock *)opts;
    sndpsxlimits[4] &= 0xffffe000;
    return 0;
}
