/* eaclib/psx/sndpsxz/scdvol.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\scdvol.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x800FAA44.  SNDcdvol -- public CD-audio volume/pan setter; caches the master-scaled level and
 *   forwards (pan,vol) to the platform layer.  Ghidra nfs4-f.exe.c (scdvol) + IDA sig.
 *   Ghidra-ism: IDA typed 1 arg, but vol_l/vol_r are both passed on to iSNDplatformcdpanvol (kept 2).
 */
#include "scdvol.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sdcdvol.h"

/* SNDcdvol @0x800FAA44 : cache (vol_l * masterVol)/0x7f and apply the CD pan/volume. */
int SNDcdvol(int vol_l, int vol_r)
{
    sndcdvs[1] = (short)(vol_l * (int)((struct SndGlobalServerStateView *)sndgs)->master_volume / 0x7f);
    /* @0x800FAA90/94: iSNDplatformcdpanvol(*(short*)0x80136CAC = cached pan, (int)(short)level). The
     * recon passed the raw caller args (vol_l, vol_r) -- but the oracle passes the cached pan and the
     * just-computed master-scaled level; vol_r is in fact unused (IDA typed 1 arg) (M06). */
    iSNDplatformcdpanvol(sndcdvs[0], sndcdvs[1]);
    return 0;
}

/* scdvol.obj .data (retail 0x80136CAC), owned here since 2026-09-19 */
short sndcdvs[2] __attribute__((section(".data"))) = { 0x40, 0x7F };
