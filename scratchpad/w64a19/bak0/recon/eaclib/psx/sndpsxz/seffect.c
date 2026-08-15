/* eaclib/psx/sndpsxz/seffect.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\seffect.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E6D58 .. 0x800E6DD0].  SNDfxinitbus/SNDfxmasterlevel -- configure an effect (reverb) bus
 *   and broadcast its master level to every channel.  Ghidra nfs4-f.exe.c (seffect) + IDA sigs (this=bus).
 *
 *   Per-bus state in sndgs (bus*4 stride): +0x27 mode, +0x28 master level, +0x29/+0x2a depth params.
 */

extern int sndgs[];
extern int iSNDplatformfxinit(int bus, int mode, int depthL, int depthR); /* sdfx */
extern int iSNDplatformfxmasterlevel(int bus, int level);    /* sfxlevel */
extern int SNDfxlevel(int chanTag, int bus, int level);      /* sfxlevel */

extern int SNDfxmasterlevel(int bus, int level);   /* @0x800E6DD0 */
extern int SNDfxinitbus(int bus, int mode, int arg2, int arg3, int arg4);  /* @0x800E6D58 */

/* SNDfxinitbus @0x800E6D58 : initialise effect bus `bus` (mode + depth params), then set its master level. */
extern int SNDfxinitbus(int bus, int mode, int arg2, int arg3, int arg4)
{
    int *e = &sndgs[0x27] + bus * 4;
    e[0] = arg2;
    e[2] = arg3;
    e[3] = arg4;
    iSNDplatformfxinit(bus, arg2, arg3, arg4);
    if (arg2 == 0)
        mode = 0;
    return SNDfxmasterlevel(bus, mode);
}

/* SNDfxmasterlevel @0x800E6DD0 : record bus `bus`'s master level and re-push each channel's send level.
 * MATCH: the short-lived `base` keeps the bus-store address rooted at sndgs, while the indexed record
 * loop naturally creates the oracle's separate base, count and 100-byte induction registers. */
extern int SNDfxmasterlevel(int bus, int level)
{
    int r, i;
    unsigned char *loopBase;
    unsigned char *base = (unsigned char *)sndgs;
    unsigned char *fx = base + bus * 16;
    *(int *)(fx + 0xa0) = level;
    r = iSNDplatformfxmasterlevel(bus, level);
    if (r < 0)
        return r;
    if (*(signed char *)((unsigned char *)sndgs + 0x3c) == 0)
        return 0;
    for (i = 0; i < (int)(unsigned)((unsigned char *)sndgs)[0x11]; i++) {
        unsigned char *rec;
        loopBase = (unsigned char *)sndgs;
        rec = (unsigned char *)(i * 100 + *(int *)(loopBase + 0x94));
        SNDfxlevel(*(int *)rec, bus, (int)*(signed char *)(rec + bus + 0x35));
    }
    return 0;
}
