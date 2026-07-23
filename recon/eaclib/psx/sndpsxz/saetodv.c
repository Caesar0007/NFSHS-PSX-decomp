/* eaclib/psx/sndpsxz/saetodv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\saetodv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x8010AEDC .. 0x8010AEF4].  iSNDatodlrv -- "to delta L/R volume": pan a level relative to a
 *   previous (prevL,prevR) so the shorter side moves, picking which channel gets negated by quadrant.
 *   Ghidra nfs4-f.exe.c (saetodv) + IDA sig (6-arg; Ghidra dropped out_r/prevL/prevR as in_a3/in_stack_*).
 */

extern void iSNDlibatodlrv(int angle, int level, int *out_l, int *out_r);   /* saelib */

extern int iSNDabs(int a);                                                   /* @0x8010AEDC */
extern void iSNDatodlrv(int angle, int level, int *out_l, int *out_r, int prevL, int prevR); /* @0x8010AEF4 */

/* iSNDabs @0x8010AEDC : integer absolute value. */
extern int iSNDabs(int a)
{
    if (a < 0)
        a = -a;
    return a;
}

/* iSNDatodlrv @0x8010AEF4 : pan `level` at `angle` (via saelib), then resolve the new L/R against the prior
 *   (prevL,prevR) quadrant so playback pans smoothly -- one channel is negated to encode the move direction. */
extern void iSNDatodlrv(int angle, int level, int *out_l, int *out_r, int prevL, int prevR)
{
    iSNDlibatodlrv(angle, level, out_l, out_r);
    {
    int          quad;
    int          which;      /* which channel to negate (0 none / 1 L / 2 R) */
    int          newdir;

    if (prevL < 0) {
        if (prevR < 0) {
            quad = 2;
            if (prevL < prevR) quad = 1;
            goto have_quad;
        }
    } else if (-1 < prevR) {
        quad = 1;
        if (prevL < prevR) quad = 2;
        goto have_quad;
    }
    {
        int absL = iSNDabs(prevL);
        int absR = iSNDabs(prevR);
        if (absR < absL)
            quad = 4;
        else
            quad = 3;
    }

have_quad:
    which = 0;
    if ((unsigned int)(angle - 0x4000U) < 0x8000) {
        newdir = 4;
        if (*out_l < *out_r) newdir = 3;
        if (quad < 3) {
            which = 2;
            if (newdir == 3 && quad == 2)
                which = 1;
        }
    } else {
        newdir = 1;
        if (*out_l < *out_r) newdir = 2;
        if (2 < quad && (which = 2, newdir == 2) && quad == 3) which = 1;
    }
    if (prevL < 0) *out_l = -*out_l;
    if (prevR < 0) *out_r = -*out_r;
    if (which == 1) {
        *out_l = -*out_l;
    } else if (which == 2) {
        *out_r = -*out_r;
    }
    }
}
