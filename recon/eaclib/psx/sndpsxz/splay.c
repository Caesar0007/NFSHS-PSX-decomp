/* eaclib/psx/sndpsxz/splay.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\splay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x800E7A30 .. 0x800E7A68].  SNDplay -- play a sound described by an SND play-info block.
 *   Ghidra nfs4-f.exe.c (splay) + IDA sigs (the `this` __thiscall is the play-info pointer).
 *
 *   play-info `info`: [0] = patch index, [1] = bank id (byte).
 *   bank @ (bankid*0xc + sndgs[0x26]): +4 type(b), +6 patch count(u16), +0xc/+0x14 patch ptr table.
 */
#include "sbvalid.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"
#include "sndbankhdrpriv.h"
#include "splay.h"
#include "stagpat.h"

/* SNDplay @0x800E7A30 : play `info` if the audio system is up; -10 if down. */
int SNDplay(struct SNDPLAYOPTS *info)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    return cSNDplay(info, 0);
}

/* cSNDplay @0x800E7A68 : resolve the play-info's (bank, patch) to a tagged patch and play it.
 * MATCH: 3 FLAT early-returns `if (!cond) return -8;` (not a nested if-body / goto-fail) reproduces
 * the oracle's exact basic-block layout for the in-range test (branch-polarity + which path needs the
 * extra `j`-trampoline); a nested `if (cond) { body }` or an explicit `goto fail;` both left the
 * in-range test's branch inverted (7-diff residual) even though they're semantically identical. */
int cSNDplay(struct SNDPLAYOPTS *info, int recurse)
{
    int patch;
    struct SndTaggedPatchRecordPrefixView *pp;
    struct SndBankDataHeaderPrefix *bank;
    (void)recurse;
    if (iSNDvalidbank((signed char)info->bhandle) < 0)
        return -8;
    patch = info->patnum;
    bank = ((struct SndGlobalServerStateView *)sndgs)->bank_table[(signed char)info->bhandle].data_block;
    if (patch < 0)
        return -8;
    if (!(patch < bank->patch_count))
        return -8;
    if (bank->type == 4)
        pp = ((struct SndBankPatchTable20Prefix *)bank)->first_relative_patch[patch];
    else
        pp = ((struct SndBankPatchTable12Prefix *)bank)->first_relative_patch[patch];
    return iSNDplaytaggedpatch(pp, info);
}
