/* eaclib/psx/sndpsxz/slimits.c -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj slimits.obj @[0x800E9F84..0x800E9FD4] */
extern int sndgs[];
extern int sndpsxlimits[5];
struct LimitsBlock { int value[5]; };
extern int SNDgetlimits(int *opts);   /* @0x800E9F84 */
extern int SNDsetlimits(int *opts);   /* @0x800E9FD4 */
/* SNDgetlimits : read the SPU memory/voice limit block into opts[0..4]. */
extern int SNDgetlimits(int *opts)
{
    if ((signed char)sndgs[0xf] == 0) return -0xe;
    /* MATCH: the library copies this contiguous 20-byte option block as one aggregate. */
    *(struct LimitsBlock *)opts = *(struct LimitsBlock *)sndpsxlimits;
    return 0;
}
/* SNDsetlimits : apply opts[0..4] (SPU ctx size opts[4] rounded down to 0x2000). */
extern int SNDsetlimits(int *opts)
{
    if ((signed char)sndgs[0xf] == 0) return -10;
    if (opts[4] < 0x2000) return -1;
    *(struct LimitsBlock *)sndpsxlimits = *(struct LimitsBlock *)opts;
    sndpsxlimits[4] &= 0xffffe000;
    return 0;
}
