/* eaclib/psx/sndpsxz/spvtolrv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\spvtolrv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x8010C738.  iSNDpvtolrv -- pan-to-L/R for the CD/streaming volume (linear pan law about centre
 *   0x40, range 0..0x7f).  Ghidra nfs4-f.exe.c (spvtolrv) + IDA sig.
 */
extern int iSNDpvtolrv(int pan, int level, int *out_l, int *out_r);   /* @0x8010C738 */

/* iSNDpvtolrv @0x8010C738 : split `level` into L/R per `pan` -- centre keeps both, left/right attenuates the
 *   opposite channel by (pan or 0x7f-pan)/0x40.  Returns the attenuated value (0x40 when centred). */
extern int iSNDpvtolrv(int pan, int level, int *out_l, int *out_r)
{
    int v = 0x40;
    *out_l = level;
    *out_r = level;
    if (pan != 0x40) {
        if (pan < 0x40) {
            v = level * pan >> 6;
            *out_r = v;
            return v;
        }
        v = level * (0x7f - pan) >> 6;
        *out_l = v;
    }
    return v;
}
