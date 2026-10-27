/* eaclib/psx/sndpsxz/sbadd.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbadd.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7DEC.  SNDbankadd -- register a new sound bank: allocate a slot, record its data pointer
 *   in the bank table, install the exit-time bank-remove hook, and download it to SPU.
 *   Ghidra nfs4-f.exe.c (sbadd) + disasm: a2 is the bank DATA pointer (passed twice to iSNDdownloadbank),
 *   a1 is the output slot pointer; iSNDbankalloc returns the slot (Ghidra void-typed it).
 */
#include "sbadd.h"
#include "sballoc.h"
#include "sbremove.h"
#include "sbdload.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankpriv.h"

/* SNDbankadd @0x800E7DEC : add the bank at `bank_data`, writing its slot id to *bank_out.  Returns the
 *   download result, or -10 if audio is down. */
int SNDbankadd(int *bank_out, void *bank_data)
{
    int  slot;
    struct SndBankTableEntry *e;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    slot = iSNDbankalloc();
    *bank_out = slot;
    e = &((struct SndGlobalServerStateView *)sndgs)->bank_table[slot];
    e->data_block = bank_data;
    e->platform_block = bank_data;
    ((struct SndGlobalLifecycleHookView *)sndgs)->bank_remove_hook = SNDbankremove;
    /* The first argument views the bank header prefix; the second is the read-only RAM DMA source base. */
    return iSNDdownloadbank(bank_data, bank_data);
}
