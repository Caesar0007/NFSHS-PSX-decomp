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
extern void data_ready_callback(void);                 /* C_004 @0x80108798 */
extern int  printf(const char *, ...);                  /* libc C63 @0x801028AC */

/* @0x800F8794 : copy `num` 32-bit words src -> dst.  (4th arg present in the original signature
 *   but unused -- callers pass a trailing 0 / 1; reproduced so the call-site stack layout matches.) */
extern void _st_copy_words(int *dst, int *src, unsigned num, int arg3)
{
    /* MATCH (w51-a4, cc1_272 lane): a counted `for (i = 0; i < num; i++)` makes gcc-2.7.2
     * reserve an 8-byte `vars` frame on every such loop (`.frame $sp,8` -> subu/addu $sp),
     * where the oracle is frameless.  Guard-then-goto is frameless and reproduces the
     * oracle byte-for-byte (`beqz num` with `i=0` in the slot; bottom `sltu`/`bnez` with
     * `addiu a0,a0,4` in ITS slot).  Lane-neutral: still PASSes on the 2.8 lane. */
    unsigned i = 0;
    (void)arg3;
    if (num == 0)
        return;
loop:
    *dst++ = *src++;
    i++;
    if (i < num)
        goto loop;
}

/* @0x800F87C0 : program DMA channel `ch` (madr, blocks x blocksize, chcr); waits for the channel
 *   idle first and gates the kick on CDREG0 bit 0x40.  `enable_irq` toggles the channel DICR bit.
 * MATCH (w51-a4): shape TRANSPLANTED from the byte-exact Rage Racer libcd decomp,
 * C:/Temp/rage-racer-decomp/src/main/PAL/lib/libcd/dma_start.c :: CD_dmastart.  What it recovered
 * that the earlier reconstruction was MISSING (ours 91 insns vs oracle 106):
 *   (a) TWO discarded `volatile` read-backs the original keeps (`sw $v0,0x10($sp)` twice in the
 *       oracle = one stack `dummy` slot): the DICR word re-read after the byte-mask store, and the
 *       CHCR read-back after the kick -- both are real PSX DMA write-posting flushes;
 *   (b) the DICR bit is read into a TEMP then stored (`bv = dptr[2]; dptr[2] = bv | (1<<ch);`)
 *       through a NON-volatile `u_char *`, not a `|=` on a volatile lvalue;
 *   (c) the 6th argument is a `u_char` (oracle `lbu $s1,0x44($sp)`), not an int;
 *   (d) the busy-wait is a plain rotated `while (busy) { if (i == 0x10000) {printf; break;} i++; }`.
 *   (7th arg present in the original signature but unused; reproduced for the call-site layout.) */
/* MATCH (w52-a2): 95 -> 25 diffs, frame 56 -> 48 (= retail).  Four levers, in the order they
 * landed -- each one gated individually:
 *  (1) `volatile int chcr` PARAM.  Retail reads the 5th (stack-passed) argument at its POINT
 *      OF USE (`lw $v0,0x40($sp)` right before the CHCR store).  Ours copied it into a 6th
 *      callee-saved register ($s5) in the prologue, which grew the frame by 8 and shifted
 *      EVERY incoming stack-arg displacement (arg6 read at 0x4C instead of 0x44).  Marking the
 *      parameter `volatile` keeps it in its incoming home and loads it once, at the store.
 *      95 -> 67, frame exact.
 *  (2) The two `__asm__ __volatile__("")` SCHEDULING BARRIERS -- transplanted verbatim from the
 *      byte-exact Rage Racer decomp's identical routine (C:/Temp/rage-racer-decomp/src/main/
 *      PAL/lib/libcd/dma_start.c, CD_dmastart: one after the DICR read-back, one after
 *      `bit = 1 << (dv+3)`).  Without them sched1 interleaves the DPCR/bit/p computation into
 *      the DICR read-back's two load-delay gaps; retail keeps that read-back SERIAL
 *      (`lui; lw; nop; lw; nop; sw`).  67 -> 65 and the whole DICR region became byte-exact.
 *  (3) READ-ONLY FENCE on `bv` after the if/else (allocno DEMOTE dial, W49 fence-direction
 *      law): lengthening bv's live range drops its priority so `dptr` wins the lower register
 *      -- retail has dptr=$v1 / bv=$a0, ours had them swapped.  65 -> 47.
 *  (4) IDENTITY FENCES (PROMOTE dial, +2 refs each) on `bit` (x2) and `dp` (x1): retail's
 *      fill order is bit($v1) > dp($a0) > p($a1) > dv($a2); ours was dv > p > bit > dp.  The
 *      `bit` pseudo has only 2 refs, so its allocno numerator floor_log2(refs)*refs - SIZE is
 *      NEGATIVE -- one fence was not enough, two were.  47 -> 39 -> 31 -> 25.
 * Rage Racer needed `register long bv asm("$4")` / `register long dv asm("$6")` for the same
 * two registers; the fences reach $a0 and $v1 pin-free.
 * RESIDUAL 25 = (a) `dv` colors $v0 where retail has $a2, and (b) ONE extra `li $v0,1` reorg
 * speculates into the busy-wait entry branch's delay slot.  NAMED ANGLE for (a) (numeric-scan
 * law): retail's $v0 is occupied across dv's whole window by the BCR value
 * (`sll $v0,$s3,16` scheduled UP into the DPCR load's delay gap), so $v0 is not free when dv
 * fills; ours computes BCR after dv dies.  FALSIFIED so far: hoisting BCR into a named local
 * before `dp = _dpcr` / before `dv = *dp` (sched1 sinks it straight back, 25), the same with a
 * read-only fence pinning it (25), read-only/identity/volatile fences on `p` (31, +2 insns),
 * read-only fences on dv at either def (25/33), a 3rd `bit` fence (25), and a void-tail fence
 * before the mode test for (b) (27).  Next dial: make the BCR value's live range genuinely
 * span dv (a second consumer), or an out-of-loop ref-step on dv. */
extern void _st_dma(int ch, int madr, int blocks, int blocksize, volatile int chcr,
                    u_char enable_irq, int arg6)
{
    volatile int  dummy;
    int           i;
    volatile int *p;
    u_char       *dptr;
    volatile int *dp;
    int           bv;
    int           mode;
    (void)arg6;

    mode = enable_irq;
    i = 0;
    while (*(volatile int *)(0x1F801088 + (ch << 4)) & 0x01000000) {
        if (i == 0x10000) {
            printf("StCdInterrupt: DMA ch busy %08x\n",
                   *(volatile int *)(0x1F801088 + (ch << 4)));
            break;
        }
        i++;
    }

    if (mode == 1) {
        dptr = (u_char *)_dicr;
        bv = dptr[2];
        dptr[2] = bv | (1 << ch);
    } else {
        dptr = (u_char *)_dicr;
        bv = dptr[2];
        dptr[2] = bv & ~(1 << ch);
    }

    __asm__("" : : "r"(bv));   /* MATCH: DEMOTE bv (read-only fence) so dptr wins $v1 */
    dummy = *(volatile int *)_dicr;
    __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier -- keep the DICR read-back serial */
    {
        int dv;
        int bit;

        dv  = ch * 4;
        bit = 1 << (dv + 3);
        __asm__ __volatile__("");  /* MATCH: Rage Racer CD_dmastart barrier */
        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: PROMOTE bit -> $v1 (2 refs => negative */
        __asm__("" : "=r"(bit) : "0"(bit));  /* MATCH: allocno numerator; needs TWO fences)   */
        p   = (volatile int *)(0x1F801080 + (ch << 4));
        dp  = _dpcr;
        __asm__("" : "=r"(dp) : "0"(dp));  /* MATCH: PROMOTE dp -> $a0 (p then takes $a1) */
        dv  = *dp;
        *dp = dv | bit;
        *p++ = madr;                                /* MADR */
        *p++ = (blocks << 16) | blocksize;          /* BCR  */
        while ((*_cd_idx & 0x40) == 0)              /* wait until the CD is ready to DMA */
            ;
        *p = chcr;                                  /* CHCR -- kick the transfer */
        dummy = *p;
    }
}

/* @0x800F7E78 : the CD-streaming sector interrupt handler.
 *
 * MATCH (w52-a2): 89 -> 81 diffs on the WIRED lane, and 89 -> 36 once the TU also carries
 * `no_strength_reduce` (see the RECOMMENDED-FLAG note below).  Three source levers, each
 * gated in BOTH configurations:
 *  (1) SUB-HEADER LOOP -> INDEX FORM.  Retail recomputes the element address every iteration
 *      (`addu $v1,$a1,$a0` off a loop-invariant `addiu $a1,$sp,40`) and tests the COUNTER
 *      against an immediate (`sltiu $v0,$a0,4`); our pointer-walk `do { *p++ = ...; } while
 *      (p < end);` tested against an end POINTER (`sltu $v0,$v1,$a0`).  Written as
 *      `for (i = 0; i < 4; i++) p[i] = *_cd_reg2;` the shape is right BUT gcc's
 *      strength-reduction converts it straight back -- the index form only takes effect
 *      together with `-fno-strength-reduce` (89 -> 52 combined; the flag ALONE is inert at
 *      89, and the source edit alone is diff-neutral, so BOTH halves are needed).
 *  (2) DROP the `(u_short)` cast on CChannel and the `(short)` cast on `_st_slot[2]`:
 *      retail reads CChannel as a full word (`lw`) and the slot half-word unsigned (`lhu`);
 *      the casts were emitting `lhu`/`lh` respectively.  52 -> 48 (85 unflagged).
 *  (3) DECLARATION ORDER of the header-relocate loop's two pointers: retail's FIRST-loaded
 *      global ($a1) is the DESTINATION (StRingAddr) and the second ($v1) the SOURCE
 *      (_st_slot); ours had them the other way round, swapping the whole loop.  48 -> 36
 *      (81 unflagged).
 * RESIDUAL 36 (flagged) = four named clusters:
 *   (A) 1-insn order at the sub-header loop's entry;
 *   (B) the `_st_slot[0x1C] = loc[0]` store: retail emits an UNALIGNED movstrsi block move
 *       (`lwl/lwr` + `swl/swr`, +3 insns of our 8-insn shortfall).  A `struct {char b[4];}`
 *       cast-assign DOES reproduce that exact sequence -- verified twice -- but the
 *       surrounding coloring then costs more than it gains (36 -> 43, 48 -> 59 in the
 *       earlier basin), because retail also materializes the following 0x20843 CDROM_DELAY
 *       constant into $a0 BEFORE the copy so the copy temp lands in $a1.  FALSIFIED for the
 *       constant: hoisting it into a named local before the copy.  NEXT DIAL: get the
 *       constant materialized first, then re-land the Pack4 aggregate;
 *   (C) the channel-mismatch tail: retail RE-READS `_st_slot` from its global into $v1 for
 *       the `_st_slot[0] = 0` store (plus a dead `lhu $v0,0($a0)` on the StEmu_Addr==0 edge)
 *       instead of reusing the cached $a0 -- the SELECTIVE-CACHING class;
 *   (D) one `andi $v0,0xFFFF` retail keeps on `Stframe_no = _st_slot[4] & 0xFFFF` that our
 *       cc1 folds away (the `lhu` already proves the range).
 *
 * RECOMMENDED PER-TU FLAG (orchestrator action, w52-a2): add `"no_strength_reduce": True`
 * beside this TU's existing `cc1_272` entry.  Whole-TU gate, measured both ways:
 *      _st_copy_words  PASS      -> PASS
 *      _st_dma         25 diffs  -> 25 diffs   (inert)
 *      StCdInterrupt   81 diffs  -> 36 diffs
 * i.e. -45 diffs, zero PASS regressions.  (`no_schedule_insns` / `no_schedule_insns2` /
 * `no_delayed_branch` / `no_split_addresses` were all probed on this TU and are worse or
 * inert -- see the w52-a2 report table.) */
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
        for (i = 0; i < 4; i++) p[i] = *_cd_reg2;   /* MATCH: INDEX form (oracle `addu v1,a1,a0`) */
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
    if (_st_slot[0] != 0x160 || ((_st_slot[1] >> 10) & 0x1F) != CChannel) {
        if (StEmu_Addr != 0) StEmu_Idx = 0;
        debug_cause = 5;
        _st_slot[0] = 0;
        return;
    }

    /* ---- sector-offset / frame-number sync check -------------------------------------------- */
    if (Stsector_offset != _st_slot[2] ||
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
                int *dst = (int *)StRingAddr;   /* MATCH: dst declared FIRST -- retail's first-
                                                 * loaded global ($a1) is the DESTINATION */
                int *src = (int *)_st_slot;
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
