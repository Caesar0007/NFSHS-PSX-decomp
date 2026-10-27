/* eaclib/psx/sndpsxz/sbremove.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\sbremove.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x800E65F8 .. 0x800E6694].  Unload sound banks: stop their voices, release SPU data, clear the
 *   bank table.  Ghidra nfs4-f.exe.c (sbremove) + IDA sigs (`this` is the bank id).
 */
#include "sbremove.h"
#include "sbvalid.h"
#include "sstop.h"
#include "sbirmpat.h"
#include "sdasync.h"
#include "snd_globals.h"
#include "sndchpriv.h"
#include "sndbankpriv.h"
#include "sndbankhdrpriv.h"
#include "sdresolv.h"

/* iSNDremovepatches @0x800E65F8 : release each of a bank's `count` resolved patches (de-dup via a local
 *   scratch table seeded to -1). */
int iSNDremovepatches(int bank, int count)
{
    struct SNDRemoveEntry scratch[256];
    int i;
    unsigned char *neg1 = (unsigned char *)-1;
    for (i = 0xFF; i >= 0; i--) {
        scratch[i].spu_address = neg1;
    }
    for (i = 0; i < count; i++)
        iSNDbankremovepat(bank, i, scratch);
    return 0;
}

/* SNDbankremove @0x800E6674 : the exit-time hook (sndgs[0x1f]); unloads bank `bankId`. */
void SNDbankremove(int bankId)
{
    cSNDbankremove(bankId, 0);
}

/* cSNDbankremove @0x800E6694 : unload bank `bankId` (or all banks when bankId == -1) -- stop its playing
 *   voices, free its patches/SPU data, and clear its bank-table entry. */
int cSNDbankremove(int bankId, int recurse)
{
    struct SNDGlobals *base = &sndgs;
    int i;

    if (!base->initialized)
        return -10;
    if (bankId == -1) {                  /* unload every bank */
        for (i = 0; i < base->bank_count; i++)
            cSNDbankremove(i, 0);
        return 0;
    }
    if (iSNDvalidbank(bankId))
        return -8;
    {
        struct SndBankDataHeaderPrefix *data = base->bank_table[bankId].data_block;
        int off;
        struct SndBankTableEntry *entry;
        struct SNDGlobals *base2;
        i = 0;
        if (base->channel_count) {     /* stop voices owned by this bank */
            struct SNDGlobals *loopbase = base;
            off = 0;
            do {
                /* `off` is a byte displacement; convert the legacy base before adding it. */
                SndChannel *slot = (SndChannel *)(off + (unsigned char *)loopbase->play_records);
                if (slot->start_marker == bankId)
                    SNDstop((int)slot->owner_tag);
                off += sizeof(SndChannel);
            } while (loopbase->channel_count > ++i);
        }
        base2 = &sndgs;
        /* Keep the 32-bit sum for retail operand order, then view its result as the typed table record. */
        entry = (struct SndBankTableEntry *)(bankId * sizeof(struct SndBankTableEntry) +
            (unsigned int)base2->bank_table);
        if (entry->platform_allocated.s) {
            iSNDplatformfree(entry->platform_block);
            sndgs.bank_table[bankId].platform_allocated.u = 0;
        } else
            iSNDremovepatches(bankId, data->patch_count);
        sndgs.bank_table[bankId].data_block = 0;
        sndgs.bank_table[bankId].load_state.u = 0;
    }
    return 0;
}

