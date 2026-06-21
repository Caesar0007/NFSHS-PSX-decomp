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

extern "C" int  cSNDplay(int *info);            /* @0x800E7A68 */
extern "C" void SNDplay(int *info);             /* @0x800E7A30 */

/* SNDplay @0x800E7A30 : play `info` if the audio system is up. */
extern "C" void SNDplay(int *info)
{
    if ((char)sndgs[0xf] != 0)
        cSNDplay(info);
}

/* cSNDplay @0x800E7A68 : resolve the play-info's (bank, patch) to a tagged patch and play it. */
extern "C" int cSNDplay(int *info)
{
    int patch, bank, pp;
    if (-1 < iSNDvalidbank((int)(char)info[1])) {
        patch = info[0];
        bank = *(int *)((char)info[1] * 0xc + sndgs[0x26]);
        if (patch < 0)
            return -8;
        if (patch < (int)(unsigned)*(unsigned short *)(bank + 6)) {
            if (*(char *)(bank + 4) == 4)
                pp = *(int *)(bank + patch * 4 + 0x14);
            else
                pp = *(int *)(bank + patch * 4 + 0xc);
            return iSNDplaytaggedpatch(pp, (int)info);
        }
    }
    return -8;
}
