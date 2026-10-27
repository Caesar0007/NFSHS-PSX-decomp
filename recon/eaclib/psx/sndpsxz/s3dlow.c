/* eaclib/psx/sndpsxz/s3dlow.c -- RECONSTRUCTED. NOT original.  *** 1/1 ***  obj s3dlow.obj @0x800E80E4 */
#include "s3dlow.h"
#include "salloc.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "spatkey.h"
#include "sserver.h"
#include "s3dpos.h"

/* SND3dpos : set the 3D pan position on every voice of `tag`. */
int SND3dpos(unsigned int tag, unsigned int pos, int y)
{
    int ch, cur[2];
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized) return -10;
    pos &= 0xffff;
    if (y >= 0x4000)
        y = 0x3fff;
    else if (y < -0x4000)
        y = -0x4000;
    iSNDenteraudio();
    ch = iSNDgetchan(tag);
    if (ch > -1) {
        cur[0] = -1;
        while (iSNDpatchkey(ch, cur))
            iSNDplatform3dpos(cur[0], pos, y);
    }
    iSNDleaveaudio();
    return ch;
}
