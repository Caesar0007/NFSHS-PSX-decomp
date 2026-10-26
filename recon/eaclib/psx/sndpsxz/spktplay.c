/* eaclib/psx/sndpsxz/spktplay.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/13 ***
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity; w26-a4 manual C89 port -- the automated
 *   dialect fixer did not converge on this TU). Pre-migration (.cpp/cc1plus) vs post-migration
 *   (.c/cc1) per-fn diff counts, verify_asm.py authoritative -- IDENTICAL, zero regressions:
 *     iSNDpacketplayoverhead=PASS(0)  SNDPKTPLAY_overhead=PASS(0)   SNDPKTPLAY_create=PASS(0)
 *     SNDPKTPLAY_start=PASS(0)          SNDPKTPLAY_submit=PASS(0)        SNDPKTPLAY_submitspace=PASS(0)
 *     SNDPKTPLAY_unsafeframesoutstanding=PASS(0)  SNDPKTPLAY_framesoutstanding=PASS(0)
 *     SNDPKTPLAY_purge=PASS(0, w34)                                          SNDPKTPLAY_stop=PASS(0)
 *     SNDPKTPLAY_destroy=PASS(0)      iSNDpacketget=PASS(0)         iSNDpacketfreeframes=PASS(0)
 *   13/13 PASS. Do NOT revert to .cpp without user decision.
 *   Source obj : nfs4\eaclib\psx\spktplay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   13 fns @[0x801028BC .. 0x80103424].  SNDPKTPLAY -- the packet player sst.obj feeds.  A ring of
 *   "frames" (each a list of per-channel sample-data pointers) is submitted, then drained by the platform
 *   audio layer; per-frame release/notify callbacks report consumption back up to the stream layer.
 *
 *   Dual-source: Ghidra `C:\Temp\claud\nfs4-f.exe.c` L166899..167407 + disasm-v3 L334627+ (authoritative;
 *   Ghidra mangled SNDPKTPLAY_start's unaligned copy AND swapped its hdr/arg3 param naming, and dropped
 *   the bodies of unsafeframesoutstanding/framesoutstanding and args of iSNDpacketget/freeframes).
 *
 *   ===== player ppp = sndpps[i] (@0x80148574, one slot) =====
 *     +0x00 voice id (-1 idle)   +0x04 submit sequence   +0x08(h) ring size (numFrames)
 *     +0x0A(h) read index   +0x0C(h) last-channel marker (0xffff)   +0x0E(h) outstanding frame count
 *     +0x10 bytes pending   +0x14 bytes consumed   +0x18 mem base   +0x1C release cb   +0x20 notify cb
 *     +0x24 rate word (unaligned copy)   +0x26(b) channels per frame   +0x28.. frame ring (0x18 each:
 *           +0=seq, +4=size, +8.. = up-to-channels sample pointers)
 *   ===== voice ch = sndgs[0x25] + note*sizeof(SndChannel) (the global channel pool slot) =====
 */

                /* @0x80148574 -- one-slot player pointer array */
/* W65-A6 DATA-MAT: `sndpps` is the one-slot player pointer table at .bss @0x80148574, size 4
 * (next symbol sndpp @0x80148578).  Keep its explicit C definition in `.bss` rather than a
 * tentative definition: with -G4, a `.comm` would be routed to `.sbss` and/or gp-relative, while
 * retail has no `%gp_rel(sndpps)` references.  The representation is now PacketPlayerHeader *[1];
 * this preserves the 4-byte slot and absolute addressing.  The table has one owner/consumer TU.
 * Receipts: scratchpad/w65a6/RECEIPTS.md */
#include "salloc.h"
#include "sclcptch.h"
#include "sdpacket.h"
#include "salloc.h"
#include "sclcptch.h"
#include "sdpacket.h"
#include "sdata.h"
#include "sndserverpriv.h"
#include "slib.h"
#include "snd_state.h"
#include "spktplay.h"
#include "sndchpriv.h"
#include "sndpacketpriv.h"
#include "sndattrpriv.h"
#include "sndfmtpriv.h"
#include "sstop.h"
#include "sserver.h"
#include "../../../shared/SNDPLAYOPTS.h"

struct PacketPlayerHeader;
struct PacketPlayerHeader *sndpps[1] __attribute__((section(".bss"))) = { 0 };
                  /* (signed char)sndgs[0xf]=init, sndgs[0x25]=channel pool base */
/* HEADER WISH: the oracle actually loads this global from D_80147900 (SNDPKTPLAY_start @0x80102C34,
 * iSNDplaytaggedtimbre @0x801020D8 -- same "rate * ch-field * ch-field, magic-const mult, dur"
 * idiom both places), NOT 0x80147840 as this decl previously claimed. Doesn't affect verify_asm
 * (relocations are name/addend-erased) but the address comment was wrong; not chased further this
 * pass -- flag for whoever materializes/cross-checks sndpsxz globals next. */
       /* @0x80147900 -- platform sample rate (pitch calc); UNSIZED: oracle loads it absolute (lui+lw), a sized [1] goes gp-rel */

/* ---- backends ---- */
/* H10: 9-arg per oracle call @0x80102C94 (a0..a3 + sp+16/20/24/28/32). sdpacket's def reads 8
 *   (volAngle,level,pitch,a6,fxlevel,hdr-ptr); a9=hdr+0xc is pushed-but-unused, matching the binary. */


/* The fixed player header, frame ring, sample format, patch attributes, play options and channel pool
 * now use their concrete layouts below; no byte-offset accessor macros are needed in this TU. */

/* forward decls (mutual) */
typedef struct PacketFrame {
    int sequence;
    int size;
    unsigned char *channel[4];
} PacketFrame;
typedef char PacketFrame_size_check[(sizeof(PacketFrame) == 0x18) ? 1 : -1];

/* Purge deliberately copies one frame in two movstrsi batches so `wrptr` is
 * referenced twice and receives the retail allocno. These are semantic views
 * of PacketFrame's first four and last two words, not opaque word arrays. */
typedef struct PacketFramePrefix {
    int sequence;
    int size;
    unsigned char *channel[2];
} PacketFramePrefix;

typedef struct PacketFrameTail {
    unsigned char *channel[2];
} PacketFrameTail;

/* Fixed 0x28-byte player header. The variable-length PacketFrame ring starts
 * immediately after it; its records are addressed separately by ring index. */
typedef struct PacketPlayerHeader {
    int voice_id;                         /* +0x00: active SND voice, -1 when idle */
    int submit_sequence;                  /* +0x04 */
    unsigned short ring_size;             /* +0x08 */
    unsigned short read_index;             /* +0x0A */
    short last_channel;                    /* +0x0C: -1 means no channel completed */
    unsigned short outstanding_frames;     /* +0x0E */
    int pending_bytes;                    /* +0x10 */
    int consumed_bytes;                   /* +0x14 */
    unsigned char *mem_base;              /* +0x18: original byte-addressed player allocation base */
    void (*release_cb)(unsigned char *);    /* +0x1C */
    void (*notify_cb)(int, unsigned int);  /* +0x20 */
    SNDSAMPLEFORMAT rate;                 /* +0x24..+0x27 */
} PacketPlayerHeader;
typedef char PacketPlayerHeader_size_check[(sizeof(PacketPlayerHeader) == 0x28) ? 1 : -1];
/* ====================================================================================== */

/* iSNDpacketplayoverhead @0x801028BC : fixed PacketPlayerHeader + one sentinel PacketFrame + `n` ring frames. */
int iSNDpacketplayoverhead(int n)
{
    return n * sizeof(PacketFrame) + sizeof(PacketPlayerHeader) +
           sizeof(PacketFrame);
}

/* SNDPKTPLAY_overhead @0x801028D0 : total player overhead (bookkeeping + platform). */
int SNDPKTPLAY_overhead(int n)
{
    int a = iSNDpacketplayoverhead(n);
    return a + iSNDplatformpacketoverhead();
}

/* SNDPKTPLAY_create @0x801028FC : claim a player slot in `mem`, size its frame ring, store the callbacks.
 *   Returns the slot index, or a negative error.
 *   MATCH (oracle-traced, real bug fixes vs the earlier flat-if reconstruction):
 *   (1) `sndpps` is a genuine ONE-SLOT array (SYM confirms only 4 bytes between sndpps@0x80148574 and
 *       the next symbol sndpp@0x80148578) reached via a real `for(slot=0;slot<1;slot++)` loop the
 *       compiler did NOT unroll (`slot<1` folds to a `blez` test) -- not a scalar `if`. The loop
 *       rematerializes `&sndpps` into a walking pointer and computes `slot*4` in the found-branch's
 *       delay slot (used later as the store index), matching lever #1 (index-loop, not a hand-flattened
 *       `if`).
 *   (2) `iSNDplatformpacketoverhead()` is called TWICE with its return values genuinely CONSUMED --
 *       first call's return offsets `mem` into `ppp` (`mem += overhead()`), second call's return is
 *       subtracted from `memsize` for the ring-size divide. `off` (iSNDplatformpacketplaycreate's
 *       return) is used ONLY for the `<0` error check and never reused -- the earlier "off reused for
 *       both offset and ring-size, overhead()'s results discarded" reconstruction was a genuine bug.
 *   (3) `mem` is DEAD after the offset add (lever #14 in-place mutate): reassigned in place to become
 *       `ppp` and used directly for every subsequent field store; the pre-offset value is saved to
 *       `savedmem` as `void *` (oracle's `$s0`) before the reassignment for the +0x18 `mem_base` store. */
int SNDPKTPLAY_create(unsigned char *mem, int memsize, void (*relcb)(unsigned char *),
                      void (*notifycb)(int, unsigned int))
{
    int slot, off;
    unsigned char *savedmem;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    for (slot = 0; slot < 1; slot++) {
        if (!sndpps[slot])
            goto found;
    }
    return -9;
found:
    off = iSNDplatformpacketplaycreate(slot, (SndPacketPlayerContextPrefix *)mem);
    if (off < 0) {
        do { } while (0);
        return -6;
    }
    savedmem = mem;
    mem = (unsigned char *)mem + iSNDplatformpacketoverhead();
    memsize = memsize - iSNDplatformpacketoverhead();
    sndpps[slot] = mem;
    ((PacketPlayerHeader *)mem)->mem_base = savedmem; /* original player-allocation base */
    ((PacketPlayerHeader *)mem)->release_cb = relcb;    /* puVar4[7] */
    ((PacketPlayerHeader *)mem)->notify_cb = notifycb;  /* puVar4[8] */
    ((volatile PacketPlayerHeader *)mem)->ring_size =
        (unsigned short)(((unsigned)(memsize - sizeof(PacketPlayerHeader) - sizeof(PacketFrame))) /
                       sizeof(PacketFrame)); /* frames after fixed header + sentinel frame */
    ((volatile PacketPlayerHeader *)mem)->voice_id = -1;
    return slot;
}
/* Exact match (69 instructions). The slot scan, overhead-call order, and in-place `mem` reassignment
 * remain as required by the oracle. Player bookkeeping, callbacks, ring size, and idle voice id now
 * use the named PacketPlayerHeader fields. */

/* SNDPKTPLAY_start @0x80102A10 : begin playing a stream on player `p`.  Allocates a hardware voice, copies
 *   the format/rate into the voice, fills the ~50-field voice descriptor (sources per the disasm -- NOTE
 *   Ghidra's hdr/arg3 param naming is swapped), computes the playback pitch/duration, and hands off to the
 *   platform.  Returns the voice id, or a negative error.
 *   Args (per the caller, sst): rate points to the locked 4-byte sample-format value, hdr points to the
 *   decoded 0x14-byte `SndPatchAttributes` record, and params points to `SndStream.start_params`
 *   (`struct SNDPLAYOPTS`, size 0x14). Player, rate, attributes, play options and channel use
 *   PacketPlayerHeader, SNDSAMPLEFORMAT, SndPatchAttributes, SNDPLAYOPTS and private SndChannel layouts. */
int SNDPKTPLAY_start(int p, SNDSAMPLEFORMAT *rate, struct SndPatchAttributes *hdr,
                     struct SNDPLAYOPTS *params)
{
    PacketPlayerHeader *ppp;
    int note, allocOut, r;
    SndChannel *ch;
    int rateb2;
    struct SndGlobalServerStateView *gsp;         /* &sndgs, held in a callee-saved reg across
                                                    * enteraudio/allocchan: the enable guard and the
                                                    * 0x25 pool-base lookup share the SAME
                                                    * materialized state pointer in the oracle ($s3). */
    int gp;                                       /* the packet-play length (oracle redefines the
                                                    * very register that held the sndgs base right
                                                    * after `lw v1,0x94(s3)`). */
    /* MATCH (W85-S8, 2026-09-02): the two ROLES are TWO SOURCE VARIABLES, not one.
     * Retail reuses ONE hard register ($s3) for both, and this file used to model that with one
     * `int gp` -- which is what forced the two `__asm__("" : : "r"(note))` USE FENCES (w50-a8):
     * a single 2-role `gp` collects the refs of BOTH roles, and with the 3-statement in-place
     * length arithmetic below that is 10 REG_N_REFS.  Measured on the -dl dump of the one-var
     * form (gcc-2.8 priority = floor_log2(refs)*refs/live_length):
     *     gp   (p91) 10 refs / 108 insns -> 3*10/108 = .2778
     *     note (p85)  9 refs / 110 insns -> 3* 9/110 = .2454     -> gp allocated first
     * so gp took $s2 and note $s3, the exact inverse of retail (38 diffs, count-EXACT 187/187).
     * The fences bought note 9->11 refs (3*11/110 = .300 > .2778) at zero instructions; dropping
     * gp to the 2-statement form instead bought 10->8 refs (.222) but cost the oracle's in-place
     * `sll s3,s3,8 / andi s3,s3,0xffff` (4 diffs) -- at -O2 `flag_expensive_optimizations` makes
     * `preserve_subexpressions_p()` true, so expand_expr NEVER reuses the assignment target as a
     * subexpression temp; the in-place shape is structurally tied to one-op-per-statement.
     * SPLITTING the variable dissolves the whole trade: each role keeps its own REG_N_REFS /
     * live_length, the length allocno stops out-ranking `note`, and both fences become
     * unnecessary.  PASS 187/187 with ZERO devices.  (Register-level fidelity is unchanged:
     * gcc still hands both roles $s3 -- the source-level split is invisible in the output.) */
    gsp = (struct SndGlobalServerStateView *)sndgs;
    if (!gsp->initialized)
        return -10;
    rateb2 = rate->channels;                         /* MATCH: evaluated before the ppp lookup/
                                                    * enteraudio -- oracle hoists this arg early */
    ppp = sndpps[p];
    iSNDenteraudio();
    note = iSNDallocchan(hdr->attributes.patch_id, rateb2, (signed char)hdr->attributes.velocity, &allocOut);
    if (note < 0) {
        iSNDleaveaudio();
        return -9;
    }

    /* MATCH (w32-a8, 132 -> 114 diffs AND insn count 185 -> EXACT 187): the whole ring HEADER is
     * volatile -- these are async-touched player-slot fields, so the ordered member stores preserve
     * the oracle's schedule just as the volatile header reads in SNDPKTPLAY_stop do.  With plain stores gcc's scheduler hoists the
     * `li -1` + `sh 0xc` marker to the top of the block (stealing the `bgez` delay slot on the way)
     * and sinks `sw allocOut,0(ppp)` to the bottom; the oracle keeps the written order and leaves
     * that delay slot unfilled.  Making ONLY the first or only the two end stores volatile is not
     * enough (132 / 119) -- the run has to be ordered as a whole. */
    ((volatile PacketPlayerHeader *)ppp)->voice_id = allocOut;
    ((volatile PacketPlayerHeader *)ppp)->read_index = 0;
    ((volatile PacketPlayerHeader *)ppp)->outstanding_frames = 0;
    ((volatile PacketPlayerHeader *)ppp)->pending_bytes = 0;
    ((volatile PacketPlayerHeader *)ppp)->submit_sequence = 0;
    ((volatile PacketPlayerHeader *)ppp)->consumed_bytes = 0;
    ((volatile PacketPlayerHeader *)ppp)->last_channel = (short)0xffff;
    ppp->rate = *rate; /* unaligned rate-word copy */
    ch = &gsp->play_records[note]; /* Direct channel-array index; retains the delayed pool-base
                                     * load and note*100 schedule exactly (187/187). */

    if ((signed char)params->use3dpos != 0)
        gp = params->azimuth;
    else {
        /* TWO statements, not one and not three.  `gp` is the retail two-role variable (&sndgs,
         * then the packet length) and its REG_N_REFS decides whether it wins the oracle's $s3:
         *   1 stmt  `gp = ((MSB(params,7)-0x40)<<8)&0xffff;`  ->  6 refs, prio 12/97=.124 < params'
         *           30/224=.134  ->  gp lands $s4, params $s3 (the old 100-diff swap);
         *   2 stmts (this)                                    ->  8 refs, 24/98=.245 -> gp $s3 OK;
         *   3 stmts (the oracle's own in-place addiu/sll/andi chain) -> 10 refs, 30/99=.303, which
         *           outranks `note`/`ppp` and takes $s1 (120 diffs).
         * So we spell the subtraction in place (matching the oracle's `addiu s3,v0,-0x40`) and fuse
         * the shift+mask, leaving a 2-insn `sll v0,s3,8 / andi s3,v0,0xffff` vs the oracle's in-place
         * `sll s3,s3,8 / andi s3,s3,0xffff` -- the price of staying at 8 refs.
         * W47-a3 (2026-08-03) re-measured in the current basin, both REVERTED:
         *   - 3 statements (`gp = gp << 8; gp = gp & 0xffff;`): 60 diffs (the w35 note's 10-ref
         *     prediction confirmed -- s1/s2/s3 rotate through the whole fn).
         *   - mask-then-shift `gp = (gp & 0xff) << 8;` (algebraically identical, same ref count):
         *     4 diffs, different shape (`andi v0,s3,255 / sll s3,v0,8`) -- the temp just moves to
         *     the other operand.  NEW NAMED ANGLE: the in-place `sll s3,s3,8` REQUIRES an RTL
         *     `(set gp (ashift gp 8))`, which expand_expr only produces when the assignment target
         *     IS the shift's own operand and is its own statement (safe_from_p refuses the target
         *     as a subexpression temp).  So the shape is structurally tied to the 3-statement form
         *     and the fix must come from the OTHER side: a zero-insn ref DELETER on `gp` (w45
         *     store-read-back family) or a zero-insn ref INFLATOR on its rivals (`note`/`ppp`) to
         *     restore the 8-ref ranking with 10 real refs.  Not attempted -- both need reqdelta. */
        gp = (signed char)params->pan - 0x40;
        gp = gp << 8;                 /* MATCH: THREE statements, in place -- see the w50-a8
                                       * receipt at the fn tail; the 3-statement form is the
                                       * only one that emits retail's in-place shift/mask, and
                                       * its +2 gp refs are paid for by the ppp/note inflators. */
        gp &= 0xffff;
    }

    ch->start_marker  = -1;              /* li -1 (signed char), not li 255 */
    ch->base_detune = hdr->attributes.base_detune;
    ch->base_pitch = params->pitchmult;
    ch->autovol_step  = 0;
    ch->autovol_position.word  = (signed char)params->vol << 0x10;
    ch->portamento_step  = 0;
    ch->sweep_countdown  = 0x7fffffff;
    ch->portamento_position.word  = 0x7f0000;
    ch->patch_volume  = hdr->attributes.patch_volume;
    ch->pan  = hdr->attributes.pan;
    ch->bend  = (unsigned char)params->bend;   /* H09: src was hdr (oracle 0x80102B90 *(u8)(9+$s4=params)) */
    ch->sweep_count  = 1;
    ch->sweep_index  = 0;
    ch->control32  = 0;
    ch->pan_scale  = 1;
    ch->playback_fx.playback.playback_factor34  = hdr->attributes.playback_factor34;      /* H09: src was params (oracle 0x80102BAC *(u8)(9+$s5=hdr)) */
    ch->playback_fx.playback.playback_factor35  = (unsigned char)params->fxlevel0;  /* H09: src was hdr (oracle 0x80102BB8 *(u8)(10+$s4=params)) */
    ch->envelope_detune_depth  = (short)((signed char)hdr->attributes.envelope_detune * 100);
    ch->group_id  = 0;
    ch->playback_fx.playback.group_flag  = 0;
    /* MATCH: 0x40/0x44 zeros BEFORE the 0x3d store, 0x48/0x4c/0x50/0x54 AFTER -- oracle interleaves
     * `a0=note` (calcpitch's arg) between MB(params,7) and the first zero pair. */
    ch->current_pan  = (unsigned char)params->pan;   /* H09: src was hdr (oracle 0x80102BE8 *(u8)(7+$s4=params)) */
    ch->sweep_table  = 0;
    ch->final_volume_curve  = 0;
    ch->pan_curve  = 0;
    ch->detune_curve  = 0;
    ch->velocity_curve  = 0;
    ch->pitch_lfo_table  = 0;

    ch->linear_pitch_cache  = 0;               /* MATCH: independent store -- oracle schedules it into the
                                       * calcpitch jal's delay slot */
    iSNDcalcpitch(note);
    iSNDcalcvol(note);

    /* pitch -> playback duration: rate * playback_factor34 * playback_factor35, divided by a fixed
     * constant. PC twin (nfs4-sound SNDPKTPLAY_start): ONE accumulator reassigned across two statements. */
    /* H10: oracle (0x80102C94) passes 9 args; was 6 with dur/rate/hdr+0xc in the wrong slots and
       channel volume/pitch plus params[0xe] missing. a0..a3 + sp+16/20/24/28/32. */
    r = iSNDplatformpacketplay(p, note, gp, ch->volume, ch->spu_pitch,
                               params->timemult,
                               sndgs_fx_bus0_master[0] * ch->playback_fx.playback.playback_factor34 * ch->playback_fx.playback.playback_factor35 / 0x3f01,
                               rate, (int)hdr + 0xc);
    if (r < 0) {
        iSNDfreechan(note);
        iSNDleaveaudio();
        return r;
    }
    iSNDleaveaudio();
    return ppp->voice_id;
}
/* Exact match (187 instructions). Player header, sample format, patch attributes, play options and channel
 * descriptor use PacketPlayerHeader, SNDSAMPLEFORMAT, SndPatchAttributes, SNDPLAYOPTS and SndChannel members. */

/* SNDPKTPLAY_submit @0x80102CFC : append a frame (descriptor `frame`) to the player's ring.  Returns the
 *   submit sequence number, or -0xD if the ring is full. */
/* MATCH (w50-a8 2026-08-09): SNDPKTPLAY_submit is PASS 93/93.  The 2-diff residual below (the
 * oracle emits `addu v1,zero,zero` (j = 0) into the `beqz channels` delay slot, ours emitted
 * `addu a1,s1,zero` (src = frame)) is CRACKED by a TWO-DIAL composition, neither half of which
 * works alone -- this retires the w49-a8 'floor RE-CONFIRMED' verdict kept below:
 *   (1) EMISSION ORDER: `j = 0;` written FIRST, so reorg's eager steal takes IT out of the
 *       fall-through block's head (that alone = 12 diffs -- it also swaps j/src's colours);
 *   (2) REF INFLATION on `j` (the w44 do{}while(0) depth wrapper on the init) to UNDO that
 *       colour swap.  MECHANISM (allocno_compare): src and j are GLOBAL allocnos with equal
 *       refs; whoever is BORN FIRST has the longer live range, hence the LOWER priority, hence
 *       is allocated SECOND and takes the higher-numbered free reg ($a1=5 vs $v1=3).  Writing
 *       `j = 0;` first therefore hands j $a1 -- wrong.  One extra ref on j crosses the
 *       floor_log2 step (3->4 refs: prio 3 -> 8) so j out-ranks src DESPITE being born first,
 *       and the whole loop re-colours to retail's j=$v1 / src=$a1.
 *   The wrapper must sit on the INIT, not on the in-loop `j++`: a wrapper inside the loop is a
 *   sched2 barrier that pins `addiu v1,v1,1` after the `sw` (measured: in-loop wrapper = 2 diffs,
 *   the SAME count, different insn).  Depth 2 also passes; depth 1 kept.  An equivalent PASS with
 *   an extra value temp + in-loop wrapper was also found and rejected as heavier.
 *   Falsified this wave (all 93/93): de-coupling decl order from assignment order (`int src, j;
 *   j = 0; src = frame;` = 12 -- the colour is welded to EMISSION order, not decl order, which
 *   corrects the w47-a3 'welded to first-use order' wording); hoisting j's init above the
 *   `if (channels)` guard (12); a use fence on `frame` before the guard (2, inert); a use fence
 *   on `src` at the block head (12); block-local value temps to cross the 3-qty boundary (they
 *   are optimised away, so no qty is created: 12/2 unchanged).
 * ---- historical (w28-31 .. w49-a8) ----
 * NEAR-MISS 2 diffs (93/93): the oracle emits `addu v1,zero,zero` (j = 0) BEFORE `addu a1,s1,zero`
 * (src = frame) in the channel-pointer loop's preheader; ours emits them the other way round.
 * 🔴 w49-a8 2026-08-08 -- floor RE-CONFIRMED with a NEW evidence class (the w45/w47 fence family,
 * which the w28-31 note predates).  The catalog's mechanism holds exactly: gcc-2.8 pseudo
 * numbering couples EVAL ORDER to both register colour and delay-slot-fill priority, so writing
 * the oracle's emission order in source makes it WORSE, and a barrier cannot decouple them --
 *   `int j = 0, src = frame;` 12 | split decls, j first 12 | split decls, src first 2 (== kept)
 *   | void fence before the loop 2 | void fence BETWEEN the two inits 12 | fence after src 2
 *   | opacity fence on j 2   (all 93/93).
 * i.e. every form that puts j's evaluation first pays 12, and no fence position buys the order
 * without the colour.  Do not re-run the order sweep. */
int SNDPKTPLAY_submit(int p, union SndPacketSubmitFrameView *frame)
{
    PacketPlayerHeader *ppp;
    unsigned char *slot;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    ppp = sndpps[p];
    iSNDenteraudio();
    if ((((int)(((volatile PacketPlayerHeader *)ppp)->outstanding_frames) << 16) >> 16) < (((int)(((volatile PacketPlayerHeader *)ppp)->ring_size) << 16) >> 16) - 1)                    /* MATCH: positive (room-available) test
                                                             * branches AWAY to `room`; the FALLTHROUGH
                                                             * is the error path with its own explicit
                                                             * jump to `leave` -- oracle's exact
                                                             * `slt;bnez room / [fallthrough] j leave`
                                                             * shape, not an if/else. */
        goto room;
    frame = (union SndPacketSubmitFrameView *)(unsigned int)(-0xd);                                         /* MATCH: the oracle reuses `frame`'s OWN
                                                             * register ($s1) as the return-value
                                                             * carrier for the whole fn -- its ONLY
                                                             * use past this point is the dead-param
                                                             * reuse `addiu s1,zero,-0xD`, no separate
                                                             * `seq` pseudo. */
    goto leave;
room:
    {
        int idx = (((int)(((volatile PacketPlayerHeader *)ppp)->read_index) << 16) >> 16) + (((int)(((volatile PacketPlayerHeader *)ppp)->outstanding_frames) << 16) >> 16);            /* (read + count) wrapped */
        if ((((int)(((volatile PacketPlayerHeader *)ppp)->ring_size) << 16) >> 16) <= idx)
            idx -= (((int)(((volatile PacketPlayerHeader *)ppp)->ring_size) << 16) >> 16);
        slot = (unsigned char *)&((PacketFrame *)((unsigned char *)ppp + sizeof(PacketPlayerHeader)))[idx];
        ((PacketFrame *)slot)->size = frame->fields.data_size;                /* size */
        ((PacketFrame *)slot)->sequence = ppp->submit_sequence;                         /* sequence */
        if (ppp->rate.channels) {                         /* copy the per-channel pointers */
            int j;
            unsigned char *src;
            do { j = 0; } while (0);              /* MATCH: zero-insn REF INFLATOR on j (see
                                                     * the header receipt) -- j must be born
                                                     * FIRST for reorg's delay-slot steal AND
                                                     * still out-rank src in allocno_compare. */
            src = (unsigned char *)frame;
            do {                                          /* MATCH: walks `slot` itself in place
                                                             * (lever #14) -- `frame` stays intact
                                                             * (re-read below), `slot`/a0 is dead
                                                             * after the loop. */
                ((PacketFrame *)slot)->channel[0] = *(unsigned char **)(src + 0xc);
                src += 4;
                j++;
                slot += 4;
            } while (j < ppp->rate.channels);
        }
        ((volatile PacketPlayerHeader *)ppp)->outstanding_frames = ((volatile PacketPlayerHeader *)ppp)->outstanding_frames + 1;                /* count++ (plain lhu, no shift) */
        ((volatile PacketPlayerHeader *)ppp)->pending_bytes = ppp->pending_bytes + frame->fields.data_size;  /* bytes pending += size */
        frame = (union SndPacketSubmitFrameView *)(unsigned int)((volatile PacketPlayerHeader *)ppp)->submit_sequence;               /* MATCH: reuse `frame` (dead after the
                                                             * loop) as `seq` -- oracle's `lw s1,4(s0)`
                                                             * right here, same register as the param. */
        ppp->submit_sequence = ((volatile PacketPlayerHeader *)ppp)->submit_sequence + 1;      /* sequence++ */
    }
leave:
    iSNDleaveaudio();
    return (int)(unsigned int)frame;
}
/* Exact match (93 instructions). Preserve `frame` as the reused result carrier, the explicit goto
 * branch polarity, and the block-local channel-copy induction variables. The header table and local
 * player base are now PacketPlayerHeader pointers; `slot` is a byte pointer into the variable ring. */

/* SNDPKTPLAY_submitspace @0x80102E70 : free frame slots in the ring. */
int SNDPKTPLAY_submitspace(int p)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    {
        PacketPlayerHeader *base = sndpps[p];
        /* MATCH: volatile forces the oracle's lhu+sll16+sra16 shape -- a plain `(short)` load
         * collapses to a single `lh` (still correct, but byte-mismatched). */
        int a = ((int)(((volatile PacketPlayerHeader *)base)->ring_size) << 16) >> 16;
        int b = ((int)(((volatile PacketPlayerHeader *)base)->outstanding_frames) << 16) >> 16;
        return a - b - 1;
        /* The one-slot table already has type PacketPlayerHeader *; volatile member reads retain
         * the oracle's lhu+sll16+sra16 sign-extension sequence. */
    }
}

/* SNDPKTPLAY_unsafeframesoutstanding @0x80102EC4 : bytes still to be played (no critical section). */
int SNDPKTPLAY_unsafeframesoutstanding(int p)
{
    PacketPlayerHeader *ppp = sndpps[p];
    return ppp->pending_bytes + ppp->consumed_bytes;
}

/* SNDPKTPLAY_framesoutstanding @0x80102EEC : same, inside a critical section. */
int SNDPKTPLAY_framesoutstanding(int p)
{
    int r;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDenteraudio();
    r = SNDPKTPLAY_unsafeframesoutstanding(p);
    iSNDleaveaudio();
    return r;
}

/* SNDPKTPLAY_purge @0x80102F3C : drop every frame whose sequence falls within [lo, hi] from the ring,
 *   compacting the survivors down, firing the release callback for each removed frame.
 *   PASS (119/119) as of w34-a6 -- cracked with the gcc-2.8 ALLOCNO-PRIORITY model read straight off
 *   the cc1 `-dl`/`-dg` RTL dumps (priority = floor_log2(refs)*refs/live_length; allocation order IS
 *   the s-register rank).  The residual was a 3-way rotation of {wrptr,rd,wr} over s1/s2/s3:
 *     - dump (before): wr 7 refs/52 insns = .269, rd 7/54 = .259, wrptr 5/40 = .250
 *                      -> order wr(s1), rd(s2), wrptr(s3);  oracle wants wrptr(s1), rd(s2), wr(s3).
 *     - LEVER 1 (live-length): SWAP the two identical `lhu +0xa` reads back to `wr` FIRST -- the
 *       earlier-defined pseudo lives longer, giving wr 7/55 = .2545 < rd 7/51 = .2745, i.e. rd now
 *       outranks wr (the oracle's own read order: its FIRST `sra` lands in $s3 = wr).
 *     - LEVER 2 (ref count): SPLIT the 0x18-byte ring copy into the movstrsi 4-word + 2-word halves
 *       as TWO struct assignments.  Byte-identical codegen (a 24-byte movstrsi is emitted as exactly
 *       load-4/store-4 + load-2/store-2 anyway), but it gives `wrptr` a SECOND address reference ->
 *       6 refs/40 = .300, lifting it above rd and completing the rotation.
 *     - LEVER 3: statement order inside the wrap-reset block (`wrptr = ppp;` BEFORE `wr = 0;`) --
 *       the last 2 diffs.
 *   The earlier note that this was an "unmodelable retail allocno_compare delta" was WRONG: the
 *   delta was entirely explained by our own dump's refs/live-length numbers.  (Same instrument is
 *   worth re-running on sbdload/start, whose floors were filed with the same reasoning.)
 *   W31 findings that still hold: goto loop kills the strength-reduced store anchor; volatile
 *   16-bit member reads for wr/rd/total/ring size preserve async reloads; REMOVE ("lo<=fr0<=hi") is the branch-away/fallthrough arm
 *   and KEEP is the oracle's explicit two-`bnez`-to-the-same-label branch target. */
int SNDPKTPLAY_purge(int p, int lo, int hi)
{
    PacketPlayerHeader *ppp;
    int i, wr, rd, total, rdoff;
    unsigned char *wrptr;

    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    ppp = sndpps[p];
    i = 0;                                         /* MATCH: set before the ring reads -- oracle
                                                      * schedules this into iSNDenteraudio's jal
                                                      * delay slot (independent of the call), and
                                                      * this decl-order is what pins ppp/i/wr/rd/
                                                      * total/rdoff/wrptr onto the oracle's exact
                                                      * s0..s7/fp permutation (9 live-across-a-call
                                                      * locals -> every callee-saved reg is used). */
    iSNDenteraudio();
    wr    = (((int)(((volatile PacketPlayerHeader *)ppp)->read_index) << 16) >> 16);                          /* write (compaction) index -- READ FIRST: the
                                                      * earlier def gives `wr` the LONGER live range
                                                      * (55 vs rd's 51), which drops its allocno
                                                      * priority below `rd`'s.  Retail's weaker CSE
                                                      * keeps BOTH identical lhu's; their ASSIGNMENT
                                                      * ORDER is the live-length lever. */
    rd    = (((int)(((volatile PacketPlayerHeader *)ppp)->read_index) << 16) >> 16);                          /* read index (2nd identical volatile read) */
    total = (((int)(((volatile PacketPlayerHeader *)ppp)->outstanding_frames) << 16) >> 16);                          /* frames to scan            */
    if (total > 0) {
        rdoff = rd * sizeof(PacketFrame) + sizeof(PacketPlayerHeader);
        /* Keep `wrptr` a byte pointer.  The unsigned 32-bit base+offset intermediate preserves the
         * oracle's operand order; direct typed-pointer addition differed only by swapping the two
         * commutative `addu` operands (2 exact-ASM diffs). */
        wrptr = (unsigned char *)(wr * sizeof(PacketFrame) + (unsigned int)ppp);
        /* GOTO loop (W31, same finding as sbdload): a natural do/while gets loop notes and gcc
         * strength-reduces the 0x28..0x3C store addresses onto a REBASED anchor (wrptr+0x3C-held
         * base, negative displacements); the oracle keeps the raw wrptr/rdoff IVs and recomputes
         * src = ppp+rdoff each iteration.  No loop notes -> no SR -> source IVs survive. */
purge_next: {
            /* rdoff is a byte offset from the player header base; materialize the typed frame pointer
             * only after forming that machine-address sum. */
            PacketFrame *fr = (PacketFrame *)((unsigned int)ppp + rdoff);
            if (lo <= fr->sequence && fr->sequence <= hi) {      /* remove (branch-away, oracle fallthrough) */
                ((volatile PacketPlayerHeader *)ppp)->outstanding_frames = ((volatile PacketPlayerHeader *)ppp)->outstanding_frames - 1;  /* plain lhu, no shift (no compare) */
                ((volatile PacketPlayerHeader *)ppp)->pending_bytes = ppp->pending_bytes - fr->size;
                if (ppp->release_cb)
                    ppp->release_cb(fr->channel[0]);
            } else {                               /* keep -> move down (oracle branch target) */
                /* The 0x18-byte ring copy, written as the TWO movstrsi batches gcc would emit for a
                 * single 24-byte struct assignment anyway (load-4/store-4 then load-2/store-2 in
                 * $a3/$t0/$t1/$t2).  Codegen-identical to `*(PktCopy6*)(wrptr+0x28) = *(PktCopy6*)fr`
                 * -- but it references `wrptr` TWICE, which is the point: 5 -> 6 REG_N_REFS lifts
                 * wrptr's allocno priority (12/40 = .300) above rd's (14/51 = .2745) and pins it to
                 * the oracle's $s1.  Do NOT re-merge into one assignment (reverts to 32 diffs). */
                *(PacketFramePrefix *)(wrptr + sizeof(PacketPlayerHeader)) = *(PacketFramePrefix *)fr;
                *(PacketFrameTail *)(wrptr + sizeof(PacketPlayerHeader) + sizeof(PacketFramePrefix)) = *(PacketFrameTail *)((unsigned char *)fr + sizeof(PacketFramePrefix));
                wrptr += sizeof(PacketFrame);
                wr++;
                if ((((int)(((volatile PacketPlayerHeader *)ppp)->ring_size) << 16) >> 16) <= wr) {
wrptr = (unsigned char *)ppp;
                    wr = 0;
                }
            }
            rdoff += sizeof(PacketFrame);
            rd++;
            if ((((int)(((volatile PacketPlayerHeader *)ppp)->ring_size) << 16) >> 16) <= rd) {
                rdoff = sizeof(PacketPlayerHeader);
                rd = 0;
            }
            i++;
            if (i < total)
                goto purge_next;
        }
    }
    iSNDleaveaudio();
    return 0;
}
/* SNDPKTPLAY_stop @0x80103118 : stop the voice, purge the whole ring, and idle the player.
 * MATCH: the +0xc last-channel marker is read TWICE (guard + callback index) and the +0 voice id is re-set right
 * before iSNDleaveaudio -- the oracle genuinely RELOADS +0xc a second time (fresh `lhu`) and does NOT
 * sink the +0 store into iSNDleaveaudio's jal delay slot, both of which gcc's CSE/scheduler undo unless
 * the accesses are `volatile` (this player slot IS touched by async playback/IRQ, so the qualifier is
 * semantically correct, not just a match hack). */
int SNDPKTPLAY_stop(int p)
{
    PacketPlayerHeader *ppp;
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    ppp = sndpps[p];
    iSNDenteraudio();
    SNDstop(ppp->voice_id);
    SNDPKTPLAY_purge(p, 0, 0x7fffffff);
    if (ppp->release_cb &&
        -1 < (int)((unsigned)(unsigned short)((volatile PacketPlayerHeader *)ppp)->last_channel << 0x10)) {
        ppp->release_cb(((PacketFrame *)((unsigned char *)ppp + sizeof(PacketPlayerHeader)))
                        [((volatile PacketPlayerHeader *)ppp)->last_channel].channel[0]);
    }
    ((volatile PacketPlayerHeader *)ppp)->voice_id = -1;
    iSNDleaveaudio();
    return 0;
}

/* SNDPKTPLAY_destroy @0x801031F4 : release the player slot. */
int SNDPKTPLAY_destroy(int p)
{
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    iSNDplatformpacketplaydestroy(p);
    sndpps[p] = 0;
    return 0;
}

/* iSNDpacketget @0x80103248 : platform pull -- hand out the next sample pointer for channel `idx` of the
 *   head frame, advancing the ring (and firing the release callback) once the last channel is taken.
 *   Writes the frame size to *out.  Returns the channel's sample pointer (0 if none). */
unsigned char *iSNDpacketget(int p, int idx, int *out)
{
    PacketPlayerHeader *ppp = sndpps[p];
    short m;
    PacketFrame *fr;

    if (idx + 1 == ppp->rate.channels &&
        -1 < (int)((unsigned)((unsigned short)((volatile PacketPlayerHeader *)ppp)->last_channel) << 0x10)) {
        m = ((volatile PacketPlayerHeader *)ppp)->last_channel;
        ((volatile PacketPlayerHeader *)ppp)->last_channel = (short)0xffff;
        {
            void (*cb)(unsigned char *);
            /* MATCH: compute the completed PacketFrame address before fetching the callback
             * pointer.  The oracle schedules the +0x1c load late, after the independent index
             * arithmetic, and forms the final entry base in the branch delay slot. */
            fr = &((PacketFrame *)((unsigned char *)ppp + sizeof(PacketPlayerHeader)))[m];
            cb = ppp->release_cb;
            if (cb)
                cb(fr->channel[0]);
        }
    }
    if (!ppp->outstanding_frames)                           /* MATCH: direct `return 0` (oracle's v0=0
                                                        * lands in the beqz's delay slot -- the
                                                        * epilogue label IS the return), not a
                                                        * fall-through `fr=0`. */
        return 0;
    fr = &((PacketFrame *)((unsigned char *)ppp + sizeof(PacketPlayerHeader)))[(((int)(((volatile PacketPlayerHeader *)ppp)->read_index) << 16) >> 16)];
    *out = fr->size;
    if (idx + 1 == ppp->rate.channels) {
        ((volatile PacketPlayerHeader *)ppp)->last_channel = ((volatile PacketPlayerHeader *)ppp)->read_index;              /* MATCH: volatile -- two 0xa reads separated
                                                        * by the 0xe store must NOT be hoisted/CSE'd
                                                        * together (oracle keeps them apart). */
        ((volatile PacketPlayerHeader *)ppp)->outstanding_frames = ((volatile PacketPlayerHeader *)ppp)->outstanding_frames - 1;          /* MATCH: volatile -- forces this store to act
                                                        * as an ordering barrier so the SECOND 0xa
                                                        * read (below) doesn't float ahead of it. */
        ((volatile PacketPlayerHeader *)ppp)->read_index = ((volatile PacketPlayerHeader *)ppp)->read_index + 1;
        ppp->consumed_bytes = ppp->consumed_bytes + fr->size;
        ((volatile PacketPlayerHeader *)ppp)->pending_bytes = ppp->pending_bytes - fr->size;
        if (!(((int)((unsigned)((volatile PacketPlayerHeader *)ppp)->read_index) << 16) < ((int)((unsigned)((volatile PacketPlayerHeader *)ppp)->ring_size) << 16)))
            ((volatile PacketPlayerHeader *)ppp)->read_index = 0;
    }
    return fr->channel[idx];
}
/* Exact match: modeling each 0x18-byte ring entry as PacketFrame fixes both head-frame addressing
 * and the completed-frame callback argument.  Reusing `fr` for that callback is significant: it
 * retains the natural `m*0x18+0x28` entry base and loads channel[0] at +8, matching the oracle's
 * branch-delay scheduling.  Volatile stores to +0x10 and the wrapped +0x0a index preserve the
 * oracle's ordering and duplicate tail-index calculation. */

/* iSNDpacketfreeframes @0x801033C4 : platform notify -- once the last channel of a frame is consumed,
 *   credit `bytes` back and call the notify callback. */
void iSNDpacketfreeframes(int p, int idx, int bytes)
{
    PacketPlayerHeader *ppp = sndpps[p];
    unsigned int v = ppp->rate.channels;
    do {
        if (idx + 1 == v) {
            v = ppp->consumed_bytes - bytes;
            ((volatile PacketPlayerHeader *)ppp)->consumed_bytes = (int)v;   /* Volatile preserves the async-touched field store and its
                                                                                             * position before the callback guard. */
            if (ppp->notify_cb)
                ppp->notify_cb(p, bytes);
            /* The typed notify callback receives the original player index and consumed byte count. */
        }
        return;
    } while (0);
}

/* W66-A3 (link): the owning-TU definition once proposed for this interior field
 * was a latent defect, not a link harness: it would route to a local symbol and
 * place a private word where retail has none. The shared scalar alias
 * `sndgs_fx_bus0_master` is emitted at `sndgs + 0xA0` in sdata.c. Keep storage
 * owned by that shared block; do not add a second definition here. */
