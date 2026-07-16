/* eaclib/psx/sndpsxz/slib.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 5/5 ***
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
extern unsigned char  sndpd;                /* voice/queue state base @0x80147918 */
extern unsigned char  snd_old_chan_mode;    /* last applied channel-mode byte     */
unsigned char snd_old_chan_mode;  /* def (owning TU; BSS) */
extern unsigned char  DAT_80147919;         /* pre-load guard           */
extern int            DAT_8014791c;         /* current fx mode          */
extern unsigned char  DAT_80136df0;         /* DMA scratch RAM (zeroed) */
unsigned char DAT_80136df0;                 /* def (owning TU; @0x80136df0 image-verified zero; head byte of the 0x10-byte DMA-clear source region) */
extern void          *snd_user_serve_hook;  /* @0x80148038              */

/* voice-table fields (0x2c stride) */
extern unsigned char  DAT_801479f0;         /* +0x00 voice base (int fields via &+off) */
extern unsigned char  DAT_80147a0c;         /* +0x1c playstate */
extern unsigned char  DAT_80147a0d;         /* +0x1d substate  */
extern unsigned char  DAT_80147a0f;         /* +0x1f channels  */
extern unsigned char  DAT_80147a10;         /* +0x20 link      */
extern unsigned char  DAT_80147a11;         /* +0x21 link flag */
extern unsigned char  DAT_80147a14;         /* +0x24 L cache   */
extern unsigned char  DAT_80147a15;         /* +0x25 R cache   */
extern unsigned char  DAT_80147a16;         /* +0x26 flag      */
extern unsigned char  DAT_80147a17;         /* +0x27 voice-done */

/* SPU/DMA register pointers latched by iSNDinit (consumed by sdma/spatkey) */
extern unsigned int  *DAT_80147e14, *DAT_80147e18, *DAT_80147e1c, *DAT_80147e20, *DAT_80147e24;
extern int            DAT_80147e28;         /* SPU voice reg base (address) */
extern int            DAT_80147e2c;         /* SPU control reg base (address) */

/* libspu hardware registers (memory-mapped) */
extern volatile unsigned int   DPCR;
extern volatile unsigned short SPUSTAT;
extern volatile short          SPU_MAIN_VOL_L, SPU_MAIN_VOL_R;
extern volatile short          SOUND_RAM_DATA_TRANSTER_CTRL;
extern volatile unsigned int   SPU_VOICE_CHN_FM_MODE, SPU_VOICE_CHN_NOISE_MODE;
extern volatile short          CD_VOL_L, CD_VOL_R, EXT_VOL_L, EXT_VOL_R;
extern volatile unsigned int   SPU_ADDR, SPU_DELAY, D4_MADR, D4_BCR, D4_CHCR, VOICE_00_LEFT_RIGHT;

/* dependencies */
extern unsigned int iSNDpsxkeyon(int mask);                   /* spatkey */
extern int          iSNDpsxkeyoff(int mask);                  /* spatkey */
extern unsigned int iSNDsetvol(int chan, int left, int right);/* spatkey */
extern unsigned int iSNDstartvoice(unsigned int chan);       /* spatkey */
extern int          iSNDfreechan(int chan);                  /* salloc  */
extern unsigned int iSNDpsxfxinit(int mode);                 /* sdfx    */
extern void         iSNDserver(void);                        /* sserver */
extern void         iSNDleaveaudio(void);                    /* sserver */
extern int          iSNDdmqueue(int ram, unsigned int spu, int len, unsigned char prio, unsigned char flag); /* sdma */
extern void         DMACallback(void);                       /* syslib INTR  */
extern int          addtimer(int callback);                  /* addtimer */
extern int          deltimer(int callback);                  /* addtimer */
extern int          addexit(int handler);                    /* exit     */
extern void         SNDSYS_service(void);                    /* ssysserv */
extern void         SNDSYS_restore(void);                    /* ssysinit (exit handler) */

extern void iSNDplatformoutputcaps(void);   /* @0x800FF5A8 */
extern void iSNDplatformoutputset(void);    /* @0x800FF600 */
extern void iSNDinit(void);                 /* @0x800FF700 */
extern void iSNDrestore(void);              /* @0x800FF9A0 */
extern void iSNDserve(void);                /* @0x800FFAF4 */

#define SCB(i) (((char *)sndgs)[i])
#define SUB(i) (((unsigned char *)sndgs)[i])
#define SSH(i) (((short *)sndgs)[i])

/* cop0 Status read/write (interrupts masked around the hardware-register pokes; host: plain). */
#if defined(__mips__)
static inline unsigned int rd_sr(void) { unsigned int s; __asm__ volatile("mfc0 %0,$12" : "=r"(s)); return s; }
static inline void wr_sr(unsigned int s) { __asm__ volatile("mtc0 %0,$12" : : "r"(s)); }
#else
static unsigned int g_sr = 0;
static inline unsigned int rd_sr(void) { return g_sr; }
static inline void wr_sr(unsigned int s) { g_sr = s; }
#endif

/* iSNDplatformoutputcaps @0x800FF5A8 : publish this platform's output capabilities into sndgs (44.1 kHz,
 *   24 SPU voices, stereo). */
extern void iSNDplatformoutputcaps(void)
{
    SCB(7) = 0;  SCB(8) = 0;  SCB(9) = 0;  SCB(6) = 0x18;
    SSH(0) = (short)0xac44;  SCB(4) = 1;  SSH(1) = (short)0xac44;  SCB(5) = 2;
    SCB(0x13) = 0;  SCB(0x14) = 0;  SCB(0x12) = 0;  SCB(0x11) = 0x18;
    SSH(7) = (short)0xac44;  SCB(0x10) = 2;
}

/* iSNDplatformoutputset @0x800FF600 : apply the requested output channel count (clamped to caps), and if the
 *   mode changed while audio is up, re-push every playing voice's L/R volume. */
extern void iSNDplatformoutputset(void)
{
    int chan;
    SCB(0x11) = 0x18;
    if (SUB(0x10) < SUB(4))   SCB(0x10) = SCB(4);
    if (SUB(5) < SUB(0x10))   SCB(0x10) = SCB(5);
    if (SCB(0xf) != 0 && snd_old_chan_mode != SUB(0x10)) {
        chan = 0;
        do {
            int vt = chan * 0x2c;
            if ((&DAT_80147a0c)[vt] == 2 && (&DAT_80147a11)[vt] == 0)
                iSNDsetvol(chan, (int)(signed char)(&DAT_80147a14)[vt], (int)(signed char)(&DAT_80147a15)[vt]);
            chan++;
        } while (chan < (int)(unsigned)SUB(0x11));
    }
    snd_old_chan_mode = SUB(0x10);
}

/* iSNDinit @0x800FF700 : bring up the SPU -- enable DMA4, zero the SPU voice/main/CD/ext volumes, latch the
 *   DMA + SPU register addresses, key-off all voices, set master volume, apply the fx preset, and install
 *   the audio timer + exit handler. */
extern void iSNDinit(void)
{
    unsigned int sr = rd_sr();
    int i;

    extern unsigned short snd_spu_engine_ver;   /* sdmemman */
    extern unsigned short snd_spu_block_total;
    snd_spu_engine_ver = 0x41;
    DPCR = DPCR | 0xb0000;
    SPU_MAIN_VOL_L = 0;
    SPU_MAIN_VOL_R = 0;
    snd_spu_block_total = 0x2000;
    DAT_80147e14 = (unsigned int *)&SPU_DELAY;
    DAT_80147e18 = (unsigned int *)&D4_MADR;
    DAT_80147e1c = (unsigned int *)&D4_BCR;
    DAT_80147e20 = (unsigned int *)&D4_CHCR;
    DAT_80147e24 = (unsigned int *)&DPCR;
    DAT_80147e28 = (int)&VOICE_00_LEFT_RIGHT;
    DAT_80147e2c = (int)&VOICE_00_LEFT_RIGHT;
    while ((SPUSTAT & 0x7ff) != 0) { }
    SOUND_RAM_DATA_TRANSTER_CTRL = 4;
    SPU_VOICE_CHN_FM_MODE = 0;
    SPU_VOICE_CHN_NOISE_MODE = 0;
    CD_VOL_L = 0;
    CD_VOL_R = 0;
    EXT_VOL_L = 0;
    wr_sr(rd_sr() & 0xfffffbfe);
    EXT_VOL_R = 0;
    *((unsigned short *)&SPU_ADDR + 1) = 0xc000;
    DMACallback();
    wr_sr(sr);
    iSNDdmqueue((int)&DAT_80136df0, 0x1000, 0x10, 1, 0);     /* clear first SPU page */

    i = 0;
    if (SUB(0x11) != 0) {
        do {
            int vr = DAT_80147e28 + i * 0x10;                /* zero SPU voice regs */
            *(short *)(vr + 0) = 0;
            *(short *)(vr + 2) = 0;
            *(short *)(vr + 4) = 0;
            *(short *)(vr + 6) = 0x200;
            *(short *)(vr + 0xe) = 0x200;
            *(short *)(vr + 8) = 0;
            *(short *)(vr + 0xa) = 0;
            (&sndpd)[i * 0x2c + 0xff] = 0xff;                /* mark voice done */
            i++;
        } while (i < (int)(unsigned)SUB(0x11));
    }
    iSNDpsxkeyon(0xffffff);
    *(short *)(DAT_80147e2c + 0x1a2) = (short)0xfffe;        /* reverb work-area base */
    *(short *)(DAT_80147e2c + 0x180) = 0x3fff;               /* SPU master vol L (Ghidra mis-decompiled +0x60) */
    *(short *)(DAT_80147e2c + 0x182) = 0x3fff;               /* SPU master vol R */
    *(unsigned short *)(DAT_80147e2c + 0x1aa) = *(unsigned short *)(DAT_80147e2c + 0x1aa) | 1;
    iSNDpsxfxinit(DAT_8014791c);
    DAT_80147919 = 0;
    addtimer((int)iSNDserver);
    if (sndpd == 0) {
        addexit((int)SNDSYS_restore);
        sndpd = 1;
    }
}

/* iSNDrestore @0x800FF9A0 : tear the SPU back down -- unwind the audio lock, let all voices fade past their
 *   release, drop the audio timer, clear the fx, and re-arm the DMA callback. */
extern void iSNDrestore(void)
{
    int          quiet;
    int          chan;
    unsigned int deadline;
    unsigned int sr;

    while (SCB(0x3f) != 0)
        iSNDleaveaudio();
    deadline = sndgs[0x11] + 100;
    SCB(0x3f) = 0;
    do {
        quiet = 1;
        chan = 0;
        if (SUB(0x11) != 0) {
            do {
                if ((&sndpd)[chan * 0x2c + 0xf5] != 0) {     /* voice still active */
                    quiet = 0;
                    if (deadline < (unsigned int)sndgs[0x11]) {
                        iSNDpsxkeyoff(0xffffff);
                        (&sndpd)[chan * 0x2c + 0xf5] = 0;
                        iSNDfreechan(chan);
                    }
                }
                chan++;
            } while (chan < (int)(unsigned)SUB(0x11));
        }
        SNDSYS_service();
    } while (!quiet);
    deltimer((int)iSNDserver);
    iSNDpsxfxinit(0);
    sr = rd_sr();
    wr_sr(rd_sr() & 0xfffffbfe);
    DMACallback();
    wr_sr(sr);
}

/* iSNDserve @0x800FFAF4 : the per-frame SPU voice driver -- run the user serve hook, advance every voice's
 *   play position, retire finished/stopping voices (free their channels, key them off), and key-on any
 *   newly-armed voices.  Batches the SPU key-on/key-off masks for a single hardware poke. */
extern void iSNDserve(void)
{
    unsigned int koff = 0;     /* local_30 : key-off mask deferred until DMA settles */
    unsigned int kon = 0;      /* mask     : key-on mask */
    int          chan, vt, i, n, lvt;
    unsigned char *vp;
    short        *vreg;

    if (snd_user_serve_hook != 0)
        (*(void (*)(void))snd_user_serve_hook)();

    chan = 0;
    if (SUB(0x11) != 0) {
        vt = 0;
        do {
            vp   = &DAT_801479f0 + vt;
            vreg = (short *)(DAT_80147e28 + chan * 0x10);
            if ((&DAT_80147a0d)[vt] == 2) {                          /* voice stopping */
                if (vreg[6] == 0) {                                  /* SPU ADSR reached 0 */
                    if ((&DAT_80147a16)[vt] != 0 && (&DAT_80147a11)[vt] == 0 &&
                        (int)((unsigned)(&DAT_80147a17)[vt] << 0x18) < 0) {
                        n = (int)(unsigned)(&DAT_80147a0f)[vt];
                        do {
                            int c = chan, cvt = vt;
                            if (n == 2) { c = (signed char)vp[0x20]; cvt = (char)vp[0x20] * 0x2c; }
                            vp = &DAT_801479f0 + cvt;
                            (&DAT_80147a0d)[cvt] = 0;
                            (&DAT_80147a0c)[cvt] = 0;
                            n--;
                            iSNDfreechan(c);
                            vreg = (short *)(c * 0x10 + DAT_80147e28);
                            vreg[3] = 0x200;                 /* ADSR -> 0, then key-on to force silence */
                            kon = kon | (1u << c);
                            vreg[0] = 0;
                            vreg[1] = 0;
                        } while (0 < n);
                    }
                } else {
                    (&DAT_80147a16)[vt] = 1;
                }
                if (vp[0x28] != 0) {                                 /* pitch dirty -> reprogram */
                    vreg = (short *)(DAT_80147e28 + chan * 0x10);
                    vreg[2] = (short)(*(unsigned int *)(vp + 8) / 0x1b9);
                    vp[0x28] = 0;
                }
                if (*(int *)(vp + 0x10) < 1) {                       /* advance play position */
                    *(int *)(vp + 0xc) = *(int *)(vp + 0xc) + *(int *)(vp + 8);
                    if (*(unsigned int *)(vp + 0x14) <= *(unsigned int *)(vp + 0xc)) {
                        if ((int)((unsigned)vp[0x27] << 0x18) < 0)
                            *(int *)(vp + 0xc) = *(int *)(vp + 0x14);
                        else
                            *(int *)(vp + 0xc) = *(int *)(vp + 0xc) - *(int *)(vp + 0x14);
                    }
                } else {
                    *(int *)(vp + 0x10) = *(int *)(vp + 0x10) - *(int *)(vp + 8);
                }
            } else if ((&DAT_80147a0d)[vt] == 3) {                   /* voice fully stopped */
                if (vreg[6] == 0) {
                    kon = kon | (1u << chan);               /* (Ghidra `mask`) */
                    (&DAT_80147a0d)[vt] = 0;
                    vreg[3] = 0x200;
                    vreg[0] = 0;
                    vreg[1] = 0;
                } else {
                    koff = koff | (1u << chan);             /* (Ghidra `local_30`) */
                }
            }
            vp = &DAT_801479f0 + vt;
            if (vp[0x1c] == 1 && vp[0x1d] == 0 &&
                ((unsigned char)vp[0x1f] < 2 || (&DAT_80147a0d)[(char)vp[0x20] * 0x2c] == 0)) {
                kon = kon | iSNDstartvoice(chan);                    /* arm newly-triggered voice */
            }
            chan++;
            vt += 0x2c;
        } while (chan < (int)(unsigned)SUB(0x11));
    }
    if (koff != 0)
        iSNDpsxkeyoff((int)koff);
    if (kon != 0)
        iSNDpsxkeyon((int)kon);
}

/* owning-TU def (extern-declared, never defined; link-harness) */
 volatile unsigned int VOICE_00_LEFT_RIGHT; 
