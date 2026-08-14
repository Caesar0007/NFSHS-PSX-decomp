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
 *   SPU hardware regs (libspu): DPCR, SPU_MAIN_VOL, SPUSTAT, D4_xxx, VOICE_00_LEFT_RIGHT etc -- addresses
 *   are latched into DAT_80147e14..2c (the DMA + SPU register pointers the rest of the sound code uses).
 */

extern int            sndgs[];
extern unsigned char  sndpd[];              /* voice/queue state base @0x80147918 (unsized array: forces
                                              * base+offset addressing instead of folding &sndpd+const into
                                              * one absolute %lo load -- see sdpacket.c/spatkey.c precedent) */
extern unsigned char  D_801479F0[];         /* exact voice-table-base linker symbol; iSNDserve's
                                              * retail relocations name this object directly */
extern unsigned char  D_80147A0C[];         /* same table's +0x1c state field; exact-VA alias is in
                                              * linkers/undefined_syms_auto.txt */
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
    unsigned char *vp;       /* WALKING &sndpd+0xd8 pointer (voice-table row base), +=0x2c per
                               * iter -- matches iSNDserve's established `vp = &DAT_801479f0 + vt`
                               * lever: keeps the 4 field accesses (0x1c/0x21/0x24/0x25) as load
                               * DISPLACEMENTS off ONE walking base instead of 4 separately-folded
                               * &DAT_80147a0x constant bases */
    unsigned char *vbase;
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
        if (chan < (int)(unsigned)gp[0x11]) {
            vp = (struct RestoreVoice *)base;
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

    *(volatile unsigned int *)&koff = 0;
    base = sndpd;
    do {
        do {
            kon = 0;
        } while (0);
    } while (0);
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
     *   FIX: move the increment INSIDE the condition -- `} while ((int)(unsigned)SUB(0x11) > ++chan);`
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
    if ((int)kon < (int)(unsigned int)SUB(0x11)) {
        fpbase = base;
        vt = chan;
        do {
            vp   = D_801479F0 + vt;
            vreg = (unsigned short *)(*(int *)(fpbase + 0x510) + chan * 0x10);
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
                                vbase = D_801479F0;
                                do { vbase++; vbase--; } while (0);
                                c = (int)((unsigned int)*(volatile unsigned char *)(vp + 0x20) << 24) >> 24;
                                vp = D_801479F0 +
                                     ((int)((unsigned int)*(volatile unsigned char *)(vp + 0x20) << 24) >> 24) * 0x2c;
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
                            *(volatile unsigned char *)(vp + 0x1d) = 0;
                            *(volatile unsigned char *)(vp + 0x1c) = 0;
                            iSNDfreechan(c);
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510) + 6) = 0x200;
                            onec = 1;
                            kon = kon | (onec << c);
                            onec = 0;
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510)) = 0;
                            *(unsigned short *)(c * 0x10 + *(int *)(fpbase + 0x510) + 2) = 0;
                        /* Keep the decrement in the latch; the volatile state stores above make it
                         * the retail jal-delay-slot candidate without changing the loop semantics. */
                        } while (0 < --n);
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
                if (vreg[6] == 0) {
                    one = 1;
                    kon = kon | (one << chan);              /* (Ghidra `mask`) */
                    vp[0x1d] = 0;
                    vreg[3] = 0x200;
                    vreg[0] = 0;
                    vreg[1] = 0;
                } else {
                    one = 1;
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
            vt += 0x2c;
            /* MATCH (w47-a3): the counter increment lives INSIDE the condition, evaluated AFTER the
             * bound load, so the loop-latch block STARTS with `lui %hi(sndgs+17)`.  A duplicable
             * `lui` at the join is what lets gcc's reorg EAGER-STEAL it into the three forward
             * guard branches' delay slots (retail has `lui v0,0` in all three; a leading
             * `addiu chan,chan,1` can never be stolen -- it would increment twice -- so we got
             * `nop`s).  Operand order `bound > ++chan` (not `++chan < bound`) puts the load first
             * (catalog: compare-operand order IS evaluation/load order) and still emits
             * `slt chan,bound`. */
        } while ((int)(unsigned int)SUB(0x11) > ++chan);
    }
    if (koff != 0)
        iSNDpsxkeyoff((int)koff);
    do {
        if (kon != 0)
            iSNDpsxkeyon((int)kon);
    } while (0);
}
