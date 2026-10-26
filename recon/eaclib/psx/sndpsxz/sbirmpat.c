/* eaclib/psx/sndpsxz/sbirmpat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbirmpat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE5B4.  iSNDbankremovepat -- unload one patch of a bank (release its resolved SPU samples
 *   and null its pointer).  Ghidra nfs4-f.exe.c (sbirmpat) + IDA sig (Hex-Rays cross-checked, identical).
 *   NOTE: VA 0x800FE5B4 ALSO appears as a size-0 phantom FILE record under `sdasync.obj`(iSNDsync_func) in
 *   the SYM/xlsx -- a PSYLINK ghost aliasing this very code.  sdasync contributes no unique function; this
 *   IS that code.  SNDPSXZ is therefore code-complete (sdasync needs no separate .cpp).
 */
#include "sbirmpat.h"
#include "sbvalid.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"
#include "sndbankhdrpriv.h"
#include "stagpat.h"

/* iSNDbankremovepat @0x800FE5B4 : free patch `patch_idx` of bank `bank` (its tagged SPU data), clearing the
 *   patch pointer (+0x14 for bank type 4, else +0xc).  Returns 0 / -8. */
int iSNDbankremovepat(int bank, int patch_idx, struct SNDRemoveEntry *scratch)
{
    struct SndBankDataHeaderPrefix *data = ((struct SndGlobalServerStateView *)sndgs)->bank_table[bank].data_block;
    struct SndBankDataHeaderPrefix *base = data->type == 4 ? data : 0;
    struct SndTaggedPatchRecordPrefixView *pp;

    if (iSNDvalidbank(bank))
        return -8;
    if (patch_idx < 0 || patch_idx >= data->patch_count)
        return -8;
    /* MATCH: group `base + (patch_idx<<2)` so the base is addu operand 1 (oracle `addu v0,s1,v0`), NOT
     * the index-first order `addu v0,v0,s1` that `base + patch_idx*4 + 0x14` produced. */
    if (data->type == 4)
        pp = ((struct SndBankPatchTable20Prefix *)base)->first_relative_patch[patch_idx];
    else
        pp = ((struct SndBankPatchTable12Prefix *)data)->first_relative_patch[patch_idx];
    if (!pp)
        return -8;
    iSNDremovetaggedpatch(pp, scratch);
    if (data->type == 4)
        ((struct SndBankPatchTable20Prefix *)base)->first_relative_patch[patch_idx] = 0;
    else
        ((struct SndBankPatchTable12Prefix *)data)->first_relative_patch[patch_idx] = 0;
    return 0;
}
