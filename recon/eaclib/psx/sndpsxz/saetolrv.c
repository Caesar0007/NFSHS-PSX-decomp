/* eaclib/psx/sndpsxz/saetolrv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\saetolrv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010B0A8.  iSNDatolrv -- angle+level -> absolute L/R volumes (the "to L/R volume" pan law).
 *   Ghidra nfs4-f.exe.c (saetolrv) + IDA sig (4-arg; Ghidra dropped out_l/out_r as in_a2/in_a3).
 */

extern void iSNDlibatodlrv(int angle, int level, int *out_l, int *out_r);   /* saelib */

extern void iSNDatolrv(int angle, int level, int *out_l, int *out_r);       /* @0x8010B0A8 */

/* iSNDatolrv @0x8010B0A8 : compute the panned L/R volumes for `angle`/`level` (via the shared saelib pan
 *   law) then take their magnitudes -- this absolute variant ignores phase.
 *   MATCH: callers declare void; void return removes the v0 liveness that caused the extra nop+lw. */
extern void iSNDatolrv(int angle, int level, int *out_l, int *out_r)
{
    iSNDlibatodlrv(angle, level, out_l, out_r);
    if (*out_l < 0)
        *out_l = -*out_l;
    if (*out_r < 0)
        *out_r = -*out_r;
}
