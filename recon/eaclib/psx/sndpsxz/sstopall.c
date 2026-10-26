/* eaclib/psx/sndpsxz/sstopall.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstopall.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E81A8.  SNDstopall -- stop every voice in the channel pool.  Ghidra nfs4-f.exe.c (sstopall).
 */
#include "sdata.h"
#include "sndchpriv.h"
#include "sndserverpriv.h"
#include "sstop.h"
#include "sstopall.h"

/* SNDstopall @0x800E81A8 : walk the channel pool (sndgs[0x25], count sndgs[4]._1_1_) and SNDstop each
 *   channel by its owning tag. */
void SNDstopall(void)
{
    int i, off;
    SndChannel *record;
    struct SndGlobalServerStateView *base = (struct SndGlobalServerStateView *)sndgs;
    if (base->channel_count) {
        struct SndGlobalServerStateView *gs;
        i = 0;
        off = i;
        gs = base;
        off = i;
        do {
            i++;
            record = (SndChannel *)(unsigned int)(off + (unsigned int)gs->play_records);
            SNDstop(record->owner_tag);
            off += sizeof(SndChannel);
        } while (i < gs->channel_count);
    }
}
