/* eaclib/psx/sndpsxz/sstop.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstop.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7E80.  SNDstop -- stop all voices keyed on a tag.  Ghidra nfs4-f.exe.c L145138.
 */
#include "salloc.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "spatkey.h"
#include "sserver.h"
#include "sstop.h"
#include "sdriver.h"

/* SNDstop @0x800E7E80 : stop every voice patched under `tag`.  Resolves the tag to a channel, then walks
 *   its patch keys, issuing the low-level stop on each.  Returns the channel (or a negative error). */
int SNDstop(unsigned int tag)
{
    int chan;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    chan = iSNDgetchan(tag);
    if (chan > -1) {
        int v = -1;
        while (iSNDpatchkey(chan, &v))
            iSNDstop(v);
    }
    iSNDleaveaudio();
    return chan;
}
