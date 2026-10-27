/* eaclib/psx/sndpsxz/sautovol.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj sautovol.obj @0x800E82D0 */
#include "salloc.h"
#include "sautovol.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "spatkey.h"
#include "sserver.h"

/* SNDautovol : ramp a sound's voices toward `target` volume over `rate` ticks (sets +0x18 target, +0x14 step). */
int SNDautovol(unsigned int tag, unsigned int rate, int target)
{
    int ch, cur[2];
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;  /* signed -> lb (ccpsx char is unsigned) */
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (ch > -1) {
        if ((int)rate < 1) rate = 1;
        cur[0] = -1;
        while (iSNDpatchkey(ch, cur)) {
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            SndChannel *v = &pool[cur[0]];
            int delta = target * 0x10000 - v->autovol_position.word;
            v->autovol_limit = target * 0x10000;
            v->autovol_step = delta / (int)rate;
        }
    }
    iSNDleaveaudio();
    return ch;
}
