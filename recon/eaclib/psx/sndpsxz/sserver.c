/* eaclib/psx/sndpsxz/sserver.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\sserver.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x800EA138 .. 0x800EA620].  The sound-system tick server: catches the audio clock up to real
 *   time (iSNDserver), runs one 100 Hz tick (iSND100hzserver: per-voice pitch/vol envelopes + portamento +
 *   pitch sweeps), the audio re-entrancy lock (iSNDenteraudio/leaveaudio) and the 100 Hz client list.
 *   Ghidra nfs4-f.exe.c (sserver) + IDA sigs.
 *
 *   Shared `sndgs` server state is overlaid by `SndGlobalServerStateView` in `sndserverpriv.h`;
 *   named fields include the lock/re-entry state, tick counters, callback tables, channel count and pool.
 *   `SndServer100HzClientCursorView` retains the codegen-matched displacement while the callback list is walked.
 *   Channel slot uses the private `SndChannel` layout (size `0x64`): owner/state at `+0x00/+0x0B`,
 *   autovol ramp at `+0x14..+0x1F`, portamento/sweep state at `+0x20..+0x2B`, cached volume/sweep bytes
 *   at `+0x2D..+0x31`, phases at `+0x39..+0x3B`, sweep-table pointer at `+0x40`, and pitch/cache fields
 *   at `+0x5E..+0x63`.
 */
#include "sclcptch.h"
#include "sdata.h"
#include "sndchpriv.h"
#include "sdfx.h"
#include "sdriver.h"
#include "slib.h"
#include "snd_state.h"
#include "sndserverpriv.h"
#include "sserver.h"
#include "sstop.h"

extern int timerhz[]; /* hardware tick rate */

/* iSNDserver @0x800EA138 : advance the audio clock, running the server callback until the audio tick
 * catches up with real_ticks * 100 / timerhz; defer one request while the audio lock is held.
 *
 * Exact-match constraints retained with the shared `SndGlobalServerStateView`:
 * - No C zero-divisor guard: the retail sequence is the unchecked divide followed by its hand-written
 *   break path; a trap() call adds a call/setup that is absent from the target.
 * - `p`, `g`, and volatile `q` are intentionally distinct. The entry guard uses `p`, the rotated callback
 *   loop carries `g` across the indirect call, and the final volatile member store uses `q`; collapsing
 *   these pointers changes register allocation / loop rotation.
 * - `tick_count`, `real_ticks`, the deferred-request halfword, and `in_server` retain the observed volatile
 *   accesses. The real-tick counter is re-read after its increment before computing the target.
 * - `timerhz` remains an unsized array: its address is shared between the compare load and halfword
 *   reload. The callback loop is an entry-guarded do/while to retain retail's rotated branch layout.
 * - The trailing clear still materializes `q` as a volatile pointer; casting that pointer to a volatile
 *   `SndGlobalServerStateView` names the flag without changing the matched address-generation sequence.
 * Verified byte-for-byte: 71 instructions. */
void iSNDserver(void)
{
    struct SndGlobalServerStateView *p;
    struct SndGlobalServerStateView *g;
    unsigned int target;

    p = (struct SndGlobalServerStateView *)sndgs;
    if (!p->in_server) {           /* not already inside the server */
        if (p->audio_lock_depth) {       /* audio locked -- defer */
            p->deferred_requests.s = p->deferred_requests.s + 1;   /* run it later, on leaveaudio */
            return;
        }
        p->in_server = 1;
        if (timerhz[0] != (((int)(p->timer_hz_cache.u) << 16) >> 16)) {
            p->timer_hz_cache.s = (short)timerhz[0];
            *(volatile int *)&p->tick_count = 0;
            *(volatile int *)&p->real_ticks = 0;
        }
        *(volatile int *)&p->real_ticks = *(volatile int *)&p->real_ticks + 1;
        target = *(volatile int *)&p->real_ticks * 100 / (unsigned int)timerhz[0];
        if (p->tick_count <= target) {
            g = p;
            do {
                g->server_callback();
            } while (g->tick_count <= target);
        }
        { volatile char *q = (volatile char *)sndgs; ((volatile struct SndGlobalServerStateView *)q)->in_server = 0; }
    }
}
/* iSND100hzserver @0x800EA254 : one 100 Hz tick -- bump the audio clock, run the stream/serve pump and the
 *   registered 100 Hz clients, then for every held voice step its pitch LFO, the AUTO-VOLUME ramp and the
 *   VOLUME ENVELOPE, recomputing SPU pitch/volume (and stopping voices whose envelope runs out).
 *   FIELD SEMANTICS PROVEN by the NFS2-PC beta ancestor (Watcom debug names, byte-matched:
 *   C:/Temp/nfs2-clean/pc-beta/match/sserver.obj/iSND100hzserver.c -- same TU cmn/sserver.c):
 *   p[5]/p[6]/p[7] = autovol_step/autovol_target/current_volume (0x14/0x18/0x1C -- a volume ramp, NOT
 *   portamento); p[8]/p[9]/p[10] = envelope_step/envelope_volume/envelope_duration (0x20/0x24/0x28);
 *   +0x2d = mixed_volume (s8, the iSNDvol arg); +0x30/+0x31 = envelope_count/envelope_index;
 *   p[0x10] = SND_ENVELOPE_POINT{int duration; int volume;}[] (the stride-8 table; <<16 = 16.16 volume);
 *   the 100 Hz client array generalizes NFS2's discrete midiserver/speechserver/crowdserver/pathserver
 *   pointers; NFS4 dropped NFS2's malformed-envelope abortmessage and added the pitch-LFO block. */
void iSND100hzserver(void)
{
    int *g;
    int i;
    int chanIdx;
    struct SndGlobalServerStateView *channelBase;
    struct SndGlobalServerStateView *globalBase;
    SndChannel *p;
    int dirty;

    g = sndgs;
    *(volatile int *)&((struct SndGlobalServerStateView *)g)->tick_count = *(volatile int *)&((struct SndGlobalServerStateView *)g)->tick_count + 1;
    i = 0;
    iSNDserve();
    if (0 < ((struct SndGlobalServerStateView *)g)->client_100hz_count.s) { /* run the 100 Hz client callbacks */
        struct SndGlobalServerStateView *clientBase = (struct SndGlobalServerStateView *)(unsigned int)g;
        do {
            ((struct SndServer100HzClientCursorView *)g)->callback();
            g++;
            i++;
        } while (i < clientBase->client_100hz_count.s);
    }

    channelBase = (struct SndGlobalServerStateView *)(unsigned int)sndgs;
    i = 0;
    if (channelBase->channel_count) { /* over every channel */
        globalBase = channelBase;
        chanIdx = i;
        do {
            p = (SndChannel *)((unsigned char *)globalBase->play_records + chanIdx);
            if (p->state == 1 && -1 < (int)p->owner_tag) { /* held, valid tag */
                if (p->pitch_lfo_table) {                                 /* pitch LFO active */
                    unsigned char phase = p->pitch_lfo_phase + 1;
                    p->pitch_lfo_phase = phase;
                    if (p->lfo_phase_limit <= phase)
                        p->pitch_lfo_phase = 0;
                    p->linear_pitch_cache = 0;
                    iSNDcalcpitch(i);
                    iSNDplatformpitch(i, p->spu_pitch);
                }
                dirty = 0;
                if (p->velocity_curve) {                                 /* velocity envelope active */
                    unsigned char phase;
                    dirty = 1;
                    phase = p->velocity_phase + 1;
                    p->velocity_phase = phase;
                    if (p->velocity_phase_limit <= phase)
                        p->velocity_phase = 0;
                }
                {
                    /* MATCH (184/184): keep the step as direct field reads. GCC CSEs them into the
                     * oracle's step/sign register pair while retaining `position` as the add result. */
                    if (p->autovol_step) {                                   /* autovol ramp step */
                        int position;
                        dirty = 1;
                        position = p->autovol_position.word + p->autovol_step;
                        p->autovol_position.word = position;
                        if (p->autovol_step < 0) {
                            if (!(p->autovol_limit < position)) {
                                p->autovol_position.word = p->autovol_limit;
                                p->autovol_step = 0;
                            }
                        } else if (!(position < p->autovol_limit)) {
                            p->autovol_position.word = p->autovol_limit;
                            p->autovol_step = 0;
                        }
                        /* 🔴 2026-08-10 REAL BUG FIX (found by the real-ASPSX byte confirm):
                         * this negative-volume stop is INSIDE the ramp block -- retail's
                         * `beqz a0` skips PAST it when the step is 0 (word 10800015 vs our
                         * old 10800011), and the NFS2-PC ancestor agrees (current_volume<0
                         * check nested in `if (step != 0)`).  The old placement ran the
                         * check every tick.  verify_asm was BLIND to it (branch-target
                         * lenient by design) -- objdiff's 99.97% was flagging exactly this. */
                        if (p->autovol_position.word < 0) { SNDstop(p->owner_tag); goto next_chan; }
                    }
                }
                /* portamento done -> pitch sweep */
                if (p->portamento_step) { dirty = 1; p->portamento_position.word = p->portamento_position.word + p->portamento_step; }
                if (!p->sweep_countdown) {                                   /* advance to next sweep segment */
                    signed char index = p->sweep_index + 1;
                    p->sweep_index = index;
                    if (!(index < p->sweep_count)) {
                        SNDstop(p->owner_tag);
                        goto next_chan;
                    } else {
                        SndSweepSegment *table = &p->sweep_table[index];
                        p->sweep_countdown = table->duration;
                        if (p->sweep_countdown < 0)
                            p->sweep_countdown = 0x7fffffff;
                        p->portamento_step = (table->target_pitch * 0x10000 - p->portamento_position.word) / p->sweep_countdown;
                    }
                }
                p->sweep_countdown = p->sweep_countdown - 1;
                if (dirty) {
                    iSNDcalcvol(i);
                    if (-1 < (int)p->owner_tag)
                        iSNDvol(i, p->volume);
                }
            }
next_chan:
            chanIdx += sizeof(SndChannel);
            i++;
        } while (i < globalBase->channel_count);
    }
}

/* iSNDenteraudio @0x800EA534 : take the audio re-entrancy lock (mutex + depth++). */
void iSNDenteraudio(void)
{
    struct SndGlobalServerStateView *g;
    SNDI_mutexlock();
    g = (struct SndGlobalServerStateView *)sndgs;   /* materialize &sndgs (lui+addiu) AFTER the call so it lands in a caller-saved reg */
    g->audio_lock_depth = g->audio_lock_depth + 1;
}

/* iSNDleaveaudio @0x800EA56C : release the audio lock; at depth 0, flush any servers deferred while held. */
void iSNDleaveaudio(void)
{
    struct SndGlobalServerStateView *g = (struct SndGlobalServerStateView *)sndgs;      /* held across the call (oracle: callee-saved $s0) */
    ((volatile struct SndGlobalServerStateView *)g)->audio_lock_depth =
        ((volatile struct SndGlobalServerStateView *)g)->audio_lock_depth - 1;
    SNDI_mutexunlock();
    if (!((volatile struct SndGlobalServerStateView *)g)->audio_lock_depth) {
        while (((struct SndGlobalServerStateView *)g)->deferred_requests.u) {
            ((struct SndGlobalServerStateView *)g)->deferred_requests.u =
                ((struct SndGlobalServerStateView *)g)->deferred_requests.u - 1;
            iSNDserver();
        }
    }
}

/* iSNDserveradd100hzclient @0x800EA5F0 : register a 100 Hz tick callback `cb`; returns sndgs.
 *   The count uses its signed view for the array index and unsigned view for the increment-store.
 * MATCH: the named callback array in `SndGlobalServerStateView` emits the retail sll(count*4), addu,
 *   then `sw a0,0x4c(base)` displacement sequence. */
struct SndGlobalServerStateView *iSNDserveradd100hzclient(void (*cb)(void))
{
    /* Keep the raw count as the scaled index; do not fold the 0x13-slot prefix into it. The field
     * expression below is a true array member yet retains the retail +0x4c store displacement. */
    struct SndGlobalServerStateView *base = (struct SndGlobalServerStateView *)sndgs;
    base->client_100hz_callbacks[(signed char)base->client_100hz_count.s] = cb;
    base->client_100hz_count.u = base->client_100hz_count.u + 1;
    return (struct SndGlobalServerStateView *)sndgs;
}

/* iSNDserverremove100hzclient @0x800EA620 : unregister a 100 Hz callback, compacting the client list.
 *
 * MATCH (w49-a7, 3 -> PASS 43/43): the twin of ssysserv.c iSNDserverremoveclient, cracked by the same
 * single lever -- the w47 OPACITY/IDENTITY FENCE `__asm__("" : "=r"(target) : "0"(cb))` as the FIRST
 * statement, with the parameter back to an honest plain `int cb`.  `target`'s def is an asm_operands
 * (not a REG) so global.c `set_preference` never gives it the $a0 copy preference, and `cb` now dies
 * at the fence so it stops conflicting with the loop index -- `regs_someone_prefers[i]` loses $a0 and
 * the {i,base,cb} = {$a0,$a1,$a2} rotation lands; the `"0"` matching constraint makes reload emit
 * retail's `addu $a2,$a0,$zero` at insn 0 at zero cost.  The state base is a typed view; callback
 * slot displacements remain byte-based at the cursor boundary. Full mechanism + the -dg receipt is
 * on the twin in ssysserv.c. (Retires the w33/w34 `volatile`-param 3-diff floor on BOTH twins.) */
void iSNDserverremove100hzclient(void (*cb)(void))
{
    int i;
    int j;
    void (*target)(void);
    struct SndGlobalServerStateView *base;
    struct SndGlobalServerStateView *p;

    __asm__("" : "=r"(target) : "0"(cb));
    p = (struct SndGlobalServerStateView *)sndgs;
    if (p->client_100hz_count.s <= 0)
        return;
    i = 0;
    base = p;
findloop:
    if (((struct SndServer100HzClientCursorView *)((unsigned char *)base + i * 4))->callback == target) {
        ((struct SndGlobalServerStateView *)base)->client_100hz_count.u = ((struct SndGlobalServerStateView *)base)->client_100hz_count.u - 1;
        if (i < ((struct SndGlobalServerStateView *)base)->client_100hz_count.s) {
shiftloop:
            j = i * 4;
            i++;
            ((struct SndServer100HzClientCursorView *)((unsigned int)j + (unsigned int)base))->callback =
                ((struct SndServer100HzClientCursorView *)((unsigned char *)base + i * 4))->callback;
            if (i < ((struct SndGlobalServerStateView *)base)->client_100hz_count.s)
                goto shiftloop;
        }
        return;
    }
    i++;
    if (i < ((struct SndGlobalServerStateView *)base)->client_100hz_count.s)
        goto findloop;
}
