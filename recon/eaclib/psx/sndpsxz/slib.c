/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            iSNDserve
 *   default         58 (229/231)
 *   2.6.0           compile error
 *   2.6.3           compile error
 *   2.7.2-970404    85 (226/231)
 *   2.7.2           compile error
 *   2.8.0 CONTROL   67 (226/231)
 *   2.8.1           85 (226/231)
 *   2.91.66        187 (222/231)
 *   2.95.2         261 (234/231)
 *
 * READING: nothing improves; the ROUTE alone costs 9 (58 -> 67 at the same compiler).
 * Note iSNDserve is one of the w47-a9 "13 SN-DIVERGENT" functions (where SN's compiler
 * patch diverges from stock 2.8.1) -- the ladder is consistent with that: no stock rung,
 * old or new, reproduces it better than our patched-2.8.0 lane does.
 */
/* W85-S8 VOLATILE AUDIT (2026-09-02): the `volatile` qualifiers on 377, 394, 413 (the three `postmask_spu`/`vr`/`post_ctrl` reads of the LATCHED SPU base at `sndpd+0x510/0x514`; every inline re-read of that word inside an MMIO store stays volatile -- stripping those costs iSNDinit 33 diffs)
 * were REMOVED -- plain main-RAM driver state, not MMIO and not IRQ-mutated; removal is
 * gate-neutral (whole-TU verify_asm/tugate PASS before and after).  Every REMAINING
 * `volatile` in this file was measured individually or as a group and is load-bearing
 * (MMIO, or state the oracle provably re-reads) -- do not strip them.  Receipt:
 * scratchpad/w85/S8_receipt.md. */

/* eaclib/psx/sndpsxz/slib.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 5/5 PASS ***
 *   Source obj : nfs4\eaclib\psx\slib.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   5 fns @[0x800FF5A8 .. 0x800FFAF4].  The PSX SPU sound-system: boot init (iSNDinit), teardown
 *   (iSNDrestore), the per-frame voice driver (iSNDserve), and the output-format caps/apply.
 *   Ghidra nfs4-f.exe.c (slib) + disasm-v3 for dropped args / offset fixes:
 *     iSNDinit's iSNDdmqueue is 5-arg (ram,spu,len,prio,flag)=(&DAT_80136df0,0x1000,0x10,1,0); addtimer/
 *     deltimer/addexit are 1-arg (Ghidra `in_a1` was register leftover); addexit(SNDSYS_restore@0x800f204c);
 *     SPU master-vol offset is +0x180/+0x182 (Ghidra decompiled +0x60 wrongly); outputset's iSNDsetvol is
 *     3-arg (chan, (s8)L-cache@+0x24, (s8)R-cache@+0x25).
 *
 *   SPU hardware regs (libspu): DPCR, SPU_MAIN_VOL, SPUSTAT, D4_xxx, VOICE_00_LEFT_RIGHT etc -- base
 *   addresses are latched in the private SndSpuRegisterBases view at sndpd+0x4FC..+0x514. The `+0x4FC`
 *   role has conflicting local labels (`delay` here, DPCR/control in sdma.c), so that field stays neutral.
 */


/* W65-A6 DATA-MAT: `sndpd` was extern-only tree-wide -- 113 reloc-referenced undefined sites
 * across 20 TUs.  Retail: .bss @0x80147918, size 1836 (= gPreLoadTicks @0x80148044 - 0x80147918);
 * VA > t_addr+t_size (0x8013E000) => no file bytes, pure zero-init BSS.  slib.obj owns it
 * (50 references here, the driver core).  DEVICE = file-scope asm .bss definition (not a C
 * tentative def): every consumer declares it `extern unsigned char sndpd[]` UNSIZED and that
 * shape is load-bearing for address materialization (see the decl comment below), so keeping
 * the C view `extern` makes the storage byte-neutral BY CONSTRUCTION.
 * INTERIOR ALIASES -- five more undefined `D_`/`DAT_` names are offsets INSIDE this one block:
 *      D_801479F0 / DAT_801479f0 = sndpd + 0x0D8  (voice-table base; slib.c+sdtimrem.c /
 *                                                  sdplapat.c+sdriver.c -- two spellings, one VA)
 *      D_80147A0C               = sndpd + 0x0F4  (that table's +0x1c state field)
 *      DAT_80147e28             = sndpd + 0x510  (spatkey.c)
 *      D_80147E34               = sndpd + 0x51C  (sdmemman.c)
 * Emitted as extra LABELS (not `sym = sndpd+N`): ASPSX 2.77 has no symbol-assignment form
 * (catalog 15E), a second label is the only dual-legal spelling.  Retires 2 more `DAT_`
 * seal-criterion #3 violations.  Receipts: scratchpad/w65a6/RECEIPTS.md */
#include "salloc.h"
#include "sdata.h"
#include "sndchpriv.h"
#include "snddriverpriv.h"
#include "sndserverpriv.h"
#include "sndspuregpriv.h"
#include "sndmempriv.h"
#include "sndhookpriv.h"
#include "sndlibetcpriv.h"
#include "sndpacketpriv.h"
#include "sdfx.h"
#include "sdma.h"
#include "slib.h"
#include "sdriver.h"
#include "slib_state.h"
#include "sserver.h"
#include "ssysserv.h"
#include "ssysinit.h"
#include "../eacpsxz/addtimer.h"
#include "../eacpsxz/exit.h"

__asm__("\t.globl\tsndpd\n\t.globl\tD_801479F0\n\t.globl\tDAT_801479f0\n\t.globl\tD_80147A0C\n"
        "\t.globl\tDAT_80147e28\n\t.globl\tD_80147E34\n"
        "\t.section\t.bss\n\t.align\t2\n"
        "sndpd:\n\t.space\t0xd8\n"
        "D_801479F0:\n"
        "DAT_801479f0:\n\t.space\t0x1c\n"
        "D_80147A0C:\n\t.space\t0x41c\n"
        "DAT_80147e28:\n\t.space\t0xc\n"
        "D_80147E34:\n\t.space\t0x210\n\t.text");
/* ==== moved here from spatkey.c 2026-09-21: the SPU key / voice / volume layer opens this object (see the note in spatkey.c).
 *      It stands BEFORE this file's own sndpd-relative macros, so its declarations keep the spelling they were matched with. ==== */

   /* EA sound-driver state base @0x80147918 (unsized array: forces
                                     * the oracle's `lui;addiu &sndpd; lw r,0x514(base)` base+offset shape
                                     * instead of folding &sndpd+const into one absolute %lo load) */
/* Register-base and per-voice state layouts are described by the private views in
 * sndspuregpriv.h and sndpacketpriv.h. Keep the one byte-base alias below where its exact
 * relocation/materialization shape is needed by legacy voice-table code. */



/* iSNDcalcvol @0x800FF050 : compute a channel's effective 0..0x7F volume from its patch volume (+0x2C),
 *   note velocity (+0x1E), expression (+0x26) and the master volume, then apply the optional velocity
 *   (+0x50) and final (+0x44) volume curves.  Caches the result at +0x2D and returns it. */
void iSNDcalcvol(int chan)
{
    SndChannel *pool = ((struct SndGlobalServerStateView *)sndgs)->play_records;
    SndChannel *v = &pool[chan];
    int          n = v->patch_volume * v->autovol_position.halves.high *
                     v->portamento_position.halves.high * ((struct SndGlobalServerStateView *)sndgs)->master_volume;
    /* VOID (W31): oracle exits `jr ra; nop` with nothing computed into $v0 -- the cached byte at
     * +0x2D is the only output and no caller consumes a result.  The old "v1-not-v0 coloring floor"
     * was the reserved-return symptom (3.2): dropping the return frees $v0 and the whole velocity-
     * curve block colors itself. */
    n /= 0x1f417f;
    v->volume = (char)n;
    if (v->velocity_curve) {                  /* velocity curve */
        v->volume = (char)((n * 0x1000000 >> 0x18) *
               (int)*(signed char *)(v->velocity_curve + (unsigned)v->velocity_phase) / 0x7f);
    }
    if (v->final_volume_curve) { /* final volume curve */
        *(unsigned char *)&v->volume =
            *(unsigned char *)(v->final_volume_curve + v->volume);
    }
}

/* iSNDpsxkeyon @0x800FF140 : strobe the SPU key-on register for `mask` (24 voices). */
volatile unsigned char *iSNDpsxkeyon(int mask)
{
    struct SndSpuRegisterBasesStateView *base = (struct SndSpuRegisterBasesStateView *)sndpd;
    unsigned char *r;
    *(volatile short *)((unsigned char *)base->registers.control_base + 0x188) = (short)mask;
    r = (unsigned char *)base->registers.control_base;
    *(volatile short *)(r + 0x18a) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxkeyoff @0x800FF168 : strobe the SPU key-off register for `mask`. */
volatile unsigned char *iSNDpsxkeyoff(int mask)
{
    struct SndSpuRegisterBasesStateView *base = (struct SndSpuRegisterBasesStateView *)sndpd;
    unsigned char *r;
    *(volatile short *)((unsigned char *)base->registers.control_base + 0x18c) = (short)mask;
    r = (unsigned char *)base->registers.control_base;
    *(volatile short *)(r + 0x18e) = (short)(mask >> 0x10);
    return r;
}

/* iSNDpsxeffecton @0x800FF190 : enable reverb on the `mask` voices (OR into the SPU echo-on register). */
unsigned int iSNDpsxeffecton(int mask)
{
    struct SndSpuRegisterBasesStateView *base = (struct SndSpuRegisterBasesStateView *)sndpd;
    unsigned int r;
    unsigned char *c0 = (unsigned char *)base->registers.control_base;
    *(volatile unsigned short *)(c0 + 0x198) = *(volatile unsigned short *)(c0 + 0x198) | (unsigned short)mask;
    {
        unsigned char *c1 = (unsigned char *)base->registers.control_base;
        r = *(volatile unsigned short *)(c1 + 0x19a) | (mask >> 0x10);
        *(volatile short *)(c1 + 0x19a) = (short)r;
    }
    return r;
}

/* iSNDpsxeffectoff @0x800FF1D0 : disable reverb on the `mask` voices. */
unsigned int iSNDpsxeffectoff(int mask)
{
    struct SndSpuRegisterBasesStateView *base = (struct SndSpuRegisterBasesStateView *)sndpd;
    unsigned int r;
    unsigned char *c0 = (unsigned char *)base->registers.control_base;
    *(volatile unsigned short *)(c0 + 0x198) = *(volatile unsigned short *)(c0 + 0x198) & ~(unsigned short)mask;
    {
        unsigned char *c1 = (unsigned char *)base->registers.control_base;
        r = *(volatile unsigned short *)(c1 + 0x19a) & ~(mask >> 0x10);
        *(volatile short *)(c1 + 0x19a) = (short)r;
    }
    return r;
}

/* iSNDpsxeffectvol @0x800FF210 : set the SPU reverb (echo) L/R output volume. */
volatile unsigned char *iSNDpsxeffectvol(int left, int right)
{
    struct SndSpuRegisterBasesStateView *base = (struct SndSpuRegisterBasesStateView *)sndpd;
    unsigned char *r;
    *(volatile short *)((unsigned char *)base->registers.control_base + 0x184) = (short)left;
    r = (unsigned char *)base->registers.control_base;
    *(volatile short *)(r + 0x186) = (short)right;
    return r;
}

/* iSNDsetvol @0x800FF238 : write a channel's SPU voice L/R volume from logical (left,right) levels,
 *   panning per the routing mode (mono spread vs hard L/R) and output mode (mono/stereo).
 *   VOID (W31): no caller consumes a result and the oracle's exit `$v0` holds the UNMASKED
 *   `(sum*0x81)>>1` scratch on the mono paths (no C `return` could produce that) -- the declared
 *   return value was the 4 extra insns (`addu v0,x,zero` funnels).  One `vol` + one reused `vreg`
 *   carry the a0/a3 webs through the shared tail. */
void iSNDsetvol(int chan, int left, int right)
{
    /* Keep the driver-state byte base and explicit byte offset; the voice-register cursor is a
     * pointer, and each SPU halfword access below is volatile MMIO. */
    int            vt = chan * (int)sizeof(SndPacketVoiceState);
    unsigned char *voiceBase = sndpd + 0xd8;
    SndPacketVoiceState *slot = (SndPacketVoiceState *)(voiceBase + vt);
    unsigned char  *pd = (unsigned char *)voiceBase - 0xd8;
    unsigned char *voiceRegs = ((struct SndSpuRegisterBasesStateView *)pd)->registers.voice_base;
    unsigned short *vreg = (unsigned short *)(voiceRegs + chan * 0x10);
    int            vol;

    chan = ((volatile SndPacketVoiceState *)slot)->channel_count;

    if (chan == 1) {                                /* single channel */
        int sum;
        if (((struct SndGlobalServerStateView *)sndgs)->output_mode == 2) {                  /* stereo output */
            *vreg   = left * 0x81 & 0x7fff;
            vreg[1] = right * 0x81 & 0x7fff;
            return;
        }
        sum = left + right;
        if (slot->route == chan) { /* L/R-spread routing */
            if (left < 0)  left = -left;
            if (right < 0) right = -right;
            if (left > 0x7f)  left = 0x7f;
            if (right > 0x7f) right = 0x7f;
            sum = left + right;
        }
        vol = sum * 0x81 >> 1 & 0x7fff;
    } else {                                        /* linked pair */
        if (((struct SndGlobalServerStateView *)sndgs)->output_mode == 2) {
            *vreg   = left * 0x81 & 0x7fff;
            vreg[1] = 0;
            vreg = (unsigned short *)(((struct SndSpuRegisterBasesStateView *)pd)->registers.voice_base +
                    ((volatile SndPacketVoiceState *)slot)->link_index.vs * 0x10);
            *vreg   = 0;
            vreg[1] = right * 0x81 & 0x7fff;
            return;
        }
        vol = left * 0x81 >> 1 & 0x7fff;
        *vreg   = vol;
        vreg[1] = vol;
        vol = right * 0x81 >> 1 & 0x7fff;
        vreg = (unsigned short *)(((struct SndSpuRegisterBasesStateView *)pd)->registers.voice_base +
                ((volatile SndPacketVoiceState *)slot)->link_index.vs * 0x10);
    }
    *vreg   = vol;
    vreg[1] = vol;
}

/* iSNDsetslot @0x800FF394 : program a channel's SPU voice ADSR + pitch slot (attack/decay rate, start
 *   address, sample rate). */
/* MATCH: the voice-register base is the pointer-valued +0x510 field (also aliased by
 * DAT_80147e28). Keeping `r` as a byte pointer preserves address arithmetic. Listing the two
 * variable stores before the constant ADSR stores gives gcc the oracle's early `sra`/base-load
 * schedule; it still emits the hardware writes in oracle order (attack, sustain, pitch, address, level). */
unsigned char *iSNDsetslot(int chan, unsigned char *addr, int pitch)
{
    unsigned char *r = (unsigned char *)((struct SndSpuRegisterBasesStateView *)sndpd)->registers.voice_base + chan * 0x10;
    *(short *)(r + 4)  = (short)pitch;               /* sample rate / pitch */
    *(short *)(r + 6)  = (short)((int)addr >> 3);    /* SPU start address (8-byte units) */
    *(short *)(r + 8)  = 0xf;                        /* ADSR attack */
    *(short *)(r + 10) = 5;                          /* ADSR sustain/release */
    *(short *)(r + 0xe) = 0x200;                     /* ADSR sustain level */
    return r;
}

/* iSNDstartvoice @0x800FF3CC : key a channel's voice (and its linked partner) -- reset pan caches, arm the
 *   ADSR slot, set the initial volume + fx level, and return the SPU key-on mask. */
unsigned int iSNDstartvoice(unsigned int chan)
{
    int          vt  = chan * sizeof(SndPacketVoiceState);
    volatile SndPacketVoiceState *voice =
        (volatile SndPacketVoiceState *)(sndpd + 0xd8 + vt); /* &voicetable[chan] */
    unsigned char *voiceBase = sndpd + 0xd8;
    /* 441 Hz units; cc1psx lowers the unsigned divide to multu 0x4A4DC96F + mfhi >> 7. */
    int          pitch;
    unsigned int mask;

    voice->pan_left_cache = 0;
    voice->pan_right_cache = 0;
    pitch = voice->position_step / 441u;
    iSNDsetslot(chan, voice->spu_start_address, pitch); /* +0x00 SPU start address / tag */
    mask = 1u << chan;
    voice->play_state = 2;
    voice->voice_status = 2;
    voice->stop_pending = 0;
    if (voice->channel_count == 2) {                            /* linked pair -> arm the partner too */
        signed char maskLink; /* MATCH: retain the pre-store linked index; inlining it in the final mask shifts lbu/li (4 diffs). */
        int         vt2  = voice->link_index.vs * (int)sizeof(SndPacketVoiceState);
        volatile SndPacketVoiceState *vte2 = (volatile SndPacketVoiceState *)(voiceBase + vt2);
        int         a3;                              /* linked-partner start-addr offset (oracle 0x800FF468-50C) */
        if ((signed char)voice->voice_done >= 0) { /* bit7 clear: ptr table at base+0x420 indexed by f27 */
            int f27x4 = (int)(signed char)voice->voice_done * 4;
            unsigned char *table = voiceBase + 0x420;
            /* The table yields an address; only the word at byte offset +8 is consumed here. */
            unsigned char *pt = *(unsigned char **)(table + f27x4);
            a3 = *(int *)(pt + 8);
        } else {                                     /* bit7 set: index from +0x04 via 1/0x1c reciprocal */
            unsigned int checkNumerator;
            a3 = (unsigned int)voice->loop_length_param / 0x1c;
            checkNumerator = (unsigned int)voice->loop_length_param;
            if (checkNumerator != (checkNumerator / 0x1c) * 0x1c)
                a3 += 1;
            a3 = a3 << 4;
        }
        iSNDsetslot(voice->link_index.vs,
                    voice->spu_start_address + a3, pitch);
        maskLink = voice->link_index.vs;
        vte2->play_state = 2;
        vte2->voice_status = 2;
        vte2->stop_pending = 0;
        mask |= 1u << maskLink;
    }
    iSNDvol(chan, (signed char)voice->level);
    iSNDplatformfxlevel(chan, 0, (signed char)voice->fx_level);
    return mask;
}

/* ==== end of the block moved from spatkey.c ==== */

/* The packet voice table has a shared private layout in sndpacketpriv.h. `DAT_801479f0` below
 * remains as a byte-base view where its exact symbol/materialization is part of matched codegen. */
/* DMA scratch RAM @0x80136DF0, per configs/symbol_addrs.txt
                                              * (oracle references this real symbol name directly, not a bare VA) */
/* w64-a18 E5 fix: retail = a 16-byte INITIALISED .data object (word 0 =
 * 0x00000700, rest zero) -- was a 1-byte .sbss tentative def (W62-A19 3.2's
 * wrong-section class; a genuine wrong runtime value). */
unsigned char sndpdsafeloop[16] = {0x00, 0x07, 0x00, 0x00}; /* @0x80136DF0 */

/* Exact-symbol byte-base view retained for source sites whose relocation shape is matched. */
#define DAT_801479f0 (sndpd[0xD8])           /* packet-voice table base */

/* The pre-latch SPU_MAIN_VOL_L/R + SPUCNT/SPUSTAT accesses go through a RUNTIME POINTER VARIABLE
 * (below, `spu`) rather than independent literal macros: gcc-2.8 -O2 keeps the pointer in a register
 * and reuses it via load/store displacements. This is the exact shape required by the oracle. */

   /* @0x800FF5A8 -- oracle explicitly zeroes $v0 before return */
    /* @0x800FF600 */
                 /* @0x800FF700 */
              /* @0x800FF9A0 */
                /* @0x800FFAF4 */

/* cop0 Status read/write (interrupts masked around the hardware-register pokes; host: plain). */
#if defined(__mips__)
static inline unsigned int rd_sr(void) { unsigned int s; __asm__ volatile("mfc0 %0,$12" : "=r"(s)); return s; }
static inline void wr_sr(unsigned int s) { __asm__ volatile("mtc0 %0,$12" : : "r"(s)); }
/* CP0 critical section around the DMA4 (SPU) callback (re)install.  This IS the sanctioned cop0
 * macro block: the oracle carries the identical hand-written sequence verbatim (iSNDinit
 * @800FF82C / iSNDrestore @800FFAA0, both tagged `/ * handwritten instruction * /` by splat),
 * including the `nop` after `mfc0` and the three `nop`s after `mtc0` -- the R3000 CP0 hazard
 * slots no C compiler emits.
 *
 * W85-S8 (2026-09-02): the two `register int x __asm__("$4"/"$5")` HARD-REGISTER PINS that used
 * to hold the DMACallback arguments across this block are GONE.  They are replaced by threading
 * the argument values THROUGH the cop0 block as matching in/out operands, which is what the
 * critical section semantically is (those values must survive the masked window).  Measured:
 *   pins + `"+r"` operands ........................ 5/5 PASS (old form)
 *   plain ints + `"+r"` operands .................. cc1 ABNORMAL TERMINATION (2.8.0 ICE)
 *   plain ints, operands dropped entirely ......... iSNDinit 3 / iSNDrestore 2 -- the only
 *       residual is the POSITION of `addiu $a0,$zero,4`: retail materializes the channel BEFORE
 *       `mfc0`, gcc sinks the constant to the `jal DMACallback` (statement order, a literal arg,
 *       and moving `dma = 4` above `iSNDpsxfxinit` all leave it at 2)
 *   plain ints + read-only `"r"(channel)` inputs .. iSNDinit 7 / iSNDrestore 3 (worse)
 *   plain ints + `"=r"(x)` / `"N"(x)` MATCHING in/out operands ... 5/5 PASS  <- kept
 * No hard register is named anywhere; gcc chooses $a0/$a1 on its own because they are the
 * outgoing arguments of the `DMACallback` call that follows. */
#define MASK_SR_FOR_DMA(sr, channel)                                                   \
    __asm__ volatile(                                                                 \
        "mfc0 %0,$12\n\t"                                                            \
        "nop\n\t"                                                                     \
        "li $1,-1026\n\t"                                                            \
        "and $8,%0,$1\n\t"                                                           \
        "mtc0 $8,$12\n\t"                                                            \
        "nop\n\t"                                                                     \
        "nop\n\t"                                                                     \
        "nop"                                                                         \
        : "=r"(sr), "=r"(channel) : "1"(channel) : "$1", "$8", "memory")
#define MASK_SR_FOR_DMA_CALLBACK(sr, channel, callback)                                \
    __asm__ volatile(                                                                  \
        "mfc0 %0,$12\n\t"                                                             \
        "nop\n\t"                                                                      \
        "li $1,-1026\n\t"                                                             \
        "and $8,%0,$1\n\t"                                                            \
        "mtc0 $8,$12\n\t"                                                             \
        "nop\n\t"                                                                      \
        "nop\n\t"                                                                      \
        "nop"                                                                          \
        : "=r"(sr), "=r"(channel), "=r"(callback) : "1"(channel), "2"(callback) : "$1", "$8", "memory")
#else
/* SYM-HOST-ONLY: g_sr -- portable stand-in for the target COP0 Status register. */
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#define MASK_SR_FOR_DMA(sr, channel) do { (sr) = rd_sr(); wr_sr((sr) & 0xfffffbfe); } while (0)
#define MASK_SR_FOR_DMA_CALLBACK(sr, channel, callback) MASK_SR_FOR_DMA(sr, channel)
#endif

/* iSNDplatformoutputcaps @0x800FF5A8 : publish this platform's output capabilities into sndgs (44.1 kHz,
 *   24 SPU voices, stereo). */
int iSNDplatformoutputcaps(void)
{
    struct SndGlobalServerStateView *base = (struct SndGlobalServerStateView *)sndgs;   /* materialize bare &sndgs first (oracle: no offset folded into %lo) */
    base->opaque_007_009[0] = 0;  base->opaque_007_009[1] = 0;  base->opaque_007_009[2] = 0;  base->voice_limit = 0x18;
    base->sample_rate_00 = 0xac44;  base->min_output_mode = 1;  base->sample_rate_02 = 0xac44;  base->max_output_mode = 2;
    base->opaque_012_014[1] = 0;  base->opaque_012_014[2] = 0;  base->opaque_012_014[0] = 0;  base->channel_count = 0x18;
    base->sample_rate_0E = 0xac44;  base->output_mode = 2;
    return 0;
}

/* iSNDplatformoutputset @0x800FF600 : apply the requested output channel count (clamped to caps), and if the
 *   mode changed while audio is up, re-push every playing voice's L/R volume. */
int iSNDplatformoutputset(void)
{
    struct SndGlobalServerStateView *base;    /* &sndgs, caller-saved until the voice loop. The initial
                              * `channel_count = 0x18` member store anchors the compiler's base at +0x11;
                              * the preceding output-mode clamp reads then use negative displacements,
                              * matching the measured register/address schedule. */
    volatile SndPacketVoiceState *vp;       /* WALKING &sndpd+0xd8 pointer (voice-table row base), +=0x2c per
                               * iter -- matches iSNDserve's established `vp = &DAT_801479f0 + vt`
                               * lever: keeps the 4 field accesses (0x1c/0x21/0x24/0x25) as load
                               * DISPLACEMENTS off ONE walking base instead of 4 separately-folded
                               * &DAT_80147a0x constant bases */
    struct SndGlobalServerStateView *vbase;
    int chan;
    base = (struct SndGlobalServerStateView *)sndgs;
    base->channel_count = 0x18;
    if (base->output_mode < base->min_output_mode)   base->output_mode = base->min_output_mode;
    if (base->max_output_mode < base->output_mode)   base->output_mode = base->max_output_mode;
    if (base->initialized && ((struct SndDriverBootstrapPrefixView *)sndpd)->last_channel_mode != base->output_mode) {  /* signed `initialized` at +0x3C: retail uses lb */
        chan = 0;
        vbase = base;
        vp = (volatile SndPacketVoiceState *)&DAT_801479f0;
    voiceloop:
        {
            /* goto-loop (catalog §B): a label+goto back-edge carries no NOTE_INSN_LOOP_BEG, so
             * loop.c never runs on this body -- that is what stops gcc hoisting the literal 2 of
             * the state compare into a callee-saved reg ($s2, which the oracle needs for the
             * persistent sndgs base) and reproduces the oracle's per-iteration
             * `addiu v0,zero,2` remat in the lbu's load-delay slot. */
            if (vp->play_state == 2) {
                if (!vp->link_flag) {
                    iSNDsetvol(chan,
                        (vp->pan_left_cache << 24) >> 24,
                        (vp->pan_right_cache << 24) >> 24);
                }
            }
            vp++;
            /* Preincrement makes the channel-count load precede the counter increment. */
            if (++chan < vbase->channel_count) goto voiceloop;
        }
    }
    ((struct SndDriverBootstrapPrefixView *)sndpd)->last_channel_mode = ((struct SndGlobalServerStateView *)sndgs)->output_mode;   /* FRESH re-read, not through `base` -- oracle re-materializes
                                       * this via its own %hi/%lo AFTER the epilogue register
                                       * restores, so `base`'s live range must END at the if-check
                                       * above, not extend across the loop/call to here */
    return 0;
}

/* iSNDinit @0x800FF700 : bring up the SPU -- enable DMA4, zero the SPU voice/main/CD/ext volumes, latch the
 *   DMA + SPU register addresses, key-off all voices, set master volume, apply the fx preset, and install
 *   the audio timer + exit handler. */
int iSNDinit(void)
{
    unsigned int sr;
    int ch;      /* DMACallback channel arg (4), materialized early like the oracle */
    int callback;
    volatile unsigned int *delay;
    volatile unsigned int *madr;
    volatile unsigned int *bcr;
    volatile unsigned int *chcr;
    volatile unsigned int *dpcr;
    unsigned char *spu;    /* runtime byte base of the SPU MMIO register banks */
    unsigned char *wait_spu;
    unsigned char *pd;
    unsigned char *latched;
    struct SndGlobalServerStateView *gs;
    struct SndGlobalServerStateView *loop_gs;
    unsigned char *loop_pd;
    unsigned char *post;
    unsigned char *postmask_spu;
    unsigned char *post_ctrl;
    int pitch;
    int done;
    unsigned short master;
    unsigned char *vp;    /* walking sndpd address for the "mark voice done" byte */
    int i;

    delay = (volatile unsigned int *)0x1f801014;
    madr = (volatile unsigned int *)0x1f8010c0;
    bcr = (volatile unsigned int *)0x1f8010c4;
    chcr = (volatile unsigned int *)0x1f8010c8;
    dpcr = (volatile unsigned int *)0x1f8010f0;
    spu = (unsigned char *)0x1f801c00;
    pd = sndpd;
    ((struct SndSpuMemoryStateView *)pd)->memory.engine_ver = 0x41;
    *dpcr = *dpcr | 0xb0000;
    ((struct SndSpuControlRegisterView *)spu)->master_volume_left = 0;
    ((struct SndSpuControlRegisterView *)spu)->master_volume_right = 0;
    ((struct SndSpuControlRegisterView *)spu)->control = 0;                      /* early clear (pre-latch) */
    ((struct SndSpuControlRegisterView *)spu)->master_volume_left = 0;              /* oracle writes both master-vol halves TWICE */
    ((struct SndSpuControlRegisterView *)spu)->master_volume_right = 0;
    ((struct SndSpuMemoryStateView *)pd)->memory.boundary.view.limits.block_total = 0x2000;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.address_4fc = delay;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.dma4_madr = madr;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.dma4_bcr = bcr;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.dma4_chcr = chcr;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.dpcr = dpcr;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.voice_base = spu;
    ((struct SndSpuRegisterBasesStateView *)pd)->registers.control_base = spu;
    if (((struct SndSpuControlRegisterView *)spu)->status & 0x7ff) {
        do {
            wait_spu = (unsigned char *)0x1f801c00;
        } while ((*(volatile unsigned short *)(wait_spu + 0x1ae) & 0x7ff) != 0);
    }
    latched = sndpd;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x1ac) = 4;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x190) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x192) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x194) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x196) = 0;
    ch = 4;   /* DMACallback channel arg, materialized early (matches oracle's early a0=4) */
    callback = (int)iSNDdmcallback;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x1b0) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x1b2) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x1b4) = 0;
    postmask_spu = ((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base;
    MASK_SR_FOR_DMA_CALLBACK(sr, ch, callback);
    *(volatile unsigned short *)(postmask_spu + 0x1b6) = 0;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)latched)->registers.control_base + 0x1aa) = 0xc000;
    DMACallback(ch, callback);               /* install the real DMA4 (SPU) callback */
    wr_sr(sr);
    iSNDdmqueue(sndpdsafeloop, (unsigned char *)0x1000, 0x10, 1, 0);     /* clear first SPU page */

    i = 0;
    gs = (struct SndGlobalServerStateView *)sndgs;
    if (gs->channel_count) {
        pitch = 0x200;
        done = -1;
        loop_pd = latched;
        loop_gs = gs;
        vp = latched;
        do {
            unsigned char *vr = (unsigned char *)((struct SndSpuRegisterBasesStateView *)loop_pd)->registers.voice_base + i * 0x10;
            *(short *)(vr) = 0;
            *(short *)(vr + 2) = 0;
            *(short *)(vr + 4) = 0;
            *(short *)(vr + 6) = pitch;
            *(short *)(vr + 0xe) = pitch;
            *(short *)(vr + 8) = 0;
            *(short *)(vr + 0xa) = 0;
            i++;
            *(signed char *)(vp + 0xff) = done;             /* mark voice done */
            vp += (int)sizeof(SndPacketVoiceState);
        } while (i < loop_gs->channel_count);
    }
    iSNDpsxkeyon(0xffffff);
    post = sndpd;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)post)->registers.control_base + 0x1a2) = 0xfffe;
    master = 0x3fff;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)post)->registers.control_base + 0x180) = master;
    *(volatile unsigned short *)(*(unsigned char * volatile *)&((struct SndSpuRegisterBasesStateView *)post)->registers.control_base + 0x182) = master;
    post_ctrl = ((struct SndSpuRegisterBasesStateView *)post)->registers.control_base;
    *(volatile unsigned short *)(post_ctrl + 0x1aa) =
        *(volatile unsigned short *)(post_ctrl + 0x1aa) | 1;
    iSNDpsxfxinit(*(int *)(post + 4));
    *(volatile unsigned char *)(post + 1) = 0;
    addtimer(iSNDserver);
    if (!sndpd[0]) {
        addexit((void (*)(void))SNDSYS_restore);
        sndpd[0] = 1;
    }
    return 0;
}

/* iSNDrestore @0x800FF9A0 : tear the SPU back down -- unwind the audio lock, let all voices fade past their
 *   release, drop the audio timer, clear the fx, and re-arm the DMA callback. */
int iSNDrestore(void)
{
    struct SndGlobalServerStateView *guard;
    struct SndGlobalServerStateView *gpraw;
    struct SndGlobalServerStateView *gp;       /* &sndgs, INDEPENDENTLY re-materialized for the rest of the fn --
                               * shared for BOTH the 0x11 channel-count byte AND the 0x44 ticks
                               * int (oracle keeps ONE base reg (s3) for both instead of
                               * re-deriving per access), but is a SEPARATE live range from `p`
                               * above (oracle re-does the lui/addiu a second time here) */
    unsigned char *base;     /* &sndpd, materialized ONCE (function scope, before the outer
                               * do-while) -- the oracle keeps this INVARIANT copy in its own
                               * persistent reg (s5) separate from the per-iter walker, so the
                               * walker resets from a plain base + the 0xf5 field stays a load
                               * DISPLACEMENT instead of folding &sndpd+0xf5 into one constant */
    unsigned char *vp;      /* WALKING sndpd pointer (reset from base each outer pass, +=0x2c
                               * per inner iter) */
    int          quiet;
    int          chan;
    unsigned int deadline;
    unsigned int sr;
    int dma;

    guard = (struct SndGlobalServerStateView *)sndgs;
    if (guard->audio_lock_depth) {
        struct SndGlobalServerStateView *waitBase = guard;
        do {
            iSNDleaveaudio();
        } while (waitBase->audio_lock_depth);
    }
    gpraw = (struct SndGlobalServerStateView *)sndgs;
    deadline = (unsigned int)gpraw->tick_count + 100;
    gp = gpraw;
    base = sndpd;
    do {
        quiet = 1;
        chan = 0;
        /* MATCH (w49-a7, 2 -> PASS 85/85): TWO cooperating facts, both read off the oracle's block
         * layout.  (1) `vp = base` belongs INSIDE the guard -- the oracle emits `addu s1,s5,zero`
         * AFTER the beqz's delay slot, i.e. in the loop-preheader block, not in the test block
         * (moving it alone gets the position right but rotates chan/vp s0<->s1).  (2) the guard is
         * the ZERO-TRIP form on the counter itself (`chan < count`), not `count != 0`: the extra
         * loop-weighted reference to `chan` lifts its allocno above `vp`'s so chan takes $s0 and
         * vp $s1 like retail (allocno_compare = floor_log2(refs)*refs/live).  The in-tree zero-insn
         * USE fence `__asm__("" : : "r"(chan))` after the vp store reaches the identical object,
         * confirming the mechanism is the chan REF COUNT -- but the guard is the honest spelling,
         * so the fence is not used here. */
        if (chan < gp->channel_count) {
            vp = base;
            for (; chan < gp->channel_count; chan++) {
                if (*(volatile unsigned char *)((unsigned char *)vp + 0xf5)) { /* voice still active */
                    if (deadline < ((struct SndGlobalServerStateView *)gp)->tick_count) {
                        iSNDpsxkeyoff(0xffffff);
                        *(volatile unsigned char *)((unsigned char *)vp + 0xf5) = 0;
                        iSNDfreechan(chan);
                    }
                    quiet = 0;
                }
                vp += sizeof(SndPacketVoiceState);
            }
        }
        SNDSYS_service();
    } while (!quiet);
    deltimer(iSNDserver);
    iSNDpsxfxinit(0);
    dma = 4;
    MASK_SR_FOR_DMA(sr, dma);
    DMACallback(dma, 0);      /* detach the DMA4 callback (teardown) */
    wr_sr(sr);
    return 0;
}

/* iSNDserve @0x800FFAF4 : the per-frame SPU voice driver -- run the user serve hook, advance every voice's
 *   play position, retire finished/stopping voices (free their channels, key them off), and key-on any
 *   newly-armed voices.  Batches the SPU key-on/key-off masks for a single hardware poke. */
void iSNDserve(void)
{
    unsigned int koff;         /* local_30 : key-off mask deferred until DMA settles */
    unsigned int kon;          /* mask     : key-on mask */
    unsigned short *vreg;
    int          chan, vt, n, cvt;
    int          onec, one;
    unsigned char *vbase;
    unsigned char *vp;
    unsigned char *base;
    unsigned char *fpbase;    /* &sndpd, materialized ONCE right before the loop and kept LIVE across
                                * the whole loop (matches iSNDinit/iSNDrestore's persistent-base lever,
                                * oracle reg $fp) -- every plain sndpd-relative field access that is
                                * NOT relative to the CURRENT voice pointer `vp` (the SPU voice-reg-base
                                * dereference @+0x510, and the linked-voice-done probe @+0xF5+cvt) goes
                                * through this cached base instead of re-materializing sndpd's own
                                * %hi/%lo every time. */

    koff = 0;
    base = sndpd;
    do {
        do {
            kon = 0;
        } while (0);
    } while (0);
    if (((struct SndDriverHookStateView *)base)->hooks.user_serve)
        ((struct SndDriverHookStateView *)base)->hooks.user_serve();

    /* W31 (106 -> 101): `chan = kon` (== 0) -- the oracle's entry-guard is a real slt against the
     * count with the zero in a REGISTER (retail cse substituted kon's reg for the literal 0); a
     * plain `chan = 0` guard folds to beqz.  Natural while: closest measured layout.  RESIDUAL
     * (101): ours lays the loop as j-to-bottom-test and hoists the `1 <<` constant into $fp
     * (oracle: test duplicated top+bottom, li 1 rematerialized per use) plus the kon/chan/vt
     * coloring web -- same allocno-ordering signature as the rest of this wave's monsters.
     *
     * W32-a8 -- TWO STRUCTURAL FACTS CONFIRMED AGAINST THE ORACLE, both TESTED AND REVERTED
     * because the diff count rises even though the shape gets closer.  Record them so the next
     * pass does not re-derive them, and so they can be re-applied the moment the `li fp,1`
     * blocker below falls:
     *   (i)  the serve-hook guard is a PLAIN `kon = 0; if (hook) hook();` -- NOT the `kon = 0`
     *        duplicated into both arms of an if/else.  The oracle materializes the zero ONCE, in
     *        the `beqz` delay slot shared by both paths (`beqz v0,T / addu s3,zero,zero / jalr v0
     *        / nop`), and has no `j` around an else arm.  With this the whole prologue + hook
     *        block becomes byte-exact (measured), but the diff count goes 101 -> 121 because kon
     *        slides s3 -> s5 and drags the rest of the web with it.
     *   (ii) the voice loop is ROTATED with an ENTRY GUARD, and -- exactly as in sserver.c's
     *        iSNDserver -- the guard and the back-edge test are on DIFFERENT variables: the guard
     *        compares `kon` (still 0 there; retail's cse substituted kon's register for the
     *        literal) while the body's counter `chan` is zeroed in the guard's delay slot:
     *          if ((int)kon < (int)(unsigned)((struct SndGlobalServerStateView *)sndgs)->channel_count) { chan = 0; fpbase = base; vt = chan;
     *              do { ...body... } while (chan < (int)(unsigned)((struct SndGlobalServerStateView *)sndgs)->channel_count); }
     *        Applied together with (i) this reaches EXACT insn parity 231/231 in one variant and
     *        an oracle-exact loop-entry block, but 120 diffs.
     *   BLOCKER (why neither is kept): gcc's loop.c hoists the `1` of `1 << chan` / `1 << c` out
     *   of the voice loop into a register (`li fp,1`), stealing $fp from `fpbase` and rotating the
     *   whole callee-saved web; the oracle REMATERIALIZES `addiu v0,zero,1` at each site -- and at
     *   0x800FFD74 it even parks that remat in the `bnez` delay slot so BOTH arms of the
     *   kon/koff if/else share it.  This is the catalog's "-dL move-insn savings cost-model"
     *   negative (§F).  A full goto-loop (the documented LICM killer) DOES remove the hoist but
     *   also kills the `vt`/`vp` induction handling: 161 diffs / 226 insns, far worse.  Until the
     *   hoist can be suppressed without losing strength reduction, the natural-while form below
     *   scores best; do not "fix" the if/else or the loop shape in isolation.
     *
     * W33-a8 -- THE LAST UNTESTED COMBINATION IS NOW FALSIFIED; treat the hoist as CLOSED.
     *   The goto-loop is this wave's confirmed LICM-constant killer (it took iSNDplatformoutputset
     *   in this same file from 7 diffs to PASS by stopping exactly this kind of hoist).  It was
     *   never tried here TOGETHER with (i)+(ii), so all four combinations were measured:
     *       (i)+(ii)+goto-loop     161 diffs / 226 insns
     *       (i)+(ii)+do-while      122 diffs / 229 insns
     *       (ii)+goto-loop only    165 diffs / 228 insns
     *       goto-loop, chan=kon    164 diffs / 227 insns
     *       (i) alone              121 diffs / 228 insns
     *   EVERY goto-loop variant lands at 226-228 insns against the oracle's 231, i.e. it always
     *   costs ~5 instructions.  Unlike outputset's tiny loop, THIS loop genuinely needs loop.c:
     *   killing the loop notes to suppress `li fp,1` also kills the `vt`/`vp` strength reduction
     *   the oracle depends on.  The two goals are mutually exclusive in our cc1, so the hoist is a
     *   real -dL move-insn cost-model floor (catalog SS.F) and the 101-diff natural-while form
     *   below stands.  Route to the toolchain-identity investigation, not to more source reshaping.
     *   (Also re-checked this wave: a3's "redundant copy = a SECOND source evaluation" reading of
     *   `chan = kon` -- i.e. two literal zeros that retail's cse turned into a register copy -- is
     *   what fact (i) already encodes, and it still measures 121, not better.)
     *
     * 🔴 W35-a2 2026-07-26 -- THE ABOVE "-dL COST-MODEL FLOOR" VERDICT IS **WRONG**; 101 -> 69.
     *   The `li fp,1` LICM hoist IS killable without touching the loop shape, using the w34/w35
     *   movfxya SET-TWICE DEAD-SET CARRIER (`one = 1; use; one = 0;`): loop.c counts the dead set
     *   (set_in_loop != 1 -> not invariant -> no hoist) and flow deletes it for free, so the `1`
     *   is rematerialized per site exactly like retail -- and the giv/strength-reduction machinery
     *   the goto-loop destroyed is fully preserved.  With the hoist gone, `$fp` is freed and the
     *   whole residual becomes a pure ALLOCNO-ORDER problem, which is arithmetic, not guesswork.
     *
     *   THE ALLOCNO ARITHMETIC (cc1 `-dl`/`-dg`, priority = floor_log2(refs)*refs/live_length,
     *   REG_N_REFS weighted by loop DEPTH: 1 outside, 2 in the voice loop, 3 in the cleanup loop;
     *   callee-saved REG_ALLOC_ORDER is s0..s7 then $fp, and gcc-2.8 allocno_compare TIE-BREAKS BY
     *   PSEUDO NUMBER = DECLARATION ORDER).  Retail's map, read off the oracle:
     *       vp $s0 | c $s1 | n $s2 | kon $s3 | vreg $s4 | chan $s5 | cvt $s6 | vt $s7 | fpbase $fp
     *       (+ koff SPILLED to 0x10(sp) -- 10 callee-saved-needing pseudos, 9 registers)
     *   Four source levers move our table onto it (all four are load-bearing, measured):
     *     1. dead-set carriers `one`/`onec` (above) -- removes the const-1 allocno, frees $fp.
     *     2. facts (i)+(ii) -- plain `kon = 0; if (hook) hook();` + explicit entry-guard/do-while.
     *        These were measured at 121 in w32 ONLY because the const-1 allocno was still there;
     *        with lever 1 in place they are what puts fpbase LAST (its live length grows to ~282,
     *        priority 0.16 < vt's 0.19) and re-spills koff.
     *     3. `chan = 0;` as the FUNCTION'S FIRST STATEMENT -- pure live-length dial: it lengthens
     *        chan's range to exactly kon's (both 4*18/154), landing chan in the kon/vreg tie group.
     *     4. `unsigned short *vreg;` DECLARED BEFORE `chan` -- the three pseudos end up with
     *        NUMERICALLY IDENTICAL priorities (36/77 == 72/154), so the winner is decided purely by
     *        allocno_compare's `allocno1 - allocno2` tail, i.e. by declaration order.  Moving the
     *        vreg decl above chan orders them kon < vreg < chan == $s3/$s4/$s5 = retail.
     *   Plus `cvt = vt` hoisted OUT of the cleanup do-while (it is loop-invariant there, so it
     *   crosses iSNDfreechan and becomes the 7th callee-saved allocno = retail's $s6).
     *
     *   5. `vbase = &DAT_801479f0;` as a per-arm CARRIER in the cleanup loop, with the SPLIT `vp`
     *      form (`vp = vbase + c*0x2c` in the n==2 arm, `vp = vbase + cvt` in the else).  The split
     *      form is what prices `cvt` at 0.24 so it takes retail's $s6 -- but on its own it makes
     *      &DAT_801479f0 a 3-site loop invariant that gcc hoists into ONE caller-saved pseudo and
     *      then caller-save-SPILLS (frame 0x48 vs retail's 0x40, +14 diffs).  Assigning it to a
     *      carrier in BOTH arms makes set_in_loop != 1 -> loop.c refuses the hoist -> each arm
     *      materializes its own `lui/addiu %hi/%lo` exactly like retail, and the spill slot plus the
     *      whole frame-offset cascade disappear.  (Lever 1's mechanism applied to an ADDRESS.)
     *   6. `kon = 0;` AFTER the hook call, not before.  Pure live-length dial: kon and chan
     *      otherwise price IDENTICALLY (both 18 refs / 157 insns) and no change to `vreg` can then
     *      land between them.  Moving kon's def past the hook block cuts its range to 153
     *      (0.471 > chan's 0.459) and opens the gap `vreg` has to fit into.
     *   7. `vp[0x1d] = 0;` moved AFTER the three `vreg[]` stores in the state==3 arm -- shortens
     *      vreg's live range by exactly 1 insn (79 -> 78), lifting vreg from 0.4557 (below chan) to
     *      0.4615 (between chan 0.459 and kon 0.471).
     *
     *   ==> THE ENTIRE RETAIL CALLEE-SAVED MAP NOW REPRODUCES EXACTLY (cc1 -dg dispositions):
     *       vp $s0 | c $s1 | n $s2 | kon $s3 | vreg $s4 | chan $s5 | cvt $s6 | vt $s7 | fpbase $fp
     *       + koff spilled to 0x10(sp), frame 0x40 = retail.  69 diffs, ours 230 / oracle 231.
     *
     *   RESIDUAL (69), four clusters, NONE of them register allocation any more:
     *    (a) prologue: lever 6's price -- retail sets kon=0 in the hook `beqz` delay slot (shared by
     *        both paths); ours materializes the 0 after the call and copies it (~6 diffs).  Undoing
     *        lever 6 re-ties kon with chan and costs far more.  The clean fix would be ONE more
     *        depth-1 REG_N_REF on kon instead of the range cut (`chan = kon` / `vt = kon` spellings
     *        are cse'd away, measured).
     *    (b) the `vreg0` split-temp costs one `addu s4,a0,zero` retail does not have (2 diffs);
     *        dropping it puts vreg's live length back to 79 and loses $s4 -- coupled to lever 7,
     *        needs a different -1 on vreg's range (the pitch-block swap was tried: 83 diffs).
     *    (c) the cleanup-loop store block: retail interleaves the three `lw 0x510(fp)` reloads with
     *        the sllv/or differently and puts `n--` in the jal delay slot where ours puts the arg
     *        copy (~12 diffs).  Pure sched1/reorg -- the same class the spktplay.c statement-order
     *        sweep cleared this wave, so it is the obvious next target.
     *    (d) `addiu a0,a1,0` vs retail's in-place `addiu a1,a1,0` on the vbase materialization, and
     *        `li v1,1` vs `li v0,1` -- anonymous-temp coalescing (catalog trichotomy case 3).
     *   Saved states: scratchpad/slib_a2_{69,75,regsmatch,parity}.c.
     *
     * 2026-07-27 inline pass -- FIVE more directions FALSIFIED at the 69 form; treat 69 as a hard
     *   local optimum pending a sched1-model tool:
     *   - kon=0 moved BEFORE the hook (fact i, banking on the un-folded guard slt = the "+1
     *     depth-1 ref"): 85 (the callee-saved web rotates, sw s5 appears in the prologue).
     *   - full facts (i)+(ii) (chan=0 inside the guard, vt=chan): 88.
     *   - per-TU -fno-schedule-insns: 73 (this obj IS sched-on; 3d-identity ruled out).
     *   - n-- placement (before call / at join top) and a `freearg = c` join copy: all 69
     *     UNCHANGED -- sched1 canonicalizes: it sinks n-- past the call into the reload_b
     *     latency gap and copy-props the freearg. Cluster (c)'s root: retail's jal ds CONSUMED
     *     n--, so retail's store block had to use li/sllv as latency fillers (kon block early);
     *     ours keeps n-- as a filler and sinks the kon block. The ds choice and the store-block
     *     order are ONE coupled sched1 outcome, not two independent diffs.
     *   - state==3 arm `one <<= chan` in-place shift (matches retail's self-sllv + shared li in
     *     the bnez ds), with and without a trailing `one = 0` carrier: 73 both.
     *
     * ★ W47-a3 2026-08-03 -- 69 -> 58, the LOOP-TAIL BLOCK IS NOW BYTE-EXACT.  NEW NAMED LEVER:
     *   *** A LOOP LATCH THAT STARTS WITH THE COUNTER INCREMENT CANNOT BE EAGER-STOLEN FROM. ***
     *   Retail parks `lui %hi(sndgs+17)` (the %hi half of the loop-bound load) in the delay slots of
     *   all THREE forward guard branches that jump to the loop-continue point, and uses `chan++` as
     *   the bound load's own load-delay filler.  That is reorg's EAGER fill: it duplicates the join
     *   block's FIRST insn into each predecessor's slot and redirects the branch past it.  A `lui`
     *   is safe to execute twice; an `addiu chan,chan,1` is NOT -- so as long as our latch began with
     *   the increment (`chan++; vt += 0x2c;` then the `while` test) reorg had nothing to steal and we
     *   paid three `nop`s plus a load-delay `nop`.
     *   FIX: move the increment INSIDE the condition -- `} while ((int)(unsigned)((struct SndGlobalServerStateView *)sndgs)->channel_count > ++chan);`
     *   -- so the latch starts with the bound load's `lui`.  Operand order is load order (catalog),
     *   so writing `bound > ++chan` (not `++chan < bound`) evaluates the load first; it still emits
     *   `slt chan,bound`.  4 diffs of nop-vs-lui + the load-delay nop disappear, and ours drops the
     *   1 excess insn there (229 vs oracle 231 now; we are 2 SHORT overall, was 1).
     *   FALSIFIED this wave at the 58 basin (all reverted, state the basin when re-testing):
     *     - `kon = 0;` moved BEFORE the hook `if` (fact (i), to get retail's `slt v0,s3,v0` entry
     *       guard + the zero in the hook's beqz delay slot): 74 diffs BUT insn count becomes EXACT
     *       231/231.  posdiff says this is a mirage: structural residual 151/231 with `s5` displaced
     *       to first-use position 1, vs residual 24/231 and an IDENTICAL first-use order for the 58
     *       form.  The 58 form is structurally far closer; do not chase the count.
     *     - cluster (c) fences: `__asm__("")` between the kon block and the +0 store (62 @231),
     *       double fence around the kon block (70 @231), fence before/after `n--` (58/59).  The
     *       fences DO pin issue order but the interleave retail wants (`lw 0x510(fp)` between the
     *       sllv and the or) is destroyed by serializing.  `n--` before the call: 58 (unchanged,
     *       sched1 canonicalizes, confirming the 2026-07-27 note).
     *     - lever 7 re-test (`vp[0x1d] = 0;` moved BACK before the three vreg stores, which IS the
     *       oracle's emission order): 72.  Lever 7 still holds in the new basin -- vreg's live-range
     *       -1 is worth more than the 4 order diffs.
     *
     * W50-a7 2026-08-09 -- HONEST NEW-TOOLKIT PASS at the 58 basin: 9 probes, NOTHING BIT; parked.
 *   The pass targeted the two clusters this note names as source-reachable, with the zero-insn
 *   dials that were NOT yet available when 58 was set (w44 ref-step inflators + the w47 opacity
 *   fence).  All measured at 229/231 unless noted:
 *   Cluster (a) -- 'the clean fix would be ONE more depth-1 REG_N_REF on kon':
 *     `do { kon = 0; } while (0);` depth wrapper 58 (no change) · nested depth-2 wrapper 58 ·
 *     ARM-DUPLICATED `kon = 0;` in both hook arms (w44 inflator #2 -- cross-jump merges the code,
 *     flow counts both refs) 75 @230 · arm-dup + depth wrapper 75 @230 · a `koff = koff;` self-
 *     assignment carrier 58.  ==> the depth wrapper is INERT here: this statement is at loop depth
 *     0 in a function whose competing refs are depth-1/2 weighted, so a x2 on ONE outside-the-loop
 *     ref cannot cross kon's flr2 step.  The 'one more depth-1 ref' the note asks for has no
 *     zero-insn generator at this site -- the only forms that add the ref (arm duplication) also
 *     add the insn.  Treat cluster (a) as needing a reqdelta/allocsim-priced dial, not a spelling.
 *   Cluster (b) -- the `vreg0` split-temp's extra `addu $s4,$a0,$zero`:
 *     dropping vreg0 for a plain assignment 83 @228 · plain + an OPACITY fence on `vreg` 83 @228
 *     (the fence does NOT substitute for the split temp's live-range -1) · split temp + opacity
 *     fence on vreg0 58 (exactly inert) · computing vreg0 BEFORE `vp` 90.  The 2-diff price of
 *     vreg0 is still much cheaper than any alternative; the note's reading stands.
 *
 * 2026-07-27 NFS2-PC AXIS CLOSED for this fn (user-requested check of VA 0x0048c0a8):
     *   nfs2-v1.txt names 0x48c0a8 `iSNDserve_` (FCN VOID) -- the twin EXISTS, but it is a
     *   complete Windows rewrite: the DirectSound ring-buffer pump (COM vtable calls through
     *   DAT_004e18bc -- GetCurrentPosition/Lock/Unlock at +0x24/+0x2c/+0x4c -- play-cursor
     *   chase, 0x32-tick underrun counter, adaptive write-ahead, mixed-audio fills via
     *   FUN_004b00f8).  No voice loop, no kon/koff masks, no per-voice walk: nothing of the
     *   PSX body's structure survives, so no statement order or variable identity transfers.
     *   NOTE: nfsw.IDA.c's sub_48C0A8 is a BROKEN-BOUNDARY stub (`JUMPOUT(0x48C0A5)`) -- use
     *   nfsw.Ghidra.c FUN_0048c0a8 for this one. */
    chan = 0;
    if ((int)kon < ((struct SndGlobalServerStateView *)sndgs)->channel_count) {
        fpbase = base;
        vt = chan;
        for (; chan < ((struct SndGlobalServerStateView *)sndgs)->channel_count; chan++) {
            vp   = D_801479F0 + vt;
            vreg = (unsigned short *)(((struct SndSpuRegisterBasesStateView *)fpbase)->registers.voice_base + chan * 0x10);
            if (*(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->voice_status == 2) {       /* voice stopping */
                if (vreg[6]) {
                    *(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->stop_pending = 1;
                } else {                                             /* SPU ADSR reached 0 */
                    if (((struct SndPacketVoiceState *)vp)->stop_pending && !((struct SndPacketVoiceState *)vp)->link_flag &&
                        (int)((unsigned)((struct SndPacketVoiceState *)vp)->voice_done << 0x18) < 0) {
                        cvt = vt;
                        n = *(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->channel_count;
                        do {
                            int c = chan;
                            if (n == 2) {
                                vbase = D_801479F0;
                                do { vbase++; vbase--; } while (0);
                                c = (int)((unsigned int)*(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->link_index << 24) >> 24;
                                vp = D_801479F0 +
                                     ((int)((unsigned int)*(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->link_index << 24) >> 24) * (int)sizeof(SndPacketVoiceState);
                            } else {
                                vbase = D_801479F0;
                                /* MATCH: using the real +0x1c field symbol and subtracting its field
                                 * offset gives this arm a distinct address pseudo.  GCC can then
                                 * consume its %hi in place (`lui/addiu a1`) instead of keeping the
                                 * shared high half live and forming the low half in v0. */
                                vp = D_80147A0C + cvt - 0x1c;
                            }
                            /* MATCH: both state bytes are asynchronously visible voice state.  The
                             * volatile stores stay before iSNDfreechan; with the decrement left in
                             * the loop latch, reorg selects `--n` for the jal delay slot.  This paired
                             * basin changed 9 -> 4 diffs; the distinct +0x1c alias above changed 4 ->
                             * PASS (231/231).  Making only the second byte volatile stalled at 17. */
                            *(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->voice_status = 0;
                            *(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->play_state = 0;
                            iSNDfreechan(c);
                            *(unsigned short *)(c * 0x10 + (unsigned char *)((struct SndSpuRegisterBasesStateView *)fpbase)->registers.voice_base + 6) = 0x200;
                            onec = 1;
                            kon |= onec << c;
                            onec = 0;
                            *(unsigned short *)(c * 0x10 + (unsigned char *)((struct SndSpuRegisterBasesStateView *)fpbase)->registers.voice_base) = 0;
                            *(unsigned short *)(c * 0x10 + (unsigned char *)((struct SndSpuRegisterBasesStateView *)fpbase)->registers.voice_base + 2) = 0;
                        /* Keep the decrement in the latch; the volatile state stores above make it
                         * the retail jal-delay-slot candidate without changing the loop semantics. */
                        } while (0 < --n);
                    }
                }
                if (((struct SndPacketVoiceState *)vp)->pitch_dirty) {                                 /* pitch dirty -> reprogram */
                    vreg[2] = (short)(((struct SndPacketVoiceState *)vp)->position_step / 0x1b9);
                    ((struct SndPacketVoiceState *)vp)->pitch_dirty = 0;
                }
                if (*(volatile int *)&((struct SndPacketVoiceState *)vp)->served_position > 0) {              /* advance play position */
                    *(volatile int *)&((struct SndPacketVoiceState *)vp)->served_position = *(volatile int *)&((struct SndPacketVoiceState *)vp)->served_position -
                                                   *(volatile int *)&((struct SndPacketVoiceState *)vp)->position_step;
                } else {
                    *(volatile int *)&((struct SndPacketVoiceState *)vp)->byte_position = *(volatile int *)&((struct SndPacketVoiceState *)vp)->byte_position +
                                                  *(volatile int *)&((struct SndPacketVoiceState *)vp)->position_step;
                    if (*(volatile unsigned int *)&((struct SndPacketVoiceState *)vp)->byte_position >=
                        *(volatile unsigned int *)&((struct SndPacketVoiceState *)vp)->loop_length) {
                        if ((int)((unsigned)((struct SndPacketVoiceState *)vp)->voice_done << 0x18) >= 0)
                            *(volatile int *)&((struct SndPacketVoiceState *)vp)->byte_position = *(volatile int *)&((struct SndPacketVoiceState *)vp)->byte_position -
                                                          *(volatile int *)&((struct SndPacketVoiceState *)vp)->loop_length;
                        else
                            *(volatile int *)&((struct SndPacketVoiceState *)vp)->byte_position = *(volatile int *)&((struct SndPacketVoiceState *)vp)->loop_length;
                    }
                }
            } else if (*(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->voice_status == 3) { /* voice fully stopped */
                if (!vreg[6]) {
                    one = 1;
                    kon |= one << chan;              /* (Ghidra `mask`) */
                    ((struct SndPacketVoiceState *)vp)->voice_status = 0;
                    vreg[3] = 0x200;
                    vreg[0] = 0;
                    vreg[1] = 0;
                } else {
                    one = 1;
                    koff |= one << chan;            /* (Ghidra `local_30`) */
                }
                one = 0;
            }
            /* NOTE: no `vp = &DAT_801479f0 + vt;` re-materialize here -- the oracle reuses whatever
             * $s0 currently holds (the outer voice's vp on every path EXCEPT after the n==2 linked
             * cleanup ran, where it deliberately reads the LAST freed channel's row here; byte-exact
             * behavior, not a bug to "fix"). */
            /* Keep the adjacent +0x1C/+0x1D probe in byte-offset form: spelling both as struct
             * fields split the matched halfword load into two byte loads (+6 oracle diffs). */
            if (((struct SndPacketVoiceState *)vp)->play_state == 1 && !vp[0x1d] &&
                ((unsigned char)((struct SndPacketVoiceState *)vp)->channel_count < 2 ||
                 !(((struct SndPacketVoiceState *)(fpbase + 0xD8))[
                    ((int)((unsigned int)*(volatile unsigned char *)&((struct SndPacketVoiceState *)vp)->link_index << 24) >> 24)
                 ].voice_status))) {
                kon = kon | iSNDstartvoice(chan);                    /* arm newly-triggered voice */
            }
            vt += (int)sizeof(SndPacketVoiceState);
            /* MATCH (w47-a3): the counter increment lives INSIDE the condition, evaluated AFTER the
             * bound load, so the loop-latch block STARTS with `lui %hi(sndgs+17)`.  A duplicable
             * `lui` at the join is what lets gcc's reorg EAGER-STEAL it into the three forward
             * guard branches' delay slots (retail has `lui v0,0` in all three; a leading
             * `addiu chan,chan,1` can never be stolen -- it would increment twice -- so we got
             * `nop`s).  Operand order `bound > ++chan` (not `++chan < bound`) puts the load first
             * (catalog: compare-operand order IS evaluation/load order) and still emits
             * `slt chan,bound`. */
        }
    }
    if (koff)
        iSNDpsxkeyoff(koff);
    do {
        if (kon)
            iSNDpsxkeyon(kon);
    } while (0);
}
