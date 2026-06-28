/* eaclib/psx/sndpsxz/slimits.cpp -- RECONSTRUCTED. NOT original.  *** 2/2 ***  obj slimits.obj @[0x800E9F84..0x800E9FD4] */
extern "C" int sndgs[];
extern "C" int sndpsxlimits, DAT_801234d8, DAT_801234dc, DAT_801234e0, DAT_801234e4;
extern "C" int SNDgetlimits(int *opts);   /* @0x800E9F84 */
extern "C" int SNDsetlimits(int *opts);   /* @0x800E9FD4 */
/* SNDgetlimits : read the SPU memory/voice limit block into opts[0..4]. */
extern "C" int SNDgetlimits(int *opts)
{
    if ((signed char)sndgs[0xf] == 0) return -0xe;
    opts[0] = sndpsxlimits;
    opts[1] = DAT_801234d8;
    opts[2] = DAT_801234dc;
    opts[3] = DAT_801234e0;
    opts[4] = DAT_801234e4;
    return 0;
}
/* SNDsetlimits : apply opts[0..4] (SPU ctx size opts[4] rounded down to 0x2000). */
extern "C" int SNDsetlimits(int *opts)
{
    if ((signed char)sndgs[0xf] == 0) return -10;
    if (0x1fff < opts[4]) {
        sndpsxlimits = opts[0];
        DAT_801234d8 = opts[1];
        DAT_801234dc = opts[2];
        DAT_801234e0 = opts[3];
        DAT_801234e4 = opts[4] & 0xffffe000;
        return 0;
    }
    return -1;
}
