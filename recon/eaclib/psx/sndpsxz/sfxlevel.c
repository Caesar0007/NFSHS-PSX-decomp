/* eaclib/psx/sndpsxz/sfxlevel.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 2/2 ***
 *   Source obj : nfs4\eaclib\psx\sfxlevel.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   2 fns @[0x801005BC .. 0x801005E8].  Per-sound effect (reverb) send level.
 *   Ghidra nfs4-f.exe.c (sfxlevel) + disasm-v3 L<801005E8+> -- AUTHORITATIVE: Ghidra OVER-SIMPLIFIED
 *   SNDfxlevel (it dropped the send-scaling math + the /127 normalise + the 3rd call arg).
 *
 *   ⚠️ This call to iSNDplatformfxlevel is 3-ARG (chan, bus, fxon); the sealed sdriver.cpp declared it
 *   2-arg (chan, fxon) -- sdriver's IDA sig is actually (a1,a2,a3), so sdriver should gain the `bus` arg
 *   on a reconcile pass.  extern links regardless; flagged in 00_current_state.md.
 */
#include "salloc.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sdfx.h"
#include "sfxlevel.h"
#include "sdriver.h"
#include "slib.h"
#include "snd_state.h"
#include "spatkey.h"
#include "sserver.h"

/* Codegen-preserving global-state displacement view. The actual records are SndFxBus (0x10 bytes,
 * at sndgs+0x9C); from the state base plus bus*0x10, the master is at displacement +0xA0. */
struct SndFxBusMasterDisplacementView {
    unsigned char pad[0xa0];
    int master;
};

/* iSNDplatformfxmasterlevel (0x801005BC) is NOT in this object: it closes sdfx.obj (2026-09-21).  seffect.obj asks for
 * iSNDplatformfxmasterlevel, iSNDplatformfxinit, SNDfxlevel in that record order, and retail pulls sdfx.obj FIRST and this
 * object second -- so the first name is sdfx.obj's; the code is contiguous with iSNDplatformfxinit. */

/* SNDfxlevel @0x801005E8 : set the effect-send `level` for sound `tag` on `bus` -- for each voice, scale the
 *   requested level by the voice's per-bus send (slot[bus+0x34]) and the bus master (sndgs[bus*4+0x28]),
 *   normalise by 127, and push it to the SPU.  Returns the channel, or a negative error. */
int SNDfxlevel(int tag, int bus, int level)
{
    int chanIdx;
    int cur[2];
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    chanIdx = iSNDgetchan(tag);
    if (chanIdx >= 0) {
        cur[0] = -1;
        while (iSNDpatchkey(chanIdx, cur)) {
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            unsigned char *slot = (unsigned char *)&pool[cur[0]] + bus;
            int scaled = level * ((SndChannelPlaybackFxView *)(slot + 0x34))->fx_level_window[0];
            int fxArg;
            ((SndChannelPlaybackFxView *)(slot + 0x34))->fx_level_window[1] = level;
            /* The displacement view keeps GCC's exact retail lw 0xA0(s4) form; direct SndFxBus
             * indexing adds an address instruction and changes this function's exact match. */
            fxArg = (scaled * ((const struct SndFxBusMasterDisplacementView *)((unsigned char *)sndgs + bus * 0x10))->master) / (127 * 127); /* /(127*127): normalises BOTH the send byte
                                                                 * and the bus-master 0..127 fractions (oracle
                                                                 * magic 0x82061029 sra 13 == signed /16129) */
            iSNDplatformfxlevel(cur[0], bus, fxArg);
        }
    }
    iSNDleaveaudio();
    return chanIdx;
}
