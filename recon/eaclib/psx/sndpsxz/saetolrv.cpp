/* eaclib/psx/sndpsxz/saetolrv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\saetolrv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010B0A8.  iSNDatolrv -- angle+level -> absolute L/R volumes (the "to L/R volume" pan law).
 *   Ghidra nfs4-f.exe.c (saetolrv) + IDA sig (4-arg; Ghidra dropped out_l/out_r as in_a2/in_a3).
 */

extern "C" void iSNDlibatodlrv(int angle, int level, int *out_l, int *out_r);   /* saelib */

extern "C" int iSNDatolrv(int angle, int level, int *out_l, int *out_r);        /* @0x8010B0A8 */

/* iSNDatolrv @0x8010B0A8 : compute the panned L/R volumes for `angle`/`level` (via the shared saelib pan
 *   law) then take their magnitudes -- this absolute variant ignores phase. */
extern "C" int iSNDatolrv(int angle, int level, int *out_l, int *out_r)
{
    iSNDlibatodlrv(angle, level, out_l, out_r);
    /* @0x8010B0C4-E8: abs(*out_l)/abs(*out_r).  near-miss floor (2 insns): the oracle returns the 2nd
     * abs's `negu` value straight out of $v0 (negu in the bgez delay slot, always-runs), avoiding a
     * reload; gcc here keeps `*out_r` live -> a `nop` in the bgez delay slot + a `lw v0,0(s1)` reload.
     * Branch-polarity/explicit-return reshapes only make it worse. */
    if (*out_l < 0)
        *out_l = -*out_l;
    if (*out_r < 0)
        *out_r = -*out_r;
    return *out_r;
}
