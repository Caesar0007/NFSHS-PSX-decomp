/* eaclib/psx/sndpsxz/slib.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/5 PASS ***
 *   Source obj : nfs4\eaclib\psx\slib.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   5 fns @[0x800FF5A8 .. 0x800FFAF4].  The PSX SPU sound-system: boot init (iSNDinit), teardown
 *   (iSNDrestore), the per-frame voice driver (iSNDserve), and the output-format caps/apply.
 *   Ghidra nfs4-f.exe.c (slib) + disasm-v3 for dropped args / offset fixes:
 *     iSNDinit's iSNDdmqueue is 5-arg (ram,spu,len,prio,flag)=(&DAT_80136df0,0x1000,0x10,1,0); addtimer/
 *     deltimer/addexit are 1-arg (Ghidra `in_a1` was register leftover); addexit(SNDSYS_restore@0x800f204c);
 *     SPU master-vol offset is +0x180/+0x182 (Ghidra decompiled +0x60 wrongly); outputset's iSNDsetvol is
 *     3-arg (chan, (s8)L-cache@+0x24, (s8)R-cache@+0x25).
 *
 *   SPU hardware regs (libspu): DPCR, SPU_MAIN_VOL, SPUSTAT, D4_xxx, VOICE_00_LEFT_RIGHT etc -- addresses
 *   are latched into DAT_80147e14..2c (the DMA + SPU register pointers the rest of the sound code uses).
 */

extern int            sndgs[];
extern unsigned char  sndpd[];              /* voice/queue state base @0x80147918 (unsized array: forces
                                              * base+offset addressing instead of folding &sndpd+const into
                                              * one absolute %lo load -- see sdpacket.c/spatkey.c precedent) */
#define DAT_80147919 (sndpd[1])              /* pre-load guard == sndpd+1 */
#define snd_old_chan_mode (sndpd[2])         /* last applied channel-mode byte */
#define DAT_8014791c (*(int *)(sndpd + 4))   /* current fx mode == sndpd+4 */
extern unsigned char  sndpdsafeloop;        /* DMA scratch RAM (zeroed) @0x80136DF0, per configs/symbol_addrs.txt
                                              * (oracle references this real symbol name directly, not a bare VA) */
unsigned char sndpdsafeloop;                /* def (owning TU; @0x80136df0 image-verified zero; head byte of the 0x10-byte DMA-clear source region) */
extern void          *snd_user_serve_hook;  /* @0x80148038              */

/* voice-table fields (0x2c stride) -- all live INSIDE the sndpd block (same struct as sdpacket.c) */
#define DAT_801479f0 (sndpd[0xD8])           /* +0x00 voice base (int fields via &+off) */
#define DAT_80147a0c (sndpd[0xF4])           /* +0x1c playstate */
#define DAT_80147a0d (sndpd[0xF5])           /* +0x1d substate  */
#define DAT_80147a0f (sndpd[0xF7])           /* +0x1f channels  */
#define DAT_80147a10 (sndpd[0xF8])           /* +0x20 link      */
#define DAT_80147a11 (sndpd[0xF9])           /* +0x21 link flag */
#define DAT_80147a14 (sndpd[0xFC])           /* +0x24 L cache   */
#define DAT_80147a15 (sndpd[0xFD])           /* +0x25 R cache   */
#define DAT_80147a16 (sndpd[0xFE])           /* +0x26 flag      */
#define DAT_80147a17 (sndpd[0xFF])           /* +0x27 voice-done */

/* SPU/DMA register pointers latched by iSNDinit (consumed by sdma/spatkey) -- also inside sndpd block */
#define DAT_80147e14 (*(unsigned int **)(sndpd + 0x4FC))
#define DAT_80147e18 (*(unsigned int **)(sndpd + 0x500))
#define DAT_80147e1c (*(unsigned int **)(sndpd + 0x504))
#define DAT_80147e20 (*(unsigned int **)(sndpd + 0x508))
#define DAT_80147e24 (*(unsigned int **)(sndpd + 0x50C))
#define DAT_80147e28 (*(int *)(sndpd + 0x510))        /* SPU voice reg base (address) */
#define DAT_80147e2c (*(int *)(sndpd + 0x514))        /* SPU control reg base (address) */

/* sdmemman/sdmemlu fields -- oracle iSNDinit writes these as sndpd-RELATIVE offsets (+0x51a/+0x51c off
 * the &sndpd already in a register), NOT via their own %hi/%lo symbol.
 *
 * SPLIT-STORAGE FIX (wave-22 a1, RESOLVED): sdmemlu.c used to independently DEFINE
 * snd_spu_engine_ver/snd_spu_block_total as ordinary externs (own linker-placed storage) -- a genuine
 * aliasing bug where iSNDinit's writes here and sdmemlu/sdmemman's reads would NOT share storage in a
 * real link. sdmemlu.c, sdmemman.c, and sdfx.cpp were all converted to the same sndpd-relative
 * macro-view model this file already used, so the field names below now genuinely alias with every
 * other reader/writer tree-wide (see sdmemlu.c's banner for the cross-file proof). No change needed
 * in THIS file -- it was already sndpd-relative. */
#define DAT_80147e32 (*(unsigned short *)(sndpd + 0x51a))   /* snd_spu_engine_ver alias (sdmemman) */
#define DAT_80147e34 (*(unsigned short *)(sndpd + 0x51c))   /* snd_spu_block_total alias (sdmemlu)  */

/* libspu hardware registers (memory-mapped, PSX SPU @0x1F801C00 + DMA4/DPCR).  These are REAL literal
 * addresses (not relocatable program symbols) -- the oracle loads them via lui+ori 32-bit immediates,
 * NOT lui+addiu %hi/%lo(SYM) relocations.  Modeling them as `extern` variables (previous form) is a
 * real codegen bug: gcc then emits a symbol relocation instead of the literal constant, and the two
 * forms are NOT byte-identical (this cost iSNDinit ~20 instructions of near-miss).  #define as literal
 * MMIO pointers instead, matching the established convention elsewhere in the tree (libetc/INTR.cpp,
 * libpress/LIBPRESS.c DPCR). */
#define DPCR                       (*(volatile unsigned int   *)0x1F8010F0)
#define SPU_DELAY                  (*(volatile unsigned int   *)0x1F801014)
#define D4_MADR                    (*(volatile unsigned int   *)0x1F8010C0)
#define D4_BCR                     (*(volatile unsigned int   *)0x1F8010C4)
#define D4_CHCR                    (*(volatile unsigned int   *)0x1F8010C8)
#define VOICE_00_LEFT_RIGHT        (*(volatile unsigned int   *)0x1F801C00)
/* The pre-latch SPU_MAIN_VOL_L/R + SPUCNT/SPUSTAT accesses go through a RUNTIME POINTER VARIABLE
 * (below, `spu`) rather than their own independent literal macro: gcc-2.8 -O2 does NOT constant-fold
 * "(T*)LITERAL + LITERAL_OFFSET" back into one fresh absolute address the way it would for two
 * separately-named #define'd constants -- it keeps the pointer VALUE in a register and reuses it via
 * a load/store DISPLACEMENT (same class of lever as the sndpd/DAT_80147e2c base-sharing elsewhere in
 * this file). An independently #define'd 0x1F801D80 etc. re-materializes its OWN lui+ori every access. */
#define SPU_MAIN_VOL_L_AT(b)       (*(volatile short          *)((char *)(b) + 0x180))
#define SPU_MAIN_VOL_R_AT(b)       (*(volatile short          *)((char *)(b) + 0x182))
#define SPUCNT_AT(b)               (*(volatile unsigned short *)((char *)(b) + 0x1aa))
#define SPUSTAT_AT(b)              (*(volatile unsigned short *)((char *)(b) + 0x1ae))

/* SPU control-cluster fields (0x180..0x1B6 off the SPU base) -- oracle accesses ALL of these through
 * the LATCHED pointer DAT_80147e2c (sndpd+0x514), reloading it fresh at each access, not via their own
 * symbol -- same "base already in a register" convention as the reverb/master-vol writes below. */
#define SPUCNT_F                   (*(volatile unsigned short *)(DAT_80147e2c + 0x1aa))
#define SOUND_RAM_XFER_CTRL_F      (*(volatile unsigned short *)(DAT_80147e2c + 0x1ac))
#define SPU_VOICE_CHN_FM_MODE_L_F  (*(volatile unsigned short *)(DAT_80147e2c + 0x190))
#define SPU_VOICE_CHN_FM_MODE_H_F  (*(volatile unsigned short *)(DAT_80147e2c + 0x192))
#define SPU_VOICE_CHN_NOISE_MODE_L_F (*(volatile unsigned short *)(DAT_80147e2c + 0x194))
#define SPU_VOICE_CHN_NOISE_MODE_H_F (*(volatile unsigned short *)(DAT_80147e2c + 0x196))
#define CD_VOL_L_F                 (*(volatile unsigned short *)(DAT_80147e2c + 0x1b0))
#define CD_VOL_R_F                 (*(volatile unsigned short *)(DAT_80147e2c + 0x1b2))
#define EXT_VOL_L_F                (*(volatile unsigned short *)(DAT_80147e2c + 0x1b4))
#define EXT_VOL_R_F                (*(volatile unsigned short *)(DAT_80147e2c + 0x1b6))

/* dependencies */
extern unsigned int iSNDpsxkeyon(int mask);                   /* spatkey */
extern int          iSNDpsxkeyoff(int mask);                  /* spatkey */
extern void iSNDsetvol(int chan, int left, int right);/* spatkey */
extern unsigned int iSNDstartvoice(unsigned int chan);       /* spatkey */
extern void         iSNDfreechan(int chan);                  /* salloc  */
extern unsigned int iSNDpsxfxinit(int mode);                 /* sdfx    */
extern void         iSNDserver(void);                        /* sserver */
extern void         iSNDleaveaudio(void);                    /* sserver */
extern int          iSNDdmqueue(int ram, unsigned int spu, int len, int prio, int flag); /* sdma */
extern int          DMACallback(int ch, int func);            /* libetc INTR.obj @0x800F28AC -- Ghidra/our
                                                                * previous decl dropped BOTH real args (channel,
                                                                * new-callback-fn); see cdcont.cpp/SYS.cpp for
                                                                * the true signature used tree-wide */
extern void         iSNDdmcallback(void);                    /* sdma -- installed as the DMA4 callback */
extern int          addtimer(int callback);                  /* addtimer */
extern int          deltimer(int callback);                  /* addtimer */
extern int          addexit(int handler);                    /* exit     */
extern void         SNDSYS_service(void);                    /* ssysserv */
extern void         SNDSYS_restore(void);                    /* ssysinit (exit handler) */

extern int  iSNDplatformoutputcaps(void);   /* @0x800FF5A8 -- oracle explicitly zeroes $v0 before return */
extern int  iSNDplatformoutputset(void);    /* @0x800FF600 */
extern int  iSNDinit(void);                 /* @0x800FF700 */
extern int  iSNDrestore(void);              /* @0x800FF9A0 */
extern void iSNDserve(void);                /* @0x800FFAF4 */

#define SCB(i) (((char *)sndgs)[i])
#define SUB(i) (((unsigned char *)sndgs)[i])
#define SSH(i) (((short *)sndgs)[i])
#define SUSH(i) (((unsigned short *)sndgs)[i])

/* cop0 Status read/write (interrupts masked around the hardware-register pokes; host: plain). */
#if defined(__mips__)
static inline unsigned int rd_sr(void) { unsigned int s; __asm__ volatile("mfc0 %0,$12" : "=r"(s)); return s; }
static inline void wr_sr(unsigned int s) { __asm__ volatile("mtc0 %0,$12" : : "r"(s)); }
/* CP0 transaction shim: keep the DMA channel in $a0 across the status-register
 * mask and spell the required R3000 load/write hazard slots explicitly. */
#define DECLARE_DMA_CHANNEL(name) register int name __asm__("$4")
#define DECLARE_DMA_CALLBACK(name) register int name __asm__("$5")
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
        : "=r"(sr), "+r"(channel) : : "$1", "$8", "memory")
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
        : "=r"(sr), "+r"(channel), "+r"(callback) : : "$1", "$8", "memory")
#else
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#define DECLARE_DMA_CHANNEL(name) int name
#define DECLARE_DMA_CALLBACK(name) int name
#define MASK_SR_FOR_DMA(sr, channel) do { (sr) = rd_sr(); wr_sr((sr) & 0xfffffbfe); } while (0)
#define MASK_SR_FOR_DMA_CALLBACK(sr, channel, callback) MASK_SR_FOR_DMA(sr, channel)
#endif

/* iSNDplatformoutputcaps @0x800FF5A8 : publish this platform's output capabilities into sndgs (44.1 kHz,
 *   24 SPU voices, stereo). */
extern int iSNDplatformoutputcaps(void)
{
    unsigned char *base = (unsigned char *)sndgs;   /* materialize bare &sndgs first (oracle: no offset folded into %lo) */
    base[7] = 0;  base[8] = 0;  base[9] = 0;  base[6] = 0x18;
    *(unsigned short *)(base + 0) = 0xac44;  base[4] = 1;  *(unsigned short *)(base + 2) = 0xac44;  base[5] = 2;
    base[0x13] = 0;  base[0x14] = 0;  base[0x12] = 0;  base[0x11] = 0x18;
    *(unsigned short *)(base + 0xE) = 0xac44;  base[0x10] = 2;
    return 0;
}

/* iSNDplatformoutputset @0x800FF600 : apply the requested output channel count (clamped to caps), and if the
 *   mode changed while audio is up, re-push every playing voice's L/R volume. */
extern int iSNDplatformoutputset(void)
{
    unsigned char *base;    /* &sndgs, CALLER-saved live range (pre-loop field checks only) --
                              * matches iSNDplatformoutputcaps' PASSing lever; SCB(0x11)=0x18 as
                              * the FIRST textual access anchors the compiler's base pointer AT
                              * offset 0x11 (all other accesses become NEGATIVE displacements from
                              * a shifted base), so the reads are ordered BEFORE the 0x11 write to
                              * anchor at offset 0 instead (POSITIVE displacements) -- see
                              * wave-20/wave-21 notes */
    unsigned char *vbase;
    unsigned char *vp;       /* WALKING &sndpd+0xd8 pointer (voice-table row base), +=0x2c per
                               * iter -- matches iSNDserve's established `vp = &DAT_801479f0 + vt`
                               * lever: keeps the 4 field accesses (0x1c/0x21/0x24/0x25) as load
                               * DISPLACEMENTS off ONE walking base instead of 4 separately-folded
                               * &DAT_80147a0x constant bases */
    int chan;
    base = (unsigned char *)sndgs;
    base[0x11] = 0x18;
    if (base[0x10] < base[4])   base[0x10] = base[4];
    if (base[5] < base[0x10])   base[0x10] = base[5];
    if (*(signed char *)(base + 0x3c) != 0 && snd_old_chan_mode != base[0x10]) {  /* oracle: lb v0,0x3C(a0)
                                                                                    * -- offset 0xf was wrong;
                                                                                    * needs a genuinely SIGNED
                                                                                    * load (`char` reads as
                                                                                    * unsigned on this build,
                                                                                    * a cast-after-load doesn't
                                                                                    * change the lbu->lb) */
        chan = 0;
        vbase = base;
        vp = &DAT_801479f0;
    voiceloop:
        {
            /* goto-loop (catalog §B): a label+goto back-edge carries no NOTE_INSN_LOOP_BEG, so
             * loop.c never runs on this body -- that is what stops gcc hoisting the literal 2 of
             * the state compare into a callee-saved reg ($s2, which the oracle needs for the
             * persistent sndgs base) and reproduces the oracle's per-iteration
             * `addiu v0,zero,2` remat in the lbu's load-delay slot. */
            if (*(volatile unsigned char *)(vp + 0x1c) == 2) {
                if (*(volatile unsigned char *)(vp + 0x21) == 0) {
                    iSNDsetvol(chan,
                        ((int)*(volatile unsigned char *)(vp + 0x24) << 24) >> 24,
                        ((int)*(volatile unsigned char *)(vp + 0x25) << 24) >> 24);
                }
            }
            vp += 0x2c;
            /* Preincrement makes the channel-count load precede the counter increment. */
            if (++chan < (int)(unsigned)vbase[0x11]) goto voiceloop;
        }
    }
    snd_old_chan_mode = SUB(0x10);   /* FRESH re-read, not through `base` -- oracle re-materializes
                                       * this via its own %hi/%lo AFTER the epilogue register
                                       * restores, so `base`'s live range must END at the if-check
                                       * above, not extend across the loop/call to here */
    return 0;
}

/* iSNDinit @0x800FF700 : bring up the SPU -- enable DMA4, zero the SPU voice/main/CD/ext volumes, latch the
 *   DMA + SPU register addresses, key-off all voices, set master volume, apply the fx preset, and install
 *   the audio timer + exit handler. */
extern int iSNDinit(void)
{
    struct InitWaitSpu {
        unsigned char pad[0x1ae];
        volatile unsigned short status;
    };
    unsigned int sr;
    DECLARE_DMA_CHANNEL(ch);      /* DMACallback channel arg (4), materialized early like the oracle */
    DECLARE_DMA_CALLBACK(callback);
    volatile unsigned int *delay;
    volatile unsigned int *madr;
    volatile unsigned int *bcr;
    volatile unsigned int *chcr;
    volatile unsigned int *dpcr;
    unsigned int *spu;    /* runtime copy of the SPU base (0x1F801C00) */
    struct InitWaitSpu *wait_spu;
    unsigned char *pd;
    unsigned char *latched;
    unsigned char *gs;
    unsigned char *loop_gs;
    unsigned char *loop_pd;
    unsigned char *post;
    int postmask_spu;
    int post_ctrl;
    int pitch;
    int done;
    unsigned short master;
    int vp;               /* walking sndpd address for the "mark voice done" byte */
    int i;

    delay = (volatile unsigned int *)0x1f801014;
    madr = (volatile unsigned int *)0x1f8010c0;
    bcr = (volatile unsigned int *)0x1f8010c4;
    chcr = (volatile unsigned int *)0x1f8010c8;
    dpcr = (volatile unsigned int *)0x1f8010f0;
    spu = (unsigned int *)0x1f801c00;
    pd = sndpd;
    *(unsigned short *)(pd + 0x51a) = 0x41;
    *dpcr = *dpcr | 0xb0000;
    SPU_MAIN_VOL_L_AT(spu) = 0;
    SPU_MAIN_VOL_R_AT(spu) = 0;
    SPUCNT_AT(spu) = 0;                      /* early clear (pre-latch) */
    SPU_MAIN_VOL_L_AT(spu) = 0;              /* oracle writes both master-vol halves TWICE */
    SPU_MAIN_VOL_R_AT(spu) = 0;
    *(unsigned short *)(pd + 0x51c) = 0x2000;
    *(volatile unsigned int **)(pd + 0x4fc) = delay;
    *(volatile unsigned int **)(pd + 0x500) = madr;
    *(volatile unsigned int **)(pd + 0x504) = bcr;
    *(volatile unsigned int **)(pd + 0x508) = chcr;
    *(volatile unsigned int **)(pd + 0x50c) = dpcr;
    *(unsigned int **)(pd + 0x510) = spu;
    *(unsigned int **)(pd + 0x514) = spu;
    if ((SPUSTAT_AT(spu) & 0x7ff) != 0) {
        do {
            wait_spu = (struct InitWaitSpu *)0x1f801c00;
        } while ((wait_spu->status & 0x7ff) != 0);
    }
    latched = sndpd;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x1ac) = 4;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x190) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x192) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x194) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x196) = 0;
    ch = 4;   /* DMACallback channel arg, materialized early (matches oracle's early a0=4) */
    callback = (int)iSNDdmcallback;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x1b0) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x1b2) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x1b4) = 0;
    postmask_spu = *(volatile int *)(latched + 0x514);
    MASK_SR_FOR_DMA_CALLBACK(sr, ch, callback);
    *(volatile unsigned short *)(postmask_spu + 0x1b6) = 0;
    *(volatile unsigned short *)(*(volatile int *)(latched + 0x514) + 0x1aa) = 0xc000;
    DMACallback(ch, callback);               /* install the real DMA4 (SPU) callback */
    wr_sr(sr);
    iSNDdmqueue((int)&sndpdsafeloop, 0x1000, 0x10, 1, 0);     /* clear first SPU page */

    i = 0;
    gs = (unsigned char *)sndgs;
    if (gs[0x11] != 0) {
        pitch = 0x200;
        done = -1;
        loop_pd = latched;
        loop_gs = gs;
        vp = (int)latched;
        do {
            int vr = *(volatile int *)(loop_pd + 0x510) + i * 0x10;
            *(short *)(vr + 0) = 0;
            *(short *)(vr + 2) = 0;
            *(short *)(vr + 4) = 0;
            *(short *)(vr + 6) = pitch;
            *(short *)(vr + 0xe) = pitch;
            *(short *)(vr + 8) = 0;
            *(short *)(vr + 0xa) = 0;
            i++;
            *(signed char *)(vp + 0xff) = done;             /* mark voice done */
            vp += 0x2c;
        } while (i < (int)(unsigned)loop_gs[0x11]);
    }
    iSNDpsxkeyon(0xffffff);
    post = sndpd;
    *(volatile unsigned short *)(*(volatile int *)(post + 0x514) + 0x1a2) = 0xfffe;
    master = 0x3fff;
    *(volatile unsigned short *)(*(volatile int *)(post + 0x514) + 0x180) = master;
    *(volatile unsigned short *)(*(volatile int *)(post + 0x514) + 0x182) = master;
    post_ctrl = *(volatile int *)(post + 0x514);
    *(volatile unsigned short *)(post_ctrl + 0x1aa) =
        *(volatile unsigned short *)(post_ctrl + 0x1aa) | 1;
    iSNDpsxfxinit(*(int *)(post + 4));
    *(volatile unsigned char *)(post + 1) = 0;
    addtimer((int)iSNDserver);
    if (sndpd[0] == 0) {
        addexit((int)SNDSYS_restore);
        sndpd[0] = 1;
    }
    return 0;
}

/* iSNDrestore @0x800FF9A0 : tear the SPU back down -- unwind the audio lock, let all voices fade past their
 *   release, drop the audio timer, clear the fx, and re-arm the DMA callback. */
extern int iSNDrestore(void)
{
    struct RestoreVoice {
        unsigned char pad[0xf5];
        unsigned char active;
    };
    unsigned char *guard;
    unsigned char *gpraw;
    unsigned char *gp;       /* &sndgs, INDEPENDENTLY re-materialized for the rest of the fn --
                               * shared for BOTH the 0x11 channel-count byte AND the 0x44 ticks
                               * int (oracle keeps ONE base reg (s3) for both instead of
                               * re-deriving per access), but is a SEPARATE live range from `p`
                               * above (oracle re-does the lui/addiu a second time here) */
    unsigned char *base;     /* &sndpd, materialized ONCE (function scope, before the outer
                               * do-while) -- the oracle keeps this INVARIANT copy in its own
                               * persistent reg (s5) separate from the per-iter walker, so the
                               * walker resets from a plain base + the 0xf5 field stays a load
                               * DISPLACEMENT instead of folding &sndpd+0xf5 into one constant */
    struct RestoreVoice *vp; /* WALKING sndpd pointer (reset from base each outer pass, +=0x2c
                               * per inner iter) */
    int          quiet;
    int          chan;
    unsigned int deadline;
    unsigned int sr;
    DECLARE_DMA_CHANNEL(dma);

    guard = (unsigned char *)sndgs;
    if (guard[0x3f] != 0) {
        unsigned char *waitBase = guard;
        do {
            iSNDleaveaudio();
        } while (waitBase[0x3f] != 0);
    }
    gpraw = (unsigned char *)sndgs;
    deadline = *(unsigned int *)(gpraw + 0x44) + 100;
    gp = gpraw;
    base = sndpd;
    do {
        quiet = 1;
        vp = (struct RestoreVoice *)base;
        chan = 0;
        if (gp[0x11] != 0) {
            do {
                if (*(volatile unsigned char *)((unsigned char *)vp + 0xf5) != 0) { /* voice still active */
                    if (deadline < *(unsigned int *)(gp + 0x44)) {
                        iSNDpsxkeyoff(0xffffff);
                        *(volatile unsigned char *)((unsigned char *)vp + 0xf5) = 0;
                        iSNDfreechan(chan);
                    }
                    quiet = 0;
                }
                vp = (struct RestoreVoice *)((unsigned char *)vp + 0x2c);
            } while ((int)(unsigned)gp[0x11] > ++chan);
        }
        SNDSYS_service();
    } while (!quiet);
    deltimer((int)iSNDserver);
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
extern void iSNDserve(void)
{
    unsigned int koff;         /* local_30 : key-off mask deferred until DMA settles */
    unsigned int kon;          /* mask     : key-on mask */
    unsigned short *vreg;
    int          chan, vt, n, cvt;
    int          onec, one;
    unsigned char *vp;
    unsigned char *base;
    unsigned char *fpbase;    /* &sndpd, materialized ONCE right before the loop and kept LIVE across
                                * the whole loop (matches iSNDinit/iSNDrestore's persistent-base lever,
                                * oracle reg $fp) -- every plain sndpd-relative field access that is
                                * NOT relative to the CURRENT voice pointer `vp` (the SPU voice-reg-base
                                * dereference @+0x510, and the linked-voice-done probe @+0xF5+cvt) goes
                                * through this cached base instead of re-materializing sndpd's own
                                * %hi/%lo every time. */

    chan = 0;
    *(volatile unsigned int *)&koff = 0;
    base = sndpd;
    kon = 0;
    if (*(int *)(base + 0x720) != 0)
        (*(void (*)(void))*(int *)(base + 0x720))();

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
     *          if ((int)kon < (int)(unsigned)SUB(0x11)) { chan = 0; fpbase = base; vt = chan;
     *              do { ...body... } while (chan < (int)(unsigned)SUB(0x11)); }
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
     * 🔴 W35-a2 2026-07-26 -- THE ABOVE "-dL COST-MODEL FLOOR" VERDICT IS **WRONG**; 101 -> 79.
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
     *   RESIDUAL (79 diffs, ours 228 / oracle 231): `cvt` currently prices at 3*8/27 = 0.889 and
     *   takes $s3, rotating {kon,chan} one slot up ($s5/$s6 instead of $s3/$s5).  It needs a
     *   priority in (0.19, 0.47) -- i.e. refs 8 -> 4-5, or live_length 27 -> ~51-125.  Moving its
     *   def earlier (3 positions tried: outer-loop top / state==2 entry / ADSR-guard entry) does
     *   NOT lengthen it -- gcc sinks the copy back to the inner pre-header.  The SPLIT form
     *   (`vp = &DAT+cvt` in an explicit else arm, `vp = &DAT+c*0x2c` in the n==2 arm) DOES price
     *   cvt at 0.256 -> $s6 and gives the COMPLETE retail register map at EXACT parity 231/231 --
     *   but it makes &DAT_801479f0 a 3-site invariant that gcc then hoists into one caller-saved
     *   pseudo, forcing a caller-save spill slot (frame 72 vs 64) and costing more than it wins
     *   (128 diffs).  So the remaining lever is: keep the split form AND stop gcc hoisting
     *   `&DAT_801479f0` (retail rematerializes `lui/addiu %hi/%lo(D_801479F0)` at all THREE sites).
     *   That is the single next experiment; `-mno-split-addresses` per-TU is the obvious candidate
     *   but needs a whole-TU sweep (4 other fns in this file PASS).  Saved states for the next
     *   pass: scratchpad/slib_a2_{79,regsmatch,parity}.c (79 / 128-with-full-map / 231-parity). */
    fpbase = base;
    vt = 0;
    if ((int)kon < (int)(unsigned int)SUB(0x11)) {
        do {
            unsigned short *vreg0; /* split-temp: computed then copied into `vreg` -- a permuter basin find
                               * that shaved one more insn off the register-coloring residual */
            vp   = &DAT_801479f0 + vt;
            vreg0 = (unsigned short *)(*(int *)(fpbase + 0x510) + chan * 0x10);
            vreg = vreg0;
            if (*(volatile unsigned char *)(vp + 0x1d) == 2) {       /* voice stopping */
                if (vreg[6] != 0) {
                    *(volatile unsigned char *)(vp + 0x26) = 1;
                } else {                                             /* SPU ADSR reached 0 */
                    if (vp[0x26] != 0 && vp[0x21] == 0 &&
                        (int)((unsigned)vp[0x27] << 0x18) < 0) {
                        cvt = vt;
                        n = (int)(unsigned)*(volatile unsigned char *)(vp + 0x1f);
                        do {
                            int c = chan;
                            if (n == 2) {
                                c = (int)((unsigned int)*(volatile unsigned char *)(vp + 0x20) << 24) >> 24;
                                cvt = ((int)((unsigned int)*(volatile unsigned char *)(vp + 0x20) << 24) >> 24) * 0x2c;
                            }
                            vp = &DAT_801479f0 + cvt;
                            vp[0x1d] = 0;
                            *(volatile unsigned char *)(vp + 0x1c) = 0;
                            iSNDfreechan(c);
                            n--;
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510) + 6) = 0x200;
                            onec = 1;
                            kon = kon | (onec << c);
                            onec = 0;
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510)) = 0;
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510) + 2) = 0;
                        } while (0 < n);
                    }
                }
                if (vp[0x28] != 0) {                                 /* pitch dirty -> reprogram */
                    vreg[2] = (short)(*(unsigned int *)(vp + 8) / 0x1b9);
                    vp[0x28] = 0;
                }
                if (*(volatile int *)(vp + 0x10) > 0) {              /* advance play position */
                    *(volatile int *)(vp + 0x10) = *(volatile int *)(vp + 0x10) -
                                                   *(volatile int *)(vp + 8);
                } else {
                    *(volatile int *)(vp + 0xc) = *(volatile int *)(vp + 0xc) +
                                                  *(volatile int *)(vp + 8);
                    if (*(volatile unsigned int *)(vp + 0xc) >=
                        *(volatile unsigned int *)(vp + 0x14)) {
                        if ((int)((unsigned)vp[0x27] << 0x18) >= 0)
                            *(volatile int *)(vp + 0xc) = *(volatile int *)(vp + 0xc) -
                                                          *(volatile int *)(vp + 0x14);
                        else
                            *(volatile int *)(vp + 0xc) = *(volatile int *)(vp + 0x14);
                    }
                }
            } else if (*(volatile unsigned char *)(vp + 0x1d) == 3) { /* voice fully stopped */
                one = 1;
                if (vreg[6] == 0) {
                    kon = kon | (one << chan);              /* (Ghidra `mask`) */
                    vp[0x1d] = 0;
                    vreg[3] = 0x200;
                    vreg[0] = 0;
                    vreg[1] = 0;
                } else {
                    koff = koff | (one << chan);            /* (Ghidra `local_30`) */
                }
                one = 0;
            }
            /* NOTE: no `vp = &DAT_801479f0 + vt;` re-materialize here -- the oracle reuses whatever
             * $s0 currently holds (the outer voice's vp on every path EXCEPT after the n==2 linked
             * cleanup ran, where it deliberately reads the LAST freed channel's row here; byte-exact
             * behavior, not a bug to "fix"). */
            if (vp[0x1c] == 1 && vp[0x1d] == 0 &&
                ((unsigned char)vp[0x1f] < 2 ||
                 fpbase[0xf5 +
                    (((int)((unsigned int)*(volatile unsigned char *)(vp + 0x20) << 24) >> 24) * 0x2c)] == 0)) {
                kon = kon | iSNDstartvoice(chan);                    /* arm newly-triggered voice */
            }
            chan++;
            vt += 0x2c;
        } while (chan < (int)(unsigned int)SUB(0x11));
    }
    if (koff != 0)
        iSNDpsxkeyoff((int)koff);
    if (kon != 0)
        iSNDpsxkeyon((int)kon);
}
