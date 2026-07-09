/* eaclib/psx/sndpsxz/seffect.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\seffect.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E6D58 .. 0x800E6DD0].  SNDfxinitbus/SNDfxmasterlevel -- configure an effect (reverb) bus
 *   and broadcast its master level to every channel.  Ghidra nfs4-f.exe.c (seffect) + IDA sigs (this=bus).
 *
 *   Per-bus state in sndgs (bus*4 stride): +0x27 mode, +0x28 master level, +0x29/+0x2a depth params.
 */

extern int sndgs[];
extern int iSNDplatformfxinit(int bus, int mode);            /* sdfx     */
extern int iSNDplatformfxmasterlevel(int bus, int level);    /* sfxlevel */
extern int SNDfxlevel(int chanTag, int bus, int level);      /* sfxlevel */

extern int SNDfxmasterlevel(int bus, int level);   /* @0x800E6DD0 */
extern int SNDfxinitbus(int bus, int mode, int arg2, int arg3, int arg4);  /* @0x800E6D58 */

/* SNDfxinitbus @0x800E6D58 : initialise effect bus `bus` (mode + depth params), then set its master level. */
extern int SNDfxinitbus(int bus, int mode, int arg2, int arg3, int arg4)
{
    sndgs[bus * 4 + 0x27] = arg2;
    sndgs[bus * 4 + 0x29] = arg3;
    sndgs[bus * 4 + 0x2a] = arg4;
    iSNDplatformfxinit(bus, arg2);
    if (arg2 == 0)
        mode = 0;
    return SNDfxmasterlevel(bus, mode);
}

/* SNDfxmasterlevel @0x800E6DD0 : record bus `bus`'s master level and re-push each channel's send level. */
extern int SNDfxmasterlevel(int bus, int level)
{
    int r, i, off;
    sndgs[bus * 4 + 0x28] = level;
    r = iSNDplatformfxmasterlevel(bus, level);
    if (-1 < r && (r = 0, (char)sndgs[0xf] != 0)) {
        i = 0;
        if (((unsigned char *)sndgs)[0x11] != 0) {
            off = 0;
            do {
                i++;
                SNDfxlevel(*(int *)(off + sndgs[0x25]), bus,
                           (int)(signed char)*(char *)(off + sndgs[0x25] + bus + 0x35));
                off += 100;
            } while (i < (int)(unsigned)((unsigned char *)sndgs)[0x11]);
        }
        r = 0;
    }
    return r;
}
