/* eaclib/psx/sndpsxz/sbvalid.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbvalid.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE6BC.  iSNDvalidbank -- is `bank_id` a loaded, ready sound bank?  Ghidra nfs4-f.exe.c.
 *
 *   Bank table @ sndgs[0x26], 0xc-byte entries: +0x00 data ptr (0 == empty), +0x08 load state (0 == ready).
 */
#include "sbvalid.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"

/* iSNDvalidbank @0x800FE6BC : 0 if the bank is loaded and ready, -8 if out of range / empty, -0x12 if it
 *   is still loading. */
int iSNDvalidbank(int bank_id)
{
    struct SndBankTableEntry *bank;
    if (bank_id < 0 || ((struct SndGlobalServerStateView *)sndgs)->bank_count <= bank_id)
        return -8;
    /* Keep the pointer field typed; the 32-bit sum is only the exact retail byte-address schedule. */
    bank = (struct SndBankTableEntry *)(bank_id * sizeof(struct SndBankTableEntry) +
        (unsigned int)((struct SndGlobalServerStateView *)sndgs)->bank_table);
    if (!bank->data_block)
        return -8;
    if (bank->load_state.s)
        return -0x12;
    return 0;
}
