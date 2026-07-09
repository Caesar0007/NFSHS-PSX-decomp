/* syslib/psx/libcd/stcdint.c -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libcd.lib(C_011.OBJ): StCdInterrupt -- the CD-streaming sector interrupt handler.
 *
 *   Installed as the libcd ready callback by a streaming read (cdread2.cpp).  On each sector
 *   "data ready" interrupt it: gates on the MDECout DMA in RGB24 mode, reads the CD result and the
 *   sector sub-header (submode magic 0x160 / channel / sector# / #sectors / frame#), applies the
 *   start-frame / channel / sync filters, advances the ring write index (wrapping or clamping at the
 *   ring end), and programs CD DMA channel 3 -- or, for an emulated stream, a plain word copy -- to
 *   deposit the sector into the ring.  On a frame's last sector it sets StFinalSector and fires the
 *   user StFunc2; on the start frame it clears StSTART_FLAG.  Two file-static helpers: _st_copy_words
 *   (word memcpy @0x800F8794) and _st_dma (DMA-channel programmer @0x800F87C0).
 *
 *   Structure follows the matched libcd reference decomp (Sotn/psxsdk c_011.c -> dma_execute/mem2mem):
 *   the cached current ring slot lives in the GLOBAL _st_slot (re-read each use, NOT held in a saved
 *   register), and the CD result / sub-header are staged through a small on-stack scratch array so the
 *   sub-header word lands in the ring slot via an unaligned copy.  Hardware is reached through a .data
 *   table of CD/DMA register pointers @0x80136A98 (materialised below from the EXE).  All St* state
 *   lives in stream.cpp; _st_slot (cached current ring slot) and debug_cause are owned here. */

typedef unsigned char  u_char;
typedef unsigned short u_short;

/* ---- CD/DMA hardware-register pointer table (.data @0x80136A98, materialised from NFS4.EXE) ----
 * Each entry is a 4-byte initialised pointer; under -G4 it would land in .sdata -> gp-relative, but
 * the oracle reaches the table ABSOLUTELY (lui %hi; lw %lo).  Pin to .data so the addressing matches. */
#define ST_DATA __attribute__((section(".data")))
static volatile u_char *_cd_idx      ST_DATA = (volatile u_char *)0x1F801800; /* @0x80136A98 CDREG0/index */
static volatile u_char *_cd_reg3     ST_DATA = (volatile u_char *)0x1F801803; /* @0x80136AA4 CDREG3       */
static volatile u_char *_cd_reg2     ST_DATA = (volatile u_char *)0x1F801802; /* @0x80136AA0 CDREG2 (data)*/
static volatile int    *_cdrom_delay ST_DATA = (volatile int   *)0x1F801018;  /* @0x80136AA8 CDROM_DELAY  */
static volatile int    *_com_delay   ST_DATA = (volatile int   *)0x1F801020;  /* @0x80136AAC COM_DELAY    */
static volatile int    *_dpcr        ST_DATA = (volatile int   *)0x1F8010F0;  /* @0x80136AB0 DPCR         */
static volatile u_char *_dicr        ST_DATA = (volatile u_char *)0x1F8010F4;  /* @0x80136AB4 DICR         */
static volatile int    *_d1_chcr     ST_DATA = (volatile int   *)0x1F801098;  /* @0x80136AB8 MDECout CHCR */
static volatile int    *_d3_chcr     ST_DATA = (volatile int   *)0x1F8010B8;  /* @0x80136AC8 CD CHCR      */

/* ---- C_011-owned globals ---------------------------------------------------------------------- */
/* Regular .bss / .data, reached absolutely in the oracle -- pin to .bss so they stay out of
 * .sdata/.sbss (which would make them gp-relative and mismatch the ROM).  _st_slot is the cached
 * current ring slot pointer (StRingAddr + StRingIdx1*0x20); the oracle re-loads it from memory on
 * every use, so it is a global, not a register-cached local. */
#define ST_BSS __attribute__((section(".bss")))

u_short *_st_slot ST_BSS;   /* @0x80144864 : cached current ring slot                 */
int      debug_cause ST_BSS;   /* @0x80136AE0 : last interrupt stage/abort code (debug) */


/* ---- streaming state (stream.cpp) ------------------------------------------------------------- */
extern int StFinalSector, StRgb24, StEmu_Addr, StEmu_Idx, StSTART_FLAG, StStartFrame;
extern int CChannel, Stframe_no, StRingIdx1, StRingIdx2, StRingAddr, StRingSize, StRingBase;
extern int StEndFrame, StCHANNEL, StFunc2, StMode, StCdIntrFlag;
extern short Stsector_offset;

/* ---- peer libcd objects ----------------------------------------------------------------------- */
extern int  CdReady(int mode, u_char *result);          /* @0x800F786C (DRV) */
extern void init_ring_status(int base, unsigned count); /* C_008 @0x80108758 */
extern int  data_ready_callback(void);                  /* C_004 @0x80108798 */
extern int  printf(const char *, ...);                  /* libc C63 @0x801028AC */

/* @0x800F8794 : copy `num` 32-bit words src -> dst.  (4th arg present in the original signature
 *   but unused -- callers pass a trailing 0 / 1; reproduced so the call-site stack layout matches.) */
extern void _st_copy_words(int *dst, int *src, unsigned num, int arg3)
{
    unsigned i;
    (void)arg3;
    for (i = 0; i < num; i++)
        *dst++ = *src++;
}

/* @0x800F87C0 : program DMA channel `ch` (madr, blocks x blocksize, chcr); waits for the channel
 *   idle first and gates the kick on CDREG0 bit 0x40.  `enable_irq` toggles the channel DICR bit.
 *   (7th arg present in the original signature but unused; reproduced for the call-site layout.) */
extern void _st_dma(int ch, int madr, int blocks, int blocksize, int chcr, int enable_irq, int arg6)
{
    volatile int *chcr_reg = (volatile int *)(0x1F801088 + ch * 0x10);
    volatile int *base     = (volatile int *)(0x1F801080 + ch * 0x10);
    int counter = 0;
    (void)arg6;

    while (*chcr_reg & 0x1000000) {                 /* wait for the channel to go idle */
        if (counter == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\n", *chcr_reg);
            break;
        }
        counter++;
    }

    if (enable_irq == 1) _dicr[2] |= (u_char)(1 << ch);
    else                 _dicr[2] &= (u_char)~(1 << ch);

    *_dpcr |= (1 << (ch * 4 + 3));                  /* enable the channel in DPCR */
    base[0] = madr;                                 /* MADR */
    base[1] = (blocks << 16) | blocksize;           /* BCR  */
    while ((*_cd_idx & 0x40) == 0)                  /* wait until the CD is ready to DMA */
        ;
    base[2] = chcr;                                 /* CHCR -- kick the transfer */
}

/* @0x800F7E78 : the CD-streaming sector interrupt handler. */
extern void StCdInterrupt(void)
{
    volatile short hdr[4];   /* status/sub-header scratch (sp+0x20); stages result[0..1] at [1]/[2] */
    int     loc[2];          /* CdlLOC sub-header staging (sp+0x28) -> copied into the ring slot     */
    u_char  result[8];       /* CdReady result buffer (sp+0x30)                                      */
    u_char *p;
    int     t0;
    unsigned i;

    if (StFinalSector == 1)
        return;

    /* RGB24: never disturb an in-flight MDECout DMA -- retry next interrupt. */
    if (StRgb24 != 0 && (*_d1_chcr & 0x1000000)) {
        StCdIntrFlag = 1;
        if (StEmu_Addr != 0)
            StEmu_Idx++;
        debug_cause = 1;
        return;
    }

    if (CdReady(1, result) == 5)                    /* CdlDiskError */
        return;
    hdr[1] = result[0];
    hdr[2] = result[1];
    if (hdr[1] & 4) {                               /* error flag in status */
        debug_cause = 3;
        return;
    }

    _st_slot = (u_short *)(StRingAddr + (StRingIdx1 << 5));
    if (_st_slot[0] != 0) {                         /* target slot not yet consumed -> overflow */
        if (StEmu_Addr != 0)
            StEmu_Idx++;
        debug_cause = 4;
        return;
    }

    /* ---- pull the sector sub-header off the drive ------------------------------------------- */
    *_cd_idx  = 0;
    *_cd_reg3 = 0;
    *_cd_idx  = 0;
    *_cd_reg3 = 0x80;
    *_cdrom_delay = 0x20943;
    *_com_delay   = 0x1323;
    if (StMode == 0) {
        p = (u_char *)&loc[0];                      /* &hdr[4] == loc -> 4 raw sub-header bytes */
        do { *p++ = *_cd_reg2; } while (p < (u_char *)&loc[0] + 4);
        for (i = 0; i < 8; i++) (void)*_cd_reg2;    /* drain */
    }

    /* ---- deposit the raw sector into the slot (emulated copy or CD DMA) ---------------------- */
    t0 = 0x11000000;
    if (StEmu_Addr != 0) {
        _st_copy_words((int *)_st_slot, (int *)(StEmu_Addr + (StEmu_Idx << 11)), 8, 0);
    } else {
        _st_dma(3, (int)_st_slot, 0, 8, t0, 0, 0);
    }
    while (*_d3_chcr & 0x1000000)
        ;
    *(int *)((char *)_st_slot + 0x1C) = loc[0];     /* stash the sub-header word into the slot */
    *_cdrom_delay = 0x20843;
    *_com_delay   = 0x1325;

    /* ---- start-frame gating ----------------------------------------------------------------- */
    if (StSTART_FLAG == 1 && StStartFrame != 0) {
        if (StStartFrame == _st_slot[4]) {
            StSTART_FLAG = 0;                       /* reached the requested start frame */
        } else {
            _st_slot[0] = 0;                        /* skip frames before it */
            if (StEmu_Addr != 0)
                StEmu_Idx++;
            return;
        }
    }

    /* ---- submode / channel filter ----------------------------------------------------------- */
    if (_st_slot[0] != 0x160 || ((_st_slot[1] >> 10) & 0x1F) != (u_short)CChannel) {
        if (StEmu_Addr != 0) StEmu_Idx = 0;
        debug_cause = 5;
        _st_slot[0] = 0;
        return;
    }

    /* ---- sector-offset / frame-number sync check -------------------------------------------- */
    if (Stsector_offset != (short)_st_slot[2] ||
        (Stframe_no != 0 && Stframe_no != _st_slot[4])) {
        Stframe_no      = 0;
        Stsector_offset = 0;
        init_ring_status(StRingIdx2, (unsigned)(StRingIdx1 - StRingIdx2));
        StRingIdx1      = StRingIdx2;
        _st_slot[0]     = 0;
        if (StEmu_Addr != 0) StEmu_Idx++;
        debug_cause = 6;
        return;
    }

    /* ---- first sector of a new frame: range-check + ring-space bookkeeping ------------------- */
    if (_st_slot[2] == 0) {
        Stsector_offset = 0;
        Stframe_no      = _st_slot[4] & 0xFFFF;

        if (StEndFrame != 0 && (unsigned)Stframe_no >= (unsigned)StEndFrame) {  /* past the end frame */
            Stframe_no      = 0;
            Stsector_offset = 0;
            init_ring_status(StRingIdx2, (unsigned)(StRingIdx1 - StRingIdx2));
            StRingIdx1      = StRingIdx2;
            _st_slot[0]     = 0;
            StSTART_FLAG    = 1;
            if (StFunc2 != 0) ((void (*)())StFunc2)();
            if (StEmu_Addr != 0) StEmu_Idx++;
            debug_cause = 7;
            return;
        }

        if ((unsigned)(StRingSize - StRingIdx1 - 1) < (unsigned)_st_slot[3]) {  /* frame won't fit */
            if (StEndFrame == 0) {                  /* endless stream -> wait/wrap */
                _st_slot[0]  = 1;
                StSTART_FLAG = 1;
                if (StFunc2 != 0) ((void (*)())StFunc2)();
                if (StEmu_Addr != 0) StEmu_Idx++;
                debug_cause = 8;
                return;
            }
            /* bounded stream: rewind to slot 0 if it is free, else stall */
            if (*(short *)StRingAddr != 0) {
                _st_slot[0] = 0;
                if (StEmu_Addr != 0) StEmu_Idx++;
                debug_cause = 9;
                return;
            }
            _st_slot[0] = 1;
            {
                int *src = (int *)_st_slot;
                int *dst = (int *)StRingAddr;
                StRingIdx1 = 0;
                for (i = 0; i < 8; i++) *dst++ = *src++;   /* copy header down to slot 0 */
                _st_slot = (u_short *)StRingAddr;
            }
        }
        StRingIdx2 = StRingIdx1;
    }

    /* ---- dispatch the sector body into the ring's frame area -------------------------------- */
    debug_cause = 0xA;
    Stsector_offset = (short)(Stsector_offset + 1);
    StRingBase = StRingAddr + (StRingSize << 5) + ((StRingIdx1 * 0x3F) << 5);

    if (StRgb24 != 0) {
        t0 = 0x11000000;
        *_cdrom_delay = 0x20943;
        *_com_delay   = 0x1323;
    } else {
        *_cdrom_delay = 0x21020843;
        t0 = 0x11400100;
    }

    if ((int)_st_slot[3] - 1 == (int)_st_slot[2]) {     /* last sector of the frame */
        StFinalSector = 1;
        if (StEmu_Addr != 0) {
            _st_copy_words((int *)StRingBase, (int *)(StEmu_Addr + (StEmu_Idx << 11) + 0x20), 0x1F8, 1);
            StEmu_Idx++;
        } else {
            _st_dma(3, StRingBase, 0, 0x1F8, t0, 1, 0);
        }
        Stsector_offset = 0;
        Stframe_no      = 0;
        CChannel        = StCHANNEL;
    } else {
        if (StEmu_Addr != 0) {
            _st_copy_words((int *)StRingBase, (int *)(StEmu_Addr + (StEmu_Idx << 11) + 0x20), 0x1F8, 0);
            StEmu_Idx++;
        } else {
            _st_dma(3, StRingBase, 0, 0x1F8, t0, 0, 0);
        }
    }

    *_com_delay = 0x1325;
    _st_slot[0] = 3;                                /* mark the slot "DMA in flight" */
    StRingIdx1++;
    if (StEmu_Addr != 0 && StFinalSector != 0)
        data_ready_callback();
}
