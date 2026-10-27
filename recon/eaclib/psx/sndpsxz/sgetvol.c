/* eaclib/psx/sndpsxz/sgetvol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sgetvol.obj @0x80102810 */
#include "salloc.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sgetvol.h"
#include "sserver.h"

/* SNDgetvol @0x80102810 : return the current SPU volume (slot +0x2d) of sound `tag`, or a negative error. */
int SNDgetvol(unsigned int tag)
{
    int ch;
    SndChannel *pool;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (ch < 0) {                                   /* leaveaudio is called per-path (oracle does not tail-merge) */
        iSNDleaveaudio();
        return -8;
    }
    iSNDleaveaudio();                               /* oracle: leaveaudio BEFORE reading the +0x2d vol */
    pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
    return pool[ch].volume;                         /* signed cached-volume load */
}
