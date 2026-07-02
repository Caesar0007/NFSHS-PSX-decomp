/* eaclib/psx/sndpsxz/splay.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\splay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E7A30 .. 0x800E7A68].  SNDplay -- play a sound described by an SND play-info block.
 *   Ghidra nfs4-f.exe.c (splay) + IDA sigs (the `this` __thiscall is the play-info pointer).
 *
 *   play-info `info`: [0] = patch index, [1] = bank id (byte).
 *   bank @ (bankid*0xc + sndgs[0x26]): +4 type(b), +6 patch count(u16), +0xc/+0x14 patch ptr table.
 */

extern "C" int sndgs[];
extern "C" int iSNDvalidbank(int bankid);                /* sbvalid */
extern "C" int iSNDplaytaggedpatch(int patch, int info); /* stagpat */

extern "C" int  cSNDplay(int *info, int recurse);   /* @0x800E7A68 ; a1 always 0 at every call */
extern "C" int  SNDplay(int *info);             /* @0x800E7A30 */

/* SNDplay @0x800E7A30 : play `info` if the audio system is up; -10 if down. */
extern "C" int SNDplay(int *info)
{
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    return cSNDplay(info, 0);
}

/* cSNDplay @0x800E7A68 : resolve the play-info's (bank, patch) to a tagged patch and play it. */
extern "C" int cSNDplay(int *info, int recurse)
{
    int patch, bank, pp;
    (void)recurse;
    if (-1 < iSNDvalidbank((int)(signed char)info[1])) {
        patch = info[0];
        bank = *(int *)((signed char)info[1] * 0xc + sndgs[0x26]);
        if (patch < 0)
            return -8;
        if (patch < (int)(unsigned)*(unsigned short *)(bank + 6)) {
            /* group `bank + (patch<<2)` so the base is addu operand 1 (oracle `addu v0,a1,v0`) -- FIXED
             * the two commutative-addu diffs (11->7). RESIDUAL (7 diffs): the in-range test's branch
             * POLARITY -- oracle `bnez v0` to the body (body = branch target, -8 = fall-through), ours
             * `beqz v0` (body = fall-through). A gcc-2.8.0 basic-block layout coin-flip that neither the
             * nested-if nor the inverted `>=` early-return reshapes; permuter multi-basin candidate. */
            if (*(char *)(bank + 4) == 4)
                pp = *(int *)((bank + (patch << 2)) + 0x14);
            else
                pp = *(int *)((bank + (patch << 2)) + 0xc);
            return iSNDplaytaggedpatch(pp, (int)info);
        }
    }
    return -8;
}
