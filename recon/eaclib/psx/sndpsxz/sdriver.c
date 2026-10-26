/* eaclib/psx/sndpsxz/sdriver.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 4/4 PASS ***
 *   Source obj : nfs4\eaclib\psx\sdriver.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   4 fns @[0x800FFE90 .. 0x801000F8].  The platform (PSX) sound-driver back-end: the four entry points
 *   the channel layer pokes to actually start/stop/pitch/volume a hardware voice.
 *   Ghidra nfs4-f.exe.c (sdriver) + disasm-v3 L<800FFE90+> -- AUTHORITATIVE for the args Ghidra dropped:
 *     iSNDvol's 2nd param is the LEVEL (Ghidra called it "chan"); iSNDatolrv is 4-arg, iSNDatodlrv 6-arg,
 *     iSNDsetvol 3-arg; iSNDplatformpitch 2-arg; iSNDplatformfxlevel 3-arg (chan,bus,fxon) -- Ghidra
 *     dropped to 1 visible arg + `in_a2`; IDA sig (a1,a2,a3) confirms 3 (a1=bus is unused/overwritten).
 *
 *   Packet-voice table @0x801479F0 (0x2c stride, indexed [chan*0x2c] for bytes / [chan*0xb] for ints):
 *     int  +0x08 (DAT_801479f8) position step    u16 +0x18 (DAT_80147a08) volume angle/pan
 *     u16  +0x1a (DAT_80147a0a) base pitch        b  +0x1c (DAT_80147a0c) playstate (2 == playing)
 *     b    +0x1d (DAT_80147a0d) substate          b  +0x1e (DAT_80147a0e) volume routing mode
 *     b    +0x1f (DAT_80147a0f) channel count     b  +0x20 (DAT_80147a10) linked voice index
 *     b    +0x22 (DAT_80147a12) cached level      b  +0x23 (DAT_80147a13) cached fx level
 *     b    +0x24/+0x25 (DAT_80147a14/15) L/R out  b  +0x27 (DAT_80147a17) voice-done flag (bit7)
 *     b    +0x28 (DAT_80147a18) pitch-dirty flag
 */
#include "salloc.h"
#include "saetodv.h"
#include "saetolrv.h"
#include "sdriver.h"
#include "sndhookpriv.h"
#include "sndpacketpriv.h"
#include "slib.h"
#include "slib_state.h"

/* --- packet-voice table fields (0x2c stride) --- */
extern char          DAT_801479f0;     /* +0x00 voice-table base (byte, for hook arg)  */

/* "voice has finished" notifier installed by the host (@0x8014803C) */

/* iSNDstop @0x800FFE90 : silence a hardware voice (and its linked partner).  Fires the voice-done hook
 *   unless already flagged, releases the channel(s) back to the pool, marks them idle and strobes the SPU
 *   key-off for the combined voice mask. */
int iSNDstop(unsigned int chan)
{
    int vt = (int)chan * (int)sizeof(SndPacketVoiceState);
    unsigned char *base = sndpd + 0xd8;
    volatile SndPacketVoiceState *slot = (volatile SndPacketVoiceState *)(base + vt);
    unsigned int mask;

    if ((signed char)slot->voice_done >= 0)            /* voice-done bit clear -> notify via sndpd+0x724 */
        ((struct SndDriverHookStateView *)sndpd)->hooks.voice_done((struct SndPacketVoiceState *)slot);
    iSNDfreechan(chan);
    slot->voice_status = 3;
    slot->play_state = 0;
    mask = 1u << chan;
    if (slot->channel_count > 1) {                                     /* linked pair -> stop the partner too */
        chan = slot->link_index.vs;
        iSNDfreechan(chan);
        slot = (volatile SndPacketVoiceState *)(base + (int)chan * (int)sizeof(SndPacketVoiceState));
        mask |= 1u << chan;
        slot->voice_status = 3;
        slot->play_state = 0;
    }
    iSNDpsxkeyoff(mask);
    return 0;
}

/* iSNDplatformpitch @0x800FFF94 : program a voice's hardware pitch from its base pitch * `pitch` multiplier
 *   (12.12), scaled by 0x1b9, mirrored to the linked partner. MATCH (49/49): the voice table is
 *   sndpd+0xd8; spelling the 0x2c stride as 0xb then <<2 preserves the oracle's scheduling. */
int iSNDplatformpitch(int chan, int pitch)
{
    int vt = chan * 0xb;
    SndPacketVoiceState *slot;

    vt <<= 2;
    chan = (int)(sndpd + 0xd8);
    slot = (SndPacketVoiceState *)(chan + vt);

    ((volatile SndPacketVoiceState *)slot)->position_step =
        ((int)((unsigned)slot->initial_pitch.u * pitch) >> 0xc) * 0x1b9;
    ((volatile SndPacketVoiceState *)slot)->pitch_dirty = 1;
    if (((volatile SndPacketVoiceState *)slot)->channel_count == 2) {      /* linked pair shares the pitch */
        chan -= 0xd8;
        ((SndPacketVoiceState *)(unsigned int)(chan + (int)((volatile SndPacketVoiceState *)slot)->link_index.vs * (int)sizeof(SndPacketVoiceState) + 0xd8))->position_step =
            slot->position_step;
        ((SndPacketVoiceState *)(unsigned int)(chan + (int)((volatile SndPacketVoiceState *)slot)->link_index.vs * (int)sizeof(SndPacketVoiceState) + 0xd8))->pitch_dirty = 1;
    }
    return 0;
}

/* iSNDplatformfxlevel @0x80100058 : set/queue a voice's reverb (effect) routing.  While playing, builds the
 *   voice mask (+ linked partner) and turns the SPU echo on/off; otherwise just caches the level.
 *   `fxon` == 0 disables reverb, non-zero enables.  3-arg (chan,bus,fxon): `bus` is unused (the binary
 *   overwrites $a1 with the playstate), `fxon` is $a2 -- matches SNDfxlevel's iSNDplatformfxlevel(voice,bus,fxArg).
 *   MATCH: the slot is async/volatile signed-byte storage; casting playstate to unsigned char produces the
 *   oracle's lbu+nop+andi sequence, `link_index.vu` is the unsigned volatile partner index, and `if (fxon)`
 *   preserves its effect-on/effect-off block order. */
int iSNDplatformfxlevel(unsigned int chan, int bus, int fxon)
{
    int          vt = (int)chan * (int)sizeof(SndPacketVoiceState);
    volatile SndPacketVoiceState *slot = (volatile SndPacketVoiceState *)((volatile unsigned char *)&DAT_801479f0 + vt);
    unsigned int mask;
    bus = (unsigned char)slot->play_state; /* 3-arg per IDA/disasm: a1 is overwritten by the playstate */

    if (bus != 2) {                                          /* not playing -> cache for next key-on */
        slot->fx_level = (char)fxon;
        return 0;
    }
    mask = 1u << chan;                               /* (computed even when the branch below skips) */
    if (slot->channel_count == bus)
        mask |= 1u << slot->link_index.vu;
    if (fxon)
        iSNDpsxeffecton(mask);
    else
        iSNDpsxeffectoff(mask);
    return 0;
}

/* iSNDvol @0x801000F8 : apply a logical `level` to a playing voice -- resolve it to SPU L/R via the voice's
 *   routing mode (absolute iSNDatolrv, or delta-from-cache iSNDatodlrv), cache the L/R, and push to the SPU
 *   voice regs via iSNDsetvol.  When not playing, just caches the level.  (Ghidra mis-named arg2 "chan" and
 *   dropped the inner-call args -- all restored from disasm-v3.) */
int iSNDvol(int chan, int level)
{
    int vt = chan * (int)sizeof(SndPacketVoiceState);
    volatile SndPacketVoiceState *slot = (volatile SndPacketVoiceState *)(sndpd + 0xd8 + vt);
    int outL, outR;

    if (slot->play_state != 2) {                                   /* not playing -> cache the level */
        slot->level = (char)level;
        return 0;
    }
    if (!slot->route)                                     /* absolute L/R from level */
        iSNDatolrv((unsigned)slot->volume_angle, level, &outL, &outR);
    else if (slot->route == 1)                                /* delta from current L/R cache */
        iSNDatodlrv((unsigned)slot->volume_angle, level, &outL, &outR,
                    (signed char)slot->pan_left_cache, (signed char)slot->pan_right_cache);
    slot->pan_left_cache = (unsigned char)outL;
    slot->pan_right_cache = (unsigned char)outR;
    iSNDsetvol(chan, outL, outR);
    return 0;
}
