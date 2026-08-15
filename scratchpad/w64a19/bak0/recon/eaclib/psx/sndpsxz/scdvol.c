/* eaclib/psx/sndpsxz/scdvol.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\scdvol.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800FAA44.  SNDcdvol -- public CD-audio volume/pan setter; caches the master-scaled level and
 *   forwards (pan,vol) to the platform layer.  Ghidra nfs4-f.exe.c (scdvol) + IDA sig.
 *   Ghidra-ism: IDA typed 1 arg, but vol_l/vol_r are both passed on to iSNDplatformcdpanvol (kept 2).
 */
extern int  sndgs[];        /* (signed char)sndgs[0xf] byte1 (@+0x3d) = master volume */
/* Six-short .data block @0x80136CAC; [0]=pan (64), [1]=master-scaled level (127 initially).
 * The full-sized extern view preserves the oracle's absolute addressing and the data owner remains
 * asm/data/data_8010CCD4.data.s. */
extern short sndcdvs[6];

extern int iSNDplatformcdpanvol(int pan, int vol);   /* sdcdvol */

extern int SNDcdvol(int vol_l, int vol_r);   /* @0x800FAA44 */

/* SNDcdvol @0x800FAA44 : cache (vol_l * masterVol)/0x7f and apply the CD pan/volume. */
extern int SNDcdvol(int vol_l, int vol_r)
{
    sndcdvs[1] = (short)((vol_l * (int)*((signed char *)sndgs + 0x3d)) / 0x7f);
    /* @0x800FAA90/94: iSNDplatformcdpanvol(*(short*)0x80136CAC = cached pan, (int)(short)level). The
     * recon passed the raw caller args (vol_l, vol_r) -- but the oracle passes the cached pan and the
     * just-computed master-scaled level; vol_r is in fact unused (IDA typed 1 arg) (M06). */
    iSNDplatformcdpanvol((int)sndcdvs[0], (int)sndcdvs[1]);
    return 0;
}
