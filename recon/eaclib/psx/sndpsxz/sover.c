/* eaclib/psx/sndpsxz/sover.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sover.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7B14.  SNDover -- has the sound keyed on `tag` finished?  Ghidra nfs4-f.exe.c (sover)
 *   + disasm-v3 L<800E7B14>.
 */
#include "salloc.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sover.h"
#include "sserver.h"

/* SNDover @0x800E7B14 : report whether `tag` still owns a live channel.  iSNDgetchan returns a negative
 *   error once the tag has been reclaimed/stopped, so `(unsigned)result >> 31` yields 1 when the sound is
 *   "over" (channel gone) and 0 while it still plays.  Returns -10 if the audio system is uninitialised. */
unsigned int SNDover(unsigned int tag)
{
    unsigned int r;
    if (((struct SndGlobalServerStateView *)sndgs)->initialized) {   /* init flag = low byte of sndgs[0xf]; direct-addr read */
        iSNDenteraudio();
        r = (unsigned int)iSNDgetchan(tag) >> 0x1f;   /* 1 == finished, 0 == still playing */
        iSNDleaveaudio();
        return r;
    }
    return 0xfffffff6;                                /* -10 : audio not initialised */
}
