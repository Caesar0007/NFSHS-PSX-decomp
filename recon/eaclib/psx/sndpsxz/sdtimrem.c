/* eaclib/psx/sndpsxz/sdtimrem.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdtimrem.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col12 / SYM v3)
 *   1 fn @0x801049A8.  iSNDtimeremaining -- samples left to play on a voice = (loopEnd - servedPos) / pitch.
 *   Ghidra nfs4-f.exe.c (sdtimrem) + IDA sig.  Voice table @0x801479F0 (0x2c byte / 0xb int stride per voice).
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 19 (`voice+8` position-step word; line 22 is load-bearing and stays)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */
#include "sdtimrem.h"
#include "slib.h"
#include "snd_state.h"
#include "sndpacketpriv.h"

/* iSNDtimeremaining @0x801049A8 : remaining samples for voice `chan`; 0x7fffffff if the voice has no pitch
 *   (stopped/infinite).  The pitch==0 retest is the compiler's divide-by-zero guard. */
unsigned int iSNDtimeremaining(int chan)
{
    SndPacketVoiceState *voice = &((SndPacketVoiceState *)D_801479F0)[chan];
    if (!voice->position_step)
        return 0x7fffffff;
    return (voice->loop_length - voice->byte_position) /
           *(volatile unsigned int *)&voice->position_step;
}
