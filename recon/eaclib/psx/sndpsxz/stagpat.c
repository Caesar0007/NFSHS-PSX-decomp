/* eaclib/psx/sndpsxz/stagpat.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 8 PASS ***
 *   Source obj : nfs4\eaclib\psx\stagpat.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   8 fns @[0x80101ABC .. 0x801025C0].  The patch-trigger engine -- parse a sound bank's tag stream, build
 *   per-note "timbres", and launch the voices (cSNDplay's core).  Ghidra nfs4-f.exe.c (stagpat) + IDA sigs.
 *
 *   The two dense parsers (iSNDplaytaggedpatch 864B / iSNDplaytaggedtimbre 1280B) were reconstructed
 *   from Ghidra + disasm-v3 (7-arg timbre entry, range fields, and captured returns Ghidra lost).
 *   NEW leaf deps: sgettag(iSNDgettag), sdresolv(iSNDplatformresolve/remove), srrange(randrange),
 *   srandom(iSNDrandom), sdplapat(iSNDplatformplay).
 *
 *   SndTimbre (0x98 bytes): velocity/note ranges at +0x04..+0x10, allocation priority/flags at +0x14/+0x18,
 *     base note +0x1C, detune/pan controls from +0x30, curve tables through +0x8C, pitch-offset flag +0x90,
 *     pan scale +0x94. Root bank data headers and tagged-patch records are distinct views (sndbankhdrpriv.h).
 */
#include "salloc.h"
#include "sclcptch.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "sndbankhdrpriv.h"
#include "sndchpriv.h"
#include "sndtimbrepriv.h"
#include "sdplapat.h"
#include "sdresolv.h"
#include "sgettag.h"
#include "slib.h"
#include "snd_state.h"
#include "srandom.h"
#include "srrange.h"

struct SndTagScanState {
    unsigned char *cursor;
    unsigned int id;
    int value;
    unsigned char *data;
};
typedef char SndTagScanState_size_check[(sizeof(struct SndTagScanState) == 0x10) ? 1 : -1];
#include "sserver.h"
#include "sstop.h"
#include "stagpat.h"

/* stagpat.obj .data 0x801371C4..0x801371D0 (link-order slot sclcptch [378] .. CTYPE0 [389]; stagpat [379] is the only
 * user of both cells): the default envelope, then the rolling key-group counter. */
signed char snddefaultenvelope[8] = { -1, -1, -1, 0x7f, 0x7f, 0, 0, 0 };   /* @0x801371C4 */
unsigned char DAT_801371cc = 0;   /* @0x801371CC : rolling key-group counter (the library is built -G0: plain .data) */

/* iSNDresetpatch @0x80101ABC : clear a patch-play state's flag word (+0x90). */
void iSNDresetpatch(struct SndTimbre *patch)
{
    patch->apply_pitch_offset.word = 0;
}

/* iSNDresettimbre @0x80101AC4 : zero the 0x98-byte timbre `buf` then load the default timbre into `t`
 *   (note range 0..0x3c, full velocity, default envelope). */
unsigned char *iSNDresettimbre(struct SndTimbre *t, struct SndTimbre *buf)
{
    int i;
    for (i = 0x25; i > -1; i--)
        ((union SndTimbreBufferView *)buf)->tag_words[i] = 0;
    t->velocity_min.word = 0;
    t->velocity_max.word = 0x7f;
    t->note_min.word = 0;
    t->note_max.word = 0x7f;
    t->channel_priority.word = -1;
    t->allocation_flags.word = 0;
    t->base_note.word = 0x3c;
    t->control32.word = -1;
    t->sweep_count.word = 1;
    t->envelope_detune.word = 0;
    t->channel_count.word = 1;
    t->detune.word = 0x40;
    t->detune_range.word = 0;
    t->pan.word = 0x7f;
    t->pan_range.word = 0;
    t->base_detune.word = 0;
    t->base_detune_range.word = 0;
    t->final_volume_curve.byte_pointer = 0;
    t->playback_factor.word = 0;
    t->pan_curve.sbyte_pointer = 0;
    t->detune_curve.sbyte_pointer = 0;
    t->portamento_initial.word = 0x7f;
    t->velocity_curve.sbyte_pointer = 0;
    t->velocity_phase_limit.word = 0;
    t->velocity_phase_seed.word = 0;
    t->pitch_lfo_table.sbyte_pointer = 0;
    t->lfo_phase_limit.word = 0;
    t->pitch_lfo_seed.word = 0;
    t->pitch_lfo_depth.word = 0;
    t->pan_scale.word = 1;
    t->envelope_sweep_table.byte_pointer = (unsigned char *)snddefaultenvelope;
    return (unsigned char *)snddefaultenvelope;
}

/* iSNDresolveheader @0x80101B7C : fold an override header `out` into the running timbre header `hdr`
 *   (sum the envelope / volume / pitch fields). */
void iSNDresolveheader(struct SndTimbre *hdr, struct SndTimbre *out)
{
    hdr->final_volume_curve.byte_pointer = out->final_volume_curve.byte_pointer + hdr->final_volume_curve.word;
    hdr->pan_curve.sbyte_pointer = out->pan_curve.sbyte_pointer + hdr->pan_curve.word;
    hdr->detune_curve.sbyte_pointer = out->detune_curve.sbyte_pointer + hdr->detune_curve.word;
    hdr->velocity_curve.sbyte_pointer = out->velocity_curve.sbyte_pointer + hdr->velocity_curve.word;
    hdr->pitch_lfo_table.sbyte_pointer = out->pitch_lfo_table.sbyte_pointer + hdr->pitch_lfo_table.word;
    if (hdr->envelope_sweep_table.byte_pointer)
        hdr->envelope_sweep_table.byte_pointer = out->envelope_sweep_table.byte_pointer + hdr->envelope_sweep_table.word;
}

/* iSNDfindfreekey @0x80101BFC : advance the rolling key-group counter (DAT_801371cc) to a value not
 *   currently owned by any held channel; RETURNS the chosen key (oracle: `lbu v0,key; jr ra` --
 *   iSNDplaytaggedpatch captures it in $fp and stamps it into every started voice's +0x37). */
int iSNDfindfreekey(void)
{
    int   i, count, probe;
    unsigned char key;
    struct SndGlobalServerStateView *gs;
    SndChannel *slot;
top:
    DAT_801371cc += 1;        /* lbu/addiu/sb; the == 0 test reuses the CSE'd value */
    if (!DAT_801371cc)                     /* skip 0 (the "no group" sentinel) */
        DAT_801371cc += 1;
    i = 0;
    gs = (struct SndGlobalServerStateView *)sndgs; /* one la base for the +0x11 / +0x94 displacements */
    probe = gs->channel_count;
    if (!probe)
        goto done;
    count = gs->channel_count;
    key   = DAT_801371cc;
    slot  = gs->play_records;
loop:                                             /* goto-formed: no LOOP notes -> no giv anchoring */
    if (slot->state) {
        if (slot->group_id == key)
            goto top;                             /* key owned by a held channel -> try the next one */
    }
    i++;
    slot++;
    if (i < count)
        goto loop;
done:
    return DAT_801371cc;
    /* MATCH: keeping `probe` distinct from `count` preserves the oracle's branch value in v1 and copies it to a2 for
     * the loop bound. */
}

/* iSNDplaytaggedtimbre @0x80101C8C : launch ONE note's voice from a fully-resolved timbre.  Folds the
 *   override `header`, randomises detune/pan/pitch (srrange/srandom), allocates a channel, fills its ~50
 *   playback fields from the timbre `vol`, computes the SPU sweep, and starts it via iSNDplatformplay.
 *   7-arg per IDA/disasm (Ghidra showed 3 + dropped header/baseNote/velScale/pitchOff).
 *     header   = override header folded into `vol`
 *     baseNote = the note being played (transposes pitch off the timbre's base note vol[0x1c])
 *     velScale = velocity (scales the pan curve)
 *     pitchOff = pitch-bend offset (applied when vol[0x90] is set)
 *   iSNDallocchan is 4-arg (vol[0x14] priority, vol[0x2c] numCh, vol[0x18] flag, &out). The final
 *   iSNDplatformplay call is 8-arg: the oracle stores args 5..8 at sp+0x10..0x1c. This reconstruction
 *   restores the detune table/scaling path, both PRNG return uses, all four stack arguments, and the
 *   success/failure return contract. MATCH (320/320): modeling the one-word platform-rate storage as
 *   an array element makes gcc split its address materialization around the independent byte load. */
int iSNDplaytaggedtimbre(unsigned char *timbre, struct SNDPLAYOPTS *tag, struct SndTimbre *vol, struct SndTimbre *header,
                                    int baseNote, int velScale, int pitchOff)
{
    int b7  = (signed char)tag->pan;
    int b8  = (signed char)tag->vol;
    int b9  = (signed char)tag->bend;
    int b10 = (signed char)tag->fxlevel0;
    unsigned int  out;
    int           chan, detune, pan, sw, s28, num, active, tmp;
    SndChannel   *slot;
    int           field28, field4c;
    signed char  *field54, *field5c;
    int           playOffset, playResult;
    int           playLevel, playPitch, playTag;
    unsigned int  sv;

    iSNDresolveheader(vol, header);

    detune = vol->detune.word;
    if (vol->detune_range.word)
        detune += randrange(vol->detune_range.word);
    if (detune >= 0x80)
        detune = 0x7f;
    else if (detune < 0)
        detune = 0;

    chan = iSNDallocchan(vol->channel_priority.uword, vol->channel_count.word, vol->allocation_flags.word, &out);
    if (chan < 0)
        return chan;
    {
        SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
        slot = &pool[chan];
        slot->pan_scale = vol->pan_scale.ubyte;
        sv = vol->base_detune.uhalf;
        slot->base_detune = sv;
        sv -= (vol->base_note.word - baseNote) * 100;
        slot->base_detune = sv;
        if (vol->apply_pitch_offset.word)
            slot->base_detune = sv + pitchOff;
        if (vol->base_detune_range.word)
            slot->base_detune = (unsigned short)slot->base_detune + randrange(vol->base_detune_range.word);
        slot->final_volume_curve = vol->final_volume_curve.byte_pointer;
        field54 = vol->pan_curve.sbyte_pointer;
        slot->pan_curve = field54;
        field5c = vol->detune_curve.sbyte_pointer;
        slot->autovol_position.word = b8 << 0x10;
        slot->detune_curve = field5c;
        active = slot->pan_scale;
        slot->autovol_step = 0;
        slot->current_pan = b7;
        if (active != 1)
            b7 = (b7 - 0x40) * active + 0x40;
        b7 = detune + b7 - 0x40;
        if (b7 < 0)
            b7 = 0;
        else if (b7 > 0x7f)
            b7 = 0x7f;
        if (slot->pan_curve)
            b7 = slot->pan_curve[b7];
        pan = vol->pan.word;
        if (vol->pan_range.word)
            pan += randrange(vol->pan_range.word);
        if (pan >= 0x80)
            pan = 0x7f;
        if (pan < -0x80)
            pan = -0x80;
        slot->pan = (char)detune;
        slot->patch_volume = (char)(pan * velScale / 0x7f);
        field28 = vol->envelope_detune.word;
        slot->bend = b9;
        slot->envelope_detune_depth = (short)(field28 * 100);
        slot->sweep_table = (SndSweepSegment *)vol->envelope_sweep_table.byte_pointer;
        slot->portamento_position.word = vol->portamento_initial.word << 0x10;
        slot->sweep_index = 0;
        slot->sweep_count = vol->sweep_count.ubyte;
        slot->control32 = vol->control32.ubyte;
        sw = slot->sweep_table->duration;
        slot->sweep_countdown = sw;
        if (sw < 0)
            slot->sweep_countdown = 0x7fffffff;
        s28 = slot->sweep_countdown;
        num = slot->sweep_table->target_pitch * 0x10000 - slot->portamento_position.word;
        slot->portamento_step = num / s28;
        slot->velocity_curve = vol->velocity_curve.sbyte_pointer;
        slot->pitch_lfo_table = vol->pitch_lfo_table.sbyte_pointer;
        slot->velocity_phase_limit = vol->velocity_phase_limit.ubyte;
        slot->lfo_phase_limit = vol->lfo_phase_limit.ubyte;
        slot->pitch_lfo_depth = (unsigned short)vol->pitch_lfo_depth.ubyte;
        {
            unsigned int rv = vol->velocity_phase_seed.uword;
            if (rv) {
                rv = iSNDrandom();
                slot->velocity_phase = (char)(rv % vol->velocity_phase_limit.uword);
            } else
                slot->velocity_phase = 0;
            rv = vol->pitch_lfo_seed.uword;
            if (rv) {
                rv = iSNDrandom();
                slot->pitch_lfo_phase = (char)(rv % vol->lfo_phase_limit.uword);
            } else
                slot->pitch_lfo_phase = 0;
        }
        slot->tag_word_e = (short)tag->timemult;
        slot->base_pitch = (short)tag->pitchmult;
        slot->linear_pitch_cache = 0;
        iSNDcalcpitch(chan);
        field4c = vol->playback_factor.ubyte;
        slot->playback_fx.playback.playback_factor35 = b10;
        slot->playback_fx.playback.playback_factor34 = field4c;
        slot->start_marker   = (unsigned char)tag->bhandle;
        slot->linked_tag_view.tagged_patch.tagged_patch_word = *(short *)tag;
        iSNDcalcvol(chan);
        if ((signed char)tag->use3dpos != 0) {
            tmp = tag->azimuth;
            playOffset = tag->elevation;
        } else {
            tmp = b7;
            tmp -= 0x40;
            tmp = tmp << 8;
            tmp = (unsigned short)tmp;
            playOffset = 0;
        }
        playTag = tag->timemult;
        playLevel = slot->volume;
        playPitch = slot->spu_pitch;
        playResult = iSNDplatformplay(timbre, chan, playLevel, playPitch, playTag,
                                      sndgs_fx_bus0_master[0] * slot->playback_fx.playback.playback_factor34 *
                                       slot->playback_fx.playback.playback_factor35 / 16129,
                                      tmp, playOffset);
        if (playResult < 0)
            iSNDfreechan(chan);
        else
            return out;
        return playResult;
    }
}

/* iSNDplaytaggedpatch @0x8010218C : THE cSNDplay entry -- parse a patch's tag stream into per-note timbres
 *   and launch each note whose range matches.  For each tag: 0xfd records the SPU sample data ptr (the
 *   "timbre" to play); 0xfe terminates a note-region header -> if the requested note(tag[5])/vel(tag[6])
 *   fall in the accumulated range (builtTimbre[1..4]) launch it via iSNDplaytaggedtimbre, then reset the
 *   timbre; tag < 0x26 sets timbre[tag] (and the parallel override header) from the tag's two values.
 *   The started voices are collected and joined into a key group; on any failure all are SNDstop'd.
 *   Ghidra body + disasm: range fields are builtTimbre +4/+8 (vel min/max), +0xc/+0x10 (note min/max);
 *   the iSNDplaytaggedtimbre return (Ghidra lost it to void-typing) is the started voice tag.
 *     7-arg call: (timbreData, tag, &builtTimbre, &header, note, vel, pitchOff). pitchOff ($s6) is the
 *     CAPTURED randrange() result of the last 0x24 field tag (0 until one is seen); the group key ($fp)
 *     is the CAPTURED iSNDfindfreekey() return.  BYTE-MATCHES the oracle (verify_asm PASS, 216 insns). */
int iSNDplaytaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, struct SNDPLAYOPTS *tag)
{
    union SndTimbreBufferView bt;                /* built timbre    @sp+0x20  */
    union SndTimbreBufferView hdr;               /* override header @sp+0xB8  */
    int           started[12];             /* started voices  @sp+0x150 */
    unsigned char *cursor;                 /* tag-stream cursor @sp+0x180 (&cursor -> gettag) */
    unsigned int  g0;                      /* gettag out: tag id  @sp+0x184 (3 SCALARS, not an array */
    int           g1;                      /*             value 1 @sp+0x188  -- an array would land   */
    unsigned char *g2;                     /*             data address @sp+0x18C  BELOW cursor, +8 frame)  */
    unsigned char *timbreData = 0;         /* s5: last 0xfd sample-data ptr */
    int           ret        = -9;         /* s4: launch result / return value */
    int           nStarted   = 0;          /* s2 */
    SndChannel   *slot       = 0;          /* s3: last written voice slot (shared single/multi) */
    int           pitchOff   = 0;          /* s6: the CAPTURED randrange() of the last 0x24 tag */
    int           vel, note;               /* s0 / s1 (lb: signed; vel FIRST -> vel=s0/note=s1) */
    int           key;                     /* fp: the CAPTURED iSNDfindfreekey() return */
    int           id, val;                 /* a1 / a2 one-shot copies of g0/g1 */
    int           i, ch;                   /* ch: getchan result, BOTH branches (a0, never crosses a call) */

    if (!bank)
        return -8;
    note = (signed char)tag->keynum;
    vel  = (signed char)tag->velocity;
    cursor = (unsigned char *)bank;        /* stored (addressable) then overwritten -- both sw in oracle */
    cursor = (bank->flags & 2) ? &((struct SndTaggedPatchStream8PrefixView *)bank)->first_tag_byte : &((struct SndTaggedPatchStream4PrefixView *)bank)->first_tag_byte;

    iSNDresetpatch(&bt.fields);
    iSNDresettimbre(&bt.fields, &hdr.fields);
    iSNDenteraudio();
    key = iSNDfindfreekey();

    for (;;) {
        if (!(iSNDgettag(&cursor, &g0, &g1, &g2)))
            break;
        id = g0;                           /* ONE lw; kept in a1 for all the tag tests */
        if (id == 0xfd) {                  /* after a 0xfd tag the cursor IS the sample data */
            timbreData = cursor;
            continue;
        }
        if (id == 0xfe) {                  /* note-region complete -> launch if in range */
            if (bt.fields.velocity_min.word <= vel && vel <= bt.fields.velocity_max.word && bt.fields.note_min.word <= note && note <= bt.fields.note_max.word) {
                ret = iSNDplaytaggedtimbre(timbreData, tag, &bt.fields, &hdr.fields, note, vel, pitchOff);
                if (ret < 0)
                    goto fail;
                started[nStarted] = ret;
                nStarted++;
            }
            iSNDresettimbre(&bt.fields, &hdr.fields);
            continue;
        }
        if (id < 0x26) {                   /* field tag -> set timbre[idx] + parallel header[idx] */
            val = g1;
            bt.tag_words[id]  = val;
            hdr.tag_data[id] = g2;
            if (id == 0x24)
                pitchOff = randrange(val); /* s6: fed to every later launch as arg 7 */
        }
    }
    /* the final note-region (no trailing 0xfe) */
    if (bt.fields.velocity_min.word <= vel && vel <= bt.fields.velocity_max.word && bt.fields.note_min.word <= note && note <= bt.fields.note_max.word) {
        ret = iSNDplaytaggedtimbre(timbreData, tag, &bt.fields, &hdr.fields, note, vel, pitchOff);
        if (ret < 0)
            goto fail;
        started[nStarted] = ret;
        nStarted++;
    }

    if (!nStarted)
        goto fail;                         /* nothing started: leaveaudio + return ret (-9 or the fail) */
    if (nStarted == 1) {                   /* single voice: no key group */
        ch = iSNDgetchan(started[0]);
        if (ch > -1) {
            SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
            slot = &pool[ch];
            slot->group_id = 0;
            slot->playback_fx.playback.group_flag = 0;
        }
    } else {                               /* join the started voices into the key group */
        for (i = 0; i < nStarted; i++) {
            struct SndGlobalServerStateView *gs = (struct SndGlobalServerStateView *)sndgs; /* in-body: loop-invariant-HOISTED after the entry blez,
                                                                                             * into a callee-saved reg (held ACROSS the getchan calls) */
            ch = iSNDgetchan(started[i]);
            if (ch > -1) {
                slot = &(gs->play_records)[ch];
                slot->group_id = (unsigned char)key;
                slot->playback_fx.playback.group_flag = 0;
            }
        }
        slot->playback_fx.playback.group_flag = 1; /* mark the last voice as the group end */
    }
    iSNDleaveaudio();
    return ret;

fail:
    iSNDleaveaudio();
    for (i = 0; i < nStarted; i++)         /* roll back every voice started before the failure */
        SNDstop(started[i]);
    return ret;
}

/* iSNDresolvetaggedpatch @0x801024EC : walk a bank's tag stream and resolve its SPU sample data (tag 0xfd
 *   = platform resolve), marking the bank resolved (+3 |= 1).  Returns -1 / resolve result. */
int iSNDresolvetaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, unsigned char *bankData, struct SNDResolveEntry *scratch)
{
    struct SndTagScanState state;
    int r = -1;
    state.cursor = (unsigned char *)bank;
    if (bank->flags & 2)
        state.cursor = &((struct SndTaggedPatchStream8PrefixView *)bank)->first_tag_byte;
    else
        state.cursor = &((struct SndTaggedPatchStream4PrefixView *)bank)->first_tag_byte;
    while (iSNDgettag(&state.cursor, &state.id, &state.value, &state.data)) {
        if (state.id == 0xfd)
            r = iSNDplatformresolve(state.cursor, bankData, scratch);
    }
    if (r > -1)
        bank->flags = bank->flags | 1;
    return r;
}

/* iSNDremovetaggedpatch @0x801025C0 : walk a bank's tag stream and release its resolved SPU data (tag 0xfd
 *   = platform remove), clearing the resolved flag (+3 &= ~1). */
int iSNDremovetaggedpatch(struct SndTaggedPatchRecordPrefixView *bank, struct SNDRemoveEntry *patch)
{
    struct SndTagScanState state;
    state.cursor = (unsigned char *)bank;
    if (bank->flags & 2)
        state.cursor = &((struct SndTaggedPatchStream8PrefixView *)bank)->first_tag_byte;
    else
        state.cursor = &((struct SndTaggedPatchStream4PrefixView *)bank)->first_tag_byte;
    while (iSNDgettag(&state.cursor, &state.id, &state.value, &state.data)) {
        if (state.id == 0xfd)
            iSNDplatformremove(state.cursor, patch);
    }
    bank->flags = bank->flags & 0xfe;
    return 0;
}

