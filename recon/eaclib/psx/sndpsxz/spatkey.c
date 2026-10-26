/* eaclib/psx/sndpsxz/spatkey.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 7/10 PASS ***
 *   Source obj : nfs4\eaclib\psx\spatkey.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   10 fns @[0x800FEF4C .. 0x800FF3CC].  SPU key/voice/volume control -- the bottom-level poke layer for
 *   the channel pool (volume calc, panning, SPU key-on/off + reverb-effect registers).
 *   Ghidra nfs4-f.exe.c L164056..164366 + disasm-v3 L329894+ (for the dropped setvol/setslot args).
 *
 *   SPU register bases (set by iSNDinit): DAT_80147e28 = voice L/R-vol regs (chan*0x10), DAT_80147e2c =
 *   SPU control regs (key-on @+0x188, key-off @+0x18C, reverb-on @+0x198, reverb-vol @+0x184).
 *   Packet-voice table @0x801479F0 (0x2c stride): +0x1c playstate, +0x1e routing mode, +0x1f channels,
 *   +0x20 linked voice, +0x22 fx send, +0x24/0x25 L/R cache, +0x26 flag.
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 20, 109, 120, 131, 146, 161 (the former `SNDPD_VOICEREG` macro and five `int *base = (int *)sndpd` driver-state bases; the SPU-register accesses THROUGH them keep their volatile)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "spatkey.h"
#include "sdriver.h"
#include "slib.h"
#include "slib_state.h"

/* iSNDpatchkey @0x800FEF4C : iterate the voices keyed to a channel group.  For a standalone channel,
 *   hands back `chan` once; for a group, walks the pool returning each held member.  `tag` points at a
 *   cursor (init -1).  Returns 1 while voices remain, 0 when exhausted. */
int iSNDpatchkey(int chan, int *tag)
{
    SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
    SndChannel *pbase = &pool[chan];
    char grp;
    grp = pbase->group_id;
    if (grp) {
        int i = *tag;
        *tag = i + 1;
        if (i + 1 < ((struct SndGlobalServerStateView *)sndgs)->channel_count) {
            struct SndGlobalServerStateView *gs = (struct SndGlobalServerStateView *)sndgs;
            for (; *tag < gs->channel_count; *tag = *tag + 1) {
                SndChannel *pool = gs->play_records;
                SndChannel *p = &pool[*tag];
                if (p->group_id == grp && p->state == 1 && -1 < (int)p->owner_tag)
                    return 1;
            }
        }
    } else if (*tag < 0) {
        *tag = chan;
        return 1;
    }
    return 0;
    /* MATCH (65 insns): the state, group-id, and owner-tag tests use SndChannel fields. */
}

/* iSNDcalcvol .. iSNDstartvoice (0x800FF050..0x800FF5A8) are NOT in this object: they open slib.obj (2026-09-21).
 * Retail pulls spatkey.obj for span.obj's `iSNDpatchkey`, then slib.obj, then sdriver.obj for svol.obj's `iSNDvol` -- and the
 * only thing svol.obj asks for in between is `iSNDcalcvol`.  The code is contiguous, so the text layout cannot tell; the pull
 * order does (tools/psyq_pipe/slink_pullsim.py). */
