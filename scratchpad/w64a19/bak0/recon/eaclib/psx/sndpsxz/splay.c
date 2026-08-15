/* eaclib/psx/sndpsxz/splay.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\splay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E7A30 .. 0x800E7A68].  SNDplay -- play a sound described by an SND play-info block.
 *   Ghidra nfs4-f.exe.c (splay) + IDA sigs (the `this` __thiscall is the play-info pointer).
 *
 *   play-info `info`: [0] = patch index, [1] = bank id (byte).
 *   bank @ (bankid*0xc + sndgs[0x26]): +4 type(b), +6 patch count(u16), +0xc/+0x14 patch ptr table.
 */

extern int sndgs[];
extern int iSNDvalidbank(int bankid);                /* sbvalid */
extern int iSNDplaytaggedpatch(int patch, int info); /* stagpat */

extern int  cSNDplay(int *info, int recurse);   /* @0x800E7A68 ; a1 always 0 at every call */
extern int  SNDplay(int *info);             /* @0x800E7A30 */

/* SNDplay @0x800E7A30 : play `info` if the audio system is up; -10 if down. */
extern int SNDplay(int *info)
{
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    return cSNDplay(info, 0);
}

/* cSNDplay @0x800E7A68 : resolve the play-info's (bank, patch) to a tagged patch and play it.
 * MATCH: 3 FLAT early-returns `if (!cond) return -8;` (not a nested if-body / goto-fail) reproduces
 * the oracle's exact basic-block layout for the in-range test (branch-polarity + which path needs the
 * extra `j`-trampoline); a nested `if (cond) { body }` or an explicit `goto fail;` both left the
 * in-range test's branch inverted (7-diff residual) even though they're semantically identical. */
extern int cSNDplay(int *info, int recurse)
{
    int patch, bank, pp;
    (void)recurse;
    if (iSNDvalidbank((int)(signed char)info[1]) < 0)
        return -8;
    patch = info[0];
    bank = *(int *)((signed char)info[1] * 0xc + sndgs[0x26]);
    if (patch < 0)
        return -8;
    if (!(patch < (int)(unsigned)*(unsigned short *)(bank + 6)))
        return -8;
    if (*(char *)(bank + 4) == 4)
        pp = *(int *)((bank + (patch << 2)) + 0x14);
    else
        pp = *(int *)((bank + (patch << 2)) + 0xc);
    return iSNDplaytaggedpatch(pp, (int)info);
}
