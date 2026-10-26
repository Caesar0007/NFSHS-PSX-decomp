/* eaclib/psx/sndpsxz/sdplapat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdplapat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x8010BA48.  iSNDplatformplay -- the per-voice SPU launcher for a sound patch (the patch-side
 *   twin of sdpacket's iSNDplatformpacketplay): parse the patch's tag stream into the voice-state table and
 *   key the voice.  Ghidra nfs4-f.exe.c (sdplapat) + the call-site oracle establish an 8-arg ABI
 *   (the callee does not read the eighth argument; Ghidra showed only 3 + in_a3/in_stack_*).
 *   Tags: 0x82 channel count, 0x84 sample rate, 0x85 loop length, 0x8a sample-data ptr, 0x92 output mode.
 *   iSNDgettag is 4-arg (Ghidra dropped to 2).
 */
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndchpriv.h"
#include "sndpacketpriv.h"
#include "sdplapat.h"
#include "sdriver.h"
#include "sgettag.h"
#include "slib_state.h"

extern unsigned char DAT_801479f0;   /* voice-table byte base; retained for exact address materialization */

/* iSNDplatformplay @0x8010BA48 : launch `voice` playing the patch whose tag stream starts at `chan`.
 * MATCH (W31, was 32 diffs): (1) the tag parser is a natural `while` loop, not a goto chain -- loop
 * notes weight the in-loop defs' ref counts, allocating sampleData/voice values in oracle order;
 * (2) channel_count's initial plain store and volatile in-loop re-store let gcc cross-jump the
 * two identical stores without moving the shared store into the tag-0x82 branch delay slot;
 * (3) record fields are read/written through SndPacketVoiceState member views, while `slot` remains
 * the byte cursor that preserves the original manually-scaled voice index/address expression;
 * (4) link_index.vs preserves both the signed -1 sentinel and signed volatile linked-row index.
 * The persistent typed-pointer alias was tested and rejected
 * (95 diffs / 176 instructions); per-access typed views retain the exact 171-instruction match. */
int iSNDplatformplay(unsigned char *chan, int voice, int level, int pitch, int a5, int fx,
                            int volAngle, int pitchOffset)
{
    unsigned char **sampleData = 0;        /* 0x8a tag -> SPU sample-address field */
    int           vt;
    unsigned char *slot;
    int           rate = 0x5622;           /* 0x84 tag (default) */
    int           loopVal = 0;             /* 0x85 tag */
    unsigned int  id;
    int           val;
    unsigned char *ptr;
    (void)a5;
    (void)pitchOffset;

    vt = voice << 1;
    vt += voice;
    vt = vt << 2;
    vt -= voice;
    vt = vt << 2;
    slot = &DAT_801479f0 + vt;

    ((volatile SndPacketVoiceState *)slot)->link_flag = 0;
    ((volatile SndPacketVoiceState *)slot)->link_index.vs = -1;
    ((SndPacketVoiceState *)slot)->route = 0;
    ((volatile SndPacketVoiceState *)slot)->channel_count = 1;
    while (iSNDgettag(&chan, &id, &val, &ptr) && id != 0xfe) {
        if (id == 0x8a) {
            sampleData = (unsigned char **)ptr;
            continue;
        }
        if (id == 0x85) {
            loopVal = val;
            continue;
        }
        if (id == 0x82) {
            ((volatile SndPacketVoiceState *)slot)->channel_count = *(unsigned char *)&val;
            continue;
        }
        if (id == 0x84) {
            rate = val;
            continue;
        }
        if (id == 0x92)
            ((volatile SndPacketVoiceState *)slot)->route = (unsigned char)val;
    }

    ((volatile SndPacketVoiceState *)slot)->loop_length_param = loopVal;
    ((volatile SndPacketVoiceState *)slot)->level = (char)level;
    ((volatile SndPacketVoiceState *)slot)->volume_angle = (unsigned short)volAngle;
    ((volatile SndPacketVoiceState *)slot)->fx_level = (unsigned char)fx;
    ((volatile SndPacketVoiceState *)slot)->spu_start_address = *sampleData;
    ((volatile SndPacketVoiceState *)slot)->byte_position = 0;
    ((volatile SndPacketVoiceState *)slot)->served_position = 0;
    ((volatile SndPacketVoiceState *)slot)->loop_length = loopVal << 0xc;
    ((volatile SndPacketVoiceState *)slot)->initial_pitch.vs = (short)(rate * 0x17c7 >> 0x10);
    if (1 < (unsigned char)((volatile SndPacketVoiceState *)slot)->channel_count) { /* arm linked voice */
        unsigned char *voiceBase = sndpd;
        SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
        ((SndPacketVoiceState *)slot)->link_index.vu = pool[voice].linked_tag_view.linked_channels[0];
        /* MATCH: keep the linked-row base in these field expressions. Hoisting a typed
         * `voiceTable` local changed the address/displacement schedule (15 diffs, 172 vs 171). */
        ((SndPacketVoiceState *)(voiceBase + 0xd8))[
            ((volatile SndPacketVoiceState *)slot)->link_index.vs].link_flag = 1;
        ((SndPacketVoiceState *)(voiceBase + 0xd8))[
            ((volatile SndPacketVoiceState *)slot)->link_index.vs].byte_position = 0;
        ((SndPacketVoiceState *)(voiceBase + 0xd8))[
            ((volatile SndPacketVoiceState *)slot)->link_index.vs].served_position = 0;
        ((SndPacketVoiceState *)(voiceBase + 0xd8))[
            ((volatile SndPacketVoiceState *)slot)->link_index.vs].loop_length = ((SndPacketVoiceState *)slot)->loop_length;
    }
    iSNDplatformpitch(voice, pitch);
    ((SndPacketVoiceState *)slot)->play_state = 1;                                     /* playstate = playing */
    return 0;
}
